Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E88C88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 09:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA0E8607F7;
	Wed, 16 Sep 2026 09:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFYkDdphHIl3; Wed, 16 Sep 2026 09:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E1B8A607EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789551465;
	b=GcwkiV5NOethwWNUWWofYQnRNIGhRwEBwtt3u3oknLv5Q3OOXP1BjTJqRiNmhVwN9KkO
	 Rud2tvnRjf2b0tij+DrCmWWIVUACyXAJjA59chf/5+STL6JYb5jba3/EBrPtcA3LmLDnq
	 8EfkQchYBRBKR7n4jtbJJVV/QstL/8uxTmE86PwzoekC9oyYOhx10MVJHx+0M1pKVm28r
	 G9XpcdhL8HcL+WjSMBIT9Uo/+ZSRxjtoxEFqRflkX3tR7W6LNqzKhg5NeWulS9OMPQqLb
	 KeIlZlKpjyTsDRzbUCOSPQ6oB100HEKA8lbVEyaih5NUSIY7c8Av6j0ALsX47vKGdQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789551465;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4I8yZ6XOtXiqD24y/jVZ7yAQ6+QkuAopcG/rFs8GMD8=;
	b=CfO+nYMN8hA9tPWaBg4m9jQA/nqk5BnRRuvGPtGQJcpvpSbk/IU+mh6UbPElWo7UhfK5
	 E1Fm28yrcvGA8oiuiTVvbWRzqyzdu++jmtYxq57prDJOUwb3pdauv3hxxtVYA4CQfhfeo
	 K91r2GPlZV9NsTspldmNQV1OkZxJSET1hL/BNfw0dLv7uqkkuMsdwutCh3ajQyLzbL4Vq
	 WlWt5ekYU+6pyguzkdWtpiP4UexosTknjvwHjfPvC57JfBZeMyyWeJ1bnnNNK6RZ2h75L
	 p3IiOsDk28EnMGP/7aB2UqlC2ZoQIEa/tWqOFcOWGzDUHpyOnYf8fSwPOafJhlQOIUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEAdr2LJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789551465;
	bh=4I8yZ6XOtXiqD24y/jVZ7yAQ6+QkuAopcG/rFs8GMD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7fAtFKGUy0OZ9M9BOxRSwqalvcKwKkvILWbrmbu20ZkijN3Kf+izoO5MraKB+tuO
	 +hmMZ++xSJ97XbMyufLVU2WUcOnpPmFNYvU93RNkvC/HESwfmQBLq5lALEw+o95eIt
	 V1RLUgqaDhwfCa0lGQ5EPwyWtR/a4xjgM3N3sFfQV8+UuIJhkEOKppo3pf7jjTKdPM
	 SkE/zcjS1icBXWoC9wNWqthFxJEha8Pne8vx84XYMDNKrEeAZ7DQwoTUVqjns5bg+b
	 ch1QRkBkKsLnCYiA0FbMWmpjW2ZLftVyEbiMpw+kt+/uwAI5PRJSs72nOurH/2HIj1
	 JcvmxSzTp6Cyg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1B8A607EF;
	Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 87F933AF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A1DE607EF
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AXF_CDALjwBA for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 09:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCA1E605A7
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789551464;
 b=c+nd/DPEustFnRwMAPiCMYYz4KPRMxwmi7/t/4QtjylCawbBd+6znfK4aaHWpUGDirBw
 Qd5qm7/OUjac3Lg8HTuVaHb97E1XSW6kHer5OAmlz4URnsiRDbrVAL5s4QRToBC4u2IgH
 OdpyiA6Ek7H0rzvJQqIwpws9KTZ78dptNSeBguxSVedFJqMljO6nNABwfp0UhVw14Hf9+
 yWovCwgtFLdg/OjyT3ilaSZPaU7n803p+bbaThFk8lTj/t7/qm/LTPamfzC8njey1WNeI
 eogejdD6BeRj/zazDqi59SPgkExXtUc9KSFh5tfbIjUZ8RVeu634D2TP4ZgcuUleW2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789551464;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4I8yZ6XOtXiqD24y/jVZ7yAQ6+QkuAopcG/rFs8GMD8=;
 b=QMjY8++xpYdU7PH736OwVi+SDXwZ6BTyPGza6DxrqfpDU5N+qwG7eNYe2r1JeLlxVRAj
 PDMSQpySnAvJRGFCxfs1MwskmztTLqFLWMi5QCTnSLgidUKARy4dIi6FWKW10haZ6AKIZ
 S46vtuFB0wemXATZbKctfrSgkl06cyQb28BnyIrhgWVXGBMt1pox9QLWEIhVfU90JVfET
 iRFecnhKiOVBOZdNLqgmC4BdWJ/qw9lQ+vUkd+9WBkPRCof33ahzzxiUn/hkqvsfiS1CS
 vzQSRVWxiX0nLa2fhVB4iCXhjvr1HvZYzoWvmN8xVvYI4S1KeElK3T9GLX0YrSq8NXg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oEAdr2LJ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=oEAdr2LJ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CCA1E605A7
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 09:37:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D60BB602CC;
 Wed, 16 Sep 2026 09:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9B41F000FF;
 Wed, 16 Sep 2026 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789551461;
 bh=4I8yZ6XOtXiqD24y/jVZ7yAQ6+QkuAopcG/rFs8GMD8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oEAdr2LJOsgD3krxlx59IVK9NS24q42jjCuQ1HepMVTA0Y4PYLFJ1qzJ9TdEccYVs
 BiAT5r8PlbbDygy6Bp53IFpPrTqbUBVbD6Y2WB45Zj0kwrj345xfR5+viFQtY5Gd/G
 ofaJS/LisrefefUeGu60Nl4vSNfhs9riVyJzxM0nz69xhbN2BNVpwUzBVMu0NFYpiY
 Z/OcJynyuxVf5fJLzWhMS10A7BCL6wdth5GPqxtzZxqnOG2/dqsCNeU9ELpHK/p22y
 SqBue5j8kT/RZTVfRpQbj7ZHwKuF5wPKK/24eNL+JVn5UXQPInhLAzSDISTA2Bzdhv
 lyTNt9ruZ5kWw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 11:37:34 +0200
Subject: [PATCH 2/8] mmc: arm_pl180: Gate idle card clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mmc-pl180-improvements-v1-2-5d7670c3bb32@kernel.org>
References: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
In-Reply-To: <20260916-mmc-pl180-improvements-v1-0-5d7670c3bb32@kernel.org>
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

The MMC core uses mmc->clk_disable to request that the card clock is
stopped, but the PL180 driver leaves SDI_CLKCR_CLKEN unchanged. This can
leave inactive hosts driving their card clocks.

Honor clk_disable when programming the clock control register and enable
the controller power-save clock gating.

Hardware testing on Ux500 showed that leaving SDI_CLKCR_PWRSAV clear
causes external SD card accesses to hang when both the SD and eMMC hosts
have been initialized. Linux does not set this bit, but its runtime PM
and clock handling differ from U-Boot, where both hosts stay initialized.

Acked-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index af21b814641e..528612359789 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -294,6 +294,11 @@ static int  host_set_ios(struct mmc *dev)
 	u32 sdi_clkcr;
 
 	sdi_clkcr = readl(&host->base->clock);
+	sdi_clkcr |= SDI_CLKCR_PWRSAV;
+	if (dev->clk_disable)
+		sdi_clkcr &= ~SDI_CLKCR_CLKEN;
+	else
+		sdi_clkcr |= SDI_CLKCR_CLKEN;
 
 	/* Ramp up the clock rate */
 	if (dev->clock) {
@@ -400,7 +405,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 
 	host->pwr_init = INIT_PWR;
 	host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V1 | SDI_CLKCR_CLKEN |
-			    SDI_CLKCR_HWFC_EN;
+			    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
 	host->clock_in = clk_get_rate(&clk);
 
 	cfg->name = dev->name;
@@ -418,7 +423,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	case UX500V2_MMCI_ID:
 		host->pwr_init = SDI_PWR_OPD | SDI_PWR_PWRCTRL_ON;
 		host->clkdiv_init = SDI_CLKCR_CLKDIV_INIT_V2 | SDI_CLKCR_CLKEN |
-				    SDI_CLKCR_HWFC_EN;
+				    SDI_CLKCR_PWRSAV | SDI_CLKCR_HWFC_EN;
 		cfg->voltages = VOLTAGE_WINDOW_MMC;
 		cfg->f_min = host->clock_in / (2 + SDI_CLKCR_CLKDIV_INIT_V2);
 		host->version2 = true;

-- 
2.55.0

