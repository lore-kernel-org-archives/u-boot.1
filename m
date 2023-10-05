Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824B5E92702
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416E086D05;
	Thu,  5 Oct 2023 16:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbFqL/iK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6038986CF7; Thu,  5 Oct 2023 16:23:07 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF0286CF3
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vicooodin@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3af609c5736so629987b6e.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696515782; x=1697120582; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYInJ3qeG3d63YXOWn5N68yHVVnZIa6Kx3zVyYQy/Zk=;
 b=HbFqL/iKh6kOe+IduW6/I2ho3fSj0boNdb0hEidxq7eXuoHLKJh4fxZnidhIiCJRPE
 FSCiiNz2wk9WJWTkMaImJLvlbOsO72/tp5fBCxLRiFggdjvpG+PiDAda69Huh9zj8aup
 NKU0V8l1mrh8Qr4KAhQNYxF4ye5jwa20x9rxKIUqvr3yAFG3DVVMR31moLUl/O/2jxNo
 6pVoPhbbYdXqGj0/OFuRNrgBNC4kluhw6eVThnd8w/0Jxl9wQG5bMO6f6FxpLLxWG3D2
 gpOghO1mWqsXu/xcdB7a6+DNR08SyKOog0VBgSe7gGUQLanLC4LxWVkGKMEq4WbzvbL+
 r4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696515782; x=1697120582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYInJ3qeG3d63YXOWn5N68yHVVnZIa6Kx3zVyYQy/Zk=;
 b=bc23YFGXJQGvIielaSUf52PLnVcfGJvW1dCSTsUeYZ/7OywjrEPfv4J3OBBYJmNo6H
 8DuH9U1xwT4GnNxdGqpuHHi1fG7s/R57kvEYhvak/FhjNPe7RCZsz1Z+CioeHfjfbXce
 H0VaXMEUzJZnIVauDUJHCoBEGIgNWbj84ApSNg5lMuab4Z54LQWPjuzTEsBXY5HGQCpr
 mDFmzx2LtzppOLSUkxjyACx86knBYVoGmIaD+q2+aRm9ETDHXptmrr72DNHBoBNpkKzZ
 dAkGqIi60LZnJz7R+4P2b4lbwmsy1DXM5p/ElEiyGZVVIewiE+IGgFqC4Ak9FvvrfxVf
 3wHQ==
X-Gm-Message-State: AOJu0YwZWR+kYbTPr5wgwFy3cCoIN2nTSTjtBlLyyQgiULQY+itk9yVY
 QjlGa/UtCY3vMSIh6q6Hxvye3TGmBGqCovkJS/PS5qUtyOT5BA==
X-Google-Smtp-Source: AGHT+IFb6F+dD1NQ+JEb1ZvIOzFT7KDEIkT3dxZq73OiZebZph1WWp/JJx2LbKfAbi7EUWagBpo5nFVZIdKT3LbV/EQ=
X-Received: by 2002:a25:a545:0:b0:d89:4357:a9fd with SMTP id
 h63-20020a25a545000000b00d894357a9fdmr4745611ybi.18.1696513228273; Thu, 05
 Oct 2023 06:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
In-Reply-To: <20231003085805.2214260-1-andrii_chepurnyi@epam.com>
From: Nastya Vicodin <vicooodin@gmail.com>
Date: Thu, 5 Oct 2023 15:40:17 +0200
Message-ID: <CAFdZxxm4n26PNWUH1vSuuqe27vJ_=voBkLmkuhjwbcfpFE1YNQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] virtio-blk support for xen board
To: Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "leo.yan@linaro.org" <leo.yan@linaro.org>, 
 "andrii.chepurnyi82@gmail.com" <andrii.chepurnyi82@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by <Anastasiia Lukianenko vicooodin@gmail.com>

On Tue, Oct 3, 2023 at 10:58=E2=80=AFAM Andrii Chepurnyi <Andrii_Chepurnyi@=
epam.com>
wrote:

> Hello.
>
> This patch adds the ability to use virtio-blk in the guest domain
> under Xen hypervisor. To do such you need to build U-boot
> with xenguest_arm64_virtio_defconfig.
>
> The patch was tested on a specific build for rcar-gen3 hardware,
> with multiple Linux domains running under Xen and QEMU
> as a block backend.
>
> Andrii Chepurnyi (1):
>   board: xen: introduce virtio-blk support
>
>  board/xen/xenguest_arm64/xenguest_arm64.c | 108 +++++++++++++++++++++-
>  configs/xenguest_arm64_virtio_defconfig   |  63 +++++++++++++
>  doc/board/xen/xenguest_arm64.rst          |   2 +
>  include/configs/xenguest_arm64.h          |  10 +-
>  4 files changed, 180 insertions(+), 3 deletions(-)
>  create mode 100644 configs/xenguest_arm64_virtio_defconfig
>
> --
> 2.25.1
>
