Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A8AC624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39B2A810C1;
	Thu,  3 Sep 2026 14:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tusOqLPQXJDA; Thu,  3 Sep 2026 14:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 69BAB80EC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788445409;
	b=g6ykEcV8byU+pNjxOSqYKCYYdqNd8Xsd9sBNE7d7HkcfBXFnO8iEN1jkaHRw+0kY2NUh
	 49sxnG7IKI9dibGQb04OsJi3R8HHaAplj+nSTTVyLpy74auIs9utCuPjAFyD+0u2VoFk4
	 FiqlUno18EjZ6/o6Fcp9Brqq2IdvETt58As9mXre+aTJX1LU0YLah9AWhSbjCOqASfYXG
	 RZQ2dMK8RWuybFspmjFtReprd/wHkincXXYLxpTrfKb6zih0L3p2v3M3bRzP+1mp5U614
	 jIgxvwj70md8zqtBqIhSfdnILGDGbtyu6rnJtnOoDCba/MU9xO2IM7LGXYNLlvIrLSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788445409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RUtcZnlKdJtjbjwJNU74B0/YG3rqL3PaGo/8enxS5wQ=;
	b=qfhzTcU1PM8s2OsijyRat9Ty3hVdyAi1tcXvo4yqEqOA1Srjv3cYLeaPlT7NenPjL3tI
	 /39Y0LTtTpPf6EfeiJjmhfgH+UKbEFaA9N7mEZ+djbitU7WIBMweYYD4j44v6cdAOtxuf
	 v+eG5wiE7W7hVQFRnGn84mUf1en/wnDmfJvC2L9l0XztxaFTSH4dkKYOxZurZQGoSp2pB
	 dwHVfT6TgKd5UHIjgKDGn3xPw7sVFf2wWlHVOvIUZdmEjoRz8wjkyIVA4QkZ2kjkyVuwd
	 jGoYh9u7+zAgFdVe7bjbVIn1XbiMxZw7ZITkY1rFEYvMaEEml0TH4Hq3SlD49mGjHVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=hGO7VSP0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788445409;
	bh=RUtcZnlKdJtjbjwJNU74B0/YG3rqL3PaGo/8enxS5wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DCT3QbjsUwY0cRe5PWJiysNhkkx4pT1C5BK3oI9MmxPXLe2Z3DFxs2cNbsIdYNWQI
	 IR/V0Utb0EN9TweGH0leu/Gt31g+aFNb7+aVYtdKEifI8rA2/rwp46Xpbf9ZV8D3vR
	 c9olELuXrfBbuflkSqu1LSDyTpLG2eDRuZ6zsH+B0dkWJihbefKgEZzN9uLJlca+/h
	 FxD205CaPedIkba8pqX0MR7PZHDVPaASLlsDjIAb1ilb1VyAlFPoBcEvDVnZjgiiuD
	 T9TuVdKRelEy1owZuuOTipUsmY8qeIvcurlmI2SBJ2qP2wOb810aANXXzBURwIJeie
	 eHywG5vTTRwZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69BAB80EC5;
	Thu,  3 Sep 2026 14:23:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE6732FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C45B680EC5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5GN-mpFPZCJ for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EE2A680DF0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788445408;
 b=cQUu3jQx8n/sSfU1yifFjbnbgr9cSAyfJjpFnHiSF5jkHXAANJf0RR6d6oRexzj5U2pN
 INmExBb7Oprc6jI6i1SQGDNOM+2ULFhbdtL1u/XGEpl7FUVrLRtZTcMQCRypvv4Q4p4an
 L6qZCs/tCbB0Nwg4XmkagbC9ViVoHK90hrzeU9ccfgpbSwMBq+5imdDdw1aK1i4oKlBF/
 hYCpkRJekPCQ0Eq5Q2qHpCx2D+ySb9syYKVMIefS25HR6EX6FarUU9yBQnl0oVM8DvSjw
 paRdHVwZkwZGyl2bXSlPS1cOts8aCos4cYFEW/aLhv4kyGsdS2Ze7IeeR+1orvEyk+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788445408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=RUtcZnlKdJtjbjwJNU74B0/YG3rqL3PaGo/8enxS5wQ=;
 b=RkReDf6LhvgzlERELuwDoUk6FYQN6tLOh9/279Y+GkZJsKk3Bi7veUFlgOFtq/CkDTx3
 HIf6wAIfw2pUcExWMPr65RXbpxWwC8ddjz9/wvipwYJcpBjwP/GPMYuA2oPoaAcQ3/iCd
 FLLrK9ZEGB8o/bZ3+gKzeCMThrJwEXI/WJAyfQFXOvRXeCt8CVjOPVZ8n/+MnwHP4vh0K
 Bj9ebV4xgRUAOHOEE8AEhoYzEYFA9D5c5RuYDyb3WkCDY4sLjzOUpTpPtS78oyv0DcuMh
 53amB4kPBHjp2Xomw5we+pwG3coqkNcUv/GHp37KkGcVa5u4MYR7V8RqdVSiry2+PQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hGO7VSP0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hGO7VSP0
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE2A680DF0
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:23:27 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so2545297a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788445406; x=1789050206;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RUtcZnlKdJtjbjwJNU74B0/YG3rqL3PaGo/8enxS5wQ=;
 b=hGO7VSP0ggTJ1rV7kwn7WkgW/b2M5Q28KW+K0W9X8pbLnwtEZoCA7W+Vm1TGYj8Z99
 8FB2QaQuaeMfpHCY9hRqF6SLUPnlqbJIzs/Ckk4oSUE+bQO87Atm420dIV5lMomXD9iC
 /5DaInT6y0v3Kg5RJPrmE564X7oRZa6TLCpQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788445406; x=1789050206;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RUtcZnlKdJtjbjwJNU74B0/YG3rqL3PaGo/8enxS5wQ=;
 b=ACDZuZ4rjHYmbttPGAD2ZVlbVlb6WeyF7Z4j3+cgyksToCYyFPieI6bvlJKGK4EMEy
 CuVmItDuW+6fvfsGeBHcMTFY/B1QN7PPOzJKbdOhlhBUEUzf3pgp1wI4y29aoW6aF32C
 CVJ7mCF1lxJPlued3gSAVyRa3B0UkPQg4bDyyui9HPx9/RZj11VgcB9p1CBBEpKARKLH
 Hpu2rq9lmlWhQqbBVRqLFiCMs4QLywZ27DUmg4Zj9dHXhkaPc0JXUw4at7x6Pq4I8a4F
 RkllBwBVSo7jc+9Q3mrJhMZBwtrZWtVSJt/YdiyQuyxXArmQ34EbXNFJYi87cygKrxP0
 KrIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLKUZHp0jzNF/pi2qTUhfRlURSOPE1Fk5v0gX7K0eWcLBUm9rT9dAoz/GDvr+80HraCGtKcro=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l9JoVfCU3BIEAuLdALkMcaNpWlwfIFwarIIJoJc30tAhwGMTDD
 BvHTEpbfdtc7uBZKlmZ4KQWe6+2JrdvCLJAGTmL+xivmUq4wdzWW8Qjt87G/gcJwpPo=
X-Gm-Gg: AYBFou3C1hovrnl8nM11hMJy29yGcUM2dknSYH7VGRyxrfmjrSii674Hyjb5In7U3zb
 N8LBdTzq47SbwyCXk3arikwecEUqWSeqD6LeAIIAYfIw0PJo5uUvZqnxB0wpPODL/EphyPtQjOk
 M7FsgU5JDw16Tk9BjkpuhXfcuZkK6B4pO4rGBcRF0fr8YRzILyy06FxL2X+2ija3yeXsFyPYE7J
 oPrtpNStmfOsDIDYVBYr92AlXJ0drhlLq6l7OWa13OMGdlMbpxxRO2Sc781QIhf7dhoOdHmmJjQ
 UHHI7ndlTp63o0csvzS+95tFhIuNZRwAxc9wGmieTDBpIhI1j2u8yeUDr4oLvypfQ9gT1bZUz3/
 Sx+fJo05jdMBUstrj1a3wXbZRVCqGB4IgFahkCU+SdwNp36bBq1i1hVWx8pNBJ5yHG2aumpSWJN
 XFVTwQ8lT+aodM4Ny79jCuxz5qj1Qd6diy+t9twge57ICxIdBRYSgDall46UFbj7RMXfMpP1iM2
 1q0Bx6qG5WLV/Mje0RxjLdTGmnWHKa1yB4k8shAL1Lkb6A90+lGLUthSsPkzkH8I4mwdkhViSnJ
 s8VdkYSFD6g5K93CfYsH
X-Received: by 2002:a05:6830:81f0:b0:7f4:f9fb:fd28 with SMTP id
 46e09a7af769-7f77f0c8639mr12474051a34.2.1788445406380; 
 Thu, 03 Sep 2026 07:23:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f74d2a7763sm5038078a34.12.2026.09.03.07.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:23:25 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:23:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/2] video: remove show_splash()
Message-ID: <20260903142322.GG1764417@bill-the-cat>
References: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-0-18c22bdd9f2d@baylibre.com>
 <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-1-18c22bdd9f2d@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PtIW713YIeVrpomn"
Content-Disposition: inline
In-Reply-To: <20260903-fix-build-with-config-video-but-config-video-logo-disabled-v2-1-18c22bdd9f2d@baylibre.com>
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


--PtIW713YIeVrpomn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 03:59:34PM +0200, Julien Stephan wrote:

> show_splash() computed the result of video_bmp_display() but discarded
> it and always returned 0, so a failing splash display was silently
> ignored by video_post_probe().
>=20
> The helper is a single video_bmp_display() call with a single caller, so
> drop it and inline it into video_post_probe(), taking the logo from
> video_get_u_boot_logo(). This has the nice side effect of leaving
> video_get_u_boot_logo() as the only remaining user of the logo symbols.
>=20
> Since the return value was discarded, failing to draw the logo never
> aborted the boot, so keep that behaviour and only add a debug message
> reporting the error.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PtIW713YIeVrpomn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapmC1wAKCRAr4qD1Cr/k
CmHYAQCrdbQQG9ViIxIoBgtypdCiFILAhVvJiweFckX7X/7bswD9EnOUuXwg0eI5
Zzf44AJerf7JqKIDdsm6oAC/Rezx2gw=
=rZ/Q
-----END PGP SIGNATURE-----

--PtIW713YIeVrpomn--
