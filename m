Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E78FC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9AF835BF;
	Thu, 24 Jul 2025 13:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AlDWgdSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E840983693; Thu, 24 Jul 2025 13:19:44 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FF68313F
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29AFE449F5;
 Thu, 24 Jul 2025 11:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6FC4CEF6;
 Thu, 24 Jul 2025 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753355981;
 bh=2ea3A/w/mrjOuUsN00CGlLyWK0J/Rry0AoxFt8T4Rdg=;
 h=From:To:Cc:Subject:Date:From;
 b=AlDWgdSGBmGiZCVFhwofir79Xmy3U4EmObRF0el3Df/TBY/+GRk1UnzJBuqsiwGOG
 jwZST2GEt2NwcGqemVULBGmbYNktCl61EAoy4KDPTQ6vdNsQINVF5UBLGhh9kIHRdL
 YcAzBgH15XJNA/RoQio/NN0t6U3KxpSoavK8xzB3Sxdt9tP4ScimektMNPkAu/iT1E
 qnYPGA8i4FUU4LTEIJUjZb5HZCsuK3LJ2Z9N4DmpUWFoiwkD6oO9ODN+pbs0qcGJbI
 FzIJaAXptCrEBkKchjIo5pv+FCJQEpR8CFWv7YEbMwDFge/aE3M20nM8nXNb58fZ/b
 JI8laanl9XNwg==
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 dmitry.baryshkov@oss.qualcomm.com, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH v2] qcom_defconfig: Add VID/PID to represent fastboot device
Date: Thu, 24 Jul 2025 16:49:11 +0530
Message-ID: <20250724111911.67872-1-sumit.garg@kernel.org>
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

Changes in v2:
- Rebased to tip of master since v1 didn't apply cleanly there.

 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index b9ba7a677d9..4e24a43b888 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -140,6 +140,8 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
 CONFIG_USB_FUNCTION_MASS_STORAGE=y
 CONFIG_UFS=y
 CONFIG_QCOM_UFS=y
-- 
2.43.0

