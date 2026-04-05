Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4BBE9D812
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1F284105;
	Sun,  5 Apr 2026 22:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QZUTlIiU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F1783C5E; Sun,  5 Apr 2026 21:59:31 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F91807C0
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 21:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simons.philippe@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66e6d9610d8so2261576a12.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775419168; x=1776023968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aZAwkmDl6amBZHDrp46ZQo2/Wpd2Y1GdD0aEUJKGS2Q=;
 b=QZUTlIiUtQrB4jmg7I9xkNIej9YTPtpiNeDyODJcPdmRHkBUfH8lAYXLxMrbw6XsDk
 zdBmaDLFsp5qippJMmwAoCsFxhD61H2Wwb+jRrSfK19naVAZKYjUhUiXFxmCuzGJrZdh
 pIDpFdjgR4C+oqOThWWWRR4/dPM49ZX2j+LEuGQMrY9KYCmj3ftFb/q27R6HgVEkatIV
 K1rmRG9nzCaAcusBLs5VnGJkqniYdP6hM7nzdi5wDaaVMYzi/nWl2aI2Yft1BkpsTb3T
 oe9igCk+PAhFRJX0/72EpIV95sGYD0XvpZhvMXVx/AVUVOCjDBWtv11oP9+id8dnY6rK
 3odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775419168; x=1776023968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZAwkmDl6amBZHDrp46ZQo2/Wpd2Y1GdD0aEUJKGS2Q=;
 b=a5TcvidzUvkhjmlxdF16rL7so42LcQiuy0+tBXE8/Bt/TIXlr8UfZKiguxKrCt1/hy
 Uk8VvjJJu7KIJQWo0ZOJ1ynkKW+1wan9Jrl+fq88arOoNXBOIRQiA73od4a3A2tS3E7B
 8agkeGr0NF6vWeNcky3MEvNOa3q0x59yf6KNRF1OJym7oqkrhfpPb34hUMrVDSfPaR1s
 0jIyN0EtYoc9ZhpfRSMS8xeXn8Fw8hB7d+LfpHr547oyJXXbxbwLmjDQXK/s/lHfDAy/
 8onexKpmDrW2CZ6c8mSfCq4DrtVDTJ6F1csKUd1wyVcKyukhMq0S5gntQjFMA9S31vDG
 848Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3fyS2xrHtbO6xJvuv7trpgtGgqNm2WB55mKT8kVkbzCcLr3ZzrT+2SdX3MDNH2HJyaYgUPV8=@lists.denx.de
X-Gm-Message-State: AOJu0YzBKFXnucQB1RbQu1wNwordD97FhfC0Ug2L+KtYnJqTIeHVGkw7
 qGGhHrHNONXppDCLg/NKOUjegwi8aE/urxx/eJjxpqfNXTUkO2llyprH
X-Gm-Gg: AeBDievlbjj7jOW5k1bhOGFC2VK7BuztsqeSafjtyWFzg1fCHMtOnYJfyQARsm8yBzx
 whUjuU9jqIUz+FEw1nreAiV2SglqyaCm7W+/zxBsdTWm2T/FiEUyv3CorHGNb0m7D4Gy1FIlE32
 /KyyhanOYhLHgYiDNqRNut+ogvLZHlcjpMDBWQygIG0qSW8h1u0SaYLmldabJUpSJ5QttMWCVlO
 u7WQJiXtvdIBL3nEj/ddgnzE2AqAOJhNK55yXcXtbqzfGgC1XLsz/QxeQUaVjRD+zNoM18nXIHM
 /vq45JjuQtnLZQNt9VPwTxp9vQNQ0IenY/SyiGV5xUXZxW0w8+1xuW6oHC8sILI9NidOqYy3VTq
 nRH0RzEIOjA9bHemdL6/f3rvigKu30vu8Ad04GIexIQSJeAPNipCkguFhKQnyIykUadTm8vpVKS
 LCmm55cMSuVTgrNYkypaRf002kqRa3dxo++KKyGBZ/qdrkssvAWTSQd82ep9QVzNWOEumbUY408
 NvrRjt8Vg==
X-Received: by 2002:a17:907:6184:b0:b9c:116e:eea1 with SMTP id
 a640c23a62f3a-b9c67927218mr316330866b.36.1775419168282; 
 Sun, 05 Apr 2026 12:59:28 -0700 (PDT)
Received: from bob-linux.lan (113.73-65-87.adsl-dyn.isp.belgacom.be.
 [87.65.73.113]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97209csm421157066b.12.2026.04.05.12.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 12:59:27 -0700 (PDT)
From: Philippe Simons <simons.philippe@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Cody Eksal <masterr3c0rd@epochal.quest>,
 Philippe Simons <simons.philippe@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/2] Fix LPDDR3 H616 TPR6 parsing
Date: Sun,  5 Apr 2026 21:59:25 +0200
Message-ID: <20260405195927.2837914-1-simons.philippe@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:20 +0200
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

Vendor TPR6 parameter is currently incorrectly parsed in H616 dram code.
Fix that and adjust Kconfig default value accordingly.

Philippe Simons (2):
  sunxi: H616: dram: fix LPDDR3 TPR6 parsing
  sunxi: fix DRAM_SUNXI_TPR6 default value

 arch/arm/mach-sunxi/Kconfig            | 2 +-
 arch/arm/mach-sunxi/dram_sun50i_h616.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.53.0

