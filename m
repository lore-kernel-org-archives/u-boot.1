Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20852C88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A066680BEA;
	Tue, 15 Sep 2026 15:41:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_tdaQmP06gc; Tue, 15 Sep 2026 15:41:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6E30280A82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789486908;
	b=Wiez1hQ3Pf8gkDXw5kou2nX2LOxRHZ7RY0Iw896blUV68INjNdZZxUqJWEfRvf+TXYEx
	 s9RBg7fKl9mW4FMtWTBT1bSX549jhIm/Nobi7N/iBLW/wdxLoOUg3Ex3MQLS7QocMamRL
	 0HGiyk3AQ9/0fKpKH7w5JHybcWU1O6ah+YwA8ccL84+TxcCO2E6lWrLmQ/Dfn2yxspBOO
	 E8F7OgEI8EftO3JTJVlrs88wVpQvsx0GV9MhLRuT5r4uJ4HuSfhMhsRpYorUUY9TprMvA
	 B4UZ8YeFmE6ZvLXX3DUW54FsmAcriPsX0/2dNK3NLF2YCXloAYFocNysu177jewoz0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789486908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LIeDqGhnsRLCTOI2RGSqxcrPexBZYp8MfClXa0pPrBw=;
	b=GhwrCOfRjeMxMK1iQROmbKp5hOdSXbWQGtMKHJmFgDMOiH2Qd4XLtlUtupzbXSZOC+ZD
	 yRzIk3TnPr/goMG1xUIS4XNVI0I9mG397xsfrfc2TAV0H3QBdK0JQrzdBGxDQbCUTLxMu
	 79yXVFT6ZUfWGdxKu8Dbyb3iHUMtUwLECUneP0v9cy18kL0zMqTwydxGmMLuAw7HWYAZl
	 +SxmSVtIaYwfxe71Q7DkpOJmSHzdL20GlQ0C8dsWOi0JKxPgWMFTGd4xkk8zbFdzD+Wdf
	 cV7Uh+eif+80R5ek1A5Dh4NUtrMcF5pdskkdDPzENKVdApF+3VVUjDhXKvr807CyBng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=UVQLxPAB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789486908;
	bh=LIeDqGhnsRLCTOI2RGSqxcrPexBZYp8MfClXa0pPrBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YdQiW3HiqxjgNLZoTo5B1VUtAELSiEv1Bza1FH4FnQpxIO9QrOlXkamGlV47zlLrr
	 5B3m61W6ly+4T7GEuwXohaGj/Gh+w+HVABhl6OrFCqIlMcKMPo2kHOuyOu8vMFN7TS
	 0fRDTmTotdDSz1sbj2BPg6nMyhHasEzmlfsl3zWiEbaofxEA4BQM3WgCO4aR5ZY2as
	 lFPipdtvQKOH9xdQ/ZGYYMoP15+Y3HMVFciKpywVAM71uVwZ7WQAmRATu++qGF/Aks
	 97X7ttuuY60LQVU7NDDsHVzGxnWhHJtxg23/2xhbDU+HHoYl+W2ZlN+ELrVxdEz/N1
	 nhAfk+3e2sxgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E30280A82;
	Tue, 15 Sep 2026 15:41:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5764F2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40A4680A82
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:41:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9FnvuxoZFMm for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 15:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4380E80A58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789486905;
 b=oAiRntK4BtxkEhayjEWD01qwohMw92wfsW2Mm8YCB5dGH7HJu7vrwU8MmaQAn+KRH46c
 t1TMkYE03Lo+0cFlmB4N5sZhjCmj08jS9oIft8MgmX4jif5JBt1lXmfq94zJ6imwX22tq
 Joz7JPizt1IY/7N/V54PawfWavtCuqNqz6jVaHECJurS2X0lRY/8tOF+Qg1jr7exG6g7R
 Yx6g6KK88Cw8XikGK6IKldRbDF5mlYRMdk8QFK4ScPfKkPiprLDt5cWE6tTNuJJ7buzeF
 3RjVWmCFrPYhlX0649FLc8aAaMoGH+tLXXnWbgwF7dn1hdkRDGD0rPVAa6qK2UMOd+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789486905;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=LIeDqGhnsRLCTOI2RGSqxcrPexBZYp8MfClXa0pPrBw=;
 b=EPjU2ODzga6NnGm2gxJhTsGlcl9N1KStPw1Ne2pR/sY7FIOh9+2aIPGwP1+8vApH29MB
 tYI+aiTzctjViVGPTZXCEJcfAS+AhLUop8KcSe8Doakurtz652V6HG4bv00lHfI9Sg0ye
 QfPbTKj0qef0ALI59kIz1GWV9SJLzBdig+rjrPuW8sXPOL6AuhkRys14Sbz0S39zbkjOK
 P3qDe6Y5JZPJH7oG+sqHPRmigDdTK2NvqD1toydWZJLpKEP1DFQY8R7MlsEDCe1jI5E3k
 C60+h9+U48BooSyNKMxC2LvUmpb1hR9c4nrw6qetzFYZOn6UZTFI/I5Qqu9YTGDWQAg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UVQLxPAB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::9;
 helo=mail-oa2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=UVQLxPAB
Received: from mail-oa2-x09.google.com (mail-oa2-x09.google.com
 [IPv6:2607:f8b0:4864:30::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4380E80A58
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 15:41:44 +0000 (UTC)
Received: by mail-oa2-x09.google.com with SMTP id
 586e51a60fabf-47cf5b09bf1so1668543fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789486903; x=1790091703;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LIeDqGhnsRLCTOI2RGSqxcrPexBZYp8MfClXa0pPrBw=;
 b=UVQLxPAB2Po4dgAURyS9nBFUET0CMBW5Icx8eg8BiC5pFwt/J59w+us9kvAH0ttSWm
 eGmQIxYKjki/mLmLVpNd7iLXC8xtDIbtD+HJxznkIbVBcZ8E0Q1oHHgZFxVW06rgFIEe
 MkewDD+LgstoYzbHRYy+8W0y5exwS25xyyzos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486903; x=1790091703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LIeDqGhnsRLCTOI2RGSqxcrPexBZYp8MfClXa0pPrBw=;
 b=XVwf4qroznxAiIfZnyxaT8lNjUbWE0ecYHAi2pCq3pXLUo3Ja0sg9WIK+b6939SwWT
 l1Agrlj6pPGihQOpkF+Yosruf0GD8E1qMgMDhewIzwI0oGts9uFUSBrfkPHJlpmm0PHG
 M/as9jJ5ApFwOkh/ik7f/iRUQ2khZbI1bJ4mw8P8IzMA6AS+ISA5u+etOlotN5/9KoJ7
 V9RokZffMUv3qXI0YZr0oLcaBqjzesL6EO3veScTMJ/uEmtSKPWbRB6Aj+dDXjdab/C0
 GNA086P54HucBuGdrCKSgFBBrVMRdVRWF6W7GsRtqsSDHjw1aR8TAt6sPFcuGcWLFQ7Y
 aL+w==
X-Gm-Message-State: AFuF++kUt5e/jNe5M/N6QhH+BcZ7X9zgBsl2qv8IK0+oHmgYEQRh0agD
 pLtPvsSN0MHViOiRdpQ7zDY5thiI7HjXo1IQMUdSlKiZTsWlQ+5lS4SkzQc8QmL1nl8=
X-Gm-Gg: AYBFou1Cf2Tw8KrSmn7Eyd+1oJF3hKsO9ZXxawNN13XvQHNXbslYHDICjglxSTV8oHI
 CBY4VPAgHsMkY2/qvseQV+Bk77LIWdmC6NDPdOvq5UB/0TeoEzVzyRnKnbM+Q2DR/KtFn1HPiLu
 xHtixuttNN8+asK0w0O4dOhSn1GFlautGzT+6M01O3GsAB2uDi+z7qyQbzM7j0paxdta+m90MB0
 9NWNJmODKv03myJFucDz6D8tr/xNpbX8qCkjYnusjCgoorA35YQyvU1HsUbSIYrT5a/B/I6Nelb
 DOQW6LDfswnAQP9ihdqz4jLMcqvkdQr7A6OtjhtvfwT4MxmqaUezdwZkxtMFdZXxVqS5VjjQCoo
 bPUqHqMdW+VSUMSodTVSiyq3maHCP8NWGoclg4p0DtPiN1r1U6RuFd1tdMWCerEJiGt10jMim10
 C3qZPDm0iaV/PQXXRtbLgVhZoPfOaYBBH39+AFk8DlztoDUsT3MJDINw2Kh+FbnazeJ/gZiDCo0
 ndBgaWARnMLPstah1KMaw4t49TzPsniciKpzcbnFf5LkXpzFhr6lTOouJsH775TWirC5JiWE1TY
 oJ6zHJjKI5U4IyCZiiWS
X-Received: by 2002:a05:6870:b2f5:b0:447:1ceb:7cc6 with SMTP id
 586e51a60fabf-483d1bff634mr1367076fac.15.1789486903604; 
 Tue, 15 Sep 2026 08:41:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df8bd0284sm13117724fac.9.2026.09.15.08.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:41:43 -0700 (PDT)
Date: Tue, 15 Sep 2026 09:41:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Eva Crystal <0xiviel@gmail.com>, Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
Message-ID: <20260915154140.GA858934@bill-the-cat>
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
 <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RHX9feBi2n4vRR5R"
Content-Disposition: inline
In-Reply-To: <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
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


--RHX9feBi2n4vRR5R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 08:45:23PM +1200, Eva Crystal wrote:
> Thanks Ludwig - I hadn't referenced your series in my cover letter,
> and I should have.
>=20
> v8 4/8 does close the configuration side: fit_config_verify_required_keys=
()
> gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
> required=3D'conf' are present.
>=20
> The case I reported is the other gate. fit_image_verify_required_sigs()
> looks up the /signature node in the control DTB and, when it is missing,
> sets *no_sigsp =3D 1 and returns 0 with only a debug() message. Every cal=
ler
> then treats the image as not requiring signatures, so nothing downstream
> can fail. As far as I can see from your v8 hunks that path is unchanged.
>=20
> Two things follow:
>=20
> - I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which collides
>   with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the SPL
>   variant), default off, since the two gates have different blast radius.
>=20
> - Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image integrity
>   only, not signed configurations. An image-side required-signature gate
>   hits that setup directly, which is the other reason to keep it a separa=
te
>   symbol that is off by default.
>=20
> I'll rebase on top of your series and resend once v8 lands, rather than
> adding a patch to a series that already carries review tags.
>=20
> Tom, shout if you'd rather see it folded in instead.

Since Ludwig is already working in this area, I'd like his thoughts on
the issue / solution, and if it would make more sense to fold this in to
his series or not. Thanks.

>=20
> Eva
>=20
> On Tue, Sep 15, 2026 at 8:23=E2=80=AFPM Ludwig Nussel <ludwig.nussel@siem=
ens.com> wrote:
> >
> > On 9/14/26 19:34, Tom Rini wrote:
> > > On Tue, Sep 08, 2026 at 09:27:03AM +1200, Eva Crystal wrote:
> > >>
> > >> Reporting a fail-open condition in FIT signature enforcement.
> > > [...]
> > > Hello. Yes, please follow
> > > https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
> > > and provide a fix and test for this issue, thanks!
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20260813080943.v8.4.6d=
1d5d14140677a76a7cd7bb99a9088d8c8f480c@changeid/
> >
> > cu
> > Ludwig
> >
> > --
> > Ludwig Nussel
> > Siemens AG
> > www.siemens.com
> >

--=20
Tom

--RHX9feBi2n4vRR5R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqlnMQAKCRAr4qD1Cr/k
CpBSAP9K1rB6ydqSuMHS4pQPwWgT8/laHMDn9IWj9jsBaUEpnwD/Z38AnLY8G6j1
eKDCvGGw4BUv7BX756wT4usdxfXkZgU=
=HDkG
-----END PGP SIGNATURE-----

--RHX9feBi2n4vRR5R--
