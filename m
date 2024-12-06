Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83241E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC678976E;
	Fri,  6 Dec 2024 03:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fcTqljIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1133A89761; Fri,  6 Dec 2024 03:38:10 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E508975E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8418a2f596fso47720039f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452686; x=1734057486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MOGQ2zyftS1Xz2K5qYTDlxJ85b4+CYNa3WpB8IuHTM=;
 b=fcTqljIKt1tahwhdJiLZ17iBaDde2w4vvelq+JKfZwmMFCL61xkxUHuLR0u4ezk7cq
 96hDkAnitXpiEZC+0x5O7bhhM+0UUWvOUO5SByN66HRU/WVx+bPrkWJe9w/9cQpKq2W7
 pTrA2iUIRjvtOa2F5Jpao/cQfZGNF2lot2NcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452686; x=1734057486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MOGQ2zyftS1Xz2K5qYTDlxJ85b4+CYNa3WpB8IuHTM=;
 b=JVzZfM0MZmvNU0Swpg4lJ9cjhlwdPCIMVoMzixjB+s1Dpu2EWO/D19Dp+f/0A1ZXNh
 HpVHVubesA1YiW6sPQRXoZkk60DW2Zdgzkl6XkWF6eenHzsnEsZW8m2EfCOcfNM/+mUw
 Fg0m8zLn9o0kJTn6L39cGPIPoWvH8weEvuKbqW9SpUQVS98UfVTbNs5YBu7zksoESKiE
 TYneAVOpKP9tAu/ELnVvuMkORuKkfFGaMRkJH1DUDw+EJ20DCuzn/uuRdiTDiGt75kEj
 qckamTVbW/wMUsUXL+wWMyaOVxR+GltZ96cXjnDhGs04d03n8ZB2lJFW/+U/9zlwIYTV
 dIuA==
X-Gm-Message-State: AOJu0Yz7TYweRMrlXWDOGtRoQYRBiWtSQ1es7GWKNi8rPFFxrL+sAYMd
 kNe6jxXUbTss+ngv7gvpg6nJtQsNUO2CJNd+WlyWLYS3pH8Uihd0HstwT3VqPAddK/KhJf1wcvE
 =
X-Gm-Gg: ASbGncuGGz8DGOMqkDsTFDWk21ZK04AzY4od2IROkI/Wt8fosNMAHkJWmQRiR2QJFNp
 PMOyV3maLXE5RQQX2XXfiV9j95jaYud8e0kHXCc6DhP1DISTFOOyCH7ae5AYdb9pdVipOuMgl1P
 SFJwZEoFXysNaDOMjErQL0sXzTymxvFSHkI7IBKZWtf5t68Mq1WIbT+fEmfXtCdildeh+HVRnTi
 kDPN5iRLPwc/vUto6lEMVkUUj3o8Fae8OEohAL3UB/jKMTHaXXp3es0z1vnD0N78rdL1aF1doNf
 gQu5UeWa5DU=
X-Google-Smtp-Source: AGHT+IENxOdKhFOTM5EZg1dvM47gNKePTuL9xGjYBRb49fH6WqlbEqDAo01Wje3i9Vi2ojiDxDgjUw==
X-Received: by 2002:a05:6602:2c07:b0:83a:ab63:20b with SMTP id
 ca18e2360f4ac-8447e220e9dmr230148339f.4.1733452684574; 
 Thu, 05 Dec 2024 18:38:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 35/46] bootmeth_extlinux: Move extlinux_info into plat
Date: Thu,  5 Dec 2024 19:36:14 -0700
Message-Id: <20241206023626.2456858-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

This struct is missing a comment, so add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 569f9d760bf..e2050af8203 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -22,8 +22,15 @@
 #include <mmc.h>
 #include <pxe_utils.h>
 
+/**
+ * struct extlinux_plat - locate state for this bootmeth
+ *
+ * @use_fallback: true to boot with the fallback option
+ * @info: Info passed to the extlinux_getfile() function
+ */
 struct extlinux_plat {
 	bool use_fallback;
+	struct extlinux_info info;
 };
 
 enum extlinux_option_type {
@@ -175,20 +182,18 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
 	struct pxe_context ctx;
-	struct extlinux_info info;
-	struct extlinux_plat *plat;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
-	info.dev = dev;
-	info.bflow = bflow;
 
-	plat = dev_get_plat(dev);
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &info, true, bflow->fname,
-			    false, plat->use_fallback, bflow);
+	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-- 
2.34.1

