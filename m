Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F56606A9D7
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zpWQh950;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UyTbe9ab
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DC014043F;
	Tue, 27 Oct 2026 13:29:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uiPU4S_ix5hA; Tue, 27 Oct 2026 13:29:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 99D0A405F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107772;
	b=N/uq9aH4st3Ll7ZU5Pt1j5ez5xyaPOOHWpfuToZJg71CeD8kZDg16c8ogIl01AhexUnp
	 47aM/2XlwgsvL4X7DhQGSh1d79+E3aK5tQZXmLELCsWvygs+RVXK2eNSQGW04wKbFHdTW
	 5A031tYGdyKMqytPDO/fjDTR83MbCb7S6YRbSpQhQd9QKrWEinFUUZNTEKHnPF/yVyetG
	 xtbKx+Ixg2n6ecoIEw8a63LtMesQ09lZ3hgfnEcykaocFLCahc9AbpYzG55ODpJk/r2DZ
	 111m3mPWrkj8Y8CYLzUuJOS80JxCoo5uHK54NAdQcojwQ79V1IxucjBwdYjrv25m/aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793107772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
	b=L7mnCrKhsOMyrJhJbQXxfz7LNDeAIwmhW6gyXv1KqW4cQKG5uf8qnHX7hA0O//nj9mlE
	 Jym7+gJmBYJzFLHzfu9sqDDT2gXNxd9F9YKN6XjEzHpWJUvzNdkstwrzo1ZIylSnnsRMd
	 NGOsQFMkmT+Xz1ixisEI4SIVa8SlUlaAqnWj5lgd/nv0n4+2aYns81uQdDwiYoPX5nGK3
	 6UUGphfMcoicTUi/FlyS/hznQckS/NokuPxDDsrzzEDcjVQOoGKFPAcfiI80IdYQKQ366
	 PWPbdsRc7F4+NTNCMDCxFlED2Vad8KHNza2MFUbCkbgXG9VtWacAikxewc6d70mt4Mw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793107772;
	bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zpWQh950oe0zHH1PxugYpUtbuu96pf9giZxY7VZLTXxJQ/dEd2SzfJgEn89Qwo7My
	 q84TOP9QUK+EH5phupygdK8sRCCZs1e0H/RQUNOxoso+iQ4bOmS7hRnkCrUdrPIhma
	 uFLmxXGRVswneW/GNoMNMRENiYeza8YO7JMulE4NuGQbw/EURu8pJsr94R+VNsWdMv
	 QbeepVqem2Ycar2MP1+uNgIDWCUzZGVp/AlcYgxKEV/8GNOzuIFP38mEFhJMDa0/hF
	 yetH5A0gP3stHOfyKHuir3jJn+vrRWemhgKx7ts0t81hZmG9VhW++ILZ9jKFpn1hrZ
	 WgpsQP7OG3N5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99D0A405F8;
	Tue, 27 Oct 2026 13:29:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BAF8279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 417C9605D0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4je4sNm2PQv for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3DA5C605C9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::535"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793107768;
 b=G5P9yrq7jYHkm1BX3kgdtV3DPJdm34zO52mOcLN1Wfyp2PdFreNSTEjvsqBY6BUQuC1E
 9zm6TTu0OvKx0EagUgvTq6Y/fSLDDfNWR+p0VoN5wHdWm7uEq9kzzTTue4JdjuUZTU8Kb
 jI4et9KOEnB6WGg+ngwEiZxBa5JI2f4AvIDDQVgT0zMKgtP5QcgtFR4ORLmCpNO4RIjjx
 sKoZwXbJmR+FoZLgbA/l7QDoUWESmy9vdV4WyvMEJZE1nTfcExOK3LECBkeZ9EH51Dm8z
 73f1gN7qfisho8e7Mw44UBpvfZspdH3mLguanBRT7mW9YB8H1S43LyLjaPkCwtxrgmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793107768;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding;
 bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
 b=E0OaEwrEFAfUa0VyCx2DDDDFLBz4u3TEN5xtlD8HpQDPginCWlnQT5EwJG7Cbzn1vsJY
 B50AcXVLTvB5ODQpK2mmZ8cGxx4rsLc/5kMKnsVoTR42F+kT03btl8C5KdteNMbbLzOTu
 HFj2kibHQ8egzf+VHcwio8pF1MKJchoFp3lrpoMIhxxLgi7Vs2HbW2PKYeulxDW0cW4QK
 2HbfYrZeLOaIYGwGhgRhAiKGiet62SNIDHQwJQT0FQRsk/fFIvlLKQxc9n+kKn/VJr6ei
 GQlShRFOZ6uHjHjA3yNCNK/45dExgwOnUtDSva0UwHQRwCQ+kvX39RJ8nU+66ZSh2tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UyTbe9ab; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::535"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UyTbe9ab
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DA5C605C9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:29:27 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so6079525a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793107765; cv=none;
 d=google.com; s=arc-20260327;
 b=f3k0AUTRPunQdMxIVausyQ6MvGt2ikHcnPeOgI6HDR3I85RS1YXZ1k/funRcLjF3if
 C40TodMaJYbsEHD1AG7+jl9Q0mqlJKWC89nQ33pAjH12ueJcJXDD//czrpeSSANfFcxF
 buCz/MtLRUD6kdR+XEGI15KPZqHiPlgCRYTdCtAuNq5C+hTY44YPL1UhU3I8hn38Qy4O
 5Ucb4V3dHNQ4oPCTR+87lY4gPozaYydhK3r6nJFI5fXfQv6xPEniYXpxrFjMUB+mpG2i
 Rj4izFD3rtkmoJ2oPZXY6YZwQJO9k5g1OPt4/Vw1rV5yEEj16WjeVbRkLOYebWh02LZM
 Bw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
 fh=MobRHbWoZgdLw31Ff1oMaU7mF/Pjw9wcT8En/nD/I3g=;
 b=dq8RhpjJg2KC86gFMhLg80724jY7YFmtem/lc8ySDLfGKcqaiCdHjF+8MrLBqFlLfU
 vbtQipDZ9hm6OJ0q3iQaPr0DeHaNNxuPHDqev29M2bU1czGF39lSlaGHYxafQ3oYS1Uz
 qcQEud1jrGchHB5clc+fwWbIWT6ly6xmF3dBSPAmc+Fa2NH8F5Q4DoouxTYCu5prs/iw
 ym3WRKjO6ay9smDUU/PzmTUp743hHTQ52k78ioerCtY4o0S2vDPhEkYLT2nOC/CEWqWH
 44s+e9KRw8/nNSLb843hQkURAL+KmlyVxfW+vVKyzSu/VVSVthAkbntvegSIJedd0ANC
 3A2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793107765; x=1793712565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
 b=UyTbe9abmPqS54vwyuC4onmG1d3T0Jxqt8cqkZ9goVaiTUnDb9PUHYeSauadtGhxtV
 BfWtEDapl8cDowSvLMWPMLaoeIsFi1RkIRYp1odogkNB1m2DzUAwrmg4s7kEHDlUUEHf
 zjwtpUS5Xha3YPHi87Tas4Oh/mg3kizJ5gnRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793107765; x=1793712565;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HfJC8RF91ws1o2nll+ZlEpw2ZwL+5rqiEX4RXmmvC8=;
 b=uNK2lNXG3i7Sh4DNYjxHXudaRcJfg5F+z21aeu6pHsMw5GmKAvveFRx/XgCwPwNL2l
 59RckRYvpxA/9/kDB+4FwJN6CtUguDcBVCI6kLjd15GFKkaBLh3FCJDLu90RzgigN/je
 aGq80TaS2Vd1TvP52QvB1QsOw+vB+eAYJsU9684gTi9KHX8O7xUf7BjwFfB6RyzElzv3
 HCWIuE8M8sgbLK5T0r98TaKJQw+YHH0X3FMGmVgLB5lc4UdK54qpIf7lfTcMvr1HqyfU
 5ilc4m8OjQ8wzKJzJyV7mj3CPwMGoxK84H1Jo3yddHO596zLILvf0117GiH/CCDnheVL
 96xA==
X-Gm-Message-State: AFq9FYKpVT9+aL2rIeLVEC8xjD1hnsAzBlsfeNvu0cK3CuqldeV6y9ti
 3pOctXdlnR573ybXeoRGDA0RQNnHj7nM2gN/Lbos/hryOkYaWCDgVJSTP3Hp0nQl+vC1FMCTH6a
 hGRWYL9YTHOUPMXGtrJjHDRNboZ8X+/RYJ9d3udUX
X-Gm-Gg: AYBFou1Xw4SbnfzvC5dZeMMBYhE0WA8wTxLW1wDOrDfSTEkHHu9JGLQ0BRAnpSUCozB
 WU5aubP+IrEz5CdSv56xZXj+q5Me/aObFPuXgsd5PZBR1YKyA/7u/daqzrCiPEwPH3dD2v2df8l
 QyWxr0fTwk+FQ9G3mFZB71H2MH5TluGAa4n6gj11Ed9I/mud7culRe+SI4yZ8ra9CdpB9rOvCzM
 3p0HnLC+uZlFX/cAisIXOqQ21fakW46PJFGrOwB+RDF8XEv89T8v/3e/4TbnrGRnceRMk6DihjF
 aEiG4fefCywD3jjV3Xg3rypYp96I0PK/R6aNdFdO+1ZxHIK3V07rsu7p4ElcrAD8uwZd5Dfezef
 s151IZYHGTxdPG6tNLv+RMCftuUzYStFNaFk=
X-Received: by 2002:a05:6402:1e8a:b0:6ac:b3e7:2357 with SMTP id
 4fb4d7f45d1cf-6b442fe0ca1mr10875566a12.21.1793107765416; Tue, 27 Oct 2026
 06:29:25 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:29:22 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 03:44:20 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261025231817.1155249-2-marek.vasut+renesas@mailbox.org>
References: <20261025231817.1155249-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 27 Oct 2026 06:29:22 -0700
X-Gm-Features: AclHuK-41L2_lJn3cVMLZzJWSzr8d-ZTBOIMIXhJhtFlNCp2bI7cMXjFFII-Hoo
Message-ID: <CAFLszThLk6iE0YniZCLFjtXbE=+uJMmU934M16HR7FHggUseiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools: mkimage: Fix discarded const qualifier warning
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-25T23:17:42, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote=
:
> tools: mkimage: Fix discarded const qualifier warning
>
> GCC 16.1 defaults to C23 and glibc 2.43 added const qualifiers to
> serveral functions. In particular strchr() will now return a const
> char * when a const char * is given as input, and a char * when
> given a char * as input.
>
> Fix the following build warning by aligning the data types:
> "
> tools/image-host.c: In function =E2=80=98fit_pre_load_data=E2=80=99:
> tools/image-host.c:1797:14: warning: assignment discards =E2=80=98const=
=E2=80=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>  1797 |         name =3D strchr(algo_name, ',');
>       |              ^
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
>  tools/image-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
