Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D2E64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8C889787;
	Thu, 21 Nov 2024 23:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fII8cy6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711B08934C; Thu, 21 Nov 2024 23:32:33 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297E5896C2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6ee79e82361so23748627b3.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228349; x=1732833149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+06+D7xkVdSJV/pIcF0Onx3kr1shI0D/hgMaXfqfNE=;
 b=fII8cy6ZJZe5pLSpmnKX8WV9R5h5BppiDB5y/qJx8G/hnLoNeFVRqNDrKQeibYkINp
 GxCSTl2eroAM23Q7YDDzjiZ+UV/tCOnad0Iobv5prw7nOGfh5Sv7+cBqoE25Zav3LsHz
 gss0nrzHDQ2mhcQC49q+wCe80yb1BIRowMQsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228349; x=1732833149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+06+D7xkVdSJV/pIcF0Onx3kr1shI0D/hgMaXfqfNE=;
 b=BIVi8eGw/OIcf7IGKBTSLCH3yhE++EtROJeUf+WOgXLr0otXG9ZaO08BH/6NCW42Tg
 hsr1iMEI4HL63qJdbNCEhen8cHB9H66HWNTsj7dewI0Uux5NtqiR9bxY41sNdtgnEhDo
 +qmPAKh9HXL8T/3DQPI6nVsMGhiHhOr/AnOb51J4EN47X6g4jCMl9wzgmLObewXzKpQX
 vUY2CV6TC/kX5jz/Q3Hg9AQfE608GcRk628et/BNHHdF6ypi33D3HxIiaGqdQbE3TKOr
 fL5RNvmuISnevQa6U8qJbzI2HQJljTYuSaDUB84sJdhXy8Rwx9clM1BjQGGH4gQJkgV3
 LJoA==
X-Gm-Message-State: AOJu0Yxu6Up7E1FYY8Xm1UuL95Kc+h0C4EYEZUDkXTZ865zfgemyaUxQ
 OREWW7e8ULvB53nlz1F1AbgiDx5cJJCSaY8XETxejaLcBRU9M+8DfPTAZxXL6lopB6ep5vwMFVA
 =
X-Gm-Gg: ASbGnctGnEpjvGw/AKu5SHtg4bsAy4HCHAhuDwO7mWUYT5ERwFq0LCCE4zF0Rtiz84t
 5ADUwVsCLPXysfJJh7rhZ12EjXaKWVP0IRnZTa2NWce6qVC951ul6sK9QF2thPXvJaE1eBHvlCP
 96bR2D1Fuc8ebVmVfExncYgMJh6lDyzHc+t6ceVHPzm/IxnukwMO3PeSAf2SDPhQeKt5tL0qWQ3
 2hvyxlp82HgeJhUcWrk3McdTm/Nj/8gUxhLmVc8pd7VCnc=
X-Google-Smtp-Source: AGHT+IE+r43h71p7NffopLexJp7Iy1JTAHuFTe225uXo/i/QQf9kyTkalJxPuV60gt6DnYjrinySKg==
X-Received: by 2002:a05:690c:64c3:b0:6ee:6a2a:a517 with SMTP id
 00721157ae682-6eecd30402cmr45880317b3.18.1732228349486; 
 Thu, 21 Nov 2024 14:32:29 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 3/8] test_ut: Add an image size to setup_image()
Date: Thu, 21 Nov 2024 15:32:09 -0700
Message-ID: <20241121223217.330117-4-sjg@chromium.org>
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

Add a parameter to indicate the size of the image to build.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---

Changes in v2:
- Split out image-size patch and default to 20MB

 test/py/tests/test_ut.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 70ac012b3ad..0b716f4029c 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -28,13 +28,15 @@ def mkdir_cond(dirname):
     if not os.path.exists(dirname):
         os.mkdir(dirname)
 
-def setup_image(cons, devnum, part_type, second_part=False, basename='mmc'):
-    """Create a 20MB disk image with a single partition
+def setup_image(cons, devnum, part_type, img_size=20, second_part=False,
+                basename='mmc'):
+    """Create a disk image with a single partition
 
     Args:
         cons (ConsoleBase): Console to use
         devnum (int): Device number to use, e.g. 1
         part_type (int): Partition type, e.g. 0xc for FAT32
+        img_size (int): Image size in MiB
         second_part (bool): True to contain a small second partition
         basename (str): Base name to use in the filename, e.g. 'mmc'
 
@@ -47,11 +49,11 @@ def setup_image(cons, devnum, part_type, second_part=False, basename='mmc'):
     mnt = os.path.join(cons.config.persistent_data_dir, 'mnt')
     mkdir_cond(mnt)
 
-    spec = f'type={part_type:x}, size=18M, bootable'
+    spec = f'type={part_type:x}, size={img_size - 2}M, start=1M, bootable'
     if second_part:
         spec += '\ntype=c'
 
-    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} 20M')
+    u_boot_utils.run_and_log(cons, f'qemu-img create {fname} {img_size}M')
     u_boot_utils.run_and_log(cons, f'sudo sfdisk {fname}',
                              stdin=spec.encode('utf-8'))
     return fname, mnt
-- 
2.43.0

