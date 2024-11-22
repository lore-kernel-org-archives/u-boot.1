Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13EE69180
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 16:35:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 826778985E;
	Fri, 22 Nov 2024 17:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SCwg2BAf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D9789836; Fri, 22 Nov 2024 17:35:43 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E8A8985E
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 17:35:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF8E76000C;
 Fri, 22 Nov 2024 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1732293340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkjFm9t6bsR3XFclAEOslQ+fCkEjx22t9tNa9Rt/XQg=;
 b=SCwg2BAf5/s8b0rctZmvI7Co88luWIXO+fsI5p0GfC7tXGp/AMOL8PNn/mdNDJPoestibI
 +Gdqr842dJ+hWgbWqSa2Qd8fWLgf+b+yic5WLPJIzoHzJNz4r42B8wSXoL1m93u1pv+vzU
 nJiwthHsivvsDKltNWvSPFxhC6GN51XYBP8iz43OCPTpqnDsexMERjtQqyccBQuE7kBsiU
 15mPpDHYHGkQCdTbjHKXCsi7DPY6FcrhnYE+5Y6GAb0RJ3bWxcRWHrGuyFlPWrFII7WE+n
 YdKIeFH9nxTJTCkYPQknwBzUpwn4NSY2W0GOZpqnyXKY7CN3Tlxp5evvYsg2IQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>,  Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 5/8] imx: power-domain: Add support for the MEDIAMIX
 control block
In-Reply-To: <CAOMZO5DSjFw3skT=My_R64gAVcRdb5JQ+LHo3vgiOkdCYXXtpw@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 12 Sep 2024 09:40:32 -0300")
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
 <20240910101344.110633-6-miquel.raynal@bootlin.com>
 <CAOMZO5DSjFw3skT=My_R64gAVcRdb5JQ+LHo3vgiOkdCYXXtpw@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 22 Nov 2024 17:35:39 +0100
Message-ID: <87serjns4k.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Fabio,

First, sorry for the delay and thanks a lot for the review.

On 12/09/2024 at 09:40:32 -03, Fabio Estevam <festevam@gmail.com> wrote:

> On Tue, Sep 10, 2024 at 7:21=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>
>> +       /* Make sure bus domain is awake */
>> +       ret =3D power_domain_on(&priv->pd_bus);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Put devices into reset */
>> +       clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
>> +
>> +       /* Enable upstream clocks */
>> +       ret =3D clk_enable(&priv->clk_apb);
>> +       if (ret)
>> +               goto dis_bus_pd;
>> +
>> +       ret =3D clk_enable(&priv->clk_axi);
>> +       if (ret)
>> +               goto dis_bus_pd;
>> +
>> +       /* Enable blk-ctrl clock to allow reset to propagate */
>> +       ret =3D clk_enable(clk);
>> +       if (ret)
>> +               goto dis_bus_pd;
>> +       setbits_le32(priv->base + BLK_CLK_EN, reset);
>> +
>> +       /* Power up upstream GPC domain */
>> +       ret =3D power_domain_on(domain);
>> +       if (ret)
>> +               goto dis_bus_pd;
>
> The previously enabled clocks should be disabled on the error paths.

That's right, I will.

> Could you use clk_enable_bulk()?

This not very convenient and not future-proof, because, while we just
want to grab and enable the apb and axi clocks, the media_disp1_pix and
media_disp2_pix will be used depending on the configuration. For not
I've not included support for media_disp1_pix because I do not use it
and cannot test it, but it is a legitimate addition that someone will
soon or later want to bring. Hence I believe using the _bulk() helper is
not really appropriate in this case.

Thanks!
Miqu=C3=A8l
