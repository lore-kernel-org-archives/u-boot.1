Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBCEC0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D45080C6E;
	Mon, 10 Feb 2025 14:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E58Qw1f1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5639680C5A; Mon, 10 Feb 2025 14:09:11 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0AA280B9F
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f818a980cso19723035ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192945; x=1739797745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IjUGmn3iLhyz2/TnGcn3Gnyg0Rdle7KflmpTJiJ9T14=;
 b=E58Qw1f1l4BRPgIEE9qV+PU8oXBhj1dbdrqhAu4js9VVQjWDHpfjBnd4iMJBvZT1jn
 AJSdkhyImqeqGKs4djhUGwSixpeTEtL4ThLnvSw+z7XIJV9SrbLGfutQ2uKJmMTtBcoj
 irzdOJt5eqEgeXtr1BfUilbb5hUdCf1Lf2hjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192945; x=1739797745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IjUGmn3iLhyz2/TnGcn3Gnyg0Rdle7KflmpTJiJ9T14=;
 b=Y5b8jBhJnjXQ5s3dYzwsezxV3Tk9j4cHFsIi6nSt4T/6rf+QJfZqJXBkjrl/HCLNr6
 cqDgTxQTT83D9X9QK6llYnsHFkkurXQ8v369e+j2P2gZtOT1t14GOwEYtMTIC7IAA8k4
 g860BgU1UPnPbxcL6wiNA8IRFz7fJQ8A132+q0xKzRuMRSoO/KH9MyafLonp4jmagR31
 L/emufeSQ2xGYek61qR04lT+cOQ/LTqs594Nf87hMrALkoHiJ81C0bPZnfP2P2clSSOA
 dkbIbNmdnXve/anpx4CNPN8cvUz/WywPKAnhsaHbIvziOWpFY0vjrLM+4XtPFbBI1fZv
 MWRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNsHy0fbLtuvVD7zJCzp/+/n4Z1SPmXSAJKB9q6UI9wbHkn9uovMTJcz4NOxS7TTaPHOUD7PU=@lists.denx.de
X-Gm-Message-State: AOJu0YxAb9sv0cPZQYjXYlbIeYI2EzEy0BCgwtSVPnIENacqfhHXGPBN
 E+lB4ECWB1rvAfOPNIOcXdzYuMc/cxY43EsQrq1S+syJ7E4zfiL++0oW+FrP5N3TzUV8k/wBYSw
 Q43+TOwz+ZJ5mFwcHhX2onMb3L7QNqMy/Pqxr
X-Gm-Gg: ASbGnctSfKgBXzCzLHqEVVxVhz//+B/xtv3q5C1ok/glBjdK9nSBHs93ADVxbVUlQHs
 lyewNIDLNMXOIfRszUrskW028be7vGobrIut88VtKtJoJveHxzbQMFLnkxXWZMyHhlOR7lilfrg
 ==
X-Google-Smtp-Source: AGHT+IFGtrTMHtz/jj3xcwK7EkTl3uyy53Md1fSQ3ocYUO8/2M/wExeKiS3DYJ2BpkfqrF/quvfkeGsnynRqJnfw5c0=
X-Received: by 2002:a17:902:e9d1:b0:21f:4e7:9b16 with SMTP id
 d9443c01a7336-21f4e6a583bmr191425705ad.1.1739192945088; Mon, 10 Feb 2025
 05:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
 <20250210111830.72055-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250210111830.72055-5-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:08:50 -0700
X-Gm-Features: AWEUYZneYPNXFsf0m4WjU6vnyTICwLQbcNRhKCxjtClMsSHSxqv-lrhixmFZmjM
Message-ID: <CAFLszThq9je_KBA3wxJdBKG8NO_8z+hki8_h5LMqKgOZDVhsEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: don't use a default
 configuration
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Yu-Chien Peter Lin <peter.lin@sifive.com>, E Shattow <e@freeshell.de>, 
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, 
 H Bell <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de
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

On Mon, 10 Feb 2025 at 04:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Booting JH7110 systems with a VisionFive 2 device-tree used to kind of
> work without causing harm to the hardware. But there is no guarantee
> that this will hold true in future. So we should not rely on it.
>
> Before the current patch series booting failed on unsupported boards due
> to the lack of a device-tree in the binman generated default configuration
> when reaching main U-Boot.
>
> By setting the default configuration to non-matching value booting will
> now fail on unsupported boards already in SPL. This allows SPL to
> continue with the next boot source for a possible recovery.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  arch/riscv/dts/starfive-visionfive2-binman.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> index 05787bdb92d..dd0faca6824 100644
> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
> @@ -13,6 +13,19 @@
>  };
>
>  &binman {
> +       itb {
> +               fit {
> +                       configurations {
> +                               /*
> +                                * Do not boot if there is no matching
> +                                * configuration. We can't remove the default
> +                                * here. So use a non-matching value.
> +                                */
> +                               default = "none";

The 'default' is optional [1] but the spec is silent on what happens
when the default is missing. What do you think it should do? Perhaps
we should add a property to define the behaviour?

> +                       };
> +               };
> +       };
> +
>         spl-img {
>                 filename = "spl/u-boot-spl.bin.normal.out";
>
> --
> 2.47.1
>

Regards,
SImon

[1] https://fitspec.osfw.foundation/#id4
