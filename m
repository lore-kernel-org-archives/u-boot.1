Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0897FC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFC78714F;
	Sun, 12 Nov 2023 04:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HUOri4nZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA5F86FA7; Sun, 12 Nov 2023 04:50:46 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CC7E870E6
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a98fdeaac7so143683339f.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761028; x=1700365828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/fPiF+JC+ZJVm5/lhiP/RBykvKfpXBl1TxmRCYr/8U=;
 b=HUOri4nZ5FmEqA7jylM+avFkxApV45HfKlDcl7KlSYTP7jPH3Rgq1ZkjYp503dYW0J
 c5juo7GWXwDGFc16YyNxqBwNAd+TuMcNVyj+hKxdp6qy8hC5yMOB5pNP87RNR6FcIMda
 eL9l4IRmcNL6HTX3UpAKkLCOEtHkJWdPRafQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761028; x=1700365828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/fPiF+JC+ZJVm5/lhiP/RBykvKfpXBl1TxmRCYr/8U=;
 b=g6+4DiyrZHR2mDuaM8IBnj96rPtIjwZEWyLzCAulSN+myyBzXbG8Wv2dse5FYAUITL
 QzbZZ5T6WOiacDki6PM+LZMwIRzezjCunigtPHC9c4Ub21hMW04iAhkcSsKHnZjluNRa
 vbfkt1Zd2ffelvM4SAe4sacRNwbVzLKhWfdOIdApENyxVFLsebP4X+K0JIAVHg7/gDqo
 aBJoHpS0s9Ghk+yCh77QRd77Tx5NkoFh55KDv4d+07rytp/EdKs4u9iXY5LdsM8rTANh
 0qk6JDpYq/OXzEdOHEK/NOaw+zcsZPwMsim6hXrSpB4nvpRH8/nh6LYOtm/POh3NjBk9
 eQVA==
X-Gm-Message-State: AOJu0YxALHC8RHViIU6xShmMY2XpXqbzqhKa48ILhY2we9l6QOCtQcqp
 3FNeNwdNI5nIXOCJBogan/UCk8iEnyMaEy1xxNDMRw==
X-Google-Smtp-Source: AGHT+IGuYkZALT6+dY7nSBzza8ckd4Ph4AI92lfgiZaEoA7+fiHFqcwJ+KXvK8B0fzF/TSlj0ASzuA==
X-Received: by 2002:a05:6602:371a:b0:79a:b526:2f1c with SMTP id
 bh26-20020a056602371a00b0079ab5262f1cmr4526547iob.21.1699761027858; 
 Sat, 11 Nov 2023 19:50:27 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 4/5] bootm: Move arm64-image processing later
Date: Sat, 11 Nov 2023 20:49:56 -0700
Message-ID: <20231111204954.v2.4.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112035001.103897-1-sjg@chromium.org>
References: <20231112035001.103897-1-sjg@chromium.org>
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

If the image is compressed, then the existing check fails, since the
header is wrong.

Move the check later in the boot process, after the kernel is
decompressed. This allows use of bootm with compressed kernels, while
still permitting an uncompressed kernel to be used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rework the patch based on a better understanding of events

 boot/bootm.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index aef9fad8ca13..4c150e895f2f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -248,24 +248,8 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (images.os.type == IH_TYPE_KERNEL_NOLOAD) {
-		if (IS_ENABLED(CONFIG_CMD_BOOTI) &&
-		    images.os.arch == IH_ARCH_ARM64 &&
-		    images.os.os == IH_OS_LINUX) {
-			ulong image_addr;
-			ulong image_size;
-
-			ret = booti_setup(images.os.image_start, &image_addr,
-					  &image_size, true);
-			if (ret != 0)
-				return 1;
-
-			images.os.type = IH_TYPE_KERNEL;
-			images.os.load = image_addr;
-			images.ep = image_addr;
-		} else {
-			images.os.load = images.os.image_start;
-			images.ep += images.os.image_start;
-		}
+		images.os.load = images.os.image_start;
+		images.ep += images.os.image_start;
 	}
 
 	images.os.start = map_to_sysmem(os_hdr);
@@ -474,6 +458,31 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) && images->os.arch == IH_ARCH_ARM64 &&
+	    images->os.os == IH_OS_LINUX) {
+		ulong relocated_addr;
+		ulong image_size;
+		int ret;
+
+		ret = booti_setup(load, &relocated_addr, &image_size, false);
+		if (ret) {
+			printf("Failed to prep arm64 kernel (err=%d)\n", ret);
+			return BOOTM_ERR_RESET;
+		}
+
+		/* Handle BOOTM_STATE_LOADOS */
+		if (relocated_addr != load) {
+			printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n",
+			       load, relocated_addr,
+			       relocated_addr + image_size);
+			memmove((void *)relocated_addr, load_buf, image_size);
+		}
+
+		images->ep = relocated_addr;
+		images->os.start = relocated_addr;
+		images->os.end = relocated_addr + image_size;
+	}
+
 	lmb_reserve(&images->lmb, images->os.load, (load_end -
 						    images->os.load));
 	return 0;
-- 
2.42.0.869.gea05f2083d-goog

