Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E2AC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3638272A;
	Mon,  5 May 2025 14:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pkdAKJRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFAFA8211F; Mon,  5 May 2025 11:17:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A89820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 11:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C8B914A819;
 Mon,  5 May 2025 09:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 474A4C4CEF4;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746436632;
 bh=82WyByoUEOoa/mgVNwTu/SoG3JgO5oskQqk+MqurXBU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=pkdAKJRp8W0aqjxSV8UA2sc0B/F74n57zE6UJAiFKseQDVXKKv3xPZIcsh4l+GVvG
 XFarE1podNSyYoyDEV+C9Wh3h8iNwjOKlR0SoDVOFF72q71Iaunzyie5zLh2qaBfIS
 Z1FtnfehwaXGsE2Ki5H4w3Qr+1e1TUFSxLukbY8wp7Os0Si5ZIrHas8LeoU+Bjlqr0
 mhvEYq57OLdksVg3dhTV2XEGFgJlFIv1EhY8doTwYsll6aIX+p8SWPPbatg7aSelJh
 MilwfSAKSFuupKpQFA5us/IwJoRZZWE5dzHZYZr9avC8Wqh//YjyKhn0m2NRyVgKK0
 vSBfbhxm8QOzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3E441C3ABBD;
 Mon,  5 May 2025 09:17:12 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 05 May 2025 17:17:13 +0800
Subject: [PATCH v2 5/5] mach-snapdragon: Enable workaround of ignoring
 androidboot addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-android-boot-v2-5-92dcb5bf59c8@gmail.com>
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
In-Reply-To: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436630; l=640;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=khgh6feuD1wxYZwtRfQW3mssUaZ3a8MPHiwC7OlndHU=;
 b=hZUzjlzexW6VblObDPHJD83/KQORJd66b46gLA0VWr3CzFhRYe4fwZk/zj3o5EILiziqAuOgz
 Zafk6yU1AlxC80VWgA7tYqcWu86gNl4HtfkeLoBQigmTlKomHLkX+By
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 05 May 2025 14:37:34 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

Enable the workaround for whole snapdragon family.

Suggested-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index df373d38a55..249bd4b5bf3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1124,6 +1124,7 @@ config ARCH_SNAPDRAGON
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
 	select SYSRESET_PSCI
+	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET

-- 
2.43.0


