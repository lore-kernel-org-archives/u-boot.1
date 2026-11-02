Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A40606D80F
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I7uNiT7k;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gIsj8gJY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA6F0810DD;
	Mon,  2 Nov 2026 15:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U1VvZz13yByk; Mon,  2 Nov 2026 15:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E2AF78107C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793634208;
	b=lgTqjIoR6uEG1vdlxy7geulog4gCXGyhW7h3l9h2kOE9yj6AmjnfIQ8vi0QieU+1QiM8
	 79hmoEY95K5ytehWdZf2CDW3geL92RnDp/PFpHM/wkqz/5H3LQvxwKMmkFh2ADP0NBhBF
	 Oxb8tUwMVBsMNtMg+dbGSAbObdXIVErZ+6YYwu8igoz/HwOuyqkGbl9AytoQKKlTMxSwZ
	 G/zTsI6ZN8eAqIEB9qFilYZJ5u1a1rKlnOdNJdX7aeosNR1+5O2eISi4AADL+zg+wmbp1
	 fHYI3Zwrj19W/woUfxsorbRsT6WpqWXDGX4CUatzs5/LZ38k8LbKAbM0C7UqbbvrMAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793634208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AiyANEtP9J1ROiySnJj1KXWJQqYgn+wFjwgLVZnih6I=;
	b=jNQU/ld6AE0JP1I+Xqc3DvYnZ+HqKwG3iEB+T/MeQu/61kK37r/3Wq1JGBKNV1MBYDfM
	 2vPpzPksXw7eGOCvlE6CwIT8lxtkIg/3simfGmHTuq6g6Knuiyf/gC5IuQOpSsT04yJcf
	 17vKnQP1M3y+LxW/03Pc+rhw3yDz5zjI1/Q9v5QdbQ9D6vfcgPnWNY8KLAsSGJ5Md2vLl
	 Cgb2qeyWltT8O7R4nm4YqcX/j5J7smvoaBhpCSPKF5wvCMxYjfaYrJeBZs5WWW3C+oWLl
	 00LLAtJ/rt0P0OgMZbN7yxENhPY8AL+ODJl2OnEyaD46+NAFsi1Yes3hWaOda/5iEZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793634208;
	bh=AiyANEtP9J1ROiySnJj1KXWJQqYgn+wFjwgLVZnih6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7uNiT7kAAnHmwIPiNGRuaOwj/DR40lGRywn9DDizT7v7571ixIiC/t1KU0XBasRf
	 IuaK5PraM7EdyClqXmM80DGWGy05RXYptTfQn12GOUm5q4DIA+Mveg4IzFIeqzsiLY
	 KwxM3WBcdtbl09JqSTKziWv1MC+2TCAGGz619nCGEY5VWySsqLpvi8e4CbXPfhho7y
	 r+3GCYQH5ljhxTLqs6N2P+D7B2gILgSfMiwUiPzwX0kFT8acJkQ2yZZNmKdkeN9rJo
	 q4LwBRwtLQcigQornUFxMoZfckMxm7bCLuO/bEM9wafgGYrhdWlMf/EN+BawH9laJr
	 TA3QpzSOGli7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2AF78107C;
	Mon,  2 Nov 2026 15:43:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B014D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CF924074F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:43:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 279L5xg_8Bu9 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F94E40746
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793634204;
 b=A17sUqX7eD/XRopNyzQFulPTx4KFy3kF3mxzy6rhJPpLlYPjo9KIUcwqEIXTtaZ5WHfX
 qozXOaEKXDY6kAzxG4Dr8AWI0nvpJ93Dwh5LdW3SY0lRUNpByJ7c5HryspbbR9uR7og4+
 JXqQYHhSud10R8eNP4w9J/KGs9RGFxBjB+LlaV4DpKGn0uoWQY3wR7x70w6lDfPQACpjD
 Uc6Iw7MPovyNzzUf8bb5P5ETkCDzBwEZsc9QZCtNxDtw8Zk+esE5x2o/f0FCkIgZQjwhq
 cXQydgLHYYDKssb7tMNjnXsyy6ZoYPsw5lKsELEinN/CjFWPF5NAMT/No7JtxyVCcDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793634204;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=AiyANEtP9J1ROiySnJj1KXWJQqYgn+wFjwgLVZnih6I=;
 b=VsLKcVSHDVp0foOnr2n3qNcrV4a01+cu3BEvHQm+b/3QonbPJtAWjzVD/uhbbDov0B14
 eJq0I7Qcf8lXWLLTuRoKsi5IjLocyUoWYKQDExtF8Dms/1g9gQmQAtpC+WZUmpAaI0nU7
 AhqjU9eRuIH1xmWn8xvxyyhCoiJY0KOEvl1VQElwbZbJsBM+/hCSuj3qJYb+3ggymsNkd
 GMDytDHKrGnCrfPLEbLfzoDuTGSXl3ct2Z0W5yOMPqiqhxdIwG8nIAv3Gh/nDAf6C0pay
 ZrQwsgJWY5Qd5zeKQe1tXmEP2AVs3kJV5S1UDItMvx8PfQ7lzfSjozCv8CEhKuS/RJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gIsj8gJY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gIsj8gJY
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F94E40746
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:43:24 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-82890dea412so1486796a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 07:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793634203; x=1794239003;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AiyANEtP9J1ROiySnJj1KXWJQqYgn+wFjwgLVZnih6I=;
 b=gIsj8gJYM0j3tkjkB3Fpl2MCsbVo5uz+/wQLYMBph9/mL90g+tMAwBwESmDFbH9sCu
 9lzJd1hE2KJiSwSlU7Stf7aH8Im56ESeLv7O6rea3Pu1mdH2x93US1UKPJqd4sfEqssr
 ON8PAT987YqxSFF3BdMncb7WOp0wK6qVXMqT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634203; x=1794239003;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AiyANEtP9J1ROiySnJj1KXWJQqYgn+wFjwgLVZnih6I=;
 b=n6pK1s98U+0It7Co8PiisOiw7sydIBpeBQllIgSpbYnwRzDAYL2gGuykeNPPScChYQ
 Z7Co7z7fFq7+qrM+Y+mIAIyCdJCp6OFfaGNVJl+qnam7rNvGeiem7EnuNiUfKoSW3mKN
 u3ZU0yS3Asc2UcKE/Oe+XRV87gSVAIVw6ewfYKYzuhKYyUDIfhMbxMzR//TMTpiZnckQ
 YJUx57Hf2rhfU1r8dVlwSee4RKFaX7G7jbcBnnsClRDNX9QoBX0HZ0QIZhedTe+cyfoT
 lSTuaghR5jmtuLjLFin0edT7RBKvUBXb6oaPgOoWW5Jt7h60Z2TqWMWYeaYVSgG2aQTS
 b8Ag==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSchn5lV5QwS3+eupFV87WEQCCGVyc1Y8u/tXOYuMlaxhGe+tM2okY4r67c359Bo6U5IjEi8Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKx096fxwDyHy5WWA7tkaudUuQPwSR2jEcuZ5NSRyKAbV09Bm3/
 D6fiTynDj01jMVnP1sbQub7eggskMlTRJIYUk6LVUBs0NTIqM94RiB/ItOQhNDd2XTA=
X-Gm-Gg: AYBFou0S+p8MQa1LBKQoTL6r7bESWuK+RMNDFT7ms2n2+0BM47Skll8JoR9eSm8LIv/
 2MhpEEOWDbCwslTSrEVcYBvHevBzViNJyQlRv08esi6cQy92mLlbHcSdgzze0ZqnRzhUTBhEPmW
 W/tKpzP/L/rV7xW/C08/MSeYhHb1UOTO+yJuZkxxAYNX+lNEilsIScmIQf5TVamE3X2RRskAgE2
 7r+QamvIIWfJvpOSgk/K0Qx4HBc62+opQjl4hS7ySgjJBeXnULJK2NigfU28E7M9gQxXihH3dg9
 JqA1ryjWCii1flDKAxEyOL90JOdkXa0SZhKL+tVZvE1QCN9oIWH0+KgbtYo6zY7kRV8ePiyYtHh
 orc9M0gjQSj7Nu6WPYkdU/wDhAUtWXU/yzFe44ZzaG8RnEy0khGMhwyr2DbAz5swE6DeiepuOXw
 jPt0IQF6JsulDaTF+if/jpmbWOnbRExVwEUrItH8ezQ6TIH0B//0EDKFBUp+ktBddONU1+UjFf9
 kAL+RLEDJ0eTDoscR4LWnOjWfYnpBvSDNdepZEZtBdk3i1T2N5eON1g4SL3QEpq7DibHbWTMMFF
 CEYWYU5kKnBS9hBw/dgfo6RLyq0VuIqXDWlGrKMKbfjcYCw7eEwA3yXKFKYOWMjTfziQD2d+nUX
 2szcFD5ZV/YkHFGN1MPJlv0wjFlm6WKlY4ROHrU2o4UiyGnoPhQScvt/kJenjbo+B8qqnfaR5Fy
 0X4fvLhzruVDZ879i/RiHT+Mx1qbVKQw==
X-Received: by 2002:a05:6820:1690:b0:6f5:6ba1:aeff with SMTP id
 006d021491bc7-714f296646bmr5698505eaf.37.1793634202891; 
 Mon, 02 Nov 2026 07:43:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d354f660csm9285287a34.22.2026.11.02.07.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:43:22 -0800 (PST)
Date: Mon, 2 Nov 2026 09:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <leo.liang@sifive.com>
Cc: E Shattow <e@freeshell.de>, u-boot@lists.u-boot-project.org,
 tim609@andestech.com, zhuxu_ran@zohomail.com, nwhitehorn@pa.msu.edu,
 nikita.shubin@maquefel.me, pengpeng@iscas.ac.cn, me@ziyao.cc,
 jamie.gibbons@microchip.com, gaohan@iscas.ac.cn
Subject: Re: [GIT PULL] u-boot-riscv/main
Message-ID: <20261102154319.GV3309461@bill-the-cat>
References: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
 <9a9f37da-2aaf-4770-8a3e-3d946ca4e275@freeshell.de>
 <auispJr4NSDm9bch@lliang-1876.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gf2V4zn+aoDYi23r"
Content-Disposition: inline
In-Reply-To: <auispJr4NSDm9bch@lliang-1876.localdomain>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Gf2V4zn+aoDYi23r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:30:44PM +0800, Leo Liang wrote:
> Hi E and Tom,
>=20
> On Mon, Nov 02, 2026 at 07:09:29AM -0800, E Shattow wrote:
> > Hi Leo, and Tom,
> >=20
> > On 11/2/26 00:40, Leo Liang wrote:
> > > Hi Tom,
> > >=20
> > > The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb=
0cda3b:
> > >=20
> > >   cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git m=
ain
> > >=20
> > > for you to fetch changes up to 22c3818159190cfd6dd378b7a628c0b339ab1c=
3b:
> > >=20
> > >   clk: sophgo: cv1800b: Drop legacy compatible string (2026-11-01 19:=
16:36 -0800)
> > >=20
> > > Ci result shows no issue: https://git.u-boot-project.org/u-boot/custo=
dians/u-boot-riscv/-/pipelines/1815
> > > ----------------------------------------------------------------
> > > - riscv: sophgo: Use upstream devicetrees for CV18xx boards
> > > - riscv: mpfs: move system controller configs to CPU Kconfig
> > > - arch/riscv: Allow booting from NET
> > > - riscv: mpfs: Read and store FPGA design information on MPFS hardware
> > > - MAINTAINERS: Make RISC-V entry cover all paths containing the keywo=
rd
> > > - Fixes:
> > >   - riscv: timer: Fix M-mode early timer support
> > >   - riscv: thead: fix D-cache flushing
> > >   - doc: board: starfive: update jh7110 build output description
> > >   - riscv: mpfs: imply the CoreQSPI driver
> >=20
> > There's one more patch I'd like to see in this late PR:
> >=20
> > "[PATCH v2] configs: starfive: enable mtdparts on visionfive2"
> > https://lore.kernel.org/u-boot/20261022110913.1415753-1-e@freeshell.de/
> >=20
> > We reviewed a similar patch for SpacemiT K3 and with the benefit of that
> > discussion I improved on this patch for starfive from v1 to v2 based on
> > what we discovered, so I am confident it is ready to apply.
> >=20
> > Thanks,
> >=20
> > -E
>=20
> If that is OK with you, I will include this patch and some of the reviewe=
d patchsets
> and send out another PR tomorrow or the day after.
> There are too many on the list, so sorry for not merging them soon enough.

Another PR is fine with me, thanks.

--=20
Tom

--Gf2V4zn+aoDYi23r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauivlAAKCRAr4qD1Cr/k
CihgAP4iIOr9GUd7vmNBmn+ilB1P7MBdQ9DIoY9y4MfCiY4TLgD8CFVG5lOZAbpK
8HCvabx2ENcQIIabIXBksKoGTOsu8gM=
=iKAL
-----END PGP SIGNATURE-----

--Gf2V4zn+aoDYi23r--
