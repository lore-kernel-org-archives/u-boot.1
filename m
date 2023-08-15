Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BFFC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181A886776;
	Tue, 15 Aug 2023 16:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jf9VHC6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D41867F0; Tue, 15 Aug 2023 16:42:35 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF1C863E9
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-589f784a972so19209737b3.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110551; x=1692715351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nHaVX5RIXmu5cKFCA5gKB+V2Hmu4kMxdqDOecNMwQKc=;
 b=Jf9VHC6iOuVCSLsQWPfnJKhpdgWSrtX9LjlmgdAVhL/C2g4bhPONGkv5yzUZ6cPm4O
 2WPnMkHQaSDGsrmZbaLgDpPn7gXuhNT7QjtpRG6LnmSLfcvHvLJbcXq1eWtuzNz8wHt8
 +90Wzt1Zzr+KRtb8xxJLIMxn3k+p4VtH2liOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110551; x=1692715351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHaVX5RIXmu5cKFCA5gKB+V2Hmu4kMxdqDOecNMwQKc=;
 b=YJYKfDlMv8HlWGMwAzF05r1jvfcQO61qWXjG+U3ENpCVkx2H6LvRQ8oruJ1ldeyXAO
 ZRZ3++RoXOK1XB2NF3C/Hy66JZ35v2scBleIpCsjZEPp/9cCocYq4Tg29l9mprwrsBux
 nKYbd+W9cHMxpnckcaBUQpqJPwpKch01BbFldz6k3W3qfW8ToWSJPgZpk2kspiQaFhp8
 9BlZoLgaeNmyFmeynmsgUNLLzoco26tUR3Vw/q8nhzTxwhSzagrgtfnPXCw20MUERVuH
 aOwdSDoZUks9drdi/pGNo5g6v0SssUao/1D1xl8/eI6QQgUkAd8Dtas45+UZ3wHeYY0b
 Ym+g==
X-Gm-Message-State: AOJu0YxZZCkgVubB1SYOzged/W8XKQlUBqpvdG4SBwEbbfwLFnZSnh1s
 hcQwYdWY2up9z7l6g29Z8MxhoA==
X-Google-Smtp-Source: AGHT+IF30pQixktzNyg8DDSAKWMDTl/O3s1TQEMKggZs41C7GXyZTW7R4RHwsGcak+/rCIVSS7nkBw==
X-Received: by 2002:a81:bb42:0:b0:561:a123:1041 with SMTP id
 a2-20020a81bb42000000b00561a1231041mr12284677ywl.29.1692110551349; 
 Tue, 15 Aug 2023 07:42:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a81830c000000b0056974f4019esm3432274ywf.6.2023.08.15.07.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:29 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:27 -0400
From: Tom Rini <trini@konsulko.com>
To: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Cherry <tomcherry@google.com>
Subject: Re: [PATCH 1/1] lib/vsprintf.c: fix integer overflow in vsprintf
Message-ID: <20230815144227.GI3630934@bill-the-cat>
References: <20230309021221.306044-1-paul.liu@linaro.org>
 <20230309021221.306044-2-paul.liu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UNi7U9exs+2nz5YJ"
Content-Disposition: inline
In-Reply-To: <20230309021221.306044-2-paul.liu@linaro.org>
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


--UNi7U9exs+2nz5YJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 10:12:21AM +0800, Ying-Chun Liu (PaulLiu) wrote:

> From: Tom Cherry <tomcherry@google.com>
>=20
> vsnprintf_internal() adds 'size' to 'buf' and vsprintf() sets 'size'
> to 'INT_MAX' which can overflow.  This causes sprintf() to fail when
> initializing the environment on 8GB.
>=20
> Instead of using 'INT_MAX', we use SIZE_MAX - buf, which is the
> largest possible string that could fit without overflowing 'size'.
>=20
> Signed-off-by: Tom Cherry <tomcherry@google.com>
> [ Paul: pick from the Android tree. Rebase to the upstream ]
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Link: https://android.googlesource.com/platform/external/u-boot/+/43aae5d=
4415e0f9d744fb798acd52429d09957ce

So, this link here leads back to
https://issuetracker.google.com/issues/200479053 which isn't public.

Rasmus followed up and asked pointed questions, that weren't followed up
on.

--=20
Tom

--UNi7U9exs+2nz5YJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjtAACgkQFHw5/5Y0
tyz3RAv+Mbomf6bwsm56XVzWX9aka1hGqZY352CozvOsmZeD66UFyBl78QuSspA8
DGe99UKbqIIIu1ArHkmA5eI1Twm/Wn/n8wpFa0kL+uhFniNJwVb1bGo4QLXT5ajw
JB2+5rhqjLpsT2WjSB4oIBsClfp+9mCVRSwIhkdF4NuXhyS4259D16KgS3/3L5Zt
woBSHUodF6VuOTqFbk1i7y22HswgHKPHA4Jmf13cC1iVLc82tRsY2OUkJd08+mxh
JSJBqKVvbZPMpO+bj9/MbPwocd0TNNBij8PtfzTq7gMuWnEZiEU4iHJ6LXz2xFp2
//EZy/Ao3uo0P/pQA0X7ZVCPGjTy9Zpl8FhnKg1sR48/YrVWW0qiZ8DiJDjX0BH3
cCKcwRcvfaMyswHCecnVfgpf1h/wEenKKMjYirb7oUnHsAfzbB3BI/j96Bh6MgQZ
NUo3cAbIX8GaxYrp/tkmiyRGQ/9WTDcdqRURCVEN7hnNMPkg316svEEik+rNqa6M
s6Acwncl
=HTXW
-----END PGP SIGNATURE-----

--UNi7U9exs+2nz5YJ--
