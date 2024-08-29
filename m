Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD18C83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB62B88CA8;
	Thu, 29 Aug 2024 16:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bHadsfLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C3D88C81; Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C68C88C39
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e856a14eso37559239f.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943505; x=1725548305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2I1C3LfZG41zfMr9SHsIZt4dxxjWSVcsp5C/TUHF08=;
 b=bHadsfLXnKKh+UnG2H6/gaZDQFQqN1vIh4eCiT+IQ1iGHVpNGCLYfQMvHKkajkDRLR
 KZcp3YwHHTuZRzVeeVG4Kw4TypIVTR4it9VXpecynNOGyPjSxVhDwT65Ywf0Q37IbQRE
 2te/zTOUqA2q1Vd35rOpHlK3Od6Xvz9kKb9Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943505; x=1725548305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2I1C3LfZG41zfMr9SHsIZt4dxxjWSVcsp5C/TUHF08=;
 b=OPrqAqBr26OLZSSgKYAQ1qfDke46wUjTPn54DNiqifYrqk7PSMsipTwyo1fXdxa38F
 FnqMlE2p+DH4sjR8ZTzSbf23/n1TLi8etl2pcccNtU2rkYFCACXZHaw6W01OPRCTR3ts
 5SJV4i/r2KJXHEYmfnKrDVZ2YeoA2dqoD/825AOnwWx0jqBXIzWGqv4L3inz7SBRLeYe
 Jur4o1h6SvwzWCBl/pTiuk4NTH/HuFmHFQrF38ckZlQJCH7YDRpEYZOIYqg7Nb+xVmY0
 DNt73pd/isxJU/v9unHAT2f7MthBobgXF1z9UlJ8i+USwQ57jXGImDrFcz8Dxrm6OrU6
 pZqw==
X-Gm-Message-State: AOJu0YywMgJHb2VpRTQuK+HAqrylDlHyLUSHRHVUE/lydQkD+bxx2l6p
 yaNA8KMORjr0kXiUhg7hmAisJYxf1UdMgDTehoN+wd1DQnwfeRGytLMbR3a+LEwjfdOmqBkcjDw
 =
X-Google-Smtp-Source: AGHT+IENo1UUwWHZnxI/cViU8AICusBJ44IO4NbRRgIkxhFh8VTlD7jJbovQvSNLiKbS7+CQ9gSaMA==
X-Received: by 2002:a05:6602:2d8e:b0:825:2c2c:bd8f with SMTP id
 ca18e2360f4ac-82a11094862mr396923839f.14.1724943504361; 
 Thu, 29 Aug 2024 07:58:24 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/19] spl: Allow serial to be disabled in any XPL phase
Date: Thu, 29 Aug 2024 08:57:53 -0600
Message-Id: <20240829145802.1827952-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

The current check looks only at SPL, but TPL or VPL might have a
different setting. Update the condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 143ae96baf0..8b868a298f2 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -837,7 +837,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
  */
 void preloader_console_init(void)
 {
-#ifdef CONFIG_SPL_SERIAL
+#if CONFIG_IS_ENABLED(SERIAL)
 	gd->baudrate = CONFIG_BAUDRATE;
 
 	serial_init();		/* serial communications setup */
-- 
2.34.1

