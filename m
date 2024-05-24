Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AD4C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E7288653;
	Fri, 24 May 2024 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XtnYvKiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A332588568; Fri, 24 May 2024 10:49:43 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D17087D70
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 10:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6265d3c488so74824666b.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716540581; x=1717145381; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2Q6db9UuKP59bN2STWJ0NPL0896Jz3TpPLxrwniUiw=;
 b=XtnYvKiXmpjq1TSWaw8QsOFC3KChBBQHjF2oEFj8ubG3kXQneIGNiPJaz5gHmJyTK5
 FvsxE55EMaymk59baRboL6R97oKDSAW9Pjy1WpTGp6DJRCsE4NE30tVM9ql897SaEVl2
 e76rTQVRtMolkePRGPnJOeyliHltnGCRISranOtg4vYa17kRPor7cuhPfjH49HrespDV
 z3XhbwPGexb+fsVArj+r3dNsFBnYcQtLCayM178CyLuda8385G7YElJPHZFxDr7IU11B
 FmXFGAIWFkLsK6lp6O+EotI7niPuQ7kNr1g+Uyg1v+FT6t3lil6rJp/NBsBE30fn9SWI
 wihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716540581; x=1717145381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2Q6db9UuKP59bN2STWJ0NPL0896Jz3TpPLxrwniUiw=;
 b=NKhc9Gd3wpEb6B39mec+VHw2jd8SoVqiPq2gLqoR29sK3r6C4cBsx9EKYpJW8wKdBK
 KUEP93LiHrs/igtfAyp3Qj/UwHeNgBY2HmR3sWAScMJwrHAI7ettRLI/l48ALL2k85an
 6pXPa8t7BfqBTLPUCcSvzBrNUHtd/Rg7mdMQ+YApX2rlo+W490FMBsc8QThiUXbC4pkO
 Ab1YqYk3fzvC36Gkg9RZnoUoUCTXIFawUATUcuRMW0YU7cSAhqtQZjiODLpQzeZK65B0
 uFk7sFlDPiDf79e2U7e/7DVOO2k1Y0QcMKzfL47HI+sjZ9XeDuY7x6+PV1KeeM2cec/V
 k0iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw+4ftdHZmtnq4Vb8rMHktcaasdeKxSRNt72cmFFYBnUv6FNqY+rFsR3Dli/Itgyg7ya4zICuS0fUW2q7zxCSr1NgTJQ==
X-Gm-Message-State: AOJu0YzvJHWkm77R0xENaWY1HetnAxu5PjWUg/gChorIzbdU+fQyGskS
 l2rC8EiVMEi1aqKmeD5dgj9MB5XMujbQwdjHkfv+gXPd9jQJlAdamuXTrzGLbQ9OX03965XvUvc
 a/JAQ/uatcO3uWxrQy2xCvoQwW+c=
X-Google-Smtp-Source: AGHT+IEZ4NQudf+5hNYLe/uUc1eCHBE06rf3+T8klPGEkf3xL2U8hdlWMD9AcJWMu3m3JeQAAkkqvceZlS+rfSMSpLo=
X-Received: by 2002:a17:906:2343:b0:a60:c514:31d9 with SMTP id
 a640c23a62f3a-a62641c2e74mr167768466b.6.1716540580860; Fri, 24 May 2024
 01:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
 <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
 <CALeDE9N15GF=qUqvL5LOJn1=jzLafcNwJz6VEP4K-xbYfvkDjA@mail.gmail.com>
In-Reply-To: <CALeDE9N15GF=qUqvL5LOJn1=jzLafcNwJz6VEP4K-xbYfvkDjA@mail.gmail.com>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Fri, 24 May 2024 11:49:28 +0300
Message-ID: <CAJGZr0Lo_MauCiAiS-W9NaiVzUq=fUsq0Wh3T3RHPFFHn8OM1g@mail.gmail.com>
Subject: Re: [PATCH 10/15] test: dm: dsa,
 eth: disable tests when CONFIG_NET_LWIP=y
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 24 May 2024 14:28:51 +0200
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

=D1=87=D1=82, 23 =D0=BC=D0=B0=D1=8F 2024=E2=80=AF=D0=B3. =D0=B2 16:40, Pete=
r Robinson <pbrobinson@gmail.com>:
>
> On Wed, 22 May 2024 at 19:08, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Jerome,
> >
> > On Wed, 22 May 2024 at 19:04, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > Some sandbox tests make strong assumptions on how the network stack i=
s
> > > implemented. For example, the ping tests assume that ARP resolution
> > > occurs upon sending out the ICMP packet. This is not always the case
> > > with the lwIP stack which can cache ARP information.
> > > Therefore, disable these tests when CONFIG_NET_LWIP is enabled.
> >
> > Is the ARP Caching the only issue?
> > U-Boot isn't supposed to use the network stack that much, so it might
> > be a better idea to disable arp-caching in LWIP (assuming it's
> > doable). We might even get a few size of bytes back
>
> You end up hitting an arp cache a lot because of references to say
> DNS, IP GW or server end point for downloading, so while at first it
> doesn't appear you'd need it you also don't want to do ARP for every
> packet sent.
>
> Peter
>
Caching has to be in the network stack. At least for 5-10 entries.
There are 2 ways:
or change the test or add flush/delete arp entries. Flushing and
printing ARPs are useful
for debugging and can go to the special Kconfig option.

BR,
Maxim.

> > Cheers
> > /Ilias
> > >
> > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >  test/dm/dsa.c | 2 ++
> > >  test/dm/eth.c | 4 ++++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/test/dm/dsa.c b/test/dm/dsa.c
> > > index c857106eaf..147e2a4afe 100644
> > > --- a/test/dm/dsa.c
> > > +++ b/test/dm/dsa.c
> > > @@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state=
 *uts)
> > >
> > >  DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
> > >
> > > +#if !defined(CONFIG_NET_LWIP)
> > >  /* This test sends ping requests with the local address through each=
 DSA port
> > >   * via the sandbox DSA master Eth.
> > >   */
> > > @@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
> > >  }
> > >
> > >  DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
> > > +#endif /* !defined(CONFIG_NET_LWIP) */
> > > diff --git a/test/dm/eth.c b/test/dm/eth.c
> > > index bb3dcc6b95..cf97b1c1ab 100644
> > > --- a/test/dm/eth.c
> > > +++ b/test/dm/eth.c
> > > @@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_te=
st_state *uts)
> > >  DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
> > >  #endif
> > >
> > > +#if !defined(CONFIG_NET_LWIP)
> > >  static int dm_test_eth(struct unit_test_state *uts)
> > >  {
> > >         net_ping_ip =3D string_to_ip("1.1.2.2");
> > > @@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state=
 *uts)
> > >         return 0;
> > >  }
> > >  DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
> > > +#endif /* !CONFIG_NET_LWIP */
> > >
> > >  /* Ensure that all addresses are loaded properly */
> > >  static int dm_test_ethaddr(struct unit_test_state *uts)
> > > @@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state=
 *uts)
> > >  }
> > >  DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
> > >
> > > +#if !defined(CONFIG_NET_LWIP)
> > >  /* The asserts include a return on fail; cleanup in the caller */
> > >  static int _dm_test_eth_rotate1(struct unit_test_state *uts)
> > >  {
> > > @@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct un=
it_test_state *uts)
> > >  }
> > >
> > >  DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
> > > +#endif /* !CONFIG_NET_LWIP */
> > >
> > >  #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
> > >
> > > --
> > > 2.40.1
> > >



--=20
Best regards,
Maxim Uvarov
