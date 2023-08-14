Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6269DC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D185C86679;
	Mon, 14 Aug 2023 17:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YCd9cZDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB45586679; Mon, 14 Aug 2023 17:29:45 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1C4855CE
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-584243f84eeso50020867b3.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692026982; x=1692631782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4ezdTQO38TRV8RizQgh22zI1oXgWhxfV0lBFgeu/0f8=;
 b=YCd9cZDV/DjPH95jtYGRfLkysTOOsTZl9Y/bP+GUAklVjp3je1hpsSYmJmZfwWN8Bi
 d+qvfo3tEivv/1BWIeieVNHQy2sBWJ+K/MbfE5HmkRDUapBjAdBbz+9mUh7FekGCVgHI
 AKfVrFvR/QZkkint24koucHlGyhv105Pa/JL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692026982; x=1692631782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ezdTQO38TRV8RizQgh22zI1oXgWhxfV0lBFgeu/0f8=;
 b=cSR1zjIHLHu9W/y4+BGaTS8BS777ggIDflccnuitv69AUu33mu4/LkCOx5bIF6+PPZ
 WrwRLiqYOfDseGBU37MkEd6DSPhnDiCD7D2DSwtLjoOJuOQe8iFKYezcvjp9JUWgk7g9
 woXkynqkymAknPAUKaAt1LB5ruAluWtP6PiSRxom98/zWjerUIs8VqlRBmu6jufkSlwA
 PENBLQ6nHdw8AiVeJ8JQMbmPY434w7RMNHfA4qruwCUIEEN2XL5t7YU3Ri8DhLM2rpkS
 2gjxYYKSMsXLwVUIjHccaXZN/mH2843HmkAu3/q6TkY65rbsxZkKxAhn5O6GYPqiGxGH
 9JvA==
X-Gm-Message-State: AOJu0YzYBfQPdHTLxCAWGbHrSwuFixJjhkCTPs2wzCsq9DWObiW0naOY
 u+2RHXymvSxLqHAeQb5bVUHokQ==
X-Google-Smtp-Source: AGHT+IHfvZeaZRC9c9tuawz3Ea9Fxbwtg/25FiNek0rGkG9EpfHd6nWow3XjbR5jptzG7B0RzmIF1Q==
X-Received: by 2002:a81:9108:0:b0:56c:f68f:d824 with SMTP id
 i8-20020a819108000000b0056cf68fd824mr12265861ywg.45.1692026982394; 
 Mon, 14 Aug 2023 08:29:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 x133-20020a0dd58b000000b0058451237d7dsm2832797ywd.119.2023.08.14.08.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:29:42 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:29:40 -0400
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 goldsimon@gmx.de, lwip-devel@nongnu.org
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
Message-ID: <20230814152940.GZ3630934@bill-the-cat>
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org>
 <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hutl6qUFhZg/xApo"
Content-Disposition: inline
In-Reply-To: <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
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


--hutl6qUFhZg/xApo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <ilias.apalodimas@linaro.o=
rg>
> wrote:
>=20
> > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > Implement function for dhcp command with lwIP variant. Usage and outp=
ut
> > is
> > > the same as the original command. This code called by compatibility c=
ode
> > > between U-Boot and lwIP.
> >
> > Same as the dns command
> >
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > ---
> > >  include/net/lwip.h             | 10 +++++++
> > >  net/lwip/Makefile              |  1 +
> > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51 ++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 62 insertions(+)
> > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > >
> > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > index c83b5c8231..2f035280eb 100644
> > > --- a/include/net/lwip.h
> > > +++ b/include/net/lwip.h
> > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int flag, i=
nt
> > argc,
> > >  *         Other value < 0, if error
> > >  */
> > >  int ulwip_dns(char *name, char *varname);
> > > +
> > > +/*
> > > +* This function creates the DHCP request to obtain IP address. If DH=
CP
> > server
> >
> > Sphinx needs something more, please check the existing functions
> >
> > > +* returns file name, this file will be downloaded with tftp.  After =
this
> > > +* function you need to invoke the polling loop to process network
> > communication.
> > > +*
> > > +* Return: 0 if success
> > > +*         Other value < 0, if error
> > > +*/
> > > +int ulwip_dhcp(void);
> > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > index 6d2c00605b..59323fb325 100644
> > > --- a/net/lwip/Makefile
> > > +
> > > +static struct dhcp dhcp;
> > > +
> > > +static int ulwip_dhcp_tmo(void)
> > > +{
> > > +     switch (dhcp.state) {
> > > +     case DHCP_STATE_BOUND:
> > > +             env_set("bootfile", dhcp.boot_file_name);
> > > +             env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > +             env_set("netmask", ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > +             env_set("serverip", ip4addr_ntoa(&dhcp.server_ip_addr));
> > > +             printf("DHCP client bound to address %s\n",
> > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > +             break;
> > > +     default:
> > > +             return -1;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +int ulwip_dhcp(void)
> > > +{
> > > +     int err;
> > > +     struct netif *netif;
> > > +
> > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > +     netif =3D netif_get_by_index(1);
> >
> > What's (1)?
> >
> >
> Only one lwip netif is registered. 1 - here is the index of netif. I don't
> think that there is any definition for that...
>=20

And there's only ever going to be one interface (even if we have ipv4
and ipv60 ? If so, define it to something please, thanks.

--=20
Tom

--hutl6qUFhZg/xApo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaSGAACgkQFHw5/5Y0
tyzG6Qv+OUmCr+6G49auMVF9VCzqUpGkKbK5GGaebAEP5UlSM3lchhVjanJFOzw+
RvVFsApx2OqcubaocxJuum43iwVzEtu7NtXu1gCSxvhmGjPzQurKQWWJZ+vpZNUS
P1emYAJhsHm3Z8eeYnUjUEPwQqOyqkMVAoGMJnFsPeaWwvMVsXoZxC/N6e0Shnkc
N1/KPcIjC9ZRo700Col5C6LruF+UPb3uqvRNer3W5meYJNs9aRSRQ3UgLOki1DiH
q7Hbva3DFklxi4TTls4BQ4sts1gzhHUPecPvXyhsKs/bUV2WbuWJye+knnEd6xEZ
6mgy2eDX31/2nByJOh1xb4h8417I60AqaD+OQgA6OV3qIw80SPm1pAj0haHcEJex
plbz2FS3ccPX2Ci62F3Yq4aGeb6bmNWwRS6sSDYvOvr4NV+U5LB/t+SOOTXwmZ9V
l1xxrRIDgoGaBmZKz+3r/D7yNs1t3TLI4kt54SKOvO6tHovnBhbxToDCbv7+7fPC
Y8OERkGv
=dQtJ
-----END PGP SIGNATURE-----

--hutl6qUFhZg/xApo--
