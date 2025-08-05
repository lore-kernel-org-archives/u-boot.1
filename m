Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E470C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7B38338B;
	Tue,  5 Aug 2025 16:21:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M02pXezX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C77831E0; Tue,  5 Aug 2025 16:21:47 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263F580C59
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-615c8ca53efso9189411a12.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754403704; x=1755008504; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nElW5fwy/VIDgc32f1Dxm2963W1LaayIVRDInNEQlfQ=;
 b=M02pXezX++eH950eAKgjmh+gTzbQrvVSNh6xFZb+por5FlN6IsEAL4sIVweQFYDcGU
 /z6JH1i37aHIrd8jLfDPOPQPKlafXW61PZzPm7VZPNygzQszPsiTLmof4w1D23cgl8Xi
 xdYRRZMpmY5T7D1EW525LlqB0GuDr8Zgx2+R3C+Y8J0hF03N6vCVxX+yXX/kZlqNHDK/
 TMAxe48D2jE4kgfzGsWu90k6TRtBeJs4qRLLn6KM12x2tGOVv0bs5QK4sUzgIkLuZJW2
 gGuMi4elMTP4TzYcM3wUE1gN75x8MkH88U8wYzjrc2yoLHOmeGWeXSPL+VGRHUMawHIB
 ISlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403704; x=1755008504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nElW5fwy/VIDgc32f1Dxm2963W1LaayIVRDInNEQlfQ=;
 b=mUW/lglpoL8VFgDvM19kSmASxK6m2MjShhO1uVtngyiW8GYqifpAq+D6lg7KZBZpyo
 Qw8GnhyWEU5LkfQLJjCUW9jZIoHnTFtKKKoqaxusUdEFPE/uaXxZgu36rXVslpvItGI2
 XZo8WirYStkut8i10nnO+fvxAHmrX3QR38UueUzLqJgPGMt+mG9EywesliuByfCFKSOl
 Lqa/5koXP+GY+3WByEWiNJ3cQOg4KfMzwfJWCu5t8KvQc5sx+vAXcz5WNiaaM3NQPxXQ
 j0tuLbyCHQRVRmylru4ZegvMS+n/7AcE06FF8hNX0w8CiR5LUgtzhWWeH3+xFETm14d+
 asMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAncwRhmF4XBi0xLFOZ7KVgzkXvx4/piFm4Y3IfLjotUfqQpT2yjWjgVifvSm1srTh3lMq2ZI=@lists.denx.de
X-Gm-Message-State: AOJu0YxBRzwstsS6VaGKAxOevpFHpppo2FGbS7cHc+RLUXte62Ad9PGm
 EY19TgqAJmaBFK5xMiz4nSMBD/scnA80ohiNoJNqhm3HC2cZJNsy1an8/pRpNX2QVvdFPx7JSRm
 iovYjBcRfEnt3BFGqkqbwPQn0UdPAmA/Q9A==
X-Gm-Gg: ASbGncuWu6z0blHDTAh9T471ziI4eaCDiP8pkRszXf1P7r7wp2x7RfaF+x7umW7t7I5
 Y589CZcQzjEZQH2zct9Bypq59ERegurAzEYQsUsqv9FUG3Tmro6ojYvmLFU9kUhclMjxyYbaZbQ
 rdEmuiPpePQMukiH80Dc/iTDKeT4SI7Jn0b7I6eGhtTM8egENqLDL4rU/V80klpfWiastdF8duS
 eHIKvrk
X-Google-Smtp-Source: AGHT+IH9ABF/epet0YyavAL5UCU4ssoJynHeHZcnll0sQNBCtXXM8F96OJowI+dYwtgBHc+ux4F24fX+GK7EgBP0e+Y=
X-Received: by 2002:a05:6402:51cb:b0:615:80eb:76ba with SMTP id
 4fb4d7f45d1cf-615e6f53078mr11778231a12.17.1754399524779; Tue, 05 Aug 2025
 06:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
 <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
 <95d77991-77ed-4af5-8ba9-a4acc57e7a21@linaro.org>
In-Reply-To: <95d77991-77ed-4af5-8ba9-a4acc57e7a21@linaro.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Tue, 5 Aug 2025 20:11:52 +0700
X-Gm-Features: Ac12FXy_Kf5IU4kHIVObEg06Ek94_xiWMRpSs8vYafPqyvY9-DjMiQzxtSkdshI
Message-ID: <CAJaLiFwFpZTiM5_QnB=jq7FSrFqmf0QjbNPBsYFPMyY5=FB3kw@mail.gmail.com>
Subject: Re: Smatch issues reported for Marvell a38x DDR4
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Andrew,

On Mon, Jul 28, 2025 at 9:25=E2=80=AFPM Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> On 25/07/2025 14:02, Stefan Roese wrote:
> > Hi Andrew,
> >
> > On 24.07.25 18:01, Andrew Goodbody wrote:
> >> Hi Stefan,
> >>
> >> Smatch reports the following issues
> >>
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029
> >> mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less
> >> than zero.
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192
> >> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270
> >> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero.
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
> >> mv_ddr4_centralization() warn: unsigned 'if_id' is never less than zer=
o.
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
> >> mv_ddr4_centralization() warn: we never enter this loop
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911
> >> mv_ddr4_dqs_reposition() warn: always true condition '(delta >=3D 0) =
=3D>
> >> (0-255 >=3D 0)'
> >> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924
> >> mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than zer=
o.
> >>
> >> As I have no way to validate the correctness of the code I am not
> >> confident enough to attempt to make the appropriate fixes in this case
> >> as it could affect its operation. Perhaps you would like to take a loo=
k?
> >
> > Sure, thanks for all your work on these smatch issues. Really
> > appreciated.
> >
> > But frankly, it's not easy to test anything in this area. I still have
> > access to one board (AFAIK), but minor changes usually don't really
> > make a notable difference in the DDR controller configuration here.
> >
> > My suggestion is to send the patches (or one patch) "as best as you can=
"
> > to the list for official review. I'll try to review and perhaps someone
> > else with access to such a board will take a look.
> >
> > Thanks,
> > Stefan
>
> OK, patch coming. It was not as invasive as I feared.
>

Please add me to the CC list of your patches. I'll be available (in a
couple weeks) to run regression tests for this Armada 38x DDR4 area.

All the best,
Tony

> Andrew
