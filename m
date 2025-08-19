Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7DDCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 15:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1C4809A5;
	Tue, 19 Aug 2025 17:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NTBI6S2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1887B80FA1; Tue, 19 Aug 2025 17:33:22 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D30B802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 17:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6188b5f620dso6058270a12.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 08:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755617599; x=1756222399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PriZIRLDaJlPSNbLotvDQOgIVJfQqdNVzfybxePtctw=;
 b=NTBI6S2CaFzv3fRMC0dkGxXH06s+9BcKUHd+iNYHHy5P3vzijMhOqtQWH7KLxTS6zh
 7GDoZWcFbp8YY0c/I8qVcBkhdJFy3OlT0Jt2cZekQM5wFHgV2kqH0JK9ygt0XCcaxU1Z
 Lru4YD3GgYW0X93/mDvDd9aAU6ouycTNinb2+Y/Fuwotp4yJ+wSukqlMyJyEG2ZKscgK
 c3JQYF6WtiaHXA5oUPUx9OHWQzRIQ/06QphixPsYfWUwf6gJYaxuWGt3XLMgSfeeeLQq
 8a/xMKha4N1UgxiPbN/ztQGn6EPmmafAw2I6XI4nNOttSDCgjnA/qBPlKhiqqFoNbmid
 +emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755617599; x=1756222399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PriZIRLDaJlPSNbLotvDQOgIVJfQqdNVzfybxePtctw=;
 b=Nlsl4tp4bSFJtYXN7HKijE1seKRlAbpnCq6dAr2YLHt3toJBPo9w+FAfNDsaFDj8Jg
 gizkx5lMUYQTmeSrWz9Np3PkmlkrLpFZj9wbTnn9LOJ5eFqBhHSX1Phc9KBiRYnzgMNv
 +quUWvi3wspiMygWNbMh3I29FtXfE1ygwMaP4t0Bn7cEet9iETIEwYRxo1sQwq2ptqQO
 GGNSdLiS5ngs1A/Ko8NxYVQ5YuC3NDORQTgskamHBgHOKc3Pc4jocTy265gEEjm39nya
 XcK0FmS21lfJkwcpa8FKq16Gee0hpTzghW7uHGay1d0nvuuRsdMcPiq6cipCDh41wZ6u
 EJHg==
X-Gm-Message-State: AOJu0YzQpUWW2p/cxGJVbrfb5NQQJVMxqABNzOkBltzglvFWMmDZoQFo
 /UKiXEGowIKVJESy8BfpUN2ejpSABd+Vooa5RRYMJdrGkPRhfOFmuPrUhM//+TsMHU4lYdtJq1X
 OY4pWLEUSpCzxv8kZlGjBvDtdPDOiA10oEl7+SPHhQA==
X-Gm-Gg: ASbGncv0tkHUGma+F2EFU3Vb0/UCqa+VRrDVpS2PiA+t0F02c9HocOAM1HGdXTEYJkL
 y9DyLDZTmwA0/LHey9uFHWGOXxoOZ+7bDI38ldHv/C20Tg7I6m/djl0fVhoqxm2EgRePMA6rwu6
 +Bu5WVl2m0JWNdc0FsptAT55s4QEvgtFjnxv0VVW+6Yxxoq7NaL4FZSb6yJhqPtYOa70xg9Y++y
 Bdj6w==
X-Google-Smtp-Source: AGHT+IHFlZTS8fVjnPqP7Ff+dzeXfjdcpXa123PPILwjGviXVZMzVz86ud8fxUCZFxo4IjU9F02klywZ15S0frmUBe0=
X-Received: by 2002:a05:6402:42c3:b0:615:a847:c179 with SMTP id
 4fb4d7f45d1cf-61a7e7454d2mr2541411a12.18.1755617599160; Tue, 19 Aug 2025
 08:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250818165119.3193853-1-trini@konsulko.com>
 <CALeDE9PqJBA9gS+YaNjM605fH011wL1SyT8Odk_k2Lm_V9EHLQ@mail.gmail.com>
 <20250819145737.GB124814@bill-the-cat>
In-Reply-To: <20250819145737.GB124814@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 19 Aug 2025 16:33:07 +0100
X-Gm-Features: Ac12FXxEBMklks_SzaVP4jOgp4_JVCKMNBPuO8GK13HZCUYXD_cPsOCiwwONvG4
Message-ID: <CALeDE9PXjSh9kySvOEc-4KDVp7dT+DUUQVYh7JUk2pS+vohe7w@mail.gmail.com>
Subject: Re: [PATCH] boot: Add LEGACY_IMAGE_FORMAT to DISTRO_DEFAULTS
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sascha Silbe <sascha-pgp@silbe.org>
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

On Tue, 19 Aug 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 19, 2025 at 12:13:31PM +0100, Peter Robinson wrote:
> > On Mon, 18 Aug 2025 at 17:51, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > At this time there are still major Linux distributions which by default
> > > boot using LEGACY_IMAGE_FORMAT type scripts. Add this option to
> > > DISTRO_DEFAULTS to ensure these platforms can still boot.
> >
> > What is the legacy image format exactly? Does select make it non
> > optional, can we use imply or similar here?
>
> In this case "legacy image format" is uImage-style images, rather than
> FIT images. And no, we can't imply it because then we'd break Debian
> (which doesn't boot on a handful of platforms now which do have
> DISTRO_DEFAULTS but don't have this).

The distro boot stuff, which if my memory servers, is what the
DISTRO_DEFAULTS is used for, never used the uImage style kernels.
