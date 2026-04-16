Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CBDF8E498
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 00:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC6C841C8;
	Fri, 17 Apr 2026 02:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gq+Fog6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6586883EEF; Fri, 17 Apr 2026 02:00:15 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D713D841C8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 02:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso18638466b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776384009; cv=none;
 d=google.com; s=arc-20240605;
 b=N+wfGLSCPdG3FJaWPy+T6B1Yz5CXFsj4FZBAEhtw0tvAqMKz6blKgPRcscwZzfXtFG
 lVROrnACvdJCL7fjWtCqVxfE/gnOEY9sbIhH5C1uxGYOWGuG1SOkQCBpnbNzYLBGRU+X
 Oayl1qoI+8Y2yMRSPtmB/k7Ftwwc9rLm+GK4iCXhxDsLaMfo1yvzBRzg/0rxeyEwEESL
 F99hz1bu+tVdlm3a0NgQvg4UB2yuhgYJVjkxAfGdeqBewQ1YaAjvLwNW4LRSg5wa8Uq3
 TbiCHtiG0oTY3J8136lDjkATqAfAYWJ95M6ZIwI4Mocx1J/aH0NU2eMcs/DUtXZ4Dlds
 aYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rnt0WZthPmdMDULykt2Ki8VRtuLJgwW+AD4ooRdQANg=;
 fh=l/TNieQ0pgOAlCvjziz5ptgBYiorGf6L+HzRHNcZRV4=;
 b=B2dqgJfdm8Eo6brHxvTINEKC9nXhLNfHrmn1ZIlCKh2DNT63O5G1+buOgXC5jJPOrt
 LgO3xyLrxA0Lp6dREc8gsR4Un0PLv9x+LvWPqMhWQ3kAPqhkhEU8uV9dsF3hFOViDgvz
 3CeSxAs0PkZhQx4l17rA7U3HiU47/bpta+BKExYkJ1mb/Bd/1nEWSs74+RimXmPihawi
 A4SJMB4kM6WkV/Tu5rJchr/obNbo0VrrPpKs+4LVJO2ayMLjsNLS74GsT9KCfc0WdukL
 qWnskfWlO3Edlogbd1N+aSp1yBzUPBS25cgGRq9OzNHNApSLqZBrbJqx/TL10ndLFLHw
 APGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776384009; x=1776988809; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rnt0WZthPmdMDULykt2Ki8VRtuLJgwW+AD4ooRdQANg=;
 b=gq+Fog6FATj2kEXwr7k9CPEf0g0z2Na6kVyG1gJTxLGs1XVotQWgJBBTKDi36pr1rJ
 sk9ZXqk6U58DvsUL5J+XKBMU6HSNdJpW/3zQ0BaVhB7RXqnT6aWP3MJNoztPGh+pAKra
 zseR8uBvZ23apHrZkxJUpwHDbqGdxDHK2bRI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776384009; x=1776988809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rnt0WZthPmdMDULykt2Ki8VRtuLJgwW+AD4ooRdQANg=;
 b=DG6Vhi3rvvZh+FK53vMfd3vTGVEkzq6fwRjKKSLSv6YNsYNonW7CWoI5CoIulqs8q/
 F4S0tnvPxoGsw96uXpFNHVsnuyW4+zGtipCuH7q2XdL1eK1tHmHdLeFARX9umzQNmGLM
 1torG4f1zUmdtp4kozz+swFtqBGXLB3OfP29BK9rmNekW/Z0CeezIdQqZQZ0tmbGqk09
 OqCdH14CkTWxWMvvT9qjG0LnIbaZ7jeRJpBROKyoqILunDD5/RFBNfT4Okbkc1bL3jER
 GCdejvbQW2IkCGBkIA2UUdnRm6oxT/W+mf283WgpQupYB5mP6OYwtyWy9jUM14kAE188
 F/FA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5/HORTQ978ojzB3w4Z+b+K7mpSHEo7VNMn+fBxfc+/wwgGfGGPgYpeerbjv/slFQQggy2Zy4=@lists.denx.de
X-Gm-Message-State: AOJu0YxPl+ejVMH+HdfcpfmIB4Sz/vMjV2oT7w95tSsKsPqclRnoSi/S
 4zjLy3QjZ924iMaI54mW17bhmK35Y0BtjJJf2kA6IoZSpqfPblaI7bVbxttv4sbbtZfW0ZWFFcm
 kOyV7agnul5AJei6VIZduhJSuMFcmINtBO+sAojo4
X-Gm-Gg: AeBDiet9JBh4pVkB/+4nTGHr6xDv4C/tX/qsWMikiJhMeFNTGoED3MQLAh6nHocyBu+
 on6h3EOrR1w8QzqC8bC2VqnIlwC94MJfqaENMqJUJ4uQcVqEAV3q+3m39eGB7RiIE3pZHZMD5+o
 hZMGEi04LoG97f1WEDgrIkWQAlJp7BTow7Ed7FMFYuouN59ntd5AaRJCRRaqY0V8qKPxSmM9hk4
 2h+H5hXrEK6f22yQlB5A+zdqUe6t3egBkMR+efWOhyJj6ZXFRcKc3rZozMseOR/Oo0310sxHdmq
 JvyiJL61AC79Y/5n1eJP
X-Received: by 2002:a17:906:dc89:b0:ba2:da52:66a5 with SMTP id
 a640c23a62f3a-ba418b7e6d7mr28195466b.18.1776384009143; Thu, 16 Apr 2026
 17:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <9ceb70fcad4dec6efae1b03297f38665926b6c9f.1776302806.git.daniel@makrotopia.org>
 <CAFLszThhPE9SPOHhjcukPUDsg4Yf+GtPhVWeHdsnKCQE1ysOSg@mail.gmail.com>
 <aeFppbCsfKNDTWuC@makrotopia.org>
In-Reply-To: <aeFppbCsfKNDTWuC@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 11:59:54 +1200
X-Gm-Features: AQROBzCKKm56WLFx6hFz3iVkJNnOgTGf6-V3mS96lDMUsZqyc9wNHszwl116p8A
Message-ID: <CAFLszTgSKdVA7BynWJ3cGxZiCQbBaq2cwLTAm9hRpj4gHs1uyQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] test: py: add mkimage dm-verity round-trip test
To: Daniel Golle <daniel@makrotopia.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
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

Hi Daniel,

On Fri, 17 Apr 2026 at 10:58, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Fri, Apr 17, 2026 at 07:36:17AM +1200, Simon Glass wrote:
> > Hi Daniel,
> >
> > On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> > > test: py: add mkimage dm-verity round-trip test
> > >
> > > Add test/py/tests/test_fit_verity.py with two tests.
> > >
> > > Both tests are skipped if veritysetup is not installed on the host.
> > >
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > >
> > > test/py/tests/test_fit_verity.py | 153 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 153 insertions(+)
> >
> > > diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> > > @@ -0,0 +1,153 @@
> > > +import struct
> >
> > The struct import seems to be unused.
> >
> > > diff --git a/test/py/tests/test_fit_verity.py b/test/py/tests/test_fit_verity.py
> > > @@ -0,0 +1,153 @@
> > > +def have_veritysetup():
> > > +    return shutil.which('veritysetup') is not None
> > > +
> > > +
> > > +@pytest.mark.requiredtool('dtc')
> > > +@pytest.mark.requiredtool('fdtget')
> > > +@pytest.mark.skipif(not have_veritysetup(),
> > > +                    reason='veritysetup not installed')
> > > +def test_mkimage_verity(ubman):
> >
> > The test infrastructure supports
> > @pytest.mark.requiredtool('veritysetup') which handles the skip
> > message consistently. That also means you can drop the
> > have_veritysetup() helper.
>
> I have to admit that Python is not one of my strengths...
> I'll try to figure it out and address this in v3.

Me neither, despite having written quite a bit of it. Let me know if
you need help with any of it.

Regards,
Simon
