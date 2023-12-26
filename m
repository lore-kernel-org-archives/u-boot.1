Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D781C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA968794A;
	Tue, 26 Dec 2023 15:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpHXAbth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277638773F; Tue, 26 Dec 2023 06:07:38 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E241F876FB
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sploitem@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so21894081fa.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 21:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703567254; x=1704172054; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFMcDSgQid6I28dOr9ebH4DOpLna0THRZLI0gYMUl3A=;
 b=dpHXAbthj/n5ktycBHDLAqw7M2tFr/3637HGTh+67HeQ3oj/pdoFsC0Uh6VbKiWLwa
 mkTHQsHxQ0RGZYFwVNVI3GzEeJE+SRK6SJpZzk1Bfv+rc+rYyuFu4BU1CLUMlv9VmdIK
 BLyHKJvqgxDbxOgmZnLM3RzE9ooFIIXY7UxXm2d8B921YUYMsGEq0RuexXkY4Ra2z8Tm
 q0GilmQdJ7EWXUvawCUD/XFxWZtA+4iyBRuP54rTmx9IKQGVl/ypGEvdYMwS0FI2nbEt
 wsJ/Iq9/EGXpOneF8S5OsVgRZ/t++pmKf8aw3AvHs6Vi3DHj3PsJ5wdgJcIozaxPmIuf
 eWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703567254; x=1704172054;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFMcDSgQid6I28dOr9ebH4DOpLna0THRZLI0gYMUl3A=;
 b=qLQcJmuD+9ERN/4yjXzr1KRj1S3UOiWNa15zrTJz9oAjnLmZaNU8yOn8TPO+Y/zoFx
 LOYbebeZJKOLfuLTnh/mTeexCnXEJht4FBbrs5FA31iloe+GqvRQmbT4gd31t6aNHfH/
 c9om5Od4cBpRT0G+sUWqaA4Da9kInI7mFRQHFzEqNG7GG98wZ8AncmNpW4tqgkaAsXrk
 4Jt8fmm+Ce+7NlqbNgJaoE5hplNOB48s5OJEjjuM8qqKyZT/Z+r6qjaID0Ir1w/m6Dt2
 PmRk0JxkyO5ixFWYnauRLEUo/6DcedNFbZ8qcATSMbab5TAPjjtePBDOWW4Zh3zTSeJ2
 MuVw==
X-Gm-Message-State: AOJu0YyKbNyV/DkJGGf07e6bxZxzB68jMNzqRtA72qeOomty7EqAcjZF
 NghQLtpppf10/xaKXLuiSELsILeysDk3vFYOp7cy03Ypa2Q=
X-Google-Smtp-Source: AGHT+IH5rgKnsMZBZdXee/gQWlqE9w2P9kfFhWspelrmMgPbro5qa9buq3sg7GjHp0lbKas4E0olgrZ5/LJCqXK6r1o=
X-Received: by 2002:a2e:87c6:0:b0:2cb:4e98:2641 with SMTP id
 v6-20020a2e87c6000000b002cb4e982641mr2281130ljj.74.1703567253626; Mon, 25 Dec
 2023 21:07:33 -0800 (PST)
MIME-Version: 1.0
References: <6581d54e.ll82lGTmJx9oFRYQ%cve-request@mitre.org>
In-Reply-To: <6581d54e.ll82lGTmJx9oFRYQ%cve-request@mitre.org>
From: sploitem <sploitem@gmail.com>
Date: Tue, 26 Dec 2023 08:07:20 +0300
Message-ID: <CADk2PNOxKKTW6n=+49j==rRKd_xNqG7EP9Gw4BO0URi1V8BWow@mail.gmail.com>
Subject: Fwd: [scr1564375] your CVE ID requests
To: trini@konsulko.com, u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 26 Dec 2023 15:24:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

---------- Forwarded message ---------
=D0=9E=D1=82: <cve-request@mitre.org>
Date: =D0=B2=D1=82, 19 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 20:3=
9
Subject: Re: [scr1564375] your CVE ID requests
To: <sploitem@gmail.com>
Cc: <cve-request@mitre.org>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256


> [Suggested description]
> Integer underflow in ipv6 net component when processing incoming packets.
udp->udp_len is not verified before substruction leading to large number in
len parameter (unsigned int). This can lead to DoS or code execution.
>
> ------------------------------------------
>
> [Vulnerability Type]
> Integer Overflow
>
> ------------------------------------------
>
> [Vendor of Product]
> U-Boot
>
> ------------------------------------------
>
> [Affected Product Code Base]
> U-boot - <=3D v2024.01-rc3
>
> ------------------------------------------
>
> [Affected Component]
> u-boot/net/net6.c
>
> ------------------------------------------
>
> [Attack Type]
> Remote
>
> ------------------------------------------
>
> [Impact Code execution]
> true
>
> ------------------------------------------
>
> [Impact Denial of Service]
> true
>
> ------------------------------------------
>
> [Attack Vectors]
> Crafted ipv6 udp packet.
>
> ------------------------------------------
>
> [Reference]
> https://github.com/u-boot/u-boot/blob/master/net/net6.c#L442C18-L442C18
>
> ------------------------------------------
>
> [Discoverer]
> sploitem

This request did not receive a CVE ID assignment as CVEs are not assigned
to Release Candidate (rc) versions of products.



- --
CVE Assignment Team
M/S M300, 202 Burlington Road, Bedford, MA 01730 USA
 [ A PGP key is available for encrypted communications at
   https://cve.mitre.org/cve/request_id.html ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJlgdSnAAoJENiPHH3233OGtbYQAKDjsoR/MIuN6txsUarIqDx9
KzoNx5MR0Ze+HIyZ3vBV1+eUJcnHfStLDaIMRNGR7497+A474X54vn8OVRTqgh+W
CPQiTqx2PpJTYikxBAUrbh6uzwFHlb+iv7Dt2mqyZ4Eg+sX8X507YfyyIsWr6Npw
VYiXSt53Sy9hQDski7H+Nl3keO3km5G29MdavcvNiAwH0g/a9f+NtRvQvi68X+n7
4nWRa2bzH3zChvOVJ0TRvua9ptwU+svM4wjL9vloEMO8sDO3CyFIoiGhyhseERcT
Zv/NpPdqpqlKwRcvY6vW/GMGU6pVhwpIer9jrX4yolviN1d92/J9sIfJXchl5yNh
fUnX0NYlBbBKH1Hy/ttOXuOBPeNgFv1VpryJvjyOxmTIpOZUhm1iiehzEGA2pFdO
FUHAKmfrugVTr8Gp3HL/tQ3MN08nB64LHkowD+j0+XGN1EEIurWSnwRwdXmEn26Y
MSkGbXzT0GiibnkhwpdRxcZW4p33NC+idNBZtb4K8TIcdUdh2P4ZzeyTMYmxMKgp
WVHxxKvLEom+E17SAb996Wesia4+gRo+2wK4cXCtnEn7nqz59y1mqBf1uALeTDLG
D2/9N3nqGYZEu8WeMjSNYPmUvLMHKvffj9Z81+dBSq/IngZMYuXr6m+UGTce66N1
jmb+4NApCJi3mhF4dUK6
=3DT698
-----END PGP SIGNATURE-----
