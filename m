Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F29FE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B65680288;
	Wed, 11 Dec 2024 13:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ElKZOAhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53948022E; Wed, 11 Dec 2024 13:20:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73608021C
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so119237066b.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919650; x=1734524450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi//0d0SBJoWjzNcceL2CFRWC+SrfOygOJuiHHZ9ddA=;
 b=ElKZOAhXaCt2kEsUmOYcwP1eDAYR1IDR40H/O3HQ3RDinUmbzjtoBxQ2xM2WVpKLaF
 mkdHSrqCUFGb25A7VQcp4fG1nkYQRk53GavoMyD9Og56UrPQc29hBxK/lzdCj8MavoIT
 O6zBgrw8A2NdVYlWqhA9R68IeOXc6prPQ9uXh0uR0AtnZTuYHIUlfenuzBPV1Qt7xbbI
 njIfIW/E1kSrTIvo0/HcHjCK1s//OOf8ntcr1WOhNXrzxSZZAJ1nNtrudRRHz4AO/Z1e
 ZCCoLvLimTF/mwlNnR4xVONuKg1KRHuw1n0SisMBUbZrUwbGBeDHu7n5Vwz4P9/wJwAP
 vPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919650; x=1734524450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zi//0d0SBJoWjzNcceL2CFRWC+SrfOygOJuiHHZ9ddA=;
 b=CJcbJY/6aBEqXZCDqEh6hXVAM/GvvpsfO/ipZ8c24SO23ImBAiPQOpOEp5BY/IAYgz
 G0JBwEEEN2LoVA7TOIXTta1zY/JimOM7i249/0YswCEESUrH6dJX8WdoehdjANBotQEa
 6mRHgEMWtFJpZurMyhDD9sN6xiUmKkVBav+Ql8bx9wDOthKbSvhiuVjzWyp0JELhiX3r
 uZfrA+QuSVHECzw0XdsugswzxpgnfMU7nigggRLr+MRx6FaPNCxWqH29sH+sQWNQs7eD
 vykpSwuol/R2v2OQLU1Du0qbv+RRFwjuQSY/aYFD2yq0b97XI1Al9iLGL1jrmGFlvMpC
 SsVg==
X-Gm-Message-State: AOJu0Yz541d+zzuUwdYRyYH4SZsIXRFQuc0K48pwKnS0KpERDjphl95p
 /9lonVf1AY0BSNByJRvgvTP9+n9X34bKYlel1T7gBQLtWsBOQWaW
X-Gm-Gg: ASbGncutqeCEUOStgKBfGQBH1GLNz8ADfUJ0kEey930N5oLJaEi3ykvq+/1HwSy+vnq
 qth/aiFwMZcwoOSSvLOW7RUXa/7ZiZfpE0qiQ8ak6As0zeTwYmafd8SvzeKL2SHnMaKbyYC/cLj
 H0mblxUmQ8sPC/Y9Oi85vnIFWZ4kn5b1PNSMgkUqTc1XfMwyJjBouY2bSEUtIbE7TbnLC23sCnS
 Bdajhvp1Ctkx1+WU2fGuHnZbCUrYnNouT9m+6ah4C98zCPwVRTYNBEVuorLNGhFOto6gugMqqqr
 QG/wry/eHPKSe/Vj9Ue4Q1vrbWDv
X-Google-Smtp-Source: AGHT+IF6YJM9vBf6tsSpY9cu3BgCVV8XMrberz2H2CwBnn/a21ooqpqpXeET+yv+I2RdUw8Ic/dDYg==
X-Received: by 2002:a17:906:cc1:b0:aa6:50ee:d44c with SMTP id
 a640c23a62f3a-aa6b15cc380mr243742766b.15.1733919650066; 
 Wed, 11 Dec 2024 04:20:50 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:49 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 4/5] toradex: apalis-imx8: simplify module version handling
Date: Wed, 11 Dec 2024 13:18:54 +0100
Message-ID: <20241211122036.103383-5-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Simplify module version handling by removing the special case for the
Apalis iMX8QM.

The Apalis iMX8QM has been treated as a special case in module version
handling, but was always the default. By removing this special handling,
the code is simplified and easier to maintain.

We will not print the message "Unknown Apalis iMX8 module" anymore.
However, we still handle this because if the config block is missing we
show "MISSING TORADEX CONFIG BLOCK" and if the serial number is unknown
we show "Model: Toradex 0000 UNKNOWN MODULE V1.1A". Therefore, it is
still possible to detect such issues.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index 1dc9483f022..a8c38208693 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -243,20 +243,12 @@ static enum pcb_rev_t get_pcb_revision(void)
 
 static void select_dt_from_module_version(void)
 {
-	env_set("soc", "imx8qm");
-	env_set("variant", "-v1.1");
+	if (get_pcb_revision() == PCB_VERSION_1_0)
+		env_set("variant", "");
+	else
+		env_set("variant", "-v1.1");
 
 	switch (tdx_hw_tag.prodid) {
-	/* Select Apalis iMX8QM device trees */
-	case APALIS_IMX8QM_IT:
-	case APALIS_IMX8QM_WIFI_BT_IT:
-	case APALIS_IMX8QM_8GB_WIFI_BT_IT:
-	case APALIS_IMX8QM_IT_1300MHZ:
-	case APALIS_IMX8QM_WIFI_BT_IT_1300MHZ:
-	case APALIS_IMX8QM_8GB_WIFI_BT_IT_1300MHZ:
-		if (get_pcb_revision() == PCB_VERSION_1_0)
-			env_set("variant", "");
-		break;
 	/* Select Apalis iMX8QP device trees */
 	case APALIS_IMX8QP_WIFI_BT:
 	case APALIS_IMX8QP:
@@ -265,8 +257,8 @@ static void select_dt_from_module_version(void)
 		env_set("soc", "imx8qp");
 		break;
 	default:
-		printf("Unknown Apalis iMX8 module\n");
-		return;
+		env_set("soc", "imx8qm");
+		break;
 	}
 }
 
-- 
2.45.2

