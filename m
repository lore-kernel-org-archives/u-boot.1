Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD219C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 06:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7045B8786C;
	Wed, 17 Jan 2024 07:42:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XoVtURi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C4E86F80; Wed, 17 Jan 2024 07:42:23 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE49F87776
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 07:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7ce4512cc24so3558346241.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705473737; x=1706078537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/PqDICoC/oTZK189O1ywkYy7cPQt/G/bw9mLW2TEK0=;
 b=XoVtURi6cI9OVMAg3ulPVyE1AROuPX1eu85qmRnVmOJCwl4T9FkXiObXJ0/Pt3rmoV
 WzFTk9p0M4QrrbvHIU+i2+agX/WAwepGI0+y46xmGY/dzOyaND+N6wcbV5oiiCmFpxWo
 dqdGUXX6o/qxZhFcUYAxMdDKCtMEKPQyrLfr9SlNOrtE0BBcoknbYDO5yEawjNAqbrLx
 WJrs2laCyYB8EOv11mdnuAbiwKE0in2Y1AkvfEtWTcVcX6CENDCNRXAyGTX5i3qARp0B
 zAeHVgvqbkvd8Elh/Zn28ZcPZ4thMSHtFl0aSCfVc5BmDtpUykXdcG4wgb/l6Lk2V0fc
 G0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705473737; x=1706078537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/PqDICoC/oTZK189O1ywkYy7cPQt/G/bw9mLW2TEK0=;
 b=cafGIiTi31vnLkDgEhu7++NR9nPKsUEU4tVn0PvovVoQ4cIAFfJrCXCEGDXt1naqTR
 majvVWTgdY4x6CT1dfmPeItxcPn8YJk1fgpmn0WC8lLBO8hFRCba2ZL7s0do87D3fflj
 PVEp+ZTrjyJg/SGAs+jLXLmWQUvqqk0mvEDqYUcMRX2pjwtj66zbVb86J+alBPWY0pVp
 KLgt11YfNLIQNQdB+cmwCB5iu3ci6CBfCR2baAnJ1hgppIwd8DVRbtkyp3w9pPxXd5ls
 YJP+GRH/juNrPrXVIQxSWAuYowibmYF3Kw07CwsTyi0YWOx3e2fTFi8y/K92t3kltvh7
 59+Q==
X-Gm-Message-State: AOJu0YzgtaO3CjoiwF6wCaAMMvjmihMzfZPRDQu9pCdUblogJo+murz/
 JnHmGo7BHkOuckizx40zJrOVF0SNiLIawSHkjLUM17Nx9oTjBA==
X-Google-Smtp-Source: AGHT+IEROoL3F/hubw1i/iCJuF4Wiix2gjkneNc67DNefHZ7c64/fQHFdlFVtW4dmqg1/Z1xlpqj7L/O7KvLIajB5EA=
X-Received: by 2002:a67:fd42:0:b0:469:7f74:b2f3 with SMTP id
 g2-20020a67fd42000000b004697f74b2f3mr510560vsr.0.1705473737457; Tue, 16 Jan
 2024 22:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <CAFA6WYON2Rx8zb=An7agmeNu1mJk=UKQuZqjZ4fbtH2xD+8uFg@mail.gmail.com>
 <55e63d4d-22cd-43be-8e30-cc02e2941542@linaro.org>
 <CAFA6WYMqgn8hBnjcT07djiVQmANs7OvXyO75d5H612uSUcyKEg@mail.gmail.com>
In-Reply-To: <CAFA6WYMqgn8hBnjcT07djiVQmANs7OvXyO75d5H612uSUcyKEg@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 17 Jan 2024 12:12:05 +0530
Message-ID: <CAFA6WYNsd8VfYZUuYuS7GDxq2XB4dwWwqz3qNLLYZfuWVgTTsg@mail.gmail.com>
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

On Fri, 22 Dec 2023 at 12:36, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 21 Dec 2023 at 21:08, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >
> >
> >
> > On 20/12/2023 13:07, Sumit Garg wrote:
> > > Hi Caleb,
> >
> > Hi Sumit,
> >
> > [...]
> >
> > >>
> > >> == Upstream DT ==
> > >>
> > >> All Qualcomm boards have had their devicetree files replaced with the
> > >> upstream versions. Previous patch series made the necessary driver
> > >> adjustments to fully support the upstream DT format. All future
> > >> Qualcomm boards should use upstream DTS by default.
> > >>
> > >> Once Sumit's work to import dt-rebasing has been merged, we will drop
> > >> the imported DT and bindings again.
> > >
> > > Since there is consensus building in the U-Boot community to use DT
> > > rebasing subtree, I would suggest you rebase your work on top of [1].
> > > You can take an amlogic SoC patch [2] as a reference and see
> > > corresponding value-add. I don't see the point of unnecessary churn if
> > > there is consensus we agree upon.
> >
> >
> > I designed this so that we can just delete the imported stuff once the
> > dt-rebasing series is merged. Importing a few files and deleting them
> > later is not really a big deal, so please let's not block fixing
> > Qualcomm support on this tangentially related series.
>
> Fair enough, I think I can live with that for the time being. Let me
> give this series a spin on QCS404.

Just to update here, this series doesn't boot on QCS404. Internally I
am working with Caleb to fix issues seen. One of the major issues was
to not map reserved memory ranges in U-Boot as mapping then leads to a
hang on QCS404 (see [1] for details).

[1] https://github.com/u-boot/u-boot/commit/881338a0c6686bbcf043275714d43080b746b17e

-Sumit

>
> >
> > Thanks,
> >
> > >
> > > [1] https://lore.kernel.org/all/20231214135103.1606605-1-sumit.garg@linaro.org/
> > > [2] https://lore.kernel.org/all/20231214135103.1606605-8-sumit.garg@linaro.org/
> > >
> > >>
> >
> > --
> > // Caleb (they/them)
