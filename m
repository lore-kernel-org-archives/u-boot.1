Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE70C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 19:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D468838E6;
	Thu, 24 Jul 2025 21:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pKBtLoAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAFC0838E7; Thu, 24 Jul 2025 21:16:55 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FFF838C2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 21:16:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-708d90aa8f9so15012757b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753384612; x=1753989412; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wH8MkJqrQtXPo32ZCSl9949iFWKndon5m5aMbHuiLng=;
 b=pKBtLoAuo0EOQIWiIt4Ndgy0IiHpp4QEsm+EYhLuY96ptxnYP5aoA1Ve7VaCiqk/Vc
 wiuOcvky1z54EBFaNy/jilmC+XbpZVy+7riqDvQGOBrFbN+H24De75D4PdbRSmbNbMWI
 Y40Vw+wTbcVJsLQmowq0RI0YpHIBnKv9jYkUfLx5sCLcQd5ENEp4yas61fpibfqI47/q
 34C/V6Pie59RYgYif6hZuvGGKnWKkvItRgW1dr49JdjxKDsrwk5D1yzv+qoWKjnfnPUy
 7/6t+vlPbYJ/BTzAIJEWX5IJJMmiBoo/CD//9JBxSxcGpqz7iCQ/yZLdJUsLO3xLk7SC
 gyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753384612; x=1753989412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wH8MkJqrQtXPo32ZCSl9949iFWKndon5m5aMbHuiLng=;
 b=IS9Kz71VrVKUPhzDiYQWlD0rW3H4EQzxQuxFTGOSL5uKEjUddiXiMFtI2OSE3iJjWz
 uoO3l8zM8X1L/vQkewUj8MprgX6wpag1t1DJkifYX6H69eyxDZ20AiUx62IxdBeg3eEv
 52Oe5GBrJM0PlAyOZfzGu2OqokXUouLyKxHXlF4jFbctFfPA6m1JkLb9p7tleM/9Yvua
 BYX5yguS9TMJrgHMtbhOjl9g2Jg0R6IWRkM8ToRAKzPeV6qxJvcaTVhCcRHV4DEgmrST
 G9yOBwdUMCLCaO4/6ZVND+8e+SRWdsNoGhgwjuTd/s5nmtnKMcPxdkjB3/Ca+BGTq5Ju
 IGsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIOAsW+2aBXg1nd6TjlGmEt3p70hqR0bXbZ2/iV33vZAOQNB9DLc3DzEttZaSZcxD8fPre9/w=@lists.denx.de
X-Gm-Message-State: AOJu0YxsizvIH/9aPrmTE3rMxPb2srCO5Y2JK3RJWmtPeP1ICUlczS+x
 JlTifImne0dgxnE1lJAprMoBG9DDPWyyV8u7csZbf6d1okFaKsHUnU7QLKVCEjhKulzkBd/os0Y
 DrDSQx0LbzfSOp+A9CMYg6InYYWIGxTN2xvsb3uG5bA==
X-Gm-Gg: ASbGncvQRq/kF0haY702ogahOxF+jkaBCmKWi6m9HhOlZWLQbhh4G2HjzCqDXzSpfvl
 nwtkWRzo7glcM41yQOt6iMkR5gPWZ/7vlChPl24S4L7AdL+64o+4GSM2HbXYT12KilkSq2Xh0Kk
 PKhnhrjqGVennjnMeDN9QXkikm9VrGj9whpDcisprfkWc86GXWzfvv6q08qF6iaXpt2Vgqh1+dG
 Em3Dh8=
X-Google-Smtp-Source: AGHT+IFjWGt9BvuM6gxo064cn5ABCwxe6O0tcuUyK80fQdCVoQsGhxC0e/L8DnPJmyRMcGAANZZeEK3c9PpXAueVI/o=
X-Received: by 2002:a05:690c:6c8e:b0:718:385e:58e1 with SMTP id
 00721157ae682-719b40e6c74mr110319717b3.0.1753384611664; Thu, 24 Jul 2025
 12:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-2-semen.protsenko@linaro.org>
 <87tt3b2ti7.fsf@kernel.org>
 <CAPLW+4moDYL0Q9TjSuWbqOuLQV2KCCrrzR_02-YUhivWuvQ=SA@mail.gmail.com>
 <87ikjllws2.fsf@kernel.org>
 <CAPLW+4ncXuT7=iP4wt6fuZ25cQvLJUTZe71oC6=y04Wefb5c6w@mail.gmail.com>
 <CALrBrZ2gGjk9sqqvAESs=tC4HV65Cg5Bp0qJ_ggsjd2ix1xUOQ@mail.gmail.com>
 <CAPLW+4=gdMZqoP3zZn0Dk6p5GY4N0pCDnKsXcqtLK41P-Qqu3w@mail.gmail.com>
 <CALrBrZ2Rouk+G9HCS=pbAwxJ76ZvLKhkWp=mW_ztE5R5OPiPSQ@mail.gmail.com>
In-Reply-To: <CALrBrZ2Rouk+G9HCS=pbAwxJ76ZvLKhkWp=mW_ztE5R5OPiPSQ@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 24 Jul 2025 14:16:40 -0500
X-Gm-Features: Ac12FXzfTINAYhbxE9Ihe1uZFRhLEZHWKyy1GCkqY0-pFcv1JqR9t2x_E6lOwdY
Message-ID: <CAPLW+4=W=e0jJhuyKEe02Q_OKVu4y1ReMvQLQfN61YsUxO7eSg@mail.gmail.com>
Subject: Re: [PATCH 1/9] phy: samsung: Add Exynos USB DRD PHY driver
To: Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marex@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Simon Glass <sjg@chromium.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
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

On Thu, Jul 24, 2025 at 4:45=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> wr=
ote:

[snip]

>> Hi Minkyu,
>>
>> FYI: it might not be on your side. I can't access denx gitlab right
>> now as well. There is some relevant discussion going on on #u-boot
>> IRC. See also [1] thread.
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2025-July/594671.html
>
>
> Yes, now it works.
> But, patchset was failed to apply on latest tree.
> Could you please rebase?
>

That's weird, I just checked and this series applies fine as is for
me. I tried rebasing it on the most recent master, but after doing
that I didn't see any changes in v2 patches (as compared to v1
patches). For the reference, I checked it by applying on top of this
master commit: 7bf2a52b4943 ("Merge tag 'xilinx-for-v2025.10-rc1-v2'
of https://source.denx.de/u-boot/custodians/u-boot-microblaze").

Can I ask which tree you are trying to apply it to? Also, if possible
please share the errors you are seeing when applying this.

Thanks!

[snip]
