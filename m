Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35540FED9E7
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 15:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EEB84383;
	Tue, 17 Mar 2026 16:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CitCzfhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9883843AD; Tue, 17 Mar 2026 16:36:35 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08998437C
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 16:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso18274915e9.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773761793; x=1774366593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bkf0pjy5H27g3qcGhzdtejETRmrvbIFQ9YLschVbCVI=;
 b=CitCzfhbRBDmvN7Idbkzh7+Gr+LLR5bl2V4oXCbPG2AFXUKKuQkucWODuNOuhZdeTe
 2MWpjhvXDy0zSlui62g7HYj6uRt+aaEeOaMiOltwVsoY0JDnmS7DOFhl9EQxtfqUkNXL
 9ajLAqNjoztMZWQgKVcuXZl1V6lzuOEi2qukB7T6BE6O0ZCeMU60GxqhDUgL33kzu+lM
 4x5jvkWnqR1dqUTmO0mdXeLvoqvmpFg8Qsoar4WSnIGL+elUGSvLIsrcSoG8iF7W7jxf
 uzxtFtFSVAzL3a44mqxHrFK113JnOCm/19URdsTI+HA/2aYGqAyLp/sTswN+WbSGFEvW
 Hcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773761793; x=1774366593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Bkf0pjy5H27g3qcGhzdtejETRmrvbIFQ9YLschVbCVI=;
 b=DN0CgypnLSG9BOQucxmOnMhypm88IJJ+05Or+42q9UPV1mAQ58xCTCSd4b+aMiPZfz
 pESJTKWYqzkdSeH6g41vGL8E4azda3PY0O+xy/3vDnQfcl1JO2thPpmsam6o47y3g+md
 3y+WgJU4CMhMsilN0rnipRVlQidGfUuCK1B9RB5LxDN91IUm+M7rKvYudzuQ1vtBiG7K
 d/9GWJXkFy0p6c3cPHtVLGR9Uta58DXFnrO9gdQ0qYUl4ydogL3oLmraa8SRddyY6AWw
 L2w6zaVpmbSKW6+DT8XS86fS2c9QUgpzNUu4eawa5uaaRteyllBefShpWUWs9vzeV17v
 Tztg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtN1TO8NiVHxoqo8tZGvDXDSI3XVqRHjuHDV0oKSjPs8t1W7aVcjkfRujETRGIMrT/n6IGU78=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/8PNdqaoDjICm2ooitpWPv8vT+uGhiN/8xt+OdgAFg3CUTYxG
 SJIGUbQcqfJ86i61PJoac45JbHJNer1cLg6+y77uuWu+/85zleCzvhqM
X-Gm-Gg: ATEYQzwiZClUkmbTjVkzlaX1zOdGz/O4991Osrbaz+l5sfzcbVcRm3rO4cHypyj3lOm
 cdhLCjR1Z+fv9IuBvJkYsB6BMaXyB9pDfeiuR1I/ugTR6PewOAK98OvUM2iYuOidCUJY9a3xp7A
 2Jl2i+/V6olIEwiLWRvF7ewXY/lxNC5Lul2CgZD/hZeWiaZK8tJKDUJutYwj+fu+KGazHCvONeH
 gOY/lEZ019e1VXfPhuBRWi0KBBu3tk1JRBNwFMnsm1ncj6QbJQ4/Bfd9xYVmkaIs3lPhFijfGga
 m94Rgp0e0Pf6+zWFcE+BtyhV/6q1O6mCtJ3uVQ4tr7uyIcMEkxPAvJmwgpZosJSVuQd14A95eGk
 9aFdyG7mDCGElYgiM40WPU4qWXwiWMDg7Qzh1plqzaPHSKxXZfF7f/qkEBAQDLOXtogYMzbkMy4
 WxJXWUXrviFg9IClXLWaIlo7cVnwhQTwkoR6b2GGSPFrv5LkzBjZCsPrI=
X-Received: by 2002:a05:600c:1f91:b0:483:703e:4ad5 with SMTP id
 5b1f17b1804b1-485566faaddmr281480415e9.22.1773761792851; 
 Tue, 17 Mar 2026 08:36:32 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-48556414295sm200870485e9.3.2026.03.17.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 08:36:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Justin Klaassen <justin@tidylabs.net>, Harsha Vardhan V M <h-vm@ti.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Date: Tue, 17 Mar 2026 16:36:05 +0100
Message-ID: <20260317153614.18409-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317153614.18409-1-ansuelsmth@gmail.com>
References: <20260317153614.18409-1-ansuelsmth@gmail.com>
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

When dev_get_priv errors out, the ubifs is not umounted (if used).

Correctly handle this handle condition and while at it also return -EINVAL
instead of -ENOMEM as a better error since no memory is allocated but is
actually an invalid scenario for fw_get_filesystem_firmware().

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/fs_loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
index 2928cf75f89e..7e432a7ebd62 100644
--- a/drivers/misc/fs_loader.c
+++ b/drivers/misc/fs_loader.c
@@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
 
 	struct firmware *firmwarep = dev_get_priv(dev);
 
-	if (!firmwarep)
-		return -ENOMEM;
+	if (!firmwarep) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
 			firmwarep->offset, firmwarep->size, &actread);
-- 
2.53.0

