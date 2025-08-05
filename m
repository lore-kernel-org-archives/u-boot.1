Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D340EC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 161DC8388B;
	Tue,  5 Aug 2025 19:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cCGiU60V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E448388B; Tue,  5 Aug 2025 19:45:53 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1C483885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-af949891d3aso489202366b.1
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754415951; x=1755020751; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBobKwujmUIx1EuoOvb4O+gbJ9D9kvIOUKLqg7H0DPY=;
 b=cCGiU60VtTnM0m4kSPok7JBkRjkUv17W62ARAjHtryUm+wux1w7bTipF0WeEQuRne2
 +S0xElLl6Q4D2tqeEHRIEYZKHdfFD+vgYYu4bIjQQLtD/chEn89e9shDBX0QwNTmmz4+
 f3U0PK2s/nWZJT8qG4AnmSXlB4lqd8P9DmFsby/hSnfILWJB9MjbYfMj0D/HnrnXCRNo
 lQxneohP5eagLEXmAc/eYJNGarPN1gAUXtR1zLydHt8urmTgHNg66bzbncBox5WfW+Hx
 NvuRlxqcELXAYw3mBO3zTVRuZ1hwceUz4yFThmZkduXlHQnXu3FSqZl/thgg2qHAgoOM
 N0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754415951; x=1755020751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBobKwujmUIx1EuoOvb4O+gbJ9D9kvIOUKLqg7H0DPY=;
 b=T3jeksilKC4LdpUC8SJL0gJ4bVsm+ylzlSvezJH3t9efrcwT+od+4xoqRL6cuF1ZVT
 nmo8UEoC9tMr4TqmWMhPIxZ3n+UYb3BWHQFNepJRe1ymUe+8dvIgvr/VcgxZMwnJv5bq
 U62JfVjNVoRdKF8AfF5PWRRtFbVrynxLC2L+DFwD3oeHW2I6kyKoD++DtXj7mps6rDTU
 NtM+TePuF0bSfCxEBHHIl8Ce+MGlmgcef/va+nBzby0thQ6CL+NyztHuc6OFjuulbRjW
 NGzSI3IS7kTN9UpoWQzaAgWqTMbPcqR2YFn4Wnbb9GP5Fmu6GL3yFjc7a7HMpfbPncgJ
 Ecmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+26ER43e4XcQCn6kXBLfogRTza8V1Y9qhakRHiiHwk+UAD1jYz/S9l51aXiS0i80MtRVZLzc=@lists.denx.de
X-Gm-Message-State: AOJu0YyxknJ8CnY+oo0SWUHLX3KsDZIvbb/AMDwrxFZT5HtQSkhBMYPd
 1hiJME+4Y5lAGb3GotbWkhbT3ha4A+Z21jsluRhx3Zv3zrouuHEENuleBBjmLDqvHULjO5ndfeq
 jghqUC1vEtl4UbZuMyaw3joQU4mpiw+I=
X-Gm-Gg: ASbGncv5v3EOvR72/NryJ79GCdWlRZAox0xmF6vri40DS23Bx3Dh1joKFY0slWdbWuT
 XxZ6cvHoElxDY6pFVXkRA/RRTRORxX/NmxOzbidjRQl4JvmMO4Ssdrhxd0tFv//E+jf5FQzpp2G
 oDDSDNFepJe2qIk7ZBnF8UtbSCGDsKFt+aLSgunQiiZ3koQ2IRUCjhRg/634ueHZnGaFGCr1jMT
 jD7C1jq
X-Google-Smtp-Source: AGHT+IGMdur5uXoFt5N5WjrrzM+cILRwzF+sTxjh6pwXkq7T7uwFXRPx0DS7oHiI3t4RpXqmYZrrsFoKsKQzFtexHUw=
X-Received: by 2002:a17:907:96a6:b0:ad8:85df:865b with SMTP id
 a640c23a62f3a-af9401acd11mr1410378066b.33.1754415950507; Tue, 05 Aug 2025
 10:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <fbf8148c-1b30-40bd-b709-1b4b6817de4d@linaro.org>
 <d0e95f4a-6870-451d-a730-0eef30ed4401@mailbox.org>
 <95d77991-77ed-4af5-8ba9-a4acc57e7a21@linaro.org>
 <CAJaLiFwFpZTiM5_QnB=jq7FSrFqmf0QjbNPBsYFPMyY5=FB3kw@mail.gmail.com>
 <24e748e3-a746-46bb-b893-887dfa2e7a4d@mailbox.org>
In-Reply-To: <24e748e3-a746-46bb-b893-887dfa2e7a4d@mailbox.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 6 Aug 2025 00:45:38 +0700
X-Gm-Features: Ac12FXycJ0TfYscUl2FRTppQOlb1HZFWyvX6x9SQsUkASXRARv6NXeCgaGRPNI0
Message-ID: <CAJaLiFy_1F-GNsHvy4FKUvwPpmUNm-xWtHfXg+atmtQYxqadFA@mail.gmail.com>
Subject: Re: Smatch issues reported for Marvell a38x DDR4
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
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

Hi Stefan,

On Tue, Aug 5, 2025 at 9:08=E2=80=AFPM Stefan Roese <stefan.roese@mailbox.o=
rg> wrote:
>
> Hi Tony,
>
> On 05.08.25 15:11, Tony Dinh wrote:
> > Hi Andrew,
> >
> > On Mon, Jul 28, 2025 at 9:25=E2=80=AFPM Andrew Goodbody
> > <andrew.goodbody@linaro.org> wrote:
> >>
> >> On 25/07/2025 14:02, Stefan Roese wrote:
> >>> Hi Andrew,
> >>>
> >>> On 24.07.25 18:01, Andrew Goodbody wrote:
> >>>> Hi Stefan,
> >>>>
> >>>> Smatch reports the following issues
> >>>>
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:1029
> >>>> mv_ddr4_center_of_mass_calc() warn: unsigned 'd_min' is never less
> >>>> than zero.
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2192
> >>>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero=
.
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:2270
> >>>> mv_ddr4_dm_tuning() warn: unsigned 'reg_val' is never less than zero=
.
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
> >>>> mv_ddr4_centralization() warn: unsigned 'if_id' is never less than z=
ero.
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:662
> >>>> mv_ddr4_centralization() warn: we never enter this loop
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:911
> >>>> mv_ddr4_dqs_reposition() warn: always true condition '(delta >=3D 0)=
 =3D>
> >>>> (0-255 >=3D 0)'
> >>>> drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c:924
> >>>> mv_ddr4_dqs_reposition() warn: unsigned 'delta' is never less than z=
ero.
> >>>>
> >>>> As I have no way to validate the correctness of the code I am not
> >>>> confident enough to attempt to make the appropriate fixes in this ca=
se
> >>>> as it could affect its operation. Perhaps you would like to take a l=
ook?
> >>>
> >>> Sure, thanks for all your work on these smatch issues. Really
> >>> appreciated.
> >>>
> >>> But frankly, it's not easy to test anything in this area. I still hav=
e
> >>> access to one board (AFAIK), but minor changes usually don't really
> >>> make a notable difference in the DDR controller configuration here.
> >>>
> >>> My suggestion is to send the patches (or one patch) "as best as you c=
an"
> >>> to the list for official review. I'll try to review and perhaps someo=
ne
> >>> else with access to such a board will take a look.
> >>>
> >>> Thanks,
> >>> Stefan
> >>
> >> OK, patch coming. It was not as invasive as I feared.
> >>
> >
> > Please add me to the CC list of your patches. I'll be available (in a
> > couple weeks) to run regression tests for this Armada 38x DDR4 area.
>
> The (one) patch is already in master. It would be great though, if you
> could run some regression tests once time permits though.

Ah, I see that patch has covered all the error cases. Will do the
regression test.

All the best,
Tony

>
> Thanks,
> Stefan
>
