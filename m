Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF26AD4335E
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E9F3892D5;
	Thu,  7 Nov 2024 14:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IhszbV9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57BD892B8; Thu,  7 Nov 2024 14:45:41 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E18588581
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so10123605ad.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987138; x=1731591938; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFyKSeFj+nYz5nf5MyRXK5TNfkBAg4s1+rIXOPOxjAQ=;
 b=IhszbV9GLyuWzVNcchGk4JZ6FUN8drObHsaGDib7La0RlWvrcDNRwDJL1j8/x4NGMI
 S210iEDDALiqwI3aA46ptWI/6+6n74dnf/9qx87hXPA5osteCanW0pDQt6vaUhqH3fVd
 XWPcDUZxguS/xQ1X9Bg5lE21FU8CHUun1KTU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987138; x=1731591938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFyKSeFj+nYz5nf5MyRXK5TNfkBAg4s1+rIXOPOxjAQ=;
 b=JhZInNMqULB+it2jtVU1vnfg3W90BdyMdTwnWrvl5SopG22IjgQZXuNYYYK0h1bSjh
 A17rNDWeYvE8FbGm+Coxh3TzMtlx2PI7PtEsWvCXC/xAUW6lICG021kP6ZRzoEaopeB/
 3pvXcgxlMUwrBgFgPc8mpkQowD3ngpE2TmC7EneZf9qQvlsoyVVkSxKHoD+tzB6OYa92
 zQrMq0/ZFX6sWpx5iRCdhhnncFXMmGvwv2rlPRHybzmflGwno0SMWfYFwetocZrYcxyd
 0Jxui1X1c7C30gRUNy35JTvTWMo4VezU8jpKb86CUX4v3r9gw+TNtysRaA48atG+nO3k
 8w5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAoBZsAJoXqqZJ15W8x63yX4H3PsjokZvIfuyk+K3jDNG0rQtl6zyQ3N4qBPV288K3vzYsdYg=@lists.denx.de
X-Gm-Message-State: AOJu0YxlWEF5uyeV88vqqXXNhrCLlAXcIjf9nHgEy/TFb7MPAosYqPxK
 RqNwS8ocClgcT21d/iELPmawhg1mGBNtDQlCyFw76+sqJ+MxvjoWjj5xVEbgQ/Q+rp7q7PnQmRJ
 2PG3g7DyVHvqfe5srggphraKeWa5KAUuZQEik
X-Google-Smtp-Source: AGHT+IF66HiyCqKmHR7gfSGrccrvUaqjIb5GHIvLiE+bkKtYHXH0JEWaMn5y3faT7/GtTew9NcoOnRya70DSjTcYKuo=
X-Received: by 2002:a17:90b:28c5:b0:2e2:e4d3:3401 with SMTP id
 98e67ed59e1d1-2e9af9d63bemr62852a91.20.1730987138117; Thu, 07 Nov 2024
 05:45:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730909884.git.namcao@linutronix.de>
 <fc389bd029264da3ac37de28a1881cfb6fd95988.1730909884.git.namcao@linutronix.de>
In-Reply-To: <fc389bd029264da3ac37de28a1881cfb6fd95988.1730909884.git.namcao@linutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:30 -0700
Message-ID: <CAFLszThMD+Gh6M8B7eqDSDRCSPOgDM25SY6qANHBhh50HFz5Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] boot: extlinux: Fix unaligned buffer for reading data
 from file system
To: Nam Cao <namcao@linutronix.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, Sean Anderson <seanga2@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Javier Fernandez Pastrana <javier.pastrana@linutronix.de>, u-boot@lists.denx.de
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

Hi Nam,

On Wed, 6 Nov 2024 at 09:34, Nam Cao <namcao@linutronix.de> wrote:
>
> extlinux_read_bootflow() allocates a buffer to read from file system
> without any alignment.
>
> But for some block devices which transfer data via DMA, ARCH_DMA_MINALIGN
> alignment is required. For example, due to misaligned buffer, the below
> boot failure is observed.
>
> =3D> boot
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> CACHE: Misaligned operation at range [9efa25f8, 9efa27f8]
> ** Booting bootflow 'mmc@2194000.bootdev.part_1' with extlinux
> Ignoring unknown command: =EF=BF=BDD=EF=BF=BD=EF=BF=BD=EF=BF=BDD=EF=BF=BD=
=EF=BF=BD
> Boot failed (err=3D-14)
>
> Change the alignment to default (which is ARCH_DMA_MINALIGN).
>
> Fixes: 31aefaf89a5b ("bootstd: Add an implementation of distro boot")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Javier Fernandez Pastrana <javier.pastrana@linutronix.de>
> ---
>  boot/bootmeth_extlinux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
> index ae0ad1d53e3..5424d179bf8 100644
> --- a/boot/bootmeth_extlinux.c
> +++ b/boot/bootmeth_extlinux.c
> @@ -127,7 +127,7 @@ static int extlinux_read_bootflow(struct udevice *dev=
, struct bootflow *bflow)
>                 return log_msg_ret("try", ret);
>         size =3D bflow->size;
>
> -       ret =3D bootmeth_alloc_file(bflow, 0x10000, 1);
> +       ret =3D bootmeth_alloc_file(bflow, 0x10000, 0);

Can you please use ARCH_DMA_MINALIGN here? Either that or update
bootmeth_script to do the same  as here.

>         if (ret)
>                 return log_msg_ret("read", ret);
>
> --
> 2.39.5
>

Regards,
Simon
