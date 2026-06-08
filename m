Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675F3CD6E79
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 18:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 934258405A;
	Mon,  8 Jun 2026 20:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O11Dkmun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1214841C2; Mon,  8 Jun 2026 20:06:56 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EA8F838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 20:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso747373066b.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780942013; x=1781546813; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j4fE3+NnSS97nzpKi74HxflwlBzNufqqOXk8Q/FiUzk=;
 b=O11DkmunQd7vaiuGF1WvDQV+0UoU3q/WPKrjLF7ehyJLjuSsa9HYkph2uegMfsZ9TP
 SJzFCSnEIMGsLqTitHDzgE8qaEWzIVWYUeEoEI97KN+Li2ZBSogdNSGfwdtOHkgAWIj3
 Yh3+y1OY98AM1wKq7UmyLadCJzga5G3yeBBWKer8YWauo9NVzJLFWmhit0zJyxpAWqk0
 loZ3TdBNdhweq2P0mxvqtYLN7osMNdozMBufCDJNmaHO0sSPCK1XJUm1dufOt1Yse3eX
 bK/5QBcwxLEMVEQiP2g+wTc1A46vKvLL2XYOUNv9SdZdAFdoF+GKn+njPPOxx0a5CdBF
 XxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780942013; x=1781546813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j4fE3+NnSS97nzpKi74HxflwlBzNufqqOXk8Q/FiUzk=;
 b=VrNrEwmYCwoP8QZtdFxFrPyJM0sbYvrqNqGrsZ3do2TfXuf4W5Ve4xiMzCVehSkM1O
 IgzB/7LzLYu+yZ+43kFq7ZFbS1SSF049zIxgFzW75gsnrnYeqgV8ttUYCumjapBMRXEt
 7iQugJ7ikdvCloCdNUjs5jV1fGoQx70Dn4EaTf4z+y4MWTgr4XkHWSa0KwyECY1F59Ph
 1eeKepPUb8nhze1oudm3AKkafVAMio9TBjjw1nPxc0h9OKYdxpNCfLGl9LW0gt43XJHD
 YHGoUvr08QEveIkaTtaBNEzd6hNOj4um6jxrOspi28X83O8MLSxgeGZjmDH+k0AR3Hfe
 j2nQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EO3U1Gj0aMQY2fRnB5EkMSJyclHQz4hAVuwVN2rX6GqmIKQsIZaEtRDiXLbJ2tGORZoMZJjw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1yVgEy3NfCILkYifCKA/rO9cEAhsvCb4yFq4etwZabOvFeLn3
 CxrPXCyJdP2IrvOl2pPpTizUb6FtXpZWb6CInUDZ9LwPhW533fFqz55vZF0gpUn32NE=
X-Gm-Gg: Acq92OGmsgyYVO4PBJfecXp2dk3upDdF7UqwDpdFB88I6lx3w8TC7vr0j6gVs8upqWh
 /Ux600wwFkd7tSALr3v/JjWgy4Pn5bpNPnvdwUb/bNWIAiqVKZ2DICYQAgMVUgu9kDsH6UM+ESO
 Ea14Lh0keZi+OUEyUC7c7sYYTxaDKizJ2FXJ1Qf/Sj1rZPBHUiWJvoxE6F39I7bc87B6TI4Cz67
 W1eTLnpghq9R6FkR9V32TnscGBBwwKSC2N6DWUXOSGacsUv8kTqcMvJS+DoUg3jbXTUSGXzE6fN
 SzScFAyRXfBuG/F8NCDTw5bd0jvq5RgY525P3c0B9MgGyY082kEx+tZ4DicjCKEjuUtvwKiZ2Ft
 1YQ386AN69ZeFnN2/iWu8akEO5gQTEb5jafGUQ6RXPPOMagZ0ZT5hdlwmbiRczgY2WvojoXmTXH
 m9VtKQ+YIvZfrT5QB6BJLxbiB0WzBUKRUlXYhCD3bYPy1VFm6BGXJkkRfUGfZdotzNCmBoRpRaj
 g==
X-Received: by 2002:a17:906:c10c:b0:bec:e425:b751 with SMTP id
 a640c23a62f3a-bf370477c7fmr839150066b.14.1780942012604; 
 Mon, 08 Jun 2026 11:06:52 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e04a89sm903950166b.41.2026.06.08.11.06.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 11:06:52 -0700 (PDT)
Message-ID: <f19c6b35-bd26-4506-b2dd-cd6e6938f3cb@linaro.org>
Date: Mon, 8 Jun 2026 20:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Binman with Qualcomm
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>
References: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <CAFLszTiPJ=a2XNxKjegPP4HgQrYYOrwiPG--A2=u59y6KEV0Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 08/06/2026 19:13, Simon Glass wrote:
> Hi,
> 
> I want to start a new thread to work through the issues which result
> in later versions of [1] moving to custom build rules instead of
> Binman.
> 
> From what I understand there are some things unique to Qualcomm here,
> as well as some general comments [2]
> 
> Let's first get a list of the problems and then we can look at
> possible solutions.

I wrote a whole big reply here but then I realised it was not likely to
be productive, so I'll keep it short and sweet.

For binman to make any sense to me, it would be a very simple frontend
and library for vendor/board specific image processing. Configuration
would be static and defined in the Python scripts, dynamic configuration
is huge scope creep.

If that's all binman was, and it was co-maintained and used by other
custodians then I would definitely see the value in using it to avoid
dealing with makefile fragments and other nonsense.

Instead, it is a massive and overbearing "feature" that does stupid
stuff like pollute your boards DTB and ADD ADDITIONAL CODE TO U-BOOT
(which crashed for me btw). The moment I try to use a tool for
post-processing and it changes U-Boots runtime behaviour like this I am
fully out. Choosing to design and implement something as overbearing as
binman is just absurd, it prescribes a lot of functionality that I do
not want or need. I'm just not willing to invest so much time figuring
out how it works so I can fix it if it breaks something for my boards.

As-is it seems much more appropriate to stay within my means and ensure
that I feel confident that I can maintain whatever Qualcomm-specific
tooling we have. Vendoring a Python tool and making a tiny wrapper for
it is just the plainly obvious solution, I know exactly how it works, I
can fix it if it breaks, and it doesn't fuck with my U-Boot image or dtb.

That you are so clouded by your own perspective that you feel the need
to email me on the list to ask about problems with binman as if I
haven't already expressed myself clearly both in my mkmbn series and on
irc (and as if comparing my patches doesn't reveal the issues) makes it
quite clear that I'm much better off keeping CONFIG_BINMAN=n

> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250722-b4-qcom-tooling-improvements-v5-2-df143f1247fc@linaro.org/
> [2] https://patchwork.ozlabs.org/project/uboot/cover/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org/

-- 
// Casey (she/her)

