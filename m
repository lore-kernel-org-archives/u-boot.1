Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D5AC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8723387A3B;
	Thu,  4 Jan 2024 16:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEUFXjPE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB189879D3; Thu,  4 Jan 2024 16:12:27 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D02C1879E9
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-35fb96f3404so2166205ab.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381125; x=1704985925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtOUgHDqyJ4NkOjur7RCEjrq4RM6lSMci9ss37m6X0g=;
 b=ZEUFXjPE/kYEcahuuUCPla6Dfz802fArHOK5lC6ORE7W5WV+2UDvFkyuI7r7RMlG7c
 mlskknuaYA9oy15n6utYtGdTzW0Yk78fHvIHdytwCQkxsogadk0UisUzSsuDwMImYSwT
 9CvYKIjeiLATZBdCkcmbFawvhh4G5ICKqet94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381125; x=1704985925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtOUgHDqyJ4NkOjur7RCEjrq4RM6lSMci9ss37m6X0g=;
 b=hsNL8gYiqKs4R0AI2N1aAwvP+QX3/pEjM2OCdt9W6jL8eN/OJ3p2qJ2d/mAUOKq3ki
 uH6DmR4Wemvv8bOeO8CQ3S7+tPkT2C//3EiHQp8SIXe+j+w2r4UbE82Y5IFGnFsZbmqt
 7DQZg1ctltcXDHc0LU7W4RaA4AeuLqDDh/P20gZr3LarsLFj8VbBarIiqOhOHO4jq06t
 VQV6IuC4mQ0Aiq0RygWxuy3wa+cL5m1grdN1j9JeLkcby6LRCehAQQH5XJ7cuMf72PGZ
 CfODSsaEeeZbz4JUnbZo2jRvoAsqHXXQr/m0ywhlWX3U95oq+Q1ZdmkLpWBybUdePPOk
 DSxg==
X-Gm-Message-State: AOJu0Yx66yVoneU5jMOu2Dm53+6e6VwQDHnVPu6gu7CVdpbilrcgBP/s
 Oftd6Th4/wTADmJkQnjDNgWgu3RnmBgdwuFbkfgMXRh+epsvZGs=
X-Google-Smtp-Source: AGHT+IFfVWrWT3x62jmh7Z547nZXY8Bb6kadrKmM6fIRt6+BW5SKVQpRZs9iX+KauB15ltpDx9GBXQ==
X-Received: by 2002:a05:6e02:1c87:b0:360:17a8:5c7d with SMTP id
 w7-20020a056e021c8700b0036017a85c7dmr749620ill.6.1704381125545; 
 Thu, 04 Jan 2024 07:12:05 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 07/19] expo: Add a little more cedit CMOS logging
Date: Thu,  4 Jan 2024 08:11:40 -0700
Message-Id: <20240104151152.697855-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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
index a53a4f28990..cc1d5b76357 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -585,7 +585,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 
 		/*
 		 * note that no validation is done here, to make sure the ID is
-		 * valid * and actually points to a menu item
+		 * valid and actually points to a menu item
 		 */
 		menu->cur_item_id = val;
 		break;
@@ -719,6 +719,7 @@ int cedit_write_settings_cmos(struct expo *exp, struct udevice *dev,
 	}
 
 	/* write the data to the RTC */
+	log_debug("Writing CMOS\n");
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
@@ -786,6 +787,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 	}
 
 	/* update the current item */
+	log_debug("look for menuitem value %d in menu %d\n", val, menu->obj.id);
 	mi = scene_menuitem_find_seq(menu, val);
 	if (!mi)
 		return log_msg_ret("seq", -ENOENT);
@@ -820,7 +822,7 @@ int cedit_read_settings_cmos(struct expo *exp, struct udevice *dev,
 		goto done;
 	}
 
-	/* read the data to the RTC */
+	/* indicate what bytes were read from the RTC */
 	first = CMOS_MAX_BYTES;
 	last = -1;
 	for (i = 0, count = 0; i < CMOS_MAX_BYTES; i++) {
-- 
2.34.1

