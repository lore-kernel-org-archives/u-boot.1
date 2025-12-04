Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E00ED1F9DE
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F90B840AB;
	Thu,  4 Dec 2025 13:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OD0loGPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C578401A; Thu,  4 Dec 2025 11:26:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A995D83AEF
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b79d6a70fc8so112996366b.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764843996; x=1765448796;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rLPkWuZ7woBE30mQUM4gZPzsYQd3eTEaneYoZMu/N5E=;
 b=OD0loGPRNzia7a/sleldx1omNQ3q+OepTCvwcTCycNUIiTSd4XNTgN02iXRkCp2ZDf
 6Y/YSkdeFx2IfE7l0glHCYHBt6Jyeo2QiSKuTQZnn3XVR5m3sw/U6krk9dcxI3SbYjWO
 12kjoPVTXNK8+aMIfYYO/Uw1m1grpK6IRAJARuU5o4wM54hT+SNsq6EFfKLCvADd8Zqn
 oZkRaGNl1sXQ6T4UMeitGTuReW4cGpR6FseEKLVAQ6LZlvTcLzZut0b1r721Y0kZVyAp
 3vQWy9KV+b7kcsbJm1K3uN8m9LnmkD9kfgDOhfsIiO8EwuKPUuMfggYUGbsE2d0Lttuw
 7GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764843996; x=1765448796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rLPkWuZ7woBE30mQUM4gZPzsYQd3eTEaneYoZMu/N5E=;
 b=AqvIi1FAGLifEnPyfhHe2LfQRN2x4mP0zTFszZaz+LmxOGn7+8sZiNI9Qq+wAKRgei
 J7WtMWLTYA7SBSIIOIvbztx5CcXmiWdhNkOE6yRQ/PNz5Z3xAz29JBdiQ/pg4Nd/MyWv
 1avYVAGvrzznEFafXOFafIMy9TpWTNbNtEsQAydQpdlpicNSCpLPD4thChJNEg7UlBmi
 LC34Tgq1fyi52V7WQifbji/kd+gy3OrVa0lRprgK8/6nwc7r08YyWw/DF91cGs9GGOVX
 Pcu7qYr88q9tqPH8vXaPciivOU6Reymm/vr3PKzVrRFCGfwfpqWgVK7TJPKTRRD+5eA6
 QHUg==
X-Gm-Message-State: AOJu0Yz/FiVqg/JmapUMoDTDGB9hwDsnoOgBIW6P4rj8NP/68FCbq83m
 +/0lobKtOJRZxDWVWj3gKO5tNtm4HUA1uK2qK+uuQW3FUXbmkWj0jRFgAi9ivlDHeyY=
X-Gm-Gg: ASbGncvj9SFNNRP5+yR9VpBLq5X0ak5gg71OAQhjXZeyF2AoC/YyXj3eUurXeARKjtG
 ofhcojeWqFL4lm2AEXSgLFnIRZlChXT6DEvYacmoT62Hl2bsN+kp73wq+zvoR2emtbQqlNCcLdI
 17YewE/ff3LnEL1xVvH4vo91x2sxlhepuxp0cUYQUMq0u9fECF0tEnD8iEB2NpdilwhVlkuDNvm
 vPtJOxrrMiI4dvMrQkTR97XCBe5IPS0y/y9iMctQQzdH0zW2wq69WyLwrhe5Emv/qupAz4gj2H5
 aDEROKGkEa18V6HlMQeq9hjqpYMOuTQhVs+QX6ila2esU1VpkxxlWXbPmiimkK1ZFckrnhQFjt5
 6LW3PENh8HPNapXVRm/F/taKd/7apYDD0eo2BxQvyJV6SeDHQVpq07JhYZnqiIOlXEtfelUcqH7
 3Loq5CZtuSZ0gAEY0Prg==
X-Google-Smtp-Source: AGHT+IGJoi1ADJ8UPJ0GDRK1p6KHtoVP1J8XQirnkY2ELnVYjYwignxMKlX2ICQPzFSKwZ7ki2fA7w==
X-Received: by 2002:a17:906:6a09:b0:b74:352d:6dc1 with SMTP id
 a640c23a62f3a-b79dc51b0e8mr629033666b.28.1764843996110; 
 Thu, 04 Dec 2025 02:26:36 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4975c56sm89404166b.33.2025.12.04.02.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:35 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:39 +0100
Subject: [PATCH v3 3/9] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-3-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=msp@baylibre.com;
 h=from:subject:message-id; bh=NS4VmbDlvO+5vP+l2cBC+eAVMEkMdzOSJOuEMdMjO0k=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxK3/mirlFVWEj4hEsK6+0rkvOEl5TkeWb+UHqTib+
 KMsU3U6SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCJ75zMyTHkgpqimwjZ/Vdmc
 vAzNSwc+blklfi324SPXYz82fn74M5jhf5FV/6zqjqdhG83uPSli3Cxj8W1C3N/lM9M/PLjXva7
 9MgcA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Enable vidconsole for the am335x-evm board.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 include/configs/am335x_evm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index d2164b41d6d6e74c7da0554b966ad5ee1f78e8b2..babf065bc3ea8c63f562ecfb07080f471b489fcb 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -83,6 +83,8 @@
 	"fdtfile=undefined\0" \
 	"finduuid=part uuid mmc 0:2 uuid\0" \
 	"console=ttyO0,115200n8\0" \
+	"stdout=serial,vidconsole\0" \
+	"stderr=serial,vidconsole\0" \
 	"partitions=" \
 		"uuid_disk=${uuid_gpt_disk};" \
 		"name=bootloader,start=384K,size=1792K," \

-- 
2.51.0

