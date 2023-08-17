Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72159C2FC2F
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5CD86B40;
	Thu, 17 Aug 2023 15:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lwHBNAUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBE586B4D; Thu, 17 Aug 2023 15:46:18 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFB586AEE
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99bfcf4c814so1026563466b.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692279975; x=1692884775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EsAt1OdfthERp/nDn+PMgQZQhe+w26wC4JD5+H4qqbA=;
 b=lwHBNAUJ9FCn9gzgbuHcSTG2ggMYscSpORV9LDfuC6yuDeeA/XiqzNn7N7ablOt+8M
 uMgjOO1Pk6eY0ceQxvwbXL226+jgrnV2w9gLe1QcVRUOiNIdfOHFh3rCKLN3Z1mGN4Hx
 T4tbJ5K88dlJ8Jg2/KTryrK/WxcG45Qz9LT3xX0TPaEQEVORy6B1fHL1ghDypZ61L61T
 m1x9zTaQijnDHb014h9HO5+75RxfvvG7usHk4VctkN87wSo9Eww8eg0mEe7JuGy9RG7O
 dxJnr8jumHUB2LA6QyryJoQ8LEUUKJj03nI+mc8DgADJuTy1yiBrFW3Fg5575fvd59FI
 rmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279975; x=1692884775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EsAt1OdfthERp/nDn+PMgQZQhe+w26wC4JD5+H4qqbA=;
 b=dc0Uy3f2n3VAPaUDUQ0xlEVEEMYcN9bVvxfRXNqH52Sb7L194U59s4jBIzTELqtLGU
 Rgv34bBsXOkOqsodx6rU56RF+xjDrSQfSLQ1j563qHCcwWOPGAhh3nDQ6+u5YaIVejRP
 ZA8eCq8JLapcD8Q7ZwpbGLx4BVJvm34XHBfZtXuYrGiu6xcVMtu+HXMto9gLyBDMCiG4
 trfdXcpL66xY7e/MjMR1NrjELPghML3GAhLiVP0miCQeG/coqgT0pkYLmVLs9UEZnCoN
 hCqGQdHW/SspjxDMhWpunxA2kVp0eM8f97XDE0swDJcbQBia+PGffFnQgAAImX/jpHSt
 oEOg==
X-Gm-Message-State: AOJu0YxQ2hyYZmVGGYNpQI7qgS94vuXvNYwsymFL4ZuKcBtVilqYUw1v
 2QaO83kAaKdIhOSMPy9b/cpCySuQ/9GBg/KM1vOI7w==
X-Google-Smtp-Source: AGHT+IHNtCkUQq7HLulTN6cOoICKbA717hNXWw8oyBq2sE1bmrQykCUpULxANSNY2JEAC2DtEJWBlc2Xv3vX6VKi6ic=
X-Received: by 2002:a17:907:11d0:b0:99c:1b9a:b09e with SMTP id
 va16-20020a17090711d000b0099c1b9ab09emr5420064ejb.75.1692279975255; Thu, 17
 Aug 2023 06:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
In-Reply-To: <20230814152940.GZ3630934@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 17 Aug 2023 19:46:02 +0600
Message-ID: <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de, lwip-devel@nongnu.org
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

On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:

> On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> ilias.apalodimas@linaro.org>
> > wrote:
> >
> > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > > Implement function for dhcp command with lwIP variant. Usage and
> output
> > > is
> > > > the same as the original command. This code called by compatibility
> code
> > > > between U-Boot and lwIP.
> > >
> > > Same as the dns command
> > >
> > > >
> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > ---
> > > >  include/net/lwip.h             | 10 +++++++
> > > >  net/lwip/Makefile              |  1 +
> > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> ++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 62 insertions(+)
> > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > > >
> > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > > index c83b5c8231..2f035280eb 100644
> > > > --- a/include/net/lwip.h
> > > > +++ b/include/net/lwip.h
> > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag,
> int
> > > argc,
> > > >  *         Other value < 0, if error
> > > >  */
> > > >  int ulwip_dns(char *name, char *varname);
> > > > +
> > > > +/*
> > > > +* This function creates the DHCP request to obtain IP address. If
> DHCP
> > > server
> > >
> > > Sphinx needs something more, please check the existing functions
> > >
> > > > +* returns file name, this file will be downloaded with tftp.  After
> this
> > > > +* function you need to invoke the polling loop to process network
> > > communication.
> > > > +*
> > > > +* Return: 0 if success
> > > > +*         Other value < 0, if error
> > > > +*/
> > > > +int ulwip_dhcp(void);
> > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > > index 6d2c00605b..59323fb325 100644
> > > > --- a/net/lwip/Makefile
> > > > +
> > > > +static struct dhcp dhcp;
> > > > +
> > > > +static int ulwip_dhcp_tmo(void)
> > > > +{
> > > > +     switch (dhcp.state) {
> > > > +     case DHCP_STATE_BOUND:
> > > > +             env_set("bootfile", dhcp.boot_file_name);
> > > > +             env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > +             env_set("netmask",
> ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > > +             env_set("serverip",
> ip4addr_ntoa(&dhcp.server_ip_addr));
> > > > +             printf("DHCP client bound to address %s\n",
> > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > +             break;
> > > > +     default:
> > > > +             return -1;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +int ulwip_dhcp(void)
> > > > +{
> > > > +     int err;
> > > > +     struct netif *netif;
> > > > +
> > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > > +     netif = netif_get_by_index(1);
> > >
> > > What's (1)?
> > >
> > >
> > Only one lwip netif is registered. 1 - here is the index of netif. I
> don't
> > think that there is any definition for that...
> >
>
> And there's only ever going to be one interface (even if we have ipv4
> and ipv60 ? If so, define it to something please, thanks.
>
> --
> Tom
>

Yes, one interface has 2 addresses ipv4 and ipv6.
