Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C80C30638
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1208F86AEE;
	Thu, 17 Aug 2023 17:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l1JMvQ5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6668B86B0A; Thu, 17 Aug 2023 17:10:19 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5C986989
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bd0911c95dso6742719a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285015; x=1692889815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kGUeifjQUdDsASUf3/rnCZ3Bhp5id9NaOLvYWKimalQ=;
 b=l1JMvQ5amdIIN9dEej4Bqqb32Qqk8z7xdYIlCvfWZpxqdI/YbD5wMNVPF9uswYp0kw
 ldydcSHa8jWbfvsjF10+09Nxcpd/0fmvOK+xNdKt3qUzwapOvwhhLPoUr9ele3yQnggd
 qS5hIkRPL70a/AmB5T8N8qKoBgUysOSw4+c8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285015; x=1692889815;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGUeifjQUdDsASUf3/rnCZ3Bhp5id9NaOLvYWKimalQ=;
 b=Vz1m63P27BNmktGpewTQfVmB3P2AvNbipXNsEax2fVAhj+Tal975ErjC33gLj0nHFf
 0gRbv2jLY5+ZGi40x0OtfletEA7pgx3mZi+l8mq2V5GXrMWVVPzmtMnRMNCKONICMbf4
 tdnJ67DlgnFpxlJGRJSVNaW08J11qowIV7xZfNY4wEXXQEK9r9y8W31GLIMI8QtzPb1G
 Tc44Z0q3z2886huxrbO0Ae9uAZxEtBsnzRwF0bgYxbhJLj68ger4aonXnIATZvq4UbyY
 9gaZEvpi7ZGC/wEumNQBMoH8EEJz5P0ec+4nEv5ktgdiAJzICukxcN4BOjpI7MwmIIic
 PGCQ==
X-Gm-Message-State: AOJu0YzNs4Z8Xr5FCfj1AgDEeF4PgPof8mO4Jd+TQk5ARJC2Pm7ohJMt
 PXPL9IJDQBT4usNSx3+oUJR+tw==
X-Google-Smtp-Source: AGHT+IHd528Fbm3QXjMDbtBvm7bq1yi1r9tPvAyjfffV+ypz/uON7fhN6afZGMPxIYalvS1ZhtqMlg==
X-Received: by 2002:a05:6870:e40d:b0:1bb:b13c:7fa4 with SMTP id
 n13-20020a056870e40d00b001bbb13c7fa4mr6469214oag.26.1692285014765; 
 Thu, 17 Aug 2023 08:10:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 o123-20020a0dfe81000000b005773b750d95sm4634574ywf.28.2023.08.17.08.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:14 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, goldsimon@gmx.de, lwip-devel@nongnu.org
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
Message-ID: <20230817151012.GC1515023@bill-the-cat>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org>
 <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
 <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
 <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7WrlGlaO/wbFeRAa"
Content-Disposition: inline
In-Reply-To: <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7WrlGlaO/wbFeRAa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 08:55:17PM +0600, Maxim Uvarov wrote:
> On Thu, 17 Aug 2023 at 20:04, Peter Robinson <pbrobinson@gmail.com> wrote:
>=20
> > On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@lina=
ro.org>
> > wrote:
> > >
> > > On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> > > > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> > > > ilias.apalodimas@linaro.org>
> > > > > wrote:
> > > > >
> > > > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > > > > > Implement function for dhcp command with lwIP variant. Usage =
and
> > > > output
> > > > > > is
> > > > > > > the same as the original command. This code called by
> > compatibility
> > > > code
> > > > > > > between U-Boot and lwIP.
> > > > > >
> > > > > > Same as the dns command
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > > > > ---
> > > > > > >  include/net/lwip.h             | 10 +++++++
> > > > > > >  net/lwip/Makefile              |  1 +
> > > > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> > > > ++++++++++++++++++++++++++++++++++
> > > > > > >  3 files changed, 62 insertions(+)
> > > > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > > > > > >
> > > > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > > > > > index c83b5c8231..2f035280eb 100644
> > > > > > > --- a/include/net/lwip.h
> > > > > > > +++ b/include/net/lwip.h
> > > > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int
> > flag,
> > > > int
> > > > > > argc,
> > > > > > >  *         Other value < 0, if error
> > > > > > >  */
> > > > > > >  int ulwip_dns(char *name, char *varname);
> > > > > > > +
> > > > > > > +/*
> > > > > > > +* This function creates the DHCP request to obtain IP addres=
s.
> > If
> > > > DHCP
> > > > > > server
> > > > > >
> > > > > > Sphinx needs something more, please check the existing functions
> > > > > >
> > > > > > > +* returns file name, this file will be downloaded with tftp.
> > After
> > > > this
> > > > > > > +* function you need to invoke the polling loop to process
> > network
> > > > > > communication.
> > > > > > > +*
> > > > > > > +* Return: 0 if success
> > > > > > > +*         Other value < 0, if error
> > > > > > > +*/
> > > > > > > +int ulwip_dhcp(void);
> > > > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > > > > > index 6d2c00605b..59323fb325 100644
> > > > > > > --- a/net/lwip/Makefile
> > > > > > > +
> > > > > > > +static struct dhcp dhcp;
> > > > > > > +
> > > > > > > +static int ulwip_dhcp_tmo(void)
> > > > > > > +{
> > > > > > > +     switch (dhcp.state) {
> > > > > > > +     case DHCP_STATE_BOUND:
> > > > > > > +             env_set("bootfile", dhcp.boot_file_name);
> > > > > > > +             env_set("ipaddr",
> > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > > +             env_set("netmask",
> > > > ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > > > > > +             env_set("serverip",
> > > > ip4addr_ntoa(&dhcp.server_ip_addr));
> > > > > > > +             printf("DHCP client bound to address %s\n",
> > > > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > > +             break;
> > > > > > > +     default:
> > > > > > > +             return -1;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +int ulwip_dhcp(void)
> > > > > > > +{
> > > > > > > +     int err;
> > > > > > > +     struct netif *netif;
> > > > > > > +
> > > > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > > > > > +     netif =3D netif_get_by_index(1);
> > > > > >
> > > > > > What's (1)?
> > > > > >
> > > > > >
> > > > > Only one lwip netif is registered. 1 - here is the index of netif=
=2E I
> > > > don't
> > > > > think that there is any definition for that...
> > > > >
> > > >
> > > > And there's only ever going to be one interface (even if we have ip=
v4
> > > > and ipv60 ? If so, define it to something please, thanks.
> > > >
> > > > --
> > > > Tom
> > > >
> > >
> > > Yes, one interface has 2 addresses ipv4 and ipv6.
> >
> > What about a device like a router which may have multiple wired
> > ethernet interface?
>=20
> Yea, looks like we need lwip netif per U-Boots eth_devs. I did not yet
> support several eth devices, but it will be good to add this to not break
> existing functionality..

The general case ends up being if we have more than one interface,
ethact is what's used.  I'm unsure off-hand if some of the fancier
networking-centric chipsets and devices have something more complex
setup in their stacks.

--=20
Tom

--7WrlGlaO/wbFeRAa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOFEACgkQFHw5/5Y0
tyzhFQv/ROnJvuY5bd02yZerAXP4Lo7MBP3I3hFdIS+Ipx5O4Jl4N4merSNPnBvJ
v6Jl164QpoCDFPyPkzKTOPLVK4HBc9t7CNijJ1J0UTFMEcb+TMA1iyAfZL29n6Wn
uqLCGA1eG106nTa1GYlwbhX5/4n1aTUNMcjBdyeO4E/cUAaXeW0g/W/Z14ZccS3C
WdK0KVxRVdIRE8HwQrC38qJ/Zf8Ryboh/Eh7B4iUWsvvhh8zvvOkrAFGHMvBKzXy
UaZ9T/+vxQbbdl2o1prq7PFGuOEzMchR4uiLRUqOr/avBztfOe4pxRk/lePKk5qA
8EyMbNuCEm8hV5gweNuKQ7s7Y4TXC4THsHnz7ksFL099F4Lkt3J8hiQ/UxzOlIjR
3mP7LsyMa8WhrJo7uL8/TvdnyffVRCw+tgEHlaZABaYFQK4UqyXSM/kxfBvnKnt9
dVoKfLI0UQajS3KeB/C7fwac25AvbJxRppnmVv/nutHboQE53ujtsDzLDkE2CZnI
H2VCbpwC
=2vWd
-----END PGP SIGNATURE-----

--7WrlGlaO/wbFeRAa--
