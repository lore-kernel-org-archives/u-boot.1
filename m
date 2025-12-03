Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40D6D12D6A
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 20:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF2183BFE;
	Wed,  3 Dec 2025 21:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ExI7Viy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36A8C83C08; Wed,  3 Dec 2025 21:33:02 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AAE683B6C
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 21:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-bc2abdcfc6fso89351a12.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 12:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764793978; x=1765398778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFKTIjZrKbxp21XYUoIG59ehcYt1GN8tVWUTOnRo0BI=;
 b=ExI7Viy4sglVQKWIrkZSivQPn/ljKEPoCwOtqbHKQ5ilNK9eE6x37S9437u3uy2fcN
 H7A06Ndn3P08Ih7Uufm0MjVd5/04+2zxE5/VOoD+sFgcoC3SDp8r0CYdks+DkBg/0UaZ
 eGLWc/jA4u/jFL1cT+mHpIl48a0C2FCDR2mJK3MMGWXWnb5BCZfm9VhTebzkVQMyjHNS
 zGVbCKlMgX5uwF1ANgIvmoYzk/u3omBQvI3JEMNAR5wijbVRKjTYeM0IqjrNLDX0Ionb
 rLPi2uXxVMU/EUdQVVG8FCVA7igO9DR6BvDMWsazN52Wr0vSIMIuqlJkP0pHe2PjBLQ3
 NrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764793978; x=1765398778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFKTIjZrKbxp21XYUoIG59ehcYt1GN8tVWUTOnRo0BI=;
 b=Ks3Ke1NEHO2cJJ70tUSiBkqvc01nm+kaGBjuFslNUAhA2SHhYYZrHG/tabm7f+UdrA
 wSNFU+vDw4CiN5k5E0ERKSHy8Uo01ZOvTTyi0isKDXMCkWw91Rp0GK3PfGrErwUYwebn
 KTWviwrJeaqFEB21AzrEQjLNBGcJn8Lw0jEOVBljT+E0qPXgLbHASYuB/TCwD0YTtwcS
 zfEABzppB90UKltGOtf3JGFUw3JujK7gj8czVo1Zz5C3do/t/+cR0Bebg7HZhSklA9ib
 u+SAns0jCfF8uhSMrTza5J2YypbqrG4H25Cm2J84AH3dj/SKepF+KTuD62fUEPq9N7Y7
 xn8w==
X-Gm-Message-State: AOJu0YyV3d1IaqWI0f6rnTdhBMpXqGlS+LVMPbOF6maV4mq0cxjKTMgO
 /bKwDJfJWP7orQ2YzOk5f6vlKSRMm99DmReVgltNddggYFjOfmq8t2A39hJeuPq/UDVOuRXPTct
 2Bd3DNcr5sb/5oNIGYCEm75dZa3Bu3wwTjwfCddNC8Q==
X-Gm-Gg: ASbGncvg968clnWcvJKuL7LHWagWLk2lrqb6RAX6yHL1IvcvjeRfWeUgvcK0icuU7Dq
 d8KsOfSVGIdW/XuAQWrcJtoQ/IgWGHDmoI36eg5Ltb+faG18k54RKmtVzPQp061/Sm8krtsFkjX
 C/IhKKCnYaKOloNEG66SK5fWo3QkGSvErhBRMNrQi61pAUQvGQ/31hWfF7Lb0RsVdDoFeiPYFHX
 hUwlaiHKjOK2izvg+9MixHmOjNzRsB0tN0mznq3Pa2F5Dn1Swy8zgf6noKUw03QnZdLnams9A==
X-Google-Smtp-Source: AGHT+IF5TAtSgMMnL8Ry+aXLXXNFyv/CYdPSdbGDnEg7tYmbR+WA4O4tzmZ37f1hmW+icQmjD/1bybtaRey7taFbpjM=
X-Received: by 2002:a05:7300:7aa5:b0:2a4:3593:ddf4 with SMTP id
 5a478bee46e88-2ab92e56558mr1683193eec.33.1764793978326; Wed, 03 Dec 2025
 12:32:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <1046ae695f78304d3e756d2ff3d08aecb0d6ab2e.1764574369.git.jan.kiszka@siemens.com>
In-Reply-To: <1046ae695f78304d3e756d2ff3d08aecb0d6ab2e.1764574369.git.jan.kiszka@siemens.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 3 Dec 2025 15:32:47 -0500
X-Gm-Features: AWmQ_blXf7q3_S_xazN6F123CUXUK2jh9cbhcCTQD6oedxAG1pq1rV01REohawc
Message-ID: <CANp-EDbL8M=PqT0X_vvHSYmi_9ErR_1oeLO_qs9-3JinA-eiFg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] arch: arm: mach-socfpga: Adjust a raw sectors for
 MMC loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 Sune Brian <briansune@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jan,

On Mon, Dec 1, 2025 at 2:33=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:

> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.=
c
> index 28554b7a109..0b04f2bcacf 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -209,3 +210,13 @@ void lmb_arch_add_memory(void)
>         }
>  }
>  #endif
> +
> +#if (defined(TARGET_SOCFPGA_ARRIA10) || defined(TARGET_SOCFPGA_GEN5)) &&=
 \
> +    defined(CONFIG_XPL_BUILD)

This seems to be missing two CONFIG_ prefixes:

#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) ||
defined(CONFIG_TARGET_SOCFPGA_GEN5)) &&

Regards,
Ralph
