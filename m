Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BEF606A337
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1AbyOD/S;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=LBA/clOp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97C7140878;
	Tue, 10 Nov 2026 17:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qnc2NDU0u1Re; Tue, 10 Nov 2026 17:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D53CC4082F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794331203;
	b=fDERfbKswqIx7j2mJh9FEAoZchiEdpWqkCm8mJ7llz+lmYwPsbMKABrdFNKH9MIV7+fC
	 V9BFTYknhU25Wf7vhZKunsH0xwf0ka1Oo8GxS6cZGq0IrEeUl60zmDqmvZ0JKTZjVfBvf
	 nnHKzDSF1CXsrWwIohqfhrZ6tZyTi10QiEjlxUk40Wt0E31295/W+wsKmPSzBizs1uFoS
	 F7YA3PPvThDxE8GSO6ytsPVIz8AOcrCZOxlB4qzxmgOfXsIi/lOZdnhOvfLWZ1aYwN15V
	 NwDO+bRlw5c32qyMO6vwxUsaiLuOUkAwbuxZ89DUP/BTCSXHUmdqtZSFe/XaWu5hxbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794331203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ESEP9mUI0MLW9HN/dmg9AIwpjs4jj06uXQktYyelHD4=;
	b=hr5xUqF+XKY4JONuI2ifxcX6BvGslyxV6f63FyDXZoaKlJ9ZY4gqNp7uzr8sS/SpeV2l
	 QdqduWPMeOCaTg57mQHNkgKfSIDZg0T7+3D7ze1Jq+xVgyoxt1BQnU9etnIzqg1ywsgIR
	 70Ac0jHMeEbh3YXGPNtZK12XzMYLhIzQEL8W4PzQE6ZRpgBW2/EXusSZRkAbR8DAUOQ/4
	 uBfjXFJWLJODlFIvH8c233puDbbJom77ERFKCtmTnKkoLsNd5E7nqusFp9bj0JOJl/QZT
	 06wrwfZ9LTjFCeBjec8OTgkjc1cMQ+GVpRQtNQaICMjEdBSB4daX7tj0qiJhDl4Mj4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794331203;
	bh=ESEP9mUI0MLW9HN/dmg9AIwpjs4jj06uXQktYyelHD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1AbyOD/S/TCr65Lt1qSi/pqY815Xwq8egmJg1C51VG9cMGv2OXAR5kwnLSpYBJ8v5
	 atO0M3OFOWyJJxXAwnKbtUB7XS0uJsc6XNsgq5VHb2s/tzugskoyygLfQmGT7to+Mr
	 BZx02N6AQqw+Kgv6q5sLBAqyA0XpLVzNn1CRgN4aptx6m52IWQCwyqqCNeNwXFq/Mf
	 WzX76Mh5cOc81zjYLUuJoY2LOvMDafN/CdYNPt+W5QysxtnY+Uax1HqFDS+Vt07MAk
	 rC79JqJNcOON2QWHknCPXq50CfdojwjsuStf98tBu6GaFV6Eyopi3c9EAeLZ1QDKBm
	 PIOXbGnFWmqnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D53CC4082F;
	Tue, 10 Nov 2026 17:20:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 603421A6
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4507940060
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 18O7i7YKB5wG for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 17:20:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7061640048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LBA/clOp
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7061640048
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:19:59 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-854b6e2e41fso1193109a34.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794331199; x=1794935999;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ESEP9mUI0MLW9HN/dmg9AIwpjs4jj06uXQktYyelHD4=;
 b=LBA/clOpkJLet6bSsmgheM5DNUu7EobJU5DJ3eOuAzEuqLCIUcRRDr5M4hxMj104mm
 7nt0hzGZXwtzM6f9GiLG7yA9qUGl4MOiNIGW2F28a8PIq38A1gPYD82u2CnI/fxV6Fo9
 PWAfQPz/xQwhqkGF1bL3y+6XX9JzsBhMyeDpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794331199; x=1794935999;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ESEP9mUI0MLW9HN/dmg9AIwpjs4jj06uXQktYyelHD4=;
 b=hGdX8r+0zH2KwIZFf+MWQjv2YHBsNIT+0HR/MieegSqwjlDpxSMJtfoN1S3kaxWbm4
 6kg2yWPYoKC4/PzyBQhETkdkGtlVh5uum7e94VTdCgqiug+82GzaotRz+C7N4i+4wwZD
 dTDqWDRNYPu+w0m3Jvujo330tA1wcKb+Rq9CYzc12SBndb9Cszv5avzEPr5Bt2jzGFvc
 px9gkn7/pF+vQYu4R9hvEIC2YdhQi5mZzUTCkV3gx4KNWPqWVIwTNbF+EJkBLfsnEjI2
 2U55TYNZJYANj3TlZBngjUxAqc1pL8xvPQpMB02J+GN8zc88kn5mi5Ih9Eu5qEb5fD0J
 4x+w==
X-Gm-Message-State: APuU4Z8cqXkbxJydFKLMPtTqR4peJ6wHzi8p3kBjJrvKFYQ0NKtDP6nb
 FN0b8NGiW4pp01ZcWmuyQ+7MeZLKX3Dg+bguMcK4CQvr2s1tAATSD0cYObX/tLr+OCY=
X-Gm-Gg: AYBFou3zD7kRlyjpkQSGYTeSNrgO3yqrB40BVhDYzL6B7yMEqcn57RRxeb6+FC0jKVs
 vPOSma1RnAMw6ut1/aHLXtZKVnrwgeVeJ8k4n6HlV9GqNfhL64vLPqmLTeBb6YW9gGRTnrSamai
 USG1mSHfSNWHJ19QQ/Rh/09FiPzQCg52M5GcFJZ31+M/614y6KsUeXFGor4LzxBQWmn3lRxx6Gw
 V0SlA1HrkN9VvUcRCo0b6/KTI2a+YIs4F4xnofyOyuPeImLkTwaPZsBJVjqADyyp/ypmgjnbfRf
 p18y3aMlljQtR+/iqeYtzNa0WqKlO5Ejj8ZnDBgk7bgnPL+2jdYR46QG7lp6PnjWp+rvNxxF4UE
 nydMXj30dzDCyn8UO8SbW4ix8ROBTQahkSNMocn7PXCsjjXpJjNjvZKqoTKIJswAf7MQ0JXI0Mr
 CauoTecCX+1JrYmFCxmY4vcOs6H+lrz8rrj3WZQbmhshD1mCJNqBrKc1lDVMcNGImwbOvNDQmJN
 Fgh1FnChvj+6b8MK5LMlBNYZn7VbY/6eseFRCs/equPeG6r5voxO8F+de7G3phXK2E3PyMRvwLZ
 yQ5WNQny6TQQxmBYE324HNdT0UhQ/jBDdTzvS3hcrx9Ef/HMcw7xaqWf8RXidtLeKLHi6ZzoKjM
 Ny+rnPkNgnJO7Edt+22jsw/jDQGfS2ekoPlVCcsjXjEKfQ8CkbPyM4Zsa2Pw3o+taa+CPEyapGs
 02jejCiQI9rWThLEeJhdvcwldMKDW+cI8=
X-Received: by 2002:a05:6808:1991:b0:4cb:f21b:6f91 with SMTP id
 5614622812f47-5683cdec02amr2655303b6e.36.1794331198884; 
 Tue, 10 Nov 2026 09:19:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905f39c60sm2565190b6e.14.2026.11.10.09.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:19:58 -0800 (PST)
Date: Tue, 10 Nov 2026 11:19:56 -0600
From: Tom Rini <trini@konsulko.com>
To: aiyengar1990@gmail.com
Cc: u-boot@lists.u-boot-project.org, Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 0/2] sunxi: H6/H616: SPL PMIC access over RSB, use it on
 the OrangePi Zero2
Message-ID: <20261110171956.GE3741582@bill-the-cat>
References: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LRsnaP/FLxpOPN9x"
Content-Disposition: inline
In-Reply-To: <20261110-h616-rsb-spl-v1-0-bf91cc26507e@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--LRsnaP/FLxpOPN9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 06:19:35AM +0000, Arun Iyengar via B4 Relay wrote:

> On H6/H616 boards the AXP305/AXP805/AXP806 PMIC can be wired to R_RSB,
> as on the OrangePi Zero2. TF-A then switches the PMIC to RSB mode (Linux
> uses RSB too), and it stays there until it loses power. The SPL can only
> reach it over R_I2C on these SoCs, so after every warm reboot axp_init()
> fails with "Failed to set core voltage! Can't set CPU frequency" and the
> CPU stays at 408 MHz until Linux cpufreq takes over.
>=20
> Patch 1 adds the H6 generation to the SPL part of the sun8i RSB driver
> and uses the RSB address of the AXP305/805/806. Nothing changes for
> boards that do not select CONFIG_SYS_I2C_SUN8I_RSB.
> Patch 2 switches the OrangePi Zero2 SPL to RSB.
>=20
> Tested on an OrangePi Zero2 (H616, AXP305): cold boot and warm reboots
> come up without the core voltage error, TF-A and Linux still find the
> PMIC on RSB. A v2027.01-rc2 build with these patches (together with my
> sunxi DRAM and USB hub series) also came up from a warm reboot without
> the error and with 1 GiB. Build-tested for orangepi_zero2,
> orangepi_zero3, x96_mate, orangepi_3, pine_h64 and Cubieboard4 (sun9i,
> the other SPL RSB user) with no new warnings.
>=20
> These patches were developed with Claude (Anthropic) as a
> coding assistant: it investigated the problems, wrote the code and the
> commit messages. I reviewed them, and they were tested on an Orange Pi
> Zero2 (H616) as described above.

Thank you for being up-front about your LLM usage. The project policy
is currently "please don't", and this specific type of usage is on the
"don't" side of the spectrum than not. I'll leave it to the sunxi
custodian if he wants to review these or not.

--=20
Tom

--LRsnaP/FLxpOPN9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavNSOAAKCRAr4qD1Cr/k
Cl1/AP0XotQJ/RM7GXFfKut+FCF/m3gZB9LSXAu2mogOYXfhjgEA5e0x5S2g/QMP
bly19N/piwQCWUiaSF0gtkXupoGlUwQ=
=ctai
-----END PGP SIGNATURE-----

--LRsnaP/FLxpOPN9x--
