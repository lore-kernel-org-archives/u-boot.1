Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A9AEE4990
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 17:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E750E8393F;
	Tue, 30 Dec 2025 18:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VcN7n9/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2528D83FA4; Tue, 30 Dec 2025 18:30:19 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F7A8392C
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 18:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65b855fba0fso3914935eaf.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767115815; x=1767720615; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ywTdkRcc+hJzoyLPMBXzpVEs2pZc3gKKpEiX1UKYn1g=;
 b=VcN7n9/9F+kiBjG4Dgld0kwvp/X4Cs4xGqvbApVNwq0hPmdrWSidRx9uViRqCjk5U9
 Fm23zRuJGJp3Hqvlh0d0TrxbhPa140V4NFhntfaSKiZeqMaP7WDpeGNkZuv0mDkd8ncz
 eF64XS8n7pe7QA6YUuRFhtijQNLS6+MrkmovI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767115815; x=1767720615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywTdkRcc+hJzoyLPMBXzpVEs2pZc3gKKpEiX1UKYn1g=;
 b=cMIwcVZvzv8n2IAevVvWu1eOenAofsM8R5pGNCIyB3K3K1Qaecn6puSs0SBuh9RLSK
 3i2QQ2yYWLfiXJFnR1AXV6NVNB8bd/6vwgEGjoCVI1qIdoJzNM1BKHrK0l6GOEyF7pRI
 kNMGLebff2DJHsrPh2jHpMydGhfYTuXwrvf38JRgDaZnVuIviAGIyOo7B/FcNk26uUyE
 KO+Ysmk9Rr25PIkr8dKX+OlrXs+iananxFCRow5UJHM9v8S6brdCPatf7BHk7ZDJRHc0
 G94vqVX3wNynX3vNCUgo8WnmBTLqKe1UC9HkOiiltntzT2Fuae/gTVxOjwJwepYLolee
 JStg==
X-Gm-Message-State: AOJu0YzMXeDwDVTuCCjF6T0pBVEdj4k6rl8pn1mxg2iJxhZ4LKpu0olk
 ut90EKqm5FZmGbq803LTzkDlKyCPJmIjs3F3RtfFZ0TIeq5+MeNWAgXkgW3onZhzNACncWNGCRb
 lk613eZ8=
X-Gm-Gg: AY/fxX6JBJGOoPHvXoU7idx81wTqZgjCaOZvPO2lfxV/XF5gCCZrYf3ackTYJHejkBw
 /xvXXm37173Uo7iAdo4v/IeMTnUTHjEatXyDrI0rbxy/SwhhVWBUD/kWlg7mMzXqgXswCczeoIs
 w1Q1VNOqbLJzbx2HGyOYER2uBLG5Z6L4jzC8ymW3ISZ9nDqVM1es7u5/CQ3Vjaj5+EjI9iv77Lc
 vrQ4+D3hr4S/sOg/FNLLbWU90gG0/dGXFdgqZdsga7MR5IJRSELGPQFIg4Wf+X5mHJG/1ODMSOG
 7burX9zK15IRs5zFE7iT3M3E0GUey2pzYuNUfv8paDK1oRZYHJbgRY8wEcds7oc59vr2FPS2bnA
 a+X3n7ajhMGXxghOH8U6HJvJOELcRZL9QIwuy/KtYAjNxvAHnMt90Kkjm9VQ9dPfBB81vfF1YOV
 bsohABpDpy4LCL4R2iJhbBMMGewZ+XvP3rqSoYtfDhwudfoXorWgKboFSWtuuWbiRK+m4vBHXrV
 iWPAw6FM3TmhHK82U9wQR6hKC8gWHUQOhq98eM=
X-Google-Smtp-Source: AGHT+IGdqss0+fqJZ2KEgwa1agfhpeZTqZfFmpgJ3bJgFnAiKUvvjMenQX1DPWHP22jSDmyDyMaXiA==
X-Received: by 2002:a05:6820:330d:b0:65c:f046:bb71 with SMTP id
 006d021491bc7-65d0ea9933fmr10041063eaf.46.1767115815241; 
 Tue, 30 Dec 2025 09:30:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f3f9d15sm21487447eaf.4.2025.12.30.09.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 09:30:14 -0800 (PST)
Date: Tue, 30 Dec 2025 11:30:12 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
Message-ID: <20251230173012.GA147611@bill-the-cat>
References: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
 <20251204-topic-am33-evm-lcd-v2026-01-v3-3-ca74853bd5f0@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s+ghvP7/WfcZ4TUF"
Content-Disposition: inline
In-Reply-To: <20251204-topic-am33-evm-lcd-v2026-01-v3-3-ca74853bd5f0@baylibre.com>
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


--s+ghvP7/WfcZ4TUF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 09:31:16AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Add timing data for tfc_s9700rtwv43tr_01b from Linux to the simple-panel
> driver. To support hardcoded timing data as Linux does, add a new struct
> simple_panel_drv_data which holds a struct display_timing pointer as
> well. The hardcoded timing data is preferred over DT parsing.
>=20
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  drivers/video/simple_panel.c | 62 ++++++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 56 insertions(+), 6 deletions(-)

This leads to CI failures in test:
https://source.denx.de/u-boot/u-boot/-/jobs/1341980#L269

--=20
Tom

--s+ghvP7/WfcZ4TUF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVQMIQAKCRAr4qD1Cr/k
CuRFAP9/ZsKVuDHgb1DQ3O1sYKKlFVYQbv9vXNvjuQrtOtXTNQEAwnX0pvxuMqKs
1OqYGDc25pCHC+cnLg77ARB3N7QFeQg=
=YLTj
-----END PGP SIGNATURE-----

--s+ghvP7/WfcZ4TUF--
