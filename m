Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1729C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159DF877F5;
	Mon, 27 Nov 2023 20:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dqyQ0Jeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBED877CE; Mon, 27 Nov 2023 20:53:22 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08F5877FB
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-58d6bf7575fso1174410eaf.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114798; x=1701719598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFX1VEaQyaKZER3u2pIZ7v/2gftkn29zuIj94ExOy+I=;
 b=dqyQ0JehrWsf7bW2Q5j62tQfi4T9DJfy9eA7gVjhTzumHQghhNaDagCqW7HGybFDp6
 ZrB0JKqTac8jzBhtpCUUKqikrOdknperEBYXZD6Xl566siFglnGYXYjiatr54D/+jspR
 +4tynzhoQsPr4y59wDgxBL3Ka7CcME1eRvY7xoX7lGGVQz7mJnVS0iMMy7gLdUhFmTXM
 bC+hdm+Ti661W+w5eqUpoP9SCjBEtFSTvHi3AnFTDEJWkTgHdpbVTWBXYf3gWTOWPbC8
 bUjbueb7O/DAMs2iiryDRlujJQoct/f3Didk7hje5/p2wNfvSTkFcmadMGOdo2exUxsY
 j98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114798; x=1701719598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFX1VEaQyaKZER3u2pIZ7v/2gftkn29zuIj94ExOy+I=;
 b=Ueiv6wTLcLql+NyU8le61RsVa1bWGiZpglgDOxpFBNHnTnS6Dedhpqr6A2/07E6hHJ
 ThiqzHuHBq7g66aGujpFF/d9VT1j4OF8cVZWx4rYKEHE09Zcuo1ILcrTXZOFVY6I376T
 7IUGNamgMtWW7oDZkAU7nP5n5DwdmAOFV+K8M0aBbzS3v6UDQZOt2VjYkj0TmyhMustu
 eq2jFFnKs/x2PaSAAgnNMRndXzIpmLYlLoahqyOyUdwPBDszU2sR4/6xSY+FDcYRKwXu
 Z2v4b0js0mN5RRVvdvHn4MoHwuCXRDbbjbJF35ZfGRPccnG44jkZw69iRGb8M0cHRX3/
 xxwA==
X-Gm-Message-State: AOJu0YxQo9ERkAnoFXL5lMbyE1gPRoFIVEI/RH5l05Tyd7qRIAi/u4Jw
 pQiZNhhW5N4F+3Bzu9OM+PhUnBpMRGRhVKEG0KI=
X-Google-Smtp-Source: AGHT+IGT+xzdf0z5uxSTNATvOprKjXrT+AuqQFG8ealeiUldOlVdqG6oOClYO3z9niHu76JjSLHk4w==
X-Received: by 2002:a05:6358:89e:b0:16e:1a22:a1b9 with SMTP id
 m30-20020a056358089e00b0016e1a22a1b9mr14018199rwj.15.1701114798295; 
 Mon, 27 Nov 2023 11:53:18 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:53:17 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 14/18] bloblist: Update documentation and header comment
Date: Mon, 27 Nov 2023 11:50:25 -0800
Message-Id: <20231127195029.90951-15-raymond.mao@linaro.org>
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

Align the documentation with the v0.9 spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 doc/develop/bloblist.rst | 4 +++-
 include/bloblist.h       | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/develop/bloblist.rst b/doc/develop/bloblist.rst
index 81643c7674..28431039ad 100644
--- a/doc/develop/bloblist.rst
+++ b/doc/develop/bloblist.rst
@@ -14,6 +14,8 @@ structure defined by the code that owns it.
 For the design goals of bloblist, please see the comments at the top of the
 `bloblist.h` header file.
 
+Bloblist is an implementation with the `Firmware Handoff`_ protocol.
+
 Passing state through the boot process
 --------------------------------------
 
@@ -99,7 +101,7 @@ API documentation
 -----------------
 
 .. kernel-doc:: include/bloblist.h
-
+.. _`Firmware Handoff`: https://github.com/FirmwareHandoff/firmware_handoff
 
 Simon Glass
 sjg@chromium.org
diff --git a/include/bloblist.h b/include/bloblist.h
index c419c0d923..148a94fcd1 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -66,6 +66,7 @@
  *
  * Copyright 2018 Google, Inc
  * Written by Simon Glass <sjg@chromium.org>
+ * Adjusted July 2023 to match Firmware handoff specification, Release 0.9
  */
 
 #ifndef __BLOBLIST_H
-- 
2.25.1

