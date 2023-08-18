Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB68C678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 11:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D53186BFA;
	Fri, 18 Aug 2023 13:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ybtp50XQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3404786CA1; Fri, 18 Aug 2023 13:14:26 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A6386968
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 13:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso11525671fa.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692357263; x=1692962063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHCK0nxVouNhSl4DCUrf3atz0qAKrs0oyQAEyt6ZGG4=;
 b=Ybtp50XQT35pNd/g+83ab7Nzaqa/Uuk1BUXJPfo+jfgnyi8UIx8udyvPLdp6ao+4to
 cxNhtBHnqGyQ43KC7xaX/bOq/Wp4n/lZ15TF9kStNvsSnI+xkS6olWmSgYa1H6y/xlYh
 ce7V9fw8k13YDdmgTYiMRr2S4eX+YU5nc3kfZNuxV5T7fdIpMUwpEypQmTdxWTKei5du
 my27jrwNc+yzCZ7HVRjkKP8xHfeKwI3ujGN69rM3X0K7xHHco9jod2mpmTSjnzPQIwTN
 z53USWnzbD3HXlLi4szspnKlzlgLyGGVgrLktau1nWAIC8FT+EEtGiGIb8oXjlDw5BIR
 OOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692357263; x=1692962063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHCK0nxVouNhSl4DCUrf3atz0qAKrs0oyQAEyt6ZGG4=;
 b=MEgM+1eb7VWMut4m0u+1LEEaP6hF0qlBJGx/ZZ81m4qe2H86EjI5FmwjvnTPiQDXbM
 cA0Vb0pjd2YcgLOzQ/5Wbz5lcIryLZUN7fKVa/96qXToH/fDHSqMlTIfQad6nGj9E/fd
 8N5/XueRPOPQ+ZDnSgE0lmxi3cQ86RDproxJ8zOrnsRiO31QiOod0zhE6iWq/CJhjtNg
 dnHM1heVzCdiabqOfhi3kSxH10Nwrk05Uxj5Y0+ZiLuKRo9YRR1+T3D6J+OWbtHWb9r8
 laoeT9R5Cki3zdL9CdzMtHX84nEv5oylDZNEfrraJ1hm/98ep5KkDktdpfeuaKPUpqWD
 iVkQ==
X-Gm-Message-State: AOJu0YwgGcS0PqoXnb/nzyYLeCERG3XLh6V5U/z41+8/jEvEU0wE+SXg
 LIlRVhtSj2YbzLaHoq1sHK/7A5qqk24J3LbehxA=
X-Google-Smtp-Source: AGHT+IGgJqFqgL0UYWl0XrvconYD3NZNopPo3ho1J2pt+/XXcYyo7MLZn246i/PKZe+VDbh9jXO8j7Z8dnwDYAugE2o=
X-Received: by 2002:a2e:9658:0:b0:2b9:453f:a383 with SMTP id
 z24-20020a2e9658000000b002b9453fa383mr1688008ljh.53.1692357262510; Fri, 18
 Aug 2023 04:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
 <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
 <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
 <20230817151012.GC1515023@bill-the-cat>
 <CAD8XO3YD2XTfjBN90gJuSSdn9J40+JYk3WZ_CY7K7yA_r+XaRA@mail.gmail.com>
In-Reply-To: <CAD8XO3YD2XTfjBN90gJuSSdn9J40+JYk3WZ_CY7K7yA_r+XaRA@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 18 Aug 2023 12:14:11 +0100
Message-ID: <CALeDE9Ob4TAdGQdyyFYGToKXMpr0exbR-8+V0a2f6MLLnYH-yQ@mail.gmail.com>
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

On Fri, Aug 18, 2023 at 10:39=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.=
org> wrote:
>
>
>
> On Thu, 17 Aug 2023 at 21:10, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Aug 17, 2023 at 08:55:17PM +0600, Maxim Uvarov wrote:
>> > On Thu, 17 Aug 2023 at 20:04, Peter Robinson <pbrobinson@gmail.com> wr=
ote:
>> >
>> > > On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@l=
inaro.org>
>> > > wrote:
>> > > >
>> > > > On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:
>> > > >
>> > > > > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
>> > > > > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
>> > > > > ilias.apalodimas@linaro.org>
>> > > > > > wrote:
>> > > > > >
>> > > > > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote=
:
>> > > > > > > > Implement function for dhcp command with lwIP variant. Usa=
ge and
>> > > > > output
>> > > > > > > is
>> > > > > > > > the same as the original command. This code called by
>> > > compatibility
>> > > > > code
>> > > > > > > > between U-Boot and lwIP.
>> > > > > > >
>> > > > > > > Same as the dns command
>> > > > > > >
>> > > > > > > >
>> > > > > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> > > > > > > > ---
>> > > > > > > >  include/net/lwip.h             | 10 +++++++
>> > > > > > > >  net/lwip/Makefile              |  1 +
>> > > > > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
>> > > > > ++++++++++++++++++++++++++++++++++
>> > > > > > > >  3 files changed, 62 insertions(+)
>> > > > > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
>> > > > > > > >
>> > > > > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
>> > > > > > > > index c83b5c8231..2f035280eb 100644
>> > > > > > > > --- a/include/net/lwip.h
>> > > > > > > > +++ b/include/net/lwip.h
>> > > > > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, =
int
>> > > flag,
>> > > > > int
>> > > > > > > argc,
>> > > > > > > >  *         Other value < 0, if error
>> > > > > > > >  */
>> > > > > > > >  int ulwip_dns(char *name, char *varname);
>> > > > > > > > +
>> > > > > > > > +/*
>> > > > > > > > +* This function creates the DHCP request to obtain IP add=
ress.
>> > > If
>> > > > > DHCP
>> > > > > > > server
>> > > > > > >
>> > > > > > > Sphinx needs something more, please check the existing funct=
ions
>> > > > > > >
>> > > > > > > > +* returns file name, this file will be downloaded with tf=
tp.
>> > > After
>> > > > > this
>> > > > > > > > +* function you need to invoke the polling loop to process
>> > > network
>> > > > > > > communication.
>> > > > > > > > +*
>> > > > > > > > +* Return: 0 if success
>> > > > > > > > +*         Other value < 0, if error
>> > > > > > > > +*/
>> > > > > > > > +int ulwip_dhcp(void);
>> > > > > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
>> > > > > > > > index 6d2c00605b..59323fb325 100644
>> > > > > > > > --- a/net/lwip/Makefile
>> > > > > > > > +
>> > > > > > > > +static struct dhcp dhcp;
>> > > > > > > > +
>> > > > > > > > +static int ulwip_dhcp_tmo(void)
>> > > > > > > > +{
>> > > > > > > > +     switch (dhcp.state) {
>> > > > > > > > +     case DHCP_STATE_BOUND:
>> > > > > > > > +             env_set("bootfile", dhcp.boot_file_name);
>> > > > > > > > +             env_set("ipaddr",
>> > > ip4addr_ntoa(&dhcp.offered_ip_addr));
>> > > > > > > > +             env_set("netmask",
>> > > > > ip4addr_ntoa(&dhcp.offered_sn_mask));
>> > > > > > > > +             env_set("serverip",
>> > > > > ip4addr_ntoa(&dhcp.server_ip_addr));
>> > > > > > > > +             printf("DHCP client bound to address %s\n",
>> > > > > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
>> > > > > > > > +             break;
>> > > > > > > > +     default:
>> > > > > > > > +             return -1;
>> > > > > > > > +     }
>> > > > > > > > +
>> > > > > > > > +     return 0;
>> > > > > > > > +}
>> > > > > > > > +
>> > > > > > > > +int ulwip_dhcp(void)
>> > > > > > > > +{
>> > > > > > > > +     int err;
>> > > > > > > > +     struct netif *netif;
>> > > > > > > > +
>> > > > > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
>> > > > > > > > +     netif =3D netif_get_by_index(1);
>> > > > > > >
>> > > > > > > What's (1)?
>> > > > > > >
>> > > > > > >
>> > > > > > Only one lwip netif is registered. 1 - here is the index of ne=
tif. I
>> > > > > don't
>> > > > > > think that there is any definition for that...
>> > > > > >
>> > > > >
>> > > > > And there's only ever going to be one interface (even if we have=
 ipv4
>> > > > > and ipv60 ? If so, define it to something please, thanks.
>> > > > >
>> > > > > --
>> > > > > Tom
>> > > > >
>> > > >
>> > > > Yes, one interface has 2 addresses ipv4 and ipv6.
>> > >
>> > > What about a device like a router which may have multiple wired
>> > > ethernet interface?
>> >
>> > Yea, looks like we need lwip netif per U-Boots eth_devs. I did not yet
>> > support several eth devices, but it will be good to add this to not br=
eak
>> > existing functionality..
>>
>> The general case ends up being if we have more than one interface,
>> ethact is what's used.  I'm unsure off-hand if some of the fancier
>> networking-centric chipsets and devices have something more complex
>> setup in their stacks.
>>
>> --
>> Tom
>
>
> Likely the bootloader uses the only one ethernet interface for loading. A=
nd it might
> be enough to have an IP stack on top of the active eth device only. This =
is a model
> that I am following in these patches.

It's possible, yes, that there may only be one active device, but you
still will need to be able to handle all of them to at least work out
which one has a link that you can bring up to get an IP. There's a
bunch of devices that will have two interfaces with the same NIC
driver, plus also there's at least a few devices that have an onboard
switch (MV88E6XXX) although grep only shows a single one upstream.
