Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D89E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9901883D77;
	Thu, 19 Feb 2026 14:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MsyhglHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0D983936; Thu, 19 Feb 2026 14:10:38 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58A983D8A
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824b32875e7so493232b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:10:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506634; cv=none;
 d=google.com; s=arc-20240605;
 b=DVSgax+CRoRUVWEOLinAc0++bj/PrqRe0ERxZIkzolgraazXwzVrsnqNHcn4tGca5i
 tWrqSCeqli2caSr/qWgtARdFQckjNeHA5/XjyePFxVsLq1aqMhGMAh+kxEetHJA9jqlC
 LVP6cnAizLZyzh90AlIKhwgJ24QNg9E6XoDOfg9WzL0jqbNzexYM8TVBZnlpnRL/VOc5
 gI/0vfxesVR7S0C/aTqHd9MLGfFpbv+JWK6xxC8PteySWP/T+iN2GTaxWXFD9OMTUax5
 NwAI3nggWZVYZgcj1IgOqAx49OnZjPX5LDARxVSnVQYhaCvIz/iXDx2LsfLwuzH+L9/9
 makQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p1nJfdbCLgmPhPoBuvj9+oWIvS0TAbqDSXAV7IFsyT0=;
 fh=o+M34zlMdgNQw+zxYcA7BvEmeOHysUPwohRZYDMNfnM=;
 b=S6c+Ip6QpYYQDdEvE3JgVyKRG4UttUB2k3tivumQAdY1zt3YSJZjga8ln6kuaFP9vY
 Fs286tdwebRXAjAh/UHCi/r8QVZw2SYVXGwY0kjOM5NgeBEoJ6s4kTuo0F+CYjYKrzzR
 sOAYakT2Xv/21b+Lnf2H5yB1j4QkpfrGbctb5/eOljtI3+RmXdkuLXHZNqyF7UqLsPMT
 trw+UEWFEQA81Z5I6Qnp5h+lxW1KKD9gcM4pmHBzVEjjSygJvbnsUlECtKJswGUJC8tc
 YuQ3/6dnQTbrRoxTOG59ih8oGzkpBUqfi9IA8nAi5UYU1VtmXSZMXn9vvuD/ym5FVuDT
 UdLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506634; x=1772111434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1nJfdbCLgmPhPoBuvj9+oWIvS0TAbqDSXAV7IFsyT0=;
 b=MsyhglHHaG06DSr+DQxuERIdti6xNpGPzysuFnBMruniprbV1uFCTPFCnun+hRn2BI
 uLKH2CCQHE1MGeGae3DzJVTFWosHet6bhIhfTeHda3oQZ7GujKfAeO9GSy1soRbudVXP
 zY8Q38PoozMM0tU7pE4SNAqmipMlD5PTl8QvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506634; x=1772111434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p1nJfdbCLgmPhPoBuvj9+oWIvS0TAbqDSXAV7IFsyT0=;
 b=nvCTvZlrE8pz0ndlBYG8TVbC26ohmxDDGV3I7emQhwQjK1Mj1ZhPXdBKqmrHyy+YWb
 ra9KRrvnq/paP7K/UxusCKxNC2ADO5s6TKqjUA+QjB+Q0WEWpdAORY7cFJL+HBJsByIk
 wHPYSQg5jYHrm50I3KsnqAyO59hD0+zU0xBFUMwGDaY2nXpMX7OXFf2+Jfj22jiml0XD
 8W6MEn2W+P2zvUzrgYMg6fHpVauGLyUnbBG2f7uyKmxedlXAFTgpsz2JDdcHTQcoCG3w
 /fy1vRq7E19rv5Q6I8mb71VDp50JbQDzLUEJGap2GkoWeqrB2JYv63iCpQKYkH0YvLaM
 wLdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj4aBdFRPznNL+OkkfRJLHqHlvDruueU0QBOjd9vBy5dQ1cEvfE6bUCyhWreWHelulMh4oApw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxy6K1O2QkEj9Nb2eoUiPHAHzWsSLs7JhA8iKHhIQkpxSjfhs7+
 u+0l49ucLICCGWKy1yKfakQFu4jT3hfL1KESK4vXT7VS2QcGI6WFASueWScsKUscBPu35xEj6qx
 RAVyfUwl590bdtuBBH0DsvgMbSWrGfx6nkclNwBe+
X-Gm-Gg: AZuq6aIatidxjfQhNsC0As2mGDt3x1i8wlEsG7vBq7CNk586ISph5naGyT/FzwGqYoU
 YsD0WgDq1sNyYbxbI8FV5c6bhpG1tQAf7oyfcysZO+EuK3e+wA8B+IT+/hYpbFSZH2UKBkrSJ99
 JMXVgs5OgOCYglMF57MnWtKFmOf7OWTBNRm07WgIf6d+3z/GrtjHiZNWZquiOI5b2gZQz4WWsmD
 G4nQBN8nNs7ju7KkRCjvStX4+JtofoXtg2PHs1T1iU4fDKd77MXg9L/WZ+G333CLuMUBgNXTjMv
 jWb78Q==
X-Received: by 2002:a17:90b:274e:b0:356:24f0:aef5 with SMTP id
 98e67ed59e1d1-35889130821mr3969140a91.22.1771506634255; Thu, 19 Feb 2026
 05:10:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <1bca052ba4cd629981ee4c7522263379a0e40ac5.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <1bca052ba4cd629981ee4c7522263379a0e40ac5.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:29 -0700
X-Gm-Features: AaiRm52YDe20j3n0Wc0gHW2oGM2GFeIiAhJvJgd5YnWYbRSiE6MCe7fGoGy-xbQ
Message-ID: <CAFLszThxsO3PcAZ2mrJPiX0-_unvGK-6JLRqMRHawM+6f93n8w@mail.gmail.com>
Subject: Re: [RFC PATCH 14/20] boot: bootmeth: openwrt: implement
 read_bootflow for block devices
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

On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wrote:
>
> Implement openwrt_read_bootflow() to discover OpenWrt FIT images on
> raw block device partitions.
>
> For each partition bootstd offers, read the first block and check for
> a valid FDT header via fdt_check_header(). If the header is valid the
> partition likely contains a FIT image and the bootflow is marked
> BOOTFLOWST_READY.
>
> Full FIT validation, configuration resolution, and sub-image loading
> are all deferred to boot() which uses image_loader =E2=80=94 keeping the =
scan
> path fast and avoiding large reads for embedded-data FIT images that
> can be many megabytes.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/bootmeth_openwrt.c | 43 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>

See below

> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> index 02bf543031b..08c3f98957a 100644
> --- a/boot/bootmeth_openwrt.c
> +++ b/boot/bootmeth_openwrt.c
> @@ -16,6 +16,10 @@
>  #include <image-loader.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> +#include <memalign.h>
> +#include <part.h>
> +#include <linux/libfdt.h>
> +#include <linux/sizes.h>
>
>  static int openwrt_check(struct udevice *dev, struct bootflow_iter *iter=
)
>  {
> @@ -27,7 +31,44 @@ static int openwrt_check(struct udevice *dev, struct b=
ootflow_iter *iter)
>
>  static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *b=
flow)
>  {
> -       return log_msg_ret("nyi", -ENOENT);
> +       struct blk_desc *desc =3D dev_get_uclass_plat(bflow->blk);
> +       const char *part_name =3D NULL;
> +       struct disk_partition info;
> +       void *buf;
> +       int ret;
> +
> +       /* Get partition geometry */
> +       ret =3D part_get_info(desc, bflow->part, &info);
> +       if (ret)
> +               return log_msg_ret("part", ret);
> +
> +       part_name =3D (const char *)info.name;
> +
> +       /* Read first block to probe for an FDT/FIT header */
> +       buf =3D memalign(SZ_1K, desc->blksz);

Could you use ALLOC_CACHE_ALIGN_BUFFER() ?

> +       if (!buf)
> +               return log_msg_ret("mem", -ENOMEM);
> +
> +       ret =3D blk_read(bflow->blk, info.start, 1, buf);
> +       if (ret !=3D 1) {
> +               free(buf);
> +               return log_msg_ret("rd", -EIO);
> +       }
> +
> +       /* Must start with a valid FDT header */
> +       if (fdt_check_header(buf)) {
> +               free(buf);
> +               return -ENOENT;
> +       }
> +
> +       free(buf);
> +
> +       /* Show the GPT partition label as Filename */
> +       bflow->fname =3D strdup(part_name);
> +
> +       bflow->state =3D BOOTFLOWST_READY;

At this point there is no indication that we actually have anything,
so I think this should move to a later patch.

> +
> +       return 0;
>  }
>
>  static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
> --
> 2.53.0

Regards,
Simon
