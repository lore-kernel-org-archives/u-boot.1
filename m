Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D4C0219B
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98BDE801BE;
	Fri,  7 Feb 2025 18:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="b3wAEape";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2239800B3; Fri,  7 Feb 2025 18:23:53 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98B5807D9
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 237C93FE74
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738949027;
 bh=KWZ8D779wI639451F/sY/RxJcIRJEDuH/EPOSJN9f8k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=b3wAEapeVBKONPw4s3nx1/0KmKxSfpEAOhq9g0vJRBXr0hVdKPpzTH2aR8O2BQJhB
 F1WEK67z9Z/XohQQG7ea0NAAgi5+nfSdfJx+Alz7svuPCbz2eSh/HBjj2T8cdq0cvW
 lnSVpv7z/JhS/2KCs6oiwT6SbMjDY0nLf6qAatyrzzGf5v/RtbhpnxBx1aqpK1gFwD
 rWLSCuVKqtTWdGrRrVF+xVdDvZmlmYR/P4fGBjYUzoM1c2RF/cf/HHuBB7y1PF5/Jc
 57rqw+0oupmjYXRNq05IAQpO0bsxNRdDrYatDlRIJY9/sbzhQNG7JY5ViLXDF1kmZq
 8hk2m/whzn2wA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5dcee17a6a5so2796760a12.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948926; x=1739553726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWZ8D779wI639451F/sY/RxJcIRJEDuH/EPOSJN9f8k=;
 b=EeiVZP6p0PQd/PothgbQdJQzY4T61u3t9kB67MDC/3t62g3yeUk9kQsXSueb/W6fZY
 O43JJI1dNKM6vpMNf9aBbl7LNI/CM6L6Zi/B9by9MurxiT9bAcMve9pGP9fKL7ojv72H
 /jY5I8q4IwM6HK8J7AZOP35Xf5TQx0IBoZYZbOONfH/E5IpRrQP4TBG+yJonLiTEVo1n
 wasFKrQNblKgx1fsg2ovj07seiUdXXTesT6J9Ewehi8Pc3QN9hH9PnvP9khx5pnqMLLg
 T7sVkkKopqRxvfqQ/oIIDOWi6F97V93EWGc6xY1T206bgrrTy2cc0Nrjvdas47fvPK+W
 vAGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXAHKpfjRpxoB1PiSHEqLW0HkRQQ6A1UatRG5pYWBqbKRxRclJT7uSkyLersEn3Z/nh5uPaYI=@lists.denx.de
X-Gm-Message-State: AOJu0YyUj8dekBfKV1LgunIsvBDIXhjSc/CHuf25x9rr3br8Ql3VuIcW
 aqJ4phc8SfNOEA0qbiYmgrfOi5Yqi5vW0TBwswpnsWAlOC1TV9IkyfumkiFM2/D9ts+ocE0UbaJ
 sQll5XZ61Z90C7lqi3ybHUjvub3G/zhdfwUM2HJBoJqipVlzjbm4H0P5XwjpzXy7wSEw=
X-Gm-Gg: ASbGncta8QfyzijgNArotBQ0JeR6fkQUwy65wk9kWsy2Foa9OfIv3Fp7j2MbpnwcVOE
 +YmuiU/UxJz0qr0upvzr5EEPKb4Vzsv978AxqhNkXzYu1teKEN3GCNAUDCd6l5zqf2CDxB+1AY+
 Qjs+0abOibcU7fHGjl1dJNZt84wM5+lfTj+FiScFwGc/Sf90bpjCz3450zvN+RJDDfCmDFcTZh6
 LkXwyzZczerDbMnE5TitQfLhXJvyubK9Q0o4mYOVXSWkYtEkGSgElmKOqeHgForJMFLEprfSXcl
 r5YJYgSX6LdgkLRIClOhK5dah2C8WEL/kN++v1yZJI8qd263qFaMVJxcjwNY5JPYdhG511AST9/
 ZaG4UgoY=
X-Received: by 2002:a05:6402:5209:b0:5dc:8b8b:3517 with SMTP id
 4fb4d7f45d1cf-5de4507086emr4199608a12.17.1738948925711; 
 Fri, 07 Feb 2025 09:22:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzknBADzl/+PVSvDD7tmtCS94PBoRmiRL1vn25DKODaxIUGMR3vdrTmqMhBJguzxrar96Q+w==
X-Received: by 2002:a05:6402:5209:b0:5dc:8b8b:3517 with SMTP id
 4fb4d7f45d1cf-5de4507086emr4199571a12.17.1738948925299; 
 Fri, 07 Feb 2025 09:22:05 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:22:04 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/6] board: starfive: DeepComputing FML13V01 fdt selection
Date: Fri,  7 Feb 2025 18:21:14 +0100
Message-ID: <20250207172116.117749-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

We support all JH7110 boards with starfive_visionfive2_defconfig.
The relevant device-tree is selected at runtime based on EEPROM data.

Support setting $fdtfile to the file name of the DeepComputing Framework
motherboard (FML13V01) device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 3940d45b13f..55daf730c81 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -17,6 +17,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_FML13V01 \
+	"starfive/jh7110-deepcomputing-fml13v01.dtb"
 #define FDTFILE_MILK_V_MARS \
 	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_MILK_V_MARS_CM \
@@ -67,7 +69,9 @@ static void set_fdtfile(void)
 		log_err("Can't read EEPROM\n");
 		return;
 	}
-	if (!strncmp(product_id, "MARC", 4)) {
+	if (!strncmp(product_id, "FML13V01", 8)) {
+		fdtfile = FDTFILE_FML13V01;
+	} else if (!strncmp(product_id, "MARC", 4)) {
 		if (get_mmc_size_from_eeprom())
 			fdtfile = FDTFILE_MILK_V_MARS_CM;
 		else
-- 
2.47.1

