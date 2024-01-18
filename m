Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B079DC47DA2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBDED87B51;
	Thu, 18 Jan 2024 08:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sOC1fflz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26ADC87B53; Thu, 18 Jan 2024 08:59:42 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3401C879C4
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BC86D617F4;
 Thu, 18 Jan 2024 07:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F9FC43399;
 Thu, 18 Jan 2024 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705564778;
 bh=Xi4m5SAl+G3LpD7MjOu4ThicDbuNPH4VfB2DeeqJ4Po=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=sOC1fflzMAi9gAo+T3FBioExRHvPrKSaAce87Lf/FNVcAVr9grh8F4zpeZA6tXLFq
 l9AgmkrtY+jzxjBjvJmspEna9cOaQpqPcDcTw2V1SjH5V5mOgU9og2poFKGVDGoX14
 oHuCMJ7fBIY9DXr2nOd6PrVpzdoyrGaXErNNI7JMUz+SbOJao3k1plYckDq2j24F7y
 dWGD7kG7QS36V7l+gj+OiWf8ubj77hP8g0+7rQnFCjLKrYnXqqEV3OantPx9/rWlwx
 caNlky5HzchC1BkUmqm1SPpv4e0qqsTd2kJlcGGr4ZjuZkVbHwiRHKXFr0XsiymoxT
 YvPR1TuWR3dMA==
MIME-Version: 1.0
Date: Thu, 18 Jan 2024 08:59:34 +0100
From: Michael Walle <mwalle@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, clamor95@gmail.com,
 sjg@chromium.org, sumit.garg@linaro.org, trini@konsulko.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] boot: add support for button commands
In-Reply-To: <5af4762a66ab630ea8e391183eb7ee4f@manjaro.org>
References: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
 <20240111093808.3678028-1-mwalle@kernel.org>
 <5af4762a66ab630ea8e391183eb7ee4f@manjaro.org>
Message-ID: <15c65f2d0d66826cd1cf1c5a18ca7f26@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

Hi,

> Using CONFIG_EXTRA_ENV_SETTINGS should be good enough to provide
> the fallback defaults.  However, the users can still mess the things 
> up,
> but again, they can do that already in many places.

I disagree. In my case that is a last resort recovery. And it should
work in any case. Even if the user has messed up anything (except
from erasing the bootloader in the SPI flash ;)).

>> In summary, the registered (compiled-in) command should always take
>> precedence. If one wants to supply a default command which can be
>> changed later, that can go via the (compiled-in) default environment.
> 
> Sorry, this is a bit confusing to me.  Didn't you write above that
> the users should be able to change the associated commands through
> the environment variables?

I had two kinds of button commands in mind: immutable ones and mutable
ones. The first can be achieved with compiled-in commands, the second
with a default environment and environment variables.

Also, whether a command is a mutable one or not is the decision of
the developer (or the one who's compiling/configuring u-boot),
not the user.

-michael
