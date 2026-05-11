Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFBCCD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 750C5803C6;
	Mon, 11 May 2026 20:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="of48Hu3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFF580F0E; Mon, 11 May 2026 20:08:05 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCB780398
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6804e24803bso1822233a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778522882; cv=none;
 d=google.com; s=arc-20240605;
 b=JVkht40wx8BHajhZH/q/eYwJf/LvyYXjxFxKXlLg+BAFzGwTbhaLewOlZK1mfClWce
 otqDjwA+7gd2Wm2hFf9ytDw09Vw6FSkc1MeTDRPrpdVP66yYyOinOEhIx4id4LVApkUu
 Qk6VWXNsmR91WScs+ziBC34Xaua07m/F+6V4rjuXb08lnhkrDDhe2kSaaEPQzI1HTgi1
 qEM2tfKCXfo/zxLENiEGZWYkJDQsNJPyrpVnPDzXXnR8duoYZfeELCZ1l7yxu4hio4DQ
 nLJffw/9wWhxcPIbHVPXnbzXXwD1KXNW1NNYLbAyxFOWDHzdnyPSRmN+XOLpSFpWPfLK
 XHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gpoyzIFl6OFX5D/1DGHawVor/J+nfi0UWofV+KnjpH8=;
 fh=MnrnvWCmQksGp4DN91z/WigQEzLhsJgZ2mW/UTa57DY=;
 b=JY2279F05Hx4oDZF/gRQuESTXVupYjPROyQxU57L1Hg2Fxl07nD8vlbi9Z5wcj9HDJ
 EUL8l5YbDGeT58yzeEbkONtadcW6sMwRti9836ejHnWIlhmrXpke4D+NbX65Bklkb7sY
 u4OontCg0hxMP0rZx6CsKSPssIlysZYgt1RI58cRwy1Al3+xFvCDskJFczt7Ev7MreWQ
 JxKXE9JdthXN9jBVvumePYPPJo3q0lMU7VjjIFotavjVIFVeDqBXPABIeh5uiG/9cvE0
 RPI6Q+NI01/hK6j0tfPp9dKL6DTIma7a7u3SroZPfdyVKhTt1+SBGBBclJdRV9MdieI6
 KWsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778522882; x=1779127682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gpoyzIFl6OFX5D/1DGHawVor/J+nfi0UWofV+KnjpH8=;
 b=of48Hu3rCVvmbmC0m21tFGMtxg/VyumjJ1ibEv8Lk/j0bVq8cU8qWUFCm/p4exSsEN
 Xto/M3fy4ksmlH3mWXbtpBmn40HoocFymAgVGlDHK7kDcBacMa0vcdnUAM7dUHAhgTHp
 LNyud7nrZQqoaBDertB/dCZ/s4cnCUdvd1nBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778522882; x=1779127682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpoyzIFl6OFX5D/1DGHawVor/J+nfi0UWofV+KnjpH8=;
 b=N+trZz9jgRNO2kgym1TDMWYtw/p5Wiv9haFe7f23XCFFCLujV1bt64mlPV5goZVlvY
 l7dKvP3J0adJv5cyIL6y4iq2vRI/YHsL6U44sRGXyCVIVc1noJd0whe6Z3mogzEiw54N
 eGkyijs4vSgBhEmaApK5u+a9vuSzaNDIy0zWJdSI6n7VScS577yLf29JQsktOMlSuP1O
 I2DBHclbh/p/d+iTlxJQG3iQs4rRQsTe+9Icsze9qO8gVl1cV5QJ63VLM9dyGnIaT18L
 aYbWkn+xykzzIpauKeB90PHymRpFfJn7j3bK7rfimnaQfIcurloGDeg500WCfaEPq1Gm
 H+8g==
X-Gm-Message-State: AOJu0YzMStDIgl76dH1Be+tPMKEqItvOCkapo+uIilVXxmmIwcDM+zNo
 XR9kvUzq6fRkX0Y3RZ6QwLLBVROx0YJv2UKvbGUcFNQYggf2vSaDFPp9rkE1Awlo0YHVms2Wjot
 VLpSOtcibbBB7ted1QqmHXJrLc2VKxtLFl17d5I/3
X-Gm-Gg: Acq92OE2jx+UydwW9B/INx9U4NtMjhVU/MJFr8IG0d86NJf/lHySIidHLojf9mFEHjl
 5xwwO/Aty7/ORt16nPdEmOc/qb6lpoQHHciW2LNWlEiwOjbbyXqoG6mHE6bDcb+oPnM6bTzc2At
 23mMCGL+ii1Mu7MatNKIF7cOrbbkkJFua/K7waNlK/qbyhdipcRBqM+3NIzFcZoHTa+lFHHZLQJ
 x/DMt+YxGj25rCnEvNgiH1Oig6EuHjnO/qZQlvWOZ4YWBnjUHqHVt7Yib57V9IZ3ivLSSPw+gRb
 2z9N85Y33ag1dzaJ
X-Received: by 2002:a17:907:6094:b0:bc5:ade9:ef13 with SMTP id
 a640c23a62f3a-bcaac93698fmr796880466b.36.1778522882115; Mon, 11 May 2026
 11:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.4.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
 <CAFLszTgkgGh_o=_ACPkTPpeNw6O3qvM=ZDywranrZpgPn_c_wA@mail.gmail.com>
 <7a31d2d3-13c4-4789-86ce-f54b173771b8@siemens.com>
In-Reply-To: <7a31d2d3-13c4-4789-86ce-f54b173771b8@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:07:48 -0600
X-Gm-Features: AVHnY4KLeC0XupLjrj09KoOHFEnZxgH0ELcPR1FSSO8mNBgr3dbAxR2ncHh2WLU
Message-ID: <CAFLszTge_7Tu7tJ_vL14ApGDHOhn+ZVrs-vVVF7J11w0Ae1xDw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iminfo: also verify signatures
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ludwig,

On Mon, 11 May 2026 at 05:25, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 5/7/26 18:49, Simon Glass wrote:
> > [...]
> >> diff --git a/cmd/bootm.c b/cmd/bootm.c
> >> @@ -335,6 +335,13 @@ static int image_info(ulong addr)
> >> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE) &&
> >> +                 fit_all_configurations_verify(hdr) != 0) {
> >> +                     puts("Signature verification failed!\n");
> >> +                     unmap_sysmem(hdr);
> >> +                     return CONFIG_IS_ENABLED(FIT_SIGNATURE_REQUIRED) == 1;
> >> +             }
> >
> > A FIT with no /configurations node (an images-only FIT, which is
> > valid) makes fit_all_configurations_verify() return -ENOENT and log
> > 'Can't find configurations parent node' from inside the helper. That
> > ends up here as 'Signature verification failed!' which is misleading.
> > Please treat -ENOENT as 'nothing to do' in this caller, and don't
> > log_err inside the helper for that case.
>
> Ok, I can certainly omit the extra error message. What does 'nothing to
> do' mean when FIT_SIGNATURE_REQUIRED is enabled though? IMO images-only
> FITs are not acceptable in that case.
> Maybe renaming the option to FIT_CONF_SIGS_REQUIRED or so would make
> that more clear.

Yes that makes sense, perhaps FIT_REQUIRE_CONFIG_SIGS ?

Regards,
Simon
