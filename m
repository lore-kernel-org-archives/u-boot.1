Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B72CC19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13EC8193A;
	Thu,  6 Mar 2025 01:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C1403dbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBFD281668; Thu,  6 Mar 2025 01:28:17 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17200818C7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so9488139f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220837; x=1741825637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUs/gG60B8+RiCo/7wOfylBWGPQx890cN3RKbiyoc5k=;
 b=C1403dbOa2zilnS5hTRqVuuc03h4UAXv3f6T3Fvk0fV5b5JFDJ+/i6gUN0lODjt1W/
 5fCrL48nAeesj1gW9ZL76+DPwsdoCaPEUq6zEU7tF6/al8yV4QxTdA3uqRt9UAij6W5G
 8Zz8nAcvQg9NQgGNMbukoeueQ9xJVV81NTcQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220837; x=1741825637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUs/gG60B8+RiCo/7wOfylBWGPQx890cN3RKbiyoc5k=;
 b=auIdXWVg/yD8vTGV7XFcJM5L81qdr6R5if0swWGBgXl0COWjfe0YehgOLRL8T1ts1d
 lTuamuDS2W6BQOmGIyvzcGPIFI/bQEXoawpCccmLwLmoohpsxvy95I3iFhR0ZukwocHA
 xDvO5tUFAaFo01/owGNSd3mtkQ2jM66zFTi8IBZbylYAshijlLdjPbyV3ZCYk/twbiO9
 qVPfTXKze+2dzpUuWgW7e4I0/qwHKSatMwSy2UrBAHjf14ZecWq+t8fzd1AOxgCCRoBv
 Z1gFFrP8RjeccrmLtxck/nG+YDEWOyDnb69Kk27x6HjM55GkmparnpTx1WVH23rqcbRZ
 H1Sw==
X-Gm-Message-State: AOJu0YwCP5QJp/pVgp6Ca7gbDpvau/o+pmBqdCkB5lGFc2DqwoJ4Wu3E
 X1DoYzBK9WBc4K9twFcxVRPvWeHoaUYfMwE/c3Fd2bQ4o0pcjtHYE6Pb3e0j+ebNLOCV0EoZzp4
 =
X-Gm-Gg: ASbGncsQ9mBedH2R21NGo3uEsCY1VfQDR3lI1vEUWkud4lI9AmDB/2byz19/jcTF6z6
 qN2OQsKF5Cx3/3glCbSOoue/mIP/eHUhU0nUTaFzaMSKn/U0OpMl/R+Iehyi/PLQe6gxApsVgby
 aOj4H9rMSDrMX8Lvnxu8+CIUNi9CWBpOqTbsxnTT8TLu+ejlG/loauYbsmTHZoLwW3Rm9arpAPD
 9Pvs3Cv32ODTXGcQ/WUabTmxJII3kLzEi4h7dB5yb/R8RbBYVPGAf4SGLksvrMEcuv6+Yn0Mazn
 Zt/UzpGzZqgbWEbtCnGNsyTtZLYcvh9WQ8PJ961wavN9KdHd0D7H2ffQDTiPD4FRQYlDCUVVc0u
 882B9pQ==
X-Google-Smtp-Source: AGHT+IEjZQlybWYviAvwKSl3nklClUNdks0wfW/RbxpuS9v7lNAC7a30pqgtJojvPz5YY3P5vjSViQ==
X-Received: by 2002:a05:6602:b97:b0:85a:dcc4:d763 with SMTP id
 ca18e2360f4ac-85aff8bc8f7mr630783239f.7.1741220837278; 
 Wed, 05 Mar 2025 16:27:17 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v5 19/29] pxe_utils: Simplify default fdt in label_run_boot()
Date: Wed,  5 Mar 2025 17:25:13 -0700
Message-ID: <20250306002533.2380866-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

Tidy up this code a little to avoid two calls to env_get() for both
fdt_addr and fdtcontroladdr

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Add new patch to simplify the code reading fdtcontroladdr and fdt_addr

 boot/pxe_utils.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index bbb6ff203b6..37306f37009 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -612,24 +612,18 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	}
 
 	if (!bmi.conf_fdt) {
-		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
-			if (strcmp("-", label->fdt))
-				bmi.conf_fdt = env_get("fdt_addr");
-		} else {
+		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+		    strcmp("-", label->fdt))
 			bmi.conf_fdt = env_get("fdt_addr");
-		}
 	}
 
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
 	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
-		if (IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS)) {
-			if (strcmp("-", label->fdt))
-				bmi.conf_fdt = env_get("fdtcontroladdr");
-		} else {
+		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+		    strcmp("-", label->fdt))
 			bmi.conf_fdt = env_get("fdtcontroladdr");
-		}
 	}
 
 	/* Try bootm for legacy and FIT format image */
-- 
2.43.0

