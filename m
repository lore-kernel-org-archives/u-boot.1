Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB66C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 09:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4278785F;
	Thu, 11 Jan 2024 10:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="r1lGz59Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8238785F; Thu, 11 Jan 2024 10:38:26 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31B108751F
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 10:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 16CC4CE1F15;
 Thu, 11 Jan 2024 09:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E1C433F1;
 Thu, 11 Jan 2024 09:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704965900;
 bh=abreNGZKOdXG/6ApPFYFSS65eFTmXcD1/Hwumfc0+EU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=r1lGz59ZAIrMvOOcxoL++gaNw/nWbf0Sf9R0+u5HwovF6HYWaIR7jRWf3tZLLJ/zw
 g9dfR27j7EPJF9QSDrFy6+HD1+rquPMUYrx8lvvPZdOTyUsF6Hkj7fT2VEGKSyPWGX
 K06JZJW9naFcZfM5AumNxeelZWXadYUMiYYomywBBHLw6vvhWBWGXhPL3Xx3ASDYtx
 3y2DwGQHn1mUFyxhzoVeFFIo0QknJO7TZKz9P6ZrjGxB/9Yiu5eakIA8+GvYJajE9N
 9sJ2voVB6ywn0txntuT4o5JlXFd2iVdXrQvTgfBv2P4g5X3vsMKmaM6QWoV28m91Zd
 qmIZb7vAF1JLg==
From: Michael Walle <mwalle@kernel.org>
To: caleb.connolly@linaro.org
Cc: clamor95@gmail.com, dsimic@manjaro.org, sjg@chromium.org,
 sumit.garg@linaro.org, trini@konsulko.com, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: Re: [PATCH v2] boot: add support for button commands
Date: Thu, 11 Jan 2024 10:38:08 +0100
Message-Id: <20240111093808.3678028-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
References: <3c76c99b-4d18-48a4-902a-9d547091d3d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

>> This is simply awesome, but I see one possible issue -- the need to have
>> proper environment variables defined for a particular board or device,
>> to make the buttons work as expected.  Obviously, those environment
>> variables can be absent or can become missing for numerous reasons.
> 
> Is CFG_EXTRA_ENV_SETTINGS not persistent enough?

IMHO no. Because a user might accidentially mess up the environment
variables.

>> I think that we should have an additional mechanism in place that
>> defines the buttons and the associated commands even if no environment
>> variables are found.  Like a set of fallback defaults for a particular
>> board or device, built into the U-Boot image.  For example, Rockchip
>> boards have those defaults pretty well defined.
> 
> A programmatic API for register button/cmd mapping from
> board_late_init() (for example) sounds sensible to me.

I don't know if it has to be that complex, or if it will be enough
to just have some compile-time constants like CONFIG_BUTTON_CMD_N.

> Is this really an issue that invalidates the implementation proposed
> here though? It feels much more like a nice-to-have addition that maybe
> we could leave out for now?

Agreed. Looks like one can add it to get_button_cmd() later.

> It also has a MUCH wider scope imo - should board override env or vice
> versa? What about triggering default AND custom actions for one button
> press? What if a board wants to register a callback function instead of
> running a command?) - these are questions I don't want to answer with
> this patch.

One use case I have is restoring the default environment *in any case*;
regardless what the state of the board is. In this case, the environment
must not override the button settings. This can be a compiled-in
command, which always takes precedence.

If you want to be able to overwrite a button command, then I guess you
can already do that with the environment setting. Provide sane defaults
via CFG_EXTRA_ENV_SETTINGS and a user can then overwrite it.

In summary, the registered (compiled-in) command should always take
precedence. If one wants to supply a default command which can be
changed later, that can go via the (compiled-in) default environment.

-michael
