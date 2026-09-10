Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0DBC79FBF
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 19:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2194D4083F;
	Thu, 10 Sep 2026 19:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_ELuTbu2UYk; Thu, 10 Sep 2026 19:25:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 566C340839
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789068346;
	b=KiuF4UkSLg7jWCsUTr+b+ln3mryK8K9VqIt6BqUABPwDV1xbm4yN4pGjYFNoohaDhO0m
	 NWbtYdR2cCWIi92hYEvGUXanCmAYncxOTVUBZYhkWyjnZd22Mp925ac6EGiNTIpDODKeA
	 BI/hwE1xLWNfPAPN2/LCY3htmOIJ1VRYF+6DUmadXzWlaov8eNyJvobihs3pa1YN3rC4X
	 WjKrZh2PLItTwoDVZuHizY6NztYjWWGq6ueWt9SqIXg97bx558GpZeIfgy4ZbmacnFlDT
	 ryNZQirxQe4vGI8RskV6EaPXgGttjDB8JUD9rMgs4ITBRo1n8gGAVezmvQrmEz2SDMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789068346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NCZHtSYJHNXXuwIfS6AqR3W8ZOKKm/QIY9zXS4b5AHg=;
	b=U9f97tWyiLF7odAwPnUozNEpyDS4K5ECm6E7RgdTKdUMlZykbQ/DL8vv1ztErIFc7Moz
	 +K0gawxPaBy/cV0wV7I+W6u+9DBvYVb2drpmZbm9efipMB0CoC+lblDLuVluVDCE8Jv2r
	 l7CPGnJa8r9Kjhyq00Pn0I/jXX8moeZQVq+9NwAhEd0ne3Or0J8L9mvrWq2WgiHY5QoR3
	 /oLoUuZV/tBF/0u05pqGRV+z+eaKARA/74ETfB4eReR/ZpMRdruoadwofeDNqlzZZvfe9
	 7UZywKhg7QIu160hEs4W2a+PIKXdLsaD9QMeq1Y8GhAQKXLS5uSwXyUVJSe/v6XC/Ug==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789068346;
	bh=NCZHtSYJHNXXuwIfS6AqR3W8ZOKKm/QIY9zXS4b5AHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+jSsbAhMwPV6uMLa+7WafM4TC7a9dvp7YkICJ0oJZyV+IWpMkQ5PeiOIaExVyzz9
	 DZGE1kHH9IRMEb7r5lqy/2HFh/mMfg16t6bkekQVlSPrzdg7IHQY51cD1Bf+J05jLa
	 zhUQFeYSm/H9vn9asxo2BhOx8G2C7+j/UH1gFjqR7H7AxKNvuABpKt0gO8Wkp97RIv
	 NOdTx4DIYe8IYlo1dT3OB3BArQSYHflBVq9ZGPNdiqaTzr0ks+SlvfUN3aIOpBf9sL
	 IceRc1mWS7xj+yBb0wSmiwFYN2WeCdlZIm1J2klHjd5wCXHVXsidLxbSm52Z+vyuhd
	 6JtNuf8uhowbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 566C340839;
	Thu, 10 Sep 2026 19:25:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7628729B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CCE5400BC
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vpQeMdIBxY8I for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 19:25:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 935A140077
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789068343;
 b=KHVWCLDc4KPYJ889xxjjQBsm5Jsz8AnaYxl1HfUE/dsw+GE6GFLsDgXL94jbuoN9Ybg+
 2n0t+UtcpxOJamWQO/iBim+o+K0ocOO3hwViJ+36hSmuWmygQPlnTMqUdVTCEti28+KW4
 yejKnayiCUErIKECsBBEHeaCx6Gf3dDVkL67+zkxnDmVZg9iF499URgxFa738fwR8x3e3
 ZB+UXDIvhqVF6IZxoCqDHtqQqJWJ4b7Yeh6DAgSwGJUYOSVuVjI1YFig42hvBx5LApI23
 F+R3xIUwUJ1t0ZohtNzvRnpFR+0s3qfY7LMhiRqyoEnRdOeqsbkDqUHgr7BH02F9PkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789068343;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=NCZHtSYJHNXXuwIfS6AqR3W8ZOKKm/QIY9zXS4b5AHg=;
 b=FTyfDObu5JRTW+JkKGUCKE+31EDaYl161sA5qtg49QNZg6ve513MNktwfQaU2Jp+y+/n
 HbPA6qfvmkAWSMsX5Kj0orIpj+no9fuFG5o48RC1T+jhibYW7e+7pWOmQEAIEjI59Qllo
 IeG35BlpN0Oh+/4RgkUQAWI7VB+Ps2kQhjeW8AWglOcYYjDiBuz1iFjf8hpdqUMbiiJ0J
 dnBE+bu1p8DMvtJfrlSVd73QrZ+2AP89tyM+h3tg0rOxYQiIiR7OrHw7s2hMr+F1d+Mdc
 8pa93HTcL3Kp47r+hAA0sI01Yl1t35o/HC6ZYEn4+PUGlHdhP45HbmpHNe5xonwNLNA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GI3a76xP; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GI3a76xP
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 935A140077
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 19:25:42 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c2c368cb3bso124536b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789068342; x=1789673142;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NCZHtSYJHNXXuwIfS6AqR3W8ZOKKm/QIY9zXS4b5AHg=;
 b=GI3a76xPesnzGeC+aRyDK8vmXgtrGe9C1WJLG52L5zu0VPh1qsXvRWSPzv2SP9j6mE
 GsGJfezYGPK8i1G12eCIrgAr7FsvxOchqSZoTCOQAPGKcl4KgQ0WY6tdAwIVFqZUBaNN
 j8nZY8juoc2YYZJoCu9v6DonxH/jf0vHsFmVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068342; x=1789673142;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NCZHtSYJHNXXuwIfS6AqR3W8ZOKKm/QIY9zXS4b5AHg=;
 b=UOJjfR0Y4NH2M5Iq1YCoo9Bfa8Ny/PRvgbsrbmsg307M9cSBvFSb8nyn27r1+mI+DI
 TNvidb5rhYA+mNHBckxp4v90yD2pgw0DxcxblsjvqbQM8Mbp74LNjYQLOsXphYzNDcCo
 39kJR53AG0aO6yv3Bv9zCdLk0+wN2LLrZgvCDzMGh3oriQBM/9gCFAhXhz4bUcnIhCRy
 ooWV2pAbiQOzBeW2fFCgTotLkcLyckh2H0AkNseryoBSigi0IqTbWo95L8Ga4R2LPhVq
 SoQg9odNQymVEwYJf/2+sySBVKU769Wu2WeyCTI7YBO3TFGVjbi5m0mzwKBim4OGnKQ7
 RgQQ==
X-Gm-Message-State: AFuF++labqm7f6DXX5zgXyeE+94KvsK36oolZZw2IWWn/kJHd6G6UqFN
 JNxWWk1wm4UYSaQMrDY5L9bg7MtCxdBdZrOp6JIDKo3VaMi03gdF8UNvcLZOgibnQMU=
X-Gm-Gg: AYBFou0q5lAiiMC/k5Br5t/KFR5o1Juh05qUdV4DyvZ1mDrTeNW9vVKnKKgL8djT0uL
 /yB0VywSDqbO6XlZmJFMSXl6MurTMGJgrs5xBNYd+NqcjURU0uj6gPFPZZzy+tMu8QM/VOat5w2
 hH9GPOXKP12dY7vOXD8+6L93CFiMqN3hoim2rp9FC1BLbQQUDMV1/BBHGYTNEOsnLsT5UWrj7T9
 aDwG+Yt5crTlnLLWUdRPhJDITBMZTxmwv/JgSl0rB9/XajzXebFTPiF+fYh/FGUnhROTP+JVJkZ
 brQfnxoWoyvesMo49u9ydP1lYpA+2LtZ5QbRXcSWXgSjq3UtXR2AyveIXFQ1ISQzeaz2MVSb1Af
 Y7+4yV8DLCrYfwbS48n3iXBctHdBWNUcY4uaw0MxDkG66XG+9A93WyqXROg2+qAzkdtmZxUX5FV
 jrGLXgg/3tUapg6LS2fLpbm3gOd320BgMIxn0XXJkQ+slf/wJYREYa8QaycakOOos557laPB3PY
 AoSM+5ZzPgyfWSPbVamrBVs6cNCq5cmiwzLoiAtLQEw74ERRA1APXjUem2p4hp3CMcZGA7HciAR
 SIomhP0OcFqorIt4z7/B
X-Received: by 2002:a05:6808:1a0a:b0:4a3:f4b7:cbdf with SMTP id
 5614622812f47-4c31c738620mr645811b6e.15.1789068341917; 
 Thu, 10 Sep 2026 12:25:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c331bc9342sm96804b6e.12.2026.09.10.12.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:25:40 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:25:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Drew Kluemke <ankluemk@microsoft.com>,
 Daniel Munic <v-dmunic@microsoft.com>
Subject: Re: [PATCH 3/4] net: tftp: use bounded string compare for OACK
 option parsing
Message-ID: <20260910192538.GO1764417@bill-the-cat>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260909192016.217183-4-sriramsriram@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M7NfBAbEnDBr+QZO"
Content-Disposition: inline
In-Reply-To: <20260909192016.217183-4-sriramsriram@linux.microsoft.com>
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


--M7NfBAbEnDBr+QZO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 12:20:15PM -0700, Sriram Sriram wrote:

> From: Drew Kluemke <ankluemk@microsoft.com>
>=20
> The TFTP OACK handler matches option names in the received packet with
> strcasecmp(), which scans until a NUL byte. A malformed or truncated
> OACK packet may not contain a NUL within the received length, causing
> an out-of-bounds read past the packet buffer.
>=20
> Replace each strcasecmp() with a strncasecmp() bounded to the option
> name length plus an explicit check that the name is NUL-terminated at
> the expected position. For the "windowsize" option, whose name and
> value extend beyond the loop's "i + 8 < len" guard, add an explicit
> "i + 11 < len" bound before the comparison.
>=20
> Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
> Signed-off-by: Sriram Sriram <sriramsriram@linux.microsoft.com>
> ---
>  net/tftp.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Does the spec/RFC ensure that we're being given a NULL terminated string
here? It certainly makes sense to be using strncasecmp here, but since
we're a size constrained bootloader, we do need to find the right
balance between defense-in-depth and potential exposure.

--=20
Tom

--M7NfBAbEnDBr+QZO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqMEKwAKCRAr4qD1Cr/k
CuC7AP9dnV28Q4LFrC8tmfj87ty59S1XDsc3XUJzmAAqsGfxZAEAqkfCsbWfedVZ
iOoK/FumWYSz/rGuLGYs3DjjQj5mUAU=
=dcpv
-----END PGP SIGNATURE-----

--M7NfBAbEnDBr+QZO--
