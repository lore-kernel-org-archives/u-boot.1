Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFC3C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 11:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E2C882AF;
	Mon, 27 May 2024 13:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WoxiNHpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F36882E2; Mon, 27 May 2024 13:48:08 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFB487F52
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 13:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B3F6240002;
 Mon, 27 May 2024 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716810485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8XH0sw0bMUSi0XPIfmWpBvlMKRPZ4NyfuamHAvUFnU=;
 b=WoxiNHpeNLmFgvsEQOOg3HztoHUoFj5hi4YNSOm09LSPrwk5G7hxIoRlj0FQAwXJ+bDoB+
 Wle75IETWZPMrlLZ32u6vW3fSykFUs7ysJal0Q7j+4TcxDQTElpnGsl/3mhI5pFHyGlYYG
 K66807ahJlba+515qZqjMZi7BsXE4cFjwzoZz2M8dQwT+xGOo35Cyoi9PEaJtGeMG7bqwl
 +4s8ZmBLrv3nWsKf93Tggulwbtlyf0gvllqNpfd5qT96HnIT/l6/cS9ujwADt9hwzI1mQE
 C1UMcEX9CmMUjMozEWPf1wqyhGxE0KXsd8DiPDvtEGsei0CahWpIGyfhWJ8M0A==
Date: Mon, 27 May 2024 13:48:04 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, Jorge
 Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v5 2/2] tpm-v2: allow algorithm name to be configured
 for pcr_read and pcr_extend
Message-ID: <20240527134804.1bf788a8@xps-13>
In-Reply-To: <CAC_iWjKGijjMXoop2i97Rpc+ZzSWWb6Vbd9XxW9WKqvcRwJwhQ@mail.gmail.com>
References: <20240525200049.3904124-1-tharvey@gateworks.com>
 <20240525200049.3904124-2-tharvey@gateworks.com>
 <20240527105910.3bb425d1@xps-13>
 <CAC_iWjKGijjMXoop2i97Rpc+ZzSWWb6Vbd9XxW9WKqvcRwJwhQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Ilias,

ilias.apalodimas@linaro.org wrote on Mon, 27 May 2024 12:44:11 +0300:

> Hi Miquel
>=20
> On Mon, 27 May 2024 at 11:59, Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> >
> > Hi Tim,
> >
> > tharvey@gateworks.com wrote on Sat, 25 May 2024 13:00:49 -0700:
> > =20
> > > For pcr_read and pcr_extend commands allow the digest algorithm to be
> > > specified by an additional argument. If not specified it will default=
 to
> > > SHA256 for backwards compatibility.
> > >
> > > Additionally update test_tpm2.py for the changes in output in pcr_read
> > > which now shows the algo and algo length in the output.
> > >
> > > A follow-on to this could be to extend all PCR banks with the detected
> > > algo when the <digest_algo> argument is 'auto'.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> =20
> >
> > LGTM,
> >
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Thanks for taking the time, unfortunately I've already queued these
> for Tom and your r-b is missing

Maybe it's not a big deal to force push your branch? Otherwise please
consider letting a bit more time to the reviewers next time. 2 days
over the weekend is definitely not enough if you refuse to update your
branch.

Thanks,
Miqu=C3=A8l
