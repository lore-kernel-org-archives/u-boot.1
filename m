Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D0CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 18:20:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4F1040669;
	Mon,  5 Oct 2026 18:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4ZUY77QvFg0y; Mon,  5 Oct 2026 18:20:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E331040680
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791224444;
	b=dnCCHikdtJA4+2ErwR6OmIBaGcT50Ry+L5wFaLnES0cFgtJdyOhmQfsOAeoqG4SbNmqx
	 ayozHSpHe0iyls9oueezIU9sDt2+wkKQF+xku5dycvt7muPnDGwwGhS9qf4yrwsGn9dN+
	 NBGkCBbNhu7yHF4SBwgZu9Rn6YqOWzo9HSCeK0eR2cUTdqUA1pcmoFkZrXnspLCxcz2rj
	 brqoQ+55MyF+08weVE/kB9N3rLJoSn6tQ1+iTDfrz8KYBW+prdX/9ytDnSfKuYsRV4KKW
	 DWHROrPbWES0KfHiOXPA53xRvWvuPdN26hKYDliUpgGTFgvg+dSptlG0PYPUogDujGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791224444;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gHKvRocAL1+chmrS/P7RKeF9fiw9hTt/P6W6BCz8sZg=;
	b=cOVDPKrxsWf05PxPhUkzdXA+yqEgo/yjKZji7nQu4QU7ICVNYndZiZGe/KYlt7V2wrm4
	 ZCWlUpN2WwjjIyO/j6JnO133cfH+DlKctDXdX/wQnuIpMdXQpzLcNAvdaZW5DHv8/tmb3
	 LVjzTJhDdobwv9XDmGFUh8aZas0Em2SXXOzqVJ2XlGJBSLDSUlJOR5zv1vBYFY9YRcKmD
	 qRWFFqHdXTjal5GNjEoRCHuMklg0pRtxPIbTL8ya9+5FQVeFE9lGBoBmxVeAu80rf91XF
	 Zy6Lyrb5zZmSyCBXxQDLBf8TUKcrBg6lnyIslmHbE8Sg7Twm3nxagc6bWiaUxQGAVRQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791224444;
	bh=gHKvRocAL1+chmrS/P7RKeF9fiw9hTt/P6W6BCz8sZg=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8bAONFDDIZqXg24tBXqfxFz563YNFcYrEMYyqrXL6Z1LtLVTCwKB3wTzhKgJnq8X
	 lWvtMnTRloZoJcEx1PwS2Rx7x96IiifuD56TwlqXG1zIHdAcFCOg29h4uFJTWqCOpW
	 WvY0ecBkXU3G3V+wMpICk0CZLDrlO5MdaxvouYLg3p73rJx/7lyzKUZNTHO2TTSGIP
	 nJLiTx057p0A4W+XwVLWWEM6Nd8zlPmvLev55lZe2O+vXNR1KBh51/csl8SP2oYwG+
	 zy4+1jlvsod4UERqtqlkJ269xMudVzspVeyKwdNg+hoXDVwT+L0qYZj0+XTIGDMGLU
	 6t0A1uQNSLs+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E331040680;
	Mon,  5 Oct 2026 18:20:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 958B61A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 871B240207
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:11:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xs6m--GXDFa4 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 18:11:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8B87D40051
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791223875;
 b=I0PPKBppyNbU22GL4+9lMVozX38+ZTpz3GxG5CCYL/bzSOn5C0PG5qx1zNg0Xm/DbNRx
 YMpyc88DFdIlbgX08X0Mnosay1Sc0AIdnQ2o16kpxKlNBhU/eUwKdQRjEwMin5gReJueY
 4UFpaB3SdTW+1qEgTCFofRdDExy+T0b92uaTwGmE2V4TjjiuxEcZRoMWYjwqNkGLKzhBM
 ryW15qVkqs1joZxTA78FXg49ERP+kaqiR8+5pbpdG/YMexpFQ2C4sjWYAEiOz051nNjHR
 GVGdbZ+B7C/Zhksj70n/Ck6AyqlmNxM+UJD2hpMOz+XxxHmxJfGj0mfkCGeFSGVmwuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791223875;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=gHKvRocAL1+chmrS/P7RKeF9fiw9hTt/P6W6BCz8sZg=;
 b=HWsy5+LVbxxnNU3nq3YJHDQFimEYA2o92Zq6kbUizCkkednz1hQpDV51C6U3MSag0Hbs
 8y3/kXCYDLoswPSIIFqG6GYJ1uZAn8Kb2qJjAAU0Grl7ZdV+kYGyzNX2ufmFUb8JOb4oh
 sN24WCIssdRnjdrchuKydlVX3wHaUXoSm6Na/0PELRM4anRkew3luD0PnCzJPlD9ZuCT5
 2tYYz9PqAmaYZO9TS3uuSSaz1WmarMZ+kYZdYPd7w1vArRMhiCi+PNgQc74gvd88+JMlc
 iwwjgxpmbgWFCBPRQN0Fa456sMp+S9w0DuKVIgKRlYI5fEIZg6XmDFLd5O24bUvqWqQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=DiferoiE; 
 arc=none smtp.remote-ip=185.70.43.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.102;
 helo=mail-43102.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=DiferoiE
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B87D40051
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791223870; x=1791483070;
 bh=gHKvRocAL1+chmrS/P7RKeF9fiw9hTt/P6W6BCz8sZg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DiferoiEaH8FgvVb1jRw4hG5KHDraYVZXu6WUMarvGWjwZc1ayraZuAdBEZvJHhQ4
 PmowAxuyRDuEJ+BEHnyvKgBV4qKn3ZUS/R0Dg3Lhd7dhHt+em3TdKUi+VL41gHQ7rg
 Z73FSebQr0Pj54cRb+kV979TjCmChzhSRy0mhlKN8qWQMj33TgSjwKwlM0nlkm6vYT
 serPmOJUU/pw+TvblKCE6BElnSkJJAXrdRBMrf8ID1mcs7d0vp74k2jqdc5LN3zLye
 7VFjexqiQZji8RFNgfAUFKqdkMnvZnbO1EvYS6h960NljF7RbHbDWnN8vB30VGibfE
 ZUITNK86YB6oA==
Date: Mon, 05 Oct 2026 18:11:04 +0000
To: Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] mmc: k1: do not release the shared AXI clock and reset
 on probe failure
Message-ID: <20261005T140306-0400.mmc-v2-0003.DaveWK225@protonmail.com>
In-Reply-To: <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 082dc29213ac07de2eed166d75c3323c0692277f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

When the probe fails, the driver releases its clock and reset bulks.
clk_release_bulk() disables every clock and reset_release_bulk()
asserts every reset, and the first entry of each is the SDH AXI bus
clock and reset, which all three SDHCI controllers of the K1 share.

One controller failing to probe therefore stops the bus of the others,
and the next register access to any of them hangs the hart. On an
OrangePi RV2, whose device tree enables the eMMC controller without a
max-frequency, the eMMC probe failed in sdhci_setup_cfg() and U-Boot
then hung at "MMC:" probing the microSD controller.

Keep the clocks running and the resets deasserted on failure.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Validation: executable diff unchanged from v1; exact-base replay and
checkpatch pass. Combined-firmware warm-boot results are in the cover;
probe-failure paths have not been retested on hardware.

 drivers/mmc/spacemit_sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 4284553177..88e06a681c 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -642,10 +642,14 @@
 =09spacemit_sdhci_phy_init(dev, host);
 =09return 0;
=20
+=09/*
+=09 * Leave the clocks and resets alone on failure. The "core" clock and
+=09 * the "axi" reset are the AXI clock and reset that every SDHCI
+=09 * controller of the K1 shares: releasing them would gate the bus of
+=09 * the other controllers, and the next access to one of them hangs.
+=09 */
 err_reset:
-=09reset_release_bulk(&plat->resets);
 err_clk:
-=09clk_release_bulk(&plat->clks);
 =09return ret;
 }
=20
--=20
2.55.0

