Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C073BC369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 21:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C19F8309E;
	Thu, 17 Apr 2025 23:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FmPJ/cgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F8E830B4; Thu, 17 Apr 2025 23:40:14 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6640982F5E
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 23:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso4214616a12.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744926012; x=1745530812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6xT5JwVzMMe3SkamctXHXS0vThRsFNR7o1RkZf4Yr0A=;
 b=FmPJ/cggUCAqXzodPjVuk30N6jMA7abReF/zpuxwrM0ZW4gLE+M0O0FobbHZalJOvG
 CSHhoD9CzUuGWEVo0fATMnrhjOLYigfQM0OzP/PvnfoDIqKh7hufxclY6GV1i5fe+OgM
 a/OFWBl/jMB2vpnu6jJPWVImtxF/0oep8/+ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744926012; x=1745530812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6xT5JwVzMMe3SkamctXHXS0vThRsFNR7o1RkZf4Yr0A=;
 b=V3/7wzix82/X5Z5NDbQTmMp68HhgJJCfYyApfHPORQs8qBowl3egPhg9XjW+EL7wEI
 60lM6nauCaLZBxMH8J8yOpNw5jBSrCYqhUXKJh8BDsFlSdT6tvYF2szj/k7fOPZ5iGyE
 gzS7w3p2AAEw8S8MBDGSl9skVtRGcVnTqG3HTle/PqY/HtS47CXbwt1KzmP4/850XYEn
 /PyG1TVux+e2IUQFo1RHWXYgfDTBQWzVDfuXXN7oeFMbx5SAFodoEsgSW6LbHIavw+/k
 LlLsJADWcgIDMTmGmJ4/8TcpP9PgP62hgc9KB2jBnEV+4R0E41Fip1JcIA/LyZNfXRHR
 zt7g==
X-Gm-Message-State: AOJu0YzXbXmNVpRQmbY8hMX+Zz/L/X1TGmJoS72O8+kImhOQLJJseiiy
 xQIxGzBH6W4iMBLO+p84BGxQ/Z7pScDTaFNq7Ufk8Fr+4gaN5ezwVknUXWMzDVJ9S5gZ6B+c22j
 83AMaqef9OB75RLvtwKEBchQuGFQmNQaZBQJH
X-Gm-Gg: ASbGncsl7n5oKyHj7iumwCWJJoH02FNVWahJfR7uH92gCaD17x4AaHQIaNpiXM6Ti0j
 EZLuWZi+vIr2N7B7D1Ng3TXCbxLpEPaQLC3WkUVV/cyF9V8+ueq0xp0TD6Mof9BTSE/0hlXWGdw
 Cpp0VMFWk9P6bgXPlROW24z2BNhStuZunddA==
X-Google-Smtp-Source: AGHT+IGU593Niqgf/7U2m/6Mxu68MtI0zsM7b0CGhd8kmsyiyVozK38Izao/N8JPjafGqaKGYHlxSuTkLi2D8rkY8fc=
X-Received: by 2002:a17:907:db02:b0:acb:1fe5:434a with SMTP id
 a640c23a62f3a-acb6eca5b11mr148599066b.14.1744926011861; Thu, 17 Apr 2025
 14:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250405190711.365419-1-sjg@chromium.org>
 <20250414225307.GH5495@bill-the-cat>
In-Reply-To: <20250414225307.GH5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 15:39:57 -0600
X-Gm-Features: ATxdqUHYorwFAb-InK3jZMKlqNo7809ecWexBeIvMioNr03VORnkNd3KLUAZ-80
Message-ID: <CAFLszTj82Lw+anq9U5uQOFO7SmfqLpuVAc+1af1s4i2emkau7w@mail.gmail.com>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

On Mon, 14 Apr 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:
>
> > At present it is impossible to change the qemu_arm64 defconfig to
> > obtain a devicetree from the U-Boot build.
> >
> > This is necessary for FIT validation, for example, where the signature
> > node must be compiled into U-Boot.
> >
> > A proposed change to QEMU to allow device tree additions has been
> > blocked for several years. The only known workaround is to use QEMU's
> > dumpdtb option, merge in the signature node manually, disable
> > OF_HAS_PRIOR_STAGE and then start QEMU with special arguments. This is
> > complicated enough that it is documented in U-Boot[1].
>
> This paragraph and then
>
> [snip]
> > +       Note: this work-around is necessary since Linaro has blocked
> > +       addition of a feature to support additions to the QEMU devicetree:
>
> This part of the help are overly antagonistic.
>
> [snip]
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 2e88d210bb8..53f7e246a80 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -205,8 +205,13 @@ config OF_HAS_PRIOR_STAGE
> >         development purposes, but it is not recommended, and likely will not
> >         even work, for production systems.
> >
> > -       Note: This option must be set in Kconfig and cannot be enabled or
> > -       disabled in the board's defconfig file.
> > +       Note: This option can be disabled for QEMU usiing QEMU_MANUAL_DTB thus
> > +       allowing QEMU to support FIT validation, where the devicetree must
> > +       include a public key.
> > +
> > +       See also this for context:
> > +
> > +       https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
>
> And we don't need more wording here. The QEMU_MANUAL_DTB option itself
> is enough.

I believe what I said is true, Ilias' comments to the contrary
notwithstanding. If I were trying to be antagonistic I would perhaps
express my views in a different manner.

Perhaps we should discuss whether Linaro should have maintainship on
these important projects? U-Boot depends on QEMU and for it to block
that patch is really not that good. It just makes things hard for
open-source firmware.

As you've seen, I've added this patch into my standard-passage series,
which was dropped several years ago.

Regards,
Simon
