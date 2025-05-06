Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB71C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6300182999;
	Tue,  6 May 2025 15:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sxupf4ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBD782998; Tue,  6 May 2025 15:24:52 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C22C82162
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5fbcc5aa54aso442835a12.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537890; x=1747142690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+IAlbj0WPWGyOeSAleA4f6ayLogi+hZkxZ23TAB8/cU=;
 b=Sxupf4ur01b4z6MAMExqY+JQ8pxyUZpSic5K3VnqVL/34scXSV7sQlccbOPCsLcZP5
 hY1wcsYBx69pIfal2MAFM0fSXOzdf26L8+Q+YrYbCL4U67IDvLFLNhfaZs3sMiTC9nK8
 1e6rpLdAUbovc3mhXc/FpBhzdVg1CXCa32YPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537890; x=1747142690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IAlbj0WPWGyOeSAleA4f6ayLogi+hZkxZ23TAB8/cU=;
 b=h5A+7dQvDCk0e81BW9vi0/Tj5evq7YgrLrUrvrIKDPLPHoT8zg5seLKqsKtX5Ml+/E
 BiV87oLYLm6/AsWfh16MOh2eI/8Q/KLgvSVmMm1kERO0tyxq7UcVEGL9FDnP0kZHK777
 fPSj0biec4zhozvxA8Tug37qPUAUD1r9/CNKL9CU0D9CivSaOzCcQda/S9SqifIB1YZC
 q5dx34qj34Lsdt6VRp7U7vjM2IbyA9hPH7Fo4HHZZu6RKEa3DrMWefG78dU/IBVxptTv
 lIisr9dYx23hcAzIy0AOMOfxOdvWe4eRNk+87vyxMirHBe+5ms7LMiQF5lZeEs7fpdGY
 Fnhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTXqq+8l+BwLdIvE4enEi2c4dN51SBTyyNkdz95nKOi0LOrAHmkDJfSNvlVkf9Vz65HzhVFxo=@lists.denx.de
X-Gm-Message-State: AOJu0YyNZc7XqoozG4YujwKxPcLlpJchwenMmHnCPRmCadt4YFwEq82T
 uX7eJm9TiMqOyjNoVA+cvReOSWSwWuAkpGSJ3RtKwenXldwe8OhIllUS8haJOUUeuMXqCgWkxg4
 1Vzac1YhCP/Hwl2SZ1BWWYdGlAk1aLgckeZp/
X-Gm-Gg: ASbGnctOM48W4DNN/lup5ePTz1PnsIn8F9N7d/Iud+5J4Lv8Q0levDb9NiMn6G+ympt
 LfMx7Mez9ArN+yLkim9hOELV5S2to7vhOFo85PN77C9gHw3UkkxgGRKCj7TgvfIGBueAoAdqQ22
 JWj3TlUlEWXsuBPg/P0M6Zebk=
X-Google-Smtp-Source: AGHT+IHmJXhOG1/JBg0qkTliwYG2YgIRV4/ylVwjtWcJ5rbJhjJuOPhliiBH7U4JGG4wXbGh7+HtgWFumz3sfSaZ/0c=
X-Received: by 2002:a05:6402:5246:b0:5fb:206f:784e with SMTP id
 4fb4d7f45d1cf-5fb6fdacf2dmr2351163a12.9.1746537889918; Tue, 06 May 2025
 06:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <174620317246.1348341.13335565510376078911.b4-ty@konsulko.com>
 <CAFLszTgv8vVkK-ts7zRPN2p6oLPWwTKuTk=PjNse-AC2ZgV8WA@mail.gmail.com>
 <20250503165827.GF1261075@bill-the-cat>
In-Reply-To: <20250503165827.GF1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:24:24 +0200
X-Gm-Features: ATxdqUFQQACXUZ6TxJERSKOlEp2X7p_3ltW0h5SdBMtC6Gphmz1zoyzU9fjo96E
Message-ID: <CAFLszTiFq2L4LY+6ObZxNMr3Ni=1CvbtMh0+8sRLtedr0ssFqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sumit Garg <sumit.garg@oss.qualcomm.com>
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

On Sat, 3 May 2025 at 18:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 08:09:48PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 2 May 2025 at 10:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, 11 Apr 2025 14:47:37 +0200, Caleb Connolly wrote:
> > >
> > > > Introduce a new event to signal that the live tree has been built,
> > > > allowing boards to perform fixups on the tree before devices are bound.
> > > > Crucially this allows for devices to be enabled or disabled, but also
> > > > allows for properties that are parsed during the bind stage to be
> > > > modified (such as dr_mode for dwc3).
> > > >
> > > > With this in place, mach-snapdragon is switched over to use the event
> > > > and some hacky U-Boot specific DT overrides (which had to be undone
> > > > prior to booting an image) are removed in favour of fixing up the
> > > > livetree (which is not passed on to further boot stages).
> > > >
> > > > [...]
> > >
> > > Applied to u-boot/master, thanks!
> > >
> > > [1/8] event: signal when livetree has been built
> > >       commit: 993a9db918af451c68851522c8770e582b717629
> > > [2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
> > >       commit: 5a1dfb27f9170d35a475ea8be46b5d7c037ee837
> > > [3/8] mach-snapdragon: of_fixup: skip disabled USB nodes
> > >       commit: 0ec337d03410a4a0b7402ae72968470cf63f0c55
> > > [4/8] mach-snapdragon: of_fixup: remove confusing log message
> > >       commit: a6cc4ef343dc39c17fd5b833d983aff2f26c94b7
> > > [5/8] mach-snapdragon: of_fixup: update comment
> > >       commit: 9bc7eef9bf58c4c1d453cba81060dc61375f5354
> > > [6/8] mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
> > >       commit: 3b983cf48e70ecb6aadca788d0d91a021340c802
> > > [7/8] clk/qcom: qcm2290: show clock name in set_rate()
> > >       commit: 229fd3f9a8d4dbaad7c9a2e9c1b62d14d0753b0b
> > > [8/8] pinctrl: qcom: qcm2290: fix off by 1 in pin_count
> > >       commit: 2803a466a96153ab01c5789321e48397b6bae9c7
> > > --
> > > Tom
> > >
> >
> > One of the patches in this series introduces the concept of two
> > parallel devicetrees in U-Boot. So once we do move to livetree 'for
> > real' it won't work. We did have a discussion on the series and I
> > proposed a couple of alternatives, but have not heard back on those.
> >
> > As always, I don't mind what is applied so long as we can change it later.
>
> Yes, it seemed we had reached the point where there was confusion over
> how things work, so we're going to move forward and see what's needed in
> the future.

OK. I am not sure when I will get to doing more on the OF_LIVE
migration, but it is a good reminder.

Regards,
Simon
