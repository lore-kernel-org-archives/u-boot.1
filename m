Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C25C25B45
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F0F87934;
	Mon, 23 Oct 2023 19:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BE9JnyXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1BC8794A; Mon, 23 Oct 2023 19:14:17 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8D88793B
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so536305066b.0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698081251; x=1698686051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zpkq5pcuGYbSHQN8+/a3OeTPDELsG/eKReI+fF5A1ds=;
 b=BE9JnyXWoOJXDMVOF+v8P0HAjtcjON0f8dhCYdQtI1xRLqTPoh58dkEGhvZh6Yj9d5
 SQ1hCYKXgQFa+hkTyqltGGkXegNa4lsOyY3zPOkqTdiVxSh5IumnVFg3hXgG5hCaQCqh
 ROxbBItVvT0Ooxdmy3teWcMIEqPjvIuouUKhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698081251; x=1698686051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zpkq5pcuGYbSHQN8+/a3OeTPDELsG/eKReI+fF5A1ds=;
 b=adS9gTqyyscwwNgb+M9ivSMznaMCXwLaRrzA2NXzQtxjfb2wJiUhZmQFGpydyCT+UB
 fc30BJqCIOdoZq0iRspx7uy6bqVZQNHIr1QHBl+CYxh2EEZHRMy0okicUCv8dlNDvFYd
 UJleXCvwHueYHRaHDmfBUCdyA0kzlDKiij7hc5GiBSlBQFYjKCUd7v/nTwHDovSTfsYG
 xwCA0H2kQp0fvaBVsswkc0AsafLUbEUzUnS2qK71Twu/j9TCs2vpO1MzsAEJa3beKTIl
 qVr4aDqwbNZxZ0v5zPDF5wvDZ2UD/o4sAdHLVyTCu3Df+rIxJUawXW29dhz/qdSo4Ik2
 xmJg==
X-Gm-Message-State: AOJu0Yx8ONykj25cleQg7FR34FAzdJV5iqahO9YEISDDyfC5GmwEcXHz
 5HsV65AsakZKcRNyvuToGikfXJeKMiUAetruxbK6o5qhW5OOo8ynVu6NRoDu
X-Google-Smtp-Source: AGHT+IGrC3fK+ulfDDDONM/YARJ8P+pXM5UZYhGDwPxleqbRROWEyksexEHSaXSo2gM+8C23JNAoTjuPpSw/0Za7MFc=
X-Received: by 2002:a17:907:7b9f:b0:9bf:8073:a922 with SMTP id
 ne31-20020a1709077b9f00b009bf8073a922mr8870589ejc.19.1698081250672; Mon, 23
 Oct 2023 10:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231023070216.394709-1-sjg@chromium.org>
 <kdfpezftry3d77g2f7aeasv2akd4p2oiedv7zs4xkx4d3s62a4@7qqz2avrn42p>
In-Reply-To: <kdfpezftry3d77g2f7aeasv2akd4p2oiedv7zs4xkx4d3s62a4@7qqz2avrn42p>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Oct 2023 10:13:56 -0700
Message-ID: <CAPnjgZ25GuACGCvfuYXf5RBt92C20biUuaWQ2VN+pNm8SNT10w@mail.gmail.com>
Subject: Re: [PATCH 0/4] bootstd: Test and boot_targets improvements
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Ivan,

On Mon, 23 Oct 2023 at 02:44, Ivan T. Ivanov <iivanov@suse.de> wrote:
>
> On 10-23 00:02, Simon Glass wrote:
> >
> > This series makes another attempt to support things like "mmc" in the
> > boot_targets variable. The previous attempt introduced a bug which made
> > iteration fail.
> >
> > New test coverage is provided for some previously untested behaviour, to
> > prevent regressions.
> >
> >
>
> Thank you! Booting RPi4 from USB and uSB looks fine now.
> I have updated also our Bugzilla entry with the boot log.
>
> Tested-by: Ivan T.Ivanov <iivanov@suse.de>

Thank you for checking it.

Regards,
Simon


>
> Regards,
> Ivan
>
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1216036
>
> > Simon Glass (4):
> >   Revert "bootstd: Scan all bootdevs in a boot_targets entry"
> >   bootstd: Expand boot-ordering test to include USB
> >   bootstd: Correct logic for single uclass
> >   bootstd: Scan all bootdevs in a boot_targets entry (take 2)
> >
