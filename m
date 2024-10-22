Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB9BD2C54E
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252C288FD6;
	Tue, 22 Oct 2024 15:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZjqBjeUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B2AC88D97; Tue, 22 Oct 2024 14:15:50 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACC188ECB
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so3643824e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729599345; x=1730204145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pNTFFiDhvjS02pYi2E36x2cwn0ld7G4zNAPfrwiz67k=;
 b=ZjqBjeUGCkQCCeBur727rK3chxx9W2sh9XO6RD7v/Ui8PAXB7v+gcJHWORnecMIiIR
 PBSvyn9Z+t2UNNbM9MLEOUGzqDFc2OIEtC2SmNq2k4u06u72LPJ/wsf65Nxu/O4UDLrR
 02355orMt7R7O9XQzCVV0X9uSFV5xVEKrtOHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729599345; x=1730204145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNTFFiDhvjS02pYi2E36x2cwn0ld7G4zNAPfrwiz67k=;
 b=XqhvUc6bDACdahicf28r6tGPtwIh+3dhfj7aWhiT6dASa2s4wvhLytCyORWQvNgfvV
 jRW5YiyGUhhfvn+1lhKjmg/G6nNyRrCn1JWYo+Xr1gHGCmpQOz9Xj2xfE/i2w3rRq/dU
 GgaaJtqZoYQKV6KEatmWvWOSvLUKUsaQlAS9kJ9Csp+p9J6lKSyGVJ62ES2R1HsKulf0
 fG3n4ITV0yp9zkBtxEsWRWqQtuy4jl12FAzf9C9tiSDsxtfQgBWNNfVA7YUBhrK/LuOf
 zlS4ye2CinVy2pVqiSXtBmJGrxW1f2mBrZxie4AtgeBnlqSw8DXrY0uNXjhMvePyeafQ
 VEAg==
X-Gm-Message-State: AOJu0Yx8jvkkTLL5ZtW8rMDInccauG3WOyIjYqp1sDzhSmi5ybxkTthL
 4rpBC3h6Z9/HLJRpN2yzOVfKElNvsTvTZtctRJNHvnBh4eQ1O6MAUwVmoYcgEffOBs8tWSsvSZP
 5sRMBKCnCoz3D5/4yC6wFhpPLA9dn0PJ0+KuyrLfDI8gvGk8vnJ9M
X-Google-Smtp-Source: AGHT+IEQOf5Uth+EbYU6C8n0FmGmq35lcVLjqELZ6jNADa/5wekxFkyQcP1MpfN9icNtCardmm2IB4CXjRqc0Cai5c0=
X-Received: by 2002:a05:6512:39cc:b0:539:e436:f1cc with SMTP id
 2adb3069b0e04-53a1546cc59mr8133444e87.52.1729599345254; Tue, 22 Oct 2024
 05:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
In-Reply-To: <20241021172613.GN4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 14:15:34 +0200
Message-ID: <CAFLszTguu7hRpsSLxADsBkMgTzA_-fAR0t8Axv+8=OvxJvSRCw@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, 
 Artur Rojek <artur@conclusive.pl>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Charles Hardin <ckhardin@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jens Scharsig <esw@bus-elektronik.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Sam Edwards <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 22 Oct 2024 15:18:38 +0200
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

On Mon, 21 Oct 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > There has been an LED framework in U-Boot which uses driver model for
> > about 9 years now. Recent work is underway to improve it and provide
> > more features. It is probably a good time to drop the old code, which
> > is only used by 5 boards:
> >
> >    ./tools/qconfig.py -f LED_STATUS
> >    5 matches
> >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> >    socfpga_vining_fpga
> >
> > This series attempts that.
> >
> > Changes in v2:
> > - Combine code-removal and defconfig changes
> > - Add a patch to enable LED and LED_BOOT for these boards
> > - Add a patch to enable LED and LED_BOOT for these boards
> > - Enable LED on the 5 affected platforms
> > - Reorder patches for bisectability
>
> So I believe this means you missed the feedback of just doing the blind
> migration rather than disabling the feature, like we used to often do
> for cases where it's just a matter of changing CONFIG options. It
> should:
> - Not introduce a failure to build
> - Just work on platforms with either OF_UPSTREAM or semi-recent device
>   trees
> - Just start working on those platforms when they do move to
>   OF_UPSTREAM.

Perhaps I didn't understand what you were saying. I thought you meant
to enable LED and LED_BOOT on these 5 boards?

Regards,
Simon
