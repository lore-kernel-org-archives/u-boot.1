Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06157606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AR0kAEH+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=e1XmqGWw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D088780C76;
	Thu, 22 Oct 2026 10:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAnheAH3p0s1; Thu, 22 Oct 2026 10:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3326481226
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792664308;
	b=SqtkFcqDowtHMmrCDnqU0VzgC+X9PDGTOVzWVj2YH5V5+S+oDI3eWGCkEhJcYK38OpST
	 OxH7UIZdOlm85GznNRsW8zuZXLSyoL+xAltuB453e+Z1G95E3gPQ0PSNhAsytI9mlEJCk
	 ChMSZrJHtVzgZMCbOWChgtpxAvf7E73NPQ5NWcdZz2mNT6G0iSwwsLVrcWdhsbpqYrkb9
	 Ji19CArzNTurGh4M3KDuSbcgjaiDn4MvfyK9NN2YU07oqMLEY0CESsz6a1TlGNohY+dpL
	 6MkMYjKNWl7uUelyUMLrGDo5jkQjuIP0U45jZTTBwgFbeIKbjeWPDjWzeSXmvvQNQ9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792664308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jZXbrqKmGNRQGIlV7XqRUFhtjKxY49KoHFlcruPu2qg=;
	b=hDP9oWu6QZiM/uiHpP9abM6P8UFOw1EcwG5axVtdfnaB+z7ngRlTk4lyffRoSumWe6kV
	 0AIPF2cuSXwGAO053cQ7S88T58fhrhZHX9YlZ6SUV+H+UwWvkb2RX15LhNccZs1HmWcC7
	 aHF7bgoygUwlti7+rr6jhAH+/6Pgof9FJCBdB0n4peI9Q0oW9RVHp7fcr19huKPNwjLut
	 j7L0PgRii4ZZw3WZParowuVuZIyQmahAt8bTjrsQTmB3+sYZFndtxq9O3CeyinVOTYWKS
	 lQCBHbUL8zYDT1G6ewoERAnvhc6Ki5S46pkVJNrb0LqB7+WDXZXDBh5MgKD89tdskHQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792664308;
	bh=jZXbrqKmGNRQGIlV7XqRUFhtjKxY49KoHFlcruPu2qg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AR0kAEH+7vFptTqtfOllxyX4TLMJ9/gf6dE5R1IGoCRFuQILZAv7sxYSSdVVWxUrz
	 Psfx/Lhzl4b5uUSrsXQhAgr+rPWNCxOvkZLfNr5th+GNbdfi49H7aYy5RWYHW9urvh
	 uQ5phpxvYFhwW8Cs5zcdHfWEtV+eAIZitcmDD1hK+JIuajP+CGAh2N9RiH+45TE/Ui
	 w+1avxXD0xynsYdnR5XyhP4XY5L1XPPy1V28yHosu+i3sf6lwXiD7PmectKOey1W+D
	 zMV/PsFC10N1MFbPvUo/EihqkgTxxU5igEj4qPquz5UwYtPGyWzsPuIkhJeoM1nOTN
	 is4fHe3Hv3WYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3326481226;
	Thu, 22 Oct 2026 10:18:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0105C1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F24684097F
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:18:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q5jnZ0LQMqvg for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:18:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1990F4094E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792664306;
 b=P+ok9T5KBNQM346tuY31yuAn49xJdCMu5SEpGvdCCt93Eqk8Z1vThAEynrHrNXM9tSjQ
 A12+CrNB85JzJQ8oV3769H/gYaGi/N3m7SePCylwZXRNYT6E+IhafXIZo8buleFVk64B2
 AyKwKK6eeaoHEeQ09zCBzEgg2pbOiJ+LtY3z84gdJIEY+OO/Mfka/U8cfjzKvgFf9LNrO
 McyXp1gRjsUhG/WcJrzjH+/V62XlYgqjPMBor/aYxyMtFR7rmgHNxYxbsy2RDtJofEJg+
 jO7NzxlbW8QYwVMNjcCmmAzetLAEzwI6jnmXy2yXA2kIkK1BhF/wm7Sxyf/Mr2RbLSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792664306;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
 References:In-Reply-To;
 bh=jZXbrqKmGNRQGIlV7XqRUFhtjKxY49KoHFlcruPu2qg=;
 b=qhPthYhnxXq4bp8MJiNrcQ7tG8UAZEkoDnXzevz6fQoWX/mnlLsJsaf+7fZuAp4dpAz3
 dHq1+7IWVO6ncndxk7gzcBueF5Q1VfvftehL2PGwbFsmxvbNHUYyuGDspyuq2g5zoUBmp
 TFs4H3uh7L32wbEcJg4rpvthDc/cwZUSH5r3gPVeoF8tHF1ZhaZzhKhz4B+rL0J8hHttl
 b1oh02AsEjor+r8VTgxHbq6DbNukPZQBdBhDDkEBWrtMxbL9W5nS2/vHG5mtbntgFVdzn
 +T+P/g/e//SSQSRz6f/fSnfbrdG7kQQ4QcQkt/69H3fuUkoQWf9n3MKdcR0DIA684yA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=e1XmqGWw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=e1XmqGWw
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1990F4094E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:18:25 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1610601f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792664303; x=1793269103;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jZXbrqKmGNRQGIlV7XqRUFhtjKxY49KoHFlcruPu2qg=;
 b=e1XmqGWwp3zWmLiWsJWQXHddJMZrgYyaSGIQrNOuis4tUaKNIygVBOsBKtjAhDBrvt
 Po0X5n5kpFHKcD5hHs/9zyoLutoM9HByXszD7QGAMlwJ6+3QKRh/x47rMVH3I5JaNo3s
 uImAnZDwIVrRoOi8/A8GuKjW2WNvGD2azrj+4uxDuykycfJ6tzhu9n8xIX7jFwUbZxXU
 7wDFDHlYQ7/1hvq3ZZ33vpQUaGHuJx4wvwMJYMMPjQ6DmRYg7lc1zZBrdkOUPw2WeXqS
 sxRnxB2TK1MuTODiC2FTf8Mldvy/kKAcjLb+N2Yd61b96o6vpOk77mCI/QU3hOqgoD7A
 uQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664303; x=1793269103;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jZXbrqKmGNRQGIlV7XqRUFhtjKxY49KoHFlcruPu2qg=;
 b=1OXMcwTN/ThB5qWKy8w7kBQ/AaulNwW34Ep7SSK7+BNNl1ATJrJCAZakIie9dIq2Op
 qmKavli312DAJHda3xq6fBj20JBvrVgZ6s8M12A2kDDp94PZTWJxptL6KHfJERUvOa2N
 NVWA77MS6wJ0L7dCdbsFUp5pIONh+0sxfi8/K08hP8Im8Xn4Oeq+3K84W3t2rbjonbBV
 BBt48mcrh9vo3feDo+4xPk/o+bf6fM9rAk139IHW/GiDI1gUyeWwujE2INYftScfQeuE
 2yS/GTUTKB9CrKUP+ZpI6W7rbMuW8g2aKTdeI8tlCdoGegb+YEcVxUUvmjaxYh+6d+79
 avrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkuZ9gRx9FPpePUxHQ8DDtRAT14uTl+ipizD6Tlkb3V/mshQMO4NqA7EzQCC8z1MuXvT09vBM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjRQ23ifAZrDdFNnVVwlwqqu+nKK0Dwraq9V2pYoi/sWzIYY65
 goldM+zma3dD3fAhh+sqDGuocg+x/LqCTqjv9jYydj5cOINmlduZKRNNHgTKz710z2g=
X-Gm-Gg: AYBFou3zPqN8U8hQpU56bp+ry8iw1L6fZUwvuxcuWMGp1r8sEldJEn6n7y54vYI+k4r
 K6G9LtdnUfT+1PNHql9cawxV1IIJ9Fnz23oZK7YmnqATYSJzStzNUAAQTvWSPQTumRUTNNVT8NT
 UuhK78TYvK6qXpX8JVSvKVFpaA+dKw5+la/4jiXhE8TWdZ6TuwUhUfKAYOOeCv+9/4F/fxGXS0q
 R81bVlWAVwbuJev7KbXdPkgio55avU/sM8XOCqEGK1YXjjNWAf0s/5Na90EV1xFbp+JujAohs5T
 xFyV4/Z65CG/izekA7VCFGXBcX/iZYsDiLd5qJiughxV/pM93gb1LWIoGF4J/FDDnlZjspL9376
 bG9GK64UhwOc4gTFnhdPb91MBcXoHNTsSpqmh7oqkmvNuV8WvdrbR3bqrcRk+FiodMbp1TAmsvL
 kHy3oD1sgFzn9xhF8ZMU3tXWRk/6TTAuPwtmDYihTTnRRb4AxLjdQIttPBy6rBzEfPa4F4aMKWK
 VpVrlGa6ffL4NgoOzSa30pxbg4vWHu5ZyCMVa3TRPRn6Dnf1NWs/exzBg==
X-Received: by 2002:adf:e00f:0:20b0:488:8232:d16e with SMTP id
 ffacd0b85a97d-48e264a9823mr6518667f8f.45.1792664303386; 
 Thu, 22 Oct 2026 03:18:23 -0700 (PDT)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2583523asm11463766f8f.37.2026.10.22.03.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:18:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=90e9f33a6676d7a1fd53bba581346c3955c6ca1bd6017e313c31cf300796;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 22 Oct 2026 12:18:16 +0200
Message-Id: <DMBAGGRGOEEF.1XIHBA6ILOH5J@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Daniel Schultz" <d.schultz@phytec.de>,
 "Anshul Dalal" <anshuld@ti.com>, "Aristo Chen" <aristo.chen@canonical.com>,
 <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH 3/3] WIP: arm: mach-k3: j722s: Wait for TIFS initialization
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Kumar, Udit"
 <u-kumar1@ti.com>, "Richard GENOUD" <richard.genoud@bootlin.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <51c23f5b-9ca2-4ebe-8f3e-72d22e404617@ti.com>
 <20261022101558.2474326-1-msp@baylibre.com>
 <20261022101558.2474326-3-msp@baylibre.com>
In-Reply-To: <20261022101558.2474326-3-msp@baylibre.com>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--90e9f33a6676d7a1fd53bba581346c3955c6ca1bd6017e313c31cf300796
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Oct 22, 2026 at 12:15 PM CEST, Markus Schneider-Pargmann wrote:
...
> +/*
> + * Called by spl_early_init() before anything is probed.
> + */
> +static int k3_spl_dm_post_init_f(void)
> +{
> +	k3_sysfw_wait_ready();
> +	ctrl_mmr_unlock();
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);

I am wondering if this would work for your situation where the PMIC is
probed immediately?

Best
Markus

--90e9f33a6676d7a1fd53bba581346c3955c6ca1bd6017e313c31cf300796
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCatni6BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM6
UQEAtxxDf2Lx+ZYOC/cpP8enhAJm9LTZwBS11SAy/kn0ZskA/iH+lfcYDvDeqR2n
onuZJD2xVjUjHCjtqkShzQVyInwK
=9Hc6
-----END PGP SIGNATURE-----

--90e9f33a6676d7a1fd53bba581346c3955c6ca1bd6017e313c31cf300796--
