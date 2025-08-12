Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26925CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 17:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 486B182F00;
	Tue, 12 Aug 2025 19:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzazkOyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5A682F8F; Tue, 12 Aug 2025 19:46:33 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E4282EB8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 19:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2403df11a2aso38956375ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755020790; x=1755625590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCRZKXbQOiAIebogGAYdjqBks+j5Gm1qVC8IzPRwxCs=;
 b=ZzazkOyX23JaVMGpGOUDozTZ7ojpWNBq3cinJxnvQeWFfa7Yo2/T9uZJNy6SipH7+I
 p+2RLFvoQvV7kMnMmX6T/tjaatgAKh0W6jFeYCmZXz0k/PDlg4Kzsk2AlPzeFT6WNbaM
 9sLedg2HB2VET9PCeIYY8gVAIOY51VbySKJsnqMU/Epye8jsz4TFAWIpvRDzcsXplcMJ
 qLmj5nf04fZs8AiiX9jli/U9tJ3eEK7GCG+hrHTq3dVZd0HfMWtfPTIsmpa2j0qwV7J7
 tlyIqsljvu+uKY7R6K6GhwlMUHXf36Axv/4NSkJ/uHkl/T81ZCqMsXkIwyaS9lNXEz/h
 yL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755020790; x=1755625590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCRZKXbQOiAIebogGAYdjqBks+j5Gm1qVC8IzPRwxCs=;
 b=Hsvfe8qKQDO1D48p1KX21H1uxeCjFOknM+ep025JUPw0jXYD9BDg2rxNfiNh/nld0p
 7i27+Ukq7ll7lz8zku2Xaf/oeoQ/EpNyTOr341BWnD/Rp57/9Zb7rcqDjX7NnBEbiIRJ
 a2s1sV/30FVzdUcFRWkZ9t9hr4+YQA52CycYhMfV0t7rRovtjWomajxfjfV4IP31bXs/
 oj2CwgmDbVxfU+0t6kfAGVfauXHid5eaDPnpG7LF9LXkSnXTbZxubLVNgSar7JLSsGrl
 HoIrulw6u5fO5UB0NI19vDg7dgLm6YBZUzlhY7FVpjnF+twSsyz6yisAD3ql2XcdCURD
 JCzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr0kmyU9DOgGlO5xPhPhQTObhU5FxWx8Jw+ifzOJlA8FFJ6iyg9dVoifAE9jDAVFl3/5UaSq4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7ePiKMX2d/I2+pGqF/QuZ9+rqeSKa7Wrl2nExN9NIIC7Avhnv
 VbEOjMqbDuyDxIx0fmE3H5e7WAL6xPRT/rkppFSsgvrAgVZIY7UT62au
X-Gm-Gg: ASbGncsm1V+CN+/XPD/jPY2DKquNXSZBC38x1hgCicCyLF6NWWMYnx+L+3dpBKz4j9k
 tvQzQ4PdqyzL6ztDV6jELVIiRmvBAjwU60czIg3HJhX47TB5Ydm99JRQJfKSbsuz4IWpnCaz4ZT
 pg0QIOuxxL4ZLx+O3Xk8beoYOO0DLwImP7Ghmx5YJpM9PeG9Qyj8RChHJHRDtK0MKyAAJp+jRKE
 24YE0xTSdc+tQJ8aS+kZbsqinlvTZAaPGJP5ctpb94dNSbFKmnOxV6VdF1a/0j9QMwiQY/k5W9n
 8Hi+CCXL91zwRcXaFL25q0P51ecEwQGoYxFqclzHrsy2DgOiwNFI1aJexYJAPUfVfNrJY28UmgP
 R+ksIe5DSR47LpdCbwLdUBokmazXj1joevoDXXB9oMQDMAsA=
X-Google-Smtp-Source: AGHT+IHnwuc8DScJ/WeyAOS0TubACRPFzivV4ZP5gcDUyJoSDF8WI14CYKKk294mNhHb2wvN0VyVsg==
X-Received: by 2002:a17:902:d492:b0:23f:ecc1:ed6f with SMTP id
 d9443c01a7336-2430d0e62ddmr1329235ad.17.1755020789723; 
 Tue, 12 Aug 2025 10:46:29 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4c8c:4a84:8608:9a5a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef7c30sm304527205ad.37.2025.08.12.10.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 10:46:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: joe.hershberger@ni.com, otavio@ossystems.com.br, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] env: fat: Standardize the interface type check
Date: Tue, 12 Aug 2025 14:46:12 -0300
Message-Id: <20250812174612.1159634-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174612.1159634-1-festevam@gmail.com>
References: <20250812174612.1159634-1-festevam@gmail.com>
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

Make the interface type check consistent among the other interface types
by checking it agains the ifname string.

The ifname string contains the string returned by env_fat_get_intf(), which
returns the CONFIG_ENV_FAT_INTERFACE value.

No functional change.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 env/fat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/fat.c b/env/fat.c
index 412d95dc3057..58c279ff7690 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -131,7 +131,7 @@ static int env_fat_load(void)
 #endif
 #ifndef CONFIG_XPL_BUILD
 #if defined(CONFIG_AHCI) || defined(CONFIG_SCSI)
-	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "scsi"))
+	if (!strcmp(ifname, "scsi"))
 		scsi_scan(true);
 #endif
 #if defined(CONFIG_VIRTIO)
-- 
2.34.1

