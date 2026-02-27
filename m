Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6AD104891D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 22:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D377483E76;
	Fri, 27 Feb 2026 23:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n3v5ABf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C077983E81; Fri, 27 Feb 2026 23:14:52 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4335483CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 23:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0c83so4829345a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 14:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772230490; cv=none;
 d=google.com; s=arc-20240605;
 b=K7yJP4Uh7rbkKBZgWWnlaqNIV//MkyxEpTyP4ZDnEvR9PnbDDVZijq2VYJHxkbXUbC
 ow1SoOHq+tTSKijYwCW0xQuRe0CgcCvpr7NvtaswHJH62otNKkedqhPPkFtqTepgNvFB
 pVuJuy2sFap/XCWw37O9ZmoMfAbcoLL9OHkn+lZu9Cu5f4iP5C1PzbGkE9xM47x+Ja3M
 g6qRHiNtNzOrTcJpda5cLlNyiNjbECoGiIa+ahLHd4YS1waVBbfn0Oi8aflRZR31zZ8Y
 k2zqOkbqM7NzSpeW3UfVIeRa23t8SSZQJBiFOd49NNthaWlfNqA6g7bep4lGHV4hleIO
 D0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=O7zzEed4PuTqK2aL8AEhuwgNafYG+GxAXECAQ1ZW8JU=;
 fh=92gG7ptBGCvu2IuC2gq9NtcCuhK2VousJBpQ3Ju8FEI=;
 b=IzsGu+Md2MpAPW+8UfkET/rQNQChfSzPUpQKZrq8I7IYN4ph3vBMTYxIeL1i+oAdeR
 SnO9d2RFCFYTmhLYFalVfTu+acwet4hf7B4K8pZ579Blj8fL82Ln0se/j4n9CkUdErTK
 CsENCZy7kHika3+EyeEQKqV9yzZYKqBkZ9ke4tmR3dwKlzWck4nPdPrE0DtADcvTCCof
 aPEptKU/wYAmFo3fyc1kuv23Tqd32EXqIp18oWs7xaapHsLTYppH8g1ywa2G7x8Mg8/F
 o5uzMhdkq0ISrRENnSuuuJiUeoGK/Gt7RljxgrcY7i6L03drW1eXEW/QguuAiFitiEZD
 cvqg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772230490; x=1772835290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O7zzEed4PuTqK2aL8AEhuwgNafYG+GxAXECAQ1ZW8JU=;
 b=n3v5ABf3BcxqU/MHwSczaoCWkefhr/fEatpBU11tJS72ZU6Q6jaBKhN6aW5Tctf9kd
 lwi0gAEtQEYkGmeQSRTC7aKXttpA5K6THiB0F/YootiXpRcs9Xv1Fjx37yjBIew8hgk3
 i5ZOtBeRkncmaEehY3ep8JQ05F52RuvgqlK4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230490; x=1772835290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7zzEed4PuTqK2aL8AEhuwgNafYG+GxAXECAQ1ZW8JU=;
 b=H1ksfdgnwAlWDWZm0beBQPLl1qiIzYCyXHrMqCfivb1JyVxMXHBKeS+sQIZScH+sYD
 e4AY8DWybKMm6gMuDkOf8pU37YVDgWZ7fKjc8OjW2O770QxQ1m4uA4zNYdjkDIhapjzG
 WkVYMgnIOGxMgVsY1BDykNy0V2IvGaVYjZ33pGLkpycCjQKtFVrJt5djtRBv5r3QbTRQ
 X/+oN2aHgG7OA97vx6LSaXZVx5chPD6XzkRDK2qjvTg78u5S8qWyS2Hh1Gx4VFChvjQO
 qRkmRNa1ciALfNU9dQVj0W7qZdtHLrqXjYoS7AXX0SxyTDF+fUZacEAgwFXbrBdrdrG6
 ki/g==
X-Gm-Message-State: AOJu0YzUaG7ep5PjRCJo3QcI6ooz+yA6FGRwsr8wGkN8KZSr1mmeHcGz
 l4G+D6HWNF6nmUA/i3VUugZLbvMZ1J3bAA5bL7S/V7TqlgjTrA+aZ3KNOeIIemQUDlLbLCTWAxh
 8Q6bewOCrYw35379Zx36uQN1i9GoqiM2ieU4zEC/nCifRq1W3ETM=
X-Gm-Gg: ATEYQzxcP5PvwNxrwIyHzhIFnccScd2EFWY+miE6vUDaDigYtIlwOFceUerbInhuXws
 x8p873F6g+OT88IkQ9l5opHMcNGW/d4wvrpdojry/MZ1DVtepS+NpoweDIcG5NaOXlbIu7a1SHX
 ZFjyrTEBQO17OVdTvuk4jPm7Pe6jGztF5GV3w+TTUIDAuLKKPGokBzVAEDuo7ogzfRM0UGemhXE
 hChropEnIDc7gHVcMvJT5nwtBcR00yWky4YkFTVhjfacR1VS7shzsEguL3bzmVghGpfW5NG9b+T
 LcFbeQ==
X-Received: by 2002:a05:6402:35c7:b0:658:e665:766c with SMTP id
 4fb4d7f45d1cf-65fdd6bec33mr3185201a12.8.1772230489587; Fri, 27 Feb 2026
 14:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20260225162357.3449937-1-sjg@chromium.org>
 <20260225162357.3449937-6-sjg@chromium.org>
 <20260225171256.GR1593142@bill-the-cat>
In-Reply-To: <20260225171256.GR1593142@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Feb 2026 15:14:38 -0700
X-Gm-Features: AaiRm530FUtB0ZVMhj73XfCnWezjUij8lT_BzHEOFmyLRobzD9IWf2ZbrFoshGY
Message-ID: <CAFLszTjvQFS1BGU8QFA-Q8jiqac8jQj28_u6P=dKTo6xTrKFiQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] test: Add a helper class to create disk images
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
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

Hi Tom,

On Wed, 25 Feb 2026 at 10:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Feb 25, 2026 at 09:23:49AM -0700, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > Provide a way to create disk images which consist of multiple filesystem
> > images.
> >
> > Provide an option to use the current directory for images, instead of
> > persistent-data directory. This makes it easy for C tests to locate the
> > image.
> >
> > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >
> >  test/py/tests/fs_helper.py | 97 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
>
> It seems wrong to ignore the existing function to create disk images.

Can we do this in steps? I have a pending series to rework the test
images (and move them to the persistent dir) but it is at least 10
patches, so I figured I should start with this.

Regards,
Simon
