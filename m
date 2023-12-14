Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF4C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 21:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D3F87AAE;
	Thu, 14 Dec 2023 22:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=criticallink.com header.i=@criticallink.com header.b="pqFEhU5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74A3587ABA; Thu, 14 Dec 2023 22:49:50 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3244387A98
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 22:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=criticallink.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcormier@criticallink.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ca02def690so110557411fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=criticallink.com; s=google; t=1702590587; x=1703195387; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CyLOEmqXQg/LlnM0olo24cCHZqeWCw4do6v+pioqs3M=;
 b=pqFEhU5kCZiGuabgN3XrVn3norFn6/Na1NrqJN8k2Ru52PJCrwVvlqHr1B/D+Nv333
 qf63bL8/zs2lK/Z6k7rlExM6M99eQ22M5fgVQ4/us0hxKf2+s0o4J/ctr6wqzAs4XTnS
 J92TLu5dWvpA5DDp27AKH4hPmJEWOoOenASJvC0flAe24ld7cljXxAzGOGoGIDkIfDIM
 BcmxLcjqqxiFClyO8IMD063aBK0Bd42zO6C+OlupGP2PYQzjRMZnIRCsmXp2jDG0jM/M
 XTmMdOfjJvahbvdfxS4Akn7qXiZ+t6AWfN+s42Smjx4QPJJgYUKwDdponblBhgkjMqiy
 Ipuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702590587; x=1703195387;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CyLOEmqXQg/LlnM0olo24cCHZqeWCw4do6v+pioqs3M=;
 b=oif8upM8eGiNts5srn1QfRetCATESiWPdKoLFo/uHvFYfE/iKmA1I9cGfFtvLp6Qs9
 unayFeJ2kZW24YUlAdNVXUM32Be5vbDMs6DpXOLiL6K9Oeb/a9n4E5Cxn42HZmfI1TBl
 dBW3BB8BGCefRRoJy4W4jczPxEJLzHdhQQioa239tSW6KAJmsILK+EjRJwfntdrBs9bh
 tZC7ZtxuMkIPWN1rjYJag6pntAvbfDfpjlMJpmEil6YGJEMe4Br1AzMFR+RAT306nTEU
 967b4p84U4UfnVurjw78jCdzMSbJOTpxGNx9YUKWaojbQftqGp38YInTnWIcLVaSVo8O
 b+tA==
X-Gm-Message-State: AOJu0YxUovDXHssYlU2q+wWt/DyFJdZ+kEjbcQjHnxI4abPuilY3SxvL
 gqbqVw7V0To3c+4zUtEm9r2KqNqBUW5vkSxMzS8Qmg==
X-Google-Smtp-Source: AGHT+IH5GH2Nc3ixhknaW+GYs+zRTmWZtMQMLPss1PRDbusADLRxPUXfYJuuX8jFoO5vc/JTH9ustV7mXGCj5elr4so=
X-Received: by 2002:a2e:be2c:0:b0:2cb:2b1f:a351 with SMTP id
 z44-20020a2ebe2c000000b002cb2b1fa351mr4626939ljq.5.1702590587390; Thu, 14 Dec
 2023 13:49:47 -0800 (PST)
MIME-Version: 1.0
From: Jon Cormier <jcormier@criticallink.com>
Date: Thu, 14 Dec 2023 16:49:36 -0500
Message-ID: <CADL8D3ZWoZpMidBTy+iSs-KOB6+LRAFVcDa-n_fVqvd00Z0=nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
To: Simon Glass <sjg@chromium.org>, alpernebiyasak@gmail.com, 
 Neha Malcom Francis <n-francis@ti.com>, Davis <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>, 
 Praneeth Bajjrui <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 nm@ti.com, Manorit Chawdhry <m-chawdhry@ti.com>
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

Hi Manorit,

This commit added a possibly unintentional dependency on python 3.9+.

I ran into this while trying to build the soon-to-be-released 09.01.00.008.

Build failure on ubuntu 20.04 which uses python 3.8:
"binman: 'type' object is not subscriptable"

This can be fixed by:

diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
index f80eb542c956..872c6d38ff46 100644
--- a/tools/binman/etype/ti_secure.py
+++ b/tools/binman/etype/ti_secure.py
@@ -16,7 +16,7 @@ class Firewall():
     id: int
     region: int
     control : int
-    permissions: list[hex]
+    permissions: list
     start_address: str
     end_address: str

> Hi Manorit,
>
> On Wed, 11 Oct 2023 at 23:02, Manorit Chawdhry <m-chawd...@ti.com> wrote:
> >
> > Hi Simon,
> >
> > On 11:54-20231011, Manorit Chawdhry wrote:
> > > We can now firewall entities while loading them through our secure
> > > entity TIFS, the required information should be present in the
> > > certificate that is being parsed by TIFS.
> > >
> > > The following commit adds the support to enable the certificates to be
> > > generated if the firewall configurations are present in the binman dtsi
> > > nodes.
> > >
> > > Signed-off-by: Manorit Chawdhry <m-chawd...@ti.com>
> > > ---
> > [..]
> > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > >  tools/binman/etype/ti_secure.py | 90
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  tools/binman/etype/x509_cert.py |  3 +-
> > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > >
> > >  from binman.entry import EntryArg
> > >  from binman.etype.x509_cert import Entry_x509_cert
> > > +from dataclasses import dataclass
> >
> > What all python versions do we support in u-boot? I see that dataclasses
> > are in-built from python3.7 but for older versions we would need to
> > install them separately, do I need to add this in buildman requirements
> > for those versions?
>
> I would prefer not to worry about Python 3.6 if possible. There are a
> few workarounds in buildman for it, though.
>
> Regards,
> Simon
