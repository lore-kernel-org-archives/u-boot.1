Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB47D12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7097184020;
	Wed,  3 Dec 2025 15:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zs/n5sjo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A45B83FA6; Wed,  3 Dec 2025 14:47:24 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419E580FA1
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 14:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640aaa89697so9632429a12.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 05:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764769642; x=1765374442;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9bdsFx56O3zDwClCchQVNVKVQ7sWUSRh+C9Yb7Ul2ds=;
 b=Zs/n5sjoO39THRMzW+q2f8pjmtOM1NfxSK79sNxxxoYNhQtI4cUGBowsWPYmtlizey
 4qJKB+cDlVNX3Sl5fwKCh8IZr5nAZjbJ5q0zuPKt0NTwjcsfNrPoUYp5FOBwrcwficIg
 7eJZwEk/XOSBsEXuzoAJ9I7U0XPElsuHGtSSypTTlgJSPjOjFWWTuPUKUrJKn/1Jv9Pa
 UWLiDtGv4qUvGeYmvaaR/kULHVyemBrMubPQxXl+L32HLkEvH6Xg84jKHjsNyg596txg
 7OvaaLdJ1i1r66oJvlSJFwFX7OyHYKPAlX5MCKpg5TbQIS0N6dHkb8NF41vqz1ROQicu
 MAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764769642; x=1765374442;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bdsFx56O3zDwClCchQVNVKVQ7sWUSRh+C9Yb7Ul2ds=;
 b=P9GsNY6JTpRsZ+KnQHO/2I8Z1eQ7+VuzJySkOSxaY2FwBY1lFDX5R/BENmnHU5/Uf/
 w9vkc+kuWSOYf4zsygO+N5329Eypl/Vs9NhIbYOCBknkmCU6baKmDEs/x/0WWNB2PxeP
 cw4BoATriQAnGY4w/78Fy0BnBtioYiSts60zsI/VRRdjzInR2GnWlGDygm8WU6q3iYPc
 0XJgbBQwzErPGtAzl9MRbbbhVKeLm2II/ahK/qxE140tikoLFTQQ1EUOuhPk6TS6rmCP
 H9W4efJv8OXH+K7ohnEOZeF4fV4GpiURCfkcovIvTZZcoHcZamqg+XVNjpYrFAhN42W6
 wGcA==
X-Gm-Message-State: AOJu0YyBDz0qdeCZh6XYvhKjqHvOmwIltA5sXCjDOnQ7s7GCqX3kBkhN
 86ZoaTVTD6aMy2ECJH8e/oc93zsvMjzzaDHe5pAg1orB+tPIXJEmVfOR8beEh2Ycs0fZqPZBI1A
 ncAnt
X-Gm-Gg: ASbGnctv5xtipHAJQARxQwamK6Hnjpx6CUwY1NElfW2LOV1Qi0sIYqTiEF2kKwqz14S
 8FuEoKjlKhnNMOeLjse9WHuWG/myDeNOGFT9+Zt9OKI5TCG1Bu/47OQYRFoL33zY0MTNaTtctIW
 VdH0oBZbOv8DnKVhGtS2/QIt8UoCPWjcwfy9BwWXsNMOVUJXVHkYP89uph4xK7IRwqkeSGUmEod
 WlYircGUWMLYZyqyoGE0IIWIl8uVbQsD0a3mbdLaJGVPVhuLNkmKINgXG7LNRPVW8m/7dlc8w1N
 XnwJDX2MsiHEp4QZLq/IQ55XqF/L1c1KE14jMDOA4DLavrgEttwuJG7l1MKKHizBxDWFAguLLjq
 zQdd2lfLoXB6IGpzO/aRJsHkHJ5u38CEQyjH+e37HDX4JFFmwdHWhb1wBHnIXUkB84/RavTyrtP
 hVpaAw
X-Google-Smtp-Source: AGHT+IHFgQ8Oa0tvo4TeOjFS33g3+3Q5fYxFmM+jVmnVSXR5oynAdbEBo+Amxt9MBr46LXlbARBkCg==
X-Received: by 2002:a05:6402:46c6:b0:647:a570:b756 with SMTP id
 4fb4d7f45d1cf-647a570ba25mr15031a12.17.1764769641637; 
 Wed, 03 Dec 2025 05:47:21 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751061e60sm18499335a12.32.2025.12.03.05.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 05:47:20 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bac6d732d306274546c1669a8b238dac9a74cb0038928f7924996dd3d2d8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 03 Dec 2025 14:47:12 +0100
Message-Id: <DEOMMH1QEC9K.1T38GG06NWSM0@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Anatolij Gustschin" <ag.dev.uboot@gmail.com>,
 "Tom Rini" <trini@konsulko.com>, "Yannick Fertre"
 <yannick.fertre@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Raphael Gallais-Pou"
 <raphael.gallais-pou@foss.st.com>, "Sukrut Bellary" <sbellary@baylibre.com>
Subject: Re: [PATCH v2 1/4] panel: Add missing comment for the timing argument
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Fabio Estevam" <festevam@gmail.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
 <20251203-topic-am33-evm-lcd-v2026-01-v2-1-262cf4f34eb5@baylibre.com>
 <CAOMZO5Bnr369g+9T_a1EOHPfAG80WATHgkJ9VVWdHVSMCRKEqw@mail.gmail.com>
In-Reply-To: <CAOMZO5Bnr369g+9T_a1EOHPfAG80WATHgkJ9VVWdHVSMCRKEqw@mail.gmail.com>
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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

--bac6d732d306274546c1669a8b238dac9a74cb0038928f7924996dd3d2d8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Dec 3, 2025 at 2:38 PM CET, Fabio Estevam wrote:
> On Wed, Dec 3, 2025 at 7:19=E2=80=AFAM Markus Schneider-Pargmann (TI.com)
> <msp@baylibre.com> wrote:
>>
>> For completeness add it.
>>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  include/panel.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/panel.h b/include/panel.h
>> index ab417bc91ed1d23aadc64e861bb721418199fb0f..6c5e2c000fc79f271876daa1=
79455f16da5bc3af 100644
>> --- a/include/panel.h
>> +++ b/include/panel.h
>> @@ -29,7 +29,7 @@ struct panel_ops {
>>          * get_timings() - Get display timings from panel.
>>          *
>>          * @dev:        Panel device containing the display timings
>> -        * @tim:        Place to put timings
>> +        * @timining:   Pointer to the timing for storing
>
> There is a typo here: @timing

I made it worse than before and didn't even notice. Thanks! Also thanks
for the other reviews.

Best
Markus

--bac6d732d306274546c1669a8b238dac9a74cb0038928f7924996dd3d2d8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaTA/YRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOc
XgEA08GXno53efFzx+wWO9s2bFTAf3pJNx/UpejfKk2CM04A/RKPeVfAz5LF1hP5
zdk24eaCtRb/4Ogot8S80PJeDJ4L
=gAIc
-----END PGP SIGNATURE-----

--bac6d732d306274546c1669a8b238dac9a74cb0038928f7924996dd3d2d8--
