Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E98E77376
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 14:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6914786F6F;
	Sat, 30 Sep 2023 16:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fXYdLOnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A8086F6F; Sat, 30 Sep 2023 16:36:29 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5519E86D63
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 16:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-417f1eac78dso94591761cf.2
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696084586; x=1696689386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pSMr+YwqdzdhcgVOfdWF0oH0uKtywk6481h3jc5VlS0=;
 b=fXYdLOnhXn8g26CrBnnQDfvmnVFwMKHtGlml/AxlZKiu8U2/lzle4RpCfZbJRvhBUb
 71sNS7Ef5g0BFYRw+7C/Q55Q3Kbc3qBMKDoOMN54z23SQqNOj/q0e7Y9xryF2Ei1PzLZ
 Pm3GQqKmvtXe4owo8hNZ8jSe2wqiC/+HKEC9yQQNRtRMCaAXgo7uHWM+mr5MYerkIo71
 6NA4otIfMFkZpp0z/fDCGF5NFTaG7zSNG0jsSq34sUP8XZY1olV97NJp3IuhX0CpZZRN
 qjnTFBb40eUp7hNGCfJXl+sVBf++tP7+ahitgW2M1VUrxuo0hYQRy70K11102DuYqUj5
 5Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696084586; x=1696689386;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pSMr+YwqdzdhcgVOfdWF0oH0uKtywk6481h3jc5VlS0=;
 b=OpRZd6cuBNidKnFGmLndfz8eExbsjw3h6AdZse+IYe1/ypOA6BYlR7InhKO0MowQnc
 lwNQWqyhYq96MZsPZujoAVTT4+vHJElihBfW7U/5tvQYzcnvS8zOD9TNXOh58uGJwxQF
 gds802PUrZd5/vk9EQ2NQGTYNJXoUDb5QfSanVRUPA5Bc3ADojTEqcO7ly2oPV4GHB4U
 aSPR390Z86Q0NeFbzhmmNVTg9jKzo+Pgp0fLER3akYwkzglbjPhuEHv1nMXrAkHQHIJN
 UXGnoSkUbro26CdaZlSaQ9SBBULAl0kYZQm1cV0wWV0bfAEpvOSGfCecMHblRMirWGwM
 G8IA==
X-Gm-Message-State: AOJu0Yzmf3xLd/gR7TIoacr+uwZyTm90JbUnjYhcScQ/zGG51vBjO4l8
 2scFHvIZt1Lhw3exnI/v3Svdldmax3E=
X-Google-Smtp-Source: AGHT+IHYXXTRKw10zaAInWpSgVZOuMVN+C0/5ldPHo013mDHVzXCsZczHoQIKLeO6VQDvpPloxxWDQ==
X-Received: by 2002:a05:622a:1a15:b0:418:ff8:3833 with SMTP id
 f21-20020a05622a1a1500b004180ff83833mr9455820qtb.52.1696084585694; 
 Sat, 30 Sep 2023 07:36:25 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 z15-20020ac8710f000000b00418142e802bsm4900329qto.6.2023.09.30.07.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Sep 2023 07:36:25 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] linker_list: Fix ll_entry_get alignment
Date: Sat, 30 Sep 2023 10:36:23 -0400
Message-Id: <20230930143623.318903-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

When ll_entry_get is used on a list entry ll_entry_declare'd in the same
file, the lack of alignment on the access will override the
ll_entry_declare alignment. This causes GCC to use the default section
alignment of 32 bytes. As list entries are not necessarily 32-byte aligned,
this will cause a gap in the linker list, corrupting further entries.

As a specific example, get_fs_loader uses DM_DRIVER_GET(fs_loader) in the
same file where U_BOOT_DRIVER(fs_loader) is present. This causes a crash
when walking the driver list.

Fix this by adding appropriate alignment to all accesses.

Fixes: 42ebaae3a33 ("common: Implement support for linker-generated arrays")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 include/linker_lists.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linker_lists.h b/include/linker_lists.h
index f9a2ee0c762..e0c8a01b9ba 100644
--- a/include/linker_lists.h
+++ b/include/linker_lists.h
@@ -209,7 +209,8 @@
  */
 #define ll_entry_get(_type, _name, _list)				\
 	({								\
-		extern _type _u_boot_list_2_##_list##_2_##_name;	\
+		extern _type __aligned(4)				\
+			_u_boot_list_2_##_list##_2_##_name;		\
 		_type *_ll_result =					\
 			&_u_boot_list_2_##_list##_2_##_name;		\
 		_ll_result;						\
@@ -229,7 +230,7 @@
  * @_list: name of the list
  */
 #define ll_entry_ref(_type, _name, _list)				\
-	((_type *)&_u_boot_list_2_##_list##_2_##_name)
+	((_type __aligned(4) *)&_u_boot_list_2_##_list##_2_##_name)
 
 /**
  * ll_start() - Point to first entry of first linker-generated array
-- 
2.37.1

