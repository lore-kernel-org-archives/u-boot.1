Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75310D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63F91892A9;
	Fri, 18 Oct 2024 01:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KCmTiJzP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C978D89257; Fri, 18 Oct 2024 01:25:16 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A168C89258
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-83aad8586d3so76045439f.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207513; x=1729812313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIZN6cYtSuCe9b9k4WHrqy+BGt8vCibL9mKvBnIXkcc=;
 b=KCmTiJzP7O6b9DMHSDhKQHq+HDjm8dqLqJC9HGZI2LV9vGq5cGhyvEEiGRyd9IuAmq
 aQElSIwvgCk2wGRnVP3uPwp7kHURLNhvEDR57rFW+JLRg+pKMKyneB1G5LsoY34TsL6M
 25vWf984RavPYbE2uCNZi2kvy/j9BkhpAvwB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207513; x=1729812313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIZN6cYtSuCe9b9k4WHrqy+BGt8vCibL9mKvBnIXkcc=;
 b=lH339xp6ly9Pu4H4gJyWAHAimzLzsAIz23F8dCLG6qfpywRLJtnpW95jIjJQApbhqF
 IgMA8Oa3P1Sv6m5l1VJpWqEzsPIyS+WsZcvc9+XWH1wPTrA3c6bdGzqISUT35RgHx4jx
 iAQubm5Y+l9B6foB+/8rDRsTw1zyw0Kr4O+aM27AtpHS/1PAnSOSFgAbvur3ldVN0iFh
 KskzMTteNVm6ReE47r+DFTzGBeoz0ISt1SxxhRtW7isiWbkB7FbaOmA3sISzVlw1M9+L
 fhJ1hYlBcYzywbuNxRSKAYhgk0JQl7Ycl7OhoZhAbEPdFW8zR3RWQjSgy74dIaamoSAW
 Qy/Q==
X-Gm-Message-State: AOJu0YxzlqRKlk8TRMBbXwxY5pm1jj73ccH8AbnEAkwqOroo/WzYjFdO
 ArLQYmw9ys25vZoDrr9oon7Gi/dECZsc/q9Fdoxp+9YTGA/d+z9fK5LfeX6LslliVYqB2ibBm28
 =
X-Google-Smtp-Source: AGHT+IHwjtMgF2FzQAdFoUcHy1SLOZEw63R2+wbjUqyYtYy2FmctTZFI/G0XE9wxOGoZQfFqw6LK0w==
X-Received: by 2002:a05:6e02:12eb:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3a3f40636cdmr3950375ab.15.1729207513307; 
 Thu, 17 Oct 2024 16:25:13 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 31/34] Update bootmeth_alloc_other() to record images
Date: Thu, 17 Oct 2024 17:24:10 -0600
Message-Id: <20241017232413.724808-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

Update this function to add the image to the list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth-uclass.c | 15 ++++++++++++++-
 boot/bootmeth_script.c |  4 ++--
 include/bootmeth.h     |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 726393e20b8..fcfffa41533 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -364,9 +364,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 }
 
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep)
+			 enum image_type_t type, void **bufp, uint *sizep)
 {
 	struct blk_desc *desc = NULL;
+	struct bootflow_img *img;
+	char *img_fname;
 	char path[200];
 	loff_t size;
 	void *buf;
@@ -393,6 +395,17 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("all", ret);
 
+	img_fname = strdup(fname);
+	if (!img_fname)
+		return log_msg_ret("alf", -ENOMEM);
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("als", -ENOMEM);
+	img->fname = img_fname;
+	img->type = type;
+	img->addr = map_to_sysmem(buf);
+	img->size = size;
+
 	*bufp = buf;
 	*sizep = size;
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index f01b22b064d..e648e42a24e 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -107,8 +107,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (ret)
 		return log_msg_ret("inf", ret);
 
-	ret = bootmeth_alloc_other(bflow, "boot.bmp", &bflow->logo,
-				   &bflow->logo_size);
+	ret = bootmeth_alloc_other(bflow, "boot.bmp", IH_TYPE_LOGO,
+				   &bflow->logo, &bflow->logo_size);
 	/* ignore error */
 
 	return 0;
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 78b2ce4123b..7382f76c0b8 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -386,12 +386,13 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
  *
  * @bflow: Information about file to read
  * @fname: Filename to read from (within bootflow->subdir)
+ * @type: File type (IH_TYPE_...)
  * @bufp: Returns a pointer to the allocated buffer
  * @sizep: Returns the size of the buffer
  * Return: 0 if OK,  -ENOMEM if out of memory, other -ve on other error
  */
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep);
+			 enum image_type_t type, void **bufp, uint *sizep);
 
 /**
  * bootmeth_common_read_file() - Common handler for reading a file
-- 
2.34.1

