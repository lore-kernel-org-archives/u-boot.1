Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AB8C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 13:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD53C8857A;
	Thu, 23 May 2024 15:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lEx/C6Rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0604288582; Thu, 23 May 2024 15:40:38 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1694888577
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 15:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57824fa0a8fso3572344a12.0
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716471635; x=1717076435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gXTAGFFO1Szn/IXc5nOdvflkyK/JwBHVOFTFn3HIHrY=;
 b=lEx/C6RkEgxLeDDKLPL1MJLi8jAIFk+0QdN9ZmY7CHJiC5Nn/cMcZ/MFiWvdpAnsLR
 jMrZhf99atCUp4AFPS0TBNo/MoTDNDsP12SQ8OT6hduAdaO32wIA5d9h/zWfGwooZeiW
 iAhEjaO+635+dt9pAXgSFMjeUiZxVYJOcK7BtGuJ60dXDztSelLy38XZyKmCKsQKipJe
 mB8khy+zTyKOFC9SMO7Jlb7xEc+2j0Dbf9tBXGHQ9If1Gvcj7LG2V271SBs8LoHoljKZ
 Iw3K80IKtEENR9TceCo/vm8ZaME0hmyWaW23plWbqVY+5yhk7ANRgYm2bwn6B9KnS4Ut
 KarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716471635; x=1717076435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gXTAGFFO1Szn/IXc5nOdvflkyK/JwBHVOFTFn3HIHrY=;
 b=fXous/bOpG2xNVz6d1dtEOK8WF7r1s6N2EyQ9KrKnzWOxYUdM2yBEfB3IM6ORtmo4e
 ENSLhmoJVjmepFO+dN0cSn+T9HBb5ciGEoOWAN2ouwIMWsEgDenYx0/EXWIn02BhjFlN
 xwDsboPifrb3kNsOs0c9oAIdouvm6GQKYuKrVwElLgEFZT7UuJq3pFgRyaghY+b8EJ/g
 +cvqcWOnzW5ZPS+TsyEpzQaj8Y8Lp8CVjpaK7n10X2BQS7Sc42M53H3tr6VZk96Whz6b
 qpjW4zj96j1SHVYrZS4mGQRnAJisPqBleYBgbZ4G5dNKGp5IX4IADrUL4lBT7OOVZGPZ
 w8Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB5KE6AA1VNZQWzhuzZKxNuJZNAJ3Udv0BEqp04JMU4pJ8kv2lGVc7L9t/CiMYAOIibfww+qEQSFal+vnaZ+bT8wQZ+w==
X-Gm-Message-State: AOJu0Yy2epR+sFOcg75pYL7KmzZbGgRYi2aCcdZC9/Fj/HgKR1M9JrUA
 SZ7Dqt6BZK+QXBctH0yrztfMhdCMLYIh6P2P60KeCzjWtUYVxpW2mybj6Szk63mJ/YSEOrQqnE/
 vJbvZ3UgTEt+dfJMropDqNlfCIJ8=
X-Google-Smtp-Source: AGHT+IEW8hrV85ZlkTIw4NzIAESItfEjDXfR5C2lnNfXzRR8ndbQE3qnJlqj7TnOXjP6eiNYyxQJFNwoQASNxq7TkRY=
X-Received: by 2002:a50:9501:0:b0:572:d082:79fa with SMTP id
 4fb4d7f45d1cf-57832a2c27bmr2759307a12.14.1716471635184; Thu, 23 May 2024
 06:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <52b126477a39fe8e0bdea9fd9ec70b0951aab88b.1716393035.git.jerome.forissier@linaro.org>
 <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
In-Reply-To: <CAC_iWj+7ieyyh=aUzuAT7Okjg=PHxb=NDyXy43nKSzeFw3zFwg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 23 May 2024 14:40:23 +0100
Message-ID: <CALeDE9N15GF=qUqvL5LOJn1=jzLafcNwJz6VEP4K-xbYfvkDjA@mail.gmail.com>
Subject: Re: [PATCH 10/15] test: dm: dsa,
 eth: disable tests when CONFIG_NET_LWIP=y
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 22 May 2024 at 19:08, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jerome,
>
> On Wed, 22 May 2024 at 19:04, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Some sandbox tests make strong assumptions on how the network stack is
> > implemented. For example, the ping tests assume that ARP resolution
> > occurs upon sending out the ICMP packet. This is not always the case
> > with the lwIP stack which can cache ARP information.
> > Therefore, disable these tests when CONFIG_NET_LWIP is enabled.
>
> Is the ARP Caching the only issue?
> U-Boot isn't supposed to use the network stack that much, so it might
> be a better idea to disable arp-caching in LWIP (assuming it's
> doable). We might even get a few size of bytes back

You end up hitting an arp cache a lot because of references to say
DNS, IP GW or server end point for downloading, so while at first it
doesn't appear you'd need it you also don't want to do ARP for every
packet sent.

Peter

> Cheers
> /Ilias
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  test/dm/dsa.c | 2 ++
> >  test/dm/eth.c | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/test/dm/dsa.c b/test/dm/dsa.c
> > index c857106eaf..147e2a4afe 100644
> > --- a/test/dm/dsa.c
> > +++ b/test/dm/dsa.c
> > @@ -59,6 +59,7 @@ static int dm_test_dsa_probe(struct unit_test_state *uts)
> >
> >  DM_TEST(dm_test_dsa_probe, UT_TESTF_SCAN_FDT);
> >
> > +#if !defined(CONFIG_NET_LWIP)
> >  /* This test sends ping requests with the local address through each DSA port
> >   * via the sandbox DSA master Eth.
> >   */
> > @@ -80,3 +81,4 @@ static int dm_test_dsa(struct unit_test_state *uts)
> >  }
> >
> >  DM_TEST(dm_test_dsa, UT_TESTF_SCAN_FDT);
> > +#endif /* !defined(CONFIG_NET_LWIP) */
> > diff --git a/test/dm/eth.c b/test/dm/eth.c
> > index bb3dcc6b95..cf97b1c1ab 100644
> > --- a/test/dm/eth.c
> > +++ b/test/dm/eth.c
> > @@ -170,6 +170,7 @@ static int dm_test_ip6_make_lladdr(struct unit_test_state *uts)
> >  DM_TEST(dm_test_ip6_make_lladdr, UT_TESTF_SCAN_FDT);
> >  #endif
> >
> > +#if !defined(CONFIG_NET_LWIP)
> >  static int dm_test_eth(struct unit_test_state *uts)
> >  {
> >         net_ping_ip = string_to_ip("1.1.2.2");
> > @@ -298,6 +299,7 @@ static int dm_test_eth_act(struct unit_test_state *uts)
> >         return 0;
> >  }
> >  DM_TEST(dm_test_eth_act, UT_TESTF_SCAN_FDT);
> > +#endif /* !CONFIG_NET_LWIP */
> >
> >  /* Ensure that all addresses are loaded properly */
> >  static int dm_test_ethaddr(struct unit_test_state *uts)
> > @@ -332,6 +334,7 @@ static int dm_test_ethaddr(struct unit_test_state *uts)
> >  }
> >  DM_TEST(dm_test_ethaddr, UT_TESTF_SCAN_FDT);
> >
> > +#if !defined(CONFIG_NET_LWIP)
> >  /* The asserts include a return on fail; cleanup in the caller */
> >  static int _dm_test_eth_rotate1(struct unit_test_state *uts)
> >  {
> > @@ -616,6 +619,7 @@ static int dm_test_eth_async_ping_reply(struct unit_test_state *uts)
> >  }
> >
> >  DM_TEST(dm_test_eth_async_ping_reply, UT_TESTF_SCAN_FDT);
> > +#endif /* !CONFIG_NET_LWIP */
> >
> >  #if IS_ENABLED(CONFIG_IPV6_ROUTER_DISCOVERY)
> >
> > --
> > 2.40.1
> >
