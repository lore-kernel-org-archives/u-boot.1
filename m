Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A11606A326
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o2xzmV/t;
	dkim=pass (2048-bit key, unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256 header.s=google header.b=lNJg6WYy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD95F81028;
	Tue, 20 Oct 2026 09:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uVGqj4gn73an; Tue, 20 Oct 2026 09:51:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F244180FFB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792489876;
	b=pRg0ikwWdaIviHeKO4Tyk+vKwln0c3DPm99cMeIwu6jVbVH4aQIuw2NcmFhkjQRl37g4
	 eZU4Fw8x7zG0TW235XIIXdjcALpAMxJh3F0brSD+to6OolcsBks+JvFie4dcE7+p9QdVk
	 f7i0A3y2cnrQRDYHBdo9Ct0YU6F19uzL3l2xocXrfXXU/4AVSNJATPtfxMbXLFBdhiNx3
	 0tklefwA/qywxJUVDeeugHUMULtdMBqWfO1qEG62qnaG9uvXD+1JrsAeMq9Zt25jC1g6O
	 ZQ6IGnODEAXpgAiYBBoCA9+Zh/MohhEFYuFgceHIi++cTRfjTJ0iGMvuhiGYWqtYckg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792489876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zrpWZwrtbJA02lpLfWCdvYJ96uKdN7XE4ybecqENAgo=;
	b=sB8wxM4sKY/9egDfNOUsA2QNksoY9ce70yMk+E/JxBHkVuxcQicjnQNpDXaWMCjuG50i
	 hgDuME6WxRRtJj3jBA1p/+fSM6axG57du0bw3AXWaYcD1qqNA224LBXzd57tTtyix6zpz
	 3QeCdtFMIflCttBFEsPlQKdl0+R2wOV8J2CMGxCQMbkNMoFkYq/BG2/7FmDnXnF7Oy04S
	 e1dW46auOkipfayyju5XB/7+TXuhdyzay9z4a31grgBLqip3A5Uebehxul2C3ckPlnpCg
	 WLIasMktGMW3VW9z4XxgM28mnqIcmKnNACDaS0ra7nKQks4fXKYoo7JMEuauTX89DUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792489876;
	bh=zrpWZwrtbJA02lpLfWCdvYJ96uKdN7XE4ybecqENAgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2xzmV/tYxQaVi1aCqc9Z91rqVXg2Yt+pCvs3WNHqMCCMZ0+5BqcF9ceEgUfvCTp9
	 rB9sJNb3YoPyMbAGoh3ifJNEaWyVHkDB0TFogZdLoheiJBRFwgchHQT7JKIS0lm1BK
	 B/fx9slGf4SIcMvDnhqFm1b7saURJ68NnYSeNNHyx5qFkeaZIReO3fls6CkwQr0Pja
	 /1bKA+Y+71prO42Nk8kmQtnGwTHBxMjhkXWwjvxVdNwsKEJNphyY7KedSQfkuvewFv
	 Nxy+G/jlfT9FEGm++wmy5JqDC7HjPXsD729LwIzaNIVy2IEpRmTK+VQ/IwSyRsmNaa
	 Os24P01gx4fPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F244180FFB;
	Tue, 20 Oct 2026 09:51:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C996E1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAFAA405A7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5JJXmZYRVa4 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4398E4053C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792489874;
 b=sFoSBVs/9CbwjgIZIIU8sDX+rcpEBxfi9rRfgrHj3JzRMZYA/CgMeDQ7TYK9Qe7LQQxQ
 HgcQ8c8o/V3Ri24CX4re2pBZ+CXOogHz85DRYeO3Cb2s/qn1hW31i40KrO/qMxJaNjrQE
 UXiYJrJ0dQgSGz+p0D0uu3V5DLi3KsqGCO0h8l2MdngdULCaJ5X6Lz15YYta1eh2nCRKJ
 eMpdjdiFe6ZX8kbhO80GzFoGFdyX7ef57EulwR+3878vShuhMfLeG3CHHHvzXbJKCpClS
 XXeNoCgtdAlLSK3Uvww1sG2mTkVtXTKbd9eU+BnkNq5iKbaswK9nCbI0triExLkKj9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792489874;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=zrpWZwrtbJA02lpLfWCdvYJ96uKdN7XE4ybecqENAgo=;
 b=nHWyEBMKb1MvZZPx/juXiT+KGh27atkcVl5k0DrG9uBuU5cFCaFx4SMUwwAxw4NSe4dl
 XJMj3CTZDmobNl2u7e03pjbWbvE9BOZho/bwjP1DyWZiQF2vGFUyLcVxAeLrUUzErZWDv
 FnyaNCAqFEXMdy+93LY5cUy7YcOoIYvKIgafCfVRq+d5iEpeV1qSoDycjyPgCsYQ+6Af/
 iwSOp3fq6Q42LNU7dNTphjRb6wT4JNX6bYRX0Rk1JW5tIvY7KhZn4K5URycV5tx063yl1
 /0LzJMMEN5P8hAmndTD3zk9kZoc3qMjVgM2cAI0JVNyDm5a+N6tp1XgJ1n6V/Ntycow==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=sigma-star.at;
 dkim=pass header.d=sigma-star.at header.i=@sigma-star.at header.a=rsa-sha256
 header.s=google header.b=lNJg6WYy; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=richard@sigma-star.at; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sigma-star.at header.i=@sigma-star.at
 header.a=rsa-sha256 header.s=google header.b=lNJg6WYy
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4398E4053C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:51:12 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so14867325e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1792489871; x=1793094671;
 darn=lists.u-boot-project.org; 
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zrpWZwrtbJA02lpLfWCdvYJ96uKdN7XE4ybecqENAgo=;
 b=lNJg6WYyqqf/u5fhf/h269YQUc96q3DpXo0yVH1H7FRwd+0j1nGGYgJDbnJ3Y5nhh/
 mEyVCoxSKC7x5tkYPTGsHm+S2d/8iWhVavuBDKHnm/4QjOoHkpUY9xomp/cYmvNQxc4D
 ksiDfRYfyGaliz8OGy0k7jQAbWlLbdISf07N7b71QAV+KrFVIfd9caGrtYJjqfhm5qfc
 gzDQ4jwjVJdrWL1LZGeHRZrHsKbgBhgDi/k4PrzxGLKQF9pt/HugT3Ns9JSp/tM7BzW4
 0VxV8cvQoTYvYKU0Bi8/kFiy6Eiq8AB6I5xZyJnQI3Jns0gStSRoDkVc6zUTsr5jycpW
 OY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792489871; x=1793094671;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zrpWZwrtbJA02lpLfWCdvYJ96uKdN7XE4ybecqENAgo=;
 b=1oAe0xuJnHVeOJbA5Vgba7v42OwWZkATrPvMvBQk0De83YikG/O5e5axppChzkImtR
 6F4sK6cHTL16+j5Kys9TsW5T/3uLzHpVWunXqDrZuKqjRZ19IXnYEZW6QYBhBUV4F92H
 4satrwu9T4y9ViPhcRkOxdU0ptR5rFsqXa/NK1bDqzoPymdVp/gkIUYTDSHsOT789bVT
 s5MX4TytQXhBfp3KlXZ6ZBm5kQF3Je4rCX3LJKVskNkjnovYDMxVEQBEuYJx9/hHHiKV
 +6L1oxmB1sBs2UXQxgzpEe2WyDTlje5uOBeUCKz/g08iZRkxZlQPy21TY1qdOClId39T
 cb7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxq8TnoZBPmM6KZsc0xR0HtOCcXN7NJ6h0IaS/Xqrvl9mqjNYr0EFApIN3s+Fxvi5TvPrfkjh8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0Ua8EviGdw3TusqauCmZmhmS90LkP7+mRESw7sk75OGMc6WO8
 8u6RaN/CmHN8GkeWgwE89qdP2CIb72BWjczDOTAF+ET/Lz4w1Zy4TUVFIC1s6rzkdJw=
X-Gm-Gg: AYBFou3tyX3hXxZdnnu6rDH05OP3AOZeSJ14JvqS8TARSkAHiGqFWEL9TyozNr5T96o
 R0J31spX8vBHH+JpsxF3ccJ701f9FZelYWNwopfQwzLkbJJgrCri35xf/mdrZXp5GCvAosUFSes
 4tYQ/ovF1yopS5Wlchg+dAt+RKftvIDIPEVY+W0EY8wFLW3zIqWzhptQKnko2FIgcd/28Z5ff8O
 uw615/o522FeEN0KGK2D1ne8Y2l3IFtg6VD1vcfesZYhzmcRoACEJNxvfSyDO5oz0ItaqZqyzZI
 owzvI3f7VoCO2IGA2TLalDWmqNCooJnRuvVs6p5f57U3ZlKo0Enev2bbq3dEJR/QciOnGYB3B65
 FSfiluK/syaRvEmW92/fs9qOrlgQpKdMNoelUL8BO+e/8vymrfKwBDJjrCVmoKbAFZk181RzIqw
 nKVJWTu7svcXRcOZYy5ypRaXlx0tN0D9BUnST22khhhpygTXkHaetXRBO7m6dMymtpQi33ATiX2
 geu
X-Received: by 2002:a05:600c:4e8a:b0:4a1:8961:78dd with SMTP id
 5b1f17b1804b1-4a1d7616464mr228927825e9.27.1792489870334; 
 Tue, 20 Oct 2026 02:51:10 -0700 (PDT)
Received: from somecomputer ([2001:4bb8:116:4e2b:1042:e4b6:b77:2b45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1dc952d63sm342421215e9.2.2026.10.20.02.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:51:08 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>,
 u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
Date: Tue, 20 Oct 2026 11:51:05 +0200
Message-ID: <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
In-Reply-To: <20261020092137.242656-1-fiona.klute@gmx.de>
References: <20261020092137.242656-1-fiona.klute@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Dienstag, 20. Oktober 2026 11:21 Fiona Klute wrote:
> CONFIG_ENV_WRITEABLE_LIST only restricts loading stored environment,
> not runtime modification e.g. using "env set", while the Kconfig
> description implied otherwise. Describe the actual behavior, and add a
> note in the documentation.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  doc/develop/environment.rst | 7 +++++++
>  env/Kconfig                 | 5 +++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/develop/environment.rst b/doc/develop/environment.rst
> index a7ed4aab0a5..e7cf6de3586 100644
> --- a/doc/develop/environment.rst
> +++ b/doc/develop/environment.rst
> @@ -89,3 +89,10 @@ an association in the static list.
>  If CONFIG_REGEX is defined, the variable name is evaluated as a regular
>  expression. This allows multiple variables to define the same flags with=
out
>  explicitly listing them all.
> +
> +If CONFIG_ENV_WRITEABLE_LIST is defined, only environment variables
> +which explicitly set the 'w' writeable flag can be written from stored
> +environment. It restricts only environment loading, not runtime
> +modification using "env set", etc. Non-writable variables can still be
> +written to stored environment by external tools (e.g. ``fw_setenv``
> +from a running OS), but will be ignored when loading the environment.
> diff --git a/env/Kconfig b/env/Kconfig
> index c6df09a3349..70f6cca701c 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -897,8 +897,9 @@ config ENV_WRITEABLE_LIST
>  	select ENV_APPEND
>  	help
>  	  If defined, only environment variables which explicitly set the 'w'
> -	  writeable flag can be written and modified at runtime. No variables
> -	  can be otherwise created, written or imported into the environment.
> +	  writeable flag can be written from stored environment. This
> +	  restricts only environment loading, not runtime modification using
> +	  "env set", etc.

Wow, just wow.
I always assumed that the protection applies also to "env import ..." too
since the documentation explicitly said "written or imported into the envir=
onment".

Instead of fixing the documentation, are we sure that this isn't a serve (s=
ecurity)
bug which needs addressing?

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


