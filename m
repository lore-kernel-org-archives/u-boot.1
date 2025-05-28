Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E9C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997F6839B1;
	Wed, 28 May 2025 10:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ObqEKWkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF3B839B1; Wed, 28 May 2025 10:26:17 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E0C83966
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8613f456960so112690039f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420773; x=1749025573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/F7ZKFjgIIdFHF+5ezJXwGBVrAHJn0FntQe7WX6C+w=;
 b=ObqEKWkFkTFrgocnSvJdkWYTwvXF+8+XSTHruCvCD5WKis1bXPQ1/+v41Owgn9npwO
 LlEFkfhDMhZXps9gLOhHiSiKd4EbwRbHXSUtUO7owshztcKOPMN9kbsjz+wRW2sb9oPW
 fgi0pYflvGPm8Im2Ge8KDg1Rj74y/VaMjiTOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420773; x=1749025573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/F7ZKFjgIIdFHF+5ezJXwGBVrAHJn0FntQe7WX6C+w=;
 b=fJ9tX+0s2riW1ofG5qNADkxL9nvamUpudPVLkE91rpl6mX9tYkDjFs52rtafifNM0P
 UQh5OOhuRyD/nq3iyvsXDW5Q3Qa3F89H5i4eFbUM8jjh6Hb1nIZJXz+Dfp9+aPLMy1zI
 8cHRdcALxgZucbxwPdHZQ78KykTvz7ZeIP8tvGV7i/SOUuMGk2FxjY0rd0A1KcqvvVbB
 pFRVNhRHB/TQZWhvtBcVorELYF5DhPTzkYY/lemd+GCeqwut/n4jpiFE/y443gPUibxY
 2/8XzGW3PPS4pE6AY9Dc1sLT4LRfeA7gl2pGXViGobu4twtc06cdbUWeRhHz/pHQjJlS
 FIEw==
X-Gm-Message-State: AOJu0YzFuA19qUslUsk1RyYmlPWbX8LM4W7Iwj7qZQWyjR5lWLJnat0T
 b/a0ZRPrNha3WzaipFB8N2U3xqhQm+AgJvQwjJhd7WllHn7wOW+IJIExWC0zV2eAf2NJZVaFaDw
 lLkVtURSq
X-Gm-Gg: ASbGncvM2HQ47hHQVXT+RhvxZeYq3ayI9mKDuKsZcElKuWvkFTh/ZXB7IHyu9ziDQ8i
 W6mK0mzQMs/cWrwa0MEEYSY/nKAr0tdmzaX8j7ZtIP5rY2dTXXAWKP2evqUFq5URR2tCY972klh
 Tvsoztk0Tec2hhh06jbzW4F+tuLKiI52Vtxjd+suTvhF7lhDKmp5mHBnTC+n8PtqXMuM80TPLOC
 E71ynsLNcSB5XrW/0utC8TTZybhW/f7/9qbf3AjKgorkMOPdFIOfnh4JYPc4F97pNGvcyXT15Z7
 7+3aFwt3IB0Tbeg4Vw6f9Wb25qCgeKoUin8LUPZ8914Rfkk/j9OEjiHqX5Tq0xtveV5ct2tN55H
 KU97yksk2bexh
X-Google-Smtp-Source: AGHT+IEUgeK31zCp9BMC7wt/iPVpPjCXt2cf77F57jUGCjw4aeZW9Xwknb5LmeQ+TRzJLwCc8XoEmg==
X-Received: by 2002:a05:6e02:310d:b0:3d9:6c9a:f35d with SMTP id
 e9e14a558f8ab-3dc9b687855mr146676055ab.10.1748420772926; 
 Wed, 28 May 2025 01:26:12 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/27] efi: Rename the media device
Date: Wed, 28 May 2025 02:24:40 -0600
Message-ID: <20250528082520.152391-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

The current name of 'efi_media' is annoying in that it must be given
with 'bootflow scan'. We would prefer to use 'bootflow scan efi', for
example.

Rename the driver to 'efi'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/block/efi-media-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/efi-media-uclass.c b/drivers/block/efi-media-uclass.c
index dc5e4f59b7f..0e662e01d25 100644
--- a/drivers/block/efi-media-uclass.c
+++ b/drivers/block/efi-media-uclass.c
@@ -9,6 +9,6 @@
 
 UCLASS_DRIVER(efi_media) = {
 	.id		= UCLASS_EFI_MEDIA,
-	.name		= "efi_media",
+	.name		= "efi",
 	.flags		= DM_UC_FLAG_SEQ_ALIAS,
 };
-- 
2.43.0

