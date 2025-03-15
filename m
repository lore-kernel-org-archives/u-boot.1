Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144F8C35FF1
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 22:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEF5881BC0;
	Sat, 15 Mar 2025 23:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HxLbb0tS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA9C81760; Sat, 15 Mar 2025 23:18:40 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DF881CA8
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 23:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fd89d036so64423495ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742077117; x=1742681917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ci5acfFe9vV7BlFQ08B3zKnMivStnEQXmXHj1kSt+po=;
 b=HxLbb0tS9oWxtip0lpy9loNwzFsmJWwCnh9Fb4tVYgHDa36HitT++CEvpTDYQtc0ft
 F4JKzQxlK2GZNSS40SC/D1p7jdz6SGgcHzLfh+zxblD+nNOQQv139V9UYtzTHK9JWNUw
 BHYAjCndnZCdEllPHGpB88cVDVgv1vuPdDO+bZMLugshB83of6x6p7cU4SHUFSOK4Gum
 2vImG9I1RRlGL9cUGsY84/cdE1XqNEIw0V0TwymNWG+dCaFGae6+z8tZ4oA1HuWGcu5z
 7USlAhtXo+P9BZt3t4y1q6rQfYz6bNgt9bRBvnYXzYsYUjnlGje4IjqCSkJbDvV/+NIy
 CeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742077117; x=1742681917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ci5acfFe9vV7BlFQ08B3zKnMivStnEQXmXHj1kSt+po=;
 b=XI0cONs5JD0z3EpnpBtL+V6k+nQ6IHCxPqA9kMgKOwwbPtQSDuh1R1oUzgugltTLr1
 Ew/JG+neQBHBos+AmiIA/bcCdliP/LhBvTQvceVe3p+H4zxyP6SeMtlXSgJhVa942L2g
 HYspUiKLQ25v0qFitXfhGkJ68Ds6FEIr4v4QcLZFAcGXDix9KGo6pkf9rFm3VF90T54P
 lkt6djekXnvjwnh3Er2vkS2k7ky16YqdIhsfwRrMe/3EA2+jEdFyZe82PpvGS7gPLOL0
 Q2B4JqNDfH7KPWPkHMcq9gIwK1u9Q5gCUKuLmOj6iQKly5FHmrLKkLVBBsruEh/1VPsP
 lZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtezzN/OoCzGEisJpcnaG93YoPM6jBvNNPIrZpJL5R13nb2L5Xm1YWkDoFzzK83hAQHtKhyfE=@lists.denx.de
X-Gm-Message-State: AOJu0YzSmDMJC3EO/VIEjkrxlV8Gk7TgqThUcVLZEmSB01cBuDnub0uo
 t6bIRRHVuK1A7EDngnHK6F7fZ+ZPoMlLiW1P+5uZROYmJ/l7GtGt
X-Gm-Gg: ASbGncvY0ymB0qL4aeLBF9DRbpn4w87/qbVBEheIpeDFjflsU80T6UEnfU+4R42ci+V
 YmF31m3bDJ4hgreQ/1RBX1TcxZC+nlD48sDX5vGvT9XcLdoMZIhSs+3VhM2725x9KDFnMG7v2vC
 vP69wSYD0BKcjH/MM/mp/rjh6tRM2WIuV25VFR3gwwNrSuGNswxkpquvsTYrSu3skZpUp3Vtw05
 dfZ9M1RaIn790XCS4zPdalZ7n+HeNF1sM1N3HupCfv7jlqMh5bwtR6FNRoscZnjTWiOOpzx1j8n
 U9eP1y/scAxnt/gSDIDPizCJIs2wNQxZ4FkqcPwzanq5TXVhqnKsHoU=
X-Google-Smtp-Source: AGHT+IFrcIF84TWz1pgLh5TP9URGMHXKtmP9bAV+dBh85gG0xTbwStoWahFVU+Xpg27a1yVRppTPsA==
X-Received: by 2002:a05:6a21:7894:b0:1f5:619a:8f73 with SMTP id
 adf61e73a8af0-1f5c12c7973mr7839527637.26.1742077116831; 
 Sat, 15 Mar 2025 15:18:36 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:f31:f69b:ca22:e094])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711578a5csm4899380b3a.74.2025.03.15.15.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 15:18:36 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 14/15] spl: riscv: opensbi: Error on misaligned FDT
Date: Sat, 15 Mar 2025 15:18:12 -0700
Message-ID: <20250315221813.1265193-15-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
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
access the serial console, it can only silently hang. This proved very
difficult to diagnose without proper debugging facilities. Therefore,
give the U-Boot SPL, which *can* print error messages, an additional
check for proper FDT alignment. Hopefully this saves a lot of
development cycles if another developer encounters alignment problems.

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
2.48.1

