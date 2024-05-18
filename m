Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A743C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 15:04:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81909886A7;
	Sat, 18 May 2024 17:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bDXeMpsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D53748863F; Sat, 18 May 2024 14:03:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0974F88659
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 14:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javierm@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716033786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9wWTaAmMTAo74NaoqGMbgHxXdbG0mpL4ixasp7W9sNk=;
 b=bDXeMpsqIHTyvwCFjGxTJM/DTz6ihHp0GWvVxPralCY7Oy/NQhG4wCY40wst9E/BvT0yiV
 exv9qojfvyZnZe7MVzY2nqcrmswS9vOqWnGWLPwD4YXiPg0rS23yeV/a4Fl+hvzaXY+pke
 ruPLzdar4RGvJctgWeQywUp57A8w8fQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-JIh98tGRO1KcS77J498cjg-1; Sat, 18 May 2024 08:03:05 -0400
X-MC-Unique: JIh98tGRO1KcS77J498cjg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41feab38d16so39287735e9.3
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716033783; x=1716638583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wWTaAmMTAo74NaoqGMbgHxXdbG0mpL4ixasp7W9sNk=;
 b=Xlu7ZToOlwfSp3lMWHgbEao58HY+/AIbQ5Tes+fBroBj1hJq9WBGJ/qv6rUhigJIy2
 okdBa4NgIvAb+ecRym3fR+saYAJ7UEyS8AVSRYLFlhr8nBaE2TlcIGEXO9rHXGQ2dsx8
 tTROML1xpQBr5Sm9ZOvHaYPUgvYKNPb4AtxXww7RK9du/8LsTcRdZll8Imk+QHPVKzfD
 OCPm+TOwWRdtYIYnaoe3MS72zUGOewN5wAKSqWGEqmDbinL95lbWgn7FLuRRemAkFj/K
 Yb9gd6b0amPd0p/OtxGKCuXEJANAo2SlvecRH81Lw7fK4TFp46aq6kFR6hmRaM9BQevP
 sUZQ==
X-Gm-Message-State: AOJu0YztNxWiuU1fZRKbW+nrzOowbUj0HonyI+ynal6g4XaNCXF01Rze
 r6/GMAmqMXlWhv0yWXLcPi+qHrkfr/6dZ9uoDq7GTbD3hrCrpfSW6r1WX474H2xufisNEqoF3gd
 tmaMRX3ImBFLlUxBqtDiK9bHn4Idc5mxfZWR22mk+JpPIGnmTQwNcNs8xH2RbwS3MmzKTUk+7uK
 7BA5H+u56jQ9ONVXkyMoGyJzw7rQzltcaeZw==
X-Received: by 2002:a05:600c:1392:b0:420:e24b:dbc with SMTP id
 5b1f17b1804b1-420e24b1202mr10104035e9.27.1716033783485; 
 Sat, 18 May 2024 05:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTWwBY2KoAk6w6/kk7qcT3NgYvDMfTpIIEfMxDvqNNBBoimBi4M02QephAcg0p+dtMkK57yw==
X-Received: by 2002:a05:600c:1392:b0:420:e24b:dbc with SMTP id
 5b1f17b1804b1-420e24b1202mr10103725e9.27.1716033782780; 
 Sat, 18 May 2024 05:03:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41ff7a840d2sm304084385e9.39.2024.05.18.05.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 05:03:02 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 1/4] omap3: igep00x0: Increase malloc() pool size
Date: Sat, 18 May 2024 14:02:29 +0200
Message-ID: <20240518120254.204138-2-javierm@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518120254.204138-1-javierm@redhat.com>
References: <20240518120254.204138-1-javierm@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Approved-At: Sat, 18 May 2024 17:03:12 +0200
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

The IGEPv2 board boot started to fail since the commit afd4f15a39de ("spi:
omap3_spi: Read platform data in ofdata_to_platdata()"). Because this made
the OMAP3 SPI controller driver to allocate its platform data before doing
a relocation, but the igep0x00 config sets this pool size to just 1 KiB.

Increase the pre-relocation malloc heap size to 16 KiB, as is set by other
OMAP3 boards. This not only restores booting but also makes it consistent.

Leave the SPL pool size to the previous 1 KiB size since 16 KiB may not be
a possible size in that constrained environment and is also the value that
is set by other OMAP3 boards.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 configs/igep00x0_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 261f71acc1dd..e4d25556e3f3 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
@@ -10,6 +10,7 @@ CONFIG_DEFAULT_DEVICE_TREE="omap3-igep0020"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_IGEP00X0=y
 CONFIG_SYS_MONITOR_LEN=262144
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-- 
2.45.0

