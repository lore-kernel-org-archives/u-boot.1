Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8A5E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9AF80391;
	Wed,  1 Jan 2025 23:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzMdY/UX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895F7803C6; Wed,  1 Jan 2025 23:11:50 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CCF8044A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21675fd60feso194283415ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769505; x=1736374305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o3FQVxlZohs9qfb4zpW7rsbV03c3791jPg7fiDAdkQ0=;
 b=bzMdY/UXZ9RhP+rOWH7oNcLrlPvBddS0fjuJ9wy0Lc86VYC3CwJzTl1pOcOvcLNeNI
 mk9BJam5ZihLn/4kg/iMEwqcawRAv8H7wNxUfCMZWQAe4NSp7yYa9/T3hay+wPngkXOA
 BB1WloSYBIoxMsbQYG5LGBmSorQxrtjprjLIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769505; x=1736374305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3FQVxlZohs9qfb4zpW7rsbV03c3791jPg7fiDAdkQ0=;
 b=HNJ+2cTlQpIdv59SvxNm+TgOwRqVpqccuCDnVtP/bnA4jQwcs6Jhq0GbzRSwpKTa3U
 1c/1sLqIAfn+tTXVFb9YD0Nj18lJaw0nrAzjJe7cyc4ptXu00/53kij3nx4tkOC6h0Dj
 gtsp8Zv/56NkATTctntbzZaAB9XczZOMkQ/TNRs80U/Y7ivjaxyFZf4aWhtxaQHzH5Ek
 q1woK1za2DhoJPgMyHUBQ+42c9WLs0Dmq/4Zs07ndGoKtx+4APBhotL4gScMcyGh0MXs
 nHw+rIxZSrOJIzz21EREsbEJvFMTG6uzCMsFdV2TuWEY4IEcFtyHHSZl9J8Ud+K1wlbi
 Pdqg==
X-Gm-Message-State: AOJu0Ywkuvxu04hFhqShviMHIPJCfHHunH7RlYNORzGiqik+Yo0kyGyh
 5tn723KRpDv3k7e0AukiHUQX4PyILzW1L+Wys+t8QagrBHGx7reYphcUOOJHuAnfGevdA2gHslw
 =
X-Gm-Gg: ASbGncsWHHoEuEruFreyoTvGashVaMj92nNuXllp4HpshVave9HmJm/Rlv50+QNCnlV
 /RiumZimenLXFZ7sGXzkWuAnhE3MQMxMKusAQxj0tvcEgGJUgTSNTqZXAixhrgFWPKivG6aMf4z
 /jjyHXm/7xXs3ir9QsAFKCiId8f1++IXf6/6YIkopyOmjZD27ftR7iOxp9EaOvbHdQwZ73xRpyb
 rx6pxTL6KkHFUW2rNYvS+HMjiO75q1qjWV9pYdN7Y4V8ghW4zO+gkk=
X-Google-Smtp-Source: AGHT+IF/JUa/mtUhI8FcWiInWaltOJSfLyd5Z0c2ugmBE4qQBEPHxFxjdtQ8Gk05GHDeI3V4fxDkDg==
X-Received: by 2002:a05:6a00:430d:b0:725:db34:6a8c with SMTP id
 d2e1a72fcca58-72abddbd4f7mr63487765b3a.13.1735769505682; 
 Wed, 01 Jan 2025 14:11:45 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/67] ofnode: Indicate when out of space in a few places
Date: Thu,  2 Jan 2025 11:08:57 +1300
Message-ID: <20250101221003.1944600-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Update ofnode_add_subnode() and ofnode_add_prop() to return a suitable
error when space is exhausted in the FDT. This makes it easier to see
what is going wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/core/ofnode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index ec03f6f550d..5b8be218d3b 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1607,9 +1607,10 @@ ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 		      int len, bool copy)
 {
+	int ret;
+
 	if (of_live_active()) {
 		void *newval;
-		int ret;
 
 		if (copy) {
 			newval = malloc(len);
@@ -1623,8 +1624,12 @@ int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 			free(newval);
 		return ret;
 	} else {
-		return fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				   propname, value, len);
+		ret = fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+				  propname, value, len);
+		if (ret)
+			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
+
+		return 0;
 	}
 }
 
@@ -1897,7 +1902,7 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 			ret = -EEXIST;
 		}
 		if (offset < 0)
-			return -EINVAL;
+			return offset == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
 		subnode = noffset_to_ofnode(node, offset);
 	}
 
-- 
2.43.0

