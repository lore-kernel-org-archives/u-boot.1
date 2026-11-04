Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984D606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vM5hyXOw;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=NDniEpa2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6671B60834;
	Wed,  4 Nov 2026 08:52:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5Lh7q3PcX38; Wed,  4 Nov 2026 08:52:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AA576075B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782323;
	b=lHZ/+E+ZFtEMGXti97Tg7EFLz37ern/g5KpYl7IO36jSXXOd4c5VAQwcncKGzGmabwEY
	 dmfL7+rY3QdVFF4aqxwevrcgq0TfU8S/Y2Ao8mg8wHyLdFqmQtkc44A/mBplOrEmKiUWZ
	 eMUY740MB71qG4jd1ku8SwUL8v8r/fXQPG8Ke0/01PsoTHT58FtuIM1Xg9PiV5t1MTegn
	 DhNKoRwE32Zpj7P2mOlJYMKZq6WtRx+YNdSxzsoV11jXtlGqG48/U4vPCiqRxahU+XZCp
	 nGE6IbcWiqR/1c6BR1WLWeL7bJAw7ZbTgx0UFr27hM1RUP5JfNyNEJ0EO2xdo8PKvZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LWNQ7iGnI3uQjtP1qavPdgbq/3YCK4FiZcgcnEpAZpk=;
	b=sft7Umhodm9pM/DMHzCSyA2XKrd1/GxLV140dGwiZoOlWGVbe7utC8UW0bz1c5QDhQFf
	 au+S67ETlsgNunVkLDT2SCwL4WxXDzWrMnvYHOS4UJpHLapjj6z6pR4xZ1gKic6xrXI3B
	 c6x65xUzfQRSf6NlgpRfQuTJZY5i5Bcy5lY+Alln8MpuySNzDy6WiOlzwRXsx7vddqlAK
	 XEwcd11/iTVdsvo0bc+CK1uSzNqIIBCoC9dqH7dNkH4z/4VrC3Du4j1T2/jmpjFNbig8u
	 Bvi0iwODwt88x3nM5zZLdYb9UhxMobjH5MgqZc4lm1G1WLE8DubGrsN+uAmgdC50xUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782323;
	bh=LWNQ7iGnI3uQjtP1qavPdgbq/3YCK4FiZcgcnEpAZpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vM5hyXOwo4nFzRVBE3qFQYkp6S2WgxJXzAWVPFJxcKlUhI7lhlgPyds0XYj9EB//g
	 pgFLItpPtS2236u+BYPWGdQP0P4ETyZ6wfE8kvc1CCAE0V8OD/cm4neslHBa9gsQFS
	 dW6t6MF3FkNn581O5ijHvvRAS9Cneie3zECZsytawjTttI7pBq9SvY4yQu78L/xFZU
	 h33KpG3QYF5IWPykPpCo8r2S4le4+/iC4CFQ/B7Th06lRVJt/zDCe3pz7H01Lukn/M
	 yQTEYuMdGrNjnW+XV71Z+ng5lKTEyO3sgJIAmEwOginqmirEmVAt4peZc89RnHUT/k
	 7/mlGRPy98Cvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AA576075B;
	Wed,  4 Nov 2026 08:52:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EFFCC235
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E163140762
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2xtv2nEDjD6 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D381406C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782321;
 b=T9JGWokfEQ7c4gDdfYlzn4wvB5XsIJoHowBu0oA5BV3RpU/a5mHr7py8t1/g2ON4lg6h
 y6ilGFn35ouZqlc5fnZSfQqw81XDJIHf3kCLsVdTAhQGqZu4WMUHvL/bFk1Mzkya8aSMC
 FkvNG5ao/QUiM9OsQEPvjjLzfAKyPgWqRqd2pykN5KQ2H4x83JQoJ+TfdhOtgoa7f+NwA
 lzwuDCd0AsYSFFBERvqlpvj+svSzJzISJB9ogI43WPie4Qt9G4lfZiFI+cWGz1RD8BBM0
 1vrF59dz0GzVf9FyRlWtQYhHlZyNrfYPRgFPrkUjTOlieeXYZzMPRJvHJZcXPAv/WUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=LWNQ7iGnI3uQjtP1qavPdgbq/3YCK4FiZcgcnEpAZpk=;
 b=qzw6MGpuQQd1KRiPIb2GYKuMKKXfImp4Ye/OtdHUF0KaTOfBxYGfwFvB7WPmm6OvDPJP
 wtxycuR5SGKJ3WJ0PR3rNPvxmOQi1TWLfqhtNE6WRgA7Rnh5JRGCIWGdmB6HZCp4xB603
 3tsvHJshp/xg05zXqyjQnyu9D6SB1QLgEBBejDLewNqPIwAnzkQTCJfd6TPv5RF7Jkxli
 Fl8x4exDmaCwWYVNXhwGfD3isibcwD6NMN4HeBCFl/UhLliit0qLgvHLI2Y5s/HcNXehf
 PbQ/VngPf5zpbx2G0z0onR9Ac/NEwShkWf1OEOVMJIaxfLJylpNamlBMHuk6VCVosfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=NDniEpa2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=NDniEpa2
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0D381406C9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:00 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so8954915e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782319; x=1794387119;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LWNQ7iGnI3uQjtP1qavPdgbq/3YCK4FiZcgcnEpAZpk=;
 b=NDniEpa2dkg5CPOiil4IGzQItf1rMXRpZE2ON51w2aD1r+A/Bgh+bq1mz+Hxh9rD1J
 DGnI8mopH1q/8adcUOYPPlJePMCXCDacsIeKRxcTUTx7J8HJEONgfHrq8hcD9wmsb3lx
 AwTQ8911CO8GqCKtVFxssgqOZ3MmrzT3tcRYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782319; x=1794387119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LWNQ7iGnI3uQjtP1qavPdgbq/3YCK4FiZcgcnEpAZpk=;
 b=l8AEyqNAwovDgGRgNeHcr7js4KdEmH4WS7+q6M/q6vNnUoE0dyKBsxaecp1TzmeKNl
 SN5aL90P2ttZrrgUweRjnSovP8KvgImG0oQ8DKTSMnTsFieBvsO300dsg58a3rXBpQYk
 s7CShT/KdMHl9h2kwS1C7i3wz0vdiR3tEcHTHYsHscZMh9AmkSWuoX+W2sdoMf5P3I4x
 0KLdpMf8hTGJoB3JR+qSx+mT0ppC6kodHI6BEQWbE7CKSt3Dtmx40MvI+ptk5c39NE+G
 e+z3PwtmO0Q2TVB3s66G1EFQGIKQC2Qz4eRetxsa+ItfQ42qNw9zSqMjGqRJPsLRCp6V
 bJfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzenj1c6E8Ol7JvP97wnxoVSJSEzCeo5LHYXyH7uEtMOujSmamD06R4VSgMGJqCtsvsRMV9moY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+5IC6j05LKTvObVYYynj67LcTFJMEHLfBxl2S13x9DokyjwzQP
 9VVnfx4Nh5u11yH2XxteZrrszS5trMS5JiWwzybgci7cb0Cbe3Efo2RWsbPlCGY+wH4=
X-Gm-Gg: AYBFou2m9yBaTGh362JMnHztb4fZfbvKX+qDc2D5plpqDrPQjGezDwvBqrakR8g7hQ0
 +0o9PCahGJHg3iV+FQpCyOHams6kSTmTB/CAfqonnkgddIO/xbAwKimohUky1Q/VwaP4CUmB/6+
 Y66TfkXWOOWDmjxKqKUUgVa2fWIMJKVhUqVIm0rd6DTJGyMBWG5Sbhinqjq2g7R5crb+pvATbqx
 /mtyi2mhBupArHoUzbZol4B745TIhyO4uXevjHedN5icj36+pSnpLHjm36rnUS77ywBFt526QSo
 Sz6DGNNcvvdxi+QXChg4UVMC86VdnQXkVUv7Zq3R+aD59dAaRqjR3Nc6VG1C5IHjnaLHMKSH+ly
 TrQ1n7FMurnZp5Fa34MDDdRDkTVba8Nh429VpHFYu2Dy43iEP12M7D+avC52icHbyXRkGuyMi1x
 iURH4oGADoCgJWlHzEXuqs2Bvic0ti+1MOdDc6Tps5XiKkvSDIoBDMtC2uFAb8XLStKajpXoJzd
 D1y14zekLubkoGKdA/v113+HgVd38XL0gSbErsh3H5sAG6yUC/xto8daH/VuQVivbhTLVHuu7b0
 F+WBYm0tODTqGbRXfs3ckM4QRw4p4orVDjFvVElbsSmcPK6rEofkGoXtUqcq0gQYZYRE6Lil1jw
 Ns/ZOUg3WNveLWNjgBCWQ3xjnHkI=
X-Received: by 2002:a05:600c:6285:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4ac180f07d1mr370898085e9.17.1793782318680; 
 Wed, 04 Nov 2026 00:51:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:57 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 21/33] spi: stm32: ignore the cs-gpios polarity flags
Date: Wed,  4 Nov 2026 09:49:54 +0100
Message-ID: <20261104085036.4012238-22-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As in Linux, clear the GPIOD_ACTIVE_LOW flag of the chip select GPIOs,
so that their polarity is given by the SPI_CS_HIGH mode only. Otherwise,
a chip select described as GPIO_ACTIVE_LOW, as on the Engicam
MicroGEA-STM32MP257D-RMM board, is never asserted:

  cs-gpios = <&gpioh 8 GPIO_ACTIVE_LOW>, <&gpioh 3 GPIO_ACTIVE_HIGH>;

Fixes: a2a89b2e21db ("spi: stm32: Add Serial Peripheral Interface driver for STM32MP")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/spi/stm32_spi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index c93a749cd5bf..776d88736a42 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -624,8 +624,13 @@ static int stm32_spi_probe(struct udevice *dev)
 		if (!dm_gpio_is_valid(&plat->cs_gpios[i]))
 			continue;
 
-		dm_gpio_set_dir_flags(&plat->cs_gpios[i],
-				      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+		/*
+		 * As in Linux, the chip select polarity is given by the
+		 * SPI_CS_HIGH mode only, the cs-gpios flags are ignored.
+		 */
+		dm_gpio_clrset_flags(&plat->cs_gpios[i],
+				     GPIOD_MASK_DIR | GPIOD_ACTIVE_LOW,
+				     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
 	}
 
 	/* Ensure I2SMOD bit is kept cleared */
-- 
2.43.0

