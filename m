Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A2C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 13:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E3487640;
	Mon, 11 Dec 2023 14:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Upi07QMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A454C8775C; Mon, 11 Dec 2023 14:46:28 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1FB87756
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6cea0ea6817so253981b3a.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 05:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702302385; x=1702907185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=17fbl17on8V4CXsXoXeaayv7ut9OJxB/ZaPgi9wJENE=;
 b=Upi07QMxOmcu7b5o3Wr+4UCPhzK94HHeRXHQGtOkkE6g5KG41ntVI/C4DU9PButNc9
 JJBupPrMbnOVHQOtdCap/5qbgaDvW+QiWw6cNgKsQIhd+imupW4L1yvs80IktsHNyxbI
 nYtELYaMcCVbMKSY8SsHphnliNC/ddPjus34cVAtWbC0LCVv1grIS4UBFfXlm0803B+J
 EolTu9+9M9m5AmIETBDM3mafoZcoDnXWI3Qx6glUpHqiQA6Z+Mkfygd1oReh98DJzkzI
 nfpcpm1F418TUTdzRowAM14yTeaAh9ncKooIzE03Ea7KRM3MWm1QGDZfqOBAZvvfMKrE
 BTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702302385; x=1702907185;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17fbl17on8V4CXsXoXeaayv7ut9OJxB/ZaPgi9wJENE=;
 b=MpxdqgjY06cMhe4W6laKOKWObdlLcrOw2BkB1/C9CZ0hRlkrJwl420+Vf/GAN1BeQg
 R+DTF3rzUBoep9J3+bDAS4R6dKBJpnRVMIBJcVV0zPExIkaKpzIPQB1SaLXOx7fIwiIN
 dP91JGqdCfVjIwPaXwAoSUuHvSRGIqg4Qu3e4U/pkp4RrVSZmGO9F/FRvGYkA1Wp7kKf
 mJp8DsojPJ82OpDwM/8Hs2hScGJDTVZXwdwemGoq4Rr9GA7CMBxUHetumwWJwREUdsYA
 TPnuigLQBxM5aARfRJMaj4lOgfeU6bcDRS8AEXP6BE7T7PSLiiPu8jEK049jLJxgeD5o
 d6zw==
X-Gm-Message-State: AOJu0YxeBn2r49kaLnILG+AM4O0uNH3qRmoVvmn0jwIU3WcTmMgiJ+SR
 ko9kga6FgM3BWu2ErGjW4MQ=
X-Google-Smtp-Source: AGHT+IHCPE7rw714RYr3j7ETlQz05ktjICs2dDW2KP0KCAATO33AJmOoGXUsgzyGMtwLfRJDZwbr3w==
X-Received: by 2002:a05:6a00:1143:b0:6ce:7b6f:8c82 with SMTP id
 b3-20020a056a00114300b006ce7b6f8c82mr9356975pfm.0.1702302384587; 
 Mon, 11 Dec 2023 05:46:24 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1d51:eaf7:9aaa:d7c])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a62d44a000000b006cde1cef719sm6454221pfl.152.2023.12.11.05.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 05:46:24 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: lpmeyer@ics.com, trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx: imx-hab: Select SPL_DRIVERS_MISC in the SPL case
Date: Mon, 11 Dec 2023 10:46:17 -0300
Message-Id: <20231211134617.457471-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Fabio Estevam <festevam@denx.de>

Selecting CONFIG_IMX_HAB=y on a SPL target, such as apalis_imx6_defconfig,
for example, leads to the following build error:

/usr/bin/arm-linux-gnueabihf-ld.bfd: arch/arm/mach-imx/hab.o: in function `imx_hab_is_enabled':
arch/arm/mach-imx/hab.c:879: undefined reference to `fuse_read'

fuse_read() comes from SPL_MXC_OCOTP, which depends on SPL_DRIVERS_MISC,
since commit 251a3053b1e6 ("misc: imx: remove DM dependency for ocotp
driver in SPL").

Select SPL_DRIVERS_MISC in the SPL case to fix this build issue.

Reported-by: Lisandro Pérez Meyer <lpmeyer@ics.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index abd48d42583a..c34bc25c0bfb 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -54,6 +54,7 @@ config IMX_HAB
 	bool "Support i.MX HAB features"
 	depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5 || ARCH_IMX8M || ARCH_MX7ULP
 	select FSL_CAAM if HAS_CAAM
+	select SPL_DRIVERS_MISC if SPL
 	imply CMD_DEKBLOB if HAS_CAAM
 	help
 	  This option enables the support for secure boot (HAB).
-- 
2.34.1

