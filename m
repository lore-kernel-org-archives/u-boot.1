Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB4DC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD4588C29;
	Sat, 20 Jul 2024 08:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EgHfOeRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C6888C20; Sat, 20 Jul 2024 08:20:47 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56EC588648
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-36798779d75so1485880f8f.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456444; x=1722061244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/OXMxmi9C1+dGOLK2mXDn/pqIiUYC0dsjYcfx/TUik=;
 b=EgHfOeRR6hHmVrvVqF7SuMZ3USdCqoU+4u7Gy8md3BRCYgu5IXSdNICr/8dqX/gFvw
 EISl1sDFIRR9HnEdigcT/6xFBYaAq0mwSJlwbPtqUA/NaJRX9Bd4n1HfVcfnRUngNAjx
 DI6aBOyvKPlCh1gKZNSA7maIQKO7deeAv0AR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456444; x=1722061244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I/OXMxmi9C1+dGOLK2mXDn/pqIiUYC0dsjYcfx/TUik=;
 b=cR+GwQbAp2RQhMHdGaUtHOJirVKQvSJThNI06c2yt2s/OfufNCadQ5/ikUaVu7N7IR
 EkMjxkRZxE6XmfFjyGBbeaaKaU9lWn+o6F7CAqh1CQVrA0JGudo+OBuWuQYidPmJOhE4
 bWbyZTONKsT7i2PYbVdrTQqesXbFFyB62FdW94XnBONuz4+6imKN/jw4V0ZdUxiHNbSW
 5WdIwpKlEX36NC7kXxtnckesHUdc3TuiGDvC2o8Vl2XDnWzSikCM3aII6scoJFxxldQ1
 PJL5hWZQvp10xIhp2EGwWq47w7HSHhCwt5ygxaT6ZQ5pvi4h7W+KrsDWi7xwtTjpeATO
 t5uQ==
X-Gm-Message-State: AOJu0Yy1+BqF+dIZA8cV4loQf7eFB0ytu2ZI99fpEYgkJ50kKolUIhAm
 yXNfL7VnAdi9Sq5m9Z+CR9ED1GyTmL1Uq0NAzKWkBY+eBFw1CCEm5pprAbTsWHQA7kB56dei1Fk
 =
X-Google-Smtp-Source: AGHT+IGF1915sRtqFJuxuusS1d8/jogPGVLI+v0RNyRxZ8DV+GqLu9HXOirzhan0BbdwSlFV2zYP0Q==
X-Received: by 2002:a5d:6911:0:b0:368:e634:1520 with SMTP id
 ffacd0b85a97d-369bb2d54cfmr413157f8f.59.1721456444631; 
 Fri, 19 Jul 2024 23:20:44 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
Date: Sat, 20 Jul 2024 07:16:54 +0100
Message-Id: <20240720061706.2644229-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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

These should have a CONFIG_ prefix. Add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
---

 common/spl/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7794ddccade..6f4a8bfb3f4 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 #endif
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
-#if defined(CMD_BOOTI)
+#if defined(CONFIG_CMD_BOOTI)
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-#elif defined(CMD_BOOTZ)
+#elif defined(CONFIG_CMD_BOOTZ)
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {
-- 
2.34.1

