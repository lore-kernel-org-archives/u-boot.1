Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBBAD68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0168970A;
	Sat, 16 Nov 2024 00:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1ONwruH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B289D896F8; Sat, 16 Nov 2024 00:20:23 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E79C89704
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-83a9be2c0e6so3546639f.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712819; x=1732317619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdACeBKwkgcjFu/CPGOFCTwq55oB25rrOf5W8uwsOTk=;
 b=c1ONwruHU6IxpQhn/8lSkSlg5OitNwccRI6/+OhDiHNQxSxnjXnSO2rS2dRhL7g1Bi
 mQQtp2HVN9pIjRA01IuTEViNlVRU5xvWD2pggA2qeknSGKlQ1FSv1EfVizKAUT7QRqKz
 QCLsuTjHnsIom1CHgyLkqMtDRpjujdgXKlt/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712819; x=1732317619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdACeBKwkgcjFu/CPGOFCTwq55oB25rrOf5W8uwsOTk=;
 b=lMw7A1BwwxSp3W5em8nRYVXIvT5MFu+lxqKRJ6IgZ39qkqzTsz5LbWSvH/xO9DZAKY
 9M4v+qsZ/3nZSYKNeyZiUl+Dw+NFMnoLNt15hcvjMgKl/novu5gy+9Y+EeN/PGIiqLbn
 sLToeDzQo8TI+m/qeL2nvK6dofXlPr3Zrz3M9gXBDwoXFmw3bHqXEiC08W2/fEBrWGMP
 VoBLkAYXkvAq4U3kjMMUKkLUo4HPaETBNLbGls+ipkLuc0VCckDdB9IJWj9ybaiYWcU8
 eBYuJ33l/0oExKRrREC4xa8TytFRwzsW73WKwns7O4F9Uf3fvRZVERiUwa/wR3IB1kbo
 0h8g==
X-Gm-Message-State: AOJu0YxkvEQ7fP36+1VLzyFkYcuMS3B//IN6ogYsn0rONohkVhOugY0h
 8SxcQ1LykuroG1a3lUu1IF5qqXRGYJMwpJMobvSyG2rFaKayd+WnX+U3WjMgjvJg+aSsLXtj3Tg
 =
X-Google-Smtp-Source: AGHT+IGu4LSFdIm7iZF9+mijjQ8DvbsTipzkNKzfKNqyGiP5wyO1eEYWOol+WK+E2joq/JzZwElE8Q==
X-Received: by 2002:a05:6602:3fd0:b0:82d:13ce:2956 with SMTP id
 ca18e2360f4ac-83e6c15810cmr508281839f.10.1731712819151; 
 Fri, 15 Nov 2024 15:20:19 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 17/19] bootstd: Export bootdev_get_from_blk()
Date: Fri, 15 Nov 2024 16:19:24 -0700
Message-Id: <20241115231926.211999-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

Export this function so it can be used from other files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to export bootdev_get_from_blk()

 boot/bootdev-uclass.c | 2 +-
 include/bootdev.h     | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index a4e1d79ec9b..65a3b89e40c 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -319,7 +319,7 @@ int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp)
 	return 0;
 }
 
-static int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp)
+int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp)
 {
 	struct udevice *parent = dev_get_parent(blk);
 	struct udevice *bootdev;
diff --git a/include/bootdev.h b/include/bootdev.h
index 991b6229c1c..12c90c4ec1b 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -401,6 +401,15 @@ static int bootdev_setup_for_sibling_blk(struct udevice *blk,
  */
 int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp);
 
+/**
+ * bootdev_get_from_blk() - Get the bootdev given a block device
+ *
+ * @blk: Block device to check
+ * @bootdebp: Returns the bootdev found, if any
+ * Return 0 if OK, -ve on error
+ */
+int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
+
 /**
  * bootdev_unbind_dev() - Unbind a bootdev device
  *
-- 
2.34.1

