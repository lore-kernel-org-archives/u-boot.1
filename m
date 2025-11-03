Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9076CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 09:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A53836D1;
	Mon,  3 Nov 2025 10:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GlNkGuzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A9A83700; Mon,  3 Nov 2025 10:47:17 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B581083642
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 10:47:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640b9c7eab9so1397870a12.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 01:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762163235; x=1762768035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sYUKkDF7RooeRv9AmJmjjuOWeoemH9UV437wLnwmViI=;
 b=GlNkGuznYysAzfzXolYuJM+Fm9UI75gxVrm7JRNGUaqXs6EieELzjq+P0XgX90gwsR
 /LeogP/Fl77ha/6c8xspZW5PhmzeXiJD4iEv2rkITKZGahgn6bJx0vTwTABDjKL+BemJ
 muicFNXthNtNvYqGJGBBJl9l8Gfw41QQUthP0gF+fMLIz8ST7n0ZAAPyGOj6+gqITct4
 HCxAlYgBJKQzb0OBPu92budEeOLT2r9j5GORLfMsifxrEdXCxhMIx57XRu0BOQ6sRlDg
 q4xHueXAQdCu+MR53niwAY8taRsav4YD/22QLCW95dmrRcQupSz7UoNRHWF9qP3HQW0p
 fMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762163235; x=1762768035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYUKkDF7RooeRv9AmJmjjuOWeoemH9UV437wLnwmViI=;
 b=dxqYKtEflz0064BwW5k62s7wE6Jr+DOly0VLV457Y7iQed+Xn/sP+XSH5SkcS5WDsx
 v+/9Ny5JLTj752YuX7ouHROnkb3SS2uWzlXFl8S731GOx0wffYySUcd5TEeQP4qrXxVY
 f6MA9okrZn0Aay8wD5ud7w+uzyVR14NcCHcFumMjJu4gPrcmC609YDso8SDpOTF+qXQb
 TKgnNVScXxglWQNnVWqJf1D8HGko4dkyXyZZZ/IzFzC0BI/eK03psM538MwnnQ2xaCN8
 ikoKv1YkjCnxsOveEmjeRuzSVYL5BEmXaMHd8PkKKicdmdO2VA/64mHjH7BF7J4uKopT
 8QnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSxA/BsTaqNr0sL0S3+/3/HwmZ2eQjaFaVPC+sZtZ3FvMDMDwWjMfWa+t/xJcC07gRmTl5ff0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2udHHLknWVgCCw9H9Zezyb6kkmT9zn4oOzbi17ajRwl/BSajH
 LbXIDy0FIl3Tv1Bk8UkproJZUlxmei8XjOGW5nvWW+cGV9NexHWeLWEnD4/fAjdkk5j8sNaEyPl
 PDMaP09OXHSUYSs5ZcUG9iZ0cHnPSgkQ4/g==
X-Gm-Gg: ASbGncvrsioHVhdW4bEaqvN6ibaruHOAC+HY9R15ivjjUKHbgqpEnNNZrgj6r+7wEyW
 vb5tvph71+Fgcq8WEjKkW1LrjjDpDc/xhoA+K+oVJXipZ+/pufMs2zfJ9hjwbn2K+XY9Z5NTIba
 0f0zscCwckYqJNXYrsR+qz0SbXZyCwhT8RDRNTvstA4mnMxu5ZRvYbhAiEhdDjyKzSMIUF/v5Su
 cD0uLRrqkNak+0lT1uOmcwHuDOd0c1sniDsK74KGgFWhv0+k1gmov8QDXNMNyF5c+HGWL3NNfWe
 t+kw8qtuVMw8xJx2G6voNUvJYeWHB57aZIHDCUjJcvPmiuEfeVS0bVvM0qCeOKo2SzIIMZzlQrO
 qUzLY6CYWFVI5I+fG8H8AzpxepJbP
X-Google-Smtp-Source: AGHT+IG+stbqX/Mles3+Adfy9lwhaW4V0yK227htBtwOqMoRO6gaq7kPyETEgZHnmyflYF3CsJnfD4C5TH53XRZVTTY=
X-Received: by 2002:a05:6402:2102:b0:63c:4da1:9a10 with SMTP id
 4fb4d7f45d1cf-6407704018cmr9844546a12.31.1762163234972; Mon, 03 Nov 2025
 01:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20251102022349.326599-1-kever.yang@rock-chips.com>
 <20251102193015.GH6688@bill-the-cat>
In-Reply-To: <20251102193015.GH6688@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 3 Nov 2025 09:47:03 +0000
X-Gm-Features: AWmQ_bnSv7DMkQWPIctF4bFq1uZnuHZ48tCtdtXf-FPO6RKh89EET1VAL2PtvcU
Message-ID: <CALeDE9MdYjpiqTVbGquzkgtTYGqT0TpZpcBWJr-BVGnA0ddO_g@mail.gmail.com>
Subject: Re: Pull request: u-boot-rockchip-20251101
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

On Sun, 2 Nov 2025 at 19:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 02, 2025 at 10:23:49AM +0800, Kever Yang wrote:
>
> > Hi Tom,
> >
> > Please pull the updates for rockchip platform:
> > - New Boards support:
> >       rk3588: MNT Reform2
> >       rk3528: Radxa ROCK 2A/2F
> >       rk3576: ArmSoM Sige1, Luckfox Omni3576, FriendlyElec NanoPi M5, Radxa ROCK 4D
> >       rk3568: Lunzn FastRhino R66S
> > - Other board level updates.
> >
> >
> > CI:
> > https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/28119
> >
> > Thanks,
> > - Kever
> >
> > The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b17:
> >
> >   Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2025-10-29 07:41:43 -0600)
> >
> > are available in the Git repository at:
> >
> >   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20251101
> >
> > for you to fetch changes up to 498a9756adf57e94af64e31b144a6698c656c50a:
> >
> >   mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528 (2025-11-02 00:29:58 +0800)
> >
>
> First, in general, this is now applied to u-boot/master. Second, in
> specifics, configs/mnt-reform2-rk3588_defconfig enabled
> CONFIG_CMD_USB_MASS_STORAGE however there are dependencies missing which
> means that it's not actually in the build.

I'll take a look and do a follow up. The device was remote testing
with a Fedora user so I'm not sure how good their testing was :)
