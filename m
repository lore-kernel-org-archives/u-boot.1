Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A13C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6624B8077F;
	Mon, 20 Jan 2025 22:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cFKbVglM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2CC80758; Mon, 20 Jan 2025 22:26:32 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0431D806F8
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso420944639f.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408388; x=1738013188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aWJXh0sIbIME8VhsiXWXVbZ02pZinDt4NTwQ5WqDxyY=;
 b=cFKbVglMVLxOjoP1qAF92lMZvqMRPgQoJnN6p9jQQEB4E0SRPwhfYgeNGTtCSLpEJR
 ZNPeh6ZDNHrA4Jt+4XQdARjTZD/hX973UmbxaOSgrkpJhXAGo6dmONT+tEKXomFqGnJT
 uB02EIfted8p57exJKpLE4V3mjB7Fc0iTbzew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408388; x=1738013188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aWJXh0sIbIME8VhsiXWXVbZ02pZinDt4NTwQ5WqDxyY=;
 b=WcJ98Umk5kiNAyFrlO+qqZ9O0/kUj0+xcH+oaHCxcoywuDkZb5cKistmlLsTx2GoJQ
 i8LTjVcsdmNjJcjatO/klSfFFjlWb8i2NdfTjHzC5HTMxk2mSWFz8Ph/7aFBirRUWAq3
 EBqcYDo3JLCynqkXj9CMnvpKomcyfKKgV3GTTu8B4FUvetSyFNllLAZmP16CcEUw3o4+
 CBN6/BGwMU4+MF8qxYJZiu7wIXAjibavQzK/aPDPB02KYXSvvtbqM+Z0Fxfz5wnizFNj
 48bHld1a98/l+M5pH86Xzr96aBlOfWK7xXZxgXUgmAYyoKRGRVwoEAegHCDaSLHzS1kA
 j4bw==
X-Gm-Message-State: AOJu0YzEfiGChH3nVuPRiUDSLO1/d6Kpld5GcUbv0PlNY/gmigsSBLw6
 V7ErY5rPrm1gMrBwFDgn5x3cwk5Agm8f0UF/kJcHGN1ujmbtCBbhzPsCvQwIzZtf/M2EjhJtLM4
 =
X-Gm-Gg: ASbGnctF8OrCMnporJC5DJWHLgqrFnEiBeYiLt/GicCFiqO86JxYGOQLaWG9QiZEoUI
 XL6cej30xDYKJqlQHl65Njc2U9VBjaTPOVMdlx1ZeyodW/jiagQyFpxiPsNgoQxz9VEEFwOrVgn
 2P9/Qamg15VBWiZ41LWZlbJpWViAu9YE9qaAUJXUekTchLgQ28PW/Vk355OKZ1qL0UA0jPXTX/1
 t905sXMX2qLzY2NhFysV3XqXcTA7CJ8scdSe+ixNO4YgqsuUz21VGBBvOl8eMsTeICfTI3WxXBx
 9+1ezGy3T/nB6Kd1FWBQ0W1a5Gb/ugc=
X-Google-Smtp-Source: AGHT+IGFcV1V9VuqIoMJPoyCDk1xjUTMb9d6GDeen8UbJjb4mZAZEXFaZUbDCVDLYOaHhF6hnk7iAA==
X-Received: by 2002:a05:6602:6d13:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-851b619f80dmr1307081239f.3.1737408387832; 
 Mon, 20 Jan 2025 13:26:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/44] test: Drop unused suite prototypes
Date: Mon, 20 Jan 2025 14:25:23 -0700
Message-ID: <20250120212613.516664-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

Drop some the prototypes for functions which were removed in earlier
series.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/suites.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 2ceef577f7f..e40ad634702 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -36,8 +36,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_compression(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[]);
 int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
@@ -55,14 +53,9 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_print(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_str(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_time(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_unicode(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
-- 
2.43.0

