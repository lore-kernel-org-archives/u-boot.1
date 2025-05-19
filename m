Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F300C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 11:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E4C781FEE;
	Mon, 19 May 2025 13:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="hFN++a5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE6F82AFC; Mon, 19 May 2025 13:49:48 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0ED281E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 13:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad56e993ae9so178287366b.3
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747655386; x=1748260186;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SK9ss3402S661VRDPQ2wRDIk73djh1jJtWalnXdvjT0=;
 b=hFN++a5GlyLUl0ElDTYHWUujh2gHM7VH7vbSFS19uIlLQHBIdMkbErRa9JmwgZok14
 WwXWSafOEIE2vw/XpvffTLHWQ3HfAkp5g4CwR8wR/s8gIwS3lXvvrMJsDwyRfmz3xPgm
 Yz6YTsTLJgyopaUmNkQeIdmiUX3UhJSknoQFmHWb1HLMOpmcEY1XkQ4V5iU3ri1bYpVU
 1Prm2/aewl5nJagRNE/OrAsVqCE44JGfIs1KaBwOvCRMJo+Sth1NTLf8nhdWoVD/epqy
 mlzYpUp02VyyX+1XpyT7UhW6J/zkJYzsWLdItLxWCK9TSgsN8yZeF6f4JLIznVEVi17L
 llhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747655386; x=1748260186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SK9ss3402S661VRDPQ2wRDIk73djh1jJtWalnXdvjT0=;
 b=nGcHzNcnU2c+x/+d7Er60j88EYsLB9UEiDDZExJddlthmJkM+xtVxNDPdd+kPtjKIz
 G1qPp/XzRBlAa6Z9v2x9sJ9WwPfl0EaAQmDLgja+eqoL9HbGRDRRRN/wZMFAzIbfP/d6
 SAHA3pcY4RNWbLOPAg5jve2QgSRcEdp3P6iCpPgZm2W28KuWMKOOMAST0LYKZd1kcMGk
 vDaUnb7xdDnkOWJhJMnliT7NfJ4otlQDu0PD/SESVfslznc+8V4RoJU6CpzrQseVhqd4
 U74RaQyFLkRWk5dBzKr1zfe2PIoIruXNl4cMvvE3v4GILURd6enSnOa8v92ZMQdiW3CV
 QrSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuFAHDSkWREkXS2N2ptiUpLTD7MXGq3EvAuUBrVsah7AVjqDNPKu1yhjpVSeZPL8QdjFVbIas=@lists.denx.de
X-Gm-Message-State: AOJu0YxBe2Tp/YlFeOfs26+GLVFJUB73IuA/U47qgsOGhTcqnDMRBP44
 oPnWSpzArA3ESa9JuIm+Tx6tP6Mt2e+xSNfcppIeQMDeqNls0gxNpGZ8O66hazeCoU+Dhp1orKc
 Kvc2c+tCtm3PApo3H2jRkJDB2sccz6MenqFuIBllIVQ==
X-Gm-Gg: ASbGnctYGv/vX3lNkvMXElGJaWbb2S4GKOmzn7nfjmOP2n+7nF2+J2zRVcAtMy8uSWJ
 JOQKAu6z2H8FX9BxOB/7ZltszdZbp7ISbRqmK2WcHLTHS8hvZwYIUrQ4J/s3StazyWnNytjUklY
 3t7/YONSfbrFLpoPsveiQO62Zdo9Gxcd0=
X-Google-Smtp-Source: AGHT+IGCQITab/+3thULaeYsTv/rGSj+qu7wesODKmfCdVL/idftHzy1qacsnL20WriRJgHttmMNe+5N0uAWu+kgB9E=
X-Received: by 2002:a17:907:72c9:b0:acb:52cb:415f with SMTP id
 a640c23a62f3a-ad536f27ba5mr1130466666b.48.1747655386138; Mon, 19 May 2025
 04:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
 <64515b97-1e4f-4e58-86aa-1cd5dc3de9ec@cherry.de>
 <CABd623t=qZLn35J7BdO9q-AyXHk49cPyf0uDOA7UQ0FL=oxM1g@mail.gmail.com>
 <df9d437b-5d7f-414a-a88e-d2ce0c25c05b@cherry.de>
In-Reply-To: <df9d437b-5d7f-414a-a88e-d2ce0c25c05b@cherry.de>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Mon, 19 May 2025 13:49:34 +0200
X-Gm-Features: AX0GCFvtdSg3O9t5KT5pop-xj4G6nWUO7ePINmCu1FeB4hbvarzSkpH5hNiJqoY
Message-ID: <CABd623vgVmyHhpmEtyEyCk_ShHr-+RpDz6yi8Pu4u_g_ji4j6Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

pon., 19 maj 2025 o 12:40 Quentin Schulz <quentin.schulz@cherry.de> napisa=
=C5=82(a):
>
> Hi Lukasz,
>
> On 5/19/25 12:32 PM, =C5=81ukasz Czechowski wrote:
> > Hi Quentin,
> >
> > pt., 16 maj 2025 o 17:27 Quentin Schulz <quentin.schulz@cherry.de> napi=
sa=C5=82(a):
> >>
> >> Hi Lukasz,
> >>
> >> On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
> >>> In case DEBUG UART is not used, define dummy macros replacing
> >>> the actual function implementations that will not be available.
> >>> This allows to compile code and avoid linker errors.
> >>> Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
> >>> to avoid compilation errors.
> >>>
> >>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> >>> ---
> >>>    include/debug_uart.h | 15 +++++++++++++++
> >>>    1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/include/debug_uart.h b/include/debug_uart.h
> >>> index 714b369e6fed..4526dca24ac6 100644
> >>> --- a/include/debug_uart.h
> >>> +++ b/include/debug_uart.h
> >>> @@ -128,6 +128,8 @@ void printdec(unsigned int value);
> >>>                        (1 << CONFIG_DEBUG_UART_SHIFT), \
> >>>                CONFIG_DEBUG_UART_SHIFT)
> >>>
> >>> +#ifdef CONFIG_DEBUG_UART
> >>> +
> >>>    /*
> >>>     * Now define some functions - this should be inserted into the se=
rial driver
> >>>     */
> >>> @@ -197,4 +199,17 @@ void printdec(unsigned int value);
> >>>                _DEBUG_UART_ANNOUNCE \
> >>>        } \
> >>>
> >>> +#else
> >>> +
> >>> +#define DEBUG_UART_FUNCS
> >>> +
> >>> +#define printch(ch) (void)(ch)
> >>> +#define printascii(str) (void)(str)
> >>> +#define printhex2(value) (void)(value)
> >>> +#define printhex4(value) (void)(value)
> >>> +#define printhex8(value) (void)(value)
> >>> +#define printdec(value) (void)(value)
> >>> +
> >>
> >> There are a few additional functions that aren't redefined here:
> >>
> >> _printch
> >> printhex1
> >> printhex
> >> debug_uart_init
> >>
> >> any particular reason for not having included them?
> >
> > Looking at the original code, _printch, printhex1 and printhex function=
s
> > seem to be only used internally by other print functions, hence they ar=
e
> > static (there are also no forward declarations of them in linux_uart,h,
> > and I haven't seen any usage in the U-Boot code).
> >
>
> If I haven't misunderstood how C header works, I believe the fact that
> the functions are static and used only in functions inside the header is
> irrelevant. A static function in a header will still be available in the
> C files that include it, even if there are no user of the function in
> the header file. I believe this means anyone who includes that header
> file and use one of those functions will have a build failure when
> deselecting CONFIG_DEBUG_UART.

My point was that even if using those functions is technically possible
(because as you wrote 'static' is irrelevant here), it was likely not inten=
ded
by the author. However if you think it's safer to redefine them as well,
I can update the patch.

>
> > The debug_uart_init function calls are, in most cases, guarded by
> > CONFIG_DEBUG_UART, so it didn't trigger compilation errors for me.
> > Do you think it's worth redefining it for consistency?
> >
>
> I think it makes sense, maybe Tom or Simon have another opinion on that.
Agree on that, thanks.

>
> Cheers,
> Quentin

Best regards,
Lukasz
