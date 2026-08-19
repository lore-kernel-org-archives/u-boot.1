Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5B3C5DF8A
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15E6980E62;
	Wed, 19 Aug 2026 13:42:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5qQvS0fzAlM; Wed, 19 Aug 2026 13:42:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146931;
	bh=2SJgcBJEpD14DSgXDh/3kP4rR63gczWYipvmQntWKSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aHs7XUC1ECqU1B4JIZRqnyXbgQoLvHCktPPIVDfjc9Gs42tz83DEtFEu7WiVO8gfj
	 qA2XNYQWF5rtab829RpHN3/Y+Uj+6M1Kwx2OK/EgzBypvh9V8H1GFYZeRcDGAuBIvM
	 TJ6/znha/BStROa2+RaX5GyBG1q6aMaPyowPDLag1dAbdHDbGekkfyBYjNLDBV+GAE
	 fELEaBBGujwzDf+gTdZa4htVcXpYRLlXwuyqMEtFy/CdhHtvBVNIqo+nFn5oQmIoP/
	 9ocr6uN8srABAfJ24shPSWk2gC1+pvQltCpviCmQSUM0ozUZc7YH+NZY9kyvlyGxgR
	 EeRHMeNUarE/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65E7F80E0F;
	Wed, 19 Aug 2026 13:42:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 435AC3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2933240561
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5uqQqQiDqkCp for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 13:39:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CEKst2QK
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45CAB405E7
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 13:39:07 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so939405f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787146746; x=1787751546;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2SJgcBJEpD14DSgXDh/3kP4rR63gczWYipvmQntWKSU=;
 b=CEKst2QK/fVXUj0ndUkmWcJZwR/Kzl24n6EEJ8NLRcPvDD55HP/ncWxsPDXQGNf+4G
 8rmojpzn9q8kmMgm5GH/WegOLVAUhnugqYc1xqH/5XzwSOcdJUxAF4sdJUnfzzzHDZ7K
 58B2HdQDNu6OTIfeUUygNJT6c+UnB08xqe0zSApjDyFOHLCbUHgX7Su++qALXmmHdth9
 HqYibQxWMmca95ixuo0h4QCU2lx+TQV1taQ/rlpIZBkOPclmbcRLEpMSJyO4TKRlSmXB
 kPu1nmqY9bBWvYExYL3lgOxVrVRG5UYBiQlUDPYTAZE08exxaFc2+brdLjzlxjNhJ0cs
 kAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787146746; x=1787751546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2SJgcBJEpD14DSgXDh/3kP4rR63gczWYipvmQntWKSU=;
 b=YiURK9KxpbAbqS8j3yncGhrCe2zIMkJk/XsyGheJ7Hx+VQdnkU72YYQeWpIg5Qh5A0
 pJyZ57hQC1x2Im78q4YafK2FAfoIg+/sDPm5zCOI2DNx8RtiIqPbRnHIxXskKpcf4k9k
 Irz/hfhbqAtD0IbWBltj2tE/pDp/ZCKwIkizx3JY+7Md+n2UgVlfTGTf4WNKZ4DWOYWh
 NKWIZ7ohT+zLZ0K5DghX46/qwAm39F5jUHL1VCTD8OXdI9MGHBonAQ20Hol7hfNCa1GZ
 MHocqKjc98NRKg34pFe0KM4sAWkmHyH8TkhFrTVh5rT8JXBP2CFs8oBENfnD3wZuDRnC
 rzYw==
X-Gm-Message-State: AFuF++nWGG1PQH0jt7eAYTThs4fqVE3qVWPSrtx6phxIvzBEOvNwscUF
 W/nYX/otWxqkrd1I9vw0A0QhR3mcF/DGZtANVe2ldzTCLBjoxvQtO7jP
X-Gm-Gg: AR+sD10LykhLLSn95w6/6C+eigYUZL4awZxo598dKoZvWv3oE9WIWSAcYJ0AN1b9Kzo
 wnGEfpDMALTpDl2pxUgdiyi7rCUtq01fzoQzr8I3oOqqt16e3Tjx/DLivnvVpYGorWl/4Ls+ftv
 PNcyS1jiX2GBwi989w2tW+JUXgsbyfK57KLsNx2jEg/5hmLWjtRg2x8OzHtNeigtXNKke6zlejX
 ykH8hEHXD1ZSLDMh5sGdbau0OgrXQb1HGjrF2u4y4JzZdgrRQZ90q+JK19gbwZpg0MaCdG1JdDo
 ALsby13WC1U8yobrStHLfn1Ki52NPWhwRxHeGo4gar2Z0GOu/5no/yAVI9B42f5Xx2ep2OndVGW
 LyHf+dTiVRJqoFkehoxj2FVIbv1RZ9j9NyjOGy6GOjFlVBKNdbl6cbbs8eWsOhVyKEvzB2opujO
 Sx0MuNytAkM9trT5SbmPjAKn18BA4rfL2uXxDCX3ReUse/8VV0LyPb0A+nZSGPZACEzEDrgh2UR
 XKKcNRAjt7MOxQyA03u+dlPzzC+O7IqnlZHsD4jbMSW38qeOg==
X-Received: by 2002:a05:6000:385:b0:47f:c648:e274 with SMTP id
 ffacd0b85a97d-482b1e83838mr9486334f8f.5.1787146745928; 
 Wed, 19 Aug 2026 06:39:05 -0700 (PDT)
Received: from eichest-laptop
 (90.251.200.213.static.wline.lns.sme.cust.swisscom.ch. [213.200.251.90])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441753sm6463070f8f.5.2026.08.19.06.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:39:05 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com,
 ernest.vanhoecke@toradex.com, alice.guo@nxp.com, peng.fan@nxp.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/2] configs: {aquila, verdin,
 toradex-smarc}-imx95: remove CONFIG_SPI
Date: Wed, 19 Aug 2026 15:38:36 +0200
Message-ID: <20260819133900.167046-2-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819133900.167046-1-eichest@gmail.com>
References: <20260819133900.167046-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

CONFIG_SPI=y has been set on the Toradex i.MX95 boards since their
initial board support commits, but none of them selects an SPI
controller or slave driver. The option therefore only builds the SPI
uclass with no bus behind it, and SPI is not usable in U-Boot on these
boards.

Remove CONFIG_SPI from the aquila-imx95, toradex-smarc-imx95 and
verdin-imx95 defconfigs to reduce maintenance effort. No other symbol
selects SPI, so the resulting configuration ends up with
"# CONFIG_SPI is not set".

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 configs/aquila-imx95_defconfig        | 1 -
 configs/toradex-smarc-imx95_defconfig | 1 -
 configs/verdin-imx95_defconfig        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
index bb3d475ef4d..dcac9fdc615 100644
--- a/configs/aquila-imx95_defconfig
+++ b/configs/aquila-imx95_defconfig
@@ -160,7 +160,6 @@ CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9abadb0ed1a..cd8344572ad 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -162,7 +162,6 @@ CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index daf41a8b830..0d15a04635c 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -164,7 +164,6 @@ CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
 CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
-- 
2.55.0

