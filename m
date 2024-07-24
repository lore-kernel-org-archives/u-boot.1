Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F3BC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F106E889C1;
	Wed, 24 Jul 2024 17:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NUHU6dKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFD788969; Wed, 24 Jul 2024 17:09:47 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8585188967
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3993f5d75bbso21762035ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833784; x=1722438584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIPfoISo9sOTBEt3twsXyDv4KQqCogfpp8RYi8fX11w=;
 b=NUHU6dKcTITwt3cSYCCdSbw2xiLyxfzG26TX6gejDwqs+Z9dTT0zm9MTAYmCnUIS6t
 YIK8qczCjFHQ45wjTLJCsLNbQIxY4f49fzooj6j9FI76rLygtvIRg7hHKlTstmkQHsAV
 mxMDGeEN60a5NSJSvWn6CkIktFp/FHbEfQSC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833784; x=1722438584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIPfoISo9sOTBEt3twsXyDv4KQqCogfpp8RYi8fX11w=;
 b=H/553lB7FUAsyAggc9v9GnDSnw+k0exGlcd5YVXhDWpP0crgJq7lYO57agAIJxwZ3f
 iO4hdrsqWm55oT5+VUI6xUiq3f/A2q/P+s6kQB4UKqiOweLhDzCkqnW82kth0QuxD2RN
 lE8Gx771KGh+z2VznNTNpD8lxz2m/gtaYl9tqScoZQJjjm/jsjuoQcQXkD5bX+q6E6zX
 wepxGFCOjl5Zuf5Vx1ZBLKeRLhAkx1YYRJVzUOC1AhqeIvsEVBCSPOx6MQJrQImD2AWW
 tVwHrCuOtvDGZRONF/aQxuirqJq1ZIEJe8staDHFbWL+r/uboyruODQ/uDCND51s4bdl
 a9qg==
X-Gm-Message-State: AOJu0Yw65YMp/NeFAbFJh0osGAtff9w0QmjuxYMzbR8NzIhZalwtQ0Co
 euHVMHqFAhKmtabthhusDtaBdwnX2zX4ud6vmIp1Ttp/CaBtaGMjSqRUBqJiYL2V72MwHRVo01Q
 =
X-Google-Smtp-Source: AGHT+IFGNcJOnqDvBbow1IxcBpnOjcK2owaU7b2bfB3UdoepkGVZaeH+6qoQf8fcuo8RAYK15Z420g==
X-Received: by 2002:a05:6e02:198b:b0:374:5300:88ac with SMTP id
 e9e14a558f8ab-398e6b9eabbmr187613705ab.18.1721833784172; 
 Wed, 24 Jul 2024 08:09:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 09/35] video: Avoid setting global_data fb_base from SPL
 handoff
Date: Wed, 24 Jul 2024 09:08:56 -0600
Message-Id: <20240724150922.2343249-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This field is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/video-uclass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index cb3144f68e0..1a2cde47a33 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -218,7 +218,6 @@ int video_reserve_from_bloblist(struct video_handoff *ho)
 		return -ENOENT;
 
 	gd->video_bottom = ho->fb;
-	gd->fb_base = ho->fb;
 	gd->video_top = ho->fb + ho->size;
 	debug("%s: Reserving %lx bytes at %08x as per bloblist received\n",
 	      __func__, (unsigned long)ho->size, (u32)ho->fb);
-- 
2.34.1

