Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776EECF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158938925C;
	Thu, 19 Sep 2024 16:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AOLkzmAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BCCE8924F; Thu, 19 Sep 2024 16:13:29 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 287368921D
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71971d20a95so694458b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755206; x=1727360006; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E1oBMa9ynpVftwLgwo/P2arziHzgNKc5TmcSzR8Qlhk=;
 b=AOLkzmAB45O3sfvbvSSU5omhkGO9/w/7D1UJtakujtgyYN/NAgKIfUFB2U8eEJtmJu
 UzeUM2Nq1hbDvt8p/ymOgJ4J0f5FXvIpNP9FbelvlaD/0Co133vE8ZM+pi1f8WynVzNf
 5cCMvA6oGj7spI5MDr6r60xfrODyKagr8CCpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755206; x=1727360006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E1oBMa9ynpVftwLgwo/P2arziHzgNKc5TmcSzR8Qlhk=;
 b=uOS9pxvSH6xEJs3HPk0KyCYYqV3cgpQ2JRSNBdGAS9VL02pCHp0aSFoL+VtbW9SxlC
 9Zf5WiYvWhKdpSyj2KEmbk+TwDrZIkh2YEKRGFireMuvknGaIBDHW8CIfhdiWxC09hLz
 SV2Jo7x49Zr+acOF+sr88llBrIuNyfibo/CXNNHJ91FFzVx6pMGUK9tiBw1xp8i0dcQO
 K6m/819M1mbWfsirHjpxPYp+n/tJcBhpYeZ4ymc95LYzWPbOOsZfHJi5DBwfHlb2wxt2
 Cp6LkjBwhZvNXX7PUhPo4Dz/2GUvlRciyF26d2thj/TqpN6mavxCzrtJFw5Y+P8LYqw2
 B+jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGSjJACPFyJ1T56XfGAJ5NckT7E0Yxgm8diLcGfhJ+ll7Dld7iy/LhsDhkDXGSuyuBdt1u+dU=@lists.denx.de
X-Gm-Message-State: AOJu0YzxWZqMVfZ16Am0lO67epipJ1s1emaCbfAzPKW8TMWRKZbhfBYb
 CXfuNgePZFx9XbLCVLmNPBWhboVkxaYiX/RVXTnYdbEHluIaRRQSq4LD8yW587ZjlROZcfifCJj
 st7YRTlDoTdu4pcMVu/tLZYN2i9rsMJfUsVSF
X-Google-Smtp-Source: AGHT+IESLZmMb4o+nfGIEnES8MH6rGW600f/2jlKIQTogvPsL0BguFpIZen25VQtzSWJdHlyB2aTP0Hl2s8m175ZGgw=
X-Received: by 2002:a05:6a00:23c3:b0:70d:3337:7820 with SMTP id
 d2e1a72fcca58-71936a4d269mr32269170b3a.8.1726755205691; Thu, 19 Sep 2024
 07:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240902011825.746421-1-sjg@chromium.org>
 <eb5c045c-194a-4c0c-8617-4833e174db8c@gmx.de>
In-Reply-To: <eb5c045c-194a-4c0c-8617-4833e174db8c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:13:08 +0200
Message-ID: <CAFLszThWLmpfsdEk0JnhDQm+j=Xj8zs01Uu1UTC5Cf8h1QGs7w@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] efi: Add a test for EFI bootmeth
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Fri, 13 Sept 2024 at 15:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 02.09.24 03:18, Simon Glass wrote:
> > The test coverage for the EFI bootmeth is incomplete since it does not
> > actually boot the application.
> >
> > This series creates a simple test for this purpose. It includes a few
> > patches to make this work:
> >
> > - ANSI output from the EFI loader confusing the unit-testing checker
> > - Hang in sandbox virtio due to EFI probing all block devices
> >
> > Other necessary fixes have been split out into two other series.
>
> Hello Simon,
>
> Patches 1 and 2 are in my pull-request for the next branch.
>
> The rest needs to be rebased after considering the review comments.

OK thanks, I will give it another pass.

Regards,
Simon
