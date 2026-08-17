Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35C0C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A834740809;
	Mon, 17 Aug 2026 13:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjWfoJkGRz8u; Mon, 17 Aug 2026 13:34:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AECFF407E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973676;
	bh=VtuBIXCXjs+b6c/MVUa+Uadmv80rKnU0AUKVauJhQPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NHMR6IIXZbKdtsBFkICRw7THdrzFYx5r45yyMnen8HP3G+tKZEn35GibOTTWY+5xh
	 WSeVXlb8f7fRtwPpG1/H+r5548IxJIWgcUorAak5feAAEP8U4d+vq/7kTldyOQc8vG
	 dheXpxK+71l77OlOEzcYOAo/at928yIaE+Q/Sr0lSrFssYkoqdpQ4ZVmwk1Krz/ttg
	 Y0sF/83Fo4EoccGd/qFPwzCkJUVT7VC6cZLBg1IrC9VdNOF065dxU3S3EdfVRW+24+
	 wgtVm0gQE4kSAp/cV93L3x8MEqBumpxBAxoLwqhyW0lup3c2PmpKLimhI9ESwNa5em
	 oEuoy8gxuUwwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AECFF407E9;
	Mon, 17 Aug 2026 13:34:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72F61333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59511605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4Pgx8SZgFR5 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:32:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 659036071D
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 659036071D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Bi3ekP8Z
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 659036071D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1678143CC0;
 Mon, 17 Aug 2026 09:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0891F000E9;
 Mon, 17 Aug 2026 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959122;
 bh=VtuBIXCXjs+b6c/MVUa+Uadmv80rKnU0AUKVauJhQPc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Bi3ekP8ZnA0A1D/6R+KxkSXGBVNFDMB0WRlmGUIeW9+bzKwEdRIuM4bz7TnPvJHEJ
 2DqqH1y6OlkS92q/+sSYVklCXhVFet75qDS+WhSXTCd17OS/Wer3SjmAlLqmMBfZvU
 cFY9N8uRnUiHsoshNrW+OKKXhooqcsd5u0o0YMHHK1bVgho4yt8tSRLrHhGMAMGIyT
 ynhxAe76QhCSuVbNMn8Pb7ivzfmagucVhfXDvUpxYNpGbOKeA7cGojSZv40Qa5x9Fc
 4rgDc0/fgq4fFl+DV9tAHNWIDfdlawO9cMcE7fN6dOxBWtW5RLCTLu6jCUdPV+3Nzr
 q3xtDhwmUp3mQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:54 +0200
Subject: [PATCH v2 5/8] configs: stemmy: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-5-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Have ARCH_U8500 imply the fixed regulator driver needed by level
shifters on the supported boards. The architecture already enables the
regulator core and Nomadik GPIO driver.

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

