Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C72C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 03:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D120870BC;
	Mon, 13 Nov 2023 04:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/8zFpxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33518709A; Mon, 13 Nov 2023 04:00:15 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12DA686FD6
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 04:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so172646139f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 19:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699844411; x=1700449211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MUJ5sOhMjDJhwSyiYI2rs6d9XvPHzutZX7j3bt1UMc=;
 b=F/8zFpxcK//CthChP9mRObFAQ3hQF6kPRX8LMTe2vyu39LQprfRPUuQXA/Ot2IyifQ
 M5A6CNkb4xBr1jRI34oaLAJ2/WUfzPiuMSgMja8Q3KFKLzaP+C9KrpeBXfRDanPy/14w
 GTz74nSQkG4sXDCDqYHDxVM93qImlU8k2DHR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699844411; x=1700449211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2MUJ5sOhMjDJhwSyiYI2rs6d9XvPHzutZX7j3bt1UMc=;
 b=SXusjs/KWGKfeWJJSb/XEeaXBehfcKZ1Oo+pZIuqKRIq//bZnQf8LBEyKvLkGebKaN
 pQN84K9pnD/CJKMuC2vjpVVTksIFOW44V7wICOPHjMuxkAB++x8ttDnlepJuuJG0Zfjy
 +IGxns/xdSC6uSLX170RSy7tll3WCfLQTC4wktA4GidzKlHiWX4YLKbvcLo5xQUj1BQk
 3Eqo/+4nnePFYc/jxXWJK9d0g38tOq/pSW9vCMKutow+OcZ4bq3fnPP2RPE1Qv0mn95o
 RxT4L2nnUEnuLoOSp6gPfDCPt8Ruro+Ln96y+5v+w30gjFbvKfcYOGXhfXiq0+mPsfQk
 dZdg==
X-Gm-Message-State: AOJu0YyGxrdoOEivWSjX3wfNGBjckt83TEdtTtwAtv5HFbESlzjSWqbE
 2Akz2JIX9atG37LRzkVtVqaeX9b4AfCuZBCxXNuyXA==
X-Google-Smtp-Source: AGHT+IHTpx3vp6RzBnjttptpq92SvL768auBUzxzrqfdqpnOvKoXcAO10hd1ieLe93rg9o+DbfkUTQ==
X-Received: by 2002:a05:6e02:1545:b0:359:6a34:904a with SMTP id
 j5-20020a056e02154500b003596a34904amr8163326ilu.28.1699844411646; 
 Sun, 12 Nov 2023 19:00:11 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a92cf50000000b0035134215863sm1350914ilr.55.2023.11.12.19.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 19:00:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 7/9] Revert "generic-board: make show_board_info a weak
 function"
Date: Sun, 12 Nov 2023 19:58:27 -0700
Message-ID: <20231113030001.240020-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231113030001.240020-1-sjg@chromium.org>
References: <20231113030001.240020-1-sjg@chromium.org>
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

We already have:

- a sysinfo driver-interface which can obtain the model
- a weak function called checkboard() for showing board info

The current implementation has a weak function on top of a weak
function. Now that all boards have been updated to use checkboard()
instead, drop the __weak on show_board_info()

This reverts commit f7637cc01414b9c87b6b0f861f34d83c19bfaaaf.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/board_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_info.c b/common/board_info.c
index 3185793da4a7..a62c04794b90 100644
--- a/common/board_info.c
+++ b/common/board_info.c
@@ -15,7 +15,7 @@ int __weak checkboard(void)
 	return 0;
 }
 
-int __weak show_board_info(void)
+int show_board_info(void)
 {
 	if (IS_ENABLED(CONFIG_OF_CONTROL)) {
 		struct udevice *dev;
-- 
2.42.0.869.gea05f2083d-goog

