Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1A488AE5;
	Thu,  8 Aug 2024 12:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XW4BvLca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A677288AE8; Thu,  8 Aug 2024 12:44:56 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B323886A6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d25b5b6b0so663824b3a.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723113893; x=1723718693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fk573JI10tQUZV+dCUuFCuu/1zJE8+0okyZ1EFbMboc=;
 b=XW4BvLcaWXPsXx8KAeeGKWpa7q4PnAEwvnzYZbRRhfMBNUUO8EGss1Ox5+ZgS99mUR
 zOi0mtA9Lk+NzypOPpBPa13W46kQ6DcTA002s4lP679VtyXuGaXDQRv2ePADZbQUa4/G
 C1P/zqM3W5Y7kCe93DcYEPA+0cCV+aOobfYoxnXtbDypiq+6VdzYc5QeES2gZpxkZQUp
 3e5EktcDx/sf6azHiS1rWOgfxRRqCSoF4nUO4ZWiiwLrU6HnIsx/2U4mnbpkxJIsof+o
 gVLSb8511L3YwUytNTP8F4KBC+icywD1WYzOWB0WVpgAsbyhozuTdxDqmrQaXm8hf0lZ
 WHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723113893; x=1723718693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fk573JI10tQUZV+dCUuFCuu/1zJE8+0okyZ1EFbMboc=;
 b=BINbeY72K/ZgpHCpsmoCrSqe4uC6z3um/I8RyFB58RuP6p35N14JrXBwpIMOFhHsXb
 TyRxUHZrCxOfgBWZo/rwWijCCUemtp/vrJQ95CiFB5A4N2FwatPvUIDUNArylBFO0zUM
 scTsc6tAXi8juaKuKMdEQiE5CQ0YfMsUFNiN/W958T9Q4gEzdWk6twJ9LR8ZcUdpRS5e
 n8lqAIWrcmI+qURa0ia/6eAUTekxqZcme1ulojuEN29kpnzTtVMNCt1dVzKPH0m+wJHx
 nsyvSzzfRpxqOe6G0FWuxLloMpqFBfbtmBdouo361gD+Ixd74iFYnPjJqce6Qq+JU6tm
 VN1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdOh7Mb4Ijbp8/w2IH9S+5nSvR5rq3AmHIqRIDVmboU/eiuYdQgI3Z3rxogj+qdjpKUcue8Qqk48YNlxB1rCU/C0cxyQ==
X-Gm-Message-State: AOJu0Yy9t8eOi6gCOG8ov6VMPFIs0FH2e6ajOHgvUY81691eS3HyaDPE
 SRupFhYwlCvnNOiq2dI+xA8JjyhkKgxisuLEE+juZD4ngdY9PmL+hvO+ug7IwYPou4uuwaGnX1t
 LlTcvb20wij17V1rhg1DQGlfLDXk6HwyeG5Z9cvNvOuJK5c71
X-Google-Smtp-Source: AGHT+IHGnrUCxCMu0Y44cSJBWkuDTFZeJ28l4ZFWB2V1h+clIybG9UD/Q8mnjFU4tepjmk2Bo9im8TjxXxMSSRazzis=
X-Received: by 2002:a05:6a00:2d06:b0:70a:fb91:66d7 with SMTP id
 d2e1a72fcca58-710cae39f38mr1887328b3a.20.1723113892788; Thu, 08 Aug 2024
 03:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240807130010.407399-1-ilias.apalodimas@linaro.org>
 <f12c4ec1-e2b9-44c4-987d-c1bffb47da1b@gmx.de>
In-Reply-To: <f12c4ec1-e2b9-44c4-987d-c1bffb47da1b@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:44:06 +0300
Message-ID: <CAC_iWjKowaeEALeJO0nSBAbxuja+-i5qP3zpnk6kLpJoM3AeMw@mail.gmail.com>
Subject: Re: [PATCH] configs: enable efidebug and EFI http boot on QEMU aarch64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Anton.Antonov@arm.com, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich

On Wed, 7 Aug 2024 at 16:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.08.24 15:00, Ilias Apalodimas wrote:
> > EFI HTTP is a useful option to have by default and is working reliably on
> > QEMU. Let's enable it by default, since we have no size limitations.
> > While at it enable 'efidebug' as well, which is currently needed to
> > configure the EFI HTTP boot options.
>
> Should this be added to the efconfig command in future?

Yes, absolutely. I'll see what I can do about it

>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Thanks!
/Ilias
>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   configs/qemu_arm64_defconfig | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> > index 7e166f439087..088ba39f18e1 100644
> > --- a/configs/qemu_arm64_defconfig
> > +++ b/configs/qemu_arm64_defconfig
> > @@ -33,6 +33,7 @@ CONFIG_CMD_NVEDIT_EFI=y
> >   CONFIG_CMD_DFU=y
> >   CONFIG_CMD_MTD=y
> >   CONFIG_CMD_PCI=y
> > +CONFIG_CMD_EFIDEBUG=y
> >   CONFIG_CMD_TPM=y
> >   CONFIG_CMD_MTDPARTS=y
> >   CONFIG_ENV_IS_IN_FLASH=y
> > @@ -68,3 +69,4 @@ CONFIG_USB_EHCI_HCD=y
> >   CONFIG_USB_EHCI_PCI=y
> >   CONFIG_SEMIHOSTING=y
> >   CONFIG_TPM=y
> > +CONFIG_EFI_HTTP_BOOT=y
>
