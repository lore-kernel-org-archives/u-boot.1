Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2F9E77188
	for <u-boot@archiver.kernel.org>; Thu, 26 Dec 2024 18:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B5C48036D;
	Thu, 26 Dec 2024 19:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lxqYdUpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2E380384; Thu, 26 Dec 2024 19:22:29 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05F2680317
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 19:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6e8fe401eso544041485a.2
 for <u-boot@lists.denx.de>; Thu, 26 Dec 2024 10:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735237346; x=1735842146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cPZFmNN2O82tn6ph2Fh9oWi+2u4CVWtNRhKSO6ORKjU=;
 b=lxqYdUpZhLYOjxWYxcp/NfifKi2yzqTsYq89XygJW2Li5se9TtyFisdN5rpEb256sW
 51MIAFkplNM4y5MaKYIZzj1nqCCW4UhR7p6rhRQViKO6BRTPFLUhiV/aQ5Ew9bnYZoun
 JxW2blm20CvkgGkKG+pwQqrDXmx7ipd6HZBI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735237346; x=1735842146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPZFmNN2O82tn6ph2Fh9oWi+2u4CVWtNRhKSO6ORKjU=;
 b=eSssO9WUu9afjSQ8MeA9EQJ/i8cBEyeqd6P7Zk0X6XMlXL+iPkKkaNKBepvhKABqcv
 Nd3nj+XTXDwPjuo157oeoFRYdSxKITGdvQ9Pj5BrKUbn7sF1huGX+AXEze3KK/Vvl+9H
 y0cXur10BxEtxISRQrGoFxk9GW6dd2gK399d0yKEvdibP5167/7KT8y2Aa3fsCZYV7mF
 nfHq3wo+iF2MBThKKFpdLqC/OSHW00tgkArlk4n+wExs6a0wYSTVuGh+WJObHaYOP8No
 Du0Hp6oESGvWL219oi4wuP8db/HQ9xqqWBJQ2yOw63dvmKeSn2XIS8nCasuXbhq1o79P
 nHPA==
X-Gm-Message-State: AOJu0Yw7zMsCER1yhPn6n3ljEvsh4wZ3QI1SGAk+NsS9unnVlHCYTmC1
 L0VcCWYMB7Q8i1B2aaUgVGHHpke3QpM9JaTxBFx6chUjkJKAb18Ca7IWMdMUTcQ=
X-Gm-Gg: ASbGncsaJWG5lDg/H+NYJVnRu19+AfQVMOhhcqPeocl03ld334nt3foVvAHA52J12EF
 7ldW5hQOxbUmc7Ep3hkpUoXa0k0+eAasZy5WW4vXG2OgWNegxkfH0QL79Umk06K1uYa+uM+shZ/
 XJ15HRJ6f3ZaAQWY+CQOyvrG8jiLqXTFOxDztIEhopC3t9VaotASpMfSsDnPa4qmI82JNuVEaVK
 +GPVkhg64+4MjUGhHGQo42GzRe1F7Bii7G5X2Vg9JKKuzk+ZyY82lTcsg==
X-Google-Smtp-Source: AGHT+IEZIS+iL+IcdnwYWTvx2SM4eBDmPDT/qbgZUQUIpxgILyaPQW3JrFY8NbsdHi2M3lO1w2Mmkw==
X-Received: by 2002:a05:620a:8003:b0:7b1:3f88:48ef with SMTP id
 af79cd13be357-7b9ba7ec2abmr4045853285a.46.1735237345900; 
 Thu, 26 Dec 2024 10:22:25 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30d319sm637208685a.55.2024.12.26.10.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Dec 2024 10:22:24 -0800 (PST)
Date: Thu, 26 Dec 2024 12:22:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Subject: Re: Pull request doc-2025-01-rc6
Message-ID: <20241226182222.GB1505244@bill-the-cat>
References: <92a7b701-acc3-4ac2-a8e7-91c58f554510@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v8xGL/wpmsmsnwHh"
Content-Disposition: inline
In-Reply-To: <92a7b701-acc3-4ac2-a8e7-91c58f554510@gmx.de>
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


--v8xGL/wpmsmsnwHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 09:09:26PM +0100, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 3391587e3fe22db6c71882f652e13543a45016=
94:
>=20
>   Prepare v2025.01-rc5 (2024-12-23 20:40:49 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2025-01-rc6
>=20
> for you to fetch changes up to 0be26928bfc4f2a34df3eb447fee718d3551217c:
>=20
>   scripts: add volatge to spelling.txt (2024-12-24 18:09:46 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24005
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--v8xGL/wpmsmsnwHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdtntoACgkQFHw5/5Y0
tyx7GAwArr0p/ypdQKlrg5oUncOI5aNukDBBYFtAiXLeZujYWQqnGxyR76XcH502
fd+yDKVladIwdJlrnCnYETcsHjQzR3Ant2vXRb5wQO8gdAijEvUDY48E6x/v0gNT
gdwSEV+nRbchJgWtJGZ1c864FJC8R4diXq7ZSSdBBRyvyM9ceSK2K87ONCX9wflC
Yfv+lDmmGUKWyyHnHRDzE+xtLL/LFx8SJtsvDTSIPswaI80L5q/Sk+5t4zBuOhUg
fiY1T/MR9nYTFBCOYi4P2h+cY/rhc+2sobcMeH27NcvLa9jM6Ztg3hmsembH9jyr
JBUNGXFIgHs2uFU0X2KTzlTzgKnfrjmUTd9diu5Xk2KaHrfRN47KziZ3lcA8/ZcR
XO96TObZthMkMvCOCMkVaTIgSyMHr5yrMs9CLsBcaoNFhxNpmZiPbnE8ynkVCZwI
Cp4TkEUnrMqzPtEDaxFgUqZkDJFFxg5V5DOE+eRg9KBebGOvupTmg4dqDW+6z/fW
qmglHdya
=lX2L
-----END PGP SIGNATURE-----

--v8xGL/wpmsmsnwHh--
