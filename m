Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395EE1099B31
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 17:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC8083F00;
	Fri, 20 Mar 2026 18:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MMRuHlil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D74783FA4; Fri, 20 Mar 2026 18:40:03 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43CC283D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 18:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso340263166b.3
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 10:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028400; cv=none;
 d=google.com; s=arc-20240605;
 b=e+37ng0QKtdy75h79oOCdfsFXBdQq0ZPZA/YmcAawZJGCcqUrosHSxxo8A8WRFExWM
 wzWCq/IwYmru2PjiLvZsNojlL8uOu4LNXymu+f7XLvylBwRNGzLioplbGZfh5CkAGxtO
 vzlD9Gd70yG/FEQhHAFAL5QsR8REGWUGJKlDqKrr9bQSo97AOG5yR9RbG/pB1KdogF4K
 Qg50w+M97KuCjNL2MUOgo8JEdslMZajubgToWT1UqjKJqOFahEkPb5LUU4k/Z1RTp93i
 X5OYPNp8X9qJH2tXi1nhJyyfkJ16jc/lzFhpdwQ2RWQa/CrUUZciPf0S/xrYdY6841H0
 v7wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J2yUA0f1BE8Bgm35+6d/BuxLHdpG2V+aWoyaRcnRzfU=;
 fh=X+TXTfimi8ikLXygKYSNqmXeuVlv5IEYi0IesntAZJo=;
 b=DpUnmWsatJM/FkJbfFmgiaIJj9GmNS35k4e8xcTrPULfcODMWV5Zh8uKmR3fM77F2z
 6+TC9hTPxPd7qOJj+EHZyZ5sGMpskEUjcLXvHRvZGdRxT1QfjkYFvOabKcdOHxeowyXj
 8cYPAnes3qTIB3+hnDWiAru/pk3VN2qRgfjUru1QQOR0sCyLtUCrlQ2Mz1VYYq3A5Kb+
 +PvF6opIDIgvprDgDuaEOwQjMaWu285x6LVPQpODJT/XeBcuv9d96J8xeSL4SgWWmDEw
 kcd2Y3O8blf3BacRkrDtaEABjV/0jE6ZG8K0ahCSd6ftfULp/XF8z2fJ5eoVo83ZgG+J
 wl3Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774028400; x=1774633200; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2yUA0f1BE8Bgm35+6d/BuxLHdpG2V+aWoyaRcnRzfU=;
 b=MMRuHlilZZ3+hkBYnLSbrEd0n6fOoJfPG0UmCv5pwA9lykDMYjl7RuuWo+vYVcCtg8
 yCDREhv5zpxKxM9aubYp8vMnMz1MFwL8XPks5RsaMB+RNjyloJOIlaIbAlwzYt4gOg75
 iPeCaZtYVC7ob/zyzQpdYZg1SZLEdMFV9usJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028400; x=1774633200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2yUA0f1BE8Bgm35+6d/BuxLHdpG2V+aWoyaRcnRzfU=;
 b=o92ztlYkKoBZeIpxiym7Naon5YGy++A/sBglEwfJ+HM/BLG+GDxFt0O8Am7PABL+jY
 qny8mqhZlZPo1uqWISVn/vvaU6yATDfVqVaG/ffdygKNX6n7USOJiCeM6CUt9jRrCCar
 KNNaeWp6NI5gYrpvN03Wf+ceC1MF95qxszyVNnwj6CcwqHlSHP+qk+PQWEaI9eNanZ18
 XiJxCVTdrBIzbghCv/0nMXr+EdbyCqznfd5M1f2Y8xrcOeJ0E/9ygajckJ5HQeWd5/0A
 3i9rdishFj1xqhAry23C6nXCQU5qkCdKmAEj9HI5DDncqVgNw91wv3KR6EuxVsrl+stP
 CfdQ==
X-Gm-Message-State: AOJu0Yzpq6aqIBgDkUHqNdjNQaD0Ama0xC3iMdUZTwg4Bxj3PUyQgVdG
 SpIi+4zz/lLsCsEszT//oSYC6t6O45s1pLjZZfUOyQm78iyrYyWsSDA2w+dtsIRTwRfKbyGgmH7
 GyDGCaMPLFzXIDyeDpXhd/meCQKAwyE8xqZbYX7vD
X-Gm-Gg: ATEYQzwkKKDdPi6QcieFB4ith8EqHRx9oYO9OsL4t482VQcyVryGO3DR74nDjxmMDxx
 s7PAnJ4FSE7mPdEVGbjG7DawlSp+fMj7L0MKvdP2jncfryDzgNjYKAzPyhe/5aew9/BR3tj3ANU
 h70fEem8CXkOVxJ0oQChKeOl1Wd31UVkt79bG8Tx1uyupeGeVOdgli2PrrfqiNwM7x7s+DCwUFV
 lEI+hYJgWsvT55nP7sNB0xsHjXZUX81w+kzdz9Qw/uoTGbrWyGgFI1z9V8WjpP0j6n64oNekFNU
 hVcLfx9e
X-Received: by 2002:a17:907:8709:b0:b93:81e7:845a with SMTP id
 a640c23a62f3a-b982f0c8097mr209344966b.9.1774028399662; Fri, 20 Mar 2026
 10:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260317140621.GX502704@bill-the-cat>
In-Reply-To: <20260317140621.GX502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Mar 2026 11:39:47 -0600
X-Gm-Features: AaiRm516rbQtJFneuuuPFlHp5wu2mu2_q3lu0ZXdJ4N4xLHzCDnhzffLjk02Cfo
Message-ID: <CAFLszTg6uoDfL2OZO5H9+dZDUEV6+3aX2TqV243iGa8EwL_WyA@mail.gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
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

On Tue, 17 Mar 2026 at 08:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > Various updates:
> > - c4 lack signing so does not currently build
> > - samus hardware is non-functional
> > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> > A sample run is here:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> >
> > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > broken on -next
>
> Assuming "play" means beagleplay, it's working fine here. No link
> because I'm still working on merging physical labs to be visible to CI
> in a single job.

Ah yes, the problem is actually later and specific to my board (disk
error). So yes, play is working for me too.

Regards,
Simon
