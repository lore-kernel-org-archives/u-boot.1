Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB6E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9F489787;
	Fri,  6 Dec 2024 03:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MhWeolxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAEE8965B; Fri,  6 Dec 2024 03:38:31 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E01A089787
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a813899384so883895ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452707; x=1734057507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99yWmNGac7HvS5PIqaO4WTa+FuVX6TAIYsUh1NTygfc=;
 b=MhWeolxfM9Qb4VYBo+ukije+85wWqdCzz5uV6c1UT5/Ge8yI9rNlznO3Yh1eqNxdTt
 Lmq0rusb12bwLol6vtI38YJVNz+5AAeOt9fs7ul4jUBGp2qoVUSO3y4Ht4T3V32fs3ld
 636FBPBPDDYPRp2r96mXWGsZfSxzYgLy4sR6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452707; x=1734057507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99yWmNGac7HvS5PIqaO4WTa+FuVX6TAIYsUh1NTygfc=;
 b=qr/ydFfuCvxYJg1fMwo4SKmLQUxE6DmoYDsYjTqedKJbwfrSPGiYqoAmDpUhdOIzFP
 UMc1Q9SN1srhcsLiuH2HfR0g1m2cCsjN03JbGAqRQy6jNvWFI+5g2SWTjDUmgjEhtJ75
 U0GbAqwZ348OMRKMGig9SFJ8ULMqTwYFtZq737cUUvbSq6CZvoyV2j88hC2sUOWY4Ivg
 6QsoxW5+hFqWDIJDpWlgMVrYUnuZYbCeuogKmB0WtHrbJXPQLMvIrmEgql5ZYNvX4dYe
 ezzxnS7AzuGRrf0a23oGHNza3Ws0njUvLwxt4YTZ8WSeqVFO2lqFFHF/Sn7aBbQhDaTm
 JMyQ==
X-Gm-Message-State: AOJu0YzIV7oNpDW2JdTtqTOuf3SJolM3IPqtHhAjwnZjhENo9HC2gJU4
 geTyiE7Ssaez/DxlnrpgmH8QEz6bmxVFS2cU0b7727PZRQVuirtTqPQhiOdvyYrThxRe/1b95bI
 =
X-Gm-Gg: ASbGncvLQeT72HQuL4TM2VVusBjWu0xuJ3dj6idtmUulQdt3q6LfAetagSxQOueqUJP
 kJcQO2FK8yGw0mHtjEgVjgZpkMBj8ENtv8jH6b0mFL0/AgAbmjkqerK1ukj4PJuVpuFPZu5s1E5
 cYbRdMBn+NT817JCViLM07Ud/AvyN486zvD0ors2R5tag9XZUgFPNgyXFHVvIQVElZRMx/oP1iQ
 lSdxSzi6giyfWqYZXeyRHnyQOJ8yWuYLOTETup+yoGiFKC8lmf4TH/zeDrAgMwTdQVmIk3JBQbr
 O1UVluNiDNI=
X-Google-Smtp-Source: AGHT+IEOeAceoSR7O91lqBNhOydv/EJucbvtxvwD2+Gqtf81ddm4PbL4PYxnKmHDYmnl5Pcb1WP/4g==
X-Received: by 2002:a05:6e02:168a:b0:3a7:8d8e:e760 with SMTP id
 e9e14a558f8ab-3a811dab4dfmr18193305ab.4.1733452706771; 
 Thu, 05 Dec 2024 18:38:26 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 43/46] pxe: Deal with a missing FDT in the bootflow
Date: Thu,  5 Dec 2024 19:36:22 -0700
Message-Id: <20241206023626.2456858-44-sjg@chromium.org>
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

Move processing of a missing FDT so that it happens before booting, so
we can see the result in the bootflow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 053fdcbb6e7..1468a8e8498 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -605,21 +605,9 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			      hextoul(initrd_filesize, NULL));
 	}
 
-	if (!bmi.conf_fdt) {
-		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
-		    strcmp("-", label->fdt))
-			bmi.conf_fdt = env_get("fdt_addr");
-	}
-
 	kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
 	buf = map_sysmem(kernel_addr_r, 0);
 
-	if (!bmi.conf_fdt && genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
-		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
-		    strcmp("-", label->fdt))
-			bmi.conf_fdt = env_get("fdtcontroladdr");
-	}
-
 	/* Try bootm for legacy and FIT format image */
 	if (genimg_get_format(buf) != IMAGE_FORMAT_INVALID &&
 	    IS_ENABLED(CONFIG_CMD_BOOTM)) {
@@ -786,6 +774,28 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 	if (ret)
 		return ret;
 
+	if (!conf_fdt) {
+		if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+		    strcmp("-", label->fdt))
+			conf_fdt = env_get("fdt_addr");
+	}
+
+	if (!conf_fdt) {
+		ulong kernel_addr_r;
+		void *buf;
+
+		kernel_addr_r = genimg_get_kernel_addr(kernel_addr);
+		buf = map_sysmem(kernel_addr_r, 0);
+		if (genimg_get_format(buf) != IMAGE_FORMAT_FIT) {
+			if (!IS_ENABLED(CONFIG_SUPPORT_PASSING_ATAGS) ||
+			    strcmp("-", label->fdt))
+				conf_fdt = env_get("fdtcontroladdr");
+		}
+		unmap_sysmem(buf);
+	}
+	if (ctx->bflow)
+		ctx->bflow->fdt_addr = hextoul(conf_fdt, NULL);
+
 	if (ctx->no_boot)
 		return 0;
 
-- 
2.34.1

