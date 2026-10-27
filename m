Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D3B606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n/8HrpGo;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=jIVuigvX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B2EB80CF8;
	Tue, 27 Oct 2026 19:05:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ePcXn1OEli6; Tue, 27 Oct 2026 19:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 54F0D80D01
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793127920;
	b=MznpxoewbhIYYq1QKmINsmGqg1MxqKlEiiMoaTrSakjzn1teU23OaUWZr+8BapuD4Hxg
	 qocVhO21s7Zun70vdJtMHJ6XjiwF5giOaa+idNqnMnrYnRK8Tuo4jLr6JwNdwnptnd95I
	 zTT9mlhaNzT4UNEdz2fx9BWNa4xpVHcz0gVD4M5LdOXs4+okoCBVP/RA2kwVOoegGXYGE
	 Ki8gOrLlAUa+Swyl/dzkznXO/vEAXhw//QGPUiKzIVj7yPAunWCPCrGvY2OfmeqIEaELc
	 ajeKyMEnRDaHlvE8krM0ESFZVzLu6jV50W1VnirTsBBt4HG6Jh5+r4zreTWH8jQS8ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793127920;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8IBc1sbI5BswwzoBa4K83ve43/AOGhFDiZ7UB+6uKgc=;
	b=e7ukuuX7Uo3zd3dGa2+IThe7xS7o8kyPa/ltSvGm5HMNn1J9ajX20uNC8AzHzPGzYE70
	 mznhe+FT9x/mOqUmI6OerBOkQ61dQZr5r9UtHrpZUt7Rg/ak58faoNjFaoVhlnl2KFc4f
	 QLlOfF2ERGPU8XvC8V8sg6NA63fvA80H3MWf/7/jPwbsYXroXYS347oNyb3CUw5snBQ8q
	 7dR4DOfr95xBOqMXC4pFXBN6Ex2mznDKnk1VO1taZn+7ayUeq2nHRboC3Dyu9MytrcFlr
	 jSTfIC8ZQoA2yUj8LUAf2Ye1ufZUcEYPJOyzc+NoBPI1Xh0TmBus5QcfwvJE1MPdirg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793127920;
	bh=8IBc1sbI5BswwzoBa4K83ve43/AOGhFDiZ7UB+6uKgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/8HrpGoirEaJPBcOYZLHXbP8NrODdK2EFW2b/ktQt3+oJ3qFvL+iiXZPRFqtLxjM
	 PnhUL19SaebNkNMuwbm/TlWqt4XsUSTcNc5mnO84xoiwjlBTErbmuXKfemhU2n4KhY
	 1PfQ3Zop0kU6yi5hBTdITBEt+GnLX40IuMEyYhcc99T8ukfEWLx1fAR1mjeeV5qqKf
	 5TBnXzT3DaU8CorpBYnGZA10BlUrySeODUyfjWr91MrX3sC1gN8qWnIDIVfNAyiizD
	 ux7xfFsiwCF4Klca+zVQpKKFC8ruso3nY1FUV80R3DHtga22bY3kHroo1vKvAlmIGy
	 RgTHnCbrmt2Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54F0D80D01;
	Tue, 27 Oct 2026 19:05:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FC56473
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D7414059E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LILLJ5HMUKJr for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 19:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A0A74058E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793127917;
 b=pqpf9T0YuVJFYkK31TJjDl+kECigZHHPb9iRiul8rlyZLuCBPRFK74KK4hegLc5CJ5Br
 EVvlmTzWzTpQHobtcFrNaOmWnkmVY6etXkEpwaGERvK08rXKSDwbJbm9AT17kVWALNH5S
 GHblYZcgmYGQmKTPVgd3vDtiTDkS2vtGW6zpThbxEJhOSbRA01G1bxqoadF3E9bKDvr4W
 ky69ZN32NdmFO+ZT18i01eknCl97xillPQiDlrus2Xss6B28RTjNSXvZZ4O2WiqSSJRIs
 sKtPEG8oDiXCD0IuUeNboIjZC3ov6hPlMOwHUbrKotg4oBiJL7zsmfMxyYCtXiVwtfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793127917;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=8IBc1sbI5BswwzoBa4K83ve43/AOGhFDiZ7UB+6uKgc=;
 b=KVm0yw6ZtZUZf1Z5DqTAXbFQMig8r/TayX/+wI28JsRqnQRFKag81VsoIitr2EWyVum0
 ztxB5W7+SuvLJb/QVFCyRatobzv5Ia1Ua7UUMK8lMY2oG+4lf9TTENQxOiAoHuorbQGDI
 b3HfAFWC7Kg04xXqR90dCHlZGscqnGohZ3wsCftE0qvBpiz1vFj9JfpXFjqPaXvPaWOM8
 B/jto8ljlG4AWR+QuiqDX3n7QxXlQr7QeN8+AEGtTmr8RJoFFwn1H59GUvlmqDhJJFTVE
 Uu59PQuoun7y5QpFkZjUDnOYUsP6i87MJoP3ogbyyyww4z9eHXC6INDzdwoxyBTYNMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jIVuigvX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jIVuigvX
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A0A74058E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 19:05:16 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-8446af403b5so123023a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793127915; x=1793732715;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IBc1sbI5BswwzoBa4K83ve43/AOGhFDiZ7UB+6uKgc=;
 b=jIVuigvX1OGkuRXlQMCTPkAqfwYiF87/iWSSJWgztRVNDhQy4n4zqiuI3ojBXVWsT0
 uBYhu1RcJ1cC9QHArwXcPhISfFSlVdYzlUqZtD3JHnuJJUu1IS/cHWYLQeAshKV8LriV
 MtNCa6zCOgGDfbTHW/YmedxsuWaC5ubEbY8ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793127915; x=1793732715;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IBc1sbI5BswwzoBa4K83ve43/AOGhFDiZ7UB+6uKgc=;
 b=yxRoBtR2OnGDW1ZyWxpA3Lu0eT4+HLKU5bLxnEDlQNl+64z0w+FGcxC953ZuskATuw
 2gLs+tTPd/6eNrd1C9JwCYQqMLfUy6HW5j+Fg845DqcId5ymWfNemoFS+dZdRACfmgNc
 mauXjt7ykPz4N+HLPR8j1qK6X1cPjyAYiWjOjBzc2mRBispkNxwZpRhJrLewGdd1DfaK
 9ZRMzOqHKoLNoe1rRz+pEsZR9KxsYZdrd/A19+ZZSANnWKx8BHNyCxcX9x0ZXbfHDjIR
 BqZPQpyBMxEStlFP4ZqVfcNORC61TnnKBViVU98mdaj0Cim9dyi99KYivlSTJXQFLO6Y
 0z2Q==
X-Gm-Message-State: AFq9FYJnxwNPwOBFfPALQwcXOlxAUnBY3+KLBV+fw0L33E8AVZWEAquk
 f9qMH+TnBAgWzSqKEVB/R8X09SN9u8UaQTBP0eAft7USsBvCjhXnjiAB8t+s3NwTjVs=
X-Gm-Gg: AYBFou0Xlp01ZhGAV90yUfo+V2UzQIYqwRG/q/Vaccg6ewiXyWPPW01q/N3LOLLvWdw
 Nk0b7mzp9eGmBFU/Mtw3nS+m29PCgqS0z9D205rHyRrAYQ6fPUbH9nYn9OjLAsbkVFAHVGSpgjP
 tRrdSXzWD8u9wTY9eJJZfPPhIGyGVM97vihDHjiHMkqmEd564nhixX6Upw7lLVDO8H2j31y90nb
 sPbZX0ujiKLSQ4UOdPdEKQsWKO0BxCf/gC0BwVbA+Q/Sc8lleV4NAaw6bcM+rH2u+T6YeZfxTNk
 grnNr5hV0mYPPiOEB0tLRpe7DWYq006jQOdgcSY7kw3TVVBv+KCgUmU1bWd44XcG2pQub0Gdd7E
 YTuW8dXbic0HLqwV5c/C44j4HXXyQ44rje6JaG98lrnQQYVd8Z0I0YuR4ulPmYRfv0lbAW0VS7z
 uu1Pn4FR12Kh2+hzaxdBOPZxzipca4xWSrEdfapxoyBvuCBx1H8SnpH3aQ2Ts5fGfmINTKmJ1q6
 MH2NEDVq235b5CsBweDrEH4HIPQaZNiLwGh54TWB+L/aPPk9wWPiCbC2aX+h7PmjxODPu/EwO6z
 rwaElh+m8Ef+6yABv1IGeBUt8/gHTqUnKNwipva3wV6BDtDrgC588hvLqqEyzkA1CQcM7fHQW3z
 uGqJHZ9Sgd4HbJ9LTXlWy4UGdYumjKCc7Kix/HsgZRJJTPrahAP/9N13xqw==
X-Received: by 2002:a05:6830:b16:b0:845:3cfe:601 with SMTP id
 46e09a7af769-85ab2504c5bmr586815a34.0.1793127915189; 
 Tue, 27 Oct 2026 12:05:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb649b53sm12518829a34.16.2026.10.27.12.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 12:05:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:05:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH v2 02/14] ARM1176: Add support for
 CONFIG_POSITION_INDEPENDENT
Message-ID: <20261027190512.GJ2177077@bill-the-cat>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
 <010701a17a6ca917-f82354d1-1e8e-41a8-b262-3561e8dbc69c-000000@eu-central-1.amazonses.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ildGY8bdQj2QXOg9"
Content-Disposition: inline
In-Reply-To: <010701a17a6ca917-f82354d1-1e8e-41a8-b262-3561e8dbc69c-000000@eu-central-1.amazonses.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ildGY8bdQj2QXOg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 10:55:03PM +0000, Vencislav Atanasov wrote:

> Copied from armv7/start.S. Tested on an ARM1176JZF-S SoC.
>=20
> Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
> ---
>  arch/arm/cpu/arm1176/start.S | 42 ++++++++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
> index d3ab5928eee..7bdcb5fb97b 100644
> --- a/arch/arm/cpu/arm1176/start.S
> +++ b/arch/arm/cpu/arm1176/start.S
> @@ -37,6 +37,41 @@ reset:
>  	b	save_boot_params
>  .globl	save_boot_params_ret
>  save_boot_params_ret:
> +#ifdef CONFIG_POSITION_INDEPENDENT
> +	/*
> +	 * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
> +	 * executed at a different address than it was linked at.
> +	 */
> +pie_fixup:
> +	adr r0, reset   /* r0 <- Runtime value of reset label */

I saw the first patch is correct, but this one didn't totally correct
the spacing. There's a tab, not space after the instruction and before
arguments. Consistency within the file is important, sorry.

--=20
Tom

--ildGY8bdQj2QXOg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauD14QAKCRAr4qD1Cr/k
CkpwAQDCzn81OF9Q/ZTwu5ZvIuq4najx+WjPnBGjz/zxau435AD/VSfbEaD04WYL
l5d4/kw+Qlwx9k/iSReNrPJvGFASxgg=
=Oy+5
-----END PGP SIGNATURE-----

--ildGY8bdQj2QXOg9--
