Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F54606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ze+mVGgl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=cXRjUJ/W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 190F680FF2;
	Fri, 30 Oct 2026 18:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tm52oYnfI7VQ; Fri, 30 Oct 2026 18:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3132C80DD6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793385291;
	b=bF5XU810Nm38yJxRKjEEnXHh/ySMrEUzuEN6U4GSMCZzPEDpcI7aia8BDCS+z02dzplE
	 avLbajRIy5bQ+iUgP+I6uJP8T2nsjXzrylK9Rhkr37KyQUq2q1MNdKojQdP3aJeWyIktF
	 ZU9JUsCeY845uyOywPmniygc+u1RiuPBgLqs5jjGvfGjbbX7pEvCrw46xgQ9Tv+Z4s/Qf
	 nGmNV3H4Xa7wXTPyeN9ThJaGQMOUugZNI8TX6ubw0eV7FZ2OFqly9DSKDDfURSJDjA/4R
	 +JxoOzYL/s0jYDAif9OMy7bD+5lyuR6cetBq8NvaLYU+9+V/ys5H3AasVCLFq8bEqGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793385291;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=owYcWq8rpFh+APwUbZ7ZY7putpbhP7QoSFSXo7+RAi0=;
	b=CCIXuVPa3voYUrLvn/Kj2S9Bwgw1/+82dgXlTV0UTxQR/hFMgqkddQ/xj7aOE89s64Do
	 AGubUu1cqRU6chyKCysMRrJB1Y44T5x6FpUqSI53mfhmVN+U45MMRrjNDATNJrUEN+ZGr
	 VR1JUfBoGLV4Eif3SS906U7WMfr3YvgeqSbKTFYMCfXo81qo2ZKgCiBrS8gglyf83O/UL
	 0toRFsrHM86rRxCrSEX1bjhMMnpJGXYfC3mlemj2acX1T9wuSmbbZIc1Y4uXhxMR3PDFh
	 qxs0zEQZxLg9sP8eKT9fixCOt6EaiMhuWVj4WCQ7oJYXxDPKscR/8K5PW4ZRJuAFTMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793385291;
	bh=owYcWq8rpFh+APwUbZ7ZY7putpbhP7QoSFSXo7+RAi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ze+mVGglb5DVTacGAo9/QEozc+7+TlT/FqpeaZDoP77CLuUTkh6y1wzaH6IFTOZjB
	 qxIdHrA9/fmwB1byYoAGQmHjNLgDtsfM1MkTmyeKbc4MxNQZ5QJtQf6Gk1sg0ExG4t
	 NCMOsekrB2WQntqCw7kQIvR6kNG/X6hH+sayM/V898q10z8bcorpmHYn+qfned8gmc
	 NfT+1hhQOitYIcAwDq5ZH3JOaSq5wbltdDTaVs4vYBia3qmKCR3wSZ9m6b9460V2iw
	 XcCCOXV/TIRzY1H+Zy02ZiiADl9UdL19ZazuHu4C8kV2zdBRu4zFML4/o8Asemt3RV
	 YCqorP1GvC8iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3132C80DD6;
	Fri, 30 Oct 2026 18:34:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B39E42AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9924D406CD
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:34:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Hxb_mQxwXL5 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 18:34:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1CCA40698
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793385288;
 b=cXzRifd4Snia7LslRWDgDskzbVU/lfzz+EtaYmeErj9khpbvyKUdTLlxvvcIsznEwrX2
 i2rPdTAuJS2yhCAWMFNM8hDM/2nMEhWlNMZC4/I4zF35bkRm/w5nX/yWRtMcMvAjJL8eJ
 s+74hOwp4YnC+AfQRw9j+aYJEzPx3RhOFWsqvVrhW9ByYyiFl3skFar0x1ULtLJAf8ocb
 mF/whj8+nfWJ+UDTNB66Ftoh8F5ohYIPgCHhhtWN0LGdVRms8ueuxHyGu3szMudbp/Ec+
 VglXCeJ78Of0X26vLIbDwVOVQByE4x79PDtF27Y87Xzy0NYYGF6GQkjKLDFin+gPGMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793385288;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=owYcWq8rpFh+APwUbZ7ZY7putpbhP7QoSFSXo7+RAi0=;
 b=MGg3zGliTqpG+0LLNx/Vegwjt9hnM8QxejMCxr2pCgzseEN4XoAuoKVDVkMKm1QGj/C9
 47BW4DczXgMjpQfTBRvODM+PfyNGMAR/4IfwGjCwoA05ZPvld+BczkOHBXyemzW0pkM9W
 nEsnFYrrQo7GRirbtPRw+waZEoHeOH76RnZSaLh4TfXlXseaun6D6hsLMZgXlxJgmP0xi
 RFYloTDFbVODQws8Qfg03MFKddtkJ4xok0RI7kLJ6R4K0NOMk21wiMXbA3Dd/T6i7Ccce
 eLSOvw+bC9Rmq7OowR6kYIvtpzeNGGOQPqNBZAuYSlwhGYj4CnHwHD9vmG2pHnE3TFQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="cXRjUJ/W"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::8"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::8;
 helo=mail-oi2-x08.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=cXRjUJ/W
Received: from mail-oi2-x08.google.com (mail-oi2-x08.google.com
 [IPv6:2607:f8b0:4864:32::8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1CCA40698
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 18:34:48 +0000 (UTC)
Received: by mail-oi2-x08.google.com with SMTP id
 5614622812f47-4b94bb43008so164641b6e.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793385287; x=1793990087;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=owYcWq8rpFh+APwUbZ7ZY7putpbhP7QoSFSXo7+RAi0=;
 b=cXRjUJ/WMQPx4sqNAp/zzbxQLpXJP2Bb9UGnJKcguQfO2jBNWrEhDKWsYagv9fUG8c
 DjMFoMzz9C2YjrUipu20eagll3gwdjg1Bhs34NlVCdJxulpn37wYQWkti3H9ocCG/M+s
 EsOsKqGar4IwHAsWsecjopZKgU1fdC68uP0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385287; x=1793990087;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=owYcWq8rpFh+APwUbZ7ZY7putpbhP7QoSFSXo7+RAi0=;
 b=wK08+7F8IUB09hUSoT3zpaugLj99pIa1k9neczBqO0eMUd8PbhVMRUf5OJPtvK+h5J
 t/zVcF5UaAmsyIHROTwkABZoTRabWGkARR10aExQtDHSj1khlceqB0OL0sDNVwm0t0j7
 HarJwWAe3huaTVgW0JibKgqVFTw0J3viOgbbFyVo569dAyk0otXOyWud2/JMyFd2qZNy
 OQbN0QeFfK/sv1DS3Y4ZoE+bTIELtG1q2QNw1aRYVuH6C1Y0mw2UuYWxqhmWOOrPWPqo
 WXzSkjQDhmEKEYS0ShU2A4QjdqITMo4XIYlvPkyQI2OSMRF6KaFohPiTWAPwlTtYkhIc
 QCgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlnw/M1tttGCzXmgKM1cUWAfibKFjmtnGlilQOm0zDt20sxIV2DAw5ylsxrm9UL55DGG5g3NU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIEh/biSwN5c6CyN8W3CBLvN8Qk9UbCgySw38QFcjWYbW9mq7Od
 dn4rzpMifmE7qlrzBL8oGfKIpL+UU7I41N4wepKouAxcOMJ3M377THuIekRJ1+G7xMQ=
X-Gm-Gg: AYBFou2GQQTqmo5IUHBOP+Mlj/uOG9oMR/irvEDazcaslvrobHEDfT80Cy1kIzL+MFr
 IoaSAdHqkE+/0PtKuNPrPAMFYjZxLI+GDroHGCuC6u+vUSf0EEkEgwZZ941luHIREwVbamzvTCH
 tvRXERAgiAkVHBHSSxAuFwe71U4lwFF6XX2MQD2HeHJ+oAIhzSLIx1l2V0Z8b7ZGsiBsOop0qhs
 LWYtQQk6PtQARWOKU0llnWdyhwSj+inh5iu1udl2rlaRP/DKS5LoCI3x4OHxQpLIGpRcQwTluif
 nMPxUxpbEUASf4YuSPDHotLmDUgkXhnPiTle35kEsHoLqqTML3EEkfC2FeufGtkNN74OvrXjNH9
 8YVp1fU6g5dAJbPKLPWb5eNn2+tPQwNzNjNFcQcrNqNa19EOhXjCfw4cyjA7BdX/fkMx3n0Uo+b
 rXcLsMqsO0FKqdRDqXQul8o2o+NU3hQEN6fFklhB+coPcGA1BeaELIRFwwHJD0EvYnVfooSceyq
 rawnedt9vN4edIW6m87cSAtwuESA9Ftvwitv9CXuCsO7M+571H8R6g99qNhmmneQvgpkmDGvKT2
 0cpXGCxwZ5HnqB5LfkQ02XGye9peS2x/QCZH8HqwIgd433OUH8LtRt7rrIjswGteGy0cHx/TGzZ
 PayUgVoiWkq1tKvJ/1Czu+sC5p/xA6eSYfe4ZWpDT3aF5my9oephQ+gl1qC6KmgSg16BczM5Ivb
 ZiteiHI1m0YCvSBuLFocGQET4gLchH9YIb6ed3BRvCECqToysAwR28
X-Received: by 2002:a05:6808:1812:b0:4d6:9273:251d with SMTP id
 5614622812f47-5640de0ec2cmr2554682b6e.57.1793385287151; 
 Fri, 30 Oct 2026 11:34:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9218e97b0sm575039fac.4.2026.10.30.11.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:34:46 -0700 (PDT)
Date: Fri, 30 Oct 2026 12:34:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Maxin John <maxin.john@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
Message-ID: <20261030183444.GI3309461@bill-the-cat>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
 <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
 <CAMhs6Yxa0wdzkE3py=Ns5j+D8-8_+Z-ngnuxRKcTvQ+0qDpt-Q@mail.gmail.com>
 <20261030163953.GD3309461@bill-the-cat>
 <CAMhs6YybMn7Q2SqoaoU55s=b39LNufV=hT7ccAK9fD4sC4xxag@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TEZ6R655NJDXqSLs"
Content-Disposition: inline
In-Reply-To: <CAMhs6YybMn7Q2SqoaoU55s=b39LNufV=hT7ccAK9fD4sC4xxag@mail.gmail.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--TEZ6R655NJDXqSLs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 08:25:32PM +0200, Maxin John wrote:
> Hi Tom,
>=20
> On Fri, Oct 30, 2026 at 6:39=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Oct 30, 2026 at 05:58:58PM +0200, Maxin John wrote:
> > > Hi Heinrich,
> > >
> > > On Fri, Oct 30, 2026 at 1:26=E2=80=AFAM Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> > > >
> > > > On 10/29/26 18:34, Maxin B. John wrote:
> > > > > Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> > > > > built and run in CI on both 32-bit and 64-bit builds.
> > > > >
> > > > > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> > > >
> > > > Which tests? I could not find any depending on CONFIG_CMD_BINOP.
> > >
> > > This change is a follow-up to my recently submitted binop clean-up pa=
tch:
> > > https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637804=
=2Ehtml
> > >
> > > Following the review comments on that patch, I have also submitted te=
sts to
> > > improve binop test coverage:
> > > https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637974=
=2Ehtml
> > >
> > > These tests depend on CONFIG_CMD_BINOP, which is why I enabled it in
> > > sandbox and sandbox64.
> > >
> > > > HTML documentation for the command does not exist.
> > > > The online documentation leaves the user clueless:
> > >
> > > Agreed. The documentation for binop is insufficient and could be impr=
oved.
> > >
> > > > Usage:
> > > > binop op count [*]src1 [*]src2 [[*]dest]
> > > >      - compute binary operation of data at/in src1 and
> > > >        src2 (either *memaddr, env var name or hex string)
> > > >        and store result in/at dest, where op is one of
> > > >        xor, or, and.
> > > >
> > > > What is count good for?
> > > > What should a variable contain?
> > > >
> > > > Can we simply eliminate the command? It is only used by a single bo=
ard.
> > >
> > > I am not aware of any other users of this command apart from the
> > > gazerbeam board.
> > > Personally, I can work around its removal if that is what the
> > > maintainers decide.
> >
> > Perhaps what's missing here is what your motivation is for this cleanup?
>=20
> My primary motivation for the cleanup was to address existing safety issu=
es
> and make the command more robust, specifically fixing corner cases such a=
s heap
> corruption and crashes caused by over-sized input.
>=20
> I originally enabled binop while experimenting with U-Boot on the Milk-V =
Duo.
> There, I was exploring ways to manipulate binary configuration data using=
 binop.
>=20
> I agree that the command has limited usage today, and that similar functi=
onality
> can often be achieved using other U-Boot commands. I don't have a strong
> preference either way and am happy to go with whatever the maintainers
> feel is best.

Thanks for explaining. Yes, if you don't mind, please do finish cleaning
up the command and adding a documentation page for it as well.

--=20
Tom

--TEZ6R655NJDXqSLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTjQAAKCRAr4qD1Cr/k
CpIfAP9l/WcDO+rsqTHdOEYQtF/de6Yf0rjeX6SMwm6fL0WIXQEA9VIaJ0bAi3Ru
KLHCRVKnZ/rFxGkvGJaZ7q2Xr/4zcgc=
=CEY4
-----END PGP SIGNATURE-----

--TEZ6R655NJDXqSLs--
