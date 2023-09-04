Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB3AC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27DA86940;
	Mon,  4 Sep 2023 17:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S/xU9B9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E877C8694A; Mon,  4 Sep 2023 17:35:37 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E1E8693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a5dff9d2d9so238546966b.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693841734; x=1694446534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=22HRViHGPu6npupJtkWWyAkEEdVlIgBZ60EfOi8fJO0=;
 b=S/xU9B9IchRoNS6qTY25ZTni32rJLTBYSgJEHYb1cwaNU2hw59CTHP+LsACZ5Im40U
 KH1pofcDg6aUoPD34NS0YM/Zpy+q8730MpU+/reZDx3IGHnDA0m2kgNIonV5WcSjUSua
 W56quNoP/MNDP5VG/dEp0bRJ9XXzGS0y6agY+a6i096ApqCg/wcTJCfK0mTmfoBT0beV
 VpdJFCfw3rvKJj4KkI5AeOGm5je2ntRQ1isAWbkVlMsW+aMp8nlP4wWfFDQSjs4fq0Gr
 BlShCOayR9KirgqEKHla2CI90jdhbfZCHl1jidlgGo0Z5ArdRjqmReiaJ6j4ud9FTtbX
 R9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693841734; x=1694446534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22HRViHGPu6npupJtkWWyAkEEdVlIgBZ60EfOi8fJO0=;
 b=GIOknxip71WMuWaaC0oD7DU0OmrrRNHcsh4rhXHjyXmmdAEG7u/483oxKGoZMdzUDx
 NS74at2pEEAEh96uUWylVqGKnqohMFo4dDbtLAeEGFzrsIacDueuY0YxrOGMNVbXwcuN
 NFHEkVNqkhGorkAiOsC+NN+GMSDbTYmKE73CREKSh3Ak3BG7Ud6DoBzYJkPtyHumHB9F
 TYag8vXGuEJ40PLblYJdSOTpQYI6QiB+I5r2jtOgnzV4jal097RAJHXG0XTPH1Qdexcq
 nbYfV7OiGdZr0TVkY/LyPThQKoAVeXDloTEXBA+3iIveMgC2DsjF3eZhTDuh4FvrbUfc
 e3dw==
X-Gm-Message-State: AOJu0Yx/EEzz9lYbqvMkDcIk5y+PQ3knAJijunb5Or25YODVm8PGMCSf
 RHb3GHPmoJ1ugJasTBD+kginn7hYaTobTIYoNh6J8g==
X-Google-Smtp-Source: AGHT+IGnYCG/3XewLwLJBia2yzaDclNuhWuZtmNDzv6+h7AmJNXaRntWv3qQ4UkqVlYyXiTUFEmMfzoEeAtv9s44Xr4=
X-Received: by 2002:a17:906:20dd:b0:9a1:6aea:50d6 with SMTP id
 c29-20020a17090620dd00b009a16aea50d6mr7505021ejc.65.1693841734646; Mon, 04
 Sep 2023 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
 <20230822093614.4717-5-maxim.uvarov@linaro.org>
 <CAPnjgZ0TA_ZBDntxdVDEscdECz-=oh9cRHFnT=hCm8V_0=V2LA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0TA_ZBDntxdVDEscdECz-=oh9cRHFnT=hCm8V_0=V2LA@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 4 Sep 2023 21:27:01 +0600
Message-ID: <CAD8XO3amn80tvyEKT471V2SSmFThVyEUN0js7uOUmkQAnCJW+w@mail.gmail.com>
Subject: Re: [PATCHv7 04/15] net/lwip: implement dhcp cmd
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 23 Aug 2023 at 00:58, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Tue, 22 Aug 2023 at 03:39, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> > U-Boot recently got support for an alternative network stack using LWIP.
> > Replace dhcp command with the LWIP variant while keeping the output and
> > error messages identical.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  include/net/lwip.h             | 12 +++++++
> >  net/lwip/Makefile              |  1 +
> >  net/lwip/apps/dhcp/lwip-dhcp.c | 62 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 75 insertions(+)
> >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> >
> > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > index cda896d062..240ebba354 100644
> > --- a/include/net/lwip.h
> > +++ b/include/net/lwip.h
> > @@ -17,3 +17,15 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, int
> argc,
> >   *         Other value < 0, if error
> >   */
> >  int ulwip_dns(char *name, char *varname);
> > +
> > +/**
> > + * ulwip_dhcp() -  create the DHCP request to obtain IP address.
> > + *
> > + * This function creates the DHCP request to obtain IP address. If DHCP
> server
> > + * returns file name, this file will be downloaded with tftp.  After
> this
> > + * function you need to invoke the polling loop to process network
> communication.
> > + *
> > + * Returns: 0 if success
> > + *         Other value < 0, if error
>
> So this is an errno value from errno.h ?
>
>
No.  In this version it's what lwip returned. I can replace it with:
return dhcp_start(netif) ? 0 : -EPERM;
to not provide on upper layer lwip internal things.



> > +*/
> > +int ulwip_dhcp(void);
> > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > index 6d2c00605b..59323fb325 100644
> > --- a/net/lwip/Makefile
> > +++ b/net/lwip/Makefile
> > @@ -65,4 +65,5 @@ obj-$(CONFIG_NET) += $(LWIPDIR)/netif/ethernet.o
> >  obj-$(CONFIG_NET) += port/if.o
> >  obj-$(CONFIG_NET) += port/sys-arch.o
> >
> > +obj-$(CONFIG_CMD_DHCP) += apps/dhcp/lwip-dhcp.o
> >  obj-$(CONFIG_CMD_DNS) += apps/dns/lwip-dns.o
> > diff --git a/net/lwip/apps/dhcp/lwip-dhcp.c
> b/net/lwip/apps/dhcp/lwip-dhcp.c
> > new file mode 100644
> > index 0000000000..cce1e367f9
> > --- /dev/null
> > +++ b/net/lwip/apps/dhcp/lwip-dhcp.c
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
> > + */
> > +
> > +#include <common.h>
> > +#include <command.h>
> > +#include <console.h>
> > +
> > +#include <lwip/dhcp.h>
> > +#include <lwip/prot/dhcp.h>
> > +
> > +#include <net/eth.h>
> > +#include <net/ulwip.h>
> > +
> > +static struct dhcp dhcp;
>
> Can we keep the state in the uclass?
>
>
I found a good way to avoid this static. If dhcp_set_struct() is not called
this struct is malloced, later it can be accessed as code bellow.


> > +
> > +static int ulwip_dhcp_tmo(void)
> > +{
> > +       switch (dhcp.state) {
> > +       case DHCP_STATE_BOUND:
> > +               env_set("bootfile", dhcp.boot_file_name);
> > +               env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
> > +               env_set("netmask", ip4addr_ntoa(&dhcp.offered_sn_mask));
> > +               env_set("serverip", ip4addr_ntoa(&dhcp.server_ip_addr));
>
> Please check errors throughout your patches. Use the
> netif_get_client_data() as in code bellow and do not pass
>
>
yep.


> > +               printf("DHCP client bound to address %s\n",
> ip4addr_ntoa(&dhcp.offered_ip_addr));
> > +               break;
> > +       default:
> > +               return -1;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int ulwip_dhcp(void)
> > +{
> > +       int err;
> > +       struct netif *netif;
> > +       int eth_idx;
> > +
> > +       eth_idx = eth_get_dev_index();
> > +       if (eth_idx < 0) {
> > +               log_err("no eth idx\n");
> > +               return -1;
>
> That is -EPERM...please use a suitable error, perhaps -ENOENT?
>
> > +       }
> > +
> > +       netif = netif_get_by_index(eth_idx + 1);
> > +       if (!netif)
> > +               return -1;
> > +
> > +       ulwip_set_tmo(ulwip_dhcp_tmo);
> > +
> > +       if (!netif_get_client_data(netif,
> LWIP_NETIF_CLIENT_DATA_INDEX_DHCP))
> > +               dhcp_set_struct(netif, &dhcp);
> > +
> > +       err = dhcp_start(netif);
> > +       if (err)
> > +               log_err("dhcp_start error %d\n", err);
>
> Ideally the caller would print the errors. We try to have commands do
> that, since then it allows silent running for things which want it. It
> also helps with code size.
>
>
ok.

> > +
> > +       return err;
> > +}
> > --
> > 2.30.2
> >
>
> Regards,
> Simon
>
