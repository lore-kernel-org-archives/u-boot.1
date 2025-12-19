Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2434DE66892
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 21:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76A50803F5;
	Fri, 19 Dec 2025 22:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NpqUqeEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A40808AF; Fri, 19 Dec 2025 22:17:22 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC79080050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 22:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so3753586a12.2
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766179040; x=1766783840; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXmNmXwavdca2lloXudCXyd5xachMv4gmzzzjMebKtc=;
 b=NpqUqeEaHUD80s9XYNMlKjsTmn1AVuriifcqmkkEWvvjfAHMdpwyS1UMPe2OVzo01z
 Z/p4L8nHe8Hx8FdE4sZqb9NxeOfICuqMzoXJgl9p2cVeYmvHVIDuDGbrgprySwRvEJaF
 FIGDa3iffVjuxSQs2B1IHX17pFoExSpFKrfPL/xWjd8gyB8ChLIpzLN3oU6FLKht2+U+
 soNGKTNZWk1zMayyn+fh3tl/drsIzrTA127bwzlihmsZL+fePkZEK9qcvdfnLR0Po/A4
 HQDxXzeX67t1zCk/CMwCQkG3GQAvjNdMxPYzXJqUpRJaMGvVHQ1r12/syWnUff+1c+ER
 nvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766179040; x=1766783840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aXmNmXwavdca2lloXudCXyd5xachMv4gmzzzjMebKtc=;
 b=XvLRv2jla0C5SoxKQlTc7e7ZrhK69h6KuvkqeH9AGkBUIxy6nUN/cj4HwPRa3phc7A
 eSDO5bcUGcu0h56k7F2mZ3pPtTtj3vVtUjhGvKiCzeaLg6yHmSWiDaS9CVHg+kZ5uTjL
 3YBmowfISLKhA4MieFuo5Eg8vElhC177lmXb972q6K+ofMQ/aAwm2s2C9fUGRR3roOAf
 K0MsC+5WYR5yAYYWdMs6jjGvxNfuaB1plF4Ig3c9diU15P6+8JwvFOx5YZXO/OQOcv4j
 xriBVykCFPMbr7FeqEiXH7LHGL3b81ODFLNcUAt1R2wdAHs+6xq88va3fz8JDRX8gZ4+
 iL9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXt8UyoZuCFBQOooed80bBAPQK9nF5j79rhT8x1DEOxeN+IYEgPeh4oxlXwitOgcKStw3UjOg=@lists.denx.de
X-Gm-Message-State: AOJu0YzIfY8R5CVnjFBw+JWmFRPfhe2LObxJKwLo4tWWjU+ptNrDDfPV
 gYo16KxH/y6aMUEGLSi6zBW396I4jUEy3ngZ5++r8NE/zmfIZzEtc3EVSwtOIkkKKpk/CzE9Ne3
 S565PVsCP2agGH/SX/yKxQTeGNl5d5KE=
X-Gm-Gg: AY/fxX6BHdY1LHcYFCkULm7IySSz/iLrNfmC3cDUtVIqPM9aU45MqPKHBVC0kwyBUsg
 V380kPgsZevIgksAH3LO4uvjz16UY1ANR40qBc84ahjAz+5PHbkRdZOHd9uiEaodHE2DJuICh0f
 oiI5yHNU7a7bmLf25a2o88Zg7PFhms2WVdXPEFgp3pXyBivMDvqosI0/A9IXiF5LI5bDkNQh1rq
 uYCk5tG0RBQ3D0F34WtBq0631phV3Sa9DM9DTfBpqUBtlwKmECCUvq6nLPrJJnaNUi/m8JU
X-Google-Smtp-Source: AGHT+IFWz+ebUJH45/mz4wqj506HsMAn/vrM2IK+qHC+El0hVrclyo1v1AK5K9oFIy2D6fOeXiim3DPvWdkmaLj+iRE=
X-Received: by 2002:a05:6402:35c1:b0:64b:7654:f8b with SMTP id
 4fb4d7f45d1cf-64b8ec9da19mr3628683a12.25.1766179040053; Fri, 19 Dec 2025
 13:17:20 -0800 (PST)
MIME-Version: 1.0
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat>
 <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
In-Reply-To: <20251219162939.GS303283@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 19 Dec 2025 13:17:06 -0800
X-Gm-Features: AQt7F2pb9q27r5zd49aLQC6xpsE8bgC7mBH6Vd2CybYSFe6eV_0hSMWDgcuWlcM
Message-ID: <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tom Rini <trini@konsulko.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
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

Hi Balaji,

On Fri, Dec 19, 2025 at 8:29=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
> > Hi Tom,
> >
> > Apologies for late reply. Somehow missed the mail.
> >
> > Upon analysis, it seems the most likely root cause is Tony's 238GB disk
> > triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any =
read
> > beyond block 268,435,455 blocks enters this path.
> >
> > 'blks' is decremented both inside the 64-bit LBA block AND after succes=
sful
> > scsi_exec(), causing incorrect block count tracking and (most likely) t=
he
> > data abort observed.
> >
> > The fix is to remove 'blks -=3D blocks;' from inside the CONFIG_SYS_64B=
IT_LBA
> > block in scsi_read() function.
> >
> > Hi Tony, can you please check with this change?
> >
> > Tom, shall I raise a new patch for this now?
>
> Thanks for looking in to this now. Yes, please post a proper patch for
> it so Tony can test and add a Tested-by if it works, that'll make
> pulling to master before release easiest.

FYI, I will be traveling a week from now. So it would be best if you
can send the patch in the next couple days. Otherwise, someone else
needs to do the test in time for the Jan 05 release.

All the best,
Tony

>
> --
> Tom
