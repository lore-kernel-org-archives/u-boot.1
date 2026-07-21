Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A6C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 11:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8C5660611;
	Tue, 21 Jul 2026 11:36:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JOsf-iuvVUC; Tue, 21 Jul 2026 11:36:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C254E6062C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784633780;
	bh=tretGQGGPHfPshVu4T38kvP+YG2spWdAJ+f7egUzjl4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E0ZEIVxnXZBrfLNOSn6z7h9lvhaHQi+P8FFnpk6iZ+fi+NbY36CFo59AG+4jV/cTM
	 1iUocjJV2W6wqqrKQHtD/DpspOfMLUFGenZppO5FM0S7C7pikxsW5bfZhjIEvHY0mu
	 /i4w5A3ouxxYk+xhQGkJ92WDAf30L+v912+XlsISIkJMoyBfghfcW1Pz4EZm8EmQq0
	 7hTOLSmX/LxTGc/Zg4j0jEA2Kr8UDRNJToEI4s5BNaE3hpf9++XpRvG759HvMvcVhM
	 vXjI31KfP1eqso3gZTIdWD9gXu/8mVyKRiQ336hqyujj0TVzwlCsq/+CC7zcm2TKj2
	 JGMg0RftEeZ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C254E6062C;
	Tue, 21 Jul 2026 11:36:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDC19FCE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF59B400FE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2-j_NAAzvkLA for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 11:36:18 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=romain.gantois@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5AD66400D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AD66400D5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AD66400D5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 11:36:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CD084659; Tue, 21 Jul 2026 13:36:16 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEC4803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 13:36:13 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0A39B1A1135;
 Tue, 21 Jul 2026 11:36:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C7B5560368;
 Tue, 21 Jul 2026 11:36:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3EEEA11BD3A3F; 
 Tue, 21 Jul 2026 13:36:02 +0200 (CEST)
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
Date: Tue, 21 Jul 2026 13:35:57 +0200
Message-ID: <2l1ctkP4Ro2Q97CaOnt-yg@bootlin.com>
In-Reply-To: <CAFLszThwLCFR+HwhOVa69oGv7NTwcjXvHGtgbFsJ4kbPOweRFA@mail.gmail.com>
References: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
 <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
 <CAFLszThwLCFR+HwhOVa69oGv7NTwcjXvHGtgbFsJ4kbPOweRFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartyM2to9gQSFmVRKZm-G--gw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1784633771; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=toZtiiiSYU3FFfoTZciGefq7d7VUfHC8yyqQhsZ4O40=;
 b=MPDEZ4jQctDjLRWFPYfydqupEOKKDlgrjN1nRfpdssetkiuD9mMnpCeahgSHxsVm6VGHkW
 56M0F6uTj7R7CGo7qOmPkhUfwXoSh2UYwmJ7lk6Wig/atoYHZatB+KDOOCsAkDPa8NyA77
 k0ljzUZjWTEabmrdhtXxgI7ypdAKJkYAuL4W/6ebHeBzeZ6V8lvdVYwVMK4LQ/KQDgryGw
 yGo84Bn9E7ED3ptMipIcphaStz1qjTkdrNdPgsDXKR/zA918ELXTMiZPZYtgUEA7u4Yy9e
 YjnzFswftc3X1M+q41WRLUniZhwX+5vEAsPM6osBLzf7TjbPKE8tZMvkken0fA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=MPDEZ4jQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=romain.gantois@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MPDEZ4jQ"; 
 dkim-atps=neutral
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
From: Romain Gantois via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Romain Gantois <romain.gantois@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--nextPartyM2to9gQSFmVRKZm-G--gw
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Jul 2026 13:35:57 +0200
Message-ID: <2l1ctkP4Ro2Q97CaOnt-yg@bootlin.com>
In-Reply-To:  <CAFLszThwLCFR+HwhOVa69oGv7NTwcjXvHGtgbFsJ4kbPOweRFA@mail.gmail.com>
MIME-Version: 1.0

Hi Simon,

On Monday, 13 July 2026 15:10:48 CEST Simon Glass wrote:
> Hi Romain,
> 
...
> > diff --git a/drivers/usb/gadget/renesas_usbf.c
> > b/drivers/usb/gadget/renesas_usbf.c @@ -0,0 +1,3036 @@
> > +static int usbf_remove(struct udevice *dev)
> > +{
> > +     struct usbf_udc *udc = dev_get_priv(dev);
> > +
> > +     usb_del_gadget_udc(&udc->gadget);
> > +
> > +     return 0;
> > +}
> 
> Just to check - if the device is removed while the pull-up is still
> asserted, D+ stays driven and interrupts remain enabled at the EPC
> level. Would it be worth calling usbf_detach() here so remove() always
> leaves the hardware quiescent? What do you think?

Sorry for the late response, things have been a bit too busy :).

Sure, while the UDC core does call detach on the device, there are other code 
paths  which could call remove() directly, so it's probably better to call 
detach here just to be safe.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPartyM2to9gQSFmVRKZm-G--gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmpfWZ4ACgkQKCYAIARz
eA5/TQ/+KGbNZHq5+ylqrOlylJSF0oZ1yZvlesnUZ8oQWZ+NMn+Y7qBQCNvFokZN
wAH1MV75eKJjiTKEbx7EPU0CI2qu9eWjA9xMZD5BN0gTl5JTVjkaNLAYNDUduNGd
jfovkchn76hffdMVQgaSLQZrDYCEXIKfH3Nb33UU+IaxXzjS30QQutZBMyhYD68B
LtpftKFESqZ/Un2AUc3QgubFaaUp1RUtMHhqS3Dl94Uly/x4sClVwEHeHHZKFpR2
viDBDrngApxAiDcuxho5dU94EpiGDVwNAwrGrUjYRh04hGO8JJA/MZa7zcCeNtQ/
IhhdpoH3rqJr2I0de3+IkkpMgOXwWFag2qCdRMBVEuaF6nkZfVCACW3m8VN2gsc9
2TBDNhXK4qNBVyRDcoc5m4T64sJphEWVVXYytbqcFiHufd9jQoPKPLj6xO/2hlFN
vM/MRHZx4usNHQTbP5zLZqxyytmYy9fpPlkfmRWV1tyowKpyaddRs9r6x8AzdTi6
wdy7ISloWAGcgKEZiLzbKL/z40fGZXuSCrVQqwZcKIFOliQ56LH20k3SLqAUKARu
I6TihkKMvJXTkJqMbXc37kV/gAcuxgPnaoW2LPlILTbJLc5Cs51WmCeGLHI44LGu
a60ctgcru5dQYN+EKV8EUCIW8k3DeBuqH9IfPr34CZaUoF1U464=
=lUnu
-----END PGP SIGNATURE-----

--nextPartyM2to9gQSFmVRKZm-G--gw--



