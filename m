Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB27C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:39:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D29EA86C7C;
	Fri, 18 Aug 2023 11:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzIKQmgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A2086C93; Fri, 18 Aug 2023 11:39:38 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1E386C5C
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99bf8e5ab39so87996266b.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692351575; x=1692956375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OfB7R4logPqPYCYG09zUZmRxHqBHYLlZsqZAIe46SGE=;
 b=ZzIKQmgiQxFowB06kvey9jaQSNbg8WASxvq8OpkP9eyjEOaR6e8FRLYTQQVFxmj/tF
 wD0kOEC9WRj5IymexnqAfv+xWD/dGd+ikWvkJcRnY8eLjFs9/x7oxdwpP4ID1kxvNPOx
 md8abiTNZqwhZ/7bdLKHPAk21DO2Ds64XY3YaPmBIqj24P8oIR1BQcfbLwlFzi0MqwAw
 zRB3/l44khxhN7fSzBAqmm+qcM/vLqGLJFSWyAUSbfJQZFBI5sdE1xFpnIhaerBAVntG
 pjK0oIIyfsVag8nIq3xY4HSRQk8QtLWvZ5F0YIQ0tVD2sKEx+SNhP3kl+Shw5CVg67H5
 Jl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692351575; x=1692956375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OfB7R4logPqPYCYG09zUZmRxHqBHYLlZsqZAIe46SGE=;
 b=mGvu+qSHUaY4SX5m3Wud0yMkzNjFSXty22MOxajG85C/tdgdAwErFMNnMau7tCMiKT
 1/3KF3WzeYOIgsxiLmSHCMYiquBxiPkPsvGC+Br/OhNpe1DXytGUrdH4vo1MjTP9L/Q8
 YB3hkSQsmrRzp0FkjBdCzsqyDJ/Vr/9n30RZ4IooqVg29mDnUHG+4JaohBF9tMhpCjw9
 zMvlQO8+BfQvBUiJSAgSqf9vAfrgrw5L8zpEx5Ipe/ME5koug0pNhs9iQf5Mvpqjul88
 bS9+AER7+4oiwmhM18N6rWsUnKj+TdauRnoA1xRGRj7gJW5o6+XR3HVsZoJKJDXFTCfp
 r9tw==
X-Gm-Message-State: AOJu0YxhU6eWQB3gldkOOqzIBVgbH8D4bz4+oG94QM91bnWc/jKYt9u8
 HRqU3RVzv0uNr+XN8M1bjFthlmDKmI1988YtoTDgCw==
X-Google-Smtp-Source: AGHT+IGXD8LDMWbJNB+YST9SVxblxU5Tj5gsMe4zHmySEw71ni5upCjZvur9hVSzYgiDSFaGmACCghPF2CG3JGd1MWQ=
X-Received: by 2002:a17:907:7855:b0:994:542c:8718 with SMTP id
 lb21-20020a170907785500b00994542c8718mr1669228ejc.76.1692351575263; Fri, 18
 Aug 2023 02:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
 <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
 <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
 <20230817151012.GC1515023@bill-the-cat>
In-Reply-To: <20230817151012.GC1515023@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Fri, 18 Aug 2023 15:39:23 +0600
Message-ID: <CAD8XO3YD2XTfjBN90gJuSSdn9J40+JYk3WZ_CY7K7yA_r+XaRA@mail.gmail.com>
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, goldsimon@gmx.de, lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 17 Aug 2023 at 21:10, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Aug 17, 2023 at 08:55:17PM +0600, Maxim Uvarov wrote:
> > On Thu, 17 Aug 2023 at 20:04, Peter Robinson <pbrobinson@gmail.com>
> wrote:
> >
> > > On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@li=
naro.org>
> > > wrote:
> > > >
> > > > On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> > > > > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> > > > > ilias.apalodimas@linaro.org>
> > > > > > wrote:
> > > > > >
> > > > > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > > > > > > Implement function for dhcp command with lwIP variant. Usag=
e
> and
> > > > > output
> > > > > > > is
> > > > > > > > the same as the original command. This code called by
> > > compatibility
> > > > > code
> > > > > > > > between U-Boot and lwIP.
> > > > > > >
> > > > > > > Same as the dns command
> > > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > > > > > ---
> > > > > > > >  include/net/lwip.h             | 10 +++++++
> > > > > > > >  net/lwip/Makefile              |  1 +
> > > > > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> > > > > ++++++++++++++++++++++++++++++++++
> > > > > > > >  3 files changed, 62 insertions(+)
> > > > > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > > > > > > >
> > > > > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > > > > > > index c83b5c8231..2f035280eb 100644
> > > > > > > > --- a/include/net/lwip.h
> > > > > > > > +++ b/include/net/lwip.h
> > > > > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, i=
nt
> > > flag,
> > > > > int
> > > > > > > argc,
> > > > > > > >  *         Other value < 0, if error
> > > > > > > >  */
> > > > > > > >  int ulwip_dns(char *name, char *varname);
> > > > > > > > +
> > > > > > > > +/*
> > > > > > > > +* This function creates the DHCP request to obtain IP
> address.
> > > If
> > > > > DHCP
> > > > > > > server
> > > > > > >
> > > > > > > Sphinx needs something more, please check the existing
> functions
> > > > > > >
> > > > > > > > +* returns file name, this file will be downloaded with tft=
p.
> > > After
> > > > > this
> > > > > > > > +* function you need to invoke the polling loop to process
> > > network
> > > > > > > communication.
> > > > > > > > +*
> > > > > > > > +* Return: 0 if success
> > > > > > > > +*         Other value < 0, if error
> > > > > > > > +*/
> > > > > > > > +int ulwip_dhcp(void);
> > > > > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > > > > > > index 6d2c00605b..59323fb325 100644
> > > > > > > > --- a/net/lwip/Makefile
> > > > > > > > +
> > > > > > > > +static struct dhcp dhcp;
> > > > > > > > +
> > > > > > > > +static int ulwip_dhcp_tmo(void)
> > > > > > > > +{
> > > > > > > > +     switch (dhcp.state) {
> > > > > > > > +     case DHCP_STATE_BOUND:
> > > > > > > > +             env_set("bootfile", dhcp.boot_file_name);
> > > > > > > > +             env_set("ipaddr",
> > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > > > +             env_set("netmask",
> > > > > ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > > > > > > +             env_set("serverip",
> > > > > ip4addr_ntoa(&dhcp.server_ip_addr));
> > > > > > > > +             printf("DHCP client bound to address %s\n",
> > > > > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > > > +             break;
> > > > > > > > +     default:
> > > > > > > > +             return -1;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +int ulwip_dhcp(void)
> > > > > > > > +{
> > > > > > > > +     int err;
> > > > > > > > +     struct netif *netif;
> > > > > > > > +
> > > > > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > > > > > > +     netif =3D netif_get_by_index(1);
> > > > > > >
> > > > > > > What's (1)?
> > > > > > >
> > > > > > >
> > > > > > Only one lwip netif is registered. 1 - here is the index of
> netif. I
> > > > > don't
> > > > > > think that there is any definition for that...
> > > > > >
> > > > >
> > > > > And there's only ever going to be one interface (even if we have
> ipv4
> > > > > and ipv60 ? If so, define it to something please, thanks.
> > > > >
> > > > > --
> > > > > Tom
> > > > >
> > > >
> > > > Yes, one interface has 2 addresses ipv4 and ipv6.
> > >
> > > What about a device like a router which may have multiple wired
> > > ethernet interface?
> >
> > Yea, looks like we need lwip netif per U-Boots eth_devs. I did not yet
> > support several eth devices, but it will be good to add this to not bre=
ak
> > existing functionality..
>
> The general case ends up being if we have more than one interface,
> ethact is what's used.  I'm unsure off-hand if some of the fancier
> networking-centric chipsets and devices have something more complex
> setup in their stacks.
>
> --
> Tom
>

Likely the bootloader uses the only one ethernet interface for loading. And
it might
be enough to have an IP stack on top of the active eth device only. This is
a model
that I am following in these patches.

BR,
Maxim.
