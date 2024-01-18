Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C98C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C988795B;
	Thu, 18 Jan 2024 15:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="BDt4+TaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 683CC87AEC; Thu, 18 Jan 2024 15:33:37 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85108793C
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1705588414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BzaLn061VWW5l5GRE8je3HUckX6Yo0dbaRNfMXPVtE=;
 b=BDt4+TaRHjy3o0nKZ18Kz2GA0sAcmTjuStSMSBw1QfMGvbC3uSpdRtxl3ygJOKrCi0CDiF
 88DRnEvRrGkk/XetBUkPi2ZEx6M1Jh/G2ULWl9iUtSCzqWQ4s9bIOXx1dai9QaFjov7r/W
 GPC9KDgDVQryrw8jYLJ8rcF2h1ftYcRHb4jjvdAXJZNBcAeQ6jFuPF8JisiOesatdZfC7j
 x/UxFb/Mtw0b+yXf14Q/f04WwzL7VD6rnKTYxSSBDHXqlyvhEuXgxz3Xc5su+03cmMzfgO
 ohQragoohDV0BEP8OTqtcc0ZL8Sp3YK1K6WuIMAG6wrh871YCuJDfbzDoKIHQg==
Date: Thu, 18 Jan 2024 15:33:33 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, clamor95@gmail.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] boot: add support for button commands
In-Reply-To: <15c65f2d0d66826cd1cf1c5a18ca7f26@kernel.org>
References: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
 <20240111093808.3678028-1-mwalle@kernel.org>
 <5af4762a66ab630ea8e391183eb7ee4f@manjaro.org>
 <15c65f2d0d66826cd1cf1c5a18ca7f26@kernel.org>
Message-ID: <bf263fe8e2cb0bb841efed72372ba954@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-01-18 08:59, Michael Walle wrote:
>> Using CONFIG_EXTRA_ENV_SETTINGS should be good enough to provide
>> the fallback defaults.  However, the users can still mess the things 
>> up,
>> but again, they can do that already in many places.
> 
> I disagree. In my case that is a last resort recovery. And it should
> work in any case. Even if the user has messed up anything (except
> from erasing the bootloader in the SPI flash ;)).

Maybe the solution could be another compile-time option to "lock down" 
the built-in defaults provided through CONFIG_EXTRA_ENV_SETTINGS?  If 
that new option is selected, changes to the environment would make no 
changes to the built-in defaults, i.e. those parts of the environment 
would actually be ignored.

>>> In summary, the registered (compiled-in) command should always take
>>> precedence. If one wants to supply a default command which can be
>>> changed later, that can go via the (compiled-in) default environment.
>> 
>> Sorry, this is a bit confusing to me.  Didn't you write above that
>> the users should be able to change the associated commands through
>> the environment variables?
> 
> I had two kinds of button commands in mind: immutable ones and mutable
> ones. The first can be achieved with compiled-in commands, the second
> with a default environment and environment variables.
> 
> Also, whether a command is a mutable one or not is the decision of
> the developer (or the one who's compiling/configuring u-boot),
> not the user.

I believe that the additional compile-time option, which I proposed 
above, could be extended to specify which of the built-in default 
button-command associations are immutable, and which are allowed to be 
modified through the environment variables.
