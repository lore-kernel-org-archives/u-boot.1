Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8572606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xDXV+sls;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=YrHmrNrX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A63B7812B7;
	Wed,  4 Nov 2026 19:15:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfAz46uwVpXY; Wed,  4 Nov 2026 19:15:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DBEA6812BB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793819747;
	b=c6HrfXs/YFtYqlNzMxAicgVmcNkFva4BDkE2La5MlNNWkZ5ElbCtRc9a7aRtWQFSLcxU
	 KW2NEXnjcSPIEEYFXnDs8oTn7uscEnOOak6klSYCQBr8pDy5jTMvfUyHeZc84qOGZLZtT
	 NXbLSkDuABjE7ttEKuJEWfIfkDp5PNw+hOkRSsCAhzgyhVQwRtdzG5jd8E+6Az+u8f7Nh
	 o8rSXm4PIsnqX1+4BFy51cQ+Rd4aX9jpwWPvfKyDKTx4OIYfP+XbYZ1EA67svcWZT+MeX
	 McCK3CswGlPCDZZ7G4O4rxPpb4tRzLA3eAA/qEeEmmtAFPq+PspdwwdzGjBMpXTi6fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793819747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=scqfjj2xFpEdlDPDhGSFfkUk8uvLCDwC/NX7naViifI=;
	b=akyisI9REd6ybml3MI+EwCkX2RjGseiYgSe4Iy8Jtht0t8s+K4645X11wX7GQvWt6jvj
	 5Ot8hkGF7iVr/WBv093U056sfJHdOakfgjDxcwVfOSkNewPmxEfDwoJkQUKJOhgRyv016
	 dwIHsfizAz87nFlarXS93svVDjTvk97NP0ysDoyitQUjIjTvvaqGMl3TMh0Z9FexIVLmd
	 25JRRT9Uw8s1Q0ks0HgiNL0TGrKpln5qx5o1x+CzdQpxzo8MZW1rmPS1V4xPeCACLuDZR
	 b/Ap6WhJYl/vH4JXeTIel+iHVcNfUD5eyjUhHMcbMddKbeU2AhIBcfKtLj2RXfwEXrg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793819747;
	bh=scqfjj2xFpEdlDPDhGSFfkUk8uvLCDwC/NX7naViifI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xDXV+slsC0hHyb+zTGbQlVcX4FIh5XH8vSiRbfZJyxGV3hO20W6t14Zwat4Y4YsUp
	 oayojEt/J7ZLK/7od63F1QRKnDNHGiAzTx5094uymfspgR4UQHpMR3qjzxFKjzuvsU
	 nenYllXJBwNuVO1G9W7D1TVwzOJiFfe6xYoexRnXTrOCa9TxQYD2uZkuOWTsObD3ut
	 RsoZJ5qb6GP6M6OEJqQKSqL4TQI3312ba/pJg0lJvm4gP7IKITH8WxkzH2gYtWwM+q
	 Kjt/C6olQuyuL1G4NZ8ulUQo6RQQ05PBa9a2cBdAGWOmgwiGwMKPM2yY24vSRzSMS3
	 rTJWFL4bRomAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBEA6812BB;
	Wed,  4 Nov 2026 19:15:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE4F49C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9FCD44034C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:15:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAOCreKvTGSk for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:15:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B24E240062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YrHmrNrX
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B24E240062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:15:44 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-825b40f8a26so498580a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793819743; x=1794424543;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=scqfjj2xFpEdlDPDhGSFfkUk8uvLCDwC/NX7naViifI=;
 b=YrHmrNrXxIf4weJWOHShtVdG0czM9kjvHa7Z3S6balYwolF2iC1GWr6HXzCUf9XSOr
 LNbQaQW3dDJk5o/cKlMCB44+l8Cq83V5k8TPQ9tere6miPhx2+GJuWFVfpDO5fNikAi8
 5Kp7AdXF1OIDJ97W/gtsc/cuJrwktxPBgwkRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819743; x=1794424543;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=scqfjj2xFpEdlDPDhGSFfkUk8uvLCDwC/NX7naViifI=;
 b=1sa/IYhf+JHfPIE+0wZLH92cknkcFdRvIrNPrAH3LFZ2CM0Ua/ybx3tmt+OJLMKFFn
 qNTKWBQAV1tC6s3RArM/jB8Q/KtNBCndFK2qbJ9O01XefJm8IX6bECPaV5BRc7BcKMcS
 EfAZ5rkqe555LnPF8Jb3jAeWvLtWspFiZ9EagpjsDqTuGc3WZ1i9xOlt4cQ0eazU0qXY
 hZqaag7vmtgBrzcuLxT89vWXABq+XBUKjQ1swFFMyHouZxUCx2V527OnGu8ZVNO5EWmT
 yYB442yhwDFJ/Uk/zJLxwqjy0gWVnI8PKzh83UrW2mWjQiKS8PNQE/0hvfLZPnbgJH/I
 DqHw==
X-Gm-Message-State: APuU4Z/MtECB7E9Z58ohedo3Pv2NYsdXVw5hRWcUY7Ugudd7stOKMvV5
 ErETN0XX/pnpe/3GZ0OQJqsnwSjfPo8q0dNj3y4KOigHjb/KdPyKV3hEagEHJsgcO40=
X-Gm-Gg: AYBFou3s4Yp1FHCUrcoD2VJ40iNRtWOkUPxL7K2SY81PfpR+SduEE6vTm4vRy9QkhCl
 Cb/SaqmcQaKP99+fcu524+kEC+YZzgxBmw0FsAp5WkvHbZMwv7HETzSXEZyUPNwWG4p0nMduYuH
 a8jpmt7S05LqMqAzhlM2n9FCuHtrRBMZmDPd6ohrNMtXKXLGorC9Sj0klQcZFKjsjsUlxij2xxr
 E7XRH1DVz5VB62/fSKb+pcb6AGJRRsG5owKpMYeMWdJpKlM1l9bWua8K1xhRO6jfPL5kNK+sxGm
 u9EK/TIx0jazDpv4nu7JfCiFaUDDwPck5d5cWCp3+SEo9SYm99vr4SCn0osO/8KuyD0pwhl+oHy
 PgZ4hRLhM+cTntB5/CnYqxBT7AiHP/Ps6bfZ2vdXoLp9mwXYt9sU6L4E4M+3MKODFco8lLiohxt
 FoLZ17Y9ZEnD81aFPGmix1gxOsi5yUXBhIBKYXhvQFQUs9U4wteABfJxyDGvXhqJnDf09nvQAQl
 bIhIc5eaP53nB2oSIfNXee5hH1uzqTw4Ua11w+b1+eTzbPzNWuBX8oWLXpzpJLXC8EY+KNACKpJ
 w7nupziPlkU0gFTabclu/E4ezgoPW213VDId7UKUstCpXCCMtC05KgbkMdVi5PfjadqlIP+I5aN
 8Vy8n4H+zcSUvadmr7J3R9dMEEJuuK/t0NDuij2X7lF1pkZuw7OXkkjEKleWa1leQnUjxZOGaCq
 GUnSqZSyH8r7dvu8Lly8Ms8g5Dm/LyQQ==
X-Received: by 2002:a05:6808:23cf:b0:53a:e153:e8e7 with SMTP id
 5614622812f47-5640dd8a159mr11960577b6e.44.1793819743138; 
 Wed, 04 Nov 2026 11:15:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea4903e9sm2667990fac.3.2026.11.04.11.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:15:42 -0800 (PST)
Date: Wed, 4 Nov 2026 13:15:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 ricardo.salveti@oss.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, andersson@kernel.org,
 nicolas.dechesne@oss.qualcomm.com
Subject: Re: [RFC] Qualcomm Firehose flashing protocol support in U-Boot
Message-ID: <20261104191539.GB1164024@bill-the-cat>
References: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lSlX8+mRzpR54fLO"
Content-Disposition: inline
In-Reply-To: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--lSlX8+mRzpR54fLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 04:57:03PM +0100, Igor Opaniuk wrote:
> Hi all,
>=20
> I'd like to run an idea past the U-Boot community before writing any code.
> It touches the USB gadget layer, block devices and a protocol U-Boot
> has never spoken, and I'm sure your feedback can save us from wrong
> turns early on.
>=20
> Some background first. Every Qualcomm SoC has an Emergency Download
> (EDL) mode in its boot ROM (PBL). It is entered when no valid
> bootloader is found, or on request (button, test point, reboot
> reason). In EDL the SoC enumerates on USB as 05c6:9008 and speaks
> Sahara, a simple protocol for uploading an image into On-Chip RAM. The ho=
st
> uses Sahara to upload a "programmer", a SoC-specific
> Qualcomm binary (prog_firehose_*.elf) that sets up DDR and storage
> and then serves Firehose. Firehose is the actual flashing protocol:
> the host sends small XML commands (<configure>, <program>, <read>,
> <erase>, <patch>, ...) over USB bulk, the device answers with
> <response value=3D"ACK|NAK"/> and <log/>, and sector data goes in raw
> binary between them. This is how Qualcomm boards are flashed in the
> factory and unbricked in the field with qdl [1].
>=20
> We are moving Qualcomm boards to an open boot stack: after the stock
> XBL, TF-A (BL2/BL31), OP-TEE and U-Boot replace the proprietary TZ
> and UEFI stages. The Arduino UNO Q (QRB2210) PoC boots this way,
> and the platform support is going upstream in each project. With
> U-Boot in the boot chain anyway, we'd like to reuse it as the
> programmer image too, instead of shipping a separate closed one. The
> code that boots the board would then also flash it.
>=20
> Hence this RFC, before I write the code: would a Firehose server in
> U-Boot (a "firehose" command) be welcome
> U-Boot community, so that the existing host tools can flash a board with
> U-Boot as the programmer?
>=20
> Why not fastboot: Firehose works on raw storage, not on named
> partitions. It addresses any physical partition or UFS LUN by sector,
> creates the GPT from scratch (rawprogram/patch XML, sized to the
> device), provisions UFS, reads back and verifies with SHA-256, and
> selects the boot partition. Qualcomm's build and factory flows already
> produce these XML files, so a board flashes the same way from EDL or
> from U-Boot.
>=20
> Two ways in:
> 1. Recovery, as snagrecover does it: the PBL loads a DDR-init-only XBL
>    over Sahara, that XBL loads U-Boot, and U-Boot runs the Firehose "serv=
er".
> 2. From an installed U-Boot, like ums:
>      =3D> firehose 0
> and then on the host machine:
>      $ qdl --storage emmc <devprg image> rawprogram0.xml patch0.xml
>=20
> The first version covers configure/program/read/erase/patch/
> getsha256digest/power over the blk API, with eMMC hardware partitions
> as physical partitions. UFS provisioning would come later.
>=20
> Main concern is XML. Firehose only needs one element per document,
> with attributes and no nesting:
>   <?xml version=3D"1.0" ?><data><program A=3D"v" ... /></data>
> I'd write a small in-place parser for exactly this subset (about 150
> lines, input capped at 4 KiB, sandbox tests with malformed input)
> instead of importing a library.
>=20
> Questions:
> 1. Is a Firehose server acceptable next to ums/fastboot/rockusb?

Yes.

> 2. Is a subset parser like this OK, or would you prefer a generic
>    one in lib/?

I think a subset is likely safer to validate than a generic one, so
that's the better direction.

--=20
Tom

--lSlX8+mRzpR54fLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuEWAAKCRAr4qD1Cr/k
CuEBAP9g87rTz5jB+dy4EGpkYo6KFMpV9h2NFGmbiqoFkqIrKQD/R9cwZvxYEU62
6w/EHgD4IlwknxyDNjUmleQNauvpvgw=
=bEBy
-----END PGP SIGNATURE-----

--lSlX8+mRzpR54fLO--
