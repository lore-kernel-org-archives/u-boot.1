Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F415CC71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D831982F35;
	Fri, 13 Jun 2025 15:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yMxsG4jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F5282D09; Fri, 13 Jun 2025 15:22:19 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA3382CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:22:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad1b94382b8so384892966b.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820937; x=1750425737;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AkOfoHnFV/Z+CEBZc+gd1476X5driDQCnPNgqB1p1zw=;
 b=yMxsG4jxrtloQ177mrdxPAEi+nDhCqVsTPLSc0UMn+cuE+aFNBIAM95aSeAM+w6kIq
 XLC8Kg8WMMjKHS93G1AbSyg0Oomqn4Km/4305k43A6Rr2X++NUBXPs/jmgfWaik6mMJj
 atjvkiO0U7LbOZK9pKZO4MYPkgiKwGPMH3rISh9tnjU0GYJJOKQ/kfTQREeS/MWpOfQP
 f19xqvgqt6iV00dA1RinOfMH+g80gnJpKKEEWHTFGbU82QvdpFNpS/6mW+w4y59pitr4
 RoJGT9+Kw14kHrVCjF0iTDsKz4Asz+e1/G7yMJ4Pfko0AMbcPOR5l82DSaZydttggzRU
 FIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820937; x=1750425737;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkOfoHnFV/Z+CEBZc+gd1476X5driDQCnPNgqB1p1zw=;
 b=AGs84FA1rQjBGZKLrddpxqZPwI6oqChF6tMB4bsOrr9KznRD9xT4II9U/j/Ctm6B9c
 WoUkpQ5jSpXFO3IbHLRvOmM1JdoClZaOhxZUb0lEg+oagwYVuIViE72IVioLxPVRwqLZ
 ++wbkiyRSPJatgNQMviR6MhIlcYGf/cqX1w6rNlEfkUP/zd5/Eze6hCF1pE5HzoMd+z1
 SjqA6KleITJpMSfw2772up/sMzWvFxraUZSokCdOoZmlf7o+xKzeEPZbVvVO5B/Xa0kJ
 MiloCSQ+YHs/E/el9Hran9rHQl9WJd/iq7PI/I8KdvtrFUGzKPR60oK0XRTx+iCTnl0Z
 hHZg==
X-Gm-Message-State: AOJu0YwxfXPhInzjqjvJRMG1n8WAA7ACTK6GTZJZe8WK6sQ2QyM6oS25
 UwKIsS/ZdFjh/BRp1BxGcU9Cpo9gPXpUaAsnRqNcbd/VCteOv3YOrRTamChwuinvMzvxxVhiU66
 A3ur7
X-Gm-Gg: ASbGncs7EwVHd56PKkPXDong6Fu+nWb3XzuOnYmpjfxKcuctvmd0WyeXUZKJJYZlQuB
 +wDebJOx40s7vyY+JLZarHOezXm4eG4lY4am4/kpIh+jNhJwFlyoKgCNjtJXevT7wd40uaVPkjf
 x/q70EBNs3MegdP8BYDkEiTlPLK6mBS526wwedIToVND9Zhrep/hRIV99+qtX1zEr06ayMKXGVj
 Z/M+CFRE2e7j5utUfjqizKVm/AEELr/5efqGz6dRRyVsv0S+sywFtyjpuBTVEp43zsFCcYmJYEL
 BCQYFEA+jOrUe9uqdvuhLb+O7nxBQoH/1T5zztDabuTVvyOIg9cwl/GJHyho60+w53bgQA==
X-Google-Smtp-Source: AGHT+IElBo4OoHFNaGAyC41wr6xK18aqr8A0gbUXLCmaGfKhoAYEsQ5K6xRie5xOZ74D1SppevXuhQ==
X-Received: by 2002:a17:907:7ea8:b0:ade:bf32:b05a with SMTP id
 a640c23a62f3a-adec4cfe2fbmr309508266b.0.1749820936667; 
 Fri, 13 Jun 2025 06:22:16 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec8158cc8sm129263366b.1.2025.06.13.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:22:16 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:41 +0200
Subject: [PATCH v2 21/22] configs: am62ax_evm_r5: Enable IODDR resume support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-21-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=624; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kh9cdx4rlesuW/3Ibe/be4eC7uZY3ZAwwnIb4cKx+W0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1efNstI3vz6sqTMoYa25kbfL4Avjnq6QiBnBZ9YvF
 nlxpFano5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACZS0MjI8Kj/s2NqTfaDgw0z
 /X9sqbvTl2Audn7hps3TBB+/VXxaupzhn5UN9yaGv0G105df3Pj6+wNPDmmtaG1m139Rf6RkVZ6
 JcgAA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Enable K3_IODDR to enable support to resume from DDR after exiting
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 configs/am62ax_evm_r5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 4ea551b509bdff2541453046a54b2dc87720d08b..c57cff530089b2f4ca1db1e298259f64416eb9fe 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -105,3 +105,4 @@ CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
 CONFIG_LIB_RATIONAL=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_K3_IODDR=y

-- 
2.49.0

