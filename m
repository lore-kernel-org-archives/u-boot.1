Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7190C61DC2
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EEA060712;
	Tue, 25 Aug 2026 19:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWOEJSQfZ0EE; Tue, 25 Aug 2026 19:04:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684655;
	bh=gl99Qp2Z8KTvwANJtGhic34Apg6/cIG4YARx9Ri6ahQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C3l8bKjenyrP3HVCa4zD2o3xmhjfugUbA0ajyfjQi4/mMuoAJsLgVqI8epUh8Lme8
	 OJPh3h6Ywl+dW8xPIneBxIOrtgBmV/OGRIWDb3/pVJy5rFEytwlgJV5VpDSUNdAqeh
	 yLG1ruuGZ4x6IFWyQT9Lq196H3MJIKl4NIOe1eRvUA8wzI3iCVMOi7X71LAybMHEZw
	 pRBZOwYsP6Gu317od/OPXKuGfVSZor4wTyPEI5rgZoroZNmG13aosAqvV34MRX4k2+
	 27PluW8dSMdb4gpjC/EpP6ysXQXLGT5VAvnBD+bV6riyvLh3NFrMhKWs60Z4i13Wtu
	 pWDmk9OHgKY6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C80B606FA;
	Tue, 25 Aug 2026 19:04:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F15F8334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7BD180BA2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GD8KPI62x1Bc for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=WmsjBWzt
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC7D780B97
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C86940AFE;
 Tue, 25 Aug 2026 19:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C01F000E9;
 Tue, 25 Aug 2026 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684650;
 bh=gl99Qp2Z8KTvwANJtGhic34Apg6/cIG4YARx9Ri6ahQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WmsjBWztUGEpKXRy5hz82KXFDQTvfWEKiDSlF7F/r6fqBkLDo+SNOjxOh5sLE27kc
 oZwGzXSlDs8H94orx1N9Bx8xW0kg1xtNxNAupuZxv4RGrtOl7O7LYNDoFaT2VQ52v1
 AfFGYMpn3CA1kv8n3uDub2lmA2dF+HJ34Jld6Z9fsTlNaT0sYhA67B+4sVtNLu1tOF
 zJNlx4COns29zUiORguMD2RGMPPEPAWo+E/9gqMbEHpBDmzxeV3luJTvthgIxfzVm0
 78GymVCDFKLFXOc4ZrmKMqeLnXQF2w/T++5HyqsF1gSUTUQT6TnLuXgfT729yCDA4P
 87aLRkfSqc6kA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:02 +0200
Subject: [PATCH v6 02/13] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-2-61446b6c289e@kernel.org>
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

The Ux500 MMCI variant can control external level-shifter signal
directions through the power register. Parse the standard ST MMCI
device tree properties and set the corresponding direction and
feedback-clock bits.

This is required by the external SD card slot on Samsung Janice, where
commands cannot reach the card unless the direction controls are set.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index f00b0ff0dc95..af21b814641e 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -427,6 +427,19 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 		host->version2 = false; /* ARM variant */
 	}
 
+	if (dev_read_bool(dev, "st,sig-dir-dat0"))
+		host->pwr_init |= SDI_PWR_DAT0DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat2"))
+		host->pwr_init |= SDI_PWR_DAT2DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat31"))
+		host->pwr_init |= SDI_PWR_DAT31DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-dat74"))
+		host->pwr_init |= SDI_PWR_DAT74DIREN;
+	if (dev_read_bool(dev, "st,sig-dir-cmd"))
+		host->pwr_init |= SDI_PWR_CMDDIREN;
+	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
+		host->pwr_init |= SDI_PWR_FBCLKEN;
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

