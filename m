Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153E5C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 07:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C183A876F8;
	Fri, 22 Dec 2023 08:07:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FQH+RyTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937808769A; Fri, 22 Dec 2023 08:07:00 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2A568776E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 08:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4b6de25993cso422122e0c.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 23:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703228814; x=1703833614; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/5dMGiaREPsuU3oIkjztSFrC4yBg8HffwcjABWhRCrc=;
 b=FQH+RyTdZ3UYUHlSkpIzszdp3KnPM2mDOgj5zk4JbkljVAv+zDDYFSxYsSFEuEQ5k3
 /C61wjjwb5SPfVSE8p4U22vbhEZvkpQlRDv1oT7NCB+pepTmMLEQAdg21j4RfiTsyh9u
 wB+guKr51zzhkCWSwzldlfC6Kl3+e7oVuCxX9QsoyA7AdiuLeyK5UCu6NTYEO3vHXx8W
 VAEMaWbVZsNc4xg+DuqvBRbUOeBrLBWbhf3NVJ9gdvnPGWMvTTx5Xt2PdX+jmfLfjyvT
 eB/J4UfTvby7WtlUNJGMZ1wsWmJQ4w+B/Sv/kom3G7JG/kyCoPQQwJmn9cZZ6B72MOfF
 bdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703228814; x=1703833614;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/5dMGiaREPsuU3oIkjztSFrC4yBg8HffwcjABWhRCrc=;
 b=pjjmmCcrgnDT5eZBxDKJy9OFLvv6yWpYyChzrX1igpCmd8ztXEYoarY7I1NBTT1Rvx
 QiWyAcvVN6E8in3Sp6noJU82y5Eb4qJBLmRJbhTYM8ypCeyeTQQGKQTWQWRHaJ37NeQk
 lJRfmjSFTqefjxAb4H83kv4iFWBU2gNPVsmS1SP/Atv8T/ICW14V8egjHj7mIRkZ27+7
 RL23iq/XS1nyJ5a1Ha7wKEEJX+mRQNsHIQRmzP8DxWjNuwA0Le5jv+PZSe0Mk6sq1HHY
 EkytHaFq7MKbL0uZIgoyf6aIPoeJUHsBoAt9nZHJH2/x3nTH4EeP0iqFxQcPWdTNSbCM
 47UA==
X-Gm-Message-State: AOJu0Yxb+Tm2yC8UIU+IjAlNko26dgvWkNwf+SU1gEvItBn1OsPjhVzz
 Ufz01jvfyfNAwQvr1/7kY1fipN59NZqhin266YXEt/asFaRKog==
X-Google-Smtp-Source: AGHT+IH81PmqwQ8ZKN5CvioEGeYztHyC/KEq721olO0fIq81CSL2ghkrdEme9p4g0hHAscRnU/d35nIpZXEXAnU9mSI=
X-Received: by 2002:a05:6102:5e91:b0:466:b3a9:ec56 with SMTP id
 ij17-20020a0561025e9100b00466b3a9ec56mr701048vsb.47.1703228814332; Thu, 21
 Dec 2023 23:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <CAFA6WYON2Rx8zb=An7agmeNu1mJk=UKQuZqjZ4fbtH2xD+8uFg@mail.gmail.com>
 <55e63d4d-22cd-43be-8e30-cc02e2941542@linaro.org>
In-Reply-To: <55e63d4d-22cd-43be-8e30-cc02e2941542@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 22 Dec 2023 12:36:43 +0530
Message-ID: <CAFA6WYMqgn8hBnjcT07djiVQmANs7OvXyO75d5H612uSUcyKEg@mail.gmail.com>
Subject: Re: [PATCH v2 00/32] Qualcomm generic board support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

On Thu, 21 Dec 2023 at 21:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 20/12/2023 13:07, Sumit Garg wrote:
> > Hi Caleb,
>
> Hi Sumit,
>
> [...]
>
> >>
> >> == Upstream DT ==
> >>
> >> All Qualcomm boards have had their devicetree files replaced with the
> >> upstream versions. Previous patch series made the necessary driver
> >> adjustments to fully support the upstream DT format. All future
> >> Qualcomm boards should use upstream DTS by default.
> >>
> >> Once Sumit's work to import dt-rebasing has been merged, we will drop
> >> the imported DT and bindings again.
> >
> > Since there is consensus building in the U-Boot community to use DT
> > rebasing subtree, I would suggest you rebase your work on top of [1].
> > You can take an amlogic SoC patch [2] as a reference and see
> > corresponding value-add. I don't see the point of unnecessary churn if
> > there is consensus we agree upon.
>
>
> I designed this so that we can just delete the imported stuff once the
> dt-rebasing series is merged. Importing a few files and deleting them
> later is not really a big deal, so please let's not block fixing
> Qualcomm support on this tangentially related series.

Fair enough, I think I can live with that for the time being. Let me
give this series a spin on QCS404.

-Sumit

>
> Thanks,
>
> >
> > [1] https://lore.kernel.org/all/20231214135103.1606605-1-sumit.garg@linaro.org/
> > [2] https://lore.kernel.org/all/20231214135103.1606605-8-sumit.garg@linaro.org/
> >
> >>
>
> --
> // Caleb (they/them)
