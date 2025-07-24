Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26AEC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 10:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A7F836B2;
	Thu, 24 Jul 2025 12:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LCyn+Ae1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4ED836D5; Thu, 24 Jul 2025 12:52:24 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C030835BF
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 12:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DFD5A61164;
 Thu, 24 Jul 2025 10:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B72FC4CEED;
 Thu, 24 Jul 2025 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753354340;
 bh=mcT28HTJSRP1KRyA9OzZNcUqH4Mt4WOSVKkNwPo4W/k=;
 h=From:To:Cc:Subject:Date:From;
 b=LCyn+Ae1E0SQzu4lEGBnyWlhQFDy1731B9OPf7aNGntGmkta6wd1/zxPjhgnQsaAv
 yv063Q3kFq4DSzVlxUyy27IYjPSZKG/9hYrchRT42iIP31P3jlUdrhezQLsEqxeszT
 mEPSUW7YiejfW6RGqb31af+aruMAB5Ro5yhLBAqLkh3wjOLnR0w1+oXeq5f/pxw/JU
 gQtHT0YLfdMTYqXHCXrhBtdRQdbv3qgPWUkGRvU0VIePFs9GPQ1L+cZQcNkexD/cCU
 35n36Lkjmttw7a8YK3xeQkK6Uw2v27vO9vZ7w7XANfhKPRlpI1aEMipcG2zkoJTmVr
 U8OthCRkdzAtg==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] qcom_defconfig: Add VID/PID to represent fastboot device
Date: Thu, 24 Jul 2025 16:21:57 +0530
Message-ID: <20250724105157.54091-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Currently fastboot mode is enumerated as VID/PID: 0000:0000 which is
not appropriate. On Qcom platforms, fastboot mode is rather enumerated
as VID/PID: 18d1:d00d in ABL or from fastboot.efi app. So lets use the
same VID/PID pair in U-Boot to represent fastboot mode.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 925e39e6f3c..b7f60eb2465 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -142,6 +142,8 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_UFS=y
-- 
2.48.1

