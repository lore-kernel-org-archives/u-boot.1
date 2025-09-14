Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADAFCA0EE8
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 14:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4336D83071;
	Sun, 14 Sep 2025 16:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="AmSPq4Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4954083322; Sun, 14 Sep 2025 16:56:52 +0200 (CEST)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B96E82AE1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 16:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexeymin@minlexx.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fWEu7eDT71YLeN+LjPEDLR16Jkeqd9JPGYtffjDAI90=; b=AmSPq4JqKPYhYFU7In3mL/Vwt1
 ytVG4Tb6A8iLoE1PznRkPf4QZusqYTjkFs1peA0jasLUSledbnBYaKMrw/uphZrHi+X+igXv0yQy6
 OSa7TvSqWnocee5yc1pzNhFo07WwK7WKey1XmBxCH1TkMHrz1mbbEVdRQEFSQ7I8PWgQ=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (envelope-from <alexeymin@minlexx.ru>) id 1uxo9o-000000006tV-0gm7;
 Sun, 14 Sep 2025 17:56:48 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Alexey Minnekhanov <alexeymin@minlexx.ru>
Subject: [PATCH] qcom_defconfig: Enable pinctrl driver for SDM630/660
Date: Sun, 14 Sep 2025 17:56:20 +0300
Message-ID: <20250914145620.1962735-1-alexeymin@minlexx.ru>
X-Mailer: git-send-email 2.49.1
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

Pin controller driver for SDM630/636/660 SoCs was added in
b4420a0c9ed ("drivers: pinctrl: Add Qualcomm SDM630/660 TLMM driver"),
but not enabled in qcom_defconfig. Correct that omission.

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 86d7de89e77..3acd57fb774 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -110,6 +110,7 @@ CONFIG_PINCTRL_QCOM_QCM2290=y
 CONFIG_PINCTRL_QCOM_QCS404=y
 CONFIG_PINCTRL_QCOM_SA8775P=y
 CONFIG_PINCTRL_QCOM_SC7280=y
+CONFIG_PINCTRL_QCOM_SDM660=y
 CONFIG_PINCTRL_QCOM_SDM845=y
 CONFIG_PINCTRL_QCOM_SM6115=y
 CONFIG_PINCTRL_QCOM_SM8150=y
-- 
2.49.1

