Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95E1FD8770
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E298432E;
	Tue, 17 Mar 2026 15:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SOtNnaNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FE18432F; Tue, 17 Mar 2026 15:02:25 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1718F8432A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-41708f6c3feso3713018fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773756140; x=1774360940; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N6zmpU37Fjbrhb86c74iiAJ3YVCDvnHv7eBNrFVBKXY=;
 b=SOtNnaNvkciRKHhj/uGXKq7tS1SowZPXY6ejeGh+/5UF0DWWP2ioMdNZtL9jqNEs52
 RLaeZjHTyKTC15NfZjhtjSQM5ik+tGViWI50BsTBN7xRSmoTPv+797NDNLAakmJhxYgi
 yDuNWUhn1O9ooLP6N7jpy3+UEKZ9nzhCEgyh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756140; x=1774360940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6zmpU37Fjbrhb86c74iiAJ3YVCDvnHv7eBNrFVBKXY=;
 b=m4tlN2VaVeD83rsto2TSkn9CUPjmD0DvkUWUt8MS/ADcEBaaGQN94FY9B9dNyMZdiR
 RbjOhCc4CnT8Z4/PGhQDRaTgw1D5AEVV/62WTLIYk3kP2asvRZCnFZkm1X85cqRyUGBp
 AwMDgK+gdax4NIchtl6MdBYliXwIWzOqatUKHsq0UxPzQg/+NEaOuFPiog93ovJtvRsz
 QFFs2EkjnwdH5N62rviiVuVOmuNfy9uKJK6ApGn5gsZ9kV+d8ndqaK923fjLnbKpYdeA
 tIeVNuL7rv9CqtjfRN8kvqQGTSMfj/MvsvKzoHtrV9D2eXqqLE2P70Upr9gJZn7rEkLC
 6Fgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI9GYb0vWnSzVopOrDK1JG1W1DuX0IvzxV4gNwLjIkjC18bH7LUyzc39kRRUHWabT+DPSz5ws=@lists.denx.de
X-Gm-Message-State: AOJu0YxjHO5tbL7A+rPpOzhtHGTcCPAgtXJ8Lh33Ig6HadEuU7kQzXTq
 jKKGz+s35O9KG9XACpCia7h9KQYlTIL8gI8sFKiXLMkz9EY6ZQtjFu+BZ9Kk2ofgfcw=
X-Gm-Gg: ATEYQzxts6nSeycMrKGEFPk2FFHP/544GrXAbaY5pYsrPKfnHrTCtqAnX8Ne2ww1zco
 kxCu4uqolnsmuANHI2sYEa3O2GLKTPm/1s/vicBHT5s8JGEuTjVp2QXk5JsRIs1WcpVkJBGBypa
 4vYioUSHKQEOEoaZPbvFMyuW1J+HJFNbjjS+Jo7DU5Bxb4wnto1BX/t5mp6p6mJC+mIVOU2e5Sb
 y9JeG3LcoWhT+ivb9Yywz+j8jdb9YpabkAaSXuZttWgJUJVBkzrgx2haSRrIY/qBCOjbv1XVtxh
 y/kd1CaeswHtl8CrvDLsZ1dbIkIBOlIzrDFwcNbiSEscUvHBnxOOI9BkFgyzltGcwQt8tey8ODk
 6UZVsXgE7EW9IVe/r4Sh6Vi+IcpRBFvb+kzyXSCTLqjJai0hjPyNFZK4dzgQhKPKUMY53QiMVrp
 nHw+qPTdn1/e6xfgyHO4KWBFsQwqIeMS75UIhtzB97wu75lX+7lb8o4GBodZH63fBGyWB87BjGG
 eEhcmTtfrDAC17L7o7UtRX+e7ET9YxRkWadJBSx+4ZbfOny
X-Received: by 2002:a05:6870:a903:b0:417:6c45:b92e with SMTP id
 586e51a60fabf-417b91bfc2fmr9769299fac.19.1773756139865; 
 Tue, 17 Mar 2026 07:02:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e25f037sm19108828fac.5.2026.03.17.07.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 07:02:19 -0700 (PDT)
Date: Tue, 17 Mar 2026 08:02:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, macpaul.lin@mediatek.com
Subject: Re: [PATCH] scsi: Fix oversized data length in scsi_inquiry()
Message-ID: <20260317140216.GW502704@bill-the-cat>
References: <20260316-scsi-inquiry-len-v1-1-a8176ee6620d@flipper.net>
 <CAKTNdwEf+jx4sZ3TVMYR4ZWL0a-=UOUP1r4HgKKtw=3PDkxORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3qIJt8gjLWNGfX6I"
Content-Disposition: inline
In-Reply-To: <CAKTNdwEf+jx4sZ3TVMYR4ZWL0a-=UOUP1r4HgKKtw=3PDkxORw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--3qIJt8gjLWNGfX6I
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 04:38:29PM +0400, Alexey Charkov wrote:
> On Mon, Mar 16, 2026 at 8:42=E2=80=AFPM Alexey Charkov <alchark@flipper.n=
et> wrote:
> >
> > scsi_detect_dev() sets the inquiry data length to 512, but
> > scsi_setup_inquiry() only sets the command up with a 255 byte length.
> >
> > This causes some SCSI devices such as the Foresee FEUDNN064G-C2G07 UFS
> > chip to fail to respond to the inquiry command, preventing its detectio=
n.
> >
> > Set the data length to the size of the scsi_inquiry_resp structure, whi=
ch
> > is the maximum amount of data that scsi_setup_inquiry() will request.
> >
> > Fixes: 570712f4bcc4 ("scsi: Extract device detection algorithm")
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/scsi/scsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> > index 8fe6b38a8c74..6a3a91b1d32b 100644
> > --- a/drivers/scsi/scsi.c
> > +++ b/drivers/scsi/scsi.c
> > @@ -513,7 +513,7 @@ static int scsi_detect_dev(struct udevice *dev, int=
 target, int lun,
> >         pccb->target =3D target;
> >         pccb->lun =3D lun;
> >         pccb->pdata =3D tempbuff;
> > -       pccb->datalen =3D 512;
> > +       pccb->datalen =3D sizeof(struct scsi_inquiry_resp);
> >         pccb->dma_dir =3D DMA_FROM_DEVICE;
> >         scsi_setup_inquiry(pccb);
> >         if (scsi_exec(dev, pccb)) {
> >
> > ---
>=20
> I noticed that Tom applied a patch by Macpaul Lin [1] which does
> pretty much the same thing, which had already been reviewed and which
> I haven't noticed before submitting mine (it landed in next nearly
> simultaneously with me sending this out).
>=20
> FWIW, I can confirm that Macpaul Lin's patch also fixes the issue I
> had with my Foresee FEUDNN064G-C2G07 UFS chip, so my patch here can be
> dropped.

Thanks for the update!

--=20
Tom

--3qIJt8gjLWNGfX6I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCable5QAKCRAr4qD1Cr/k
ClDTAQCSd4DCrohVQveOaica477luQGgZ882XV/vT02CEjqOxgEAoej9U85XQAUs
j15jHaaSyjJlPVceEtDEZvxA0mnaPgg=
=4sqO
-----END PGP SIGNATURE-----

--3qIJt8gjLWNGfX6I--
