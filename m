Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D48E64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7148E89774;
	Thu, 21 Nov 2024 23:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uk2b+9Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 653A48977B; Thu, 21 Nov 2024 23:32:38 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C673896C2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-6ee6a2ae6ecso14529117b3.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228354; x=1732833154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzclya6VZzzriL/ll8y60PODQIDhht0Q+aIhiw7UnBM=;
 b=Uk2b+9Rxv8ET5mKGLhEAYdd5/ZZoZ5X4AaKw9zSfYNbJmbmKSFOk7p43zf6mjmNbBF
 c564xeonqEEvRTbrXjZcGhieTZhZr9pSs0h4a3utAYO3TN7iuSwlJKRh7L87Ct2jof6j
 oxt4NCIP3yjD7uSg5h0OKG5EDMv6l5alrfL/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228354; x=1732833154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzclya6VZzzriL/ll8y60PODQIDhht0Q+aIhiw7UnBM=;
 b=cv2r/9+TcFJ+wyy7r/xAnjzyKW1WfrjfGQdDwljrN+PbCBl6WiJuULwi+81Iue4QJg
 KH6onPhqNfQvT3nZ8BqzebguG/39ZsI2kzoeK2/JfFWmjBoj1OUBAINFjmz+kP2b6lC/
 CapLFzIRiph2XSy6+BaTk6dhf1mjjfx3SwO+a0jEOaUpE/7BqijzWGQrDAgJDMwbbZm2
 un/gN4qDyumY0KP6CM1sfoLYRETekhMCw/oCFAQCFNPP3Lv/AuRee0QVJlS8EtMSfUcU
 nqfEIyAN9lFiprqPrmRBbu/pu+mqA0GJOG0g0bpkK5bM5P8dNgjUphsQSG9mMeUCHWAX
 RzPA==
X-Gm-Message-State: AOJu0YzTVDfxnOZg04auO9+YanToDNVsPk3b2I8wl45KL/EGOa0PdPhB
 hDhJ97lR0A/WRbUPyPPe/OF8T/ArFtyibL9E0q9ofENugnqZCWlIPPYpohRtEX1ImbIpsnpUaqo
 =
X-Gm-Gg: ASbGncugcgKYAJonsQsXCteopFTHtpfZRAoHv21/ELBTZnCzyO6cOQeDdcI0QecaTcf
 91nnSCYR0rY3NlwF0Nn43FvB3rKziipCTVl7EOMn4HDkORMyZ17FLtN+J8aLrHq+gtttDptKB9E
 XGvh/4hsOR2fLwC/NG7ezjhE2yk0WbW4mXaSpg+H6dLE+mtQNAWQIieDtvZXSCv80P3dRoP3Cqz
 WMcAYqL7Nb82JIsxU+nZ0YYnszLExTC9m5b8XKv8avYS+g=
X-Google-Smtp-Source: AGHT+IFsasDZsx+vzqyUA/Zid39vaMQXCK9TJPm4i8GdDRQ8zq7ucldRmB8P+unVgVGV5ROV5AqPyA==
X-Received: by 2002:a05:690c:710a:b0:6dd:d5b7:f35d with SMTP id
 00721157ae682-6eee0a5bab4mr10497097b3.30.1732228354145; 
 Thu, 21 Nov 2024 14:32:34 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 6/8] test_ut: Use the built mkimage
Date: Thu, 21 Nov 2024 15:32:12 -0700
Message-ID: <20241121223217.330117-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
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

The mkimage tool is not present in the docker image. Use the one in the
build directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to use the built mkimage

 test/py/tests/test_ut.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 82cedbef039..6c3b360d5fd 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -167,8 +167,9 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
         cons,
         ['sh', '-c', f'xz -dc {infname} >{bmp_file}'])
 
+    mkimage = cons.config.build_dir + '/tools/mkimage'
     u_boot_utils.run_and_log(
-        cons, f'mkimage -C none -A arm -T script -d {cmd_fname} {scr_fname}')
+        cons, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
 
     kernel = 'vmlinuz-5.15.63-rockchip64'
     target = os.path.join(bootdir, kernel)
@@ -225,8 +226,9 @@ label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
     inf = os.path.join(cons.config.persistent_data_dir, 'inf')
     with open(inf, 'wb') as fd:
         fd.write(gzip.compress(b'vmlinux'))
+    mkimage = cons.config.build_dir + '/tools/mkimage'
     u_boot_utils.run_and_log(
-        cons, f'mkimage -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
+        cons, f'{mkimage} -f auto -d {inf} {os.path.join(mnt, vmlinux)}')
 
     with open(os.path.join(mnt, initrd), 'w', encoding='ascii') as fd:
         print('initrd', file=fd)
-- 
2.43.0

