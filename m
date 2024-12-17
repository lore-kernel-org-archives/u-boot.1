Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E72E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2269801CE;
	Tue, 17 Dec 2024 09:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="lv3AGsjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC711801CF; Tue, 17 Dec 2024 09:59:33 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9810C801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 075A3100007;
 Tue, 17 Dec 2024 11:59:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 075A3100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734425971;
 bh=uzzy07Nm/VVybxXp3oUbAF2NLujtGaUYFYFqIiLnWkQ=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=lv3AGsjfSiZLkGAYl71SE+k3O4F/nH8sAtpLW3TWYnSN6dsn3XJhqticgrEyeveTm
 spHeB5FhOYqHmGqYCGFgS9Arqxfuhp8A1xH1jxx4GWZOebepYAoEEK1xICU5WJkT6M
 DLeZBfst24ALzMlUCsOu/ms07MYMY/TUO2BAttiTCCo+cgP9sK/phl8NauUhmV4ybT
 9vFzjbqgGy0wOcmHGtNFQ1qU+GA8X+XxECVYX2sYcXDYD23AdqUzsteaHhAezDX9Mc
 Jzv2I9Ko4sWBko3pJefhQGmGz3TjiHmp7tG0nv4OOUges9nQEfYj0phWYSUWQkdxjv
 U3f/hyblrK/rQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Dec 2024 11:59:30 +0300 (MSK)
Date: Tue, 17 Dec 2024 11:59:29 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>, <kernel@salutedevices.com>,
 <evgen89bachinin@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/5] sandbox: set retval early in board_fdt_blob_setup()
Message-ID: <fz4k34cnnoabukznehqthg4fk3tjavc54zveiepnecaz7nrmlg@xl4y44up2zrh>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-5-05aff4b0ccf7@salutedevices.com>
 <CAFLszTj7psRzUuKfq+bMKeAsZS2xbox263sk=EAvOGKH+Z781A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTj7psRzUuKfq+bMKeAsZS2xbox263sk=EAvOGKH+Z781A@mail.gmail.com>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189882 [Dec 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 47 0.3.47
 57010b355d009055a5b6c34e0385c69b21a4e07f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 patchwork.ozlabs.org:7.1.1; 127.0.0.199:7.1.2;
 smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/17 08:10:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/17 08:11:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/17 06:22:00 #26894014
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi, Simon, see below

On Fri, Dec 06, 2024 at 08:31:36AM -0700, Simon Glass wrote:
> Hi Evgeny,
> 
> On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
> <EABachinin@salutedevices.com> wrote:
> >
> > Bug:
> > nobody sets 'ret' to non-error value inside board_fdt_blob_setup()
> > in case, when gd->fdt_blob has been initialized before calling the
> > board_fdt_blob_setup() (say, due to CONFIG_OF_EMBED=y)
> >
> > Reproduced with CONFIG_OF_EMBED=y && BLOBLIST=n.
> >   ```
> >     $ ./u-boot
> >     initcall: 0000000000078e05 (relocated to 000061138d2c7e05)
> >     initcall: 0000000000117b12 (relocated to 000061138d366b12)
> >       fdtdec_setup():
> >             gd->fdt_blob = dtb_dt_embedded()
> >       fdtdec_setup():
> >             gd->fdt_blob = board_fdt_blob_setup(&ret);
> >
> >         board_fdt_blob_setup():380 ret:-2 gd->fdt_blob:0x61138d4db310
> >                 if (gd->fdt_blob)
> >                         return (void *)gd->fdt_blob;
> >
> >     initcall failed at call 0000000000117b12 (err=-2: No such file \
> >        or directory)
> >     ### ERROR ### Please RESET the board ###
> >   ```
> >
> > Patch moves code, zeroizing the 'ret', before checking the fdt_blob.
> >
> > Fixes: d8289e7dfe5 ("sandbox: fdt: Avoid overwriting an existing fdt")
> > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > ---
> >  arch/sandbox/cpu/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sandbox/cpu/cpu.c b/arch/sandbox/cpu/cpu.c
> > index d1c4dcf0764fb37ec99585a3db16fa34c3a54dac..7e93377e87e75b0fb92a8cf139b4a731a88a6a7b 100644
> > --- a/arch/sandbox/cpu/cpu.c
> > +++ b/arch/sandbox/cpu/cpu.c
> > @@ -377,10 +377,10 @@ void *board_fdt_blob_setup(int *ret)
> >         int err;
> >         int fd;
> >
> > +       *ret = 0;
> >         if (gd->fdt_blob)
> >                 return (void *)gd->fdt_blob;
> >         blob = map_sysmem(CONFIG_SYS_FDT_LOAD_ADDR, 0);
> > -       *ret = 0;
> >         if (!state->fdt_fname) {
> >                 err = setup_auto_tree(blob);
> >                 if (!err)
> >
> > --
> > 2.34.1
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But note for the future we have:
>
> https://patchwork.ozlabs.org/project/uboot/patch/20241102174944.412088-2-sjg@chromium.org/

Thanks for pointing me!

Could you advise me?
Should I abandon this patch from v2 patch-set?

--
Best Regards,
Evgeny Bachinin
