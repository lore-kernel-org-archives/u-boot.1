Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14A606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q9kBMybn;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=A8HfvJ96
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89256810A2;
	Thu, 29 Oct 2026 17:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaZDlEJw4s3t; Thu, 29 Oct 2026 17:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 969F681082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295458;
	b=XSgPUF6a/8zGwCAqj1Lvhj77uZ4vcT+IOoFYzMLcyNzaCFEvaYcIWcmF4nYnr+DQR4V+
	 98S37PMNzZbyLzcCQ6NvajlPUw3B3hBHJUHURpFpTA0nbmxnegxIlEPhjWERlYLYjbBjF
	 E9fjq0X6VFA3V9xpDgylveYOuKnBaS1/4wHYc33KdGwKF6iZ/fdio/yXmFUwX7Rj2uffU
	 nKwuL0gZsaabMiokBseNVQNNrIZt+rPYkJ+2un3encdkW7Lau56+7ancZB1k6ODBly+Jx
	 rlpJpL1oUoUk2tHoeQKUSiFPGd2nSMoWdGmTKiYIetEhW2QpP4n9WDAH67PNOSNo01g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=J8arP0zUTtOBpKFJm0C3PzXgF1aZwN7W/hAsnAAn5dw=;
	b=kl3PZiYB+l0Buzbhmuyr64S81HdxLat+ihBivFpi/t3Wa9NkByEsgr2Ht0l6IBtXropA
	 7VDqiXzKZm7Nc/gC6iFL+ImgurH/FgykssL22izo06zFeOsWjBCWUFDO/b47OQ6SFjs0V
	 CbLQNUG8CHVtf5ijh2PoWVYF1R1+jHNLOpG568FhXBPvP7MvTp2fNpOyYh84XCk3KzWMA
	 5B5e6BAVgW0/YDK8sxIVETZbd39hnfH3GH39wX/rfRCmdRenUh+YqlXzjBujgoC1+Pac4
	 nAWfF6IV3EOS7ZSQ8cviTyrI5bDAFXnzaC6GTbKgsCYO6fwPdRzUdqMFZbop3H6yPvQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=A8HfvJ96;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295458;
	bh=J8arP0zUTtOBpKFJm0C3PzXgF1aZwN7W/hAsnAAn5dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9kBMybnMtS3a2mUUaoCn2ThFd4n03LwgGSTivGwz+qO4GsfG+I06RdcvYhqzCHuQ
	 P5V4ZLazoC3Wgo2Ev5GwX2MLCaXD6ZNYpeLh0VRZQM0ehFVs9NZJ2nop5lxDZrDWuL
	 p7hn9PfBrbd3CANEx2wSXzvds9TUrZwxAKG7Y7mDv2o6cwmIaqjCp2ZQHjEkdbOA6J
	 EDlnRfYIsj7WyjG94Zd/JgzfvEpRVG6PKNnkNVKlLITH1gE1jvo1qeRqS1sy4MXMYW
	 hQ29QIgWrPJgTrpPYW6X1tBpoFxeMsgm5CwEea1GZF6qsUOCxDGb8Sz4SeHk4JMOzz
	 eVZ34rduB4P/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 969F681082;
	Thu, 29 Oct 2026 17:37:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9FD63A7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFC4D81082
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 21hV32PDvoTM for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:37:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9E498107F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295456;
 b=MP3t2hZYWNM6EgatEH4brshK2zGsueJAcVnZPNG9v7mQoITmLPXbgSL6p7Muf0j4iiF9
 AbFtABCUiU8trjv8Fvz+OgqA5W0sIi5tUizYAfv7K3qfRVuLbV+VfwjTu3gFHgvMvpo3g
 qbYDBvrmMEdW1gPgi6KSLyLzia2QSVv6djGZrFR/wpwqMFYFBe6S5aYH3PiVPH7ANZuKv
 19Qg17lT8sPUUD+yTyTSJVcCQIdcuNZv6vmybVGtNyElyuTpCvV6mzCnRwOA8Z8oZFEbB
 V51/+zJRBoUkxEYs50CHON3l0sNMmaek+q5XXmN+FfzikO41qt9ykFVXTraOUb3vnQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295456;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=J8arP0zUTtOBpKFJm0C3PzXgF1aZwN7W/hAsnAAn5dw=;
 b=p4pH8w/2Mo4MdbH0S/3rEVNRl1pD4xapRMUrMgxb8aAk1bkigROU7rlJQhWjjdlmzbbO
 U8wA8aHh8n0WD3V4ffiLppflRnj3Pz5tZtAjbvXLUL0XMt1zsRiC3mgKimQrxaDw5Zj47
 V8NVADoJqGOlGF/ticsTuiNHL+LoPqK65iSuR09h06KaArYDqEhjtELMqgUO/lILQGFjQ
 AEb+ZyteaZuNSSpup6MGWxnw7LVCagowg/f0rnU7c7exLq5GArny47DIRlehUfFm7A0dE
 DE9mwdM5S1/oFSDdDHIuxiFU/z9+mYGzDFEZxsnhIeV0+5eiH8Udw+vWGlx7bwy9KSQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A8HfvJ96; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::9;
 helo=mail-oo2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=A8HfvJ96
Received: from mail-oo2-x09.google.com (mail-oo2-x09.google.com
 [IPv6:2607:f8b0:4864:31::9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9E498107F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:37:35 +0000 (UTC)
Received: by mail-oo2-x09.google.com with SMTP id
 46e09a7af769-821a4a69647so1092789a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793295454; x=1793900254;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J8arP0zUTtOBpKFJm0C3PzXgF1aZwN7W/hAsnAAn5dw=;
 b=A8HfvJ96uYT4Xw6OGHKzd7a0DpiDQv3wLWFUh8b7Dkxpq/Uwz1weErVCdBUpXEjmlm
 yayR1LtJgjiKE40Xx/W1RdJGlmCPHEIc6vpdVX7ykI8aCzk8+ed6g6vwQ7zzXHQmyXHO
 o6xjUFGAjXUgH5l2QZT0tL5a/yjoquP9Ygqbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295454; x=1793900254;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J8arP0zUTtOBpKFJm0C3PzXgF1aZwN7W/hAsnAAn5dw=;
 b=bQx74K06zXdfDcqf5RNGyxB+eYEHWlFi6naIu8nqR7WEajcXofq8Zt3TAJuY8dysDg
 +MIKIfkVdgxP+CSLJPD/FyX+LaKGLGMxn3ym1KkojlNbEVbY+uhIEPH5wT2mZ6LC0qPD
 lJgpLUHO3iGSrolwFm0L6RpVpbEy1x7ZnCedo0EXbGxtRsk97i5YoJ45wvG3T7ay9qBu
 C75pTpnDhh+UTk1+v4NONf7tRaAgt4SUMm2uCKQBhqxHvn1u7wZBwLAi2QivkcKcsq21
 CaPu8Q+Ss6cO7LiZOPCVZGmkDOHFII08a0VSbNREOI88Y6A+12cofJvEiId9pW6JSCfC
 9CCw==
X-Gm-Message-State: AFq9FYJu0dkUMpYwtAxQvn0X5MeXHt6JOGgcreOebR55fEkhqbm6H5ha
 rL1DX5qlfFPzq32tj/ZIddvn3jrm4grQWc18Nfb1627xZtWmcBlvDGHRkAigSR425d8=
X-Gm-Gg: AYBFou3+N/KulEfefSpCgCbWTtcf41Oav2M/c6TUkx3sWbW4v4VUiq3yW014DBbWBtU
 xWNP440OiuMH2nm/RRwQWkoHq1DAonMHhbW16hoNimNsTtzhwySqlk5HVcM02z8byMrnTdtNKlh
 6FXxA6RoQf0di2FnvgJvTAKMJou45XDnoAjJtx5MJw4LOMTaao3qXKv2fNP3DGMPzZX+AJmvaCt
 iieZHn/x1cyTkl9/31efQQogNQFx2J7EHwD9QNQOjchQlV7/mUPGdFm8B2MHeE9DYBcKnfLG0Rg
 F5Blwh/swNU78mj+5bRBjJSC8zBheTcOoe5/SuZW5sV6imB3FPfGEZ9VAUPn7chcOBrf0CYVCqm
 mQXkYuTKSUTSlqfkS+odgz43NHxpxLV4/ne5Q2RXDaIw3ge+m41Q8995wM6tDJVGrmgYfgJyHwr
 9PbKCidgtxmEknZwoAAVthy1iWXJkBzqWBVey0GjwIHr9+Abo7FtU56O+lhtwzMg4O5YV0JFKmx
 OlSi37mQT5ST+nOLWP21ceI06OABtzZi8bVVoIcAUNJUJj+zJfYCbz3UjvaiOY9tgTwCmcOUYCu
 wTe3io4eXRLmh0aAAEf28aHOd8dbimPqRyN7zkF1R1xcy1nVSszT5Z+SjrjN/bfb4cY5JaHSAWQ
 8FfTB3Or2+EqKRTXYRtySjtpaYvwaEPdN8gLW5VSJka48cSg2ELQJTh2sLdEzj5P7fXoCI9Hqdv
 rTFEPuQ99cl0uxOoHEmFJhHr3rbAGTphM=
X-Received: by 2002:a05:6830:2e10:b0:844:a8bf:7dc7 with SMTP id
 46e09a7af769-85abd12e702mr5483084a34.17.1793295454007; 
 Thu, 29 Oct 2026 10:37:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d3545b880sm94849a34.8.2026.10.29.10.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:37:33 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:37:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] lib: date: reject out-of-range month in rtc_calc_weekday()
Message-ID: <20261029173731.GA3018304@bill-the-cat>
References: <20261027131837.177854-1-odeschamps.mail@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+H1kPJJLc5Dqoc9G"
Content-Disposition: inline
In-Reply-To: <20261027131837.177854-1-odeschamps.mail@gmail.com>
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


--+H1kPJJLc5Dqoc9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 02:18:37PM +0100, Oscar Deschamps wrote:

> rtc_calc_weekday() indexes the 12-entry month_offset[] array with
> tm->tm_mon - 1 but never checks that tm_mon is in 1..12. A caller that
> derives the month from untrusted data can pass a larger value, causing an
> out-of-bounds read of month_offset[].
>=20
> fs/fat reaches this with on-disk data: fat_readdir() calls fat2rtc() on
> each directory entry's cdate/date/adate fields, and fat2rtc() does
>=20
>     tm->tm_mon =3D (date & 0x1e0) >> 5;
>=20
> The month is a 4-bit field, so it can be 0..15. A directory-entry date
> word with a month of 13..15 (which a compliant filesystem never writes,
> but a crafted or corrupted image can contain) makes rtc_calc_weekday()
> read past month_offset[]. This happens while merely listing a FAT volume
> (fatls / ls), i.e. on attacker-controlled media before it is validated.
>=20
> The impact is limited to an out-of-bounds read (a wrong weekday, or on a
> sanitizer build an abort); there is no write. Reject an out-of-range
> month, as is already done for the year. This also hardens the other
> callers (mc146818, efi_runtime, cmd/date).
>=20
> Found with a libFuzzer harness over the FAT parser (test/fuzz/fat.c).
>=20
> Signed-off-by: Oscar Deschamps <odeschamps.mail@gmail.com>

This was reported recently with:
https://patchwork.ozlabs.org/project/uboot/patch/20261014-wday-v1-1-d6a45cd=
f7c5f@arm.com/
which also covers what Simon is talking about I believe.

--=20
Tom

--+H1kPJJLc5Dqoc9G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauOEWwAKCRAr4qD1Cr/k
CnGpAQDYsWuFpKnDwKCVcIwvnPzaFYleZzPs10Bk5xESUIOJRwEAk1H970BJG0eT
GakoxZgXoueHADceyC0whEW5tC5f5gk=
=Vrq0
-----END PGP SIGNATURE-----

--+H1kPJJLc5Dqoc9G--
