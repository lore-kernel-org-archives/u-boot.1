Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55F4E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 19:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52003896D9;
	Mon,  9 Dec 2024 20:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="avhpH2ze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33FC88979C; Mon,  9 Dec 2024 20:55:44 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9FC896D9
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 20:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-841acc8151aso344697739f.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 11:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733774140; x=1734378940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MkcJaaRe0icfPUui3G29jzixrK0O//f/fBo3i5KjD4=;
 b=avhpH2zeji15QSY9YesVpdXRbtLUKMplf5vJeS0F/k2LuVW82hOciAYfhN/INvE3k5
 k7YQ1CePqKkvLPZ4KCkyJKW//+x0LD8LLjIu5fj5gRamPxVgS7RKNdzYx7NVuyDu5dJd
 0AvWo5yDh3MENDRqzcIWBFJSKp5x3h6HJHFuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733774140; x=1734378940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MkcJaaRe0icfPUui3G29jzixrK0O//f/fBo3i5KjD4=;
 b=uGlHcDqoNHiGEbtvuC+4hVEcHZaZfHhlQnG1AG5Tid/0pV4rZvdtWAxgFk7rM6iPGA
 VyTD6v3nJ2+tXvY/hf85u5m6M5FAa3+BHTknYp9sA2OLB8dzKqa1xNr23Tgj0viFMw4J
 DakMDKmr7QUgXOcBZbOj/5MUQmu4oCN74hOWn1xfguQfePG/c89Jmw3Q6FNj+qR+cLrX
 dGb7fLOPsJB2Sx92uRiKOTZhbNCfTJtBaz4CoWaI5vpUSXoUWXey/oUCOqtmQ0VEVuTl
 DKzN640KMj0CCkTiNILNb9bxD2FrFBxNMPllQRqqt4piRAdWcfdtBdZA8LM4VTJ4RZn1
 ssXw==
X-Gm-Message-State: AOJu0Yx8m3pnz9dGMEx9g4/RfP+uPH6oqTlbTFM7toeP7AVE05MBfFcG
 xN4RJH/S+9KlpfqFvNTaBq7TBiCEA1+Ivmqnf24hWYvAqzxvBMRlXW1P8S56g0JKoVUIL/ESNf0
 =
X-Gm-Gg: ASbGnctI7U6/2QrTcRarHcQIm5t8U0DqCc6CuCUJth5r2zsfHb/gNO5uDWEh2jVJqwS
 Z2S8WJx8e6aJtWOiLrAcF3Tz79DXAOXy6FLrwo+cmmOQU51MNs++QHv8w4ssjIJruj1yxZrpD2m
 MDICUrCmM+i9fiyjCkK2GtzTjOCxqo4pjYapv85SoQJtIaC2gMVp5ePtTdSUlpWKjZAZloOsNYo
 pG84uSeGAV34iiJNrkBddGBzl5MizVl90dER372p7qjyUjELR9MEZNU7FxMaMjJpEMNGkTBJEo0
 IGrfCb8BUHd+mp0=
X-Google-Smtp-Source: AGHT+IH1PzSencHSdlvCqNRvUaMSAxJznyXfNQ+Ttv0OqMhjLPqcvuFqDWx9EqWEuKMUTsR02CuHNQ==
X-Received: by 2002:a92:ca4f:0:b0:3a7:c378:3bab with SMTP id
 e9e14a558f8ab-3a9dba3cb59mr16419775ab.0.1733774140185; 
 Mon, 09 Dec 2024 11:55:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e286146f85sm2348941173.74.2024.12.09.11.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 11:55:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 4/5] rpi: Update environment to support booti and large
 initrd
Date: Mon,  9 Dec 2024 12:55:26 -0700
Message-Id: <20241209195528.730260-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209195528.730260-1-sjg@chromium.org>
References: <20241209195528.730260-1-sjg@chromium.org>
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

The existing values don't provide for decompressing an arm64 boot-image.
Add those values and move things apart a bit so that a 50MB kernel can be
accommodated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update the comment block with the new values, including compression

 board/raspberrypi/rpi/rpi.env | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 9b9fad82828..9ac9d6768ca 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -48,28 +48,33 @@ dfu_alt_info+=zImage fat 0 1
  *
  * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
  * conflict with something else. Reserving 1M for each of them at
- * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
+ * 0x05400000-0x05500000 and 0x05500000-0x05600000 should be plenty.
  *
  * On ARM, both the DTB and any possible initrd must be loaded such that they
  * fit inside the lowmem mapping in Linux. In practice, this usually means not
  * more than ~700M away from the start of the kernel image but this number can
  * be larger OR smaller depending on e.g. the 'vmalloc=xxxM' command line
  * parameter given to the kernel. So reserving memory from low to high
- * satisfies this constraint again. Reserving 1M at 0x02600000-0x02700000 for
- * the DTB leaves rest of the free RAM to the initrd starting at 0x02700000.
- * Even with the smallest possible CPU-GPU memory split of the CPU getting
- * only 64M, the remaining 25M starting at 0x02700000 should allow quite
- * large initrds before they start colliding with U-Boot.
+ * satisfies this constraint again. Reserving 1M at 0x05600000-0x05700000 for
+ * the DTB leaves rest of the free RAM to the initrd starting at 0x05700000.
+ * This means that the board must have at least 128MB of RAM available to
+ * U-Boot, more if the initrd is large.
  *
- * Limit bootm_size to 512MB so that all boot images stay within the bottom
+ * For compressed kernels, the maximum size is just under 32MB, with an area for
+ * decompression at 0x02000000 with space for 52MB, which is plenty for current
+ * kernels.
+ *
+ * limit bootm_size to 512MB so that all boot images stay within the bottom
  * 512MB of memory
  */
 bootm_size=0x20000000
 
 kernel_addr_r=0x00080000
-scriptaddr=0x02400000
-pxefile_addr_r=0x02500000
-fdt_addr_r=0x02600000
-ramdisk_addr_r=0x02700000
+kernel_comp_addr_r=0x02000000
+kernel_comp_size=0x03400000
+scriptaddr=0x05400000
+pxefile_addr_r=0x05500000
+fdt_addr_r=0x05600000
+ramdisk_addr_r=0x05700000
 
 boot_targets=mmc usb pxe dhcp
-- 
2.34.1

