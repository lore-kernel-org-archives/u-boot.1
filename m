Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CEFC52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 13:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADD68890A;
	Thu, 22 Aug 2024 15:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cuUzhoV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DEC888F0; Thu, 22 Aug 2024 15:55:31 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CA68870B
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d3b89ded1so2967165ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724334928; x=1724939728; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qf7fcrtYbSX8z2HBiPAuNHc7m1MrGdeZ0jMc562veCQ=;
 b=cuUzhoV/x8B026VPD26DCoQFrJRxgMgSbWzfqH5dLbIZvAyuuvs2YyX0ycSLPd/+aP
 gPiEGkUmDcPm+9schJUXn4Kka0EFuJT0+qdI1at4enAEuAfYabRM/+GDVLVgbqGm2mEn
 MWEFu0r3wsoXaTIDvmhozt5FUOlQOxqrKY0QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334928; x=1724939728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qf7fcrtYbSX8z2HBiPAuNHc7m1MrGdeZ0jMc562veCQ=;
 b=imBKF8znpvE5ZZrLa1ma/DVQowNxiV3owAkFMfeBpHQpHpANII+A5txlSzrgkEpYq9
 VzrIM+fMLwHb+k02n+kJe/KAVaYxu/9YJxWXpnsXH4n55xPF07xT9N5Tdz4s4Za3vC06
 D1LGucnUT4USbrv+fXKXEnDaldsl9Q2siGE+uGcps7bJtbIJRNojh4gAFdprT3RLS9A0
 dLfZ3ImvjomLEg0fxN/GPhp3a9c0lDNp4npiuPFug6lVFjmJOMZaJV7eT/mJleZ1vumb
 86U866H+VlV1LkUAGkU/87xjCnd3aCyWqIz6sjn6MU/xTDU3qoRzBZBD7WMT/nvlXUy6
 61AA==
X-Gm-Message-State: AOJu0Yzjm6WuxXtQ6oOrSMBBwBGDTtxYXxYxZ/+qtsMefem8V3d9yu25
 28bm2UlM4F9LhbsgD4ojuYdFAcnX6CIJFN0OSInAW6Ai8u9NdvWVeVBFLXkftpoZTL2/scHP53g
 =
X-Google-Smtp-Source: AGHT+IHjYYZuIbyFgWSoLS9NCV0CHD8smlsWWRvqFkQfuYsd+5jRQbjL75MhNt76xdk2hngS3T/nsA==
X-Received: by 2002:a05:6e02:2148:b0:38b:48c9:55d5 with SMTP id
 e9e14a558f8ab-39d6c38a621mr66591825ab.13.1724334927667; 
 Thu, 22 Aug 2024 06:55:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e7c1eesm6692585ab.39.2024.08.22.06.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:55:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v4 02/14] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
Date: Thu, 22 Aug 2024 07:54:51 -0600
Message-Id: <20240822135503.2363706-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135503.2363706-1-sjg@chromium.org>
References: <20240822135503.2363706-1-sjg@chromium.org>
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
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 common/spl/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index d6a364de6ee..028cba964fb 100644
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

