Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06550C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3154406E4;
	Mon, 20 Jul 2026 19:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4YXco7TOKK3; Mon, 20 Jul 2026 19:00:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03F41405E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784574002;
	bh=ojWOuV1AHcned5zr6qVnqy7tDmQvUpcwlZ8+2vs9K8w=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=V7kAPZatFx6nlRLhvBO4xLYyOaIVWOCM+q40BhqLGXYnpzk0mUSalZluOg16pnH3w
	 nxIwtT2nO1PZ5lAdKxWMcjabSx9O6Ng+DPQqZkjo4OadJyS9bFKubxPZi1mpXmn+nJ
	 vMdq5QwmRJIU/ianfGycDJcb9mPQT0MVLADCde6igBwK0fVjEaR2JlkJiDluuNQ9GI
	 SoUorh3SRKSLnG89CvM8QPcR7ey+X07WzjNHPk+c3EoOnaFfQhWtbAl7iTaK/oDOOl
	 nEsZxUJaEAdHniYgD7qp9JFvMe+OpVc5o9+IPIKoKi7l+NPEs2NavgjHTXEtFAIe6d
	 hz6R32xwTxxSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03F41405E5;
	Mon, 20 Jul 2026 19:00:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D35441142
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9102405E5
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:00:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vlVrCvSx9RY for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:00:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2e; helo=mail-oa1-x2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EA31940599
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA31940599
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA31940599
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:59:59 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso4741986fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 11:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784573999; x=1785178799;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ojWOuV1AHcned5zr6qVnqy7tDmQvUpcwlZ8+2vs9K8w=;
 b=BS0mFro4ZsWUaZm2AJhPsaHq06H7QclhrigDoLTzhxQ5z/rcCv22ttwqevhwKg998A
 swnKMnEa++C6ouxQl9af7MWF9tcTuOa2Kc65ugdvBNftdUtpqLWQxXR7H7qBY7Ynn7EP
 HLL9Njfohx8rxrferVUspS7Xizjk+siahMucnEPil/mfFrWOlES1VKkebb160woy6xPO
 1Hb0+uPiCgpDJxXTmh/tp54lT3w9h4GSTxV8E++74HS8mAWRWo+mSSwj7Pk+hA+1vJwC
 2tZ/L1n9HMnZFk/d6008V11DU03pUns4wlUnv9i6Eema2tR6g0Z9dAMolSq70Y/6hl1s
 2OsA==
X-Gm-Message-State: AOJu0YwePYmkwyS+naihQ/Jl5pugO+Asq4BC5lVIN+D1Y/ATqt6YIZyl
 aJZMLGG0f0ljE97sJkR8dVhnrZWJsf91PtMQEVcRHhnwLZCc6zSXKtdNww36zoJmg6s=
X-Gm-Gg: AfdE7cl6ZpMcXMuW3cqRD26E8neE7/rRL0aAbWOHx6zLOVWBjUO4uhPqsj9yxEcIfvj
 TO/LgC18iP+eg4pWQM93iOqvsEzNXBBw01sJAwIPfavjuJZNmewcza8/4vaxkEfLN4SO4IJdStR
 fZtDFNCWlXD/ir6Rt9uC8hCEgo4hpG0wl7PhaETgEbyL/PzF4DtW9txvY7FPCynJe3RPH1i4SKZ
 8FQ3ZF0nZxFXxHNAuhMcnYefVo1psfZAOOoZAHtYfVNESSzyJnetozu4FVZUhLD7pi5ulC4U870
 LgEO+hwOVFp6mDtK39gijbQrQECF1iOC9AovLZAJ5Cr+wuVGubCVjqnZyHuIpqGuo7umxSQTyiV
 u3klLT0ygSZSgHSDZG0wowph8WvkSJ8uiEuzaP9DmLjdVU2M+5S/+rnN26/fOZpUzzfdj1i9/ze
 c8BNbtyG8MTP3HW31N+1dIKPx9K10BJjfvxVm29K/JVXpQgRp4dAg0XchLXxMTdOpOlYRI+1cHs
 w7TJFCytKg0JL52SuWbUsGAvZc=
X-Received: by 2002:a05:6871:3313:b0:43f:a479:d464 with SMTP id
 586e51a60fabf-4569012a485mr7293802fac.9.1784573998729; 
 Mon, 20 Jul 2026 11:59:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e141783sm9721170fac.6.2026.07.20.11.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 11:59:58 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:59:55 -0600
To: anoduck <anoduck@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 The Anoduck <anoduck@protonmail.co>
Subject: Re: [PATCH RFC PineTab-V DTS File v2 0/2] Pine64 Pinetab-V Device
 Tree Support
Message-ID: <20260720185955.GF749385@bill-the-cat>
References: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v6ebEp2znWAowWs4"
Content-Disposition: inline
In-Reply-To: <20260719-develop-v2-0-91fdc4cd60a2@protonmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784573999; x=1785178799;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ojWOuV1AHcned5zr6qVnqy7tDmQvUpcwlZ8+2vs9K8w=;
 b=Dtr1JEyeuJ5OHXkg0z05kQdjijSD1HnIiAI3mL/IdT/ZJ2bU4u/D1uHn3/QG+Uik1Q
 7P2PBVDNS/m0olCIvXXbV7m9V1Dvn/8ER1xitU/3C7kNjBMNjNreGsY5h4Bgx1Suafc2
 mwR4XftIMsURZ6mEypxJFNLeIDOg9cQcANJq0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Dtr1JEye
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--v6ebEp2znWAowWs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:02:16PM +0000, anoduck wrote:

> Provide support for the Pine64 Pinetab-V Risc-V 64bit Tablet
>=20
> Signed-off-by: anoduck <anoduck@protonmail.com>
> ---
> Changes in v2:
>     - Device Tree split into two separate files per request.
>     -- File 1: Previous Community Additions
>     -- File 2: Addition of support for sd card and EMMC
>     - Location corrected to `arch/riscv/dta`.
>     - Link to v1: https://lore.kernel.org/r/20260718-develop-v1-1-d4b5c06=
75f87@protonmail.com
>=20
> ---
> anoduck (2):
>       RFC: Pine64 Pinetab-V dts Device Tree File
>       RFC: Pine64 Pinetab-V Device Tree File
>=20
>  arch/riscv/dts/jh7110-pine64-pinetabv-u-boot.dtsi  | 1756 ++++++++++++++=
++++++
>  .../riscv/dts}/jh7110-pine64-pinetabv.dts          |    7 +-
>  .../jh7110-starfive-visionfive-2-pinetab-v.dts     |   12 -
>  3 files changed, 1760 insertions(+), 15 deletions(-)

I hate to ask, but after looking at your codeberg profile, are you a
human? This is also still not right, and my explanation before was
clear.

--=20
Tom

--v6ebEp2znWAowWs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCal5wKwAKCRAr4qD1Cr/k
CnWLAP0cj1LdWLXFMeCgrCncBe3fSIK2sbCPd1Iqc9Kz5Dq+VAD+ImZC9Z/HqcUq
KyfnWKUnETR6wnelSHJUfRLOcOc+bg4=
=i1mY
-----END PGP SIGNATURE-----

--v6ebEp2znWAowWs4--
