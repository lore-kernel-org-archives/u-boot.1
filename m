Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDCE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0450489736;
	Fri,  6 Dec 2024 03:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YVS/f/4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D5A589736; Fri,  6 Dec 2024 03:37:26 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 957768918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8418ecda199so55718539f.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452641; x=1734057441; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsAWBSpRjw4R0AqyMrs39o+aPJEFcT8k17IMykfCQAw=;
 b=YVS/f/4qcsJElBUea7Pz0SByPLa9wD2PKp6mQ9K1XSXvNKEVHrr+IExuUYR1qvWEu5
 Pke3g0KWC+37bNd2AXWC/jqlrM2bcKGEvBMwrHUZ/m10HuyA5HIxI2CLYdMZ/3DxUE6I
 kKJZSspjoPbBSDw/M+5zD0TFiUkrgMITmoeZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452641; x=1734057441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsAWBSpRjw4R0AqyMrs39o+aPJEFcT8k17IMykfCQAw=;
 b=LreipSZjG7TWByPP4nZzA6mI/U1K2Uuhl7OOE41wlGH5jueuDdzN4UADLKXBKl6O+C
 BXw4C7o6jyKjKSICzjC+PBa/apn8KicOGKzEqGWFH7F06ZB1fSli+DiII3VlOXq9+xGn
 eIEvWPrgt4CxGT5j1Iv6SCrEydjg7Xe6DjtcooKiU5gsKQ9jibXFo+wqKK/edSlo7wEV
 v1GhlMaOZoyZKrqCIsI4Gev5ETtHpTkmZ46Gaiu+1IiuA0BiomEbQLurSSgBc/i5O4Y1
 PmBdryUZzgmDav3yOHxE0jtC5UCZuIK90PXDHV66FAbbBg+SMlReo4TLkcVba3eVDC1o
 VxtA==
X-Gm-Message-State: AOJu0YwfuyvOchFrxUOM1yla/6j8lQsydNfaX+V+CO73dE/1384ee1ao
 7uRmAkBAmV+SzC1LuikEyeLa63hmLd2wR4sDreB6sx99tkxLjSeic/zdkuANmuiIuLCmIZKUyjU
 =
X-Gm-Gg: ASbGncuRnnKL+sh6Zs9IUKTtDXb3ilohEtQC+h5IoOemWK0w0kg4xjyTVfB6hFIRJUU
 B3JYXMmmg2YWjTfOYoW32HcOHrYnks8QR8uQ+LG7j9uOAmsLnEBbjXDssREk+qtkQbBisDV3apV
 ugb1yjGmXFQD9/cPdzWmQGAOL7vrEsrx7TWOAd9/WpqtMaC876ABzMhSSQc3MwlJSvIktd47w92
 WViB8da/ibjmiDmC5u4M9XofS4Vy8EaGB930r9zt1pEp5gErgg30+n3jqf2QRlDFfjJa+rmP8H3
 fLvAJ3V/+Lg=
X-Google-Smtp-Source: AGHT+IEH4KXU0S531k4axrt8z1v/d7vrOdPEJr5m2sHQJNP9lRQEN5KjdZaCQbfPiYg2++iytL5O3A==
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:e0a5:aa98 with SMTP id
 e9e14a558f8ab-3a811db2148mr18943145ab.13.1733452641487; 
 Thu, 05 Dec 2024 18:37:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v3 19/46] pxe_utils: Simplify default fdt in label_run_boot()
Date: Thu,  5 Dec 2024 19:35:58 -0700
Message-Id: <20241206023626.2456858-20-sjg@chromium.org>
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
2.34.1

