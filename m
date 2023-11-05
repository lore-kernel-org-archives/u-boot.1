Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD09C4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 20:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A70286F45;
	Sun,  5 Nov 2023 21:05:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fKUSk1WR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E13B86F12; Sun,  5 Nov 2023 21:05:22 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3329386F1C
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 21:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so127551539f.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 12:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699214711; x=1699819511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCttQyWPhRfVqA6AReAFOgutltM13isj/Ex8MHF/fho=;
 b=fKUSk1WRIDd+TiMbMuZl/PNwdS5mz+yznP0yc57t7p67CAfjniw+ogIqzziQGz4/cR
 kdhDO2AyjZQ751BWunrwgD4ZIMXbhH9Bcr1wkyB3M+nbRSZ7AhHL/dIF3l0GGA2WjNH2
 F4qMXrCaCPtpcN44K9Jcc1GL6dEY6WeGEexq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699214711; x=1699819511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qCttQyWPhRfVqA6AReAFOgutltM13isj/Ex8MHF/fho=;
 b=UnSbmfzlpfRpZUNMCkjw+8qzNka4C8SrPC1XrzShiyZPlVIcnlcA/h0U2B9Z7H/DUn
 Blu5MgK4GCdpUpCaxsUvl5uRZ+NFrOPRPmg5cpPEvaoz0NWlIRnMT85N8x3qlSCxdlmM
 U5ir1mYWJ+r7t++3qmDZsbcbKKbQwcoMx1pHsC0k3cgOwuuNiaqmoZPyARRZL5sYQmyN
 Eep9TzJ0UgUWg5gCTLwlpWy2BMbevaOgfWYFJ5MPZNrTowLp38+G27culbvZs1BpwWIw
 /K7XtVL2O9BTm8rlqiXhb4+SZB0GkqhA2JljmiIFkZ/13k1VbGCZQjG8AK4byWxPA9bL
 XbsA==
X-Gm-Message-State: AOJu0Yx+LSs7N6YL7kNqEUlqNLRbcFp09rGotASUYaEzrPsb5TEtz/DD
 ftQVpNOSlecDe1EJjYOmTrunNVxw5BhQb/mL502qVg==
X-Google-Smtp-Source: AGHT+IH+DJ54F/u2IQRtH05bVgOQTvyk+bZqv6RBVgqPUaM9HMpsm5o+Tc/w7/UDSYmo6pfxbbYA2g==
X-Received: by 2002:a05:6602:2a4d:b0:7a9:4268:fc26 with SMTP id
 k13-20020a0566022a4d00b007a94268fc26mr38773518iov.10.1699214711738; 
 Sun, 05 Nov 2023 12:05:11 -0800 (PST)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a029693000000b0044d10eda3a8sm1685512jai.158.2023.11.05.12.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:05:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 2/4] bootm: Move arm64-image processing later
Date: Sun,  5 Nov 2023 13:03:52 -0700
Message-ID: <20231105130351.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231105200453.1887418-1-sjg@chromium.org>
References: <20231105200453.1887418-1-sjg@chromium.org>
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

 boot/bootm.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 7583be5a4515..8c35afb09937 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -245,27 +245,6 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 		return 1;
 	}
 
-	if (images.os.type == IH_TYPE_KERNEL_NOLOAD) {
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
-	}
-
 	images.os.start = map_to_sysmem(os_hdr);
 
 	return 0;
@@ -472,6 +451,36 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_CMD_BOOTI) &&
+	    images->os.type == IH_TYPE_KERNEL_NOLOAD &&
+	    images->os.arch == IH_ARCH_ARM64 &&
+	    images->os.os == IH_OS_LINUX) {
+		ulong relocated_addr;
+		ulong image_size;
+		int ret;
+
+		ret = booti_setup(load, &relocated_addr, &image_size,
+				  false);
+		if (ret) {
+			printf("Failed to prep arm64 kernel (err=%d)\n",
+			       ret);
+			return BOOTM_ERR_RESET;
+		}
+
+		/* Handle BOOTM_STATE_LOADOS */
+		if (relocated_addr != load) {
+			printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n",
+			       load,
+				relocated_addr, relocated_addr + image_size);
+			memmove((void *)relocated_addr,
+				load_buf, image_size);
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

