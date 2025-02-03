Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2879C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDB580885;
	Mon,  3 Feb 2025 18:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W7aA1XnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30EE80725; Mon,  3 Feb 2025 18:44:30 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66998096D
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3eb7edfa42dso2572088b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604667; x=1739209467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7wkQdMhGDq+rvUwVp3XK9PjwxN7AZoxLHXby+1ZkLQ=;
 b=W7aA1XnLET+z88m4uHqSfQ4ak0Zc6m27Pq3MkCk2dw4nXSk7WnJgLILVfsc2TmDTWS
 1VVrJdvk1YDE+8x+4+dYDdi+yDOTo1ucBl/TkJffLn8RIBOlCuLIk80Suo/2c/iriW3D
 lMX1n1Iv7TcISycdPB9QV7hhHRKe4A8kw1yEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604667; x=1739209467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7wkQdMhGDq+rvUwVp3XK9PjwxN7AZoxLHXby+1ZkLQ=;
 b=R9vUwAC/sLtOkrbkjSahHNWDov819MbwtrLACL40XIk04eEkPuBhrjgsfKiYQqY4fX
 S4MByPvXtsQqoz8hxs7UDTL62sAPlAwjmGl+/HkYddkIhyARqsNyknccRUJyTZD/D76R
 T5O5CE8JdBTCBWtj8DkFbaoYYl6EzThaG+3uexoYZ5v04FSdT0HkiqIX2WkuGBApR90w
 UMAYk2+xOPu/39BcHlCzfOVtaPhtdeaqvXd8BYRwHmoqZAma4WKlaq8y+4T2hSucExbA
 zjeB4R7qDDPKEEN10yUhlkTglxckn1i0WSPokMVDFfcX4LGBu59Q3Egu9Hlz0zRqYuUM
 H/cw==
X-Gm-Message-State: AOJu0Yw8fux3jpOL0POEviIYfF7Hw1ve30sRJaBqAk0xAPR21DxydrNq
 yggs+l+OGeveVlqMB8KBt8rnKeuinAinQDklSv/73rXNUuk8a7NSDyDnK/u4Ov+t6rVUulKEjPE
 =
X-Gm-Gg: ASbGnct/yKyC1Pe4c9q9cKOxtgIDOJEfWrlmmhXFGIiPosSrc8FHxKjG8sSdhAF0pLv
 q9TiXCxK56Wp14UK208dwu/eWZ1HtuDKX/bX1ERH4pZLg03xYoP2mlfhz5ReU9/Ecn++Tt6pnci
 Hhz21SgpZBZ7PGNGtAl0UZbgtr71/yHYvyeE9m61fJXKbDfgYrmDUG2nFVIJmxMwScCHy34LbPR
 y7xS1e6/XwtF2SuRS8Obs4itVQLK5zSeDGm3Md995JxpLT1JvxN7A8eoJHZOQrI3iYAAzvqxyL7
 nU+Y/IwCH1gs1zzUgUyuZlW1LYLBtrdY4xTRlc4y6reOErSyzmeR
X-Google-Smtp-Source: AGHT+IGJxaw3EgC0a/p3LTSdea3Qpk2O5mx4ki6YyLNJVARfkm2mOQ++jk61/lPLfxZEnogUlm+6ZA==
X-Received: by 2002:a05:6808:228e:b0:3e6:5792:2fb1 with SMTP id
 5614622812f47-3f323a23307mr16293064b6e.10.1738604666971; 
 Mon, 03 Feb 2025 09:44:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/32] efi: arm: Provide startup and relocation code
Date: Mon,  3 Feb 2025 10:42:20 -0700
Message-ID: <20250203174245.1331464-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Build in the EFI-app startup code as well as the code to relocate U-Boot
to the loaded position, since this is under the control of the previous
firmware.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/lib/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index a41566c816d..a2b8ef96ff5 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -32,6 +32,8 @@ obj-y	+= relocate.o
 endif  # ARM64
 endif  # EFI_APP
 
+obj-$(CONFIG_EFI_APP) += $(EFI_CRT0) $(EFI_RELOC)
+
 obj-$(CONFIG_CPU_V7M) += cmd_boot.o
 obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o
 obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
-- 
2.43.0

