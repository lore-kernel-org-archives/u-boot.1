Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A27AE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:27:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10B6893D1;
	Sat,  7 Dec 2024 18:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TBJKwcLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F3389323; Sat,  7 Dec 2024 18:26:29 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4D9894A7
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-841a9c504d4so214356739f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592383; x=1734197183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqj2YVVu9L1AkthObNEdMZy2vUhvoT4ahnmRMzhQ574=;
 b=TBJKwcLXDukqb55qReht1cLb+ykbimBcqbGGwaUje0kHsEsePhD1buHEvmy5G2yxi9
 7dUiFqMOPSiP+n64fWrtpnl2qFGr5/iY9cVSYgnF06+/HtyY1uNWA69SvZTSA7Kt+fsC
 YxDpXVw0xc9CxI3p49/sdKqIFt4h2yeUmChAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592383; x=1734197183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqj2YVVu9L1AkthObNEdMZy2vUhvoT4ahnmRMzhQ574=;
 b=c9i3PtbT3nqyds4lFWlO6rHFwXwzADGBRcZE0FTbzG+BCkwQGhA9mqYRIPFEKyM97/
 S+wCb3fXcpVdzuL+okULQjWnL+0qDY+SN6U+Dpjfx3zqnp+fiOwQPQTiNoXC621+iuGY
 8STvTncIdSg1t66NME3/RJUrSWn9AjFED1RoOyGt8OwWxRODP3LKMFPwDNF3IF/7BTDz
 OvRXRTAnbsoxDZgZmL6sz+rbWsIDmsHuCOZ8k7wsh7/rFV99rwvgNNwUnQCZNLaO4jNx
 oWAM5+yizyVloV5p/Snr7Yvig4HT0cwiiE1gNYp02t82U/38I6wxfQH+upyTPo+9GD5n
 p2kA==
X-Gm-Message-State: AOJu0YypC0x7STAEaE5vKlDZTQ0Ca/kWVtW7yin00sEAJkFru6Cvhelz
 EfkeE92lilwjRtSu7vGYvt97XZqA99SaUg4enVAPZbtsU964/YEid6gcW9VAtIbjKzljaaDWGkQ
 =
X-Gm-Gg: ASbGncuICFylnKWmi6U7V7AwWOVqc1SCFKml92i4t1/d9PfwfTDaMDFggr49xSDOosU
 6asMAJ2+tcatRtXP5tMW1rARpaXxq7PRll7S0qR4OgpGzkgplUXCQ03BHeM+76Z7807CQQnvriJ
 nGL1+ziOcclDinTxa7crHP+bdg00YU4eBOfYP8cTgP03DRE82GjxuqTA9aqIxonXOq9YiotL75L
 qHU0TBFYZyDaXpcUAK22zac+n/V1dlefye4G+tfe6ESN5+ikzqrz0NyBW1VdBaqf1VQUJhvkRlF
 GQCmXHC/4M8=
X-Google-Smtp-Source: AGHT+IHPAqme6FFrnqDKpUVviCN5piNzdvRPajnSaBhHBDuANAFBDzls/WSzlBasqN4BZoW7Rk3wJA==
X-Received: by 2002:a05:6602:6d01:b0:837:7f69:eac2 with SMTP id
 ca18e2360f4ac-8447e1dac49mr690711539f.1.1733592383392; 
 Sat, 07 Dec 2024 09:26:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/19] spl: Report a loader failure
Date: Sat,  7 Dec 2024 10:24:02 -0700
Message-Id: <20241207172412.1124558-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

If a loader returns an error code it is silently ignored. Show a message
to at least provide some feedback to the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 1ceb63daf31..7c57eb8539b 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -612,6 +612,7 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 	for (i = 0; i < count && spl_boot_list[i] != BOOT_DEVICE_NONE; i++) {
 		struct spl_image_loader *loader;
 		int bootdev = spl_boot_list[i];
+		int ret;
 
 		if (CONFIG_IS_ENABLED(SHOW_ERRORS))
 			ret = -ENXIO;
@@ -631,10 +632,13 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 					     "Unsupported Boot Device!\n");
 				}
 			}
-			if (loader &&
-				!spl_load_image(spl_image, loader)) {
-				spl_image->boot_device = bootdev;
-				return 0;
+			if (loader) {
+				ret = spl_load_image(spl_image, loader);
+				if (!ret) {
+					spl_image->boot_device = bootdev;
+					return 0;
+				}
+				printf("Error: %d\n", ret);
 			}
 		}
 	}
-- 
2.34.1

