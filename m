Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C516FC5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9284D607F2;
	Mon, 17 Aug 2026 13:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id goFuhaq3hj2j; Mon, 17 Aug 2026 13:34:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5440607EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973652;
	bh=VtuBIXCXjs+b6c/MVUa+Uadmv80rKnU0AUKVauJhQPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a8J1odYKk1qetdNUNx/1Wa4xYGxtuv3d0Dn/PrwFBQbAtTN8FzyLvjypg30Zpu2O9
	 GD9tlOtwMHsNIqX1df+cKv7U1+I4tyNYCjSXnzYVjX8LAKG0FVCuig1TMcj4UDzcxo
	 sFrnpGd9H7PSpSr94xhR7/h5IbUYcEhxfMKwNsEWgYWSPy1HH+Fcn4NaQs6k7/62Cr
	 b+Op9mI0TB1s7ikP77SDfUA5ObVMYtINRccstRku4gZxrF/EjtK6vcgIPz34FsnpJt
	 3sRNpa5++Ac1ZrPCAo04LIVfgDGxmAV9zfCNxW+T9NMonoCc17iekgMyWHgIfMFVaz
	 zpyiIfCff3l1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5440607EA;
	Mon, 17 Aug 2026 13:34:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 042A7147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF249400EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id usmhvKIBL7wy for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2CBD54016F
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2CBD54016F
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QsHTNo2T
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CBD54016F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 10A83600AE;
 Mon, 17 Aug 2026 08:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5FD1F00A3D;
 Mon, 17 Aug 2026 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956263;
 bh=VtuBIXCXjs+b6c/MVUa+Uadmv80rKnU0AUKVauJhQPc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QsHTNo2TfD9Davz05SPg4Pm0rJVG0SpaKcil0NnaKiQdvkKZ1Jjk/WE4Rnu2ipiCJ
 cLipBBKmhCdTrx+JmHmQCyLKvKVhT1LCozkVmwXo5E77ACSMhzD7ZmdmShg2/YcNU6
 OFg6WWCTiRXOwh1fOGtKJp1SaMK1yGe7iwpw2qnLsGFpEpV0wiArbGAfz9XWDSpvWV
 fHfRvN7QugUoijFupTykc6sxw5jVnRjMZjXAKPINSZ9H2byGPYTZiqWqMHAbOMcRG/
 SgfsFvi7jBrp4tEqNXT7o2rlhtM7KtMa0JEVL1b4cQ43YPYbQJYK/SnbJAU4ZUdoTT
 vcREpNgpkDiQQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:09 +0200
Subject: [PATCH 5/8] configs: stemmy: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-5-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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

