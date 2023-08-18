Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30213C7113C
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:24:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A236586E58;
	Fri, 18 Aug 2023 16:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uMBtBouc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F3E86E64; Fri, 18 Aug 2023 16:24:06 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8E0586D8F
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 16:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58d40c2debeso9725377b3.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692368642; x=1692973442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2MuiWtzbNRo+VIIxBbBn4Y+KkjmmLrcDSGDMi8ng9M=;
 b=uMBtBoucmIiskZTrMBdLF0TUPk32MxVs0oyr78kBaRsempPWfXy28rXc7yzPN3wkCF
 0ZD7vhUZekbaSRZCpXuj5E6Xx51Ab4sYYXcmf/4kGYqMgrh0dmK9iQyWuIPydXt+bZf4
 f+WpLCm0lyma8LSXrB97uAc3CTqoaoO0Lw3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692368642; x=1692973442;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2MuiWtzbNRo+VIIxBbBn4Y+KkjmmLrcDSGDMi8ng9M=;
 b=OVWa9a6RYCQfzDfZxchvEoAB3MTf80Y4jcQd4v2wrQ6GfDuXvyup7aeMn/Gcrv0/oC
 RdIPUERl2ZyScmmMMjV9zGOSZAKUX12tBih5/hiw8fWq2bNu0djjHmJ3dNWNJIDiPvFN
 vM1fcMuwCvxqf82wb20owdQk62PtwwGMfKRNsSAazYZRkfn7RSRJe30rQ3pQv7BgUXfW
 Ysy5yjiz/vrW8Uicrq0ssFwXrRpoeuMgQB3jBnHhvhypa34sawcMyMQ8OdWWgFOMlo/d
 XjrS8Nx1/cTDoBwN9pjpudNKSrY5+5tmsbMO4mXknEiJHzO4my64im4HZeARhW/7naUY
 fM1A==
X-Gm-Message-State: AOJu0YwXHroWUHDVY19gcR7XEsoOEdqOdZM5gOIUWD3ql/MjLfLsItpO
 vP3DYyhOvHOMvkecXD6rSNbFGGxRqk5nS3RdOCwkRA==
X-Google-Smtp-Source: AGHT+IF6BixaaKBSbeNuxZFLn5bvpwWG01FHaivjocbBXh3+j2jVOEMZ23tsWlMjzpZj9qGPT2HeUQ==
X-Received: by 2002:a81:4f86:0:b0:56d:34:893c with SMTP id
 d128-20020a814f86000000b0056d0034893cmr2742125ywb.4.1692368642482; 
 Fri, 18 Aug 2023 07:24:02 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 r123-20020a0dcf81000000b0057087e7691bsm518886ywd.56.2023.08.18.07.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 07:24:02 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:24:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, goldsimon@gmx.de, lwip-devel@nongnu.org
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
Message-ID: <20230818142400.GW1515023@bill-the-cat>
References: <20230814133253.4150-5-maxim.uvarov@linaro.org>
 <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
 <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
 <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
 <20230817151012.GC1515023@bill-the-cat>
 <CAD8XO3YD2XTfjBN90gJuSSdn9J40+JYk3WZ_CY7K7yA_r+XaRA@mail.gmail.com>
 <CALeDE9Ob4TAdGQdyyFYGToKXMpr0exbR-8+V0a2f6MLLnYH-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KTJzDs0Tc7IGjOlI"
Content-Disposition: inline
In-Reply-To: <CALeDE9Ob4TAdGQdyyFYGToKXMpr0exbR-8+V0a2f6MLLnYH-yQ@mail.gmail.com>
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


--KTJzDs0Tc7IGjOlI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 12:14:11PM +0100, Peter Robinson wrote:
> On Fri, Aug 18, 2023 at 10:39=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linar=
o.org> wrote:
> >
> >
> >
> > On Thu, 17 Aug 2023 at 21:10, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Aug 17, 2023 at 08:55:17PM +0600, Maxim Uvarov wrote:
> >> > On Thu, 17 Aug 2023 at 20:04, Peter Robinson <pbrobinson@gmail.com> =
wrote:
> >> >
> >> > > On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov=
@linaro.org>
> >> > > wrote:
> >> > > >
> >> > > > On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrot=
e:
> >> > > >
> >> > > > > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> >> > > > > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> >> > > > > ilias.apalodimas@linaro.org>
> >> > > > > > wrote:
> >> > > > > >
> >> > > > > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wro=
te:
> >> > > > > > > > Implement function for dhcp command with lwIP variant. U=
sage and
> >> > > > > output
> >> > > > > > > is
> >> > > > > > > > the same as the original command. This code called by
> >> > > compatibility
> >> > > > > code
> >> > > > > > > > between U-Boot and lwIP.
> >> > > > > > >
> >> > > > > > > Same as the dns command
> >> > > > > > >
> >> > > > > > > >
> >> > > > > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> > > > > > > > ---
> >> > > > > > > >  include/net/lwip.h             | 10 +++++++
> >> > > > > > > >  net/lwip/Makefile              |  1 +
> >> > > > > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> >> > > > > ++++++++++++++++++++++++++++++++++
> >> > > > > > > >  3 files changed, 62 insertions(+)
> >> > > > > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> >> > > > > > > >
> >> > > > > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> >> > > > > > > > index c83b5c8231..2f035280eb 100644
> >> > > > > > > > --- a/include/net/lwip.h
> >> > > > > > > > +++ b/include/net/lwip.h
> >> > > > > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp=
, int
> >> > > flag,
> >> > > > > int
> >> > > > > > > argc,
> >> > > > > > > >  *         Other value < 0, if error
> >> > > > > > > >  */
> >> > > > > > > >  int ulwip_dns(char *name, char *varname);
> >> > > > > > > > +
> >> > > > > > > > +/*
> >> > > > > > > > +* This function creates the DHCP request to obtain IP a=
ddress.
> >> > > If
> >> > > > > DHCP
> >> > > > > > > server
> >> > > > > > >
> >> > > > > > > Sphinx needs something more, please check the existing fun=
ctions
> >> > > > > > >
> >> > > > > > > > +* returns file name, this file will be downloaded with =
tftp.
> >> > > After
> >> > > > > this
> >> > > > > > > > +* function you need to invoke the polling loop to proce=
ss
> >> > > network
> >> > > > > > > communication.
> >> > > > > > > > +*
> >> > > > > > > > +* Return: 0 if success
> >> > > > > > > > +*         Other value < 0, if error
> >> > > > > > > > +*/
> >> > > > > > > > +int ulwip_dhcp(void);
> >> > > > > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> >> > > > > > > > index 6d2c00605b..59323fb325 100644
> >> > > > > > > > --- a/net/lwip/Makefile
> >> > > > > > > > +
> >> > > > > > > > +static struct dhcp dhcp;
> >> > > > > > > > +
> >> > > > > > > > +static int ulwip_dhcp_tmo(void)
> >> > > > > > > > +{
> >> > > > > > > > +     switch (dhcp.state) {
> >> > > > > > > > +     case DHCP_STATE_BOUND:
> >> > > > > > > > +             env_set("bootfile", dhcp.boot_file_name);
> >> > > > > > > > +             env_set("ipaddr",
> >> > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> >> > > > > > > > +             env_set("netmask",
> >> > > > > ip4addr_ntoa(&dhcp.offered_sn_mask));
> >> > > > > > > > +             env_set("serverip",
> >> > > > > ip4addr_ntoa(&dhcp.server_ip_addr));
> >> > > > > > > > +             printf("DHCP client bound to address %s\n",
> >> > > > > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> >> > > > > > > > +             break;
> >> > > > > > > > +     default:
> >> > > > > > > > +             return -1;
> >> > > > > > > > +     }
> >> > > > > > > > +
> >> > > > > > > > +     return 0;
> >> > > > > > > > +}
> >> > > > > > > > +
> >> > > > > > > > +int ulwip_dhcp(void)
> >> > > > > > > > +{
> >> > > > > > > > +     int err;
> >> > > > > > > > +     struct netif *netif;
> >> > > > > > > > +
> >> > > > > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> >> > > > > > > > +     netif =3D netif_get_by_index(1);
> >> > > > > > >
> >> > > > > > > What's (1)?
> >> > > > > > >
> >> > > > > > >
> >> > > > > > Only one lwip netif is registered. 1 - here is the index of =
netif. I
> >> > > > > don't
> >> > > > > > think that there is any definition for that...
> >> > > > > >
> >> > > > >
> >> > > > > And there's only ever going to be one interface (even if we ha=
ve ipv4
> >> > > > > and ipv60 ? If so, define it to something please, thanks.
> >> > > > >
> >> > > > > --
> >> > > > > Tom
> >> > > > >
> >> > > >
> >> > > > Yes, one interface has 2 addresses ipv4 and ipv6.
> >> > >
> >> > > What about a device like a router which may have multiple wired
> >> > > ethernet interface?
> >> >
> >> > Yea, looks like we need lwip netif per U-Boots eth_devs. I did not y=
et
> >> > support several eth devices, but it will be good to add this to not =
break
> >> > existing functionality..
> >>
> >> The general case ends up being if we have more than one interface,
> >> ethact is what's used.  I'm unsure off-hand if some of the fancier
> >> networking-centric chipsets and devices have something more complex
> >> setup in their stacks.
> >>
> >> --
> >> Tom
> >
> >
> > Likely the bootloader uses the only one ethernet interface for loading.=
 And it might
> > be enough to have an IP stack on top of the active eth device only. Thi=
s is a model
> > that I am following in these patches.
>=20
> It's possible, yes, that there may only be one active device, but you
> still will need to be able to handle all of them to at least work out
> which one has a link that you can bring up to get an IP. There's a
> bunch of devices that will have two interfaces with the same NIC
> driver, plus also there's at least a few devices that have an onboard
> switch (MV88E6XXX) although grep only shows a single one upstream.

Right.  You can even simulate this on some other devices via the gadget
ethernet driver.  In other words, please make sure we don't forget to
use "ethact" (see net/eth-uclass.c and net/eth_common.c).

--=20
Tom

--KTJzDs0Tc7IGjOlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTffwAACgkQFHw5/5Y0
tyxpPwv/XLccv7UNl2QFqtOlAzKbvmfGZpchYJF6MoXrAGcFCEUWJJYczCdb2ei3
ZCPfpV24nQ1qjQ921hTK6ZszzeBbzMTN3PRAr6BU4kPEBjeGNbATHgZBkC2hO31O
39vShHKlmEeCmIkcPlEXkTahPjNYYzWGHxBcNrWa2oMy1vniIYL+Z0NAOibnFTKf
0K7LhEYxEfPQYd4lRCixzWEWaNay8X2KmYRFq0TZLm43SJ85je2z5Csvo7Z/OyI7
VnXWEq51DtAFrQvXANg+BbsLL+ybH4JoYVC6++E97vfftJ3QgEgYFoWuYjuniMI2
ntGmfU0avUMeuo0avtpM2ERHW+o9RQXFS7h2gvmLbz0/Diw8C7aIotPAk72QNbdS
yVd2CNe0GTxJKSK8LM61Z1n2rtxQOpvSfynla8LG/bXNCwTtge3IgjR7NJtIWK9A
YYdfEtEq4Je7A9uSkHP42CsrEW+BfeEEfVirVUf5SqcZP0XrAeca2OQiWZNpx6Vt
AqSWzDbf
=OHm9
-----END PGP SIGNATURE-----

--KTJzDs0Tc7IGjOlI--
