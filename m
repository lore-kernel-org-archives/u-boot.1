Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41CBE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2AC89686;
	Wed,  4 Dec 2024 00:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fXm0sjQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEF2896CF; Wed,  4 Dec 2024 00:46:57 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D2D8967A
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-841837213b1so430341839f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269613; x=1733874413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsqtE5uXNaqnsrM+trLoKifwtRHyDtvI3SaZv0KqB2I=;
 b=fXm0sjQKC5XVLFcb8wsvqr1G2ht0IXhYQkDACQDmI5hz8ygvfwJzNjyrZWbxpxUv0y
 L6SGYKbUVWf2XeQ0gEcPjZt0zNT6RUZGccFTiBeAZh+g0S/5q02ddp6+EchiTQMywlQS
 kpFY3+R8IMNsfoMLiOkIdUfiaNPbJfxOm+Vds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269613; x=1733874413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsqtE5uXNaqnsrM+trLoKifwtRHyDtvI3SaZv0KqB2I=;
 b=Q4yfPV7n4S8AzLEeuEpR9uJYLsyNwff9TbuFSEeZGErFUArx4+Ongr9nChkyhbPKnz
 FcbOkixDz/92EIL3l2a7nb4hGr4EkHUCxi7Vzdfo6t5Mjdeiav0w+rBuJrlFCMCbDqOu
 mFbbyZGAGQ1+Q3pO903aAPd2hmoqnK4YiAL12w+OZb9VaMmY2AsQ5o9WnvZlJ0xiK5uZ
 uUwf4QRuLsLKbaB3ns5mmQlv8+zYiNSVWZVsRfP9wmcsN/ELrIgQWLFIBADwD7yEXDmU
 njD5TOwxBok8B95yNg+qBSQmxytV/X0Wh7e3EY6UHv1lYvd14hvyAlqvYhC7dnSLzWDh
 UtNA==
X-Gm-Message-State: AOJu0YzBuQh7Bz/+T2beIdowvVonAYSsHUxc4pDVvlcbU2FHEbgniPIy
 HrYta1QNHZGVBHBQhjsx/qMcYfKAPH8sPVUZl1YHo0eqpfDj75pldVdMDgb5QVQSa/W7hsfguHA
 =
X-Gm-Gg: ASbGncv7LpniWixVHfrPaMU3g9qbrB31PsZ8LHDYqaKPK7ukrjO3Rz/MJ1Qp2h8zU0L
 TWK7DkAXFJPE/2p5akwIAzn2T0G8bWYDknnfi/XF6/mKH1KsTRNw3IBEx+vuJwxusfxrEXj9iwQ
 YIbpuQ0Brvzx/53K6QGkfP91nnrCp/OFMQz3pTUrngpcNxWaIIlmhhMpNU8S2Xr3mSwUHYZGbSQ
 iE16cz1CjhHfmXfqAnbaukMpWEcNU6Ayl8VmxHbpA9y/UvOpvlcUKxmLBrA4Hfra759N4xxqVke
 z8rp8RzRejk=
X-Google-Smtp-Source: AGHT+IGLsiMpEmaQ412xokYWfP9LhwuiM4tVCvHlcKsdKgSsTvbDhqTk+bqb92ioYWTjY/Ay+lwCJw==
X-Received: by 2002:a05:6602:14d2:b0:843:f220:fa3d with SMTP id
 ca18e2360f4ac-8446296f5b3mr225879939f.7.1733269613299; 
 Tue, 03 Dec 2024 15:46:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 15/41] pxe_utils: Simplify default fdt in label_run_boot()
Date: Tue,  3 Dec 2024 16:45:33 -0700
Message-Id: <20241203234559.2938192-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

