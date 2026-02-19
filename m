Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C40E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204BF83D77;
	Thu, 19 Feb 2026 14:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aMSqqRFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BF883D77; Thu, 19 Feb 2026 14:11:14 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A263E83E48
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-65a43a512b0so959730a12.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:11:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506663; cv=none;
 d=google.com; s=arc-20240605;
 b=afSbaUguXIz9DDdKXJVcPQyGxNFZre1vfZ2BuxQVo1HXdPKvUOwvU5a29gnXztpPxO
 UgeZndpobLorf52I9rb+rNPpJYobOf3ZuqeD7F3dkcyXCFBDB7SBSj08b0HfyMcbZnMO
 5cKYkblJ8eup2goIraqM1RrP+RpdKwLk5MCfLHNPrdg65an2oDviKAYe2bHdk0qFDkDc
 +j4FW3NSYuijJtlY71wFL/Dat+dTmk6SlVLiLuNxcG/IGaeofiNj0dn/DIYhedCf+iau
 eN9XJLc/+N0GkxMOcVl6xF7yhru5OFgf6TFJFW7qFLx1UpyOeaBNeJ4QU+17Uarrvved
 tFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=27Ak6TsMgrj8CwRjaLaEB3V21YwCMvKps6GG3g+OmFg=;
 fh=8HXeQCbb9h3AtNPUfI3FO3bizYOX7+wOEfFEklPP8Y0=;
 b=SDcgnVCbVlhKCa4XWsq6Tf4T8sOWTvSEr7tbggtnhGWrt1oZW5grabWYwl0sgkpej6
 S/cbekCsq5usxmh9w+0iStum2IAHUXsKEBr5Lc17Gx/HVmdGwPFgqjo8p9i4/I/vTEhS
 dBhvaFsZ++YVxYx1xDEtjJW+AooLvT7FvSp9CEqxMc1IjlNTPkIMAyhg0/arBv5SgyAg
 kfHE8RGPG62w9o3nu9l2wa3/56+zD1kZBrvE52RdqzrVCgfk1fdTmx/98P2HAI5UGh5u
 8iXrErj88A+/46Ot9NQdyKJVKXymOg8JPqASRwoOBt6W77i+dw+SsEJ3BOaZbPFx9wcG
 c12A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771506663; x=1772111463; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=27Ak6TsMgrj8CwRjaLaEB3V21YwCMvKps6GG3g+OmFg=;
 b=aMSqqRFSIMBWQwMa0etpedVyziMbEtp09t/B0/EcMirM5Yj9TlY1KEf2XT3VyVtX00
 FxrhXFw85DrhMixEr01EI6eWxqtJ3n7V11bBvHzXH6GC8oT34Dn/d4/5kMN9nYrXYTMA
 S5T6+Gv4rMD4PMtSPAvVLK9qJrSWJk1q2IZHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506663; x=1772111463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27Ak6TsMgrj8CwRjaLaEB3V21YwCMvKps6GG3g+OmFg=;
 b=LfgfovtFhR+4fUtjIq8S82UqGn+GKlpl2bAo4xnvwgcIB7+kOyuXSnEf+QUlfZ0/uX
 4T2eiRVD496gju7aXIaBNW6d31vw9JHmSi2UuoQVMeVgn/CxQZ9J5fQ5xOL0z6EoeB+N
 BWURkiI55xdIsdemnSOwwBKsJ4q99Pke7p3QSQzuNL/SGKw1vbip/F+OATpJ8QcHv39m
 1V8ez1vs3wQ3hla3qqYt4qT7N/clLnPhz7iXIHrI5Qpzlmvt0cz2hWQzHMUr94BA6xFc
 V4HpU9V9BNhXl7MFogy3yWuRwvYw999aIxRuWxQ7q7H2uTa+d0YJ48RIg62Hf5CIuDlN
 3mpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Ghxoqn8tr9AzVer8IiWmyoB5kV92scPaozipjkEI5xoPGv0hVqlPRE2XbOWzp/YOt03sjtY=@lists.denx.de
X-Gm-Message-State: AOJu0YzSpy+Yn8m1/R8x9k+B0nXGjaAllmnnvHxBSxKyytnDjQeSEetw
 J1Sc1YtIgRwUpi2LmRwp7nClqXL4lRFQQ6UK/UiJpWErYKhwAVFH9fqhOuOKM7xdiqGKzXUo+n/
 VM2TTsIWYF2rZK9gUX26LMgVbdDfVCjlIUL4SLBf8
X-Gm-Gg: AZuq6aK0jzbH+lCYniojHF854CT//w80BufnMyrc/ZDg3HAt4RORpW76CDTb/dCnVRz
 SqRV0s/G/+490uSt/KidoOUKHXJkE9BgwSPvIYVbiYyWA+mGwg+Ec/vwYW2GL7o85EFqzYLdmKi
 Iz9LzNdihUtHIrpDJUO7EtJB4QMEJXnMXEmyj1WBUgQ7fHEjiKtghx4NtGM2t0gnEKPY8mardpH
 ZFph89mc6UzObGtje5PvC+DwV0kwDIAAwEB8aQ1FU1f6gYe+fMoKJyQQGdrKZP3UT9Ayo+0vDUk
 5+QqdA==
X-Received: by 2002:a05:6402:2794:b0:65b:f342:d1a2 with SMTP id
 4fb4d7f45d1cf-65c76999439mr3075217a12.6.1771506662651; Thu, 19 Feb 2026
 05:11:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1771275704.git.daniel@makrotopia.org>
 <92b77e44c1fb34f0433fb75f8404f357ed28b03e.1771275704.git.daniel@makrotopia.org>
In-Reply-To: <92b77e44c1fb34f0433fb75f8404f357ed28b03e.1771275704.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Feb 2026 06:09:29 -0700
X-Gm-Features: AaiRm53Kr9-DAwxyh0aKOdjh54QrN42rYHaKwfs3WHwKO20jz1JxxhYyWWTBZ6c
Message-ID: <CAFLszTgXPPo0u7zUsqDc7g6FsZycwuo9nLxEG22+XvmSrF4c8A@mail.gmail.com>
Subject: Re: [RFC PATCH 15/20] boot: bootmeth: openwrt: implement boot via
 bootm storage path
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
> Implement openwrt_boot() to boot a discovered OpenWrt FIT image:
>
> 1. Get the block interface name via blk_get_devtype() and construct
>    the dev_part_str (e.g. "0:3") from the block descriptor and
>    bootflow partition number
> 2. Initialise an image_loader for block devices via
>    image_loader_init_blk(), with alloc_ptr set to image_load_addr
> 3. Optionally read the 'bootconf' env variable and pass it as
>    '#config' in bmi.addr_img for FIT configuration selection
> 4. Call bootm_run() which runs the full bootm state machine:
>    START -> FINDOS -> FINDOTHER -> LOADOS -> OS_PREP -> OS_GO
>
> The image_loader handles on-demand reading of the FIT metadata and
> sub-images (kernel, FDT) directly from the raw partition. The
> existing cleanup call in bootm_run_states() releases the loader just
> before OS_GO. If bootm_run() returns (boot failure), cleanup is
> called explicitly.
>
> This completes the core block-device boot path for bootmeth_openwrt.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  boot/bootmeth_openwrt.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootmeth_openwrt.c b/boot/bootmeth_openwrt.c
> index 08c3f98957a..82f39c17d7f 100644
> --- a/boot/bootmeth_openwrt.c
> +++ b/boot/bootmeth_openwrt.c
> @@ -13,6 +13,8 @@
>  #include <bootm.h>
>  #include <bootmeth.h>
>  #include <dm.h>
> +#include <env.h>
> +#include <image.h>
>  #include <image-loader.h>
>  #include <malloc.h>
>  #include <mapmem.h>
> @@ -73,7 +75,40 @@ static int openwrt_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>
>  static int openwrt_boot(struct udevice *dev, struct bootflow *bflow)
>  {
> -       return log_msg_ret("nyi", -ENOSYS);
> +       struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
> +       const char *ifname = blk_get_devtype(bflow->blk);
> +       struct image_loader ldr = {};
> +       struct bootm_info bmi;
> +       char dev_part_str[32];
> +       char addr_img[64];
> +       const char *conf;
> +       int ret;
> +
> +       snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> +                desc->devnum, bflow->part);
> +
> +       ret = image_loader_init_blk(&ldr, ifname, dev_part_str);
> +       if (ret)
> +               return log_msg_ret("ldr", ret);
> +
> +       ldr.alloc_ptr = image_load_addr;
> +
> +       bootm_init(&bmi);
> +       bmi.loader = &ldr;
> +
> +       /* FIT config selection via #conf suffix */
> +       conf = env_get("bootconf");
> +       if (conf) {
> +               snprintf(addr_img, sizeof(addr_img), "#%s", conf);
> +               bmi.addr_img = addr_img;
> +       }
> +
> +       ret = bootm_run(&bmi);
> +
> +       /* Clean up if bootm_run() returned (i.e. boot failed) */
> +       image_loader_cleanup(&ldr);
> +
> +       return log_msg_ret("run", ret);
>  }
>
>  static int openwrt_bootmeth_bind(struct udevice *dev)
> --
> 2.53.0

This looks OK so far as it goes, but will need rework for the driver change.

Regards,
Simon
