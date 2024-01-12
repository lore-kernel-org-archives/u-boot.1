Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34CBC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0F20879D3;
	Fri, 12 Jan 2024 16:35:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d2pmF7wP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AA3879E6; Fri, 12 Jan 2024 16:35:31 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F3F879C3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9b51093a0so5783472b3a.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705073727; x=1705678527; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gGgj330Lfa8T6D3C/aBJweU9zqG5wl1k6ZXIWiqOVrk=;
 b=d2pmF7wPVBFqR3SXYFdSK8YVMY2QoueWniJ+j7cl5ivUyWWg8OMStPyvFc6ormkszH
 XyadgElEg1lCvOaSvv/f1URG9+ojxGgMHbHIghDrCVmUb1pUMoOIBx9XcVHvkpb1Q9Qi
 OIZhd35L1g40bKDWv4kFV0k6+DBNPAdKirDj/iJBUSaduMCYh9u/0HcMK+ccqo/QK8sq
 z/YtQbEYZisWvofeHE3KgiAWwUMdAyvLZ2JcCgmQYK/k5oyLk5r6EFml+3L5AmX5CfOz
 8979OovxRnahfT7WgoZ524bfMF8AKkyAWavHd+iwwFZwInZ85zx3nz5Qw1RM5BJjxaD4
 rV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705073727; x=1705678527;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGgj330Lfa8T6D3C/aBJweU9zqG5wl1k6ZXIWiqOVrk=;
 b=cglBeesiNzMpOMA3TjwslR/KeZO5J/VW1ZiFA5QCumK8pI7W7zRsmmk7H372liJHws
 Mexy7bjezc0jkxu5wXze7hTG3t305hL0vM5Rj8JAfZtJZVNZ/8+rPr+oClV1ejoirUpy
 uzDexWM7j8Nwa3fCTW7W+UDT7D/8xDlxZBvDWw/nBq94eIaA/b5U/333hEXfXMyey3LX
 Wp8vorYVaE1HufKclZ9wKYT9c46Ouwp24Hgy3Bz9saqJF689X29XzUHG6nhp+eyI/crE
 2iUIASZwWxmniUEDhH/rX4v8/gQ8Wc+nJrivw6CSMs3bG/R8NzsqJBABEKAOpwSqiMbK
 S2dg==
X-Gm-Message-State: AOJu0YyhdHKescy1khxxFZWZGgSAjb615hhecadtAeLArzm1sNBQR6FS
 LpiFvH4UyTr/+JJFr5H62DLbVP9hmWzUXqya/YeCyZOfkYtaLA==
X-Google-Smtp-Source: AGHT+IEkF+Em17XldMSBX4AykY3HHSDPQSqdg10p28Dj9xL6mD0+RNPq9o9iPmcjU4A4Piip6FX4+6Hp0EeFC7xjY5Y=
X-Received: by 2002:a05:6a21:a599:b0:19a:3eae:6875 with SMTP id
 gd25-20020a056a21a59900b0019a3eae6875mr1420336pzc.15.1705073727342; Fri, 12
 Jan 2024 07:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-9-raymond.mao@linaro.org>
 <CAC_iWjL9zbNWDFk4x=Q3=PVe-zjv441Y52-npjWYW3Pni8PKLg@mail.gmail.com>
In-Reply-To: <CAC_iWjL9zbNWDFk4x=Q3=PVe-zjv441Y52-npjWYW3Pni8PKLg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 12 Jan 2024 10:35:16 -0500
Message-ID: <CAEfUkU+-0fWkTzt8AY4KM4tae83VYF0yoaC770riPMbZ9X4_uA@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] fdt: update the document and Kconfig description
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Wed, 10 Jan 2024 at 09:12, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> I think this isn't needed anymore after
>
> https://lore.kernel.org/u-boot/CAC_iWjJ6=NjqwcFzVvV4DzMWy5nY_QAeD=vfQrRSjodLbVqroQ@mail.gmail.com/
>
> I think Simon's patch is missing the description on OF_BOARD, a FDT from
the previous stage via transfer list
depends on both  OF_BOARD and BLOBLIST.
And also I think we need to describe about the arch-specific function here,
in case that other arches want to
follow the same FW handoff spec in the future.

[...]

Regards,
Raymond
