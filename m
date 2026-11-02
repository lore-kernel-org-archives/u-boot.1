Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685C2606BA4A
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WUat1Jml;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ymi6zNzR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01393810F9;
	Mon,  2 Nov 2026 16:42:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AdIAbQ-ljh9; Mon,  2 Nov 2026 16:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31B6581100
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793637725;
	b=h3b6btcEUYxhM6VIRYj2xZVnhgCeOXVzPqBjY+C61JpOwicZb8a/YSsXMFqO2BMc6UXO
	 NgvKc3GRNnuB2mPgGJiYuts6RQoovDodhjm0ElNUIKzN9AXdSU1CjvpopffjRbsTbxdbi
	 ZvzxmslMA9HVYlGSrIaAG3WWfl+aKVlvwwU9opXeg7x5cGbkVEAfEUSQTI0SdAc6+fgFz
	 YMDhmas9XZsna4t1VRux8NS78Qr/V+hQsVx9Vuu4bsUeDDio/ytkTyZLYY35uhuoo8/RU
	 /W3ROKSgPyHiyRQ34eVj7ox6XdGZG+jVQTCGHHr9lCaqgydX1/ONSmJTroqDdJ0Nbgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793637725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2/+U82OQPRY5nBpvqp1XcDtCudmrRYC+WsKkhVxTDHs=;
	b=luymGRE4XDljOzmoB2LwLMTzcnDklwv53w5Ca+BWblSHKKNPnnUVWBeE/4gykY3vRXLA
	 yE6rfk6fdN3SHk7iTUU0y4xY9Xro2uqxVFXVq329UHWspPIiw4Zil4yEd8Af8FffsK5qw
	 x8FApcRe1G4WTzNH2xceJsdDy31qc9yl7oTkjkhIffeSl9k0Rzokjuto2Plx2jn67Duyr
	 IbSts5cjaR0ToaI7gGuHe/Sgu9ZhzmhcIhlU3nH+/92T71LZ8+2Tqlo/cv9yrLQEl2h1s
	 cWFqHli/PyLJgeZj/q5zsLIQnA8OVHNgdDArRhLlpRZR4aduOXkQiGyIR8Z8nky75tw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Ymi6zNzR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793637725;
	bh=2/+U82OQPRY5nBpvqp1XcDtCudmrRYC+WsKkhVxTDHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WUat1JmlG3aOnJN9BC9SyNyNUzgTgO5qbgjPcjFta409NYX+mQuyLuWImvC+dxY53
	 FUXDmwSoIBEJJTYOK3o/A2xxtoYXmdEoSXwx8mRXHBAt+vsFUixSqUoAxe5yrPVBZp
	 UCdbfC4kbAp8LXEK8w2yZo+0wnQGXvmCs8lRH8eCi1A7BUMRE/GxIlK5NOi33O3Lmu
	 vbSbA1d2dpxp4y/N6j4o+QL5xendM7KmS0GTCKBe8+w5Zg8lVjP/jPXs/ZlA97lLlv
	 ISUAmtTZtXLXxTRTyxdSd63oEQHJzxUUZk9UA00xErZgFfrgWFaS64KAiWhr/SliKp
	 6GFMRMEv1ug0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31B6581100;
	Mon,  2 Nov 2026 16:42:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A65F120
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B96781100
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItCBhMc6V54Z for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:42:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A749810F9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793637722;
 b=n3FHkK2AxRFHJWDeut35iwyJUue/DpJQTRYqpwzUMJu8o4MfUqydDwo5r6x/gZ0w7I1H
 bafB96Og71/5+Ul9TT30+sn6VCDYFnZ8DUOFFdf2Cw9R3NH/fERFkk51Hf7jB4paJ6g8s
 3ioDGjN3NaOycbOnD9wzNC8fk6qzMopHurR3EbsSBWhVA3tGKhdSWJwtwq6G1LPTSx2RV
 OuYIqabE3JHQmwI/u5XSohrSIVKLdFQtDp/evzXL5QDywSpIjktkRm8q/vOaiCNAxUM/9
 7prEXfOcIqbNiQfYgw0rd7uG4kDtFzdAiez5IMIzw4LiVLwJIjY08oLcFsvhr6pn2RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793637722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=2/+U82OQPRY5nBpvqp1XcDtCudmrRYC+WsKkhVxTDHs=;
 b=DeXpeZWGLTwopuZEtupY1eFX0c8yVFt492870q92FsI15yMDG+FdsA1AFrTG3RhX7d8I
 sbMTpsItoNjAN37oRacf4EAuO+H92ccQ/Mc2U3Sg9xxi0I3B8etTHWEo9AoQI/SlR50GA
 J1XpXnmAdjLExY8bPff6c62DMfYgbm+i0ky66sp5ysx4RsQJ5qr4UFKZ+eM4zUNgv1Mdl
 bxbm178zPJEo5n3RK5/00MNCG11UOzGw9o111eRR9Et90zaPvm0iO/QuRY8Z9F+sdsmHI
 L4r5+C+rEI3G+7bnMhxFKOKzTGj0lx+gaFOTFu6XQl7rc9XptHMnxRtvEI0mKQEUMDQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ymi6zNzR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ymi6zNzR
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A749810F9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:42:00 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-504ae5941faso1912358b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793637719; x=1794242519;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2/+U82OQPRY5nBpvqp1XcDtCudmrRYC+WsKkhVxTDHs=;
 b=Ymi6zNzRIYIfyoldWsewCS1UjGeNNHh+9MaieVrYsrVN0W3HXdJxesjTXtiu3Ltshm
 xgKusfiSYxZUd4icZlM5xsnvVd4MT4N2VWf8y1rljgrMC+ZbPjV0GG8JOuK4BPdN6W6b
 R3T26V2ikyBGmCHwTTmYK2qkn2tPqiac8T6M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793637719; x=1794242519;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2/+U82OQPRY5nBpvqp1XcDtCudmrRYC+WsKkhVxTDHs=;
 b=IOr9pqj3p9ouFsUUI7KTNMy6cxscxLTYHdQIi1Rnr3i7/SxwXuTFWxKjr+hZdGcFNj
 19T/qszbXyKYmCSV7HoifgV7q/85pYFi3EUl7N3IRWmDMuo/8fOU8maGAPe4w4MMr58Q
 aQ34lJXLyVWwYIf7bKA2jvSyPdg+Pe4XdAmTvJfG8ma8HYMqCD+3GgPtYCnhTXkH8sjJ
 f1fj9hTLfY2ktmG/kymvAi4s3PdAJqPfIHV2yv9zQhsCHeVOKV4ZGpZHqmIoXVVQpdQ2
 acCO1dE1f+Dquz+0I8VXdsBTurAgqE3ninAm/bphymSJuQtz/snQ1vj1cBWjM7seSUgB
 F5vw==
X-Gm-Message-State: AFq9FYJfuPnlJDM9gtVysd9xYSJPoXBHBOyQ8qfQauH2n0oA2b8h4Pxs
 BhtnH6fHrrOIvGuvHyuMJ75pW4Hc4kCX5lcxSYIcBkFx+mPeXF2YEWrnR3Y3lYHIohg=
X-Gm-Gg: AYBFou0aG6wWc3bCaqVWuXRYJQXdP8ucId7BlDQ1LQz5APetxft/glUcvj36+f5WRho
 vfOz1eJn14Npjj66mg6EvoJZAZ1U2BAjTsa9n6PUJ6eMXkroxJzOJ5pROqt9f0m6T3W8VvWGTgO
 P/TOYFpAG+cuao2ta2ty7EZWrsiu1fVAXQ6JsRS/fPUxsmmRb3pF1QTUycYcIuyhd/QhhK+nSzR
 fgb23Ah05XWp3ZZSmXnU5IhoJGrdQt9vUzQRysXaJijgn9X3j7yar4WjeyUJVnyIv1vSBhx6r2t
 0nu5EhBJOKEgLVKy7bPm1Of9V7y6L3rnfpSbj7FS+74GPeTxSIN3OxDb7cs+3MVSPIhuLy9uvLG
 y4iTQL7xGDFr48TUEseU0nEaG/LYhRp3wb7cySdIp2Zizsccqw+l8o2+A+eUhMxVfGZBdSJ3HO4
 uYhhsKOUhAIPbSuaoZdfUDfqlMRwHW4gP5ML85BZvj4Q1vrYDpZbZq78Pvwb6dx4utW59iAVgFD
 Tl06ol3J0EmbHExDeBCpYMX7Baj3YVJhCIkjVk5KpL4NoWrO1WylZ2ZpCV0o2FQenIMasTyPPqE
 OjVifz3+PGQsnfHzRt88aKGbKIczl2Tn3OuEyK/9DjhLj3vbX9MjlTgnhAJ51PADxRTLl2pYD1p
 uquQdC0TxeCs0Fvbfcl5XnhwAnHMCYUaUr8iTItQP0ElV/klzEaDo04m3T8q4KFADh+aqEkAKrm
 G7546f8VQcbRm4k4GH8Nq2VsgDxSEZkbPAxZvcj7fL3ethlEOasZw=
X-Received: by 2002:a05:6808:3098:b0:4f6:a430:1822 with SMTP id
 5614622812f47-5640d91b3e5mr7241376b6e.7.1793637719532; 
 Mon, 02 Nov 2026 08:41:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a921997d50sm7290741fac.10.2026.11.02.08.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:41:59 -0800 (PST)
Date: Mon, 2 Nov 2026 10:41:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
Subject: Re: [PATCH v9 8/8] doc: qualcomm: Add snagboot mode documentation
Message-ID: <20261102164156.GX3309461@bill-the-cat>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
 <20261021175256.GF3275858@bill-the-cat>
 <df45aef5-5172-4d85-82e6-331b5594eb5a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tj5ZnTtXUgF7N8CC"
Content-Disposition: inline
In-Reply-To: <df45aef5-5172-4d85-82e6-331b5594eb5a@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--tj5ZnTtXUgF7N8CC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2026 at 04:10:44PM +0530, Balaji Selvanathan wrote:
> Hi Tom,
>=20
> On 10/21/2026 11:22 PM, Tom Rini wrote:
> > On Wed, Oct 21, 2026 at 09:48:27PM +0530, Balaji Selvanathan wrote:
> >=20
> > > Document how to build and sign U-Boot for snagboot mode on Qualcomm
> > > platforms, using Lemans-EVK as the example, and how to add a snagboot
> > > defconfig for another board using the qcom-snagboot.config fragment.
> > >=20
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.co=
m>
> > [snip]
> > > diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/sna=
gboot.rst
> > > new file mode 100644
> > > index 00000000000..716d88b2ba2
> > > --- /dev/null
> > > +++ b/doc/board/qualcomm/snagboot.rst
> > > @@ -0,0 +1,80 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +Snagboot Mode for Qualcomm Platforms
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The second line is too long, which means you didn't run this through CI
> > or build docs with warnings-as-errors, as CI does.
>=20
> Corrected this.

I hope this means you put the whole tree through CI.

--=20
Tom

--tj5ZnTtXUgF7N8CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaui9UAAKCRAr4qD1Cr/k
CrwVAQCl0WproLSQ8zifDUl6uQJ4CfKAlhjddmab7Jz2wctSiQD+Ntr3cIMllC9M
/+iZUozlmuj0amUq8WiUT73/fV4mjQM=
=3bXR
-----END PGP SIGNATURE-----

--tj5ZnTtXUgF7N8CC--
