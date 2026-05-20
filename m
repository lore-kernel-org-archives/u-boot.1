Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D454CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFE9847E1;
	Wed, 20 May 2026 22:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oKlnfQ2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEFB084839; Wed, 20 May 2026 22:43:57 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52DC846BD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd8d0e4e341so682986966b.0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309835; cv=none;
 d=google.com; s=arc-20240605;
 b=DbdpHtCO0cnyAfnsfiVBK2z6HX8+mYaqvc39bsOL9sX3+Wl7xy1XsEoTmc1knv97+S
 nzXnpD1iFvs9VZ8cN4Tenc48tweObyLWNYxxfLP0YmNg9r/9teKLG7f64KIwufcwNpFw
 1pZX+j93F4jOwEjwMBVac9BMzbh0ilq2w9kjc96+nktKEWNsQn7vUSg0c+LUfkoGp+Tj
 W7hkdtBK2QeMlVBF3ixuOZb+EifTt97GMzLnFoZ70BiKCh9xRQP0KjRykBnCe26niayI
 SkZ/r4gfBIDRs3l8ooAzVCpPp2pl6vNfdAjifrc2EpUUAva5te2x6YKKzg5uj9rokKqN
 JFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n6aLvW7ikaHJVyTjhAqm1JfhhYGeBAeoso5eM9sfQXE=;
 fh=kPRuukshMyHIjtZhsdqNw9YWlQDMhnyt2iGH6oJ2C0g=;
 b=eRwoXr4TxsaSfwVRMGIIUxzV55L282t3caXe4DuAaSNr3oBbI/OBjUW7W0Q36VtlO4
 rx/0r+4nZxnXS9/9DyC3n/Giu3cSPuoYTTJTmyM3DKNJBm7MCkISELrj4/5N9G6O+IUZ
 U44wm19/soaYqyrhCoXSOfnp66bm5gkjqjUGk9FsVRgZ2TNe/3xAeZlzcFrOk0V7vfAM
 372j9zJW6JHLS5wKkk0IRD2BLQfMoTGXlVDXeCfVSTFeWT/2DN3nkLYjuVKzDY9eXmzq
 iCgHMRVqeYzUHfAkfeL11RB/TelVEsYwl7fZQyD3WiXC1Blv0TZBfS50ne/EVflemjbl
 XJPw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309835; x=1779914635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n6aLvW7ikaHJVyTjhAqm1JfhhYGeBAeoso5eM9sfQXE=;
 b=oKlnfQ2dZ3VlZTH2fCC/Kpjjqze+2+HXt7hkp9ErYl2U3j6ogIpADWIjdV0zYrJgNd
 1R1gdV0xbR1BUbQuSZrFCMAHA7fiug3gB4OT5CghZT9Xmi+Sioqk/BdBrxdTkKDjm6ee
 h5Kby9U6GlsnMqx8SA2nPh06pYiIos7e4dVT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309835; x=1779914635;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6aLvW7ikaHJVyTjhAqm1JfhhYGeBAeoso5eM9sfQXE=;
 b=oztAwu+tErwECRlwa701U8NizBI9p+TZhfzv49hDvHc36fBh6h8xaguC6J7qhThCBD
 sURt7OfHovnXEGkupJsxqAOsCxkL1Lw8AgCdAVmQ3Rkn7yHoAyv0l20FM7gSxU3zuCTh
 2o2sSOse4zsYJ5FPIA+DDHqa+8qUnSyIa+Szx4KmFrDsGBiz/z8ZK4oT8CV3zRJ3mzxM
 EdhhSUI6Jfm2qI+VaVOuwMwX8M+QMqPca1Rh1w8vrVtBtOsBemCo534u8vfK6C/foGZ9
 VInsAtMrSoJ2Tdzy5fs9QaYGiMvMqqPs6+wcT/YRUR5spmB4vtW9LOcm0n/XMh84tBnu
 Qx8Q==
X-Gm-Message-State: AOJu0Yz3JvZSNrDQbTXyNVGodFAD0VTgv5VmGbdawuXJfvR/FV23efxv
 ASz33OjX1nG6lbHVPOnpGE2ZeGNBtAgIly/nhumJsA96a0lVfWAIsIX4E009R3UM5WRjcsw2LZz
 BpROPVlZaf8xf6Lu0EpqiuSCT4Z3Nqpxwfu8BzrNL
X-Gm-Gg: Acq92OFSvZ/JjH34YBlhQySdNVXqXlzDqCJP5tNDpZx6jKpidDliHUZ0ZP11oJ4ZfDU
 zkEhLco//9hMx6JTQ2ndIQ51k+JU7sdklEt9Z3aWnLGvVU1P3RK941Pqql81aPrBkccB+pDlwWM
 rR3yDWHik6K8vUVWQYP6KcvgnOEyS2HdSE6MLWCNIa7DfJzaYnCm2Y2fTUrsNizEJVXl4jDchOJ
 GA23+gW1vFjmO8Y589F5Raz4pxMlLs7A5C70rxNZG51RnO/TrGP/Mwlmvw5E5ZZ5yv7uTLQ0NLE
 OGTtJIQhi18rjArUcGWuq4g84tY=
X-Received: by 2002:a17:907:9801:b0:bd0:8e74:85a3 with SMTP id
 a640c23a62f3a-bd5178f9146mr1477898966b.26.1779309835124; Wed, 20 May 2026
 13:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260519233207.2765755-1-sjg@chromium.org>
 <20260520000630.GJ1858239@bill-the-cat>
In-Reply-To: <20260520000630.GJ1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:43:42 -0500
X-Gm-Features: AVHnY4JaD8ovgmPXevHKzFFABRaM6BaMPPYbZfBXWYgXdSKfE639aUEFP1jltHY
Message-ID: <CAFLszTj8gpSJftxZKrPcEFdP8sLno2fGCOYWu8YANVJML6618A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Tidy command option parsing and use it a bit
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Daniel Palmer <daniel@thingy.jp>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
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

Hi Tom,

On Tue, 19 May 2026 at 19:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 19, 2026 at 05:31:26PM -0600, Simon Glass wrote:
>
> > We have had getopt() for over five years but it is not much used. It is
> > much easier to understand arg-parsing using getopt() and it avoids
> > common errors. As the named maintainer I decided to look at how to make
> > more use of it.
> >
> > So this series explores the impact of converting a few commands to use
> > getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
> > anywhere in the cmdline and provides a few helpers to reduce
> > boilerplate.
> >
> > The chosen commands are:
> >
> > - echo: very simple with one flag and fixed ordering (worst case?)
> > - hash: fairly simple with just one flag
> > - env grep/export/import - fuller examples
> >
> > The series also adds a recommendation to use getopt() for new commands.
> >
> > To try to reduce the code-size increase, a lower-case function is added
> > and called from a few places. The difference is fairly marginal.
> >
> > v2 includes further attempts to reduce code size, by making reordering
> > a Kconfig option, dropping some printing and some intensive optimisation
> > of the env commands.
>
> Let us return to the comments from v1 again:
> https://lore.kernel.org/u-boot/20260515203311.2555651-1-sjg@chromium.org/
>
> Sean was saying that nvedit should be a best case for the conversion. In
> v1, grep was no change and "export and import" was 164 bytes on "qcom",
> which I chose because it already enabled GETOPT. Let us now look at v2.
> Here, grep, export and import are three commits:
> 10: cmd: nvedit: Use getopt() in env grep
> 11: cmd: nvedit: Use getopt() in env export
>    aarch64:  w+   qcom
> +(qcom)   636 |         char    buf[32];
> +(qcom)       |                 ^~~
> w+(qcom) cmd/nvedit.c: In function 'do_env_export':
> w+(qcom) cmd/nvedit.c:636:17: warning: unused variable 'buf' [-Wunused-variable]
>    aarch64: (for 1/1 boards) all +4.0 data +16.0 rodata -12.0
>             qcom           : all +4 data +16 rodata -12
>                u-boot: add: 0/0, grow: 0/-1 bytes: 0/-32 (-32)
>                  function                                   old     new   delta
>                  do_env_export                              608     576     -32
> 12: cmd: nvedit: Use getopt() in env import
>    aarch64: (for 1/1 boards) all +1.0 data +56.0 rodata -55.0
>             qcom           : all +1 data +56 rodata -55
>                u-boot: add: 0/0, grow: 1/0 bytes: 100/0 (100)
>                  function                                   old     new   delta
>                  do_env_import                              692     792    +100
>
> So grep is unchanged, export is a small reduction but import is growing,
> but less.
>
> My feedback is this. If you are going to bother with RFC v3, please just
> limit it to converting nvedit and showcasing that it's an improvement to
> convert. And if it's not, as Sean said in v1 we might need to revisit
> the interface.

It is an improvement in terms of the interface, but not really in code
size. I've fiddled with it quite a bit - I'm not saying it can't be
done but if you look at the code you can see that it is similar before
and after.

Any thoughts on this point?:

"One option would be to make the getopt_init_state() in command.c and
pass struct getopt_state to the commands. This would reduce code size
at each size, but obviously requires a different command signature,
unless a global is used."

We could do it piecemeal, i.e. cmd by cmd. Removing the init call and
passing gs instead of argc/v would improve things.

Regards,
Simon
