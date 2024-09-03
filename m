Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F84FCD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19D8888AA;
	Tue,  3 Sep 2024 13:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="ImP78RdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD39088AE8; Tue,  3 Sep 2024 13:06:35 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7967B88875
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6b4412fac76so40714577b3.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 04:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1725361592; x=1725966392;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtuEipPKp3BDVQAgDAaxzyoKsQbZK9wtCo7LIe0aN44=;
 b=ImP78RdHN1ECfWVDkxNgL/W8kNA2EvGvefmQ9vhl+RLxLVmQMtbRgtecyoo41Bm6tQ
 usHcKvZXkI8PkfZ4N5feQjZFqdsWrC2300HT0pKfBUQSLpECZ6k4l98RIBUwwgc9LEkJ
 K+eAZnGrnIQkuXHOW9ln1kd72LFO+CrI/VP7XcVLlh+imoby/Ee1S2NaxpCjYV8K17Yv
 1Ak1YRkyjjNkSzz/5xA6BnSMUUDWjTELIbQlKmfKItaLqVUedz98tOdoY/SEoTQCR4kY
 vdymKthB75+glm4Sxz4jeXYy6VFL642CSqMx3HL7YTSOH7vR5FeqBOoeJAreM1jcaGuv
 xCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725361592; x=1725966392;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtuEipPKp3BDVQAgDAaxzyoKsQbZK9wtCo7LIe0aN44=;
 b=kfJ7/NP0ZtRlSJYYfkPIIiw4FdM5NS8FJUWE4kuEnSkRjPp4XOb7RkmzkzUvVS/cI1
 zq301T/KUiIqBlkkE+pfT/FvkVduHlQ3cAriOwqpiTJ3BKcv8kg7+3r8ySPX1jlclqmD
 Y/wsDhik7+tTwvmOIvu+FoKYC3SWm9Xjmgn/UZhMwUu/stcbJuVS3cYEAJiVOhOTe4hU
 pKJEf/PaMTc+m0R96imCTGTSkJknwX9aBclYUyYBDA3r2rEVDQA5VHQrnS4vego/2J7M
 NQ7d8mgPcWmKvw97xSeK5kwJW396bdiE62ZKrEZOUj6Etjs7hRknlhy2JPARmqPyWQ//
 oO7Q==
X-Gm-Message-State: AOJu0YxPOorSmE2mV3dxjnKp/zMHU9oxjJMvt64a2ODfVkNynhvlpzh/
 G2nCfKFkln9L7O8UxgifHZifMJYny6ddxkophXHnL9S00Ux5MLcoquaAyzlqvuuzKti4OI7SdmS
 OKBrdI3cBRAszZVTcKYKM5wyLPdn4R9LKLv8b
X-Google-Smtp-Source: AGHT+IH1QqiZWakk8mRDS7THShu/MtZ8IeySaaxuy7AMk8nECwFdBiFBz1Cr/yDTJ5ZoxOnCSebleLbl533quRBko0E=
X-Received: by 2002:a05:690c:5087:b0:6d3:e798:a1e1 with SMTP id
 00721157ae682-6d6524069cfmr76668947b3.40.1725361592333; Tue, 03 Sep 2024
 04:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
In-Reply-To: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
From: Michal Simek <monstr@monstr.eu>
Date: Tue, 3 Sep 2024 13:06:21 +0200
Message-ID: <CAHTX3dLUTJ=FKyZT1NaWMsGwKpUwy0MBMsra7YwNQCPERYNDoA@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: setexpr: fix no matching string in gsub return
 empty value
To: Massimiliano Minella <massimiliano.minella@gmail.com>,
 Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke-oss@weidmueller.com>, 
 Massimiliano Minella <massimiliano.minella@se.com>
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

HI,

=C4=8Dt 8. 2. 2024 v 16:00 odes=C3=ADlatel Massimiliano Minella
<massimiliano.minella@gmail.com> napsal:
>
> From: Massimiliano Minella <massimiliano.minella@se.com>
>
> In gsub, when the destination string is empty, the string 't' is
> provided and the regular expression doesn't match, then the final result
> is an empty string.
>
> Example:
>
> =3D> echo ${foo}
>
> =3D> setenv foo
> =3D> setexpr foo gsub e a bar
> =3D> echo ${foo}
>
> =3D>
>
> The variable ${foo} should contain "bar" and the lack of match shouldn't
> be considered an error.
>
> This patch fixes the erroneous behavior by removing the return
> statement and breaking out of the loop in case of lack of match.
>
> Also add a test for the no match case.
>
> Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
> ---
> Changes in V2:
>  - update documentation to describe the behavior
>
>  cmd/setexpr.c             |  9 ++++-----
>  doc/usage/cmd/setexpr.rst |  1 +
>  test/cmd/setexpr.c        | 10 ++++++++++
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/cmd/setexpr.c b/cmd/setexpr.c
> index 233471f6cb..ab76824a32 100644
> --- a/cmd/setexpr.c
> +++ b/cmd/setexpr.c
> @@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_size, c=
har *nbuf, uint nbuf_size,
>                 if (res =3D=3D 0) {
>                         if (loop =3D=3D 0) {
>                                 debug("%s: No match\n", data);
> -                               return 1;

This patch actually changed the return value from command.
In board/xilinx/zynqmp/zynqmp_kria.env we have

bootcmd=3Dsetenv model $board_name && if setexpr model gsub
.*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter*
$k26_starter; then run som_cc_boot; else run som_mmc_boot; run
som_cc_boot; fi

and this patch actually breaked it because we rely on return value.
Changing return value is not described and I want to know if this
patch should be fixed
or we should update our commands to match new return value.

Thanks,
Michal
