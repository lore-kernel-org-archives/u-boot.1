Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31595CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE6688D33;
	Mon,  7 Oct 2024 15:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grmjJSR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F345C88AB9; Mon,  7 Oct 2024 14:54:38 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFDB888EB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martinstolpe@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7ae3d9a93c0so461993085a.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728305676; x=1728910476; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8nhchx8uXkbtyCwIDt13jpxsfQIPCZMz3OUPRGgKJrM=;
 b=grmjJSR10X7mybyoQYH0cdZtuyqNApeCRXkEFcxeyscCgH0m0RvtehVuBEWb8P9/pA
 28AldS/QvTdRnfUNj5eBLS5vza2NBisAyXTmOMNsB0ISwrN2oyU/2gsw09B5V1bs+prW
 cX/Dm8UZTUY9ePoQBDQvkuKyTlWf6cm5crIW9EhdDOgGO6UZjkSfSvmvHfErPkHaO4kh
 sQjUHt68imgM5W4rM/rsKMgVR6YfOt2ShT6AZKJwO9m14mA+l1zEYVUkm8t5S65+njM4
 7FcGo+nQqDeY+seWIzgd3VMKH8Bxa3/pYfcovLpWhcWbRewhdUwlYU0XhAW2sGRBepsC
 kIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728305676; x=1728910476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nhchx8uXkbtyCwIDt13jpxsfQIPCZMz3OUPRGgKJrM=;
 b=OKeOssMsiktdowCiAMQk+8o0Q/a7mAZQ08K4t/KVYvy7q/HmzTPu+H/KQM8yf1FodP
 Lil41Dvv/WwnGbjWOEPFWVL+D9URuV7D30L3D3BbRPAOGQr9OxJkxZlKDo7JAUKWMB4I
 VgyHt8LkcfKmPR73pLaFcJHduEc7Q+TQfVfZh+awlxGX2bnMcZXLOSrA9ubfquNrJ469
 8+4KWdGqv0CjXoUFErhQX6aU1pFwowHKVd3dHL6wqtvzb/7yYm9XjgYxVfIJWh6ygUuJ
 R9ACr7PIWhn1+inq6gTEy7rpVykGsIhJAMBHZcvhkFwQFMGMwzDH7MQpdCZ/l8K+ilRL
 FYHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhuYBX+LTRiWrnXQKDEe5LzqF4FbPPuO/UdhC4iCtX2xJ13uoRfSZ4CQpeWapxJJrsbrPv6f8=@lists.denx.de
X-Gm-Message-State: AOJu0YxF6R3TBCK/tU3z69BhaEwe4loXY0Ia8GS5nuTM6pQyqcLDiU9H
 8ieKHPHQwxrKGmuqSdF39O2jvKB5YeFNxnnZWBdcp7OX64XYOpkF3oT+FuzwzGGA/5QLA2VULkH
 uZwxccRN8SffqAtKl+f20yfdJ/TM=
X-Google-Smtp-Source: AGHT+IEQruXjWdcwKrFWMcC/IKlJKPNCUahQ0/sx5OAPUCfP37xbUvcSKJQKytInd1oSv3mzmO5lgOZOUIGru3Io/Ns=
X-Received: by 2002:a05:620a:4555:b0:79d:532a:fcbb with SMTP id
 af79cd13be357-7ae6f42cf76mr2152613685a.2.1728305675707; Mon, 07 Oct 2024
 05:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
 <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
 <CAPHZmLbcfMVOydp9jCY0mWKdKPePBp+3rfttMyKbHT-CbB7kjA@mail.gmail.com>
 <e27aef89-8038-9099-58ed-b927cce54579@ti.com>
 <CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com>
 <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
In-Reply-To: <08a38499-c36d-4bf7-adcc-d3f547f3afc8@ti.com>
From: Martin Stolpe <martinstolpe@gmail.com>
Date: Mon, 7 Oct 2024 14:54:24 +0200
Message-ID: <CAPHZmLaVVSckGeqU09WMy0s4rGA-w6pQ9ObPuh3SBf8uTBaD9Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
To: Devarsh Thakkar <devarsht@ti.com>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, u-boot@lists.denx.de, 
 Francois Berder <fberder@outlook.fr>, Matthias Brugger <mbrugger@suse.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Tom Rini <trini@konsulko.com>
X-Mailman-Approved-At: Mon, 07 Oct 2024 15:25:58 +0200
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

Hi Devarsh,

Am Do., 26. Sept. 2024 um 18:45 Uhr schrieb Devarsh Thakkar <devarsht@ti.com
>:

>
> Thanks for taking a look, I have posted them to the list [1], it would
> be great if you could provide a Reviewed-by or Tested-by too.
>

I've tried to compile the project for am64x_evm_a53 with the patches
applied and I've added the following line to
am64x_evm_a53_defconfig: CONFIG_OF_BOARD_SETUP=y
When I then try to compile U-Boot using the following command:
make am64x_evm_a53_defconfig; make

I get the following error message:
aarch64-linux-gnu-ld.bfd: boot/image-fdt.o: in function
`image_setup_libfdt':
/home/mstolpe/repositories/build_base_station/build/workspace/sources/u-boot-copy/boot/image-fdt.c:633:(.text.image_setup_libfdt+0x150):
undefined reference to `ft_board_setup'
aarch64-linux-gnu-ld.bfd: cmd/fdt.o: in function `do_fdt':
/home/mstolpe/repositories/build_base_station/build/workspace/sources/u-boot-copy/cmd/fdt.c:687:(.text.do_fdt+0xf98):
undefined reference to `ft_board_setup'
Segmentation fault (core dumped)
make: *** [Makefile:1801: u-boot] Error 139
make: *** Deleting file 'u-boot'

I guess this shouldn't happen?

BR
Martin
