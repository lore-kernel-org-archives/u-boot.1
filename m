Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F81E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D8083EA6;
	Thu, 19 Feb 2026 14:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JFWtzOgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387C583EA6; Thu, 19 Feb 2026 14:11:58 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF7F83E96
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so1674370a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506715; cv=none;
 d=google.com; s=arc-20240605;
 b=bheYHsdKMhHPOSFHjA9j5Jc2x4sWbgv5Ye0ho4RtaMBxJg6xr+gnyyyMKZAGbXC+MC
 ylia9OsBgWgVuYx2U9mBHJwjfulGm2nl5Vc/pOX4pxeJuEmU1YoNp5zjEjcu1XkEvKAn
 +kSljMHTnPl32HM3O7+GmBC53pyNqQSe5OFoSN7jxS5ov+EF4KfJVziRY/MdmFzDKsm5
 VuN+P9MlQVeDgkGlDlwAh1MgHpeKXVdTHqyMMnmrN6sb77VZFs1/nETFzKG21U3cHwAN
 14t1kFLG9iI3cqyM/iAFkxH/bnG8NkTExBtyXtZpjvU76TcfHBu1iTPs1Lxm0SEy3spM
 LSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AeJbgIFc3Hdtr4rW/N2JI/bvIu1QqXLv3IS9ruWpFp4=;
 fh=tG3qah6MjM85oKjPvZkRaK3CbCFcaSwMXHxXK0+vL3g=;
 b=OqqC5eCFbBGGrdE4kt5G6es8KFZBr0djzjck496qfRtQvADF2IlmiQbRXSkAaZJ8oI
 /gN3BTGR/ByPzgl+7zwswRITsqb1DH/3xjdCvxxn0maeQzWSe5lxptAECuMrTxVUFqcE
 r9L6gelYE3vrU1PHrS8t2SqgB3AEEL0kb1yl/wT15rqTJlvRMv5F+YrAsOjfpnSYUadi
 hUy549UU3b1rP7Iz5uvTejb6GaeWJ/rhaDZzH1J+hzjKLsNXpz2rsozFxl+3oG+5B3at
 fHNvMkm2HB7k9ZyqTulU9ZE3vjVASkrG02wl6GDsnTA0OygTXLl1g9fpvhx8LKfyg5zK
 Co/Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506715; x=1772111515; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeJbgIFc3Hdtr4rW/N2JI/bvIu1QqXLv3IS9ruWpFp4=;
 b=JFWtzOgUnfYyrigDh+GWvtlkf6Uo/07hWmfzYyv9gBwul4OYBUQMQZxt30Rfb/BFjZ
 VcUSsPq+xJFaNsHAfZZ4x56MidB356tr1CE2XjWamZ4msYRUKrTF81Y5qokAk+qqbkkP
 ZhK9uRSxz6IiTqxaO8rnAWvOUCaBk0SKjBCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506715; x=1772111515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeJbgIFc3Hdtr4rW/N2JI/bvIu1QqXLv3IS9ruWpFp4=;
 b=bEgRbVAgz+0g92ZouQpAZXB3QI3kaJYsoqr/CwGIBm00tALCqDGCdgL8LmZfrbihb8
 m/ToTXQmuvBX4gG3+cc+H0o54CYr1GKCY2Pg+hNJ0nTJwGZZ6WiB0TG/LBHZPBrgXD2k
 ySSdjE8CqjV1q683GVAE7g7c4ihELSN6j2vhAAUk15iXEADJuMFhPXa1bB1oKHeYoanH
 PJffbJWoHbfTnvca6ptNSLAolnKjwEDh8YnQaZ3d2zfZQetAZ98ydcvzLJGQ7XaF4kaB
 gzghnNwYeW1AoFgzJK8a7KyRF9neWWsymlawbfrn6HTIeTf93cHCi2kGm8miHFp6+2qQ
 onUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3zdT5gkwYQqm8zslXZ5eq3ZzWVG4j3oftaZwyVDe3GMLBRJaQ+w/O95Ojg5E0aY7gKMM1zLc=@lists.denx.de
X-Gm-Message-State: AOJu0YwdaHrP8ql3wIz2nVnGhV4m4cDipdJCbc/5atjk3G35r7bKd1m4
 pE7d4VvAYlCrF5jxJRPnwRLiDsfyumC9ywfTJqARYk6YjYEPR9K+uULD8Ke6pbnXOllfHH5WU/W
 +efQifiz8pZIOguQ9ZhcxrqDQXnWkuP/xtwdtw+8p
X-Gm-Gg: AZuq6aKYQG2ryy6jh4ijdhRXLpd2FeRT0n3xpmHXXvrCIn3q0QXSWfwJ26q2DURh/rE
 5sZuLdc9lRMdEVZtZ6YXpvZIsaG0iulyahhh8q6K2Jw6L43vhOcb2X7Lh0Z5vHZm7rvz4+bVe3+
 nWhnMgq7EsFSeSbBvy3vYqYSXp0zZRGLxbxFWCl8mHQxVPC2WA3xFo9u8jw57gZetrkUdRz+N/R
 XVa45geAsVwNHQQgzuWSMaEU3CFismIJYWj5omO3uJk/N81uXDWJgVfQekM5PUal1dlrWGz8hTe
 8IGVeg==
X-Received: by 2002:a05:6402:3581:b0:65c:6387:4733 with SMTP id
 4fb4d7f45d1cf-65c63874e39mr4713581a12.25.1771506714041; Thu, 19 Feb 2026
 05:11:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <db31f5b213b57b802c5db7309941b5fab94dec2c.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <db31f5b213b57b802c5db7309941b5fab94dec2c.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:11:35 -0700
X-Gm-Features: AaiRm51INiCfoKQJ9hHSrx0ACrX91W1gFFyFU6SDsKATlIoTNYuY0MfxfPS74-8
Message-ID: <CAFLszTh4dudF6+gN7SDDTs9iJhHLNkqLR8+YG586x8QSPR4AxA@mail.gmail.com>
Subject: Re: [RFC PATCH 20/20] boot: bootmeth: openwrt: add slot configuration
 from environment
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
> Add configurable multi-slot boot with slot names and boot order
> defined via environment variables. This enables production/recovery
> dual-boot (or any number of named slots).
>
> New environment variables:
>
> - openwrt_slot_<name>=3D<location> -- defines a named slot. <name> is
>   an arbitrary label (e.g. "production", "recovery"). <location> is
>   a GPT partition label, MTD partition name, or UBI volume name.
>
> - openwrt_boot_order=3D<name1> <name2> ... -- space-separated list of
>   slot names that are eligible for booting. Only partitions/volumes
>   whose name matches a configured slot's location are probed.
>
> Without openwrt_boot_order, all partitions/volumes are probed
> (backward-compatible with the Milestone 1/2 behavior). When set,
> only partitions matching a defined slot pass the filter.
>
> The matched slot name is stored in bflow->os_name for later use by
> boot-loop avoidance (Milestone 4) and boot menu display.
>
> The MTD and UBI bootdevs now delegate to bootmeth_read_bootflow()
> instead of setting BOOTFLOWST_READY directly, so that slot filtering
> is applied uniformly across all storage backends.
>
> Example configuration:
>
>   openwrt_slot_production=3Dfirmware
>   openwrt_slot_recovery=3Drecovery
>   openwrt_boot_order=3Dproduction recovery
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/bootmeth_openwrt.c | 130 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 104 insertions(+), 26 deletions(-)
>
> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> index d448697fe08..6e90a203ed6 100644
> --- a/boot/bootmeth_openwrt.c
> +++ b/boot/bootmeth_openwrt.c
> @@ -24,6 +24,63 @@
>  #include <linux/libfdt.h>
>  #include <linux/sizes.h>
>
> +/**
> + * openwrt_match_slot() - check if a partition name matches a configured=
 slot
> + * @part_name: GPT label, MTD partition name, or UBI volume name
> + * @slot_namep: set to strdup'd slot name on match (caller must free)
> + *
> + * When ``openwrt_boot_order`` is set in the environment, only partition=
s
> + * whose name matches one of the ``openwrt_slot_<name>`` locations are
> + * accepted. Without ``openwrt_boot_order``, all partitions pass.
> + *
> + * Return: 0 if accepted, -ENOENT if filtered out
> + */
> +static int openwrt_match_slot(const char *part_name, char **slot_namep)
> +{
> +       const char *order, *p;
> +
> +       *slot_namep =3D NULL;
> +
> +       order =3D env_get("openwrt_boot_order");
> +       if (!order)
> +               return 0;
> +
> +       if (!part_name)
> +               return -ENOENT;
> +
> +       p =3D order;
> +       while (*p) {
> +               char name[64], var[80];
> +               const char *location, *end;
> +               int len;
> +
> +               while (*p =3D=3D ' ')
> +                       p++;
> +               if (!*p)
> +                       break;
> +
> +               end =3D p;
> +               while (*end && *end !=3D ' ')
> +                       end++;
> +
> +               len =3D end - p;
> +               if (len >=3D sizeof(name))
> +                       len =3D sizeof(name) - 1;
> +               memcpy(name, p, len);
> +               name[len] =3D '\0';
> +               p =3D end;
> +
> +               snprintf(var, sizeof(var), "openwrt_slot_%s", name);
> +               location =3D env_get(var);
> +               if (location && !strcmp(part_name, location)) {
> +                       *slot_namep =3D strdup(name);
> +                       return 0;
> +               }
> +       }
> +
> +       return -ENOENT;
> +}
> +
>  static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter=
)
>  {
>         if (bootflow_iter_check_blk(iter))
> @@ -34,40 +91,61 @@ static int openwrt_check(struct udevice *dev, struct =
bootflow_iter *iter)
>
>  static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *b=
flow)
>  {
> -       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
>         const char *part_name =3D NULL;
> -       struct disk_partition info;
> -       void *buf;
> +       char *slot_name =3D NULL;
>         int ret;
>
> -       /* Get partition geometry */
> -       ret =3D part_get_info(desc, bflow->part, &info);
> -       if (ret)
> -               return log_msg_ret("part", ret);
> -
> -       part_name =3D (const char *)info.name;
> -
> -       /* Read first block to probe for an FDT/FIT header */
> -       buf =3D memalign(SZ_1K, desc->blksz);
> -       if (!buf)
> -               return log_msg_ret("mem", -ENOMEM);
> +       if (bflow->blk) {
> +               struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk)=
;
> +               struct disk_partition info;
> +               void *buf;
> +
> +               ret =3D part_get_info(desc, bflow->part, &info);
> +               if (ret)
> +                       return log_msg_ret("part", ret);
> +
> +               part_name =3D (const char *)info.name;
> +
> +               /* Check slot filter before expensive I/O */
> +               ret =3D openwrt_match_slot(part_name, &slot_name);
> +               if (ret)
> +                       return -ENOENT;
> +
> +               /* Read first block to probe for an FDT/FIT header */
> +               buf =3D memalign(SZ_1K, desc->blksz);
> +               if (!buf) {
> +                       free(slot_name);
> +                       return log_msg_ret("mem", -ENOMEM);
> +               }
> +
> +               ret =3D blk_read(bflow->blk, info.start, 1, buf);
> +               if (ret !=3D 1) {
> +                       free(buf);
> +                       free(slot_name);
> +                       return log_msg_ret("rd", -EIO);
> +               }
> +
> +               if (fdt_check_header(buf)) {
> +                       free(buf);
> +                       free(slot_name);
> +                       return -ENOENT;
> +               }

The code above would benefit from being in its own function.

>
> -       ret =3D blk_read(bflow->blk, info.start, 1, buf);
> -       if (ret !=3D 1) {
>                 free(buf);
> -               return log_msg_ret("rd", -EIO);
> -       }
>
> -       /* Must start with a valid FDT header */
> -       if (fdt_check_header(buf)) {
> -               free(buf);
> -               return -ENOENT;
> -       }
> +               /* Show the GPT partition label as Filename */
> +               bflow->fname =3D strdup(part_name);
> +       } else {
> +               /* MTD or UBI =E2=80=94 partition/volume name in bootmeth=
_priv */
> +               part_name =3D bflow->bootmeth_priv;
>
> -       free(buf);
> +               ret =3D openwrt_match_slot(part_name, &slot_name);
> +               if (ret)
> +                       return -ENOENT;
> +       }
>
> -       /* Show the GPT partition label as Filename */
> -       bflow->fname =3D strdup(part_name);
> +       if (slot_name)
> +               bflow->os_name =3D slot_name;
>
>         bflow->state =3D BOOTFLOWST_READY;
>
> --
> 2.53.0

Regards,
SIMon
