Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1044EC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 17:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8BD806FC;
	Thu, 20 Mar 2025 18:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="LOfSsbfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C6688070C; Thu, 20 Mar 2025 18:59:33 +0100 (CET)
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE83E803CC
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 18:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1742493541;
 bh=I5shWDz8mllotMxt1iKiPjsJyqeJGDmIrmKh+WkjbYg=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=LOfSsbfDW+oC3rCY6JB4GB9It3+2kXOIB1a9XvM3vfSWRfOsjEUqIre8N9fh2kREc
 iX5RW5C79Iid3obszW2rx0KPgHMmAmthN4YhnikQahxR8ktvv9ZGrULT6MSvHGy90J
 j5tmR4vS/wDg0vYfBP16v6dX8tvy2RV8/Ec3fKwGCalJV+HecA3WcJPdjsxTSUEbvc
 /xeIQSaCd7EFGfy2i3cc2ywKr4//iLRD4goS2G3iGmY2F4IKtRShvtDC59EBVD0bme
 l8kVDZJsZ7awbiYe8V4m7AjH8SXdm6L7e27EZGVFuRCrwj+yhKPSnAhgAVLOKIKDRK
 bstzt+DlNPhCw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Tom Rini <trini@konsulko.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Benedikt Spranger <b.spranger@linutronix.de>, "Simon
 Glass" <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>
Subject: RE: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Topic: [PATCH] tiny-printf: Add support for upper case hex values
Thread-Index: AQHbmYJXS9LfVQSOoEantzWfxGK4yLN72G+AgAAkmwCAAAPYgIAAAUaAgAAZBTA=
Date: Thu, 20 Mar 2025 17:58:56 +0000
Message-ID: <b43b5a7016ed4fa08e934c294457b424@dh-electronics.com>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <513b3e03-72d6-4997-8fb7-ca5d8a530097@denx.de>
 <20250320141837.GP2640854@bill-the-cat>
In-Reply-To: <20250320141837.GP2640854@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

From: Tom Rini <trini@konsulko.com>
Sent: Thursday, March 20, 2025 3:19 PM
> On Thu, Mar 20, 2025 at 03:14:03PM +0100, Marek Vasut wrote:
> > On 3/20/25 3:00 PM, Quentin Schulz wrote:
> > > Hi Marek,
> > >
> > > On 3/20/25 12:49 PM, Marek Vasut wrote:
> > > > On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
> > > > > If tiny printf is used with 0x%08X (upper case X) the output is
> > > > > always 0x00000000. It could be confusing if upper case instead
> > > > > of lower case is used intentionally or accidentally because the
> > > > > actual value is not output. To avoid this confusion, tiny printf
> > > > > is extended to support also the formatting with %X.
> > > > >
> > > > > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics=
.com>
> > > > TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, a=
t
> > > > the expense of functionality. This is meant to be used in size
> > > > constrained environments, like the SPL. If you need full vsprintf()
> > > > formatting support, disable TINY_PRINTF in your config and use the
> > > > regular vsprintf() implementation.
> > >
> > > The issue is that disabling TINY_PRINTF may not be possible (size
> > > constraints) and some code is compiled for different stages and peopl=
e
> > > typically don't check whether the format used in printf is valid with
> > > tiny_printf. I've had this issue already in the past, I vaguely recal=
l
> > > "complaining" about it on IRC.
> > >
> > > Maybe there's something we can do to verify that the code is working =
how
> > > we expect it to work, regardless of tiny_printf/full printf selection=
?
> > > checkpatch or a compile-time check for the formats maybe?
> > >
> > > But yeah, essentially the whole thing is... if we continue like this,
> > > we'll just end up getting closer and closer to the full printf which =
is
> > > not something we want :)
> > Shall we maybe patch tiny printf to print '?' on unsupported formatting
> > characters, or outright complain that users should fix their code ?
>=20
> This sounds good to me, adding ? in the output.
>=20
> > For the %x/%X thing, we could technically fall back from %X to %x , whi=
ch
> > would do the printing with minimum footprint increase, albeit slightly
> > malformed:
>=20
> There's 109 hits on "%X" and another 489 on "%0.X", so I think it's
> reasonable to do either of:
> - Misprint A-F as a-f (in other words, treat it like 'x'
> - Audit the callers and change them to 'x' from 'X'. We normally don't
>   capitalize the output and there's all sorts of patches over the years
>   changing them to lowercase in other places.
>=20
> We have done both for other format specifiers and tiny-printf before in
> the past.

If we taking about adding feature, I think that the patch don't really
add a new feature, it's just a variant of %x. I reuse part of the %x code.
So if size matters here the size of the object file (not stripped):

Before:
-rw-r--r-- 1 developer developer 19340 Mar 20 15:32 tiny-printf.o

After with current patch:
-rw-r--r-- 1 developer developer 21212 Mar 20 15:38 tiny-printf.o
=3D> Diff: 1872 Bytes (+9,67%)

I have another patch, where I don't introduce two new function and
don't use an enum. Then it looks like this:
-rw-r--r-- 1 developer developer 19888 Mar 20 16:53 tiny-printf.o
=3D> Diff: 548 Bytes (+2,83%)

Would this increase in size be OK for %X?
So there will be no misprint.

Otherwise, a misprint for %X would be fine with me, because I still
get the correct value.


Regards
Christoph
