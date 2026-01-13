Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAECD29DD4
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 06:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D49836A3;
	Tue, 13 Jan 2026 07:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ChyGFsoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC45836C8; Tue, 13 Jan 2026 07:35:36 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFC583678
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 07:35:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c7aee74dceso3113895a34.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 22:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768286132; x=1768890932; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cxsZwtuns+lnC0OooGzqHjyzyUlO+0Y5r8nyeXFOvs=;
 b=ChyGFsoc2KogCDM77TeYsH2s0D/VVaY2VAnOP7yAnqq6SJMgmN6z2EDcHTZ7pXp2y0
 HZKg+VALBQ1ZArKSKKHrTDZBK7rc3qLAWRfrQyKXpK8IPugnSEP2BxeVN0Eqvdmun7zI
 7aCB5xlL7jnadhdVH17z1eROSz/5CpcDwS0l/FdveKKtyheXZ3RsczOzPFFo2dcWImvA
 VoqbSv6sRPpp52PS7Gy+cgAQyxnn9hCte7Cd5zsho7iRZzWpnVXoCtgqs+GaFyf8l3jS
 qWg8MjCsmIuFp6WYPCNCDNWYqgwz3FvegaCCX0MTzRp/VBDCq9NI+Y/t10kDC2BSIAtE
 tjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768286132; x=1768890932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7cxsZwtuns+lnC0OooGzqHjyzyUlO+0Y5r8nyeXFOvs=;
 b=mz54w4hi5Rb0GEdg2Z99OWZuwHaus/Tx/SWOo/CVVAc01WPtJtmCqy4CMk9ZmItKiy
 MyIu5f5oT8YviGQx1dw1dlADO//FtfZVEYmbSWtKCHZfgtZLsKNLuE+i9TkOQh4eUMbR
 nEt7s7t4mnwYE6aU8xuCP8I7giQ0gBb77p2/KHuPx7zT+/d78tUX3ojFkbbsFk1FJ1bI
 9Dk77Iauk0j9JCQA6c1GbHhEkA5VSCPDDwGtaGpQupQb/jbYwcNv1ooP8E7RlIIeeQGd
 Znwd9M2nKpndEDEDv8qkTU6Tp3uBeH+RHIB+OA+BjhjifHAYTN7J83hk2EU1ZsadDqIa
 bUOg==
X-Gm-Message-State: AOJu0YwAOQSMwDqRXqqEVfImk1SFGvPiJbJQBL71CBIMJKQwS3WKC01C
 8bRCoc9pei0W8F/rolIihK/UrIxPQqAhuQ4Y6qCaplHUKVQgjRjZ5ijb2IFYCfy8xtCgzx8Mpyv
 ikEzopwPb7lA/XEBFSXCN9PI0UReJJKhei+h54BU=
X-Gm-Gg: AY/fxX7csLdmq79VCfpCrduDeWg2cFYJNnumT3c0oUg+pubThs259cx8tyfyvNNVh7+
 BtciNQ0H3Si8LoPNYGCbBz7BacJk1T62HKAinhfwI/b4L53Bad1H8UuUlL6l1Nw/CuSyZB6WPxO
 GsCg53DHO8Y3gpqpDEcHo89MYTBE/WA/a93TncMOs6dAxEEPnbJ+SYYtCMtLakPaVPs3RJ/pWRP
 v+xZavcvX8M6PCYqRsOk17iya/mYj00RoHDshDTh48VnOPoD8gPKlDdfcWL9JXCp6Yrgbc=
X-Google-Smtp-Source: AGHT+IEY62rGP/W1qIChP2zpePX6rNAXKjYE98DVUQ23/rdplPyFkT0Je0U4dl7/eEL/96ldybUYS/O1bx1iNFzKAdg=
X-Received: by 2002:a05:6830:929:b0:7c9:5e2e:297d with SMTP id
 46e09a7af769-7ce5089d97cmr13774081a34.3.1768286131880; Mon, 12 Jan 2026
 22:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20251229153354.5558-1-briansune@gmail.com>
 <20251229153354.5558-2-briansune@gmail.com>
In-Reply-To: <20251229153354.5558-2-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 13 Jan 2026 14:35:20 +0800
X-Gm-Features: AZwV_QjBE8f2kENy_qOhX73gUGcjr0OVH3EBEr0fcbL0f2cGvYtvcfsUELZPX8M
Message-ID: <CAN7C2SC43GUgfgcv=-zq3R5RxRRbwYWL_kmgeRPi-thtHUC5bw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add CoreCourse socfpga Board - AC501
To: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi T.F.,

Any issue on the new board patches?
Please review and push to the mainstream if possible.

Thanks,
Brian

On Mon, Dec 29, 2025 at 11:34=E2=80=AFPM Brian Sune <briansune@gmail.com> w=
rote:
>
> CoreCourse Altera GEN5 Cyclone V board
> do support different size and formfactor.
> Now introducing AC501 C5 to mainstream u-boot
> This is a UBGA-484 based board with basic
> feature. More info on [1]
>
> [1] https://corecourse.cn/forum.php?mod=3Dviewthread&tid=3D27704&highligh=
t=3DAC501
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
same~
