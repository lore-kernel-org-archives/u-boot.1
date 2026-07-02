Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482FC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B87D84C85;
	Thu,  2 Jul 2026 10:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iG3/yzze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BA884CAB; Thu,  2 Jul 2026 10:00:06 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E68E84C19
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697edb1bf6eso2211145a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782979203; cv=none;
 d=google.com; s=arc-20260327;
 b=VBBMxNG31iJn4jul0hxiJkq03V1lPXtl98mJSyipNV902xQDTlKsm7BX8cVXmeg+Q5
 xH79yqKiYQpWIcu2ZMRyztZmBrLNwIPHrewviyYFscD8niLVzBNO8e1zOi7xXJOQV2bB
 63gViymxw9WNH8QqUwhz6UOOZ42hnIHez++RKBCleFMzsLgHuk9pDvMNN2o6UQhh49wu
 /f0MziEVSiCDvFXNXHcAvwP+UZCWHbSZ0V0b7fvi0/+79ikRBXGQj9qVmmllqsc6G6X3
 dfEmiKZ5L88HjQZ+hbBFluq88t7O/M94fQto4FLGwIqPF4OscvOqcz5CpfVQT45gT0zc
 /M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BDzFVVzimcjkOtGsxZdHU2NYJdcsHsTU5rmI2wvAVOI=;
 fh=JRowCf+raen5s4UALdGdJiYSWN4yV9fxIdvAHn74LaY=;
 b=E5do/RPaHXKEVUJcZ2zwdkbwdhzcT3DtWbtBXRbd1rHY3TyJRjsWU0uvUNGM6uMstd
 r1uQHro+3mITcTnhWXCg+hghnSlK/fL3qoe+hseBu08kMJDyW1b3pdq/0O4nXzcWFm9H
 k11QpY4+fbrXf+53a8HDoyQRXNapb0LTvJdJQzxEdnRlBH/n4LRjxnSdwG8wSvNbBsmh
 mMf4YejbTw0ioGFbutEnH1hfcIadTXLEB6zr9FgvFPQfFzHtjRxmGCPkhA6BHU3Uq0XC
 bj3573OfllZqCwkIxwP0xo8m1ysAWMh/EKQRBS/SSoi3L7qIM07Gh6v4SFCaR0kp2t65
 lKrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782979203; x=1783584003; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BDzFVVzimcjkOtGsxZdHU2NYJdcsHsTU5rmI2wvAVOI=;
 b=iG3/yzzeneGUt9yY1jJ7VKNREvCIkRh1ci5tc7tQ4NjO0QG4G0z1gbUnjj8vvxxi9v
 J4x6TMuYLSYEoTyi9pr3toQ6zM66LVSdFU0xpVxuzMV8YQlXSt3m7NjcVcoTfUhawSUA
 e+YWGg00hVqX7UlWu3pNXLk2q7zA1V3mnMejE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782979203; x=1783584003;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BDzFVVzimcjkOtGsxZdHU2NYJdcsHsTU5rmI2wvAVOI=;
 b=UcCEJKop5AhD9vpFQ6Udi4x7DYfF91MGu+p72UVJG8nUwgDOiQax17AbFguszcPwAL
 4YWqQA7k9waLXfGexEtTGN5ss5H97W0HkYstMSm7Qx6a4TNIigKC38dq0k2mRLiMjC4Y
 rAi0dqm+aOIHtwL735oAaBBn49auI6S/wrb5FY3IMw+VtAtCjKGq/HRbRYC7Qgw6ojsE
 vgAYkqXNl/Da+r4xnf2bOdJQRSbNgijH3h0zg1FrlQ+HGAIdIv9vu3WDP6rV8TqygBqN
 HtiUfz92Y4hEwyuKMD50aGOdadHvPH6SE+jhbroQ+1qG2Mf57qtFSowBY+MeN+SJ9bDK
 RELw==
X-Gm-Message-State: AOJu0Yw51F0D628+NQzFHA+2sPKUysan6BLQzVgSA9axZnclZZxCNDWk
 TbacxVnIl8GkYykEi3asTn1X5SHchXEqKsIT7WbwmobCh/0NKWgfKtiFlZNFoNgw5pwFFgQKzwb
 ZWCqyTdq9s2YNebsERKtGngdQXW5S3ywJ4LuLdxF3rrpLpiXmXz1dvQ==
X-Gm-Gg: AfdE7cmUIw32ybndNFvOb80zyILmeo/zcHjC2YYs81mgGun3bCFYc/CcHaHGOy1Ji9H
 hKfE0JoG2bjqZQYAHAGmkyvOwJV+aBn84wGbb+1lDxNiqN0fAkTh8sj7uKoKJm5weIXYB4KxRM7
 kJRHrtd9B3yz/RRtp/9jCsTD4ACTV56ZV7mKcV//ftvlDoM+Ipw9uesbG/SGbW962SzZESjgPG5
 9IBXFT+PlCC8UG6Pzle7G3dedotCSf3qcUcyx63g4+C8sl9ANJ5FkyN4AmfTuAk0d3PFxhYhA==
X-Received: by 2002:a05:6402:5409:b0:698:9251:2f87 with SMTP id
 4fb4d7f45d1cf-6989f3a184amr2071002a12.39.1782979202924; Thu, 02 Jul 2026
 01:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260701114248.1396125-1-sjg@chromium.org>
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 08:59:45 +0100
X-Gm-Features: AVVi8CeSgWGlZTSsHMz19DcckYt5K-7gwEQMl-b6bHkHyue50k0QGRUhlyCpIx0
Message-ID: <CAFLszThrisZ+KLhR6TQTZhTAkw6utrYGPOYo+YyuhrVCu7m84Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] cmd: Convert command option parsing to getopt()
To: u-boot@lists.denx.de
Cc: Adam Lackorzynski <adam@l4re.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Heiko Stuebner <heiko@sntech.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Sam Day <me@samcday.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
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

Hi,

On Wed, 1 Jul 2026 at 12:46, Simon Glass <sjg@chromium.org> wrote:
>
> Most U-Boot commands open-code their option parsing, scanning argv[] for
> "-x" strings by hand. That only recognises options in fixed positions
> (so e.g. 'echo foo -n' misbehaves) and duplicates the same code in
> every command.
>
> This series introduces a getopt-based command signature: a command
> marked CMDF_GETOPT receives a single 'struct getopt_state *' and parses
> options with getopt(), while commands without the flag keep the classic
> (cmdtp, flag, argc, argv) signature, so commands move over one at a
> time.
>
> It starts with the getopt groundwork - optional argv permutation, a
> getopt_pop() helper, dropping the printed error messages and the silent
> variant - then adds the U_BOOT_CMD_GETOPT() signature support and a
> strlower() helper, and converts the first commands: hash, env
> export/import/grep, fastboot and echo.
>
> The signature change itself is code-size-neutral; commands parse in
> POSIX mode (a '+' optstring prefix), so CONFIG_GETOPT_PERMUTE - which
> would make every getopt command carry a writable argv copy - stays off
> by default and is kept only as an opt-in.
>
> The earlier RFCs grew arm64 by about 1.1K, not ideal for a series that
> mainly benefits readability. To fix that, this series also restructures
> struct cmd_tbl so that adding getopt() support does not cost size: the
> rarely-useful ->cmd_rep function pointer is replaced by a
> CMDF_REPEATABLE flag, dropping a pointer from every command entry.
>
> Because that pointer is removed from every command on every board, the
> net result is now a size reduction. On qcom (arm64, ~120 commands) the
> whole series is about 6.9K smaller than mainline.

I just wanted to mention one more thing here, in case people are
confused by this large reduction. Subcommands have their own table so
there are about 250 entries all up. Since it is a PIE arm64 build,
this means a 24-byte relocation for each pointer in addition to the
pointer itself. So we are effectively saving about 32 bytes per
subcommand, not just 8.

Regards,
Simon
