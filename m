Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F59C624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23D7C406DB;
	Tue,  1 Sep 2026 09:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJJpfV3UbR2I; Tue,  1 Sep 2026 09:13:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254005;
	bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ji0PkWg1aUcHrI8PDcTBe5osE1RIEgCNcaa7ligszbvCN8Tcw8FWLHMlG6UE0Fv1Q
	 J4nXQ7UzHRbZpOBv3NGNFMHIvDzJNVPP6ZzzLtovvFkPk4hL+SVBkS5Lyk66U1/yV7
	 7LBHcoD2N0wheXsufM3S/++xtIjYOpKJuU0/zeY4TO/S0JNDcOAEZu93tjXvPPIau9
	 jEbsZMAsDJQSRdLeeWFLBbMbio67KYuIfwN53E+KHjxS7gAE6vzUnOWVUJFRN08YY/
	 9G66VtRX/vRF7nZfCTGRRku4FtqGGyR9ukufajt/fgXJbPtSnVsPmXxeWgpMCpH+vs
	 f62aMjt2vAjLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F29A0406ED;
	Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EBEA105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ED98406ED
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ozb3GqkEGBQ0 for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gydBjcW5
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C120406DB
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC8C5601DB;
 Tue,  1 Sep 2026 09:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CBB1F000E9;
 Tue,  1 Sep 2026 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254001;
 bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gydBjcW5EylQqd4L35sCjWFCxa0a+tCC2xyBonFK2qWgVSO6+uRf4ywbpAl+ZIm0N
 u4U+D6trEy0U5m9w9/qbpfOSh4sCB2CcXzzRBKGmfiZ+3KS+CJq8pLA41IJBVyN7hS
 f6MtlYY0g2TAZBN0JZeVtjEKHzHvxo1TEXjaRVhVlMExyoIt21eURuD1+SmCZDFrhn
 xo4+d63WVHMfIxXrODoSI2gDF8l9wr/nXVzMh/gjUF91/WEPcle91bxFaOtnT9UTqC
 Qd812dqu/FLB+/dRQAa+0ziznFzQaHGeza4sH/nodEnKG1U0KGARnXfKemUn0eXw8b
 4v51wvQ9Ui0fw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:06 +0200
Subject: [PATCH v7 08/13] arm: u8500: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-8-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

