Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A09CCA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 15:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24941607E5;
	Tue,  6 Oct 2026 15:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dYCsOuIcT-F9; Tue,  6 Oct 2026 15:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 66EA1607CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791299022;
	b=dmAbYk46kWti+6/fT057OOvx7Rpm2JPevaUUsR8dlqmTiXfmt0g/mD4k5pip6ATmQd9c
	 TOzvVySjwyRGFuT129zhRjiptxe0YJI+pX/VYNz7Yq0IUPc2IOtBn6JGqlXsW1Rgz9O0X
	 YQxEvZOkPO+y/foUMzz7eqmIq/rUk3hnh7zK94jaUeu6Ao0MOOQ6oUg4U+6S0D8T/AY4B
	 7KVBB8g4GOyeeymNaDaG/RJ2xXlcn4J27AhOgKa+yJkIW34qJuCOsNkaq2tt2QnqRWY8k
	 o9ByGE9Y8b+b1Ui1c1yn8dCgss80K61MNvsT5ipHWkQCrZvqAuXJMAUFEEtkbBixN1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791299022;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cEqlU+43UNyNFpqTuhsvClWr0oqJNm+iUq12iT8V/EI=;
	b=LOXyy6BnmpWVOLa3aszsaKSOhavcGiaMhLshzPHsQXfmBQ07rkGyZWz/+L4NWltPUv7z
	 ILrCNSRB1Fo2Po3Jwg73eB2I6NWSJ0YHLsxD19RYykJRTdO0/EfT3p094BoU2xudzT8MG
	 QCJ7OJ63yuFVk5eQxDk5H1oHCVck5zHfRR5Dni2f5u2AYSQRLw5mj8Av2iiHgn8j1bUab
	 F2VqQKqina/dAepKc4tWmQH3aosQuOd6yF2CZCXCH75ZTWcLrtByI6whcLxMJQoGSfrLX
	 lxYg8nYFIOKump5MfROgd3DozYC5YEA1/nvEUscZVwpwVxzblFs/hHeEp1/VCtDitPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791299022;
	bh=cEqlU+43UNyNFpqTuhsvClWr0oqJNm+iUq12iT8V/EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cbzNyb0qV2ROlBxJY1GIphbCy21iR0IT1/ufN70viksh+8xUcPj1gMMbC1EltI2Pu
	 WVtKNaulWbOeXN/U+E9enA22GX5BbWxyJ4RmdNIQPO2wk2qZGTAZfSPmMJSAgdw5aS
	 yBt4hrIWLx6n8ykuYTKXRFFd3Huv3f+WNO5nre8+nUG2dxUK8T7AuTNtRgn/GaLFCc
	 Qx0JLnSajfgJV6RIfTIBKHIxMI2vIv14RDaWfjVkpijV7EyL+zlR6nesMYocAE5aQS
	 66/2c2zzf3CoyUBRevmPqKY3+qurrFRqzUJlaTiHtRX3a79aI+hGtJi6cYgknyWX1X
	 LJx7YLB97l+dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66EA1607CB;
	Tue,  6 Oct 2026 15:03:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3848C341
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1DDEB40604
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FJ2s9qsm7iqq for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 14:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6239F40602
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791298537;
 b=FCZSUd2mQ+0pk001ebSsSX7JKyCYPY3YF0pyYY3I2U1hT2f+cBGEsCfMZR0NxS315QBj
 ylP7M/cngnToRPcgtBdq9nMnuQdTeHStLiJSNWrMJ+tT230NahSnJ55SNXUCoZp10cKuu
 zlD3Q4NyDgQBxgjSowKpKOVVsD5fn3gaNQpaslUanet8RUxekEb4labckwl0Aru4T0Jzh
 Wh2djGhTVdepyaBMTWWgZ6DEnmbqSLY96pAcFpztkx/eKDsQZpn0LzzFcIMO6mWk6eKdl
 5VF0wUHGRYiQbwa/I7Ze0aHMlnz3mjgkovPSCEa/bbl/SYG9QwCnmE/OQFkLBwAh2dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791298537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=cEqlU+43UNyNFpqTuhsvClWr0oqJNm+iUq12iT8V/EI=;
 b=FX6NcVHyVg8an9JPpcUb7dmITvkSJOIXCbY4KQpIY4bzM96i65ATBBXDTmyfj/lNKZND
 MpaAzVdM7us5lu9AL/V/4eAs5s4LW6Zje//4a68rcR5y2Wk6/44RSb01ar6/oeHmjeBs7
 k9Cw+wZvAtad+yq4+5BwkGX8aGjaLlLA1+qbWRMCnhB+b2Vbwm4gT8klfO6ks3sw/zqed
 rCIyh4Nb9XekGJF/lwzp6ItdVaka5MS3JM6pqsC+ze5Twof6Mp1rVHEnFw3uy0m8Gl52K
 rSNOc22n6Nj55Y4j8nf3+qGW4Y92uD/QqFlSB8cT7+ua3GWnDzTp0pq3V5ZfPjEkg2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ipk3bMX0; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ipk3bMX0
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6239F40602
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 14:55:36 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-48e94879f02so287224fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791298536; x=1791903336;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cEqlU+43UNyNFpqTuhsvClWr0oqJNm+iUq12iT8V/EI=;
 b=ipk3bMX06NWNWhMTDENpF9MJiFQ2mfvoXk0/zv5tgpveWhTIJpk16fad/TOBbxQyI/
 bIDv5wk4f8fQ96eDx6V/ibBtDiGWRBL0H56CQXBMKNIJTnttnp962PLec/Dr6vuu+pW2
 Z+tmARRUYIXcxCjwO6Rx0f4IaZICqzbXydcVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791298536; x=1791903336;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cEqlU+43UNyNFpqTuhsvClWr0oqJNm+iUq12iT8V/EI=;
 b=pdA5kn3fz2D2AmSYy+h2WBnUwAHFU6xE9wANEAHkivt1MlZTEpUyoimeXNOvuDA8Aj
 3XzgzZVlsxApB/2S/ZuVtT3STSuk2sQVtRLgIImitLDW4yhEdbq1hOZ4wV9B7D6qUifz
 OVQfqxf5tNMVbGPUhTpiB40a0MqlbhUlbI9csyBoFQJ997Pil/YZ4INfRClRuSSGsM0g
 o3FZ+w0/MKsHZHvCSgPddFpSDSpF4vcHjWtnta5qxKxsgprXmdVpKH2/L4pJAzc3UBzZ
 KnDRLBQCYL/CdRtFZYrf0Lrclle/OgE1CmQlnXSqdmatHMOo1Kmla4s9UK/RmVgoiRK6
 6dsA==
X-Gm-Message-State: AFq9FYKLaY2ovMGa1Moefbna0Q1pYv3R6z6ZRcZrYtMw76g1QGb2Ks5S
 C6yl7MK2OyMijF+XbJQT/7YiCKR7hndmyBnzjA4U93SmI4NgNdPGmY0L9zfbIuw49LKKWVIZdQx
 WA2Rs/qag4Kc+
X-Gm-Gg: AYBFou1VAS+Ob1MzdOPzfaaybwBPJUcklNVMHYg28DTvnEep+TAQirHzZzRZpbLNIbf
 Eao5+A0RGSo3W06TnCq7ArSem0kpwcLcTJLYLFequV4Obqtksik7upNxLZ0X7bxJj3X6J/QECf7
 ytHtqgo0r+/haeNdFiWwwi6cRANpOGLiSpx2Y/MuOIkRRz2ev/gSe5ktapOP6RE9YxxycLiK1ZU
 ap+qDdkMJDj3GiQiGk4vckO7V1afmZVmsgBDYw7B4cvN7QgdAIfGo3VFp7uacQiHRbjSsqJJEaS
 aL72sdUqD2SyxXUoSRNHef4aiC4WnXpVZW0/OOccjMTtfHdMmYnumK+30TQuzt7mwYM+mEIpeJc
 9hvw5ZcSHE9asSmGxBjyx3D2RqPrbvBUBCCRYMvBgCrSLS7RQg682wMTWW4wC0hbK4D8Kp3SDRe
 qZuyMlKwT6vgoHtUolsdmiMxSmQdIBaQKFlsGGQ0D+BDM8J39E8TYV9YTdsrD/Rhql33EFWpyQb
 TG++A0aYAgdoKqVmgC3CUmOJeTsS8fDMTKvNZwm6WI5ElIaFTDtdfvHfUEruvib8wGDfw3qLwho
 dBM8fvvucYLCkqLxMOg=
X-Received: by 2002:a05:6870:3206:b0:491:88f1:f3aa with SMTP id
 586e51a60fabf-4a24047b1bfmr1513276fac.26.1791298535946; 
 Tue, 06 Oct 2026 07:55:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e1d0fesm12622944fac.8.2026.10.06.07.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:55:35 -0700 (PDT)
Date: Tue, 6 Oct 2026 08:55:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 5/5] lib: sm3: use memzero_explicit() for the message
 schedule
Message-ID: <20261006145532.GA1356209@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-6-18102059357@163.com>
 <179127471103.744.12789818892668439293@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d8k/tHkXfwwD0i/f"
Content-Disposition: inline
In-Reply-To: <179127471103.744.12789818892668439293@163.com>
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


--d8k/tHkXfwwD0i/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2026 at 04:18:31PM +0800, Xiaoyi Suo wrote:
> Tom,
>=20
> > Why is this last memset call clear here safe? I'm not saying it's not, I
> > just want to be clear.
>=20
> sctx is the caller's object, not ours - it comes in as a pointer argument=
, so
> the write is a visible side effect and the compiler has no way to show it=
 is
> dead. W is a local array that nothing reads after the clear, which is why
> those two do get dropped.
>=20
> I went and looked at the dse dump to be sure (GCC 13.3,
> -fdump-tree-dse-details). At -O1, -O2 and -Os it reports only the two:
>=20
>   sm3_update: Deleted dead call: memset (&W, 0, 64);
>   sm3_final:  Deleted dead call: memset (&W, 0, 64);
>=20
> and nothing on sctx. With W as memzero_explicit() the same dump has no de=
leted
> memset left at all.
>=20
> One thing I ran into while checking: there is also a "Trimming statement"=
 line
> in that dump, but it is sm3_init(), not sm3_final(). That memset() is an
> initialisation anyway - the pass drops its first 32 bytes because the IV =
is
> written over state[] right after.
>=20
> If you would rather see the helper on the sctx clear too, happy to send i=
t that
> way. I left it alone because nothing removes it today.

Thanks for explaining.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--d8k/tHkXfwwD0i/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasUL3AAKCRAr4qD1Cr/k
CrVTAP9wIDltvLM6r5WoFU7nIyyUpYP2R40wbFaVueDpHAXkkAEArqfUSa3G2+EE
VpEitMcQYxU4b6Itd+dBndqqU4dQrwc=
=T+GI
-----END PGP SIGNATURE-----

--d8k/tHkXfwwD0i/f--
