Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279A4E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81EBD83E36;
	Thu, 19 Feb 2026 14:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RxN97XcT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0691183E23; Thu, 19 Feb 2026 14:11:02 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC22F83936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65a3527c5easo1510656a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506655; cv=none;
 d=google.com; s=arc-20240605;
 b=gJTmWeKzWSTSy1ee7+iFxHLqi2PKhu0Jsak7JjTMKjwetPYtImGgimqIhVTNFHJ/Ih
 IfCP7MRc8nWwgHREMU7fcvl1YYZ8cAcaT4d0oCGXJqGnKu2bx6D+BGlXbF6/CfSg+4RP
 9s6oD/d/hTlIP2NuSWR6FOH03Kmo9SEm2pG2VYONz8ZoASubM9V89qQEYVE/jfWtbSTX
 ku5Oz4cwmRaOoCx3skb3sTvJfyauf33lThvKwsPrQ00D1ffMmwyeq4cFdPtt/whik00w
 wnjHBRTlyiwNfU9S/v++d676lVW7oVkHcsUsqWeON9/kjcbkCLNuiEGGxHfShHRgJhMW
 GWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H7Ke1bT7WKuSHR07bc9OeW4z6pJwsgafW89v6FBJWwg=;
 fh=h8DJn1ONPQto9PCb1Hs2C2WQxCPDk+nOjeaq4ewFRVQ=;
 b=imPEQMvA2pscGcOg2hOb2ajkUEuQZ0OG5c5yI+DXPqDHnrNtkJ5h7FO33PBXPQ/70A
 RetA7s2yoXcZVxWkCIW/o0O7AfWV7f+ucTsnhPBaMIMTye1VvwwE60Hf5d9PTUa1wQGG
 PvdFAy1sgSSYWsjOVLALOm8e1bw2EHZjCVtFdQG4VdVWXKnEZo8CKBAmtSBtNkZkWiGa
 8SIYWpUke2rFkMk24At/fLGQcArs7CpDnQr40/BccyR64hApV5m2Pumvw0+bt8uXvD16
 JAU0++Pra46/QSvwUaCk3bNen2zvOiwdmBmp3TKHEg/hd58I0SE8tIqcufduqMBCAO+Q
 kszQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506655; x=1772111455; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7Ke1bT7WKuSHR07bc9OeW4z6pJwsgafW89v6FBJWwg=;
 b=RxN97XcTp67fhjLbZqdZnI+G5pfRZ1fw68SWMhIrknSfqD/KXpNKApJPI5abQ3LLUK
 1x5xsLTYh/WZKCAooCUP5dJaOJnj0jDpyu/qHr64W03oA5HTxcCErBG4nqju+tlNHVeC
 /VkX8uxlzFDnPrJ9hEzfSe8OoBlRRS6ffsPwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506655; x=1772111455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H7Ke1bT7WKuSHR07bc9OeW4z6pJwsgafW89v6FBJWwg=;
 b=ZhZmgde6gx6Jh8v1CKyqC4C7/2TZH4i//F0DAfXARE7goLEr4zFi4KsU2sQH/0KnTP
 WD879HlgjtVjhu5I8io81P91nJFD45YnIGSRpzt4Sq2Jo2lGOpIMqq3usRFe1e6BJ6iG
 pl7NtQdIOZYyK8MlOGH5U9zcVL0l3mRuyVOnxc69VhXIvjWEIclOO+P8evOpL3uW0MDI
 cA62814R7SaYdHQss+THb1WS6Yi6NWW34m4zkbk2Cr36TQ9J8JNZwWbK70wbJltkriFZ
 htsZU3Q+zVStD67WkXNso4gM2NnF9u/TUdc1YCsPkbnjrm0KSy/5aM2EwCpCXgLw99Dp
 hBSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPkNIQENBk8i6+tKvZTvBaKTrwn3kEuyDxaMqRKzIdZo88dY3OFrlNpAfyirbRe0ppKffOwPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwOw5aArRUjAtRSjqMtT8h9C/k7eYQ+wxX8ik6YGEJq9tGQNhIC
 V+rC08hCDfH7YPeEV53QrSdPl7iCs1nU3Ay8BruX1QHngUDPBY2wtZvkICYF2YIJvP4aQGjlhgl
 QclXdZDOxecwReD6XhYd7QVwb0owYnfbeG0DoM48K
X-Gm-Gg: AZuq6aLvWgFvOpa8zyZ/UUZoA+3k+wBoIGR/58Q+0ohJMtWMZveFZVXITIbGl9jUu/5
 slH7hFEAW5FD12OAik3Hdc0niv6l5Wfjgz4CqstxBUtn+oPHtVjerVy+hlPt2w9sLdyAYY463Ae
 VRev4yuMHcOaPQiKBt8gr/S1U/oDjh9GXhnNDuWEZFd5zWOO/ho1JYiep4GSaTljNlUnn+pbQXy
 4iJvyH4GxuR0xm7PK/pdzXmhPLbxprQODeOUdtIhyK9H/65Aeh1HAZDtAaEUTIOjqMEO3NCfmpX
 +D/J1g==
X-Received: by 2002:a05:6402:2712:b0:65b:f81d:7cac with SMTP id
 4fb4d7f45d1cf-65dbd3a2829mr1592828a12.32.1771506655318; Thu, 19 Feb 2026
 05:10:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <3c7d569e09075992921c6d627c91934665a637d1.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <3c7d569e09075992921c6d627c91934665a637d1.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:32 -0700
X-Gm-Features: AaiRm519Jk3-bfhONJFG4IC3G28aMdNOoOodTdQMbnFk41NwIEEau41EFoHF6aQ
Message-ID: <CAFLszTiNM7Oh-hYSF0Yt27PXYVN6ns8idW2QOrQtpC+vEjh6TA@mail.gmail.com>
Subject: Re: [RFC PATCH 18/20] boot: bootmeth: openwrt: support MTD and UBI
 bootdevs
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>, Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de, 
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
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

Hi Daniel,

On Mon, 16 Feb 2026 at 14:24, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Extend bootmeth_openwrt's boot() to handle all three storage backends:
>
> - Block devices: detected via bflow->blk, uses image_loader_init_blk()
>   (existing path, refactored into openwrt_boot_blk() helper)
> - UBI volumes: detected by checking the bootdev driver name
>   ("ubi_bootdev"), uses image_loader_init_ubi() with the volume name
>   from bflow->bootmeth_priv
> - MTD partitions: fallback for non-block bootflows with a priv string,
>   uses image_loader_init_mtd() with the partition name
>
> The check() function does not need changes: bootflow_iter_check_blk()
> already accepts non-network bootdevs including UCLASS_MTD parents.
>
> The rest of boot() remains identical across backends =E2=80=94 bootm_init=
(),
> optional bootconf config selection, bootm_run(), cleanup on error.
> Each backend path is guarded by IS_ENABLED(CONFIG_BOOTDEV_*) to
> avoid link errors when not configured.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/bootmeth_openwrt.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> index 82f39c17d7f..e1f47b58f61 100644
> --- a/boot/bootmeth_openwrt.c
> +++ b/boot/bootmeth_openwrt.c
> @@ -73,21 +73,38 @@ static int openwrt_read_bootflow(struct udevice *dev,=
 struct bootflow *bflow)
>         return 0;
>  }
>
> -static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
> +static int openwrt_boot_blk(struct bootflow *bflow,
> +                           struct image_loader *ldr)
>  {
>         struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
>         const char *ifname =3D blk_get_devtype(bflow->blk);
> +       char dev_part_str[32];
> +
> +       snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> +                desc->devnum, bflow->part);
> +
> +       return image_loader_init_blk(ldr, ifname, dev_part_str);
> +}
> +
> +static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
> +{
>         struct image_loader ldr =3D {};
>         struct bootm_info bmi;
> -       char dev_part_str[32];
>         char addr_img[64];
>         const char *conf;
>         int ret;
>
> -       snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> -                desc->devnum, bflow->part);
> -
> -       ret =3D image_loader_init_blk(&ldr, ifname, dev_part_str);

Something odd here, removing code added in a previous patch.

> +       if (bflow->blk) {
> +               ret =3D openwrt_boot_blk(bflow, &ldr);
> +       } else if (IS_ENABLED(CONFIG_BOOTDEV_UBI) &&
> +                  !strcmp(bflow->dev->driver->name, "ubi_bootdev")) {
> +               ret =3D image_loader_init_ubi(&ldr, bflow->bootmeth_priv)=
;
> +       } else if (IS_ENABLED(CONFIG_BOOTDEV_MTD) &&
> +                  bflow->bootmeth_priv) {
> +               ret =3D image_loader_init_mtd(&ldr, bflow->bootmeth_priv)=
;
> +       } else {
> +               return log_msg_ret("typ", -ENODEV);
> +       }

With driver model I am hoping you can just probe your device and avoid
all of this boilerplate.

>         if (ret)
>                 return log_msg_ret("ldr", ret);
>
> --
> 2.53.0

Regards,
Simon
