Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B462C3ABB8
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEE6782977;
	Mon,  5 May 2025 16:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AJ5Br6R9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B06829A1; Mon,  5 May 2025 16:46:30 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32E38212B
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c40235c34so1237184a34.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746456387; x=1747061187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wSzDY539U7Sb9oL5gAf9nZ3Rd5fPYJJe2KHorZ1ZF5c=;
 b=AJ5Br6R9AT6jDmtpliXDHlJ2DM+5jWtgP9TuTTZEkcuJmnGKR1XQY0HjWPIKFldOrq
 KAa2U7i5+f9F0Y2tA40h0Sd5KdPW2fyz4h2/rTmErCwzK6d6dS4+K1q+6SyHxYuHDgAv
 gPU7S+qLzP5cQFQnIpv1scvAzl8LdvRjNcgPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456387; x=1747061187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSzDY539U7Sb9oL5gAf9nZ3Rd5fPYJJe2KHorZ1ZF5c=;
 b=Gov73PUDFEnYru4WD5CRBvVmfPeEQ/15o0a9pa6F30NPCjlqbX1PwhmnhYvqCG3n9G
 6eCcVyZphn7gZrPHKyRojNXcy65p87VlbwiWvAuRDps9W2v30IBKun/faHGvmxFg8+Fc
 7W6MGH68l+659gc740FB8MKBOu7VO38K7G07woLXO2/7xTgdv2XtPsLWHP+XTr0j0E2k
 wAazoQ/tfldkJ0fUD7qbfPuQRYmmOXXGF8CjWPJct3axvE9uva8gzFuZgdpsmkBJcDws
 inScOGWHAQufgfbpfeACJOn6gicIjcS1Lx4jW0IMVo8MLxdVNwg8wxpV91WmJ97iXi+W
 12xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv7PUC3Iaa9xfuhlc9oVR1PHuCjEJdZr1mdHJpgI/kJep+I6PokEtVxy5Re57Z9By4cvfwLsU=@lists.denx.de
X-Gm-Message-State: AOJu0YzrN9aYyGP5HAOPmfBUE0MNBapQh7uT5I4zC+itU8rQ8a8uORbm
 5ftyKMAnTy1iAKB8lWRqLXPQohPLJrtPQe2Fj+TURTXYNmUz3gyKcuwRJmIdz9w=
X-Gm-Gg: ASbGncsNEGzRd5PJrmU1BM0HFp3RVNv+EmE0sah8ZG3X43uhpiUPOZBhuXlv8P+UEoB
 xpUG0iotropoenAqMqaZZhCa389AmDv0LQOHrZNKpbutj9Q/G40Q+9F7/8zsYBGwRys0p84YOTp
 RmO7QMApttbYNvLL4fUi1AhtSoxDR/gbK0bNX2HLPqhFBfR9CJbBWeDIR6wpfcbUxNb7w36xKoi
 WtstOvRxS0QHHgzY/+U4s0VlsGo+A+iZsgJR3K+085vvnmiR0wJBeziMtB8NlU9D38qPw4MclJB
 sVWbQAJJRG6p9r27hkHuDH77j8+0CfsLkusSiebL4sU09LoOIpyExcJU71IsGJn3pcIR2lU7Z/+
 JEw==
X-Google-Smtp-Source: AGHT+IG39bovhmvm+MMijSHTe9WLjTqmO0GismawdSL04b+qBtowrHcKNiy++RkMK3EMdkOf8O95Zw==
X-Received: by 2002:a05:6830:2a8c:b0:727:345d:3b72 with SMTP id
 46e09a7af769-731eadb676cmr5589262a34.16.1746456387488; 
 Mon, 05 May 2025 07:46:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31a2366sm1495605a34.3.2025.05.05.07.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 07:46:26 -0700 (PDT)
Date: Mon, 5 May 2025 08:46:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: "marex@denx.de" <marex@denx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 "brian.ruley@gehealthcare.com" <brian.ruley@gehealthcare.com>,
 "ravi@prevas.dk" <ravi@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "paul.henrys_ext@softathome.com" <paul.henrys_ext@softathome.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Leonard Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
Message-ID: <20250505144624.GC5430@bill-the-cat>
References: <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <CAOMZO5ARze74UsOqUbMLfsyjfFcpBQ38hgqTZnrP4ZkqNOZiTQ@mail.gmail.com>
 <0261fb66f34d30c6fc3ea1995bf23d4a055dfb6b.camel@phytec.de>
 <CAOMZO5BtELcioQPygHGx6rsRmFvxeStn-PFf3B22BeXkgUbepw@mail.gmail.com>
 <20250331183118.GL93000@bill-the-cat>
 <CAOMZO5ARjb5g4q6xATR8snQ8OJQnQBWfPQsUqUFEX=62=F3-pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rOu8pe1F/qmnpvfz"
Content-Disposition: inline
In-Reply-To: <CAOMZO5ARjb5g4q6xATR8snQ8OJQnQBWfPQsUqUFEX=62=F3-pw@mail.gmail.com>
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


--rOu8pe1F/qmnpvfz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 09:28:19AM -0300, Fabio Estevam wrote:

> Hi Marek and Tom,
>=20
> On Mon, Mar 31, 2025 at 3:31=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > And make similar changes to .azure-pipelines.yml as well please.
>=20
> I made another attempt and still get CI errors when applying this
> patch. zstd is not found in CI:

The Dockerfile needs to install zstd then it seems. You can't install it
like binman is trying to do, in CI at least, because there's no apt
archive cache (it's not included in the container, as a normal best
practice).

--=20
Tom

--rOu8pe1F/qmnpvfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgYz0AACgkQFHw5/5Y0
tyxPjAv9G7Scg+9qJ9pfZwzntfg6e/E51u89MWB8S6sEFyvKZHy7PjvUY682wEtk
55gtzJaNs8hYSee7VKGcd3sOatYrvvMs9weQOA0/n4W9C5CdOza3YA3T6115aMwn
mwwKKyMqnVBgJ7xZX7+cFH8TBejcJncOE8jcrgCbUNThK94fJVw0LgAI72NC5/+c
Ojrbxo/znh9vRym3KR1GOK+rFt60ExkcnT8Nd4ZetVIVZpUnsu7vt+KYvmyWboCc
/27xCUt40qwhV3j1jo0PQ2oQkYmzxMRfi6Kf7w/2j7R7wBr7ZEfIb7IsxHvcjfHu
0vfhsa9cd/hEulPVNpwW15ggxEMyl5o/zfoa950CysetDnDHUJ4eMv+EKa/mljKO
FX1fv8JR0AFsyIobD4re4K752DAG/dCDe8oTr4cfbql9boJpLJfXjfbMwFxO8BBp
oGA4CsnfD8/MCNeZgGqfrRm1G/JB67eE077QgfraYKhHLvtOkJhndk60eGT8FZV/
EVFGn9P/
=hM/L
-----END PGP SIGNATURE-----

--rOu8pe1F/qmnpvfz--
