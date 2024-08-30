Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31982CA0ECC
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA7288D06;
	Fri, 30 Aug 2024 02:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ossystems.com.br
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A4688914; Fri, 30 Aug 2024 02:43:46 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F37C88D06
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ossystems.com.br
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=otavio.salvador@gmail.com
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7142e4dddbfso1029128b3a.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724978622; x=1725583422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OT49Dt7auJCi7zIWATvSzBZZDSSemQoPqWjAL+cABno=;
 b=fl70tN8DDrHhTuUUecfXzraJNPYjnlbuhdGTug32kqkQtzc+jsSoESBpr9lCrtwoc/
 nwiQ7O9Kt0RITQP3lUMud99yhNd2a7dzQgXhvhyOgeoAzqbgwjwyJRTndE2zLzc4VfQL
 nExQIky0+9n2WwFy4D7oqc3gKjD5nUeqIPE6SfoFb74aUNp8E/8O+EFHloja0b8kzAKN
 Q7aD8MOav/AnzMp+S0i/15s78DYUJZGF19ZSBJ2fMtrAsywFyrwWwdbaaDU2TDf0eu5C
 YiJM4UxT8XftTZLnWTwGtETfbPTv3gxRJd6eXwulQLsPlyYdPzMn7EbHxxMvl/yoag4P
 ikOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKqbTtNcsvaOdFXdh+iENYwv8buOqOsHmixcgmo7o2HRN3I3P8fcGjX+feu+9K85mUGqZPUlM=@lists.denx.de
X-Gm-Message-State: AOJu0YxwGLGIuU++iuKPZxoPUIbOxDG6B6g8Zvpp0GDULn2RM2oxwtAB
 stItDdqmADDUhqvK5+VCFyvxQnuMWrPgXhap1L9VH4P77XKj41qseZnLoNQa
X-Google-Smtp-Source: AGHT+IHomD5Yp7uGdqK6qJeShtESeCbOv2Gp5Rqhj1WwLIVWW6gkndS5iwpjILfcRIJAWGRfB0sK4A==
X-Received: by 2002:a05:6a00:9452:b0:714:1c0e:1336 with SMTP id
 d2e1a72fcca58-715dfb90e89mr5406994b3a.4.1724978622358; 
 Thu, 29 Aug 2024 17:43:42 -0700 (PDT)
Received: from localhost (189-30-34-54.user3p.v-tal.net.br. [189.30.34.54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-715e569e9bfsm1712585b3a.130.2024.08.29.17.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 17:43:41 -0700 (PDT)
From: Otavio Salvador <otavio@ossystems.com.br>
To: openembedded-core@lists.openembedded.org
Cc: Otavio Salvador <otavio@ossystems.com.br>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] u-boot: Ensure we use BFD as linker even if using GCC for it
Date: Thu, 29 Aug 2024 21:43:24 -0300
Message-ID: <20240830004331.2856512-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.45.2
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

If we are using 'ld-is-gold' as DISTRO_FEATURE, the U-Boot Makefile has
mechanisms to ensure that we use BFD as linker. However, this does not
work for the GCC when it is used as linking tool.

To support that, we added explicit BFD use whenever we have the
DISTRO_FEATURE feature enabled.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 meta/recipes-bsp/u-boot/u-boot.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meta/recipes-bsp/u-boot/u-boot.inc b/meta/recipes-bsp/u-boot/u-boot.inc
index 5a7bd6703f..ed3822784e 100644
--- a/meta/recipes-bsp/u-boot/u-boot.inc
+++ b/meta/recipes-bsp/u-boot/u-boot.inc
@@ -9,7 +9,8 @@ inherit uboot-config uboot-extlinux-config uboot-sign deploy python3native kerne
 
 DEPENDS += "swig-native"
 
-EXTRA_OEMAKE = 'CROSS_COMPILE=${TARGET_PREFIX} CC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${DEBUG_PREFIX_MAP}" V=1'
+EXTRA_OEMAKE = 'CROSS_COMPILE=${TARGET_PREFIX} V=1'
+EXTRA_OEMAKE += 'CC="${TARGET_PREFIX}gcc ${TOOLCHAIN_OPTIONS} ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', ' -fuse-ld=bfd ', '', d)} ${DEBUG_PREFIX_MAP}"'
 EXTRA_OEMAKE += 'HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}"'
 EXTRA_OEMAKE += 'STAGING_INCDIR=${STAGING_INCDIR_NATIVE} STAGING_LIBDIR=${STAGING_LIBDIR_NATIVE}'
 
-- 
2.45.2

