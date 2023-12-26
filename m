Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A36AC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF70D8792D;
	Tue, 26 Dec 2023 10:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ngqW2hRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 829F587922; Tue, 26 Dec 2023 10:48:22 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4A687919
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28b9e9e83b0so1876386a91.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584098; x=1704188898; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKFLwlJscF5JbYbHdx9KmaBk32ZX7p3thN5rrl+Du8k=;
 b=ngqW2hRXKbdKAN7TWljP+Rsab2zgliTwh9ovzfE6StxVg8U1fwUDYhnIVWrLtBnaE5
 wJpAQToF0k9cdd7rkBAbvnJzfvEoFkAJZVqGb1uv0k81xLyEjJT5pnKYE6sgWUgQcB76
 w9AYrZTbAFRKxnWea5+CBUFD9VnLzWiaZfLrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584098; x=1704188898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKFLwlJscF5JbYbHdx9KmaBk32ZX7p3thN5rrl+Du8k=;
 b=Zn4dViPoIwvAa1PKVaFp62kh8Nlmh4kdMnH6R3IKDCDnd2OckeIAcusPHy8KM11q2o
 A4k3+nGuxoKPFqb5U9/8oO0Np1URJrrPBvKmAvBKJFZjxm4wR5Ua1XIusIEMdWM7oIx0
 EEKDsCHrVnPtdNjM41WK8oNyUregqvpOGXjKBK4tXvWujFttgXD9fdTIeRyS/2eFnDFC
 jYZFCByCfV4fA271767RkAHfOPwNkXlFgD97aDvh2HBNWTg6iu+wSbqR5SnyUP2t6Eh3
 h24rWkJKRyMoWnGdFMHDTyA8MYEkvl3DH/VwqZb6x5v+8dqGuaCqyhFyHNGiZbznQ3gI
 fhvQ==
X-Gm-Message-State: AOJu0YzUQpGEHKRgdq13sFVhsHbb8MaFJrz0h2hDRPp/irHngm2i25qM
 CMdeoxiMozHd6TyQNFssXAfs9SjOAQ7PhXNNC/LNC6RTf4is
X-Google-Smtp-Source: AGHT+IGV9CgLCXivwFKZET2z8xvjAZwJFYQpRvHoHD4vqFO5m7Ve+bMwxPKNqN88TWJ/UNXn8N05BVXc8RCakWz6ohM=
X-Received: by 2002:a17:90a:3002:b0:28c:42c8:7fbf with SMTP id
 g2-20020a17090a300200b0028c42c87fbfmr638808pjb.29.1703584097998; Tue, 26 Dec
 2023 01:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-10-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-10-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:47 +0000
Message-ID: <CAFLszTjGejJm4XdCachiy5C-2i2L2XyWUschx+bNy+1YpYoOcQ@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] qemu-arm: get FDT from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
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

On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Get devicetree from a bloblist if it exists.
> If not, fallback to get FDT from the specified memory address.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactor of board_fdt_blob_setup().
>
>  board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

I believe this patch will not be needed, since we have fdtdec_setup()
to do this.

> diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-a=
rm/qemu-arm.c
> index e225011bf0..d326668caf 100644
> --- a/board/emulation/qemu-arm/qemu-arm.c
> +++ b/board/emulation/qemu-arm/qemu-arm.c
> @@ -149,9 +149,17 @@ int dram_init_banksize(void)
>
>  void *board_fdt_blob_setup(int *err)
>  {
> +       void *fdt =3D NULL;
>         *err =3D 0;
> -       /* QEMU loads a generated DTB for us at the start of RAM. */
> -       return (void *)CFG_SYS_SDRAM_BASE;
> +
> +       /* Check if a DTB exists in bloblist */
> +       if (IS_ENABLED(CONFIG_BLOBLIST) && !bloblist_maybe_init())
> +               fdt =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +       if (!fdt)
> +               /* QEMU loads a generated DTB for us at the start of RAM.=
 */
> +               return (void *)CFG_SYS_SDRAM_BASE;
> +
> +       return fdt;
>  }
>
>  int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
> --
> 2.25.1
>

Regards,
Simon
