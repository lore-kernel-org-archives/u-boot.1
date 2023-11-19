Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F689C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB77F86FB6;
	Sun, 19 Nov 2023 15:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WEw63zws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC2D5869C4; Sun, 19 Nov 2023 15:44:09 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90F5F86FB6
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7b006f7c473so130964339f.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405031; x=1701009831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vf3ecsLzyAiwEgCgTo5cm8Hv2wbhnfH6sfxTxE3g8+0=;
 b=WEw63zwsiO3MoCkiS8pT4j26/xOOrnKQ4MeNi1fUkyrABNLmGHncY+4ylagLp5OcnE
 PwGd6/CoZVBaRbH1j8fHwFm8citxsPbJGZeFwxGHCajHwJdwgA10Sekda6UkB+Sq0oot
 737lBU+uU2G5jeEQKuLvenCmRRVFApV6M6JSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405031; x=1701009831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vf3ecsLzyAiwEgCgTo5cm8Hv2wbhnfH6sfxTxE3g8+0=;
 b=pfhNhINBbiqLLOYSXHnslCX+9IJNd2uWhcvmw+IMd416G2dv6WJH419PAzCkCEatW8
 Q1Lb47HQCUEBgXJSitKVo5jBrDhBBAc1zO/2pHJL1RV1F1fgUPzgK7526UfQrBNXIAm3
 ZE97Ztu6w/5RAcpi5x476/419UyceK0qaVNJfAW7vAOoo4dyJBHCuwJR+AcpwSlWwoTB
 i0NVDAicUmeG02w58Zy1FLc+QA3PZuw5J3DtsfRhxVHH32bZuaAqB9f3tIRRt+pKfR4X
 Xqj/++5GMpYZeuoqfQa4FeVH/sv+XgbQxAD6P164b6//R1jipllhT++t0+6Ud4p1Gxoi
 GEqQ==
X-Gm-Message-State: AOJu0Yy26nW5akXHFYU115MRY26idrofhfhlGSUzidZeNzhjM52U9SFL
 qLU85dQFUDDuFPpT85oQm1mInze9U4xUSZ1RrrKh3w==
X-Google-Smtp-Source: AGHT+IGOoaOe3zIVBaOj57RZM4KRyjnb+tNvPP0F6SNlGo6Ohn8+JqiPruMKUi56Ty170SkV47xrAA==
X-Received: by 2002:a05:6602:2416:b0:783:4bc6:636e with SMTP id
 s22-20020a056602241600b007834bc6636emr5889972ioa.21.1700405031169; 
 Sun, 19 Nov 2023 06:43:51 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a023505000000b00463f8b3e34asm1511196jaa.23.2023.11.19.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:43:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 3/4] bootm: Move arm64-image processing later
Date: Sun, 19 Nov 2023 07:43:33 -0700
Message-ID: <20231119074333.v3.3.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144338.630138-1-sjg@chromium.org>
References: <20231119144338.630138-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Rework the patch based on a better understanding of events

 boot/bootm.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index a0d17be7742c..cf07c042fbca 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -443,24 +443,8 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
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
@@ -685,6 +669,31 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
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
2.43.0.rc0.421.g78406f8d94-goog

