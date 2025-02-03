Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE2EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06AD0801BE;
	Mon,  3 Feb 2025 18:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gDoxNTIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3D5800D7; Mon,  3 Feb 2025 17:10:18 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F2A80079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so4868169e87.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738599015; x=1739203815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e+o2qUxbg4y1z+9J7/E5nu4K+4Z+Ug9GIUstLjs8PJY=;
 b=gDoxNTIrNXfOWk7V6uwJ3aRJ18MqRwNY+PF25TcIt+Q8akVvhtdlG/KCdwnrBXPks7
 LjFsF06/bW34T6wQQX4oF1xpimF3dEOz2jMVcRuJPpTdyY3e/TU2kOLbLCdhP3yi7vKW
 x7EpHCLoefW+zoubTqpNNq4Gla/7K1bD0kmnfDXiPBtUXhcnIf8UfKgXfx9MUDdOOSAC
 8129UV9AQKp0j1UnaRhAEt54oiA/vdO3f3Jz5edXbJzmoq+nGsmgbMfE3HihdgsLW1jw
 LdK4ukRYn381FrgKHBkmRC+J6F5zTESohclvsBJCa5JLO4HAfJBM0Zn/QmWC4KLVjwX7
 23jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738599015; x=1739203815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+o2qUxbg4y1z+9J7/E5nu4K+4Z+Ug9GIUstLjs8PJY=;
 b=WG8o5WoZv5ae7oro9YtSJwb3e6Xuki284O75IVxsPbsgpm2IKF+d6VRi27EGG/qMXN
 MRhwxUbGMZ0K3oDy+r5au1ZoUFIrscj7/tLYGcRaYasZMgyMzJvlthQajIPsUliYtWKm
 5qBwHuzLEOB0p13iToDQpTOMZOZyM/+b/xuDrnmuofCDIiasc6TtVxLSrUxqguUBt9dY
 Wuhbp3FbWLoqVPwCIrEeX7bDwxSduV/rVcaqCU2bkgTnD90guT0X7fRUdvVMhKuyBQnK
 ZP7WGfdLIOT1EOM1qtCFeWYi93qDjisCY+H+TL9CzwckUaJnHFtZg7mUq5qLZLw1wgGb
 r8Gg==
X-Gm-Message-State: AOJu0YytBdiE4r7f08kOs6LKFulpUfoPgtaZ5j0bde3liPr8PSqyYmUw
 PYFsId4Z6Lt+2ZXbOwDpzS8A/z4pgwvvZlRVXlTR9Hm4BgUe+9M140J5tg==
X-Gm-Gg: ASbGncvqdq3zD2yTJVIVEfcaiUPWz3TQVZeX61YHtNu0KCMYk1048vO1ghEQ12B22Yt
 wO2nEg3kMihiSTnR/vOjz0xO4OaHjRmMeSQgRZ52eLPcg54X/HbSWGujmOk4Wwok6bREmzu2xpF
 7Kseddmk8TmF9UZ7XbwLW9ncKXrGtNLE848b4cw/0yVVHHN4P7dnOTxBhufvpwbPen1tt5nPL58
 tJXdcl6WssH60CL7FJlFRMKH83YvC0rFkrm8gouKoGBe+sfl1HcBcSwT8bjeuPb8pWk/2FY0V9L
 VsK6jwjyEziWQZEq4sQOs/U=
X-Google-Smtp-Source: AGHT+IGbN6wmRxSvPksav3zlP/lUjDjhqodd0YAWRRbnEkmu22UjK+l0Oy5QrHDpeFpMA5QvDS9Fww==
X-Received: by 2002:a19:f519:0:b0:542:215f:e615 with SMTP id
 2adb3069b0e04-543ea3d57d2mr5363875e87.16.1738599015244; 
 Mon, 03 Feb 2025 08:10:15 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebebeda2sm1338559e87.247.2025.02.03.08.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 08:10:14 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: image-host: Fix potential memory leaks
Date: Mon,  3 Feb 2025 19:10:12 +0300
Message-Id: <20250203161012.4022394-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Feb 2025 18:29:30 +0100
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

For a variable `info.name` memory is allocated when calling the 
`fit_image_setup_sig` function and is lost when the error code is returned.

The situation is similar for the `region_prop` variable, 
the memory for which is allocated by calling the function `fit_config_get_regions`.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/image-host.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 84095d760c..8d1f6b209e 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -237,10 +237,13 @@ static int fit_image_process_sig(const char *keydir, const char *keyfile,
 	uint value_len;
 	int ret;
 
-	if (fit_image_setup_sig(&info, keydir, keyfile, fit, image_name,
+	ret = fit_image_setup_sig(&info, keydir, keyfile, fit, image_name,
 				noffset, require_keys ? "image" : NULL,
-				engine_id, algo_name))
+				engine_id, algo_name);
+	if (ret) {
+		free(info.name);
 		return -1;
+	}
 
 	node_name = fit_get_name(fit, noffset, NULL);
 	region.data = data;
@@ -1058,15 +1061,22 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	int ret;
 
 	node_name = fit_get_name(fit, noffset, NULL);
-	if (fit_config_get_regions(fit, conf_noffset, noffset, &region,
+	ret = fit_config_get_regions(fit, conf_noffset, noffset, &region,
 				   &region_count, &region_prop,
-				   &region_proplen))
+				   &region_proplen);
+	if (ret) {
+		free(region_prop);
 		return -1;
+	}
 
-	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
+	ret = fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
 				require_keys ? "conf" : NULL, engine_id,
-				algo_name))
+				algo_name);
+	if (ret) {
+		free(region_prop);
+		free(info.name);
 		return -1;
+	}
 
 	ret = info.crypto->sign(&info, region, region_count, &value,
 				&value_len);
-- 
2.34.1

