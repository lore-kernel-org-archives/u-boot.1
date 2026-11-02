Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032C5606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c8M1sRMy;
	dkim=temperror header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KNcNCZJZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBE1D60792;
	Mon,  2 Nov 2026 09:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tq2UUiI02XXW; Mon,  2 Nov 2026 09:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E66626075A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793611620;
	b=a4AIq55/wtq/CRAsnwbXDY3k/xN9Ki45VM4dkyRmx3bJ0ZBWgDmY3MEFRpxRI8cmmooq
	 WgMEu3+cPmByUPiF3IUbin8Zd5Xt96Yc60Xwr6/MEBnpjk1xTX1PtG8ixqw+Uy9OKLORx
	 8Raig+UKm+zzqR4ZZGPQwaok1NHCyiuKwtCLzihg6ecTy+3Bk1wCYEALLdiCT1cDcSKXT
	 L8Op5m34D+FIvTYefz/5tSqdwjQvmUq4hHlQlyPU6XPxU7VldYx5o2d0sEwMuHZRPsBpx
	 f8qErwEiEYrtNh9+6HvwOFLlPd8BKqupB/ii/v+ed7YqC0aU7RoraeRG204ML/+EyqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Mime-Version:Content-Type:Date:Message-Id:Subject:
	 From:To:Cc:X-Mailer:References:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rf1rA1NTDoVXd8rbE1XgoflRb2yumTWKYTT7vnEqQ20=;
	b=lVGHbfbliaHfHLj1ZQ1UZ5ZGo0I45SGeygKkERJkigXsVeiL7g70NUpeyPYMPIIiMMrq
	 5XCI0n/Pc2BlaX7CVskrxv4nfpTbVy5f3BHoFb68mlZICXJAsmlllyOZdnUWgvkWH4R/n
	 U5KFq4KDnwgHsaX4HoliIUwOW7cZ07ntx9+X8//bsnsTS0s298Qnh+POO7Ud1HOONclRD
	 y108yW9s5OyIaNbQ4gIop+covwXIbveuCvmAMbPLiSsoix9KHXSIfUGqw43JEKwLHygTC
	 5S/7jL7jQCUnhVchF9AfgEP8aryXV62xY8XkZPusdhpYHYaxZ3N4xAESSc2xhn1SWJg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793611620;
	bh=Rf1rA1NTDoVXd8rbE1XgoflRb2yumTWKYTT7vnEqQ20=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c8M1sRMypUApDtlNJpepbf3+oXLHsKYh8Ew2d/tCq+oxAJ1Py86Yo0vsA4zuU59eS
	 FR74JW+fy7zPWpRCLqy1+AgqoMHiS4E0MOI/wJY0+IXIh86pbd0RQ0Okm8EPN+mnNX
	 GL/DxdGbwXIM9De2I4A+RazkbBXggvQLy8u0s7IYJyQV8XZ0IstLZnsQLGTj+Juzx1
	 yQJzfbdZjFjywnlCfSnATC6MK3Nd7M0Ffeb+DrdoJo5WGwry0D660OCt3C6zfcUCyO
	 WZ4mnfr+FVzEmzySNO1rX3bHcUh3h1djbvC0I/JvMaaWzPTYWYk6hd8kq1aG42X1L8
	 FgrzutQdc7khA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E66626075A;
	Mon,  2 Nov 2026 09:26:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91D8B4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:26:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 781AE401B9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uPeLPf8kFiE for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:26:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DE6B7400A8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793611617;
 b=m6CbcnwQIodWYGsVT8cA8cPlW313Fvwnj7mRcHulkcUM/95ZAfI+m+xC0ddUl+4Ra2ZI
 wSbYYs8plWogHYy0NM0YVoGz9HF+ODSvs/s5Na9ECou+PR9hekzHyXtIGVqOoht7KcCdd
 NVmNneCGuX51XgL4zqBEK0DALy59ct8SZdfhBYx2TBL5iieTPLQTKu6S3Bzg0hZvbybhV
 BZL1xFsbRQfkr6gt1e3TBFiIYPeiD/iWpxCXTmcxJlrjXIBCYhJtUa6tu9mM81JhjDPSN
 2HQmoZycrQyT8LoNGXA8p2juUNisTzoB04BIwcGsYU9n+OinA1AloD6WdWWkq/vRU5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793611617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
 In-Reply-To;
 bh=Rf1rA1NTDoVXd8rbE1XgoflRb2yumTWKYTT7vnEqQ20=;
 b=lZBO781kcfO694eLVa9nS9mScfBQBj0Ol4LdQ3eO9hiuYP82iESQDvV8uFzN3yS9tyYU
 KJxIUZ4MhO5j/wsnQCrE1kF63Qo1yWaBJvQS/bdOtAquOB53dnHrc4be3zRxyUbQP26Ss
 yKq4EpwWy2EpXZ2FGZaSOVs9W6yEWChNBuUIfb1lfm54DByioroCQYFxl7FasirvbG2sX
 t5u3iDopI9mjRv3dNW9M8u0OBb3Dh1RQGLZFVJ6KjmdybBYwZ4S0ixmShKsLQCxg5Cfbl
 l+dkPHGvRT8EBU3FnNBhqR7Ih5dD8ho0kaT40pT2hivtl9cPx7BVb0FAbhdRVEtp0Ig==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KNcNCZJZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=KNcNCZJZ
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE6B7400A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:26:55 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so27898705e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793611613; x=1794216413;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rf1rA1NTDoVXd8rbE1XgoflRb2yumTWKYTT7vnEqQ20=;
 b=KNcNCZJZjrpbKQ3uD0uGR84sMWzkTsctU0/wSz9XzYpDdFy6llJ/5EYohmmeZQzQeg
 xtVKRdB8wzqPLL7ZFjW9PxKP8fQI9S5PWh2aXlpQ2eTlFon8sTpL4jssZyuOuePj3+99
 YTzaop8DgqQnQ2FChq9/zHAzTeuBnKpoZ6gKp74IpYLPm2kD5aFXNo4P8vyX6WeUJDFO
 mLuhM26hcL65URYdriev7zy4I9b9azjUpbjSoJE1hufunIX9qM+4ZGAoE2hS5oXzs9uf
 fwjUcjOBXRq1X6SJ820hhaMe3LpaFarN1tNaIqnkz3PmB6yAjWaWnzU4Bh9aumYUuYqW
 PMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611613; x=1794216413;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rf1rA1NTDoVXd8rbE1XgoflRb2yumTWKYTT7vnEqQ20=;
 b=KdFBxA+ZrXtcvHrK5ojMmlHeDikHMlcNNx+9C3Yb96hKSAz3gzgtM6ucrlqlVIiIkg
 gAo/BvvPSLBHQ7JXrbN/YMKBjN67Hj2iyv5Fg0IE29xoAEJUUfxo1NBMc1DuPvqqfr/b
 XWqkXSi8KnMjlgtlLh2jGzBxBzpLtGcZHxU/r4j3JvGLxqX22JMBYPfcmxqe+4mqVSf8
 OHRfzeuJ0duVL6ikLEamPIWqk5jHyp5C5Pi5KwEFSbkDOGojIUnpgVnxTDvLDiV9x7u/
 nSjt6EUJ+b3t4A9H9Pedi6UdzXVJilKOzdbI7yQVGMiW2G5t2Q5vDcwGLdyNLGolehXS
 TSCw==
X-Gm-Message-State: AFq9FYJ4O2uH+iCEW5/VWKd6+Bp2BxzsIY2ZJ+AeQ8amu+O/mX0nsiGU
 teMdNjdtSRM1mI+PfE66xxuPU+Fl/THiZ+UxCJdrbZ1YEOye845wKTRmYYrZslJRPdg=
X-Gm-Gg: AYBFou0ob0xxuGEdzfL9JyMWfA7CMyBkmXfaSb80Eiz8dswGqdQTVI/036v9ol78k4E
 iqcm+Ssoy7uvAWWvHMCBKFwRIE5ZWeRn47a7QBA4kKtzhilTJGnzv1OBNyBoaa5qrIcfDGqXAX2
 Uvx2HNwwn1N35DyE0ePo3mSAdSXrNbVsYuEcPKJedMIhxQhOVPKcCBg6OpnWMebayazGbsxLSS4
 794nIiBOXch/aN/G+LxHhMYFLY1v2vn0k1e4sJpIWrraywm7GpZr0fSpvKaetsl5GSTIhpKUOa1
 Dlp+cOuqqLGN1VsQ7GEFJlha9oFAdFTKPis8c2rQwaErt5kDkr4k+NocVlcKm7JBHbDRMJu5eIb
 wT0gejMOzKcnmrRj0JIS7ubiG3tXNvKVcMITqHibOUtAW+1MGOq32BOM8nTnkIR0POzzhDGFf2I
 achSva23456gaeL2sODvaZBC4xkiHeGqJ5OLCzkmjOsT+skEAJmNEekhu7CxEHKuqHBq7FH17wk
 /URa3D0A3PNiO8NrBKNqkvslzYfwPxB2WbUmEJymdP4TzBiSRfx96ANef/UzwJ3fbv+pp6nBN+D
 T4YXQVuk9l1hpvQ7WEpJ2xIN
X-Received: by 2002:a05:600c:468c:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ac17d168bcmr218386565e9.9.1793611613259; 
 Mon, 02 Nov 2026 01:26:53 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm356103375e9.1.2026.11.02.01.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:26:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2e6a72bee668f036a3b95e613efac4def33dd01447d2018cb3f2445ba767;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 02 Nov 2026 10:26:44 +0100
Message-Id: <DMKM8ZUYIQG2.J82LOEGKW71T@baylibre.com>
Subject: Re: [PATCH v3 2/6] dm: core: Add SPL_DM_EVENT
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Simon Glass" <sjg@chromium.org>, <msp@baylibre.com>
Cc: <u-boot@lists.u-boot-project.org>, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Daniel Schultz"
 <d.schultz@phytec.de>, "Udit Kumar" <u-kumar1@ti.com>, "Richard Genoud"
 <richard.genoud@bootlin.com>, "Anshul Dalal" <anshuld@ti.com>, "Aristo
 Chen" <aristo.chen@canonical.com>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Paresh Bhagat" <p-bhagat@ti.com>, "Julien
 Panis" <jpanis@baylibre.com>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
 <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-2-2a67384ed0ef@baylibre.com>
 <CAFLszTi54DouCiL-JPo_1NztwBbRNve-dyQjo-s1Od-kQCG71Q@mail.gmail.com>
In-Reply-To: <CAFLszTi54DouCiL-JPo_1NztwBbRNve-dyQjo-s1Od-kQCG71Q@mail.gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--2e6a72bee668f036a3b95e613efac4def33dd01447d2018cb3f2445ba767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Simon,

On Sat Oct 31, 2026 at 7:44 PM CET, Simon Glass wrote:
> Hi Markus,
>
> On 2026-10-30T12:27:40+11:00, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
>> dm: core: Add SPL_DM_EVENT
>>
>> Add an option to allow DM_EVENT in SPL.
>
> Please can you say why this is needed, i.e. that the K3 SoCs want a
> spy on EVT_DM_POST_INIT_F in SPL, so they can unlock CTRL_MMR after
> TIFS is ready but before any device is probed. It is also worth a
> sentence that CONFIG_IS_ENABLED(DM_EVENT) is currently always false in
> SPL, so with this option dm_init_and_scan() and device_notify() start
> sending events there too.
>
>> diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
>> @@ -117,6 +117,16 @@ config DM_EVENT
>> +config SPL_DM_EVENT
>> +	bool
>> +	depends on SPL_DM
>> +	select SPL_EVENT
>
> SPL_EVENT is inside 'if EVENT' in common/Kconfig, so it depends on
> EVENT. That is fine on K3, since ARCH_K3 selects both, but another
> board selecting SPL_DM_EVENT without EVENT would get an
> unmet-dependency warning. DM_EVENT selects EVENT, so I suggest adding
> 'select EVENT' here too.

Thanks for your review, good points, I will fix both.

Best
Markus

--2e6a72bee668f036a3b95e613efac4def33dd01447d2018cb3f2445ba767
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCauhXVBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNr
6wEAyTJa0QreLCmwP4zWi0Sk9ETipsBO7ve1Awm7kvRHD3UA/1TUET7h8GLSpWkE
j8pJVZdu5+nujEQ9kyxAwTw06Z0L
=si5Z
-----END PGP SIGNATURE-----

--2e6a72bee668f036a3b95e613efac4def33dd01447d2018cb3f2445ba767--
