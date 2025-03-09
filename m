Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BFEC282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 10:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365F2801DE;
	Sun,  9 Mar 2025 11:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hYsLyfEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003458043C; Sun,  9 Mar 2025 11:59:34 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF9180107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 11:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso2736988276.3
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741517971; x=1742122771; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GjrqlKLbQTHcejwEP418AzjXOk+M0TI5uIyHRaZ4/RI=;
 b=hYsLyfEnLpnihhLY86nG+nRuTkAu8xQaQHbC3Q50V7cAyEW6+fTf2nh3W42+9un3xl
 vsiZlGDTsDEbTLJgPTzDOZvN0LPRj8BBxWbnAWwC9lJ84jmLQdT7yOw5ZmaEFFKWSpwh
 l7mB8tumMI1PH5UJTySft1gYjGPWXfsXCfm6D2xYM1t5XPYLy6X43qNdeAd/nNSVnfxK
 OXmkaoPWAcmcHsXPWbEW4n6q111ONeQK5mRaARfZVHBHD94XYhrut2UcVAaW0LjETqCW
 eaM7Gl49cH7TgeMaC2Ix1dm4Adyuha7UzVUdYicmoLI29Jsw7mgRoMTEOcOioKNC4BVx
 cb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741517971; x=1742122771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GjrqlKLbQTHcejwEP418AzjXOk+M0TI5uIyHRaZ4/RI=;
 b=Lhu+DPH7BQpBABi7LedjeR8+rTMVQolnAQ78PYlqMtq2lTdV91p+ewMKm4QuFsKWfy
 o8m1xlwuEAvXFF13p7/MaDJq7gNYcyTQWib/9t4aXFLldi7BOzHH7bRuQZr4IYhuyQMo
 xIIv69ZxmJRLbNIhuWLYGsoR0ZhUIHrNS6nRH6KxFudt9PN0OH5fiCviRLmG0elGfoc7
 TV76nRWRMSbyJIIaW4UC0AydMZ0tpobFBHcpRuRv+W7WbfX6VV+LViKydTVlaijL4pHX
 S/klPGKVwqK5ls0sSvEx1jqQWtBFLE/7f4Zonw9SWLaEPVbLBTyglahXbnLz0praPcNa
 cXtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1ohjv0+mHf5bnklfJQelj/CVr5VWKpkRhnYkkxyGn8KJiaUoZcpuWYCLI1ahRTCgi3EmKn5s=@lists.denx.de
X-Gm-Message-State: AOJu0YzAMHLREL3Ld/oItmeFYN4OyLn6gowS+bz/CLUYlYgJ2/r5MIA9
 z0L+EQdIPsMd+GkB/nxls1vEq4a1iob/rVBHwhvREuBg5IJbbSNk2HBkFEVy/3Bfoyb40rcPw38
 Edob9msVKeO+fwC5kqglSTBWiFSLSsxi4OqiHdQ==
X-Gm-Gg: ASbGncv5KQHeX+sJUN603HheA+OKVqiRg275mdjzZvPYruJ3uyu/FyiUtLdlVtu1b3s
 KL2HsP8A2CqL5sECSE2HHg913CCZZF5PA+mIYSU0lU/gQTdK6U1MXjioTbXa13S7fMfE+B4C1x9
 3QhbhNPfI0MJcm5HoPlvSyEYWftZ73zjsPWrQyqQ==
X-Google-Smtp-Source: AGHT+IHjJx5z2NY60Jp6O36+5vSdqaytibuN0dt88hpFWPBxWtPXZ5BztDT/UkdETcJFFYuQoCnY2Tjac3a7lL/Qws4=
X-Received: by 2002:a05:6902:228f:b0:e60:9b80:1f82 with SMTP id
 3f1490d57ef6-e635c101689mr12989782276.8.1741517970938; Sun, 09 Mar 2025
 03:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
 <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
 <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
In-Reply-To: <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 12:58:55 +0200
X-Gm-Features: AQ5f1Jp32xHG_lb9nl2KAyiWnWXRxxQdqaOFqqpBKojPDDDPVVVAY9gwtDxwvwU
Message-ID: <CAC_iWjJ6p8+2vV38rNPq0vJcAwY9iED=U129sYJxH=DL20-8rQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.denx.de
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

Hi Jerome, Heinrich

On Wed, 5 Mar 2025 at 17:13, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Heinrich,
>
> On 3/5/25 16:07, Heinrich Schuchardt wrote:
> > On 05.03.25 15:26, Jerome Forissier wrote:
> >> Add the "cacert" (Certification Authority certificates) subcommand to
> >> wget to pass root certificates to the code handling the HTTPS protocol.
> >> The subcommand is enabled by the WGET_CACERT Kconfig symbol.
> >>
> >> Usage example:
> >>
> >>   => dhcp
> >>   # Download some root certificates (note: not authenticated!)
> >>   => wget https://cacerts.digicert.com/DigiCertTLSECCP384RootG5.crt
> >>   # Provide root certificates
> >>   => wget cacert $fileaddr $filesize
> >>   # Enforce verification (it is optional by default)
> >>   => wget cacert required
> >>   # Forget the root certificates
> >>   => wget cacert 0 0
> >>   # Disable verification
> >>   => wget cacert none
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> ---
> >>   cmd/Kconfig     |   8 ++++
> >>   cmd/net-lwip.c  |  17 ++++++--
> >>   net/lwip/wget.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++--
> >>   3 files changed, 121 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/cmd/Kconfig b/cmd/Kconfig
> >> index 8dd42571abc..d469217c0ea 100644
> >> --- a/cmd/Kconfig
> >> +++ b/cmd/Kconfig
> >> @@ -2177,6 +2177,14 @@ config WGET_HTTPS
> >>       help
> >>         Enable TLS over http for wget.
> >>
> >> +config WGET_CACERT
> >> +    bool "wget cacert"
> >> +    depends on CMD_WGET
> >> +    depends on WGET_HTTPS
> >> +    help
> >> +      Adds the "cacert" sub-command to wget to provide root certificates
> >> +      to the HTTPS engine. Must be in DER format.
> >> +
> >
> > Shouldn't we build CA certs into U-Boot?
> > Downloading certs from unsafe media is not a good replacement.
>
> That's the purpose of patch 4/6 [1]. Although downloading may still be a
> valid option when used with hash verification as I mentioned in a reply to
> Ilias in v1 [2].
>

FWIW I think this still makes sense for peopke that don't want or can
not add the cert in the u-boot binary, but can add a signed script to
download it on the fly

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
