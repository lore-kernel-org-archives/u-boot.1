Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE28CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FBF86E29;
	Thu, 12 Oct 2023 03:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H0aDHTLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B69580422; Thu, 12 Oct 2023 03:57:15 +0200 (CEST)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F8186DD9
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-49ab0641e77so180813e0c.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075794; x=1697680594; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XD7DLONNYdZgFVBf1518puCx11kL7h9mKg+F6CpzGpo=;
 b=H0aDHTLNuerkhaeYVAA20Yd8t39FLz9H1BL+7+9vNBMK+ggIibKwS/6znK31r/cRf5
 685rrBBQr6uHtuOiP9WV/UW9go0tUfmxl2PCyQeT1vNIcdKK4H0O+FrHLHN7jOdxFtqd
 VqCqs+utNHgFP8ZPL2rCeL0RBhk6pf4hrFHwFGMY4ZnjQAmeCsu9piBI3yWcXbXcR0hE
 uX4EeA5sXJUc45GsYsZ3p0fmAv8bQYdFleSVdOY4t8Frr6mVQuN5DF42f9hrnJBtRCJX
 QxYtYh8Vth1x5rzcVoac/L5DWO4qgJs0jUDc2toRAlLEgBhlqn5Xafc6bDfoORdouzXu
 319Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075794; x=1697680594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XD7DLONNYdZgFVBf1518puCx11kL7h9mKg+F6CpzGpo=;
 b=SKdJLQ3vi+DBlQQYncLwAFNbaW9I9Ameiv2FaTwyYvZus2HKm04G/QnaBjWpv1PI58
 P8vnd05+BQuWIk2svok2iyxqCRMCaaBd8KTUqqU4O07etquYk2SUoZWViUle4h78L15a
 Z3BJ65r02BtOtIdVEFrSRxeLS3SdY9HQjiWkH/9dQUvFseF4T0RfVW8fS+wwIdRBeJXX
 jvI5WV6uxUba8bEqGRK9SiguHZQXOn+rcuModVoBNF9W53je0xE+5Qm+98JQuLwF7r2m
 A0029D6gAgzGW+A1k83uQRMjpigFwVR0d9Y1nXodRZez8RRBXfw0KvOMv7+q/hOPiA6O
 EASw==
X-Gm-Message-State: AOJu0YybB4+rmDJWVOD7mwRrAlGOY/zroZIhSUov9IUlxXrd4xyVKbGw
 muLo4QRPoq3Bdc2IHqNDu2MofPVTtcGMww==
X-Google-Smtp-Source: AGHT+IH2qaKOM0hC+vY4pqCtsU1Do87hLwi9UQqTmljBtXXvuESCBxGeDTj/HA8c4Ozw55D1XACcJQ==
X-Received: by 2002:a1f:ebc4:0:b0:49d:c216:8736 with SMTP id
 j187-20020a1febc4000000b0049dc2168736mr19827110vkh.3.1697075794560; 
 Wed, 11 Oct 2023 18:56:34 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 19-20020a05620a06d300b0076f18be9a64sm5661802qky.81.2023.10.11.18.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:34 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Nitin Garg <nitin.garg@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 05/26] arm: imx: Add newlines after error messages
Date: Wed, 11 Oct 2023 21:56:05 -0400
Message-Id: <20231012015626.3487451-6-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These error messages are missing newlines. Add them.

Fixes: 6e81ca220e0 ("imx: parse-container: Use malloc for container processing")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/arm/mach-imx/parse-container.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/parse-container.c b/arch/arm/mach-imx/parse-container.c
index d7275a58c17..c5df78d1c58 100644
--- a/arch/arm/mach-imx/parse-container.c
+++ b/arch/arm/mach-imx/parse-container.c
@@ -85,13 +85,13 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	}
 
 	if (container->tag != 0x87 && container->version != 0x0) {
-		printf("Wrong container header");
+		printf("Wrong container header\n");
 		ret = -ENOENT;
 		goto end;
 	}
 
 	if (!container->num_images) {
-		printf("Wrong container, no image found");
+		printf("Wrong container, no image found\n");
 		ret = -ENOENT;
 		goto end;
 	}
-- 
2.37.1

