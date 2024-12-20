Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307A9E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36F380394;
	Fri, 20 Dec 2024 01:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQdnvke0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99EA80384; Fri, 20 Dec 2024 01:35:07 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BBA08033E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844ee15d6f4so109217839f.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654903; x=1735259703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4ZNKxK+y8xYEBp6A8U421TiDVRRWRSAkYKzXoPDRjY=;
 b=dQdnvke0Vy4CT0RcMR3nslDUHOTZr0IIAiEqGw/C/g97yd1shehBkMxf1uLN+42goX
 jmr9W0I0uw4D1Enufv+N/qkBdAmxV5lQ6l+KBJamqssdIAKNn6r3KIBBhX3qjgswlV9Z
 YGBNmFexJnBJoxS828CVRmubdksRdAZqfMp8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654903; x=1735259703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4ZNKxK+y8xYEBp6A8U421TiDVRRWRSAkYKzXoPDRjY=;
 b=ugBguAdxuy2t87PznxVmTSmO8aCnD9/YnOwJK6sBMN/qULkUWW6iSdQlTustlPzSl+
 qybLmxDVrwKti47xX0MegOqMnHbCr0MgU7NIL89YcCMwhQOf63kPFn9yfp/urHyLO39/
 /xYK77tukS/Z7I/x28VSRJJ3sE3IlMfi2CfnHGCYbPo8iWWUfCSHGCk6hSBEUSibF3VI
 iIFLWJINk2AcTCNnUlrAuHKQTrz5f9BXEU3i4TPCtEkkX6/mERKqKR9GDQNED2NINWpQ
 9SpWkc+s7Rj2qqAX8HacPUq2RmOyy2bRphPMuDfWrb8dHK8OLGAz7mQ6rqNyIcXTkbxm
 km5Q==
X-Gm-Message-State: AOJu0YxOEs18sJVRia3uEyHFcYi8ugdAK1CRfYSSSEb2rR9drTh/AytP
 l8/Kw9pcy18xqLfMaIIn4OojxCPawfVDf1f7MJERmcD7UjIR5x355gRYd/reqmWHlTk7gmA3RKs
 =
X-Gm-Gg: ASbGnct8Yoi61ad48Lq2z7jq27xcPLOzX6l1Y3KInl2pQt/c37kU+wBHQ4/ufOuClWy
 Z0VeqjqV5pvfgTWRZpAmd2lURW+yzoQqBNQVHm4qsHCzTYfPikzcwgnNRSdBJnY2acNOEQgK/uA
 v3IampGiVnSAvjnfNEtNuJEUcYlyPTb2lKBPgUiy5EJUnlxgZ/PH9B1cv9HRYwdCwWmEZ1dxMS4
 FNNP+aLwYVW0SL2SxJA2pmKlD1kkgc6mukSGJpQRWdMRk7TeYRF4u6Aeb1P03jl8xjAlR0nA686
 TE99z2J2Ns8wWAcIYA==
X-Google-Smtp-Source: AGHT+IEurSwrHGFp+2HFNgK1B/b7Sk/HzO0irMY0jM7/LqljOX5Lt6UU2NMBXiMJ4tgRUXDkSOGfug==
X-Received: by 2002:a05:6602:2dc2:b0:841:984b:47d2 with SMTP id
 ca18e2360f4ac-8499e689c59mr85927639f.14.1734654903243; 
 Thu, 19 Dec 2024 16:35:03 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:35:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 4/5] rpi: Update environment to support booti and large
 initrd
Date: Thu, 19 Dec 2024 17:34:46 -0700
Message-Id: <20241220003447.2913443-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
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

(no changes since v3)

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

