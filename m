Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301E5E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 18:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 509DE89466;
	Mon,  9 Dec 2024 19:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PExUbDxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F2B8975B; Mon,  9 Dec 2024 19:20:22 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6444F89251
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 19:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84198253284so181134339f.3
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733768418; x=1734373218; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WfUaGt1iXu2tuU+IQpiEn12u0cnTv1rUFWFvPpWjh/o=;
 b=PExUbDxramDbtAX+TnjGRGlTzRoZ/gmz2dM9/gdfeU0PBhOw2PJ4qKL2tU2m8cdw2Z
 6AQl/16O88U5UGzG8dVfyyWpWYpR7SbpRtVfQx77SF3MqdP9VYp6ajZO7+pYbMJAoiIx
 B29b+nn7A1aUC6DuCYOrE5dBcU+wIIR9XTxpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768418; x=1734373218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfUaGt1iXu2tuU+IQpiEn12u0cnTv1rUFWFvPpWjh/o=;
 b=pO9oW7+hf+dBqFOywXyVdfbglj5xBRgAlv9pg2tQ/u2ldQBOm55EYOm1Ax7a/Q7scE
 eDtdqPEc/3HHM9aozVv59ssHNzWYibAlAbwFkgFtWdUHL15Rbbl2mUxvr1Vfgis0uVE1
 BgziyxkrwlxnqZhFzt8ychR2kgL0qQOqLUecz1W6ZUm+26suBF2/DEojaez8v7q7oLZY
 dIKM5KCncsyDxKcaAOMIs6UgwRw72l49RwzJFV2cz0g3a1TNuwo++GcltABw4/p/kKP/
 IpSIV1IpirtXMUCpuTZPYceO7GmqIQuV7YWRCyafKTFo7jkjqfO3FE6R4rrW9H8koxTF
 RRfQ==
X-Gm-Message-State: AOJu0Yz3oBR9R5+J+dhBa3sNcajsg/cc4QKWKZsUCAZgevr5vbG7zRS/
 LtRA0pZBrtpu1gIPU2TUadwY5Qo7mFn98b/rMRqx/llARb28d2lUMhkvKxulr8QxjEfW0EaqY8M
 =
X-Gm-Gg: ASbGncvg6zaGII7mGAt+9XFoIvRKP2SfOG61I55cjeTpRqD2lgl+JO+TPNE+RaJOmDL
 9i1XSOGmhAm/WHOfPVzN8SSw5GidKCzU5777EEeJUkY7EojDMAufMda7tJBW2Cr57nh1P6PrYXl
 ixyusHKp7PqgOD5dmpeDuUQHT9JwonHDayexP1DaYGaTClc79F8Hb9fDudm/qd5wvp1hKxtKjnq
 EaTqsBJ/Narkm2QHpaxriT8KrB+YBXyU2n1H577kehfZdLmLtUMz02wPvabNuq2TyOXfUKvlBNJ
 gsZYxFL0lrQ=
X-Google-Smtp-Source: AGHT+IGhJ+mTyzK3Zm7Qwq0xSdjBmwDYVvfBa424eqghxRI6QP2/1qFFGIDGpKBUQ6EJxQzj6OsIOg==
X-Received: by 2002:a92:c265:0:b0:3a7:7ee3:109b with SMTP id
 e9e14a558f8ab-3a811e03747mr145616225ab.16.1733768418607; 
 Mon, 09 Dec 2024 10:20:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d8845sm2390429173.83.2024.12.09.10.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 10:20:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 4/5] rpi: Update environment to support booti and large
 initrd
Date: Mon,  9 Dec 2024 11:20:00 -0700
Message-Id: <20241209182002.671953-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
References: <20241209182002.671953-1-sjg@chromium.org>
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

(no changes since v1)

 board/raspberrypi/rpi/rpi.env | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index b79730a3e26..ee5a4810262 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -69,9 +69,11 @@ dfu_alt_info+=zImage fat 0 1
 bootm_size=0x20000000
 
 kernel_addr_r=0x00080000
-scriptaddr=0x02400000
-pxefile_addr_r=0x02500000
-fdt_addr_r=0x02600000
-ramdisk_addr_r=0x02700000
+kernel_comp_addr_r=0x02000000
+kernel_comp_size=0x02000000
+scriptaddr=0x05400000
+pxefile_addr_r=0x05500000
+fdt_addr_r=0x05600000
+ramdisk_addr_r=0x05700000
 
 boot_targets=mmc usb pxe dhcp
-- 
2.34.1

