Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E0CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B635E80E9B;
	Sun, 11 Oct 2026 14:39:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZyMZqkBZZRNy; Sun, 11 Oct 2026 14:39:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2248880E75
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729583;
	b=hh9wKva5k/w0RRAwcRk7v9hyXifwx0D03m6Im1Vni9thA/J/stVm5GiNcIiwqzPkqQtW
	 H3vMRSn38/4cdCe6cJnHh9yNge4uIqcox0B5te2HPYBygYKO8vnmdpyP9RF1VvLS7ye61
	 Rheb0GadU4HCcc99wM5qdpJ8UOk/Y7VhtE3AERqassH3OhZbZxvCtcfNpwtfUruJuFDcz
	 +fkWrB0pB3N5e1R0m9dg5bXoj37/BIZONQ99q5q8NzMc+BpwrV18XPs17Uo4X9LLgsOJn
	 Kbmkym3kxGQ8TOLcz7o+fTofImBA6qMfZ6NJWQkCnIFj4Ty3fkbgFhejGpMIr3eG84g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729583;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=d0w33oINzPSgZY0riAP2JcGEdkPRDGg5nH4LtSR37Hs=;
	b=e1cVerrtOQxIfTE+Wa1QJb79fyn0IBXPSoYNB+qkfDQTDybXEtKoGNG8hoHy6+FZ8tkJ
	 TzuRtjOk9sTqgmknKOQp99ecl0rrFazeMLuycVkdRqwAyM4L4iKKGxkXaAskZtZGnNgCY
	 6s2TZk2/Zo+eC2xdb8HMgdR4bsnhlo0/gO++ZqqkqsS58hvn/tFcyaLOkHsjdVJLhkyIZ
	 GbiTCA4KiZw3h7B7VIJk96kfjifq4C47etA55fMgsWl6U1aXdkh6J4SiezfYRGfJRHLGx
	 m2QRn1rZebc9dnPG8ysy0UyfU++mD7XDQxsT2Jik068343JjvOtwQz6h4deGUc3FQ3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729583;
	bh=d0w33oINzPSgZY0riAP2JcGEdkPRDGg5nH4LtSR37Hs=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/mmWRjgM1GVkLwq1JngNxJSf2AF4XGms2C1EMkcP5o/OCc6EM8ezIJtDXHojOF1M
	 GUFfNWsgCy8E/55dCD3SDMZ/wptEFVsEQu3Py0JcOo/aeU29qbcKB7IbqNc0d+4JAl
	 e+0ia+VcC9Ia2ObBbI/C2g40mCxHxxLwBN4CeN7Bjtno1UJiZu1qER3j0ZnOrdQa5r
	 UHnca+78L16YoWE/cwu9mQeoz2CbxZFz+oRJs6SDcgpvOJLYlPrvrSBi7tsuAKb4I/
	 Zd5m651x7ZoLmznKH9WMiDnSGn+8qTDNdCe/j7bZ3u4R5+uS/Uc1Z4Ejh5C8Rm7h5E
	 nIghZYCgWmLdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2248880E75;
	Sun, 11 Oct 2026 14:39:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 16E1075
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F162D40071
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:17:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLpZkMpC9oQr for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 62D244002B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.70.43.27
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724665;
 b=B9N9+DUnBjGBi2Vy11O4JQsc/TYgbk6Q2rP9yZkqfVVtarkbD+vR1KqXFPyz/FiIUFrV
 UVSROKr9igeZKzDmFjg2iyZhr/b6ftgTTWpx71FreCm1TRYXFsaSkOJg2XVbblQlribX+
 aMmCvInhdW7qFnGZcUcx25r7+0hsyV7BkhjxzGyq5BqzJcuuyA6qzL4Lsy5dqdm5WrSW2
 1TalDg+XQIIOdN4A+YqvGifqok+o+c+9ZLJjJ8us+EZoWtT36KuIsF2fVmCkH11CYv0Pd
 CpFzzeuMjV1xTWHXslre+zv4VQ9oHJSpYxUQyAzizlRjilWVRwPzcF7qVMJWjpB0+dw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724665;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=d0w33oINzPSgZY0riAP2JcGEdkPRDGg5nH4LtSR37Hs=;
 b=ZoDyt1c9Wjvpv7HX5nMRgVQT18+7YfIJUsMKAWGAIJ6Gmx/xouYUPrL9NH0uFJw7PQov
 D689VDZ4JUenLfLHBM4pI9Rt3P0nFyDnp8DN1bCqTnWwwgEekwbpTUG3p2KyTexXNNoG7
 ILwyXmhiIkMHh34mAOLFFYcPA0MKssWVatZZZeYXaCKegmI6QEArz+Uy0sqk5VnQ+b0Y9
 Iufr3U+Hc6XG2fUyojvHZ1g1WD2WAp54NfOdx2BNNEiZN42qJ32VI937qoEksjSPtVCjK
 AQBOSBwveCPwpg/TInT/hFWNDBchD9mvNpnp6QTu9vGySlcg6dOyRZqRMYYUo/5x9qA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=protonmail.com;
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=Y6Zn+4Cn; 
 arc=none smtp.remote-ip=185.70.43.27
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.27;
 helo=mail-4327.protonmail.ch; envelope-from=petr.hodina@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=Y6Zn+4Cn
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62D244002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791724619; x=1791983819;
 bh=d0w33oINzPSgZY0riAP2JcGEdkPRDGg5nH4LtSR37Hs=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Y6Zn+4CnqECf+Ds+yDnZ5SV6eUtWPqGy80weMaFibrApoiuXFbceNn+uiV92qVzMc
 UROhdS16DdwQEBGblJ3qOJIERuddlg+NJBYqba7mt+3sFinU6LITolxdl6ZLW5GTnB
 +WP1gk0Qn9jOvTfO+T6p+PYgTNF2Hw2/GtbhB3oORlyNF6j6iApU7EdrdG+qDR/ORN
 PTlQH4KLNMYiJLu8mwySnj0KatNIkwWNxgyroj/GKJLjIzMgWOCTVY/3Waqqes1O6W
 pRSsRe+jqZweNNJLWlPFeD60CBHlFxlfKB3aOUlGZbjyoOg+CRrMOHX3GsrlxPeJpN
 YRtORIDT65PFQ==
Date: Sun, 11 Oct 2026 13:16:52 +0000
To: Simon Glass <sjg@chromium.org>
From: phodina <petr.hodina@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>,
 Brian Sune <briansune@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>,
 David Heidelberg <david@ixit.cz>,
 =?utf-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Alexander Martinz <amartinz@shiftphones.com>
Subject: Re: [PATCH 00/11] cmd: phonemenu: phone form factor boot menu
Message-ID: <NlOWu7YfEood1y_dXWzpWRLsMbAPbeVaGxRJ2tfzoYVnA_cNMxZgfBlUX3nZMgiuOPjZanYAWFkYQjn14S487oMfoRpmTcAaiNKg7jcWf08=@protonmail.com>
In-Reply-To: <CAFLszTh_gxpXajGF0JawRpZduNcRX0_dunixZYF854fN7+7NAg@mail.gmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
 <CAFLszTh_gxpXajGF0JawRpZduNcRX0_dunixZYF854fN7+7NAg@mail.gmail.com>
Feedback-ID: 23468634:user:proton
X-Pm-Message-ID: 8c4d6163683401daa8152d54c6bc0cca7255c902
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


On Sunday, October 11th, 2026 at 10:31 AM, Simon Glass <sjg@chromium.org> w=
rote:

> Hi Petr,
>=20
> On Sat, 10 Oct 2026 at 23:32, Petr Hodina via B4 Relay
> <devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> >
> > Add a boot menu for devices with a framebuffer where the only inputs ar=
e
> > the volume and power buttons. The menu is SoC independent and SoC speci=
fic
> > parts hook in through weak functions. Qualcomm implementation is provid=
ed
> > in the patch set.
> >
> > 1. Add helpers for several commands. dfu_pwr is needed because
> >    the stock dfu loop only exits on Ctrl-C which a phone doesn't have.
> >
> > 2. The core for the menu which reuses bootmenu_loop() for navigation
> >    so any board that maps its buttons to keys (BUTTON_REMAP_PHONE_KEYS)
> >    works unchanged.
> >
> > 3. Phones often have no usable display during bring-up, or are driven
> >    from a host so the same menu is also drawn with ANSI escapes.
> >
> > 4. Not specific to the menu: Qualcomm keeps A/B state in the GPT
> >    attribute flags, not in "misc", so ab_select_slot() is wrong there.
> >
> > 5. Generic header info for the slot lookup which is a weak hook and
> >    the block device comes from the "storage" env var.
> >
> > 6. The Snapdragon override of that hook kept out of the generic file.
> >
> > 7. Shows why the device booted (e.g. recovery, fastboot). Reads the BCB
> >    from the "storage" device.
> >
> > 8. PMIC reister layout QPNP-PON specific for PM660 to decode the boot r=
eason.
> >
> > 9. The USB ACM stdio device can be listed before it has been started
> >     and puts() then dereferences NULL private data.
> >
> > 10. The weak default picks "mmc" from Kconfig, so on UFS boards
> >     "fastboot reboot bootloader" could never write the BCB.
> >
> > 11. Usage documentation for the commands above.
> >
> > Here's the URL with image of the menu on blueline, sargo and enchilada:
> > https://download.ixit.cz/u-boot.png
> >
> > Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> > ---
> > Petr Hodina (11):
> >       cmd: phone_util: add poweroff, dfu_pwr and USB Ethernet commands
> >       cmd: phonemenu: pixel drawn boot menu rendering and navigation
> >       cmd: phonemenu: mirror the menu to byte-stream consoles
> >       boot: android_ab: read the A/B slot from the GPT on Snapdragon
> >       cmd: phonemenu: show active A/B slot in the header
> >       cmd: phonemenu: read the A/B slot on Snapdragon without "misc"
> >       cmd: phonemenu: show Android boot reason in the header
> >       cmd: phonemenu: show PMIC PON status in the header
> >       usb: gadget: f_acm: check the acm_stdio_puts() against an unstart=
ed device
> >       cmd: phone_util: fix "Cannot set reboot flag" on fastboot reboot
> >       doc: usage: add phonemenu command documentation
> >
> >  MAINTAINERS                 |   5 +
> >  boot/android_ab.c           |  42 ++++
> >  cmd/Kconfig                 |  11 +
> >  cmd/Makefile                |   1 +
> >  cmd/phone_util.c            | 148 ++++++++++++
> >  cmd/phonemenu.c             | 550 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  cmd/phonemenu_qcom.c        | 112 +++++++++
> >  doc/usage/cmd/phonemenu.rst |  92 ++++++++
> >  drivers/usb/gadget/f_acm.c  |   3 +
> >  include/phonemenu.h         |  17 ++
> >  10 files changed, 981 insertions(+)
>=20
> We have expo - rather than duplicating the video output, etc. could we us=
e that?
>=20
> https://docs.u-boot-project.org/en/latest/develop/expo.html
>=20
> There is also a boot menu which uses it.
>=20

Hi Simon,

thanks to pointing to the expo. Yeah seems as the right way to implement th=
e menu for phones. Will refactor the code and send v2.

Petr
