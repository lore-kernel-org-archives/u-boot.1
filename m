Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E55606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BeGXOI9W;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Yj99cjiZ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36F34816F6;
	Sat,  7 Nov 2026 14:33:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z53297THslLq; Sat,  7 Nov 2026 14:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A29781764
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062027;
	b=MssN2KN2IHtL4Ypf1+McyZAfz0Yi9qrjzMnZdg2iLfyzhi2OPDOogr1feqAaAPMOC6LB
	 AQWK0p63HjRpTWh9+EpmpJrulp3khGBqmwFIrpk2e2G0aKEfFGIVV3ILW5/5PDh0AW4Ym
	 uw7DeSe1E7aAmajFcNBy/+uaCOJl0cpLvf7epiE7Qg4fH4P1CnKOHN3qh1iYubiDnf7+/
	 Sh21p4+Z5K4YhW+eVaNCKdZ+kLGf2WWqfoK43kTUmpc2BdQxEEIup3o6umBcuBR7aCZHF
	 l6SlbQIIomWLaFQXE+MPbuJebWWT0ww9gyXV9ZX4/X35hSkC0yHa+D23YjFKwJLxPcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=H7RvN9SgVC5rPkqfmMlc4+qI/4No8F7surEbzH7v+/k=;
	b=XrRlsc1VY23ZJrWi8GCg31VrDLJvqUm4Xn87FBU8Xm0+ry1JyRjSeUV80n6txuaXjhkO
	 eSrD+UexOSvX92RP/Aio+LbCQtU8obQIzxLGkQe7AKzkKwL8oOKz30MgBr65M3y4dhlWL
	 bEm6K/7+A0YaNAwaEGR4fVio+77dfm1wL4ejYGq5aN9MZHrTpRg6hHmPhAGQpaRc8mQL3
	 vcGLJiHbSlYAbCuqgKSj4ZnRMGSIvi0hQe8SC6By2JGZzkSmUkkJyV3+WCWqss5sHeSgU
	 gTAlCuiFbm/V6vWMr3AAk4hq/+4aVZc6fIr4g/VzREziGT1UR8dOnnhMVm7h1uZD1GA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062027;
	bh=H7RvN9SgVC5rPkqfmMlc4+qI/4No8F7surEbzH7v+/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BeGXOI9W0FjDCqW9HcyR9gSKNAdDp8zTq+K4gCtaZo+Y6iHcahjZaZzXi0XbLDR2H
	 SDN2Osw7nn6mFFOajjSZxooIAzMihfbr8Q2KhUu0mGl8pcu6Lr7oi9VJHpvWJoUKB5
	 wievTEe+3rE1mUwTxxCHmm3fmMeU3P0X8tGBuaNs0vD4ElaXP8JR5GbXQty74sCj6v
	 yOK7inE8uvG78SB61nAH5/1iVKWf0PnjkuQ/du2cAEd2iCCbMMADPIPI+V+Ro7D36Y
	 EfSdvus2hrLY+nojCrjO4IUSIa8v1TKJS93ca/iG/BrXeesrV3FIdEJHoNI1+eG+zc
	 YycR04v2gZWtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A29781764;
	Sat,  7 Nov 2026 14:33:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 221A3211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC84760807
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSU8qYyjjBZV for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C264B608FD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Yj99cjiZ
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C264B608FD
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:29 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so880355f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062008; x=1794666808;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H7RvN9SgVC5rPkqfmMlc4+qI/4No8F7surEbzH7v+/k=;
 b=Yj99cjiZwWN4aA8NxRt0FxeLiaNgs7jw6/zwWBhwqpY1PPCWPLMqWiFGbCmYtA2NAE
 J6ifjLJ8+dpdOkFMZScRJfRuQ02m6fvo4f+b2oKNPLmW8JiR4LZT4k1uE6JJcXyg7INX
 LOUhvPdRd2oW8bUfRCsF+MLgPTmFDB99eDNhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062008; x=1794666808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7RvN9SgVC5rPkqfmMlc4+qI/4No8F7surEbzH7v+/k=;
 b=eO/l3DT6bSvoYqrjTJ7si0OSgN3xonEOOkOF7bYcHecIltiOJ2voYDpvfX31SNoEZe
 YbmoMdeo7MiKJlYJ5VGKJkB5E7jHxUVC47Kjtesq22SXycGsfs7jI+wJC/H/m7ByG0LD
 +ab5chIAbfla4GcI3VilO5PnQt41MJ4ZgWoqNJ3UubIDfG2X9VTbJX2IulPI8N6p2eaT
 fUSlgfTlp3sUeJp3Hc2rzdGRu6khO/PEsgICPh91OvYoNzLLqophlpHchMVEdr0xSBfV
 QZ9yb8690OV/h18lK6v7J6/mGuMEu2ZqMzcYR1a3s2c0O8UfeHQ0NYXQDuC2TcNftBJG
 Y/xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG+2P6VUaONY8vedapvioSnFFOR+13wyiwMnCWQXGoDp9277+EUMNOgD5gw2hrZp+P6A/iC9FA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8X3C/JvS0lEAeAblC33S0q42AC6stGz6iuYsxXLgnQjwbYWmgN
 Eq2k7r6sszbSKFbCwoyZ+yJVhd+A83bAxwNSgLtIkNkUjxrh3KxGvgHkWwsdiAAHmcs=
X-Gm-Gg: AYBFou3WE3StdXLY9KHejKDCfhz8ZlAH18nmMiQ6xN3TRKVMjPKZCzyX6JtGEfaMFkx
 m+15z9c2SeXb8uyk5V6MuNXeeQld1+2xSxRFKj+RRaICjYViCYjL8CFX95vOoJEOIoyz+e978Hi
 Iqr+UxOHLD/gW9ytO+oF6ptTiT5CFpVbq0Bndu5eamEaHIetvhS4YLlvdVWP4fb/B6pvbgui/cF
 lGIwlexsOtBqz5OYXK02Ol4dky6T+IQZjSInLkdCKlOY0/qyS3k8RrTAH6M+WrrQM+1WAO0X+q/
 pyLLY+ZztopVDE/t3vx7MgNCSwgGTg6mozVlQgcly8ODJS8rwFihhf7gQmc0tU/IA0RDvNuC3Iu
 aZXzkRkR8uoqaJpaFu/flC1+4zExnNC3cGMS/U+8B4j+uIjDgQGMX/MYCiN3BvTGATJast1sVkH
 bVixSFSOUDysRxoLJmvrdaAkc360WpzNEgxumf5P15zKQqM4InuVLXwv9HJmg6u2YrfOqh5rF+P
 uIFcn/1G8WEEsp3j+6gMQfOuyu8KN5aSClQMeLPQeAjQOByxmi9Bsxz718nfxLRlLqnQz52ttsA
 Z0YEvdnLEvVB9ruJgpr2dSJ+KZdAUlUf4xI3gudZIiJQzizEHbcTnYRW6WVHnzSfsVeBB7Wk07m
 hZAwinj8CX57etbpqp2P7VHnDgIz8ocp3Ggaz+n7nBpx5jEtRv+jQXRfawWAakmrmfk2UFaXXbI
 Z1MUXilma98uWxT7HcZmsuFOBVrw==
X-Received: by 2002:a05:6000:2911:b0:492:c04f:1dfa with SMTP id
 ffacd0b85a97d-492c04f1ef6mr10133620f8f.9.1794062007598; 
 Sat, 07 Nov 2026 06:33:27 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 21/35] spi: stm32: ignore the cs-gpios polarity flags
Date: Sat,  7 Nov 2026 15:32:11 +0100
Message-ID: <20261107143241.2236511-22-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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

