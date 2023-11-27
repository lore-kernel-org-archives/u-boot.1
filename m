Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49810C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA59877D6;
	Mon, 27 Nov 2023 20:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ErwSmKde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2587F870B8; Mon, 27 Nov 2023 20:52:23 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CB7877CA
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67a545a9462so2824686d6.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114737; x=1701719537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFN/Lp6qFAi5JiFz60Jyh9GmB1P3DSDj0M7XlJq/PX0=;
 b=ErwSmKdeLjZGQBBu41YMEOiPIBhl/pxfbLhNg9ldZp83hy8trUEzGeBNx6hl3J8hXB
 mpxP7SAgL2BQzDN44x0s3U4Cai5ok2HUwa13MJUOS8OuRlvE4bXZXXy1psLAGQnaV1Rp
 eIUO7U6K7iRNRrcqXhtoyQuwd6ceL5y+X+erTRU3xHt4BGiDvrXN5+7HMdVtEepjUK4O
 C8h9tdFlotuRiNw/uoUgj2khTTRbm0eu4ZTZuo1Qrv0+Jsm1FtP5+GgSKsqh4eMSgljT
 BZ/LUSAhXnRNirKMy++0qAQWKaa5fKeNCHEyJJh7xl1wO4VmaSZOrT+BCNUHfZl5onEp
 sA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114737; x=1701719537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFN/Lp6qFAi5JiFz60Jyh9GmB1P3DSDj0M7XlJq/PX0=;
 b=UBtjPRFQPIqsa42XAYWlAedJbA05AYsd6u8mNv2X4cD/rUGMtyYyuOAcSIr4H/rE5N
 DaUrwleKuMCNTDeWxYkAR3pwwMVk1qOlMvOMJrrQT/+YMFssfLu7HoF2ybjsWNpPU6N/
 oBdRODXevPVH3p09l0cJFxQUNVcBe16upp8V8aFAhWhGj1GGx5FEhyWgYutXfxyYvVKI
 tON/bgYpC0/SauSSQhf4XBT5cAydD7vDufF8m9pIJxn1m9ed8u7IRBj/io/yZWNZ1C6Q
 yHM9dz14DY6mXcIrFsMcOti0smKbj8pk9pExvnDusHHoCHbW8hubkHgGZ7UTjZvh6fit
 1Ocg==
X-Gm-Message-State: AOJu0Yzxb3tJEL4OWyBKUGxNgqzQ9o0pzTwRDNlGIs7o2mEG6PcEqXup
 rRHavHbAqQcNn+3IMtJ8+3RlFRo9lHPAG/uANasftA==
X-Google-Smtp-Source: AGHT+IEwTYOH4dMEnU+uJ8rb5VYjmud18q3a7jRDBeDxo5i8K+5AGgqY4H+KPtp9qqPuejE9unQeqQ==
X-Received: by 2002:a0c:cd87:0:b0:66d:9f68:219f with SMTP id
 v7-20020a0ccd87000000b0066d9f68219fmr14676603qvm.3.1701114737697; 
 Mon, 27 Nov 2023 11:52:17 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:17 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 03/18] bloblist: Change the magic value
Date: Mon, 27 Nov 2023 11:50:14 -0800
Message-Id: <20231127195029.90951-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

This uses a new value with spec v0.9 so change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the bloblist alignment to align to FW handoff spec v0.9.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 1e4f1a6342..30441f922b 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -75,7 +75,7 @@
 
 enum {
 	BLOBLIST_VERSION	= 0,
-	BLOBLIST_MAGIC		= 0xb00757a3,
+	BLOBLIST_MAGIC		= 0x6ed0ff,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
 	BLOBLIST_ALIGN		= 1 << BLOBLIST_ALIGN_LOG2,
-- 
2.25.1

