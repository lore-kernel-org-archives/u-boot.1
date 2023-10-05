Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5796E92FC9
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 23:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8596786D29;
	Fri,  6 Oct 2023 01:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYOvqz5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCAE86C0C; Fri,  6 Oct 2023 01:08:49 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C3786C98
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 01:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-352a27ab1aeso6526765ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696547323; x=1697152123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07Mlx/7I4oUZt5/A7bSwriKZgQwQdWy9fcTqVU/t/Do=;
 b=HYOvqz5Vw8oobWRp8fNq0lWmePDKsfHEYsqHQT0sum8UewIJ4r67fWTMc3tHQ5i8YS
 AgbAPvPmnxV3YXTT3RO9OiGq0295rfzOvfbZfud9Ci0DuUl+WeywSUhIS6xm2Yhr6YM9
 +c7zR5VM+8R2sumAkrsfpYWssVhi7Wj4Lvgx9XIiMjd1cEvL8IE/pnGlXRfYnPWlUXaw
 wyHEYDDZ6+kQh5Td8i0dFpTNnHWlfz89rfQqC5eY+VebOgVJpucwKlSj4myE40w30ouz
 21MhbBnYjJoHjxhFEgk3yBPMaSn4pMhPT7gZkQu2xKkKA37YdRLLRp/0EfQt8RQ947KW
 me2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547323; x=1697152123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07Mlx/7I4oUZt5/A7bSwriKZgQwQdWy9fcTqVU/t/Do=;
 b=fFtlvd+7ekKFdWAGxG6Jh9M+4ZwTiGIuYkT6AWy8a6iitWcCHOKQb0BZ8Tiw4I20HA
 P+ZhSdX9qBTZT9tvWW+rEFCF/IQM8kM1OLwafcrpvMuGxgM4dXafosJFwCDuESeyD1at
 e9tFAwAVWdeVqAkVCsmTx27UZek9lD1YAOC8r+ZhNM6h1pNiTgDPjwBEy/5nH6xHcmFa
 coVBA6l6kIiP0lnzI+ERS5aGzOB3lPCn0p+2691nqY7yZ2/w06vTiua3zS/86UEzm4ZH
 sXTbyNwhsa/JwSwdt9VpfQj2sp3l9rS/Ad5O0jZue5Magm5sPXZEFdLqwYjIQOX/Rz2S
 lGtw==
X-Gm-Message-State: AOJu0Yw7CnPAaMiKIyr858lNCPDtnPfG3r+fZ0EMEs66x66MTVTfk7r1
 x9gyZBMC0nH6ro7zfBqIOHE=
X-Google-Smtp-Source: AGHT+IF+w0s4oXdQFHQ2SjKvcurnAY5mmG0Zp5AMyTqk68Q8ulZ4sNZIq8g3lbE8wTVHwkhcoL6LoQ==
X-Received: by 2002:a05:6e02:2189:b0:34f:35e8:5098 with SMTP id
 j9-20020a056e02218900b0034f35e85098mr7824648ila.20.1696547323284; 
 Thu, 05 Oct 2023 16:08:43 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9b88:f219:40c8:60fc])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a922811000000b003513b7613f3sm709974ilf.3.2023.10.05.16.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 16:08:42 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [RFC PATCH v2 3/4] disk: part: fall-through if "ubi" requested but
 ubifs not mounted
Date: Thu,  5 Oct 2023 17:08:30 -0600
Message-ID: <20231005230831.4032070-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005230831.4032070-1-CFSworks@gmail.com>
References: <20231005230831.4032070-1-CFSworks@gmail.com>
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

Since we're adding the ability to access static UBI volumes as block
devices, it is no longer an error to use the "ubi" ifname with UBIFS
unmounted.

Ideally, the access to UBIFS should instead be called "ubifs" but it
would break backwards compatibility to change this. Instead, use the
UBIFS mount status to disambiguate what the user means by "ubi"

There is no change in functionality in this patch: UBIFS access works
the same and an error still occurs when using "ubi" without UBIFS
mounted. The only difference is that now, the error message is a plain
"Bad device specification" and does not suggest using ubifsmount.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 disk/part.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 72241b7b23..a4b6d265da 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -511,15 +511,13 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 
 #if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
 	/*
-	 * Special-case ubi, ubi goes through a mtd, rather than through
-	 * a regular block device.
+	 * Special-case ubifs, which does not go through the block device layer
+	 * and also must be mounted ahead of time. U-Boot has historically
+	 * called this "ubi" too, even though *static* UBI volumes are
+	 * accessible as block devices. For backward compatibility, assume that
+	 * when UBIFS is mounted, the user intends "ubi" to mean "ubifs."
 	 */
-	if (!strcmp(ifname, "ubi")) {
-		if (!ubifs_is_mounted()) {
-			printf("UBIFS not mounted, use ubifsmount to mount volume first!\n");
-			return -EINVAL;
-		}
-
+	if (ubifs_is_mounted() && !strcmp(ifname, "ubi")) {
 		strcpy((char *)info->type, BOOT_PART_TYPE);
 		strcpy((char *)info->name, "UBI");
 		return 0;
-- 
2.41.0

