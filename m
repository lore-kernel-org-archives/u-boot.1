Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46920C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D45E80DE8;
	Wed, 19 Aug 2026 08:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw2i2WYgWNgV; Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129660;
	bh=gl99Qp2Z8KTvwANJtGhic34Apg6/cIG4YARx9Ri6ahQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JHS213GTawCw8+Wl3sbBX8qcGCKrg5YUYcZ7nLKaUJ/QqY2lHhg6bSZCsnGSW5aty
	 1f2nQwzf4r2tTCQuf1VFmLEJRrtWrsS3gxTotnsEdCYcq0BuTN8v2NUOHI9OjogkVj
	 YbWShHFGKuWJ5aCBPhRiZWVBxWsM54EswoYxIJs0NBvvg7cyxwc0KU6H1WdTGjUY6p
	 Z/u3F8j3Dbn0yFw5ysq/Tj3z+jwZT0o1OUi2B/flAX4J9DIB6l3DLbBMM0cqbR1YG+
	 t7NgNIoQcXUFn+HhJB7oPorkuDQXjdC6ZVMUJopIfY2HStMCgz4up3MrtpL997PbPY
	 pQ9JRljDUEfJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7740880DD9;
	Wed, 19 Aug 2026 08:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F6C6265
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 326E380DE5
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQI2v_WgDdY8 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=bj1SkEaC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 88A5580D81
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 943856020E;
 Wed, 19 Aug 2026 08:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5AF1F000E9;
 Wed, 19 Aug 2026 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129653;
 bh=gl99Qp2Z8KTvwANJtGhic34Apg6/cIG4YARx9Ri6ahQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=bj1SkEaCTpiDTDRe44y2HzLJtvqGt/wXI/JJoW9Olrp7hl4GLGGTUvZK6GmzAX8ug
 yY+W/16yIB3hXgUX4J9lvzYwvvEXmHvl6LbkiMwANF9bZAVqRuaaYM7rMyPPmVRpsO
 knbC4OrFVGu782vGk4Csy9nK9clp+Z3Juq7cd4CyzRvK0Z7SpAjxkzuEvOyIjhXfM/
 VHe/4jCJCNhdvNZlHQTDbo1Ds6PvQl/Q2UHNIQ8Ak3CnVf6x6TjJsT2W7C5xc15Fmx
 bFzS7AsnQq+Fx4+r+ClQ00jh/u2WjdlL7AD/GiDdPlHehnku8nO1YDgfe+dEELeAc6
 29S93DzXqtfPA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:07 +0200
Subject: [PATCH v4 02/12] mmc: arm_pl180: Configure Ux500 signal direction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-2-f1c8c9ffac30@kernel.org>
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

