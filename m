Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EEAC30630
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 14:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2018688B;
	Thu, 17 Aug 2023 16:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J+5yZL/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD750868D0; Thu, 17 Aug 2023 16:55:32 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F3D8687F
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 16:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-997c4107d62so1038682066b.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692284129; x=1692888929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XBmRIZ6nDgHRinmk5kirb+pVYDQ6c6PSHrezsIQEGA0=;
 b=J+5yZL/6fKZA44iM8mlSKto7fDdVvZ1QLXQM7PoYFagiyunp6JeppQQdP8cBQ1IM7X
 2yRBEH5M0LeOpMeBYyUC4jsP0UgJ9cScXW8XfsIYUNPmDmD4xEb5i6X0VK7Q6tRe1UBe
 hk4BKmAVU5qFGS94IgGCYOO7ZzzxvLy+O8LypswtZjohU9K6egnhyUY7jTjsRO7U97gs
 2WXPn3IbuXqyDRSGbCCnTtZyfhOLOnyt0sa6CuwAyD6xGa8Hry6uStzZ49kVYcP+k+DR
 cCX/DMExVOIwSE3vF5RcF2vjcQxwJv6h5zruRnRzCD3k6B6lj4lkXkZg6nvOlSYnlruQ
 k32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692284129; x=1692888929;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XBmRIZ6nDgHRinmk5kirb+pVYDQ6c6PSHrezsIQEGA0=;
 b=NGZKmirkasogXA0rAmCSFt/rm0asB0bLMn5Rq/KInhEtkBaDpPmupduV5Rpu2EkoPZ
 9ezEaw9HWTlGe7O7RId66qO3eNNjlWh0oD0SCV13zGwlDGp5LR64roRxyA3k9DLC0aFi
 yxw+eqOnzz+GMirX+m4+xPrFoKHbZG0oKGTNVLSdDzIkO08SzTWYiMDbHtdGJt4tdfvs
 NZgeOuMC/yP2dS88zJarwi6fuFKrC5n8+PoZfwr1p8v53/+s/leiSuitbFoVfBORAI4n
 gmeI1tgb9biUCetTQodXJi7DO03+8aBKmHG/rKqYmvRj5W6wOXc66+IxHR/ABaHX2sv9
 KWhQ==
X-Gm-Message-State: AOJu0YwJ75DHtLndwAadq0o7KRWqxztiWosFHngtmADbL4W8FvdGYTwd
 g7biMS4M0/kCV7qr72vzYku/9MqWwUYbE9D7VSQagg==
X-Google-Smtp-Source: AGHT+IFSVsA5DhmhiLfjSEh3TU4qEufkWnf/IlPaAvaM9eFy3r3K10zhKEjVamwV6tvr/QLO2Qo+CmBkMgQ1U8M8QHw=
X-Received: by 2002:a17:906:8454:b0:987:5761:2868 with SMTP id
 e20-20020a170906845400b0098757612868mr3647208ejy.11.1692284129407; Thu, 17
 Aug 2023 07:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-5-maxim.uvarov@linaro.org> <ZNo4cZtrSXa1dKXd@hades>
 <CAD8XO3a3N1j2G_Fjiws1S7praCDtLup=nrv4po--x6JmKKCfjQ@mail.gmail.com>
 <20230814152940.GZ3630934@bill-the-cat>
 <CAD8XO3Y7pYrd6nZm9kywbUpmOp7QsUchnb686XAq6WKyVBDGfw@mail.gmail.com>
 <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
In-Reply-To: <CALeDE9MxnG4Xk=scFwG1zdrpYRQii4BRM04bxPOamzAzhhN7jQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 17 Aug 2023 20:55:17 +0600
Message-ID: <CAD8XO3aAyA-m6BAkOnxw9uF2w_kadgSAwF3iRU_uBw-jq9iJJA@mail.gmail.com>
Subject: Re: [PATCHv6 04/14] net/lwip: implement dhcp cmd
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
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

On Thu, 17 Aug 2023 at 20:04, Peter Robinson <pbrobinson@gmail.com> wrote:

> On Thu, Aug 17, 2023 at 2:46=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro=
.org>
> wrote:
> >
> > On Mon, 14 Aug 2023 at 21:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Mon, Aug 14, 2023 at 09:18:19PM +0600, Maxim Uvarov wrote:
> > > > On Mon, 14 Aug 2023 at 20:21, Ilias Apalodimas <
> > > ilias.apalodimas@linaro.org>
> > > > wrote:
> > > >
> > > > > On Mon, Aug 14, 2023 at 07:32:43PM +0600, Maxim Uvarov wrote:
> > > > > > Implement function for dhcp command with lwIP variant. Usage an=
d
> > > output
> > > > > is
> > > > > > the same as the original command. This code called by
> compatibility
> > > code
> > > > > > between U-Boot and lwIP.
> > > > >
> > > > > Same as the dns command
> > > > >
> > > > > >
> > > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > > > ---
> > > > > >  include/net/lwip.h             | 10 +++++++
> > > > > >  net/lwip/Makefile              |  1 +
> > > > > >  net/lwip/apps/dhcp/lwip-dhcp.c | 51
> > > ++++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 62 insertions(+)
> > > > > >  create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
> > > > > >
> > > > > > diff --git a/include/net/lwip.h b/include/net/lwip.h
> > > > > > index c83b5c8231..2f035280eb 100644
> > > > > > --- a/include/net/lwip.h
> > > > > > +++ b/include/net/lwip.h
> > > > > > @@ -15,3 +15,13 @@ int do_lwip_dns(struct cmd_tbl *cmdtp, int
> flag,
> > > int
> > > > > argc,
> > > > > >  *         Other value < 0, if error
> > > > > >  */
> > > > > >  int ulwip_dns(char *name, char *varname);
> > > > > > +
> > > > > > +/*
> > > > > > +* This function creates the DHCP request to obtain IP address.
> If
> > > DHCP
> > > > > server
> > > > >
> > > > > Sphinx needs something more, please check the existing functions
> > > > >
> > > > > > +* returns file name, this file will be downloaded with tftp.
> After
> > > this
> > > > > > +* function you need to invoke the polling loop to process
> network
> > > > > communication.
> > > > > > +*
> > > > > > +* Return: 0 if success
> > > > > > +*         Other value < 0, if error
> > > > > > +*/
> > > > > > +int ulwip_dhcp(void);
> > > > > > diff --git a/net/lwip/Makefile b/net/lwip/Makefile
> > > > > > index 6d2c00605b..59323fb325 100644
> > > > > > --- a/net/lwip/Makefile
> > > > > > +
> > > > > > +static struct dhcp dhcp;
> > > > > > +
> > > > > > +static int ulwip_dhcp_tmo(void)
> > > > > > +{
> > > > > > +     switch (dhcp.state) {
> > > > > > +     case DHCP_STATE_BOUND:
> > > > > > +             env_set("bootfile", dhcp.boot_file_name);
> > > > > > +             env_set("ipaddr",
> ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > +             env_set("netmask",
> > > ip4addr_ntoa(&dhcp.offered_sn_mask));
> > > > > > +             env_set("serverip",
> > > ip4addr_ntoa(&dhcp.server_ip_addr));
> > > > > > +             printf("DHCP client bound to address %s\n",
> > > > > ip4addr_ntoa(&dhcp.offered_ip_addr));
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             return -1;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +int ulwip_dhcp(void)
> > > > > > +{
> > > > > > +     int err;
> > > > > > +     struct netif *netif;
> > > > > > +
> > > > > > +     ulwip_set_tmo(ulwip_dhcp_tmo);
> > > > > > +     netif =3D netif_get_by_index(1);
> > > > >
> > > > > What's (1)?
> > > > >
> > > > >
> > > > Only one lwip netif is registered. 1 - here is the index of netif. =
I
> > > don't
> > > > think that there is any definition for that...
> > > >
> > >
> > > And there's only ever going to be one interface (even if we have ipv4
> > > and ipv60 ? If so, define it to something please, thanks.
> > >
> > > --
> > > Tom
> > >
> >
> > Yes, one interface has 2 addresses ipv4 and ipv6.
>
> What about a device like a router which may have multiple wired
> ethernet interface?
>

Yea, looks like we need lwip netif per U-Boots eth_devs. I did not yet
support several eth devices, but it will be good to add this to not break
existing functionality..

BR,
Maxim.
