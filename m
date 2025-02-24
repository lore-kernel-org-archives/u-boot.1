Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7237EC021B5
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 05:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 868E480F70;
	Mon, 24 Feb 2025 06:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSq5n8fr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1739C80F67; Mon, 24 Feb 2025 06:56:14 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C5E80F92
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 06:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221206dbd7eso77607345ad.2
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 21:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740376569; x=1740981369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziWOwdVtCShgpaTi6ZCy2diHX+UtGN/4BcuUzsXzatU=;
 b=XSq5n8frSkrjG6Fw+S8F9cqMLFOIvVuVTvbKm9Q9rerlmA3zTuJuxBV+cR8AMvCPwI
 Gt/BQmyViOPgLRbk9m5o4iea7NnittDeh6Wqnm+EVMU+M6l1slsdrRfreIHYageYCETE
 QbWy7xqDcW7c9GEkxih+ZCJsrukNwTXtX1zysuxEBIp2YqeKn0eay+nH5Sjant79Dd4n
 CRHg9b/xLQNvsG6732Dj4GQNzZTtRT1BXCFVBoVKqw14QsiACs1rZVH16M9qlGR9goZy
 i9DWk1bfsUGZEzS0yI+rJMA7a2u9w3etMflAq/ySUInU7wyBu6ty4VeE7LoJLDO+Tr9B
 SUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740376569; x=1740981369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ziWOwdVtCShgpaTi6ZCy2diHX+UtGN/4BcuUzsXzatU=;
 b=ozpfX/q4Cj+UFSeO7e0CHlNhJ/elMaZSonn1aXI1hE63ZhcuTD9YDK4NJpXQv7IayA
 RmSOKPgqzsk6Yi4l052mMoTxFQLjLBOwfuiucgGPYOqlOeDCdtoGCimCZotJmV4+5LTH
 Gz3LQzIbDcZgfS9qpSduj7Gjt4LctB7lkxZsvsaRaRfH+VdcrpcDcFLPtwTE/w5l+0kS
 kRgWSVL4XnO3Hv7/P7gJI2Toxq384Ls8jeuD+XQ54qpCLAudG5hmHN03PxbGeXkmqPXp
 G05HJhp/0bPRUJAAAGqkou7QypvCrizkLPE21CE/UStYG57M6XV8yiodDXrW/7Z2GyAJ
 A+jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXAW13uCkyRs13IG3YqxvdhwSjHo3d3N+T2aFuXjMcov2ad274xzJ5ediSQ9leSXfabxaI44U=@lists.denx.de
X-Gm-Message-State: AOJu0YxLawEgOKc5AkdmM/wWtBjy/nT9Ey96CS0spNkwogKsIagEb1ak
 gfN/VNdku7+KBWoa1z1Ee3QOyH2eYTkfWK+W2rWECyLUwnDlUudIDuFzSkPbAM4=
X-Gm-Gg: ASbGncuOQxL/w/YziNP3KDO3lt1SNPm0Q6oVbZvdl6ccZf2MSWVSH0ozv1Nw87XckNQ
 u2NhfZJ2qMAXQlvt9M30rPCatjXXHsYkerT8IB79yWsCwxRGMk4knaQRFApPW/m4Okjju4NHYTC
 zBC9lzft9MM1srBQ3IUI7w11kGTLf4XqvJDsqqCeaodHzN4SpdOhRc3kWsyt0ztnc3tSqY7KkPj
 dA67FO7dnPExYFRiQeleUhmUphOPMsyNoMA3y9CFXX0VWWcq4bN/wK82Kljw6KJkyhbtVO1S6ZF
 AWN4fwSzaM/YI20XY9qJDoTU5e01A9yRBy8LIg==
X-Google-Smtp-Source: AGHT+IHh1RbR2AX5/Hheq6KStqThEIhgdAfI2KavRO4MsSBdAJhDWk2b2gv98w/Oh6z9aoXDWv4zMw==
X-Received: by 2002:a05:6a00:464e:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-73426c8a3b2mr18966040b3a.3.1740376569528; 
 Sun, 23 Feb 2025 21:56:09 -0800 (PST)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:26ad:d46b:d078:4cca])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327e17440esm13511692b3a.76.2025.02.23.21.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 21:56:08 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 09/17] spl: riscv: opensbi: Error on misaligned FDT
Date: Sun, 23 Feb 2025 21:55:16 -0800
Message-ID: <20250224055524.1334929-10-CFSworks@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

libfdt 1.6.1+ requires the FDT to be 8-byte aligned and returns an error
if not. OpenSBI 1.0+ includes this version of libfdt and will also
reject misaligned FDTs.

However, OpenSBI cannot indicate the error to the user: since it cannot
access the serial console, it can only silently hang. This can be very
difficult to diagnose without proper debugging facilities. Therefore,
give the U-Boot SPL, which *can* print error messages, an additional
check for proper FDT alignment.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 common/spl/spl_opensbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index 5a26d7c31a4..0ed6afeacc6 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -57,6 +57,11 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 		hang();
 	}
 
+	if (!IS_ALIGNED((uintptr_t)spl_image->fdt_addr, 8)) {
+		pr_err("SPL image loaded an improperly-aligned device tree\n");
+		hang();
+	}
+
 	/*
 	 * Originally, u-boot-spl will place DTB directly after the kernel,
 	 * but the size of the kernel did not include the BSS section, which
-- 
2.45.2

