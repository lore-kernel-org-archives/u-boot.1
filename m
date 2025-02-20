Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0673C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE3F80F7D;
	Thu, 20 Feb 2025 14:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I4cicIDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F16A80C98; Thu, 20 Feb 2025 10:22:49 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE28880017
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso1114091f8f.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 01:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043366; x=1740648166; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=97LrAiYUzrTFbS5/ASdxD6WK3rMami0s/6BKnv7IPMM=;
 b=I4cicIDhXmPHwhwheaPBQsqLZQikcpsQR5M20jiTBY1aZ8K2fVXHpahVKWN4D8pcZt
 vDb2xg/LM8Y038239mzGD9comWLDBtz8AqCsmA8WduWDt7RaoOhBtPeblEXOJSc5wxNO
 Gj+wjDCS0UFsB/2hw4bx/8dzfEFA52cJAn0UUPv9rlCH8Kpnjt2k06iNpycym6K0Utvo
 xZH+eB9UUYewppkuqWBaYQXkBIVCkWcAiItiT3OdTcvKWYN6luiKA4X0z3HGIMwU8KE+
 naQTyvhJ6gUBN71vhwavb0quN/Fe0b2jBmV2mUZTLxq+m0HExQ0vJr+9+aPzPOK7x3AB
 Aa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043366; x=1740648166;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97LrAiYUzrTFbS5/ASdxD6WK3rMami0s/6BKnv7IPMM=;
 b=ngQ28Z7r35x6r9xtvUYrefTCxbKlGJELKm90JGyHLAQ8s3LwvnUFQbs8EMnNxR5MKq
 O+6FzdJvoFOcfrNPR/NUD4y679UpiaR5SDgsssEGNmX4sMJM0hBRQOkPP3yGf00cEdvK
 6Pe0bYU/y3KFCttfkxhAXrjNwRRp8owNsF+LbYMORd/vz0w4e0GfF+8ycCA88lOvLW+T
 f2qpKe1wJgx7y/aHmzW7ywMX16+P0726NTP13DzcvoNqaKi8PYlPSXJ4cyu8wgWt9+fg
 CJW3nZ2HJKXclA/cTevfoU8oknfqMc8vzIupjwOM/BYvxDOvXNKVJE4QJ9zCyUql4JDB
 kn0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbfbsMEcRrVh0fFBD8TCQRhAQVOaIDoc6MW+qH6xA2KYrwVGeUQ0j8RbAJCM8I7KqXPDhVlsk=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr8OOsHyjJdwXMKtDgWqKLLf7lSD9+cFVCb7sIf7iz2YFGSAwF
 ry0JE6fKD/uxukcUY8L66XMuDA2afuxkOz0k5XrSI5WXOPI51ydeqphGSO6XKoY=
X-Gm-Gg: ASbGnctP+MW9VeQwYkleGyARrw0UWPyRLTirH4w5hlAXu5qwvqBp13GcBAfZ4hEJFDB
 D2xTXkfvNadPmhY3Z0+qKu+jcvzMrU0VoME25uo7p5taGbrQYQsoJeuNhkLmt9763jMrvi+3sCH
 4UlLpTRupM6xO3utn4xCx+aSqrOBcy8fBRxJ7AuiZzXhqDbl/XEr9dODgZRSOMG1dmWIX3mk21K
 pl/Yok2HFkNmHiQ4wS74WDtT+B02QpQaW/ejgdJ2sZ+akpe/SQwVw1AS/geFJnf1pu5ElBK7dp6
 rt7GaAMnl6NcLIusnVoxZ1cLrslGd20nA2591VUI58uk6aU=
X-Google-Smtp-Source: AGHT+IFVA5aNkSAocrgfNHOILYdHR90rNZt0TgVdZEwbYXgHUurG4hx+qSO93C+AGUDlGLoT6GwmoA==
X-Received: by 2002:a5d:584a:0:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-38f614991f2mr1922640f8f.6.1740043366321; 
 Thu, 20 Feb 2025 01:22:46 -0800 (PST)
Received: from hera (ppp176092191135.access.hol.gr. [176.92.191.135])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5b40sm20294042f8f.68.2025.02.20.01.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 01:22:45 -0800 (PST)
Date: Thu, 20 Feb 2025 11:22:40 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
Message-ID: <Z7b0YHfFDuFwh_i0@hera>
References: <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
 <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
 <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
 <20250209163934.GM1233568@bill-the-cat>
 <CAFLszTj9zHTcvqoTGznB5WkWRoeBZ9EznVVAb1x7-OoOmYGu9A@mail.gmail.com>
 <93152001-E018-4E2B-BA34-39D961624FAD@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93152001-E018-4E2B-BA34-39D961624FAD@gmx.de>
X-Mailman-Approved-At: Thu, 20 Feb 2025 14:50:09 +0100
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

On Sun, Feb 09, 2025 at 09:27:36PM +0100, Heinrich Schuchardt wrote:
> Am 9. Februar 2025 21:15:53 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi Tom,
> >
> >On Sun, 9 Feb 2025 at 09:39, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Feb 06, 2025 at 08:47:47AM -0700, Simon Glass wrote:
> >>
> >> [snip]
> >> > Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
> >> > way you want to go, I'd be happy to do a precursor series to deal with
> >> > the fallout.
> >>
> >> I'm not sure what EFI_LOADER has to do with the generic security feature
> >> of enforcing permissions on pages. That's something we want everywhere
> >> that can enable it as it's a good defensive security measure and also
> >> catches code bugs.
> >
> >Yes, it's a good thing to have. I assumed it was related to EFI
> >because of all the mention of EFI, SetVirtualAddressMap() and the
> >like.
> >
> >It doesn't have to be DM. I was reacting to the idea that we cannot
> >add it to the CPU driver because hardly any boards have one. How about
> >mapping arch-specific stuff to generic functions, like we try to do
> >with the CPU uclass. The enforcement happens before initr_dm()
> >although I suppose it could be moved later, or a CPU driver could be
> >started up before relocation. Or just don't use a CPU driver, use
> >something else.
> >
> >WIth all the pain I've just been through with the EFI link scripts, I
> >would have rather seen some effort to follow the existing convention,
> >e.g. text_start rather than start_text. We already have
> >__image_copy_start - there is so much arch-specific variability here
> >already.
>
> Like we did for the EFI linker scripts we should standardize the u-boot binary linker scripts by using a common linker script include.

Yes, I already started this, but due to the efi_runtime complexity I need
to fix that weird split we have for .text_start, .efi_runtime, .text split first.

I have an idea of how we can fix it and link the EFI code in a way that all
relocatable objects of the .efi_runtime are self contained. But I'll send a
v2 as is first and work on the linker scripts afterwards

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
>
> >
> >Anyway, I'll stay away from this series in future.
> >
> >Regards,
> >Simon
>
