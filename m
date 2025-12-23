Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F78E6FE51
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 23:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FBA8419C;
	Wed, 24 Dec 2025 00:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e//HvisK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A96841A2; Wed, 24 Dec 2025 00:47:26 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3962984166
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 00:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so3745543fac.2
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766533643; x=1767138443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ykidpFB/r+Y7S7NJ4ReCEtWdRjPdVONcA05RkuMBRMU=;
 b=e//HvisKO4OuALkRqrSceu18l/lEiBovk9EGlNcgCkiUKWRw2HSgk1vugdh40nvHVd
 vIfKNo4QrACiQ0Ocg/k5WAg3mUWNJsHDwbC/sCRZ+wTGL62GHxzy66rjh4QF2z/0EQqn
 1wLr3jlVeMBVrrc4HkQZQp5Z3vWVxPfseFhF/IkA/ck3zZBx93BkI7Dfo3cwnPQ0rhpN
 EpoPNjk2jpLEfdpoLG7bPezia+n+LVsNKy+pHchgBVCQaAhEUlT4q0rcvDoBpdvxQQo0
 dQqpANUgvgKf+cDfNefklXsTXOFS3up00OoMihAdTUKqMWjbsgbSknpHVVwV8cSD4Mtf
 Njww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766533643; x=1767138443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykidpFB/r+Y7S7NJ4ReCEtWdRjPdVONcA05RkuMBRMU=;
 b=F50IPebeW/HvhiWNDdhiYrBA4MwSojgXJgMU2YBmrmBiZvRR/aLNviH3rKXvZjGgBb
 sVJWrbreMgrpKepC0IvLkPbEHAu6HwdMaaeTwkSUQyqsNybMcCigPFfWbUKwvi2tAcz0
 6vHvQrCyA+mnFY+xtPAULcqhYyabsMBM3aPqUHeHdNkZDdAYoKCiQHJLjUhz2363QoSH
 bFDJDxBV6LARyTbcaV8afOh5l+em9+P+/rcsDUpyoTKiMTHkWfDImHLuQpIMXXwhdNS6
 OEeKLW1uX4aANrx3oqH0pz435HuFIBXKxW7tz6PA8b0vaTJp33QJRa8eRTjRmworDbNw
 qxXA==
X-Gm-Message-State: AOJu0YzI7OwPrcsagVgjAqURJDO2wV26i+72prm4beCfrwHsME/hD4rv
 ConQUF/z7dYi1AY37vo57hnrP74bsqgtBu6Vvw0zQcgbO8eUXmlk3UScI7u5kLuh
X-Gm-Gg: AY/fxX7W9u74p3bqzxYrN7h0MkivlC3JfO1fSv9b67iNMyjli1vvKjrgT0v0mz491Ct
 4D1EUaEkw25ZXOV/aW53bMS/ibIN0T/HPwId5n1AMkefCg7oETKdCnsH6/ImpGm4jw+173e2lfA
 9tzWWN7sU+tq/ZjCQQtY6LDI22/09bazjt45PsTOUcLSmM2CvbNZbexS3+SMtX/DH8BXJkkh3Jp
 YzZLizjN1XCffl/vqqHYJ3Kauio9+Bws2k68cXHl4myewkTTq59EhJYVCyi+RKxzhxXCuewPceS
 zruTe5fhHPjhihb1SsDCFYWOSkAsWqZM6ND3Bk5svKWUeO8ZGmvHT/pzcMuzLuQmJF0BFejaIvy
 lw6HkddrC/k67VA4F0tFR6+VmVNCAJNnGQzM7Plk/t5DtPVzJtUCv6z1GbqlwbUWMIYtUz2n34p
 zF6gNDc68cHvIUQJsFerM=
X-Google-Smtp-Source: AGHT+IHTOZoYnSQEmmbHLo6sjfQyBJR5Aajfbl2ZgFLMklamkppwhSXGV5utU9P+/lhOEP85yzCV7A==
X-Received: by 2002:a4a:c388:0:b0:659:9a49:8fdb with SMTP id
 006d021491bc7-65d0ec39a5cmr4465862eaf.84.1766533642650; 
 Tue, 23 Dec 2025 15:47:22 -0800 (PST)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f69b9b0sm9388566eaf.11.2025.12.23.15.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 15:47:21 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: macromorgan@hotmail.com, mkorpershoek@kernel.org, sjg@chromium.org,
 trini@konsulko.com, jmasson@baylibre.com, nbelin@baylibre.com,
 bisson.gary@gmail.com
Subject: [PATCH] bootstd: android: Fix write outside of memory
Date: Tue, 23 Dec 2025 17:44:56 -0600
Message-ID: <20251223234456.1983614-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Chris Morgan <macromorgan@hotmail.com>

It looks like under certain circumstances when reading the vendor_boot
partition it causes my device to write outside the range of memory
available. Near as I can tell this occurs because
scan_vendor_boot_part() calls android_image_get_vendor_bootimg_size()
which calls android_vendor_boot_image_v3_v4_parse_hdr() which calls
add_trailer() which attempts to copy information to a buffer allocated
with malloc in the scan_vendor_boot_part() function. On my board the
memory set aside for malloc is at the top of the system RAM, and given
a large enough vendor boot image size this causes the write from
add_trailer() to occur outside of the system RAM (nevermind outside
of what was allocated with the malloc().

While I don't know the absolute best way to handle this, I would assume
that if we simply map the memory we want to use to where we will
eventually load the vendor_boot image that would be the most logical.

Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 boot/bootmeth_android.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 1374551dbeb..c2c25d53ef3 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -118,9 +118,10 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
-	ulong num_blks, bufsz;
+	ulong num_blks;
 	char *buf;
 	int ret;
+	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
 	if (priv->slot)
 		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
@@ -132,28 +133,19 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
 		return log_msg_ret("part info", ret);
 
 	num_blks = DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), desc->blksz);
-	bufsz = num_blks * desc->blksz;
-	buf = malloc(bufsz);
+	buf = map_sysmem(vloadaddr, 0);
 	if (!buf)
 		return log_msg_ret("buf", -ENOMEM);
 
 	ret = blk_read(blk, partition.start, num_blks, buf);
-	if (ret != num_blks) {
-		free(buf);
+	if (ret != num_blks)
 		return log_msg_ret("part read", -EIO);
-	}
 
-	if (!is_android_vendor_boot_image_header(buf)) {
-		free(buf);
+	if (!is_android_vendor_boot_image_header(buf))
 		return log_msg_ret("header", -ENOENT);
-	}
 
-	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
-		free(buf);
+	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size))
 		return log_msg_ret("get vendor bootimg size", -EINVAL);
-	}
-
-	free(buf);
 
 	return 0;
 }
-- 
2.43.0

