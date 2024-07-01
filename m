Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDCAC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B361884D2;
	Mon,  1 Jul 2024 15:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PSDnIPhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A8BF886C3; Mon,  1 Jul 2024 15:57:57 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6434C8863E
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b5932383e0so33022106d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842273; x=1720447073; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ey5Ds5O3wt8UuDt7+QqYHj5kKGLUEQrBXSev3cPIufM=;
 b=PSDnIPhAUH32GM2biw5IYaTRoyGuV9EKHV8VhsPO6Tf8ShCYJ3Iy0VyiRKU7oG7Hb7
 kl4cshewOZRHI4nUmtVaMZbmTJNVLv1Lco3eShLmgKMA1xanh7+bNK0riYgqAFfseGJR
 pQSqKuiP7eUCPE3qSMathyECFQjLWly0oJ9c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842273; x=1720447073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ey5Ds5O3wt8UuDt7+QqYHj5kKGLUEQrBXSev3cPIufM=;
 b=GTcbr9LCopBtVcKriCKjEMaLayfng6eSTdbGeHluglyc7QMYX7MkH3MxzSrnpl8MV3
 /hkl+bJBgS3F5LppayRMCh5FdQb9ETkdJ6XvztlNQEIrbCNIVSR8XYG8MaGshC99QRub
 XFGYleij4gN5qHQH8prLHc/aimvcBQ24SQ4HGAqfml858N/X7XfWWAEXoArjRk4yk2IB
 PtNEQid5M3zIUdi16VL1zMEdGDs7W9s77LZ9VTtQ336uNImaZ29g/I3WpgYecMNf0Azx
 HVZscIq+MFhhuIVRXRUC8VHSw/re67aIyYqb18niN9drmfA8pWwjBXiu2fXy3WBs6Zx2
 UrWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUicBle9B7zSv+Y11brrqSu6IouGGwHuSsUTpMegs56pO7MPAnDaeLQUa5RmIHyzaKf6bTAB7KwR7hJUp0xMpmXt55Z6A==
X-Gm-Message-State: AOJu0YxmMTzkyPXAjYDzQIvQz1od0me813UpGofRHwidnzlqE1OaOGvK
 lRWvrmX8qFxhDOEScKsuSLgNzt5043IldlYue0fA/ON5JtbFYrt0x03ME1ym5QTVDijvct+r5Gi
 9dkLZpvoemovBaZ96fZgWdfNyxDyIVZfnsInE
X-Google-Smtp-Source: AGHT+IFwtxhh/zMKVHgQXe6Girvzqy5qXC8yVT6rLvBH3Xg6rwKjKaJQ5tYJ1CJqdCLRscGFgDcUJaP2EM8y9nU/sU4=
X-Received: by 2002:a05:6214:242e:b0:6b5:5687:8f7a with SMTP id
 6a1803df08f44-6b5a545b318mr165198546d6.21.1719842273346; Mon, 01 Jul 2024
 06:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240517160624.156962-1-heinrich.schuchardt@canonical.com>
 <248bc1e8-2fcb-4865-a7a3-dcd2e0df1aa5@app.fastmail.com>
In-Reply-To: <248bc1e8-2fcb-4865-a7a3-dcd2e0df1aa5@app.fastmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:42 +0100
Message-ID: <CAFLszTg5ZpcuytnfDK5dJA7Bx71xaqSHJG0Doy0-cZOp06Duqg@mail.gmail.com>
Subject: Re: [PATCH 1/1] defconfig: disable VIDEO_COPY on the sandbox
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

Hi,

On Fri, 17 May 2024 at 17:36, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=885:06=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
> > Since commit a75cf70d23ac ("efi: Correct handling of frame buffer") the=
 EFI
> > block image transfer is broken on the sandbox.
> >
> > To test build sandbox_defconfig with CONFIG_EFI_SELFTEST=3Dy and execut=
e
> >
> >     setenv efi_selftest block image transfer
> >     bootefi selftest
> >
> > Fixes: a75cf70d23ac ("efi: Correct handling of frame buffer")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>
> It turns out that texture copy is only required for 8bpc display, which
> we don't care much anyway.

I can repeat this with this change in sandbox.dtsi in the /lcd node:

log2-depth =3D <3>;

I see:

>>>
Selected test: 'block image transfer'

Setting up 'block image transfer'
Graphical output protocol is not available.
Setting up 'block image transfer' succeeded

Executing 'block image transfer'
Executing 'block image transfer' succeeded

Tearing down 'block image transfer'
Tearing down 'block image transfer' succeeded

Summary: 0 failures
<<<

It looks like gop_get_bpp() doesn't have support for VIDEO_BPP8 and
there may be other problems.

I don't want to display this option in sandbox, since we want to test
the VIDEO_COPY feature. Instead, I think EFI support should be
enhanced to cover 8bpp if desired.

Regards,
Simon
