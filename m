Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DAFCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E13A8004F;
	Tue,  4 Nov 2025 19:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHfcB84a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB7B83655; Tue,  4 Nov 2025 19:03:55 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8CC8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-378cffe5e1aso28891581fa.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279432; x=1762884232; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShQLT/Gp6SncTt0TeGuGeCyFJaPHLXiZjuYBlQsgPxo=;
 b=LHfcB84aTfz7WL48s0KWA3+IDo2oxRdLS0rIiZwO3rJg5EzHxy9DbeTaIRKl2tROLw
 Nt/2A2jhmumw5XOIwXSBwYmE2Sv5dT9asKfxGWebuWD8uO7Y2t+uMhKFr9ZzqYvYEH5C
 QwayDNeZXnuk+l7klCLbkn10W2MQIc2DsO1Z3VGqxHGUVWJa6yGOZ9pW+3ADsu4ouoyQ
 2WIQH0rzC5t59UfkPf26dmR9qZzxi5JmGYYN2LRGgFa1TRaP7VvNasdx8zGn4YG2oa13
 VJmNUKw44DPST/TwNb9Jl3o/02/Gu6sLraAa8MWsXRaCkdsE5BKqu47/OxYWSLQbQgzR
 2xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279432; x=1762884232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShQLT/Gp6SncTt0TeGuGeCyFJaPHLXiZjuYBlQsgPxo=;
 b=R4y5PQSIBtjM8kKImC8gGFuS1jfRLMJ7AGheLSERM832uJQ41Qr6pPbzuHVsz/axgY
 zQmG5Izk+2DfOTDczZ5YFCs7ztD0Mv5em0DUAY4R8fsJfE1PKoSYYbevhcyBPGnkPIpa
 6rK26KSzTb8sOP+akDtGldk2DADR4ufr9pCIOZZbXhOCMoEdlW+VQvQsuaNBkYQf0ZcN
 Zby4DhH7Jp0r/UwSd3zt/lLSpd+mhTSjJaf8yG3tUJc9YfDuoKJjVe5TuT6/AuQHh6eI
 WipIx+jhTjpYwdSbH2WFR43kuseH9shW3PVHm91mC5J2INYy48SrtJQkQrBdBiSDjRuR
 1Lxg==
X-Gm-Message-State: AOJu0YyzNj0lfyipHk4jKIZN/VFUwFDhT5dkhUjkTCANldVyuxD4MnSf
 opX1DD11mmcO5w+5y5ss8lPwkMhPk4EbKh0ITBI7B6nURUI+sQ5PMHtWjq1t96ERGCYXk+v72Pk
 o3opA14IKeMVuBrHZIPo2Zsg1kujIOYs=
X-Gm-Gg: ASbGncsb1BqHTiZLw6HGGB18kuweb94/bpj8ewQoMvwGs0pQg71iBV8SA52KnFXLZWW
 aqoHfvhVcbu/jE00MdL526Br77LlwQzIg7AABQ1vWSsEZgkHgyKdG3DMeKhTsrKO9s5uBr+hFNO
 ERCgpmKiML3erE5lHKC6WC+6ylwaAFvQ5jjgwvG3gM+FPPofY8VaVtHoChX9MRX6XMopHgi90Le
 cSMnj8VLnJh5AbEKsjXqkNzJbTJ1rBNjgLHlT/npve4Zm9u3eGQhCLZVJ6JPNmlUqyn5975isjQ
 5Tq8cZySUZq3EIa4
X-Google-Smtp-Source: AGHT+IF4Ewb3eeXuNVmHODaNcDsn2K4xE0B1T5TnQVkEmlwxIxGz9izITHaawAmR0qXPc3x697gne9Q1qLcRE6uBf4s=
X-Received: by 2002:a2e:83c6:0:b0:37a:3751:848f with SMTP id
 38308e7fff4ca-37a5149d185mr434181fa.40.1762279430649; Tue, 04 Nov 2025
 10:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
In-Reply-To: <20251031074611.39426-1-andrea.calabrese@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:03:39 -0300
X-Gm-Features: AWmQ_bnq8pmabB6G1F65AvH4MHoafvTL6yYqLCeLiJ0UivbUxFxcCdDMBEyzuUg
Message-ID: <CAOMZO5AJoHXOD11hoVgKV9QjNvxwk_Ox+XN1-UPRYnCPzAA-=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bsh: update readme with instructions to build M2B
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
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

On Fri, Oct 31, 2025 at 4:46=E2=80=AFAM Andrea Calabrese
<andrea.calabrese@amarulasolutions.com> wrote:
>
> readme was missing instructions to build M2B. Now added.
>
> Signed-off-by: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>

I have applied patches 1 and 2.

About patch 3: please rework as per the suggestion I sent earlier.

Thanks
