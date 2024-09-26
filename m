Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65019CF9C69
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 12:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7F388A0A;
	Thu, 26 Sep 2024 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EtC6f4l4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E7788D7C; Thu, 26 Sep 2024 14:26:36 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A4788D66
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-502b144f31bso371876e0c.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727353592; x=1727958392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TPVKSYqksld4x3tmagLssd18s6YTs73aCRnZjlaH2Wo=;
 b=EtC6f4l4xVa8PhsbO9xhkOeKez9RpkbLjomNDVBWlxPNPznmXqWjFSyYdYCHJC0NtQ
 iQwsFvSb+8+JxauXa0BQSRrhkyOSgLx678mouLCSnLfUw9zyKnSbLeBf0uZCIt51zNU0
 Cc7d8hSWAbmMoiGkWDyhrcHO9km/oOd/33RMw45xhO1AjnuIoXgAqBH9CXIPnoa19UKU
 yX7AAz2M3LGJ76eX3fIOyZJ2ZXgJBJfrAjHirjYf3gy3bYt1hS0AraBoiA5/B/658qT7
 JxVTvf+hbgZgVSNXIf5JaQdpmL6zOCsLcDqPOSPnLPzZHF7hlNjxW5AXIOX0J7at/4YW
 pezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727353592; x=1727958392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TPVKSYqksld4x3tmagLssd18s6YTs73aCRnZjlaH2Wo=;
 b=p/MeCcuLD023yJhhcZ2PXWyhAo8ffpCre2D8qlBTy4+fCtjYU0xWKWjVzWWeCGsTZb
 oNmz5ZBJKBAEnNUa8Fl2xobV0pzwz8vnaF0ouN3RbN1kbbpmi47+W4CLSbp16oCPR9c6
 7PhG5j2FCnW12fVy9FNHL/U3+7WykHt1761mq/BPGeIn1zqEQ1MEWyCEJ5ZM8x1905Bf
 gw7ElPWUO67qf9rk9dcEA+/Yaa5T/ZUckZ1H6dzJxH9HzDPDNCm4pO4ogqscBBvkvQUJ
 tYK+2ABe6YhybSFTTh3/yy7MYkrJUe1erR/VTPb6P7c++dIZwc+yO1yqgMXUQPdA10xp
 otcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBNgYADxyoWc2TqrjvbW+qb0sJwK1Omk3narrq84jOunvw6CHnSR7A4iXo/0GqjHTQ/K3vj7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3n1SG4RMlu60SnAHQr3T1pKa5UjURRRDdmPJv83W93qd1NGEG
 bNDgqAhZlTDMIBaTFHbDisja55d3PYsU4NxqPvROK2RrYpEth0ZqfnyohqKbK6W6PUz1X4xVVpo
 l6G0kv5/SHVduu8NwtIB51wFRqeU=
X-Google-Smtp-Source: AGHT+IFMZnUE128F1/AxOjmMArajvdhPqHXgpPFTLQ5DxB6MSPDNKTeiXVUAAa7FLDBQ+BDUdV7YZ8nNRjc57u1JQNY=
X-Received: by 2002:a05:6122:2001:b0:4ed:145:348f with SMTP id
 71dfb90a1353d-505c20c9250mr5038866e0c.12.1727353592327; Thu, 26 Sep 2024
 05:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
In-Reply-To: <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
From: Martin Stolpe <martinstolpe@gmail.com>
Date: Thu, 26 Sep 2024 14:26:22 +0200
Message-ID: <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: Devarsh Thakkar <devarsht@ti.com>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, u-boot@lists.denx.de, 
 Francois Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Thu, 26 Sep 2024 14:40:42 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

Am Di., 24. Sept. 2024 um 08:38 Uhr schrieb Devarsh Thakkar <devarsht@ti.com
>:

>
> CONFIG_FDT_SIMPLEFB is only used in splash-screen context which in-turn
> depends on CONFIG_VIDEO. So CONFIG_FDT_SIMPLEFB is in a way dependent on
> CONFIG_VIDEO. We had fixed similar issue in past in vendor tree and by
> making
> CONFIG_FDT_SIMPLEFB dependent on CONFIG_VIDEO using below set of patches
> [1]
> which I was planning to post upstream too.
>
> Kindly let me know If these patches look good to you and fix your problem
> too,
> I can post same set of patches to upstream too.
>
> [1] :
>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=1199800505f11f2162030cb641c6d0c9276d5c9c
> [2] :
>
> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04&id=5b4b8eac243cbd86286ff2cf57ca0469c4d86345
>
>
These patches look good to me.

If I understand the code correctly the frame buffer node should only be
created if CONFIG_FDT_SIMPLEFB is enabled. Thus I would change the code
like this:

Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
---

 board/raspberrypi/rpi/rpi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index ab5ea85cf9..47db441696 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -569,11 +569,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)

     update_fdt_from_fw(blob, (void *)fw_dtb_pointer);

-    node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
-    if (node < 0)
-        fdt_simplefb_add_node(blob);
-    else
-        fdt_simplefb_enable_and_mem_rsv(blob);
+    if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
+        node = fdt_node_offset_by_compatible(blob, -1,
"simple-framebuffer");
+        if (node < 0)
+            fdt_simplefb_add_node(blob);
+        else
+            fdt_simplefb_enable_and_mem_rsv(blob);
+    }

 #ifdef CONFIG_EFI_LOADER
     /* Reserve the spin table */
-- 
2.43.0

What do you think?

Regards
Martin
