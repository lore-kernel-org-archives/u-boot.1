Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33A4C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA4987017;
	Sun, 12 Nov 2023 01:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XNKdkWA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8285D86EB8; Sun, 12 Nov 2023 01:45:51 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB3787017
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7a92727934eso129850739f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749944; x=1700354744; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jv84KWzJhviuVWbf7I+ULytGtKeZKgJMfQ8Nzm2r6Yg=;
 b=XNKdkWA/7Qj9nfeSBOLcqsIqmo0cVK3HKX+gO4R1EoORjnV7/PSJXjUSUMAsRAKLd1
 vIpQCGXdt6jfU8pEIQnTUNsAKnUI6dHMpk54+ijhMA0x8pdT0OPF7E0AZ8MnX8YUyGXm
 ertLwzOW67BRnURo8PlcDPP9o/pjzdEjAbEx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749944; x=1700354744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jv84KWzJhviuVWbf7I+ULytGtKeZKgJMfQ8Nzm2r6Yg=;
 b=IE83yPJ4Og7QrLZHI9vIWVEVCpYVrI+dDJg+ly9dFXzrGP681jd/YxsaxvWH939O4g
 AConnzXQ+G/Gp7ny6a6nEACVqOcCu7qfgpLsfbwP9N5zWRjwB+SfFO6ORWWQSfJdxDnT
 y2cELyteeIKyg55w19hwjvOVUVJmIOUXyPYxxbHQ+uVPjLebvzLJ+fivu6zU2f03OztK
 iVRB2mbF//reUJkDHhQ8wYuLxKybhTbO5T0KFnRtIjNLalsFWv8gZoU1hlMOgpYeVuGz
 Z7rKmZkTwtJAuW8KpQZa8ioS6vQIao4z69rr1hyE0ZK3wx+AFwAEtbuztJVNQWPdzkYS
 2KEQ==
X-Gm-Message-State: AOJu0Yz3IPyerTazedyjYSf+nGt6wXf1C54unUhl7y3qpP7sYd4RugyO
 TWnrqi5zEFWzIQ7zkCYVDyRjdQIMp+4/e84s2JlWGg==
X-Google-Smtp-Source: AGHT+IG1LFZm2DsrYi1uw4WXM5KcJiZVls+shxRUQNgSodByLMEXDAh9co0PduOIT0dcf0QawBOozw==
X-Received: by 2002:a05:6602:164a:b0:795:bea:ae13 with SMTP id
 y10-20020a056602164a00b007950beaae13mr4132810iow.20.1699749944654; 
 Sat, 11 Nov 2023 16:45:44 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5ec111000000b00785cfdd968bsm765277iol.5.2023.11.11.16.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:45:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 2/4] bootm: Move arm64-image processing later
Date: Sat, 11 Nov 2023 17:45:33 -0700
Message-ID: <20231111174533.v2.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004539.80982-1-sjg@chromium.org>
References: <20231112004539.80982-1-sjg@chromium.org>
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

(no changes since v1)

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

