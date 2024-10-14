Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C42D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B355189247;
	Tue, 15 Oct 2024 00:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C5Tisx++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7918921B; Tue, 15 Oct 2024 00:32:27 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E800A8921C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-835464abfa7so158517339f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945142; x=1729549942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5H08RIShF2uL9zUQ6iF/E3wVm0Tzik7+Gq1/q8sFQc=;
 b=C5Tisx++OTqsjU8K5UMvsdHe0BFc8YYcSmrvYyuzKuEbloD8u5PXvol8HaW/GcbRn9
 Y7EFCX6olEMpb8F8NjpD9aRYMBwNkHhbJWkPz3/OQoooaji0boS+ZRtBaOfSgFFB4B5k
 fzFhHfU5oAIlaGhwxtM15vvnfB0AsXGJJ+aok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945142; x=1729549942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y5H08RIShF2uL9zUQ6iF/E3wVm0Tzik7+Gq1/q8sFQc=;
 b=Tk6EcAHRc+/3rDPMMNksiBP6Zxb0Af5qMuI3LnOLF9xQQU0yx6vRRuC6yU606GaFRm
 shdcDzVvdrM26poGicVoICqpfLhgAiT0jO9HlfBFBqLTAJtME4GqAgf2K2qpgRgyBid3
 wtAsnQDcws9XvKW6vx3/+OZRXH/uEGeJa8mmcxxUK3g9IXhV31CNuc/suGQPvo1g1JLH
 7NiUV+06kb0b9Oztgd3+713RSn4U7cB1Dtbo4ukFE0gg1/W5NIGlHOeFLe2wl9oCWcpu
 prriaI4I+RQtMF/wn3zWUvxCLl/yzL/ciJQ0Si1oDhD2WVOkpkOcd1TyWq0rXCQN4ME2
 uKCg==
X-Gm-Message-State: AOJu0YwZHakHpkyrjsckH5uwX4j+KmfOCf7wn5awIkQn6UV6PRD/Q1qs
 Ew4QfV2OBcw5zKe1wRkmotv+0TPV/qGfuN2Ms70X/zXHi1DoXfYVTniIVIgoiBx6fxy5LgqTB2p
 8128g
X-Google-Smtp-Source: AGHT+IFhRJfHRAlVoQuDRNFm/NrMpq1mnmU2wQi6YPcPK2RQADkvk8Yw0o9DFs94EUNIZ65OfOaiOQ==
X-Received: by 2002:a05:6e02:b49:b0:3a2:e9ff:255a with SMTP id
 e9e14a558f8ab-3a3bcdfe432mr82302505ab.22.1728945142565; 
 Mon, 14 Oct 2024 15:32:22 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 07/20] expo: Add a little more cedit CMOS logging
Date: Mon, 14 Oct 2024 16:31:59 -0600
Message-Id: <20241014223212.2212442-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

Add some more logging in the CMOS read/write code. Tidy up a few
comments while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index cd935d4beba..9d48d3ed50b 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -584,7 +584,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 
 		/*
 		 * note that no validation is done here, to make sure the ID is
-		 * valid * and actually points to a menu item
+		 * valid and actually points to a menu item
 		 */
 		menu->cur_item_id = val;
 		break;
@@ -718,6 +718,7 @@ int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
 	}
 
 	/* write the data to the RTC */
+	log_debug("Writing CMOS\n");
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
@@ -785,6 +786,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 	}
 
 	/* update the current item */
+	log_debug("look for menuitem value %d in menu %d\n", val, menu->obj.id);
 	mi = scene_menuitem_find_seq(menu, val);
 	if (!mi)
 		return log_msg_ret("seq", -ENOENT);
@@ -819,7 +821,7 @@ int cedit_read_settings_cmos(struct expo *exp, struct udevice *dev,
 		goto done;
 	}
 
-	/* read the data to the RTC */
+	/* indicate what bytes were read from the RTC */
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
-- 
2.34.1

