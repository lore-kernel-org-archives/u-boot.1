Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DFC00A8F
	for <u-boot@archiver.kernel.org>; Sun, 22 Oct 2023 19:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B881E8615A;
	Sun, 22 Oct 2023 21:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k6suxmKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17A3877CB; Sun, 22 Oct 2023 21:41:56 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B338885C98
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 21:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso3850831a12.1
 for <u-boot@lists.denx.de>; Sun, 22 Oct 2023 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698003714; x=1698608514; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5b0bnkHkpYdQIjnGBPWhlglcWtd3khva7V6XFsZHQ8=;
 b=k6suxmKm7hCT2PFlyHzgagF+m3UXHVrn7qS6VYWcj5g0Gil+oBuLyKTxeMTzE8j4+d
 q8+EGwHZ6G2Zq+7XyCBABGYdHX6ceBQbzcjvnEHOzyEZEwizRyDrMz66kKUX8q/LE9Lj
 B6afVhzBafab3qZ0ueL3v+bSbaRtAefBSS7L5fHq83xfsS98VdWXv/U8vv8OBq6d4iLS
 fPzQyiTG/BOQDtvC5SkDqlajMQb4wgnI1mA/SX+SpdZmu5XNchynbGUFK7V1S6xS7+Be
 iGrp+ax0YMVhAqlptm+JSVWVS3HO9MBDrzvcC2bELxjTRArj42JCreLFhF3sBCEYtSDd
 xX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698003714; x=1698608514;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5b0bnkHkpYdQIjnGBPWhlglcWtd3khva7V6XFsZHQ8=;
 b=STmO4ELCENskiG+c0kbtnrTwWT074jVBtGiimOB3ZERtREKqlP9iN5U6wEbhONQNr8
 AB2FBGYvXCxdzjGTQyZqjkcrBlQ4ucZzTIkEU1P1CexA4SMa3Z2Sr8QZFrynSldH6GS0
 9zm6XwnKKgtgz+mtxwETZO3qmuofMz3RjArQkHf2Ny/rQrC/Sh9LDuAPZe1p/0O5BPwo
 r0KTqDZuLUlltTUGn5VygpUT/m6FgQ0hk/BxfMYC6N/qTXKUqJd7/RDch1KvgS7++hzJ
 eH+hj3xUEdvEYVfI5uRcs37MIi9Q1L9apCYydccVZ52Yq8STAZ1QOmraBbfaXPJ248Je
 F+6w==
X-Gm-Message-State: AOJu0Yx/UsR1fMYFYbUH1Ein5M8iO84Qm6pIBmVok3NMZFm9D/jNYlGQ
 8IPlmFtM97w5+LIL2CZOM63vc+oEZwxy8HTqDv0=
X-Google-Smtp-Source: AGHT+IG7VyseJr7VxcpVKE27nAkhVLj7RK5YJJX2XST7bA4FcZzKQXB7yXnzJ3AKFIHEzqzecyAE9eK/Q1X3ARehw30=
X-Received: by 2002:a05:6402:34d3:b0:533:4c15:c337 with SMTP id
 w19-20020a05640234d300b005334c15c337mr6150704edc.16.1698003713971; Sun, 22
 Oct 2023 12:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaLiFxGVdoa0wGbir-0kq8w9ZQUsDtN+FgXhaLfJ5_1yjJikg@mail.gmail.com>
In-Reply-To: <CAJaLiFxGVdoa0wGbir-0kq8w9ZQUsDtN+FgXhaLfJ5_1yjJikg@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 22 Oct 2023 12:41:40 -0700
Message-ID: <CAJaLiFyz03GaHhp1YUaCgUV8uxhpiM6aTkZDyQ1N+Z0+ynaZ_Q@mail.gmail.com>
Subject: Re: When do we merge bug fixes and new functionality
To: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom, Simon, Stefan,

On Tue, Oct 10, 2023 at 12:14=E2=80=AFAM Tony Dinh <mibodhi@gmail.com> wrot=
e:
>
> Hi Tom, Simon, Stefan,
>
> I have a few people waiting for these patches to get merged. So I hope
> you don't mind (I'm not sure about the merging schedule), I'd bug you
> guys about these patches. Wondering if these will be in v2024.01-rc1
> or subsequence rc?
>
> bootstd: sata: bootdev scanning for ahci sata with no drive attached
> https://patchwork.ozlabs.org/project/uboot/patch/20231007033429.25109-1-m=
ibodhi@gmail.com/
>
> bootstd: use ARCH_DMA_MINALIGN in memalign() when allocating memory
> https://patchwork.ozlabs.org/project/uboot/patch/20230919212722.16216-1-m=
ibodhi@gmail.com/
>
> bootstd: sata: Add bootstd support for ahci sata
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-m=
ibodhi@gmail.com/
>
> arm: mvebu: Enable bootstd for Synology DS116 board
> https://patchwork.ozlabs.org/project/uboot/patch/20231007213548.20276-1-m=
ibodhi@gmail.com/
>
> arm: mvebu: Enable bootstd for Thecus N2350 board
> https://patchwork.ozlabs.org/project/uboot/patch/20231007220814.30783-1-m=
ibodhi@gmail.com/
>
> arm: mvebu: sata_mv: Add bootstd hook to enable sata_bootdev
> https://patchwork.ozlabs.org/project/uboot/patch/20230906052242.21568-1-m=
ibodhi@gmail.com/
>
> arm: kirkwood: Add support for ZyXEL NSA325 board
> https://patchwork.ozlabs.org/project/uboot/patch/20230826033330.7827-1-mi=
bodhi@gmail.com/
>
> arm: kirkwood: Pogo v4: Enable LTO
> https://patchwork.ozlabs.org/project/uboot/patch/20230824190713.30866-1-m=
ibodhi@gmail.com/

Thanks Stefan and Tom for picking up most of these patches.

There are 2 remaining patches that hopefully Simon or Tom will pick them up=
?

bootstd: sata: bootdev scanning for ahci sata with no drive attached
https://patchwork.ozlabs.org/project/uboot/patch/20231007033429.25109-1-mib=
odhi@gmail.com/

[v5] bootstd: sata: Add bootstd support for ahci sata
https://patchwork.ozlabs.org/project/uboot/patch/20231011202643.9194-1-mibo=
dhi@gmail.com/

All the best,
Tony
