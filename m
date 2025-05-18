Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE0CC3ABC9
	for <u-boot@archiver.kernel.org>; Sun, 18 May 2025 12:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 111B2803DF;
	Sun, 18 May 2025 14:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rC4j8l91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B76C80584; Sun, 18 May 2025 13:16:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE1680584
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B8895C48D3;
 Sun, 18 May 2025 11:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E879C4CEF1;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747567002;
 bh=NMpdSD2jVk41SeOKgFqHExj05WOwFgvJz/XWfmpIYxw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rC4j8l91QYCYnqGKNqT5sOGmaIrOUpz5ihM1gpDN3VU/T7ayQBMLK4Gq+yTcUXINB
 YMlZbWmbEjsMTKytBy66N0llYTEaDxqR+JwPehetC2nDg8nAYBzDc/Da2n1pPiNTVQ
 HDC35xqd3mflA+mmgXxzlzyu8tCOEYOQ5aOj70RkftL/i/fppCvZWlE9LeBLvMBxZU
 oCc2F+J7xTA9cZSwJo5SzpFGi8b8KYmx1+54WO2f+RYJR8zilaM0YHA5BztmlSrxdm
 Rdy1Xa3eIfbhYqKxTRVazvF9gKBFsXWNGXd9DvjPh9GWczIdRud3+P7/WhNx60zLcM
 5swijijtnMxQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4A353C54756;
 Sun, 18 May 2025 11:16:42 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Sun, 18 May 2025 19:16:19 +0800
Subject: [PATCH v3 2/3] mach-snapdragon: Enable workaround of ignoring
 androidboot addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-android-boot-v3-2-02c8768e131f@gmail.com>
References: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
In-Reply-To: <20250518-android-boot-v3-0-02c8768e131f@gmail.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747567000; l=697;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=V/nmnp/yBWPHuHu+12WLjQqWVlQARQn8Uo9PAXzdPD4=;
 b=fjn/bl6dHD5z+7X5pMPlY26oybhkCpJXruH9Z+mbmb3XDPN+urm1U0B/SjMBMvnne7Tjr5DJ6
 zO+JRyrLsWdCxaC0fq9kHt8YbhkWbUS531Dzm99C0+QQ7Y7hO/+LibW
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Sun, 18 May 2025 14:45:03 +0200
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
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: George Chan <gchan9527@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fedfdb21457..f6d903b4f1e 100644
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


