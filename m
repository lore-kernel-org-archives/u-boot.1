Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A896CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4959828A2;
	Thu,  2 Oct 2025 13:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="D2JszD0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B8C83526; Thu,  2 Oct 2025 13:36:01 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A13C81D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so165219566b.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759404958; x=1760009758; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6lJxSpESy6JDYPwqTeDnX7AVbjyAAv1XK2qTf5VqmTw=;
 b=D2JszD0Z0HaYoDTNVE5AK6X+98lo/PNRYXcarDX1D3nUCT9acX2e+v/pxNKpHwpUY5
 Be5GOMXAyrIxidse6zvK3xRCuuBcgWS0YClBGPdjYcB3T5OJykjREcF/Egwp//JhUed8
 ONjQdFPZvL25Am81cg3D4z7ghkpLRBVz3yHTatVSX7fJuubtUGg9eoy43ZOeyWyesYT7
 8rEecWmrtoSnXKWiT8Kp6YCRtiS960cmVeftGZGqN9f7WA1vqgtXTqwo3Ex2f/ZItG8j
 GKMAcgJ9ltMWsDCMCWJ8I2kC1fspY/tZ+AL1J5Ul9vNaZRRM6JQGah08ZaqEsrY8qLkM
 r5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404958; x=1760009758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6lJxSpESy6JDYPwqTeDnX7AVbjyAAv1XK2qTf5VqmTw=;
 b=prU7FW2O4EAcw6JAGfkxNdGla8vPlJWUDkuXSqQE2/pQAAs/FGau2bn4l8oBDUmsgE
 SXIGmL3kh2Qt1uoz8ruc9m3/itF4twdhU6f5m3dPY8W4fq/h98wJRSYXpu9eEwmRWqEq
 xWhfhDAYglV9pXtmwOnbdI6cA2MsZvT+PbM2oNOWG8MB/MXWBMLGHHIVciVrVP+SMKPm
 5uJh53GF0NTYRN51Ou3WYIPEOJga7NCw8t6n1cVpi4mxu9ETjfXObGW9Jq5MmT5ThFaK
 3FbvpvA1UfEPeNpraH30TZCm0n15tL2QVqO9D9SLn906D2SROMeioYRGxs4Jd82hEzeM
 Kq4g==
X-Gm-Message-State: AOJu0Yzzta7zukpAhd+1qZJiu++zsle0VMeluSzumhKGwZm+etkGM12/
 VdhHDzzfpRnekCgpCul8He3E9l7tEXOlfyf9liEaUnd65pEPxsJ58YpCInVaRw==
X-Gm-Gg: ASbGncv2+cvfS5dY9dvPcwC5M8yycwUeB74oN2N7xeMX1wwpQet4SWOiDBo6mmkStz/
 l7YqAZHu61QfyscFBTtl9gTrM/DinRQFE4JF8ZHubsiK85gqDj0zJ8VEN9s2W3aEMGvLFtXFG+X
 hXVucudHmuhVWjG/VqGOcKJC/+Rpxi/AolH8U1sZjywXtzOGHO3w6o4Uh1rlJMVnDsrk/r2sLNI
 9XB5EkOlRpYKviViTH5+hqxQsObt1fF3Cmyx6mzGeHTN+8YMVyeEL39+NCzN9eejdUUfS6XHnsf
 4Oa+ieJlKFBYfTMoy63IdJo4x0FCRig1hxucEjlsZmm4fgi0NSOGAN2qP28ZYtic1AzeJfGDHIW
 DP1Tz7IhwsAunZmfTTx09OtxXkmP8vtVZpQHmnjlcOpdPwIW8Q8HK1JTIEdKaTSe6qIJLTBryoe
 dj0pDJ6DrT8i71bLwNOIWR4WLJNlQ=
X-Google-Smtp-Source: AGHT+IHvRXhpcE6Lmy8NcfI4BJ4rqdbguNjxQlXXn0NwqlOVZgWvvrb6uw5WAialuMrhdqtp5deZbw==
X-Received: by 2002:a17:907:3d03:b0:b3d:c47c:7ce9 with SMTP id
 a640c23a62f3a-b46e95759d8mr1002400166b.54.1759404957675; 
 Thu, 02 Oct 2025 04:35:57 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4865a7c660sm185034966b.22.2025.10.02.04.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:35:57 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ansuelsmth@gmail.com,
 hs@nabladev.com, Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] ubi: extend support for LED activity
Date: Thu,  2 Oct 2025 13:35:50 +0200
Message-Id: <20251002113550.2803053-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

Add LED activity for ubi_dev_scan() and ubi_volume_read() routines.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 cmd/ubi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 56d7da82629..93de6f3aea2 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -549,6 +549,7 @@ int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
 	}
 	len = size > tbuf_size ? tbuf_size : size;
 
+	led_activity_blink();
 	tmp = offp;
 	off = do_div(tmp, vol->usable_leb_size);
 	lnum = tmp;
@@ -582,6 +583,7 @@ int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
 		env_set_hex("filesize", len_read);
 
 	free(tbuf);
+	led_activity_off();
 	return err;
 }
 
@@ -600,7 +602,9 @@ static int ubi_dev_scan(struct mtd_info *info, const char *vid_header_offset)
 	if (err)
 		return -err;
 
+	led_activity_blink();
 	err = ubi_init();
+	led_activity_off();
 	if (err)
 		return -err;
 
-- 
2.34.1

