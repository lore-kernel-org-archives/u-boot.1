Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0626C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 06:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD81987B30;
	Thu, 18 Jan 2024 07:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Hitm7uka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760FB87B4C; Thu, 18 Jan 2024 07:57:07 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C16187B51
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1705561024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNvbAQVW5MVAXKY8shXbbTHDdbQsvC2ffVpcZbKjJs4=;
 b=Hitm7ukavHOstuEkHbgHsdGv7r+XN7Au+K0UDldHTPNqDLtzONaSQ4LerPmUWk4lHEMVVC
 DRlUF+Zw5X6xigD+Jr/1DM/mGDCbBE06TF1kDG7WobcK0kcvXYiMdeFokJXwxpbtH8LDkg
 jfpztrl7gWTT+0uQjOrXe5IunAw0gTnxAdUwq0J7HMcw+MlcvwggkQxmpczzEQK9aNPVHQ
 crttqTav3TRf6KCMA1kbhCm2nMtluXc71FH7e7RhBG4INjJGTfAu2vdmNIEmTh50UWMaR/
 fskv1omyhCaFpU15q/XacA8sdzWMThij+wCLsg6qQESkSyhe1CwMz0lQqiwkow==
Date: Thu, 18 Jan 2024 07:57:03 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Michael Walle <mwalle@kernel.org>, Caleb Connolly
 <caleb.connolly@linaro.org>
Cc: clamor95@gmail.com, sjg@chromium.org, sumit.garg@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2] boot: add support for button commands
In-Reply-To: <20240111093808.3678028-1-mwalle@kernel.org>
References: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
 <20240111093808.3678028-1-mwalle@kernel.org>
Message-ID: <5af4762a66ab630ea8e391183eb7ee4f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Caleb and Michael,

On 2024-01-11 10:38, Michael Walle wrote:
>>> This is simply awesome, but I see one possible issue -- the need to 
>>> have
>>> proper environment variables defined for a particular board or 
>>> device,
>>> to make the buttons work as expected.  Obviously, those environment
>>> variables can be absent or can become missing for numerous reasons.
>> 
>> Is CFG_EXTRA_ENV_SETTINGS not persistent enough?
> 
> IMHO no. Because a user might accidentially mess up the environment
> variables.

I apologize for my delayed response.

Using CONFIG_EXTRA_ENV_SETTINGS should be good enough to provide
the fallback defaults.  However, the users can still mess the things up,
but again, they can do that already in many places.

>>> I think that we should have an additional mechanism in place that
>>> defines the buttons and the associated commands even if no 
>>> environment
>>> variables are found.  Like a set of fallback defaults for a 
>>> particular
>>> board or device, built into the U-Boot image.  For example, Rockchip
>>> boards have those defaults pretty well defined.
>> 
>> A programmatic API for register button/cmd mapping from
>> board_late_init() (for example) sounds sensible to me.
> 
> I don't know if it has to be that complex, or if it will be enough
> to just have some compile-time constants like CONFIG_BUTTON_CMD_N.

Having compile-time constants is also a viable option, IMHO.  We should
just need some fallback mechanism, and the simpler the better.

>> Is this really an issue that invalidates the implementation proposed
>> here though? It feels much more like a nice-to-have addition that 
>> maybe
>> we could leave out for now?
> 
> Agreed. Looks like one can add it to get_button_cmd() later.

I also agree, but it should be added eventually.

>> It also has a MUCH wider scope imo - should board override env or vice
>> versa? What about triggering default AND custom actions for one button
>> press? What if a board wants to register a callback function instead 
>> of
>> running a command?) - these are questions I don't want to answer with
>> this patch.

Yes, all this opens quite a few questions.  IMHO, we should simply have
some fallback mechanism, for which using CONFIG_EXTRA_ENV_SETTINGS seems
fine to me, and leave everything else to as it already is.  Sure, the
users could mess it up, but that can already happen in many places.

> One use case I have is restoring the default environment *in any case*;
> regardless what the state of the board is. In this case, the 
> environment
> must not override the button settings. This can be a compiled-in
> command, which always takes precedence.

To me, having an option to restore the default environment isn't a bad
idea, but not automatically and always.  Perhaps some other mechanism 
that
triggers the restoration should be devised.

> If you want to be able to overwrite a button command, then I guess you
> can already do that with the environment setting. Provide sane defaults
> via CFG_EXTRA_ENV_SETTINGS and a user can then overwrite it.

I agree.

> In summary, the registered (compiled-in) command should always take
> precedence. If one wants to supply a default command which can be
> changed later, that can go via the (compiled-in) default environment.

Sorry, this is a bit confusing to me.  Didn't you write above that
the users should be able to change the associated commands through
the environment variables?
