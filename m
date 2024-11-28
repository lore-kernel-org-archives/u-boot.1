Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DF5D690EF
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 10:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9EE8987F;
	Thu, 28 Nov 2024 11:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eS18xmwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39AD189877; Thu, 28 Nov 2024 11:15:00 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 415A3894FB
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3825a721ae5so402433f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732788896; x=1733393696;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=flIiIfgV4V2w8bARC+srqswyX8PrNis02re9DIlC2Dg=;
 b=eS18xmwN3RuK7Ci//O2NWwIHrRne3300jtydfYpBePQYT9SqVtV4uT33bVyQuPYbEm
 OeER4meSriUoXegaYCXal3XhGLYqCa0hO0g0fSXarKR9zn3s0Vu82SwdnLuGP4ckT7pP
 2tWW+6kD+ezXdOZk/hD6eTlnEznsh/DPnBXla87L+9+N4jNTy8USCEJBIGe85YQnXaLt
 VGN8WhjzTUCVi5JR3skIyIOZSuEJ/FRvf30Dv7izEV56QjSNpgrfmb4KHSZdclG4LKt9
 J9xpoInkaJMqc9hfzk+7qw02uks4qOjH+RgTSfbb1se91EuBJiHWmozOywjW42+VdaJZ
 dczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732788896; x=1733393696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flIiIfgV4V2w8bARC+srqswyX8PrNis02re9DIlC2Dg=;
 b=g7OrACXhJwvuiIaXSQkLwQ3GYMMogyG/KjYxrdCEzhke+c3OY1iRIGEypDhmeEVzCi
 6IncKP3d0yasrqgS67pncbPM882gwWSgY3aJzIb0XR0OSwJuY+qOsw8ZPlbTsIRF/4Do
 PP4M+4/cJdjQg9mc9jrlzCfJxEhojv7APoIMktqlpeb9jvuWxq+T3pmEhDjyrag3CscQ
 APyNZ00y1Q0Si44944GCwMI9XG4cLZEAuc20kRG5HrGUW58gS95NnvCB6/YVaqF0YeXb
 dMnJHZbjbvfP1prFnOEnUR37wTJEyjjHunTcZncYfW6vr8GXAUUMtGC5jzglY3O8MOIU
 CW+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdGz8eDSyvAX29Ftz6IVqx2C05jaN84enNcTcc0LTQfXcOrcI8UjByQcNURL/61bfT7jgkNQQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxLrq/mvsuDN6UuTx3urECiz0DM0H78XuB68Rg3sZAlMeMeTwnr
 5CRYLFhHKSiR1ccqJFbay1l83QQL+SxKTvk38irLTS4JOU0+/QDb51KUWj33ukPJKHu9pjVXfHT
 /hw4=
X-Gm-Gg: ASbGnctr8byizHzAm1VV9CImdknX+w6fKplAh5otmYxCvcjPVgK9AJr0V5WiCd/kCex
 ERzULWlcfiVZ/9N19qbxm5EEvjR6gXVHXPIOwQ4M0BXhEQD/98JHvuiTacJ6BQs9VT2g1b9LAHm
 /YLFAPt6w3oGjmbopjnwlur5et8s3iOODwYEHB00SFjAQ468LwkQnPrqknJlifmKbDondT9LVmy
 /xc9oijWxEyQcD0NaSiurOP0lV10I6RIYq0ntp+HfMPHrbutSrcNA==
X-Google-Smtp-Source: AGHT+IFsAgEz0UQLB6v0JW4T+8Oz73Sm35+G6fDqwbRuQ1x2cE62nsx1HXLdF32ca6WFfwdYbMtnJQ==
X-Received: by 2002:a5d:6d02:0:b0:382:3ef9:dfca with SMTP id
 ffacd0b85a97d-385cbda22b4mr2069959f8f.25.1732788896314; 
 Thu, 28 Nov 2024 02:14:56 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:91a7:bd7d:8e99:8990])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74efbesm48554535e9.7.2024.11.28.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:14:55 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 28 Nov 2024 11:14:48 +0100
Subject: [PATCH 2/2] boot: android: Add bootconfig support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-bootconfig-v1-2-0e63a5dae82c@baylibre.com>
References: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
In-Reply-To: <20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

For android vendor boot image version 4 bootconfig is mandatory.[1]

In the android_image_get_ramdisk function, after copying both vendor and
boot ramdisks, we extract all androidboot.* entries from the kernel
command line. These entries are added to the bootconfig section.
We then update the sizes of the ramdisk and bootconfig.
Finally, all androidboot.* entries are removed from the kernel command
line.

[1] https://source.android.com/docs/core/architecture/partitions/vendor-boot-partitions#vendor-boot-partition-v4
Co-developed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 boot/image-android.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/boot/image-android.c b/boot/image-android.c
index 05245a0ba918..66e4c58ab4eb 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -475,6 +475,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 {
 	struct andr_image_data img_data = {0};
 	ulong ramdisk_ptr;
+	size_t ret, len = 0;
+	size_t bootconfig_size = 0;
+	char *bootargs, *androidbootarg, *end;
 
 	if (!android_image_get_data(hdr, vendor_boot_img, &img_data))
 		return -EINVAL;
@@ -510,6 +513,32 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
 			memcpy((void *)
 			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
 			       img_data.bootconfig_size);
+
+			bootargs = env_get("bootargs");
+			bootconfig_size = img_data.bootconfig_size;
+
+			while (1) {
+				androidbootarg = strstr(bootargs, "androidboot.");
+				if (!androidbootarg)
+					break;
+				end = strchr(androidbootarg, ' ');
+				*end = '\0';
+				len = strlen(androidbootarg);
+				*end = '\n'; // bootConfig are new-line terminated
+				ret = add_bootconfig_parameters(androidbootarg, len + 1,
+								ramdisk_ptr, bootconfig_size);
+				if (!ret)
+					return -EINVAL;
+				bootconfig_size += ret;
+				img_data.ramdisk_size += ret;
+				/* Erase the androidboot.* bootarg from bootargs */
+				*end = ' ';
+				memmove(androidbootarg, androidbootarg + len,
+					strlen(androidbootarg + len) + 1);
+			}
+
+			/* Save back the new commandline without androidboot. */
+			env_set("bootargs", bootargs);
 		}
 	} else {
 		/* Ramdisk can be used in-place, use current ptr */

-- 
2.34.1

