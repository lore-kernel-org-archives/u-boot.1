Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3EECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 14:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8330181083;
	Sat,  3 Oct 2026 14:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrM-Av_nw0S0; Sat,  3 Oct 2026 14:40:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org CB55980F8C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791038457;
	b=cRpn52BMZKDR8uIMZGOAhtLPZtIbqEd0BPht0Efs6PlCLlRx+HDg5E5QiXV2T26q3ptz
	 qGlNSIfTkBRNF2shfHqHwqeOcLcMJbqT6AUdHhy8XDY5l0UElMAnzyBNwjCacRZb8s/Jy
	 Vts0vy8BguMbLVUYnHx5vvvAlW3tOEaj1HE3Wt1d0JLIlm+lHgk8GKSFMqmOms6w5ktzA
	 WEwEYi2P2ZHdqcTw9nA4ZPApVpeqWr94sBe5WAzW64wL84hllWR6wuOq44Lz7LHN3qGX5
	 rqXxFgx7oDxdvZ8QJrVNPDLpL/HpLc/RD2hPLu7OrNKv0s6dnFPzA0wQZKuYPNeFmtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791038457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L/nOOgT5xZf3JbqEQC3yae1lvJmooxSqvxvK6ulcdYQ=;
	b=U66wtDYptHFIJ9Tv9tsL/oaVxkdV6ReXqI0GPKvgxDtcTr7c3jFPDzbzxvpJaQ8k6YYX
	 yWvO8t2VCf931SLAi368ujqy5cxiV1HeKz+UP8QudiFueyYLjAiq2fZbrgvvYSE1peCcT
	 kuLSLU+v/72niUFRUKTEAIWYhw099CTDpRsZPSrqrVgI0gV9app8IotIma3gjQCx9ReaC
	 IXDkgo/80uBO8sUXhMiNmJGrw9gUn/hnGUz9aXIO/BbG8IISM/dPWOsUsXPiGxDfxyrke
	 gKg8U8ctC0qdpLfMY0TKtH3F8bgsiRnKyrnOSWPQjG70YrW2LEXRS8YOM26nxCW03cw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791038456;
	bh=L/nOOgT5xZf3JbqEQC3yae1lvJmooxSqvxvK6ulcdYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uBu9f58677/DicxcZk2A7/Otkp51DZNf984S5afwqHVtjTl4WcrykSwuiJTbBJFjs
	 uQp1TwUpt23K3F92JtJzcY0iE6X3tzsqlQ1w77P/DOHr4eqiGesy6mVrMc0yQux8Ya
	 ybdppqNwTtQeO97m2ewd5S9nyT/uyOQ7ZF41OwA9/bAe7kKXv8hJUDwMe0wXhx1uK1
	 sl3CWAsjxxtHBD3d9Ce0lAs0k2IkInGhpn2yhJBp4uH4R5KUtDOATE10kn/aLLmMQJ
	 6/Qghr+Tf4ZFhmPoJNwFHsEc6upg9aHbw5h+7W9jMp1gJ+oUncEBzhvqhUlEc0l6JH
	 TUX1PIUUvi5CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB55980F8C;
	Sat,  3 Oct 2026 14:40:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B2E082E0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A41DE60621
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RiEfGUg7ELx5 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D8DF8605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791038454;
 b=hVA85Zpy7YX2+DifXCIGch8XLbh5Sl4zCL0qVAusJDqxI14GPc4gWWuk8DfT5UgmXZpW
 ReNo/e/DqqIvW9QV3N5JUwWDnXcte237ZEQgHM6YYejkKje+lcGhFlAroUhG5JH1WRRJM
 8d54NPW0E9/qQjdoU4NEAWelcRmzt0cScddl4hKS/Y53SAC7DPkoOnBoihrkFrV9AFrtq
 FDei6gy+pWrrOdrnqes6xlM4fK3vQUTql55bAUlJwzYisqxwhqcNNabkh7va7ThgciYMK
 a30fLiZAXpjjCwsmfSirXZeSXlZuvszDJpNr9J0mZEGGMfuwHlxyHi9JgXMH3MZEpwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791038454;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=L/nOOgT5xZf3JbqEQC3yae1lvJmooxSqvxvK6ulcdYQ=;
 b=Ygle4iKIpxfEvnkdwMS9B9i3Hsu+EJgeHrUsWk4sM4b5aIUCYn4NzBlJJDCEIyl4Bhcu
 ga0p9BAH6IMY0Vte8exqiVeoT5ACNIrsLsV03qMtxR7cBd8uwjg/JwjHRFDpW9CqncGl0
 srUhWF6SCmfBc4pzL6YWePojU45LbxKEtetvyhU0bheHTftLm1SXg+KNg8ddxpB7npFWD
 i17CiQO5Gr6zrrT1SACLXH/l9pi3/qK9tMYNZP9cH6LddlclDXyiMsDHqABNJ/0eNA6Vr
 wvGtlCyM8hko76m6sp7B/Rx5EpvkT63hK8PCYjuqIhVcCBLGrMbJIpo72L/jspzCgPw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U0JFwzbR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U0JFwzbR
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8DF8605D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:40:53 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-824c29c9da6so206220a34.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791038452; x=1791643252;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L/nOOgT5xZf3JbqEQC3yae1lvJmooxSqvxvK6ulcdYQ=;
 b=U0JFwzbRpjAX+/5rhNYY5W6FeTJx9BnV+l5J24jikIxI7YZZL+lBg30FnabI2oBG1/
 LGtUPE6Azo5BmjQd34YzHZGxdGw1JJY7p9BltcsB5JQo96upQqW5gfBhOx7qxth+kCWu
 I1EmhHtsoXGZCrPVAEdbp692BjfcDeLKQINhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791038452; x=1791643252;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/nOOgT5xZf3JbqEQC3yae1lvJmooxSqvxvK6ulcdYQ=;
 b=yQtXgSJ5t5ao1cRy0sLM3cWgwp+176tgjOwlCuTQ7vqcHAMPdUUxxxH9J20dNkD92c
 3ysNlLHD4DG+DHQfluFZmupZniZe1rhZX3hx/xLqMT4nFml7HiCQH4agil8mtm4QYVPu
 c0cbEIClFEUpI0uRehcUoSEtd7oMH9kEKmJq06vk1Xakst0M8UKgVjXupRZBJinuoBSO
 4BIS3xq0pomLJNgz3haxs112iGEHhoXB9pqTKeTK92Veuy58PDVZNYZoptVRvsBoOf+B
 iUxADTGZuNBofeHkcdgvUBCCqkkBheZRUTDlCjoT3zMBMhBL/S4zsQBcDIH/Xb7URgV2
 zpyg==
X-Forwarded-Encrypted: i=1;
 AKwUvByIw5l4LIzbjVb+4YBcECX1UU+0eWUdsWolWQySkbLvC9XQOgtdnEVp2S7XKsLuKVqtLXvvZas=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nRi9Lr3CyUKCbfbXbtoRMO9ul1h71EdAk81jdskl74vvsJc353
 uVkK/wwJaVsl04RnNX/UoABhelHvHZWTR5rMh9HL32rkOzPqRIzOoT8NhMPrCtbJe0c=
X-Gm-Gg: AYBFou3dpLT9YRxMv5gEn3U3Z1OKJUkxtvgJGhXJ7muYhS35wqwtataTcWZcf5MJv5E
 9vDzok1ty8XmToBHzv8sPrUEl+Fz9kRJZAklgphvuJrJh+WWZD6nubc+UHaJXOVm63ygDfB9lZt
 UZBHYZm3gpVpvFcn74uxVQa237hCgOKQaT3XhhTBbZdaJDYtWeOAgb3u8e46GrdoE8BzwOZKstF
 bZdPi7k/IuewvNSKSVrDEi5tdDSclUe4LRA+nifIxY54KeOEI6FfvUxi1jOfQJNZAyw9fxqOB+a
 sLY4kv4bM0ncBqCDoYsaYoyw0RCikYt+HyFUa1jTYWJKQcrfsppuNQAFTDepZjEDqnOICnDa5eQ
 HN3wYyxEu6kRDlmGbB7sMkWT/MtdQ9+1J6lyWu+we4lSnNO1P0yFX/4HIkFTH2Y9F3xPQq/6JSu
 nMRKU5G3e7MZZpde2m9fvtEKKhGM+iUYMl6BJbqj+2b+bnAlPVTwkIJxkDlBfzX9G5OIYnQHaJE
 j/UNYSgO6b+5qZ64YGSttvEe4eNZKIeOjt9bFL3N9VRE9iIGI1juVcjEVQkUIxrgtuQfPnFtw96
 /xH78pPFQezPhZYtk/A=
X-Received: by 2002:a05:6830:67c7:b0:7fa:ac4f:773 with SMTP id
 46e09a7af769-823fd5f6e7bmr2661456a34.18.1791038452206; 
 Sat, 03 Oct 2026 07:40:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-823ebde0865sm2608370a34.3.2026.10.03.07.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 07:40:51 -0700 (PDT)
Date: Sat, 3 Oct 2026 08:40:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Haener <michael.haener@siemens.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
Message-ID: <20261003144048.GF2658242@bill-the-cat>
References: <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <20261003143524.71665-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J+4LbLe6+YuGRfCa"
Content-Disposition: inline
In-Reply-To: <20261003143524.71665-1-michael.haener@siemens.com>
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


--J+4LbLe6+YuGRfCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2026 at 04:35:24PM +0200, Michael Haener wrote:
> Hi Ilias,
>=20
> On Thu, 1 Oct 2026 at 11:41, Ilias Apalodimas <ilias.apalodimas@linaro.or=
g> wrote:
> > Any reason why we can't add this directly to the uclass probe instead?
> > According to our docs, the probe is supposed to 'make a device ready
> > for use'.
>=20
> I tried that, but there are two problems:
>=20
> 1. On a plain booti/bootm nothing probes the TPM, so post_probe() never
>    runs. Something still has to probe it during init, which is what the
>    event handler does.
>=20
> 2. It changes probe behaviour for every caller. Once post_probe() has
>    started the chip, tpm_init() returns -EBUSY. With that change, five
>    existing sandbox tests in test/dm/tpm.c fail.
>=20
> The existing users (tpm command, efi_tcg2, tpm_tcg2) already call
> tpm_auto_start() when they need it. Since a full self-test adds boot
> time, I would prefer to keep this opt-in and explicit.
>=20
> Following Simon's suggestion, I have moved the handler to lib/ for v2.
> Are you OK with that direction?

This does show a concern I've long had which is that we wrote this "test
this in sandbox" in mind, rather than "make real world use of this" in
mind. If we need to refactor the sandbox tests so that they become one
of the "reset the system" types while making real world usage match
expectations and requirements, I'm fine with it. But it's still Ilias'
area, so whatever he thinks is best here I'm ultimately OK with.

--=20
Tom

--J+4LbLe6+YuGRfCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasET8AAKCRAr4qD1Cr/k
Ci5SAP9FhNkpHWpc7Dx1Bkzv5byqg4XOR3tgHIBbKI5lWFBYegEAxvBByurzFfAp
ZT1zNGMlrlOmhgCsle1is3VhQ5aEfg0=
=tpVI
-----END PGP SIGNATURE-----

--J+4LbLe6+YuGRfCa--
