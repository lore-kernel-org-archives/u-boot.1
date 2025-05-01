Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3062C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8BC8290A;
	Thu,  1 May 2025 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DK+f7jxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4D382905; Thu,  1 May 2025 15:38:05 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D0158070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso70782439f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106679; x=1746711479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oROTjQ1bqfHH5/fGUml4gwC2M0oCPW/hK6IP17Zt8Js=;
 b=DK+f7jxkfBghJNNSmUk3XkazUwokOfB3dg+r8fAOKSO1S2xYpwmP5opRsr/4dlMPpv
 3to82SiO0CcHumwEd0+XaMHggNauRGRO1SexMn76M+X90hZ7iB23oIOfu3h1zPXuMAkf
 Xm7RfejL6GJqXh1HL6fLZHkC8jYtYczbRqK/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106679; x=1746711479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oROTjQ1bqfHH5/fGUml4gwC2M0oCPW/hK6IP17Zt8Js=;
 b=oQB0otr1Xm/AIA/GwFdQftZaWLbHxIoieWIF+asHh+BmtSip9vC3Omujho5/rFCd1P
 hfIRCS6m1+NuuNVSfD3KmxnE62Z+3XZE0ac2+r2qRBdFEru5zjUOOXOnkX64XHe/tlGL
 RtXOBL9+DLsHa9K975jpmrZGCOH0Z0FjCcGHNebGSXgZF0ornC8MPIuURbv26zawP9a2
 qJ/9yQ/6wIlMFHsBec5V/JRUKxQvThq/dtR2wipDXvzm9/XRz4sGuI0o2ZG/9VieQgh2
 R+fH8HjlUGT1QQWVginU11mkWWAOKa13uwHaQynPaxACouOEEn37l1QqSwe5i8xp+aGW
 EwJw==
X-Gm-Message-State: AOJu0YwlvhKmstuebeetsbs8ozOzoaaXeOtFqVI0FiH6f9rwBjVtIoVL
 FHYAu391XTe5ZVVahnf8RofgTNEAhUYFDCXr8m6iTUVmVmTwEg8ML+j1/kZ2ymrryYj4FCCHsCg
 =
X-Gm-Gg: ASbGnctpcN0Kawd7dUCVIL3kbkBTT+Mbf7yeR6gi8sQa6HbM1jov/T/XlNwhKZXmnAQ
 b7WIPCUkvXjxHY1+GnppDBhubVuGYCuVoSnsb+0xKhl98LQ1sOOwDsjsK1tAHe908msXVIB0sYO
 8n4hHcU2vRYKpB783fxmhPqWX+lCoOkbas62bNPm0PIWMHEKmUgrFQ960eD2lMxMXWsZRcjGq/q
 /vkjei6roXqht/90tfqsdpCYuRm27qjQLfWGf5lSphdr0cxsZMr+qWg0rscswktwa3nwE4NnZDH
 3J+VkDYDbyc5ieRGlNmPHXj/MstBM3mXF4wJjs6j9c35qaFsklH0Ys9qnDUmhpBqgiktIdu/A24
 gAhZZhgHhNR7m
X-Google-Smtp-Source: AGHT+IG3JWTu6BM75sOG0l5Mz0CQSnJPcmtXp+JS4sVZpcg5LDNs5UV7NSrI3+TbW2gZKx2792HieQ==
X-Received: by 2002:a05:6e02:3707:b0:3d6:c2ff:eee2 with SMTP id
 e9e14a558f8ab-3d970b5dd79mr35283925ab.6.1746106679399; 
 Thu, 01 May 2025 06:37:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/18] bootstd: Expand debugging in bootdev_find_in_blk()
Date: Thu,  1 May 2025 07:37:17 -0600
Message-ID: <20250501133726.2627373-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

Add more info in this function so that the partition number and the call
to bootmeth_read_bootflow() are logged.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 80371c755b2..76397a1a990 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -126,7 +126,7 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 	 * us whether there is valid media there
 	 */
 	ret = part_get_info(desc, iter->part, &info);
-	log_debug("part_get_info() returned %d\n", ret);
+	log_debug("part_get_info() part=%d returned %d\n", iter->part, ret);
 	if (!iter->part && ret == -ENOENT)
 		ret = 0;
 
@@ -188,8 +188,9 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		bflow->state = BOOTFLOWST_FS;
 	}
 
-	log_debug("method %s\n", bflow->method->name);
+	log_debug("using method %s\n", bflow->method->name);
 	ret = bootmeth_read_bootflow(bflow->method, bflow);
+	log_debug("method %s returned ret=%d\n", bflow->method->name, ret);
 	if (ret)
 		return log_msg_ret("method", ret);
 
-- 
2.43.0

