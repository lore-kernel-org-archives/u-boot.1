Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA9FFA1FC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 15:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C32842E6;
	Wed, 22 Apr 2026 17:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="Oy9qLHBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6649F8431C; Wed, 22 Apr 2026 17:39:31 +0200 (CEST)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1DF842FC
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 17:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776872368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eorrzyy9BK13S5Pam9Bg5mFPoJsYn/bMPfbU4fT/ZzE=;
 b=Oy9qLHBSzVIz0geSD0naRXwH+yjaAYYa35n8l265apCquWnVdfwenmCsS/VRP/N0dDbxAa
 mrG+Q5G/I/89bWX8UJJ0OsSPhh6/7zFlvVcTgTuBUt/q3cs5FWEelV+7pIBf6AFizpme3Y
 mkzNnXpvWOvB0TZoODNPW829L4iy5OVNyPyke4e+U1lW7PgR25nzuYXvc6FM+aP3FyNPFs
 TAmiZXukfL5uMBaByrEB1oa7HEmEiQ0bzvEGlNObxklxS3EEZQGpKpCQp+swq10BZTCF3/
 9NQJEzKq3kttAb8s/175X5eS7uRnkGnLYGTEP0ySG9IPam9+AysBw/xVMwGe7w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 22 Apr 2026 15:39:05 +0000
Subject: [PATCH v2 2/4] arm: meson: enable SYSRESET_PSCI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-b4-amlogic-sysreset-capsules-v2-2-e04e4c9e69f9@postmarketos.org>
References: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v2-0-e04e4c9e69f9@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=997;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=g5YWUMtB5XwtBVRq1DeGDQ/bK7z/GRAg8nbP1JG+Un4=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp6Our5yPLYYcfUF57F4f7M14ND/ldNCo0p/cHX
 J7Kc+N2QYCJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaejrqwAKCRCEr8vQ14ma
 A6cSD/9wA7D0L3WdXvqZuz08FptrSGXz7LNNL9iwcI5ByHBWSOm0mnJGlCA30MSBaOajpKEaxDT
 hrsjNGDQdwjLpRHCYjx1mM6v/fKQHUv+8NzVQGguD+QqM2tdhwOdBSxATWJp/hT9iKQ9gC14f6U
 UoosYqQnQmRGX1P6ufuHM/TnqRC6cXUL4owHS1wGeQrW70abZGsFN65cdUodEGM1ApVz5ESx49C
 vyVZEs0R48Q81S0nEVLUF8nJ4i5Z0+5di/rXgSRPsToOB5dCcxH3k80nSVj6neLFCut6v+4ceMh
 H8FnICR+0KyPkOAvXRWstx9oaBpIhrqe5GnIhYqX4ksDlDVp21Z2xURz+CjwwhNVtTfEBtnHAyi
 kAHBHVArLBsu4bIppVO+7Zw1sjC/JGL1+bTc09pkOzC/vD8qCWxqAvFEQhJQLInhHWbpcdTeUHL
 NGBCQtv4oM6PpOLqXMSyK7G5INAqkRPUBhOfYjSBh7CmOSdPRMQaz8TUEGo5T7/chzVPETKsVrf
 drMPrvuQW/MkvTHqUNqOfEeER1QlSnqdVrUmRVmTvkBCOvHqkI6z4D5obeKrIYBY4J837f1XYIW
 yq7wv9by71ZTaHhq8b9tinOF65ZjLc7K0qtBj0aO9TGDBGOofDzCH+19KtDGIzeQah8PoBhfcyd
 awuG5rft0lLQyfA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Previously, Amlogic SoCs defined their own reset_cpu() implementation
that essentially just did what the sysreset PSCI driver already
supports. To reduce duplication (and allow for EFI Capsule on Disk
support), make use of it instead of a board-specific reset_cpu.

This does not affect SPL, as in that stage we do not actually have PSCI
(BL31 is not loaded yet at that point). Also, boards that don't select
PSCI support in their config will not have it enabled.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 arch/arm/mach-meson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index ef86129b535..c687ef822a2 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -12,6 +12,8 @@ config MESON64_COMMON
 	select MMC_PWRSEQ
 	select BOARD_LATE_INIT
 	select MESON_SM
+	imply SYSRESET
+	imply SYSRESET_PSCI
 	imply CMD_DM
 
 config MESON_GX

-- 
2.53.0

