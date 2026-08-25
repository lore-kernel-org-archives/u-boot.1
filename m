Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F033C61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AD7E60767;
	Tue, 25 Aug 2026 19:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKnXvIebuvC2; Tue, 25 Aug 2026 19:04:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684664;
	bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFsIoU78hhg1AL2WQ/ro7zzArwoXF+rddpMVrI7686+kCC1BONSATCldcUhprGod5
	 BpTxYKXP0VrBRY6n6t9rlCxJunvOIkpPbgep+QeFmpY+SYrpJ/HEQcLUTvDh3CsWuZ
	 rZ4s/AZkpeFSMWzSKzangne6CNcHaAB+6mN7f7Fa99ABXJDlXIUqjvxnN3bVexSrrW
	 WpNvev9uSr3wi79R8tbFuiWQzsPoyxdCiQZ8Hno3DMADVCdVa/E25EvK4INfZzd+ZV
	 sSqeFjvD9OuGV/uSHELNOswD1cQKEKWoZ7WW+lGQ/yD7q5Q3pRbcqX82JG+yN3Vhsl
	 jb8euAjYQYxsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73BF560759;
	Tue, 25 Aug 2026 19:04:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EF9923E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4551A80BA2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tcricxWLlzvu for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RO7l1qcq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F2A080B97
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B5A2412A3;
 Tue, 25 Aug 2026 19:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DE61F000E9;
 Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684660;
 bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RO7l1qcqs5/oImFSktLUvGu14lhH2Gs5TqF6J81ryFBqrFushpEsvS76ORoAv0PQl
 fDRf2u7I3B/eIrUPUwQKKnfT9eK9Vuf/bYH8kOJCZ7JI1Qdc4eJyfM+1OtyfJfKMWz
 iZ5zPhC8x+A2K1w0uGaIuAjCAxXJd6rNTZRUSLGQfCHkSCjjkPrOVvTP1YeMomfaUz
 wS607ws73JfOzSEMUsdnAXKxi6j2AWWyqHyfwIZHDq+pGyy1oMyg65ACF5Et3JCCl5
 nDrCtvwmD7qrLnOAmmkkX1O3IW/BtbbD5c7txaoJvJs8eAKLa+TrbU/DQVXp0aScbl
 tx4VoLCeebuzQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:08 +0200
Subject: [PATCH v6 08/13] arm: u8500: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-8-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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

