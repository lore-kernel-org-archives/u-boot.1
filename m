Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6278C982C9
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 22:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C88680827;
	Wed, 16 Sep 2026 22:12:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5mPXES6gbl8N; Wed, 16 Sep 2026 22:12:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8FA3E80847
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789596758;
	b=q2zdPzNEY3TZ94gdQSsJmjNwZoqBw8Auv6a3wz4FS51sfq8oBOJTFDpZt6aFqb6+1K8Z
	 ysEw6YadRwrHoH5Wm7IXp2SaK4ajj829IUb7bzMsvwpI4ejdDPnu9bd3rpngKzPpacyFp
	 NdCaldBvXEXP9st4HCQfTf4f3c2fAkfyGKuRvk11aTm4lwmPXFHoVDi/5ncjZQBXfIzUb
	 x4Cm1BQjRK8MKhQEUu1//9NaGJ+SYjI8iu6I9aT4ryKNj7c9Xq/IUEo/aHoEEOU5zfI94
	 0BrKavnU7FHHO0rT3UckDZJ0A7HUwAeCI3B0aK/UPBY8TD7hcLFek5i6yewOPkJk2xQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789596758;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=G7Qmm5lNolUcLB32EK1eirQxyp7NjScJaw74cqDptw4=;
	b=eL8xfTT9msQTaZeW4oGhphCYxE/KU//Bi/cOmPqKXSHaIb3iWuM4pgIMhIb45ULsPMZM
	 88bTtczP2JeJGe6pRfG5+YXatkJI781mVMtVqwNkohQwz56nrAB2iGnK0d3aD6VnX3f9o
	 qTVGt74ItCavwcuvi8O4NmXfB/FMth9Zfkl+K2BH08ATmfXPznq4/ondN1+S1lQrtF7Wh
	 L8xGLBN56t6c8wKlEQWEt+byRPzMUH+s5KbGw/1+dKuSTjv7k7VO0I+jPy9y6p0jNe+xY
	 MuvxOD7h9YaPouYVyLf53T8nIJwKbOqwmuRFV9bgX7J0WtdlF5g7kmNJZ2KR9QYBh8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789596758;
	bh=G7Qmm5lNolUcLB32EK1eirQxyp7NjScJaw74cqDptw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfhkuD5Ffg+V2akrPyVlX7pukanCN+57kf5i4O9pmPOSweszYajx6wuTnncbwTw3g
	 4LqVX4hJ9gZ2ddBpZKhycMpqYmwf0NlVz9TEp7F3JfnxtlRvLOe/IxtsHxUpBcfMsA
	 TpkcM+GTNJ5b80GNA9Ep1IVAnMuHUrCGSAJA+fMoTr73iyKap5LtMOAwEG9l7W+i3B
	 WMiOPKVdRBuye9HtjDdrYxa8EBXSOFWQ8xgPohCWDrNZIcKi+sTqQPbv3i+bYT0GPr
	 /hNRylqPLO1Ubg802byc9VCisK2PrD6Ubj67Hnn8lfS5p1cNPPA6f1yto8pwqsf/Nt
	 wLxzKqsi7JnCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FA3E80847;
	Wed, 16 Sep 2026 22:12:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B1C13D
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6667640367
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:12:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LuSjSD2Xj5Zw for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 22:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8757D40343
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789596756;
 b=H8qDo/kJgy4a5/wum5+HIKbfF0S+0EkyhF0Vrc756RJIuqPM8PeT94MG69paphFCUYlg
 IKBcHOcOjt02dbcqm8s6upbc5gAGaa5mnGxvMpD7exnj1HG5ORwbDDSdMc20bGrYmPS5F
 jj40w9s0D4cx/0HjzajrV9nt+vAku8wVQL8G+QICqfj6QdcJvYQuYXQbGiwCX0+RvCrn8
 MiFrN79cHxJ6Tc3NPwrpp16dbPXKA7+5EVxKUYW3jyrc62Pza++A4PF6zpYVd5qH8IhRw
 F6xEz+AK/6omQU5GWMN3rUrnaNImwgF9I1noSIiVOrQT4KPSBTRRWFdD0qVhsbL135Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789596756;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=G7Qmm5lNolUcLB32EK1eirQxyp7NjScJaw74cqDptw4=;
 b=I/Y/iWgBj6W8Hn7Ph/7rk2vSYVeo6jZeZ/LFmIc7iJN1SsGS5xgCmfSuY03hB9v3FUW+
 pyiv6zPMVUS/SAX5LGfyCNIyAMO2Ib2eyQ/O+RkwEwAEmJkjRZNJUOudeYh0BQGqCrqFc
 MDnhdUd7+Lq9VviRwYCiZ6Uk5nXguFeq7fgOMJfMVJQ4mcBjXxgYLtzl66NtA1oe9w1Qj
 JqEfK388jdCFjZL35ZFb9SIPY+MN/NIZOkxncpWiNRN4/UtbftJjOflYfb+IUCnnAJqYQ
 VuHmD/s9uTMmu5OhuhGNSiiiMlSSYPig4xrUWLpQz9GurIg4HlRUeVBvgu5Oaq9ELvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LRImrVnq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LRImrVnq
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8757D40343
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 22:12:36 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bd42f1c01cso106320eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 15:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789596755; x=1790201555;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G7Qmm5lNolUcLB32EK1eirQxyp7NjScJaw74cqDptw4=;
 b=LRImrVnq+GBcYw5eI1aWY8ioaA7VWiqfAmDyLWHunGT+Mz2Lr/ZhIlaSGuh4hig3IM
 6vFWBpTdlTFCAaBvBEfAola0/om5uacAbzW4kTdC1HQKp9vKttqopaEpLzbusTIdA0gH
 6peDqVqEnPytRitsDo2Fmf5SVHZo0mHbN9m6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789596755; x=1790201555;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G7Qmm5lNolUcLB32EK1eirQxyp7NjScJaw74cqDptw4=;
 b=bxQxbExllSWB9MiZR5E0cEkso2iIn2sFyl0WCJ6vBINLmgW6bJ/N7/CEL7rz8OUfp0
 bvBlsUvKL9BnoTL16r90WpjqH3alvTe4v+vUVRauOTj6E2noWWQVb/V59etnFAFAZZKE
 6fG+ovbTFeScvREdLWEGutrDJu3Okb20/ZTByHYUzS57KkawXTYVNMEm/FFi2yZTR1sf
 eo1qNnObgICQ3KO+nJi/F/MEr6qMCXdGbgpOSlJZ67N4kaI2H1wtMa/t76Cl6WHpymRb
 9bqBL/A22hvFXMnUwYHaLccTuMN6wFyvl3ClDVINfOnvC5l7fh6PvaoLNDQ05+EsUUNV
 K96A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5dRIqqXWxPfMavAgwMM8JwxC1Dgfxf7OS5wDsZ8k6CGGhi2qxQWff/BhkQ+eFywPr1Arkgas=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+IoyLJyEY1rfekDdldt8xBQEroEQFPlK9EMcIoUPWVzV6CL79
 Hemeil2Duqew9avf5wYqKferyqdaMmyoLxr4UNi9sGU+ycHn9UcmmhdzcihNYBnRMMs=
X-Gm-Gg: AYBFou3iJhdQvDKVVpAucadf6z6yU3NmGyqb65UUGNfJeIy1WLMsd3QQBAUsths0oj3
 66FJ2u7qolR6jDet9ixMmCR9Q8ECjMd522K2pWrAXz1Ar/GPmEQasMNoZ2sUxP2xc3M7nB6R2UN
 lt93sYMB1mE+RQMENzmiB2CHhCkCa/9AKCAO/WpRbDPoc547g7zraAsActVt5DH9XiGiPsV1Qd8
 ybPNNa/4OWr7r/jF4+hGCYD+f2fQtvfSRY81CaRiCJOmAis59eoJSpjmKw6dHjZmNWMruN2BDmg
 tKQ3fevrFJNFwnh90PpuD8qACZosJUXeBQ2eNjKDeHGHWPRpVN1JIGVQWhePJtVzqEDfFngJ3RD
 NeTHcZk9K0tDkNDM03km8YBZZ+IHrplgCgYRyTpxwQrlcvl4kpYWSPXu3Sp+oHp5L9mwrkuD7MU
 QaT1raaNiY3ZGio1XwG7cXDr5343zo0UayTjoPT2jEXRXOZmtcmoaLe7FpmWOsyyRvOev5Qeof0
 q+VTeJndQDP9pZ9XQtFMOHQUN/unWpEDL59uQRPqnnVXsGxfUSBPS1zErQ40iTeoRR7/+3d6F1m
 dUn9I9kdky2loBUET7oW7g==
X-Received: by 2002:a05:6820:161f:b0:6c2:847d:f78f with SMTP id
 006d021491bc7-6c7d15cae12mr4552656eaf.11.1789596755166; 
 Wed, 16 Sep 2026 15:12:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c8f070a959sm1324786eaf.0.2026.09.16.15.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 15:12:34 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:12:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] clk: clk-uclass: Ignore -ENOSYS in clk_set_default_rates()
Message-ID: <20260916221232.GA1252689@bill-the-cat>
References: <20260827-v2026-10-next-topic-am45-ofupstream-clk-default-rates-enosys-v1-1-ce3b87667c09@baylibre.com>
 <e3cdb9ae-9505-4d77-abdb-b08b1dce452a@gmx.de>
 <DKZT0Q2WT6PI.3FVNAODF3C3MM@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2vyQJnWV1S4UlPos"
Content-Disposition: inline
In-Reply-To: <DKZT0Q2WT6PI.3FVNAODF3C3MM@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--2vyQJnWV1S4UlPos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 04:43:06PM +0200, Markus Schneider-Pargmann wrote:
> Hi Heinrich,
>=20
> On Thu Aug 27, 2026 at 2:49 PM CEST, Heinrich Schuchardt wrote:
> > On 8/27/26 14:36, Markus Schneider-Pargmann (TI) wrote:
> >> clk_set_default_parents() already ignores -ENOSYS from clk_set_parent(=
).
> >> Do the same for clk_set_default_rates() and rely on the earlier setup
> >> clock rates.
> >>=20
> >> On am437x the cpsw switch has assigned-clock-rates for the RGMII clock.
> >> The divider delegates to a multiplier of the DPLL that has no set_rate
> >> and no delegation, so it returns -ENOSYS.
> >>=20
> >> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> >> ---
> >>   drivers/clk/clk-uclass.c | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>=20
> >> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> >> index c33f415917e9..0069ce9a8875 100644
> >> --- a/drivers/clk/clk-uclass.c
> >> +++ b/drivers/clk/clk-uclass.c
> >> @@ -359,6 +359,15 @@ static int clk_set_default_rates(struct udevice *=
dev,
> >>  =20
> >>   		ret =3D clk_set_rate(c, rates[index]);
> >>  =20
> >> +		/*
> >> +		 * Not all drivers/clocks support setting the rate (as of now).
> >> +		 * Ignore that and keep the rate set by an earlier boot stage.
> >> +		 */
> >> +		if (ret =3D=3D -ENOSYS) {
> >
> > In include struct clk_ops is incompletely documented.
> >
> > It is undefined which error code might indicate what.
> > This might be handled differently in different drivers.
>=20
> Thanks for your feedback! This patch is more about handling what
> clk_set_rate() returns than what the clk drivers return in set_rate().
> clk_set_rate() itself has a check if CLK_SET_RATE_PARENT is unset and
> returns -ENOSYS otherwise if it couldn't find a suitable set_rate:
>=20
> 	/* Try to find parents which can set rate */
> 	while (!ops->set_rate) {
> 		...
> 		if (!(clkp->flags & CLK_SET_RATE_PARENT))
> 			return -ENOSYS;
> 		...
> 	}
>=20
> >
> > E.g. zynq_clk_set_rate() returns ENXIO if there is no set rate=20
> > functionality.
> >
> > Please, complete the description of struct clk_ops, check what all cloc=
k=20
> > drivers do, and harmonize the return codes before adding this change.
> >
> > The struct clk_ops documentation should explicitly mention how error=20
> > codes are handled by the uclass.
>=20
> set_rate is also already documented in clk-uclass.h:
>=20
>   /**
>    * set_rate() - Set current clock rate.
>    * @clk:	The clock to manipulate.
>    * @rate:	New clock rate in Hz.
>    ...
>    * Return:
>    * * The new rate on success
>    * * -%ENOSYS if this function is not implemented for @clk
>    * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, a=
nd doing
>    *   this check in request().
>    * * -%EINVAL if @rate is not valid for @clk.
>    * * Another negative error value (such as %EIO or %ECOMM) if the rate =
could
>    *   not be set due to a bus error.
>    */
>   ulong set_rate(struct clk *clk, ulong rate);

Does this answer your concerns / questions, Heinrich? I believe this
patch is required for another series, which is in turn required to move
the am43xx platforms to OF_UPSTREAM. Thanks!

--=20
Tom

--2vyQJnWV1S4UlPos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqsUTAAKCRAr4qD1Cr/k
ChhUAP4z9/JGlyi1uvYGqpztdrWhQyRnf4GmOAe1H7zJcExjSQEA3onALtNqGroE
g6dGMh5Dim26yO8gO13G/gQgoEQlNAQ=
=QCcd
-----END PGP SIGNATURE-----

--2vyQJnWV1S4UlPos--
