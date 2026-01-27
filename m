Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB1AD340BB
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD0884154;
	Tue, 27 Jan 2026 17:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SftFKkmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9E084178; Tue, 27 Jan 2026 17:51:13 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DD284158
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so66995255e9.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532670; x=1770137470;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rLPkWuZ7woBE30mQUM4gZPzsYQd3eTEaneYoZMu/N5E=;
 b=SftFKkmOYIX4uvQ92Y+siD22f14e4uBiMcSDhr4coE8dXzeUwW0jne+UH30IfovO9b
 2CafCaoS18yjmCcUxN3b+AJWEoCGG7Npmj3M1KMm+vLAv/FDZEdH0NZHB7QaH/rVgA8n
 yhRsb+U7NASuWytqRf+qC/sO8+FROagBlT7NW1TH1/5NfcGBJK/nrfscs82F9ubnA3ce
 FLZAHBeuo5hvv7QibhiV8fkbRo96l8gD61OxeBXr5gDN5BHu6r+KwERGio5eyfmQMf7o
 hGkKuVETB+vg2NL8tPBoKLBLXuJC+VKsCnUbc1qOtDyEC/J+Z4g/Q8tHMIr1aWxrnyS0
 OJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532670; x=1770137470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rLPkWuZ7woBE30mQUM4gZPzsYQd3eTEaneYoZMu/N5E=;
 b=n9p/MMqUyD/wzK6NixeaPIMWN9YdjWSYX5FHfaIJrxD6W5rjAsl8iC66EzGB6vV7/t
 excxZlrjh0MoSo505Rj5Yal5+SN3BXRiRDpGdCwCH8jHbSj1efxt+TGKJr2bm/X9iVNM
 KoqFaBEwRl/3GSqiWavOSpOSoAcmeSPEoEAMRdO+GiA0YnNlFFuhjgYixN4+DWFaIDgF
 H5troXQMhWbhAZTOWVr2TkNQNhbGzVZI6kIXUJPx0nvPyN/9II1WDSmBMnP+a2AjgJGN
 PuQPXNNE5RtML4P6lt22X5KJA4nc9K7RO7j5sVsCF0XxGJsDwIZyIZZC1c3AV3/rQtww
 tEUQ==
X-Gm-Message-State: AOJu0YxnI5u9Mo1lLbZkSfETHdJ4CWWYSQl7j+Pt1bEHP6SdpVfDiSRi
 Rv9SK8a+JaGK8vENbg0NqJYaH3oWRickzUpNJNsW5uydSYkC1taa2MX/OIr/zrZVUmk=
X-Gm-Gg: AZuq6aJwwVqcVO6Bh8qREopezC9rHZz4m/WBmHCTv/cecb2gsX1Xpzc0c73kqgR9yXu
 OOIrJrzOGX/nRC2R/OstY5Y4g+zeNwicsl25Vil5xWOca18BRBc9V59d+0Rx5xsLkdDA/satLqa
 JFkFjlT8JkpgpPI5BaANwSqTR52vPsRUWWHURfHg5BESFIJ4U5NlW3vmvU/MpvIS+doEQb6MP7J
 B+s/oGxH698R6MKX5m8BCLh16qBfzYtLsiCrOAAW/CKvMKBniU4WHaoMq1OJbFRxbAGJoAWdqpS
 8evgYJx/bVzbpcuRzMK9rpnheC9lYGCE/lSWOij+pqSoCp02Eue3hwQ63cQKzlHPNfZn4iK/Nyp
 i+LJ6jqZWRopRR0ynXQF7hHZmuYOgvrlZVsYSw55Md3AhTEzl1dDcT42Sd3uUFJgaza7HpG2kFt
 QW/QVGLTOF
X-Received: by 2002:a05:600c:1909:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-48069c793a2mr32833095e9.32.1769532670179; 
 Tue, 27 Jan 2026 08:51:10 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm3728925e9.11.2026.01.27.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:09 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:17 +0100
Subject: [PATCH v4 03/10] include: configs: am335x_evm: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-3-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN3t423dV5IQ01uysXKg0/3HdnemrbAwWrAve3j9v8
 ddyj86ajlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIRDmG/747lp9ROBSZ+mVF
 q/I2sTndihltU+Mt135VXxFct+zb+heMDF3zttpGy3xiv/3I5/7vJ0olq07M8v7FkM8v57zjyAy
 3dg4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

