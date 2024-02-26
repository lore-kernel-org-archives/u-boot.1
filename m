Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B814C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 10:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB57B87DEB;
	Mon, 26 Feb 2024 11:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QF/x9FPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C64863D3; Mon, 26 Feb 2024 11:34:02 +0100 (CET)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41AFD87DF9
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-471e18cd6e3so123790137.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 02:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708943637; x=1709548437; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G/FSjlBmpWU6YKjQEHYV8yQNqZOd72UCkAGbt2ezSJc=;
 b=QF/x9FPNbn87/XUBrTL8GHydV9PaPu8eri5A5W3RpWNrsuMpG/ljvg/uVyCRGKhraV
 yv3BucRxMsUi+gVYP9ckEFdmanJF9UyZ89QoOS1AgvqjgqycabPCYmqa8/jmLf+Splzj
 NF/oNdOvsA5kYq4UVnnLyX8hOHbBZ04nTrivEbYHZqb1uZhD4zTM81fpLtLIH2aOfW0b
 XEc6lF2Rm/pNkOgAkv9PCmlFy1xzC3twtgKuBUJg3qqLwEmJ9u7XapU8fu9mt54/04FC
 YdEI+YV8Gt59tHzGme3x6204sFco0742LF4V8WBpc9NJ+UYdr5ft+lzbwupCk9FVqh6u
 NSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708943637; x=1709548437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G/FSjlBmpWU6YKjQEHYV8yQNqZOd72UCkAGbt2ezSJc=;
 b=QSzfTk5bSkOIpbfxshx6ovU1NwB/vPPL8XkQ2ObiZ0Rhgnhp/8dTGsQCX+uOy+2b8X
 Kt/yrqhKQkUAbl7VMBUHci8dVPkpCaf7fOuPLTWBqsKf4Jp3lpvtQDsBqslnZu07T/uM
 /FbyXmBuEK06DBojEtyxc1eWSYUy0Lhkv2pIXFGFf1N65LFGPIzAfVOzQsmIEXkU7buw
 CxeUXwKr01NYcZAXhR5DaTIsOjRzXvFiHuvqkuPlH9Dz4n/jTW3ws6s3+0Q/0ITd5SVg
 sMVEMXairWo+7uNhrdyMMa+XQJToVa9j24Dn0gi6EH5gkYA3jXJguHmoFaJ3fG6XCmr2
 lLOg==
X-Gm-Message-State: AOJu0Yz2eXowHqMjOdxoss8DhW44yuKOiJ4ZltCNYkz0mQ9qYFC8Eead
 JQhQUXoBZOqhMzLMTZGf78ZvE6vhgLvx9uUyoPj60WN3HvR14+UZv7DuaNS1teR8M/aNCbEOPF1
 ylR9eQYBkHHa2R2H4roF6f84UBfOR+im15BoX6Q==
X-Google-Smtp-Source: AGHT+IFktktlZyonY+nw91DXvSSZYmu+z8KAXkZfION/q87f4KB3NlvD9fzh9ALzQxCGbZTFxJ1tfKx8pRYeVfuU/EE=
X-Received: by 2002:a67:fb05:0:b0:470:3ab4:3cb4 with SMTP id
 d5-20020a67fb05000000b004703ab43cb4mr2855767vsr.27.1708943636805; Mon, 26 Feb
 2024 02:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <a5862ce9-8977-47cb-87af-e8da1839867d@denx.de>
In-Reply-To: <a5862ce9-8977-47cb-87af-e8da1839867d@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 26 Feb 2024 16:03:45 +0530
Message-ID: <CAFA6WYNEpg_zgRo_gD3ab3QR1e1j1xZCOb8ui-ZSV27U_Yv4EQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>
> On 2/26/24 9:04 AM, Sumit Garg wrote:
> > Add support for i.MX8MP reset controller, it has same reset IP
>
> Same as what ?

I can expand it.

>
> > inside
> > but with different module layout.
> >
> > Inspired from counterpart Linux kernel v6.8-rc3 driver:
> > drivers/reset/reset-imx7.c.
>
> Use commit ID of the last change in that driver:
>
> bad8a8afe19f ("reset: Explicitly include correct DT includes")
>
> I guess

Why isn't the Linux kernel tag sufficient here? I don't see the value
of cross referencing commits across different git projects.

-Sumit
