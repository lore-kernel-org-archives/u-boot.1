Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55092F36BAC
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC1F84105;
	Fri, 10 Apr 2026 07:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sa9O4rtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4EC884142; Fri, 10 Apr 2026 07:16:50 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F76C83D8A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64eee7b83cfso1136609d50.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775798207; cv=none;
 d=google.com; s=arc-20240605;
 b=h3jYZWoL1axLQ3MGgdW2ovD/xJ/hawlOwBYGNBm57NFTWRRQkK25C9Wp6PgiO2mzMn
 7vr1PKoW7yi6OthaF3azf9kELQlGCsBWCiLWI7OsKOMfL8ozrlywdTh5STHzRXE8QQGh
 20fWchBUp4b7OmCNw/hzzihlbAODlwWfOnxWUKvd2iVQzzb3ACsSd/x1aDMi4kLqywfa
 LTtS7GcKI++BuNgGZU/ptScgMPw9Z/fkrjM0QNvFTYLfFicb05waiapfSC/MkZclxpjC
 mqsV3QgAJJ7hZ22wBy5J0wqkvw+oknjkaabjw2cJPy8vykmr704cvjAGs6WzIDnbed3h
 2R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AzybGx4DnqDUSW0ssyLc0H9+eDbpY5S6cRtzTVOvzl8=;
 fh=E9b+WLicdhyBxm3MbUV2SIyu13fsnMfuNiGLW+7AyfY=;
 b=BGB9HMxaBEe8cOZUFn3NDsqh9JCPV1dbfdF6s10vuLgYMx4VNICPxaKJxv6YXJiFe3
 wEqUeGxrVbVKz1vgXWjmo8Ko6BOIQo52c4fh8WPE1bbPkf0Hywgsli32+jfJv7bHLyDb
 x8O28Js/ZTUvRiwRLu+lf3E+jOKwUU00/YK1dcmfgRSZLWddW59aMSHWtXv3Gx6MZ/Me
 4PCgUTfStKbueW1+zM3eISaFtJz15Um2ngJLlG9F26yl2nR2L29EjTtyZT9SkAURzuLr
 ZwzWcMTy3I3t1ujbR3fvnZhFhuu3AmfGf56JzEGOBzUf2Wc4pRBDCZvchy+FNmPWmiKq
 UhXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775798207; x=1776403007; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AzybGx4DnqDUSW0ssyLc0H9+eDbpY5S6cRtzTVOvzl8=;
 b=sa9O4rtcuuzXv20pJ7lds+NqAMcYGghmCPshCpvSV4h1zB4A06qtqV+sa01ptTMWGm
 3YKv2oq6m6XDPAxqCmlYPgoMxD8HDcCA2qdV7nijthZly9gJqCf0ovJP8RiJqMCYCUYY
 sBvWE3wYytfXaHpS2MfRglQ0tVIkHY/W5IAZDqllLEeasQoFxARUv0L5F/S5L9BJYHp+
 kv6MkTJsXO8jluVDay1LmPVSuXYGc9sbbw0x8kb4rqakUzoQ9/z9EEyQIIJ8T3Wu6Cls
 MmJZhfB9VwmzF0yYM4f5k4x8ldhFdSZ+ueO6Es9fYnIykTbGAzBik/wVl/DYIXibNrp0
 0R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775798207; x=1776403007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzybGx4DnqDUSW0ssyLc0H9+eDbpY5S6cRtzTVOvzl8=;
 b=rnuy0PKWwjbszKUdPpOxDMOIVGS6mkFihb/wq50tB2Db4PonM9/zjzhBY7sUOkQTUP
 C/uc+/qakM1bKk8QM9Q1xONrmjZNGZ4ELrRwuxMgBnR3jIbQMzp4odWG9FPYJEChNB+v
 jurJW+f5VumWshZEKBLa6bZh0cbcE4m7aLBgo0BkyU1kf1cIGhGRh2AHW/fBn70+8Cs1
 3g6un0VYouxJpJx5UgGHtjekyCChESclCHseQMsepozYixOTWVy/V9dNmZqGb0RazD6l
 zeVp/fu4E7vEuVuoPbG0kt2+6Vzc0OOtsenWxzVVi5jgFNSPrsy3XdwZMMCkSO0d5Rgx
 BbSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMZVuVZcn2AvjkhK+mD1g9eWy1l++x6ViDBse05lfL8Kb6rY1jejZ2bWM5Z//OF9NOc7jUuQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzdv6HN3icsCryUbIqc/LfUlXkXNJDNxvl0oEB+gPD+pYDH4X+q
 AiF+cCoIPaRscFMgeKkz6pdEglna6dIg69fcqH9uMT3ArC9fSy/IDR8+ftLMwHcIQoZPi7LxoQ4
 ivt9roUJ5w9QwRCBQJ1GcJOvyWTlHmF7XT1cGUzK3gMzQadjelXw/
X-Gm-Gg: AeBDieuLos2ou3sjdJqExL+zpQ4dcCZWduyDiJiRHf8th0WEjuTKuVAY9GfU3TrUL2G
 O1EvXdxRJVdnWWFg+lmrZC/embesB5dRniJZlsCKvQICC47+sP2BMuJUpSknblljzMjUebFyUY6
 GnXGn7WhhnpWFI6bDOtcCbQcSxqpiVf4Erc5SmB60dCRhRgisGfZyE522WcGVWlzMHYhmfKBria
 6VKg5L14FBe0e+XDwYS1lDk3Pa78LCQoJ6uhHkoPl/RS2GnER1n+dXHPLxryvf7bVMQH4QfeNm5
 82OLOUg4EoG709Hu8OCTEXg0O7uSvC32TA71ItF5M3UvDJQTei+BZh4ehkvY/SJu+DKV87SwOHs
 vThd4xsFf1mT4xivEF30WpZLPySUoru6IhWdlAjO3SJqmQu/JxAhqI/2zXvowvz+w6qLMtYH/Jc
 V3uuDtfYharXh+3opX+SKTj5JrcJnimZTry5YdvjNse380YX4JYgmJ/WDoQRaWpu22nACRYFSIr
 iBFQbn1knNY6PFcWEtgEurYDTfDc4WgjE20JXVtgvkk7saKGoaThVmetqI2s9U0AVxLtb1TNY86
 KkXAXbC6/LUrYh7gfF/0jAK9l4DQBl4pHlWiZyUW4R2druTp2qwEOA==
X-Received: by 2002:a05:690e:2552:b0:64c:9a9f:8803 with SMTP id
 956f58d0204a3-65198a2d9bbmr1100626d50.14.1775798207371; Thu, 09 Apr 2026
 22:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
 <20260403090109.3564638-5-ilias.apalodimas@linaro.org>
 <177547797999.70791.5582291609719254544.b4-review@b4>
In-Reply-To: <177547797999.70791.5582291609719254544.b4-review@b4>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:16:10 +0300
X-Gm-Features: AQROBzA7wnx2FzENQ2uQR6MA_ZBtYZjNmqobTmHVEgTGd_2n6H6Dr5TbaFXpm9M
Message-ID: <CAC_iWjKWJ9bVpkTbqLbKsgLwAiNSz5r5z50-MNi7SKDVRq1UnQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] common: Add an optionto relocate on ram top
To: Anshul Dalal <anshuld@ti.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On Mon, 6 Apr 2026 at 15:19, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Fri, 03 Apr 2026 12:01:06 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > diff --git a/common/board_f.c b/common/board_f.c
> > index dd5518b60db..2eab344037c 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -353,8 +357,19 @@ static int setup_ram_config(void)
> >        */
> >       gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
> >  #endif
> > +#if CONFIG_IS_ENABLED(RELOC_ADDR_TOP)
>
> Using a regular 'if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP))' here would avoid
> the need for '#if' macros around variable definitions above.
>
Thanks,

Ill get rid of the ifdefery in v2

> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>
> --
> Anshul Dalal <anshuld@ti.com>
