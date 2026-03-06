Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADC1F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440418402F;
	Fri,  6 Mar 2026 03:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KicCoBW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4407583FFA; Fri,  6 Mar 2026 03:37:30 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C9883FF9
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-899f5d337f7so59206556d6.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764646; x=1773369446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o04F+CXR/pmtmayAdTBJ2v95xOWmCrYqOmh3y0xfA9g=;
 b=KicCoBW54u5JI0YKQn59uI+x07q8iFVsZD0d3YDnTUBg8zksIEaZko7b+KcmZMw08B
 O6QJ+lZWKPUMaSEJ88uB5+ZTQXt3V1snvpeDDOYNAjh56JxgURIp3ucpeBFxXDz5lQ+z
 ie2v6ObjYo33z/bV9Or1LRblpmWPE1rKrf9iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764646; x=1773369446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o04F+CXR/pmtmayAdTBJ2v95xOWmCrYqOmh3y0xfA9g=;
 b=l9IpG9lJXVUIdZhzEOAzvwL1wi1l6E2xRRYnGNhDB5W/uy+82G15J3jUVMhieczy4g
 PaKG/JopITINH+Su15gSbyPfxZHD6XOTz/9pWIQ+XPUzrnxpwxrazQOpHjYs/+2tPn+I
 dy9xyRc5wVR+t+O4VSVNIHrj0Z7qS7+WLhUozhhn0v1W2sQNDFmQ92J9QNIjuDPpBNfG
 OZwO8DUFp6CIl5AYi6OPhTHmx8j3u5/MznnOSqYKVWympHuzMJSNm1HnsLvNFCODa9vZ
 PT/j7hJtabTc3NFX/oA4sPv2S8NsLuWcFg1UOeMgvdkpxnjqKCFllopUbUd4iCaAVExG
 Y3FQ==
X-Gm-Message-State: AOJu0Yx0WO46K6EXwqOfJGiRWa0nzJjhWZBjoN0QdCLSjqHDqxLDuHw5
 wfi5lr1ZlGC9oT00JQjP20vjv4gyxM6FmaptyiG+veGtlobC13VzmkComcU9GVOY7/jqxT3wZ25
 cRyU=
X-Gm-Gg: ATEYQzziu0hagLIfGs22/4xaYbIbtW0fQu6ciTZyoevXzI5SmX9lXvjcFlk3ZT9X5Sh
 V2WXn35ejepnMVeWm9W3qzTlMyHvbmdI3e9tbsi9z8MRV9UrH+oWGL+H6a79cMsANrHLKkWU44s
 Yxdk3YOINekIMG8TX2+3Hp5sgC0y1Vc9/EfeudCP8QD/RPsScbYKr5UwsG3PzHjkQMjEPNwAgXv
 sIGJvwTPcb73kjs23r+DzfU6wM48yP32nxcyPWWFoFLWVqgklqjRgRjFwmUnQSAJQDTWgSBs5wm
 VXdsH6u2hNvUxXVY/ziipnJvPaBFENjI3HlYJ0SqJOfPdAzhDY1e0ybiIV3rIuAJjFmz2C/4l3I
 7lgan0rlKmXi4Ka4t0iIjYrauekaK1NDXAiaGcMD83WdCxxy/hVL08lIoHuvFzyatP08L1ULkpb
 CPJwN6GWsAaC45qwtjB9VTJznWA47s
X-Received: by 2002:a05:6214:2242:b0:89a:a0a:c0f7 with SMTP id
 6a1803df08f44-89a249056ddmr68080506d6.33.1772764645683; 
 Thu, 05 Mar 2026 18:37:25 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Scott McNutt <smcnutt@psyent.com>, Thomas Chou <thomas@wytron.com.tw>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 14/17] nios2: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:23 -0700
Message-ID: <20260306023638.2678886-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on Nios2.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add new patch for Nios2 conversion

 arch/nios2/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 294ebfb508b..6004e83bf0c 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -41,6 +41,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 	if ((flag != 0) && (flag != BOOTM_STATE_OS_GO))
 		return 1;
 
+	bootm_final(0);
+
 	/* flushes data and instruction caches before calling the kernel */
 	disable_interrupts();
 	flush_dcache_all();
-- 
2.43.0

