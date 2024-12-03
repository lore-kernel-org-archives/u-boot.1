Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2609FE6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F168948B;
	Tue,  3 Dec 2024 01:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eAVFEC1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2AC089288; Tue,  3 Dec 2024 01:21:19 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B198948B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffc1009a06so71917821fa.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185277; x=1733790077; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UAha07xtD0lDdXvf+jfRrvF8ogI+yUwVWKrQE38G5k4=;
 b=eAVFEC1MzveOfimlWO0ZG4VJkXqio0H1xEDhpk6Aa+9mUOynPc4TZwwhQWXPv/hRfO
 JOgtpLMwKkNoAELGoXb9bifKyhZ5jgFry3rFp604aHHcFMtJokE/SO/rbSg8GT5q5z8M
 FX4hVAJyp30PDG8RYvVA9SZRbHUt3F8kaWdK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185277; x=1733790077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UAha07xtD0lDdXvf+jfRrvF8ogI+yUwVWKrQE38G5k4=;
 b=Ky5xJN0PI+TcS726arqd/CVF1znHlR7lKeWmlq8McEXeTdP7dPnesEf8sJDusFXlTX
 8BeEcKcKGEjuNkroIZWY+SLrI5/+7hFHvG0/ACGQ1gugaeXS/y3lTuZZslhuYIxb4er4
 Wye2dsAqFbwUTdh5HYDCs7MJaeVTfXQSfQ28TdceKlapVvdzP0WR/EKXU+BDuz27hdWq
 bRbNF6KAE9Rfa/35xbLsqa90qDyACXPJL7qO/qQTEHbGyPvqnMVmH04scA9uBUYTxCYY
 +GtwBufUApz/3RkPlTlPTYtmEPUR4CO2jfume4WZKMqpwcGC5ySsgCdNNyg+EWeFlDaV
 Odnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBzpTQFtAb3ZKvor+MuZX+w1FYf7b9VIQaWdmosIp1RAlkb1PpEa4fot7Lqyc3POH5x25gK5o=@lists.denx.de
X-Gm-Message-State: AOJu0YzhnIaPt7q5LNxH2g62ME1urywygJuuhWOkEBwmkGIB4krp7ntH
 4A/C4mfwjIKGXBYDfuU3n4a3ReQUvT4FlOz3vKNT2eqX3JbuU61gWhZEZUha3cvpjV5XqIQSA9I
 Br+L42nQ4hSo9Epwz6Sa8MuhomDiSNKI1L4bs
X-Gm-Gg: ASbGncs/0BC6u5aVmKbC5XOmZ7g2PHHavCgwPUPG79hN7v53l51qfBnGpoc3qcJee/0
 7qAzkaiy5oSZtB0KFRHEkMQDVvNfNtWCf
X-Google-Smtp-Source: AGHT+IEAAEWR8Jh0dMbrbDSSV76D4JQai/7LDImCDQmlqp4V3Qywgw2kh5ErWystVT5AHoQchI4eaIwtuS4zOq96iQk=
X-Received: by 2002:a05:651c:502:b0:2fb:3960:9671 with SMTP id
 38308e7fff4ca-30009c923a9mr4149291fa.15.1733185276529; Mon, 02 Dec 2024
 16:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
In-Reply-To: <20241202141558.GD2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:21:05 -0700
Message-ID: <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi_loader: Add support for logging to a buffer
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Tom,

On Mon, 2 Dec 2024 at 07:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 01:24:27AM +0100, Heinrich Schuchardt wrote:
> > Am 2. Dezember 2024 01:12:36 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >It is a bit of a pain to log EFI boot-services calls at present. The
> > >output goes to the console so cannot easily be inspected later. Also it
> > >would be useful to be able to store the log and review it later, perhaps
> > >after something has gone wrong.
> > >
> > >This series makes a start on implementing a log-to-buffer feature. It
> > >provides a simple 'efidebug log' command to inspect the buffer. For now,
> > >only memory allocations are logged.
> >
> > In my previous review I suggested to move your work to the level of the logging library lib/log.c.
> >
> > Why are you reiterating your series without exposing why an EFI specific solution. should be desireable?
>
> Even with
> https://lore.kernel.org/u-boot/CAFLszTgE_HZEbG7B09_oo=XfugvH07ix=_0eoSGaEQ+KhyA4Qw@mail.gmail.com/
> it is unclear why this patch series rather than either/both:
> - Expand CONFIG_LOG to have a "file" or "bloblist" option
> - Use CONFIG_TRACE
>
> Do not match your needs. Especially the second option.

From my side I'd like to change the conversation a little, to how to
land code, rather than why we should bother. "Code needs to land"
should be the motto. If someone has taken the time to create
something, our bias should be towards getting it in, with sufficient
changes to make it fit the project. There are cases where something is
just a bad idea, or should be done another way, but for people working
on major features or changes, biasing towards not landing the code is
just going to make them go elsewhere.

CONFIG_LOG with a bloblist option would be a great idea, but it's hard
to programmatically scan text...plus only the external call sites are
actually logged.
CONFIG_TRACE - ick, you want me to write a test which does a trace and
then scans it to see what happened? The trace doesn't even include
function arguments...

Regards,
Simon
