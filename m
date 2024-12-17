Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE0BE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 09:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4023E801CE;
	Tue, 17 Dec 2024 10:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="RjD19qVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05F06801CF; Tue, 17 Dec 2024 10:11:09 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D856C801A0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 10:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 52886120009;
 Tue, 17 Dec 2024 12:11:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 52886120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1734426666;
 bh=BCyXjSTUaM8/MxveU8nMlpcXdOKixQYD1lWvC+8cP/Q=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=RjD19qVg4TcffCdjv6o8RH5Isxyg8Dmk68ERUmO3kEmEMtz3/P/4fDqlUjyDJDG7O
 n0E5IIzTNylxNwwAHEn5DFmV6JDMankKmNkBvs17v31gR+MyDrg/QCTeCmg11UcN4c
 dUPOkyFRsdZqXXj/HsKoSUN2qwpyohoN7E2xrx4FEwboDcON57MTtwRqKBeat0cVqD
 /I4IKS/QVpv8GYisRq48uJZg0MyhExdA3UHszhlAoPfYnrUkxtmUksh3pMMXLbRcdI
 U0ComtaRrZiCNbUppMR7Fnv8oJy8nqlMx/E+awCTmOSbeSK9Ok0So9s8NX+6p6NHyS
 kDimKzT5O6SYw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 17 Dec 2024 12:11:06 +0300 (MSK)
Date: Tue, 17 Dec 2024 12:11:05 +0300
From: Evgeny Bachinin <eabachinin@salutedevices.com>
To: Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>, <kernel@salutedevices.com>,
 <evgen89bachinin@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/5] test: sandbox: fix link error with do_ut_bootm if
 BLOBLIST=n
Message-ID: <gzsr5konsq4iyxakbmcengqglrgoawu7kxf6mvtfmidpvz5xan@akuwzh3fe4pj>
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-4-05aff4b0ccf7@salutedevices.com>
 <CAFLszTisVG9Jn-Zi9F6VUERmecn=g=x6EwaNQORS+yiaCRBJRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFLszTisVG9Jn-Zi9F6VUERmecn=g=x6EwaNQORS+yiaCRBJRQ@mail.gmail.com>
User-Agent: NeoMutt/20231006
X-Originating-IP: [172.28.224.238]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
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
 57010b355d009055a5b6c34e0385c69b21a4e07f, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
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


Hi, Simon. See below, please

On Fri, Dec 06, 2024 at 08:31:22AM -0700, Simon Glass wrote:
> Hi Evgeny,
>
> On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
> <EABachinin@salutedevices.com> wrote:
> >
> > Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> > error:
> > ```
> > ld: /tmp/ccwtRVty.ltrans28.ltrans.o:(.data.rel+0x4e8): undefined \
> >                                             reference to `do_ut_bootm'
>
> Are you sure? I don't see that one. The bootm test should not relate
> to bloblist.


I've double checked - reproduced on v2024.10. There we had in
test/Makefile:
  ```
  ifneq ($(CONFIG_$(SPL_)BLOBLIST),)
  obj-$(CONFIG_$(SPL_)CMDLINE) += bootm.o
  endif
  ```
So do_ut_bootm()  was not built if BLOBLIST=n

We do not see "undefined reference to `do_ut_bootm'" on v2025.01-rc3
due to this patch:
  7f8b8c5abc2 ("bootm: test: Move test into boot")
  It made bootm.o dependant on CONFIG_SANDBOX and independent from
  BLOBLIST.

And because aforementioned patch fixes the issue, I'm going to get rid
of this current patch.


> This is what I see:
>
> buildman  -a OF_EMBED -a ~BLOBLIST --bo sandbox
> Building current source for 1 boards (1 thread, 32 jobs per thread)
>    sandbox:  +   sandbox
> +===================== WARNING ======================
> +CONFIG_OF_EMBED is enabled. This option should only
> +be used for debugging purposes. Please use
> +CONFIG_OF_SEPARATE for boards in mainline.
> +See doc/develop/devicetree/control.rst for more info.
> +====================================================
> +
> +Some CONFIG adjustments did not take effect. This may be because
> +the request CONFIGs do not exist or conflict with others.
> +Failed adjustments:
> +~BLOBLIST             CONFIG_BLOBLIST=y

Just a side note:
I am not familiar with buildman yet, but it seems, it can not set up
CONFIG_BLOBLIST=n because BLOBLIST is selected by 'select'.

JFYI, I'm going to extend the patch series by new patch to make BLOBLIST
selectable from menuconfig for sandbox via 'imply'.


>     0    0    1 /1              sandbox
> Completed: 1 total built, 1 newly), duration 0:00:11, rate 0.09
>
>
> > ```
> >
> > Fixes: fe158657a5b ("test: inconsistent bootm tests")
> > Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> > ---
> >  test/cmd_ut.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> > index 842c2c3e7f65eb9fe017fa1949eb2390be171487..a14dbf4ca5e571a872585ff11bfe7adae3f4edf3 100644
> > --- a/test/cmd_ut.c
> > +++ b/test/cmd_ut.c
> > @@ -107,9 +107,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
> >  #if CONFIG_IS_ENABLED(BLOBLIST)
> >         U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
> >                          "", ""),
> > -#endif
> >         U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
> >  #endif
> > +#endif
> >  #ifdef CONFIG_CMD_ADDRMAP
> >         U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
> >  #endif
> >
> > --
> > 2.34.1
> >
>
> Regards,
> SImon
>

--
Best Regards,
Evgeny Bachinin
