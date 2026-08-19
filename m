Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11945C5DF88
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA713406DB;
	Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJ8xJjZhCnIc; Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129667;
	bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPgvRaNp3R5rOzWvV7vQiYqri44jRlBgfnw2GGqt249d/HYPqjTB7ZHepTbnYdrQK
	 iLgh3qEZL7I1QBSC++nwhNZOfrX3hVYCGR/qU+LaHMOS86pzgiS4+mR5b480qqNvq2
	 1TlPESBrxWSep3OrvUHNZUkyvQTSsHhMPHVjUUelaWJpeR0kAdylgK9ClNkCJDDRTD
	 XIOIZZgOUbGnplepG0P1ClYfCVXpUu+F34ZDqB2iRHAbsktElObJmsGMUs0H/7jsyH
	 mUsa4OVJ4SvtUD9rLbNQ+p6sKtk/bqbedB3YZ3ohY8E/TIqn0Od1DOHE9wxEO0y4y4
	 mduCcR/DEeA4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47ACF407AE;
	Wed, 19 Aug 2026 08:54:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65F8E230
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BD7780DE6
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_UP5Df2sIWe for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Y+VqAr3p
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A08FC80E0D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A77AC60A5B;
 Wed, 19 Aug 2026 08:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8491F000E9;
 Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129661;
 bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Y+VqAr3pf/qInl/eHUm4ubq6tamqiOcoEKWWtCyj1ecQD/2vVbPSR1QRDPqCajKo5
 YoCLtHvhUWb22XRqzm3dYJ//uyUhWZgDkdS6Mqrl3t1pin0HaeQv0UIOeGDd9S6ryb
 5Pyvlhuee30wozM+I0Birv6oNzH17KNMBXHIbnixgBEXy8MB8ikmAD4Yv5DWWAfxbc
 +RhRcIgigIzoRE8ZZ6wWlv7QbeOS9JRjFpktL8WdNP/Mnuv5jSfZoFZ57UXTE0NvFo
 SWwi9vaST1ysd9itD6zDx2PFEOVDeJZ3Ke1rg/V83x+HbbesSXsOi7O3xJSXZdGofV
 yfQ9o1XBV/BhQ==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:12 +0200
Subject: [PATCH v4 07/12] arm: u8500: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-7-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Have ARCH_U8500 imply the fixed regulator driver needed by level
shifters on the supported boards. The architecture already enables the
regulator core and Nomadik GPIO driver.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 62aa9e8cc565..2a01ac9b7675 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1276,6 +1276,7 @@ config ARCH_U8500
 	imply CLK
 	imply DM_PMIC
 	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER

-- 
2.55.0

