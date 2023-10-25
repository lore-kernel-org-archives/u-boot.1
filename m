Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C09C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 15:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD125871FB;
	Wed, 25 Oct 2023 17:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D5PCb9yz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D64874CC; Wed, 25 Oct 2023 17:15:36 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BA486F8A
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 17:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-41cc0e9d92aso37731811cf.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698246929; x=1698851729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M5l5/7G46B06DiuGXhcKVRsDFmxd2h+lks0VIv1nbqU=;
 b=D5PCb9yzaJviebHZgmJ6omBZ7cKDdlvDiR4zh2qdF+9fYTaysD38uFy5GtCMuD3G2B
 W5Ue7mmNHKbEj8O1VZp3ergiXWzte2yLrITNH+3c31NRg5matoq2Ci1RgHGuReqPoo1+
 fK4hmPiATis65RZFxivh1s5a4THc/pfjy+ip8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698246929; x=1698851729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5l5/7G46B06DiuGXhcKVRsDFmxd2h+lks0VIv1nbqU=;
 b=BZwExqq/+vzq2yBbwMjmgBssL2PE9ArWlZPmevX0/pupuPfarpUI/kbjBk93l3mZM4
 CTFWJuJXMU/CMKrZXdkOS1JKWU8xZ1FeWjJi4Te1Hg9WhsZrjkNlmOUR+ZzFwrXjmz2S
 iIOLUCs1bb6KFUJwoEpn1ggL7UnumtzmmwBITh+lsMH6lGnu5J9ZxpN+3MXTmGnfGtzt
 yt/4/QCI9eWxnz8OmBPNqdDs03cHfgqrXxiPtxMEVc2Gp4RedzQ/y1r0Y4raUDRW9m9F
 +rbm7xjK9lScke61sqGC1AUTGqA2n0HDWi1KFRgY1jmT2YxxD3Ma8XicijA+xu2k8DRM
 bEng==
X-Gm-Message-State: AOJu0YwC9p/eo1DQwWX/67b1f8UCyfBze9HFe0RE74zZ6JnA5jBrDs/t
 eoCge1eAhmn/0AujQFztB2w+ag==
X-Google-Smtp-Source: AGHT+IF5NlbEVoTCAVqKt2CbRdX3FyRLJVOKbV/WdCK26pFzsDEyA3DvN7DP9+UOVrFDMx+Ej4XfIw==
X-Received: by 2002:a05:6214:404:b0:626:f3d:9e46 with SMTP id
 z4-20020a056214040400b006260f3d9e46mr17817351qvx.18.1698246929389; 
 Wed, 25 Oct 2023 08:15:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a0cf60d000000b0065b12c7a48dsm4450077qvm.133.2023.10.25.08.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:15:28 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:15:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: nd@arm.com, u-boot@lists.denx.de, xueliang.zhong@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20231025151526.GT496310@bill-the-cat>
References: <20230821210927.GL3953269@bill-the-cat>
 <20231020115747.GA141285@e130802.arm.com>
 <20231025145736.GS496310@bill-the-cat>
 <20231025151237.GA265088@e130802.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PhvIQuuJSqpDNJXy"
Content-Disposition: inline
In-Reply-To: <20231025151237.GA265088@e130802.arm.com>
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


--PhvIQuuJSqpDNJXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 04:12:37PM +0100, Abdellatif El Khlifi wrote:
> Hi Tom,
>=20
> > > > ___________________________________________________________________=
_____________________________________
> > > > *** CID 464361:  Control flow issues  (DEADCODE)
> > > > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_=
log()
> > > > 142
> > > > 143             if (ffa_id < FFA_FIRST_ID || ffa_id > FFA_LAST_ID)
> > > > 144                     return -EINVAL;
> > > > 145
> > > > 146             abi_idx =3D FFA_ID_TO_ERRMAP_ID(ffa_id);
> > > > 147             if (abi_idx < 0 || abi_idx >=3D FFA_ERRMAP_COUNT)
> > > > >>>     CID 464361:  Control flow issues  (DEADCODE)
> > > > >>>     Execution cannot reach this statement: "return -22;".
> > > > 148                     return -EINVAL;
> > >=20
> > > This is a false positive.
> > >=20
> > > abi_idx value could end up  matching this condition "(abi_idx < 0 || =
abi_idx >=3D FFA_ERRMAP_COUNT)".
> > >=20
> > > This happens when ffa_id value is above the allowed bounds. Example: =
when ffa_id is 0x50 or 0x80
> > >=20
> > > 	ffa_print_error_log(0x50, ...); /* exceeding lower bound */
> > > 	ffa_print_error_log(0x80, ...);  /* exceeding upper bound */
> > >=20
> > > In these cases "return -EINVAL;" is executed.
> >=20
> > So those invalid values aren't caught by the previous check that ffa_id
> > falls within FFA_FIRST_ID to FFA_LAST_ID ?
>=20
> I had a closer look at that and I agree that the deadcode defect is legit=
imate.
> I already provided a fix [1].
>=20
> [1]: https://lore.kernel.org/all/20231020131533.239591-1-abdellatif.elkhl=
ifi@arm.com/

Ah thanks. I had seen that posted but not put that together with this
email and assumed it was addressing something you hadn't talked about
here because you agreed with it being an issue.  I will pick up the
above patch soon then.

--=20
Tom

--PhvIQuuJSqpDNJXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5MQsACgkQFHw5/5Y0
tywTRwv7BfcrSYoY82ivg++CDKK3g7Lw7of9JbwtiWjT3GlHPVLgAV3EfomBE9li
k711MfCavDRmpmrRp24dzZYgWlhjUnkJ/9joWp47fy4y90F/Mje2TFT5zJnGcfmE
UU3xL6oySWNmb/pAx3rC7FIOBDRW5969lTsHNfJGrohcHj7T9RAe6C7apiRjiIiz
vtkpo2bNsYLclCIKQUnpQnfKSGVRwMmrQLTpTIaFYqocrpUnQob/v6yPY53uxlY9
0ZM8Lhs7X4Ye0sdMcLLUEyh96GT/4OMraSzvzclTcJv3Xr7n7lDbYP8cJ518rr+o
QyL3AIGFoNekNbm5IdnhslN84S9voRAyR/5+1DUjFWjKbJo+PFHeKGns5zijSG9v
Vtw4jeT8bvf1/kZ9+dVzGguBZWVyZs5HDU0gy00MmPPeiQn4IPYZo7Kr/2It9J/y
HqWigK1uNtTak3u6PbE44HgYSgaVYkqiEFa1fsd42s957Lquw+PeoNLpvw/xG9GG
20mBZLgf
=c2Lf
-----END PGP SIGNATURE-----

--PhvIQuuJSqpDNJXy--
