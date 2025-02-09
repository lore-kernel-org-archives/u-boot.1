Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F49C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D908880B9F;
	Sun,  9 Feb 2025 22:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FtPzRIOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73803807FE; Sun,  9 Feb 2025 21:16:10 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA9B80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de4f4b0e31so3731883a12.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739132167; x=1739736967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=96tI3crTh0y1mQab4C+zY+96jXP7+J8PzFkqE7D9mNI=;
 b=FtPzRIOvrz4NUAxAW9fO6EA/SqbOFhF/fgbO7DW0SZQqXGR7tfIFkdh6KMvnz4/sS2
 76FCpp9sC9YgQOXx7uvybtjR2mBac6tw97WtBcQc5zTmJGagBBmne5u1scAmjTsU9LE8
 5+wgrEfd4e8zuM9KA951WYTBQe2mmuRaWMvSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739132167; x=1739736967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96tI3crTh0y1mQab4C+zY+96jXP7+J8PzFkqE7D9mNI=;
 b=MDq2/FH/zv4djfLK89FWki55bZgIH9y2seL3LqnEuBPWMPkVy7cQxxBhv3w/csRyig
 pBHW2tiUD0Dfq8utmyOzajrX1HL/EGN2A148EoNMt9k69kg7MSbIk//TCrOFAPkgfNka
 F9T1Dv5PX7mO5qwvWX+C4T4CiBmAxjk3kXjANcEO0297/WI7X5xvQqMacV1QqGlsqpgN
 8usArQ2rdNJB89M+lGRgieeOQnNdLZpPcdHNoEtgJQeOiiqAFCGEU8NIjUQc6306qcGU
 rL5eMjsuF8s8owLGyHQmplCWrKt5NBfZn7epcjE8oic+aQaWxK2Esk/6if7WTDdw5scO
 NjiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZC/n2sL4sAcftlLt9dyTggYDLsxw7LkGlggwJQEL2/rEgeLLRW+7u5OUexB1taeMUktAmeVA=@lists.denx.de
X-Gm-Message-State: AOJu0YwOCRf18amCdHZeCjX5LlaTRwRb22+lMSANRZy+TYGPNzAGYoIS
 pWKllDC+h4NUDvqFzrSND/K9s0JKqTc5bnOMfKhUED2lDV14dStX4QeiYko+dn2PEObR0L0hcm2
 enq0nNcK3NaAaNKQXd5J8ehR67oj+t5AN+el7
X-Gm-Gg: ASbGnctZpudJI9hZjRK726q/XaykyoEb3cS5wq+L6BCPhC4mvRcy5qXNf9tuxVCKVj5
 9EoJa5SYL8tGmq45nRpdK9ouJU+vg1yVzWMGuuGPujzPkrwOQL4luXlPVGxCH0Ku1GCGNsefX6w
 ==
X-Google-Smtp-Source: AGHT+IHD5N772xueYQqdNRdRvkSVLDXsJlpbGzfbo0VeR6IVW7KfV+pEmt2qc21NJwbsWIdDyIeTKSBhg7hyLieKnCE=
X-Received: by 2002:a05:6402:1ec4:b0:5d0:f9f1:cd73 with SMTP id
 4fb4d7f45d1cf-5de450129f7mr14296653a12.13.1739132167189; Sun, 09 Feb 2025
 12:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
 <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
 <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
 <20250209163934.GM1233568@bill-the-cat>
In-Reply-To: <20250209163934.GM1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 13:15:53 -0700
X-Gm-Features: AWEUYZlvq_Y5j2j4fyOb763iMfbiMP52_aNvdkttg73e_lRF6_6FTTZJiPDNm2A
Message-ID: <CAFLszTj9zHTcvqoTGznB5WkWRoeBZ9EznVVAb1x7-OoOmYGu9A@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Joshua Watt <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 09 Feb 2025 22:36:48 +0100
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

On Sun, 9 Feb 2025 at 09:39, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 06, 2025 at 08:47:47AM -0700, Simon Glass wrote:
>
> [snip]
> > Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
> > way you want to go, I'd be happy to do a precursor series to deal with
> > the fallout.
>
> I'm not sure what EFI_LOADER has to do with the generic security feature
> of enforcing permissions on pages. That's something we want everywhere
> that can enable it as it's a good defensive security measure and also
> catches code bugs.

Yes, it's a good thing to have. I assumed it was related to EFI
because of all the mention of EFI, SetVirtualAddressMap() and the
like.

It doesn't have to be DM. I was reacting to the idea that we cannot
add it to the CPU driver because hardly any boards have one. How about
mapping arch-specific stuff to generic functions, like we try to do
with the CPU uclass. The enforcement happens before initr_dm()
although I suppose it could be moved later, or a CPU driver could be
started up before relocation. Or just don't use a CPU driver, use
something else.

WIth all the pain I've just been through with the EFI link scripts, I
would have rather seen some effort to follow the existing convention,
e.g. text_start rather than start_text. We already have
__image_copy_start - there is so much arch-specific variability here
already.

Anyway, I'll stay away from this series in future.

Regards,
Simon
