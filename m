Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E983FC2FC14
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 14:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 457A486B58;
	Thu, 17 Aug 2023 16:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cq07nRqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AC686B58; Thu, 17 Aug 2023 16:04:24 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7199586AC8
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 16:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9fa64db41so119427651fa.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692281061; x=1692885861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDznt0dthNWjnxU9sfz/3vYvt3vVmlgCDnReyzuOlcU=;
 b=cq07nRqYVwo8jxyInX2yVEV7YXf/m/nvx26o9dNaxNuU2wqLVJcn8wRHjTzGXEytiz
 nm0SYxoDX/ckrVkP03WtZYAbt8w9TqV3XiKXgF/SruV5JrijmQSGbM7V7Rj7C2XYkefH
 KsMFYGraST4/5iOQBuT5Y0d76YFf1nn2x9T6lTpKmA8NXEVZsBINohsh+j/OqGV3sbqG
 CuDD7UPqtMwvhPFEHdN8Q+chzFFLmuWiyiJjw5PkkFj2x12naJ97eW1q4H51S9z1acpk
 DWqPKDm6foMarryBcCjbVWezjzxItPgY/2sOga77QXu/WQDHXw5FboF7fejr9Gf24IeB
 93Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692281061; x=1692885861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDznt0dthNWjnxU9sfz/3vYvt3vVmlgCDnReyzuOlcU=;
 b=lPNnVRsTYnlMnkznNe3LcQHt8aDu5xOAX2Ibf3B7MLQKytHuKdR70ONUxJHROCmKeb
 4qZWLgKnvLP4a+HrngEN6HnO7pCA1BC6l3hm1pSdwAT1WJIkeEl9vE3QVFUgFWB10tYv
 6BsM9ErzUOlEFD8QGGE8rzNE5UNHRQqqHlJ/WuOTfbncsI+AkwkK5HgqnR3EBO/2LzFm
 wPgyXh7Wzdh4TTUuQ4kP+O8BCXYuSuhPcobukdWf8FbTsc0tkexDvbp9E6nuqM6dl5n7
 AQceyB5IHUQ8aOQKJRFpbIhmByQrxZYw7p7qzEukE3fRj1Ye8E3u0/x3TGoNQxukSscC
 wgsQ==
X-Gm-Message-State: AOJu0YxlkMhmqZSQwpNSNxQxjvrIGGIzGlkSpBvNVUNgW9+IwFdL8gER
 JU6MaIg14qLTo7g3vaLIZfACJ1REyXJPAVKsg8I=
X-Google-Smtp-Source: AGHT+IFtWpvXQXJ0/TL5aLLBj11iYNDA4KDuYv9fxPy1IwPNBEGvSfYIG/SlrELLtMXRpj1I5rZ75zpGyEznIqhnxFk=
X-Received: by 2002:a2e:9217:0:b0:2b9:bbf5:7c6 with SMTP id
 k23-20020a2e9217000000b002b9bbf507c6mr4596881ljg.43.1692281060363; Thu, 17
 Aug 2023 07:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
In-Reply-To: <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 17 Aug 2023 15:04:08 +0100
Message-ID: <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, goldsimon@gmx.de, lwip-devel@nongnu.org
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

On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:
>
> > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> > ilias.apalodimas@linaro.org>
> > > wrote:
> > >
> > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > > > Implement function for dhcp command with lwIP variant. Usage and
> > output
> > > > is
> > > > > the same as the original command. This code called by compatibili=
ty
> > code
> > > > > between U-Boot and lwIP.
> > > >
> > > > Same as the dns command
> > > >
> > > > >
> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > > ---
> > > > >  include/net/lwip.h             | 10 +++++++
> > > > >  net/lwip/Makefile              |  1 +
> > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> > ++++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 62 insertions(+)
> > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > > > >
> > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > > > index c83b5c8231..2f035280eb 100644
> > > > > --- a/include/net/lwip.h
> > > > > +++ b/include/net/lwip.h
> > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int fla=
g,
> > int
> > > > argc,
> > > > >  *         Other value < 0, if error
> > > > >  */
> > > > >  int ulwip_dns(char *name, char *varname);
> > > > > +
> > > > > +/*
> > > > > +* This function creates the DHCP request to obtain IP address. I=
f
> > DHCP
> > > > server
> > > >
> > > > Sphinx needs something more, please check the existing functions
> > > >
> > > > > +* returns file name, this file will be downloaded with tftp.  Af=
ter
> > this
> > > > > +* function you need to invoke the polling loop to process networ=
k
> > > > communication.
> > > > > +*
> > > > > +* Return: 0 if success
> > > > > +*         Other value < 0, if error
> > > > > +*/
> > > > > +int ulwip_dhcp(void);
> > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > > > index 6d2c00605b..59323fb325 100644
> > > > > --- a/net/lwip/Makefile
> > > > > +
> > > > > +static struct dhcp dhcp;
> > > > > +
> > > > > +static int ulwip_dhcp_tmo(void)
> > > > > +{
> > > > > +     switch (dhcp.state) {
> > > > > +     case DHCP_STATE_BOUND:
> > > > > +             env_set("bootfile", dhcp.boot_file_name);
> > > > > +             env_set("ipaddr", ip4addr_ntoa(&dhcp.offered_ip_add=
r));
> > > > > +             env_set("netmask",
> > ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > > > +             env_set("serverip",
> > ip4addr_ntoa(&dhcp.server_ip_addr));
> > > > > +             printf("DHCP client bound to address %s\n",
> > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > +             break;
> > > > > +     default:
> > > > > +             return -1;
> > > > > +     }
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +int ulwip_dhcp(void)
> > > > > +{
> > > > > +     int err;
> > > > > +     struct netif *netif;
> > > > > +
> > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > > > +     netif =3D netif_get_by_index(1);
> > > >
> > > > What's (1)?
> > > >
> > > >
> > > Only one lwip netif is registered. 1 - here is the index of netif. I
> > don't
> > > think that there is any definition for that...
> > >
> >
> > And there's only ever going to be one interface (even if we have ipv4
> > and ipv60 ? If so, define it to something please, thanks.
> >
> > --
> > Tom
> >
>
> Yes, one interface has 2 addresses ipv4 and ipv6.

What about a device like a router which may have multiple wired
ethernet interface?
