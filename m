Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF3C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36F287049;
	Sun, 12 Nov 2023 01:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ffE+dYbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0231E87006; Sun, 12 Nov 2023 01:10:09 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB0586F87
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7ad501764f4so137695039f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747780; x=1700352580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bNuPK7vgy0bmMM+PUf6EJhmvtWDrW7ePjaWQZ+y6AA=;
 b=ffE+dYbVWAFBxXtQ6aROCUHm4wAU5RcKgbJdd4M59WU6PzxEJXI9PnXQ9P1kjikNBl
 8yZ5F5AWMzdm4DL/1XfgztiJH3O1iPvfm/1SkGZqo+0KghpUZISeV8mo9Uz+xwWijjhs
 YCEE3re8OBqJo6dDgoEUKeGL/Q8W+qphwH/sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747780; x=1700352580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bNuPK7vgy0bmMM+PUf6EJhmvtWDrW7ePjaWQZ+y6AA=;
 b=N9Sexh/1J0EKHY5DKLhooppJEJtJ6FMZa7ldKXI8qEWVw2ZqotvYwGyClEbrUlO3FY
 yDOOKmELanYAp60dYL6I96eUpNsCgrqS8C3abvCu/qDHyFixZ9hXmp6iTQssiRTEZF3r
 7b8TluulMCbIoc80RmhmUDMV5RarJpwzFKh8SzsQV26u8MNW6TO55X2bjZX9G5iDzd98
 YBk+8UjsPY0iXi5gcnzk4LRCYXuHcJ9i29jRSZRjuP+/2179QWjb0rLnqolTX6zqoTL1
 EPYLbQeuxpw0U7+iXPzCjcSVgoEcAHd04NqDCNMVwwOvT1L5M22/NI2XGJl2nsJQ8rlC
 bC7A==
X-Gm-Message-State: AOJu0YzOqGZlA7PW2uO7Cn/VEMh7DGtDCOlrG56KGxfT1480h/nNEED0
 t2DwNbwisa1nDiMaRjg7wm8VblYl71BSVxItsRqGcA==
X-Google-Smtp-Source: AGHT+IFmkcpMNhhCDZW55WOnCoX7IfsrPvquFozh1bqFGXrBJ5xk1g7lwDdM0HV1Ry+Nq1sSs+oywA==
X-Received: by 2002:a05:6e02:174a:b0:359:d13b:e3bd with SMTP id
 y10-20020a056e02174a00b00359d13be3bdmr4900903ill.32.1699747780803; 
 Sat, 11 Nov 2023 16:09:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 11/29] image: Document error codes from fit_image_load()
Date: Sat, 11 Nov 2023 17:08:56 -0700
Message-ID: <20231112000923.73568-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

Put a list of these in the function documentation so it is easier to
decode what went wrong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/image.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/image.h b/include/image.h
index 798c5f9c16e4..d37e44721672 100644
--- a/include/image.h
+++ b/include/image.h
@@ -728,7 +728,13 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
  * @param load_op	Decribes what to do with the load address
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
- * Return: node offset of image, or -ve error code on error
+ * Return: node offset of image, or -ve error code on error:
+ *   -ENOEXEC - unsupported architecture
+ *   -ENOENT - could not find image / subimage
+ *   -EACCES - hash, signature or decryptions failure
+ *   -EBADF - invalid OS or image type, or cannot get image load-address
+ *   -EXDEV - memory overwritten / overlap
+ *   -NOEXEC - image decompression error, or invalid FDT
  */
 int fit_image_load(struct bootm_headers *images, ulong addr,
 		   const char **fit_unamep, const char **fit_uname_configp,
-- 
2.42.0.869.gea05f2083d-goog

