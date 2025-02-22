Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA976C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8BE80FD8;
	Sat, 22 Feb 2025 06:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BY2ZLZeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF10F80EC0; Sat, 22 Feb 2025 02:17:58 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C8A980017
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 02:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7be49f6b331so269438285a.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 17:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740187075; x=1740791875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=3jAz5GTCmY2eRYjz1456rnMTeVkA/3KTMFoFqJrn46E=;
 b=BY2ZLZeusJC2bsu0I63NhutIonZNKWQgaqus6Owtbozhg13Pjsi8m/eF7yu1118pZ0
 5zjTpx6O+gs5eSGLTgOmnUfzW0zDWawCp5IkEkVXvaft1O4W9QiY3vckjLu3sHZnfNqy
 gzQUMsUyIzj2Q8tgUxM1Y0ZKK3caB6K/Xq3Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740187075; x=1740791875;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jAz5GTCmY2eRYjz1456rnMTeVkA/3KTMFoFqJrn46E=;
 b=xEtkbzd1i236+OHdZwRgG+MN9AU+OO9VjFJ6z7btGWmfFygOzrcQN3/83TqrOQW2+O
 K/V+8QRjolPOHuJHSP0h6jex+u7jCwhdst8XYfgFuResBY4qp0l8aPBPAm65Yy7KHZsV
 0pEj6qlnqcq3lO6ma118/4VRe2lZyQUaygRahq1bt+wFI1Wm/13PFZ1k40WPOJfKg4to
 N1HpaeLHmb8JXLP5TBMKFJe/ObdGlYYEm9vBakbL7CA3jnbc5dAgyGYe078BtO7oFGE1
 03xg1q452tU3ndhmAoFo9YAgqILcaULmm4BXd+4vPrq2Vj1xO5qlWVy+UaIzI5FaRjPH
 WcJA==
X-Gm-Message-State: AOJu0YzDGmnxqyZnPBDOpptztwinXJEOY4GvlugbLCIqRpkojr1F6/Z9
 /kovh73XjpV9d9PDvN3p8hKc3oTGUVVXX+0OLmcPfVmuYK6cwbGnrUs0BN/afJxNI9PaA+7mJOp
 h6FkJrAuMqsSQseB2jLYb+FlXa77OFFpPFzSN
X-Gm-Gg: ASbGncsZT9WYrqHjaPqV+bjXRJulC1z/8+IRtK1S74QEsRixiLQ4CvsA/Gr8xYptW0o
 x620O1p4b/vZbFEboG2sVJJ5R/2t0kReuDBl5XdSR73CIotNQwcZVRqvEf7loUauXdGBpHbnJLM
 fNbgFUMlhMqFUJfyTFuJCW1T7UFbNaTVmiYPQ=
X-Google-Smtp-Source: AGHT+IHbCQcGBD3b/I+Jid3ZJOB1UZD4Zx/bRoLQw37zrhiRL4OPe5010fLKwa+anCMpLOhAcyfFRttEltfw51UDqLM=
X-Received: by 2002:a05:620a:1a1c:b0:7c0:c214:f2d with SMTP id
 af79cd13be357-7c0cf8ea897mr654086685a.31.1740187075217; Fri, 21 Feb 2025
 17:17:55 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 17:17:54 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 17:17:54 -0800
MIME-Version: 1.0
In-Reply-To: <20250221010658.GD1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-5-swboyd@chromium.org>
 <20250221010658.GD1233568@bill-the-cat>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Fri, 21 Feb 2025 17:17:54 -0800
X-Gm-Features: AWEUYZlMsaa8tQltyYwBuDu4smQjfDdQaX0ld1-QA6NSsflfG-ScHaX6fyTo4vU
Message-ID: <CAE-0n51YEq9VyJ94NsF0ovNh-pturMBKe89W+W7cPdQpbJoVsw@mail.gmail.com>
Subject: Re: [PATCH 04/12] coreboot: Move coreboot logic out of x86 to a
 generic place
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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

Quoting Tom Rini (2025-02-20 17:06:58)
> On Thu, Feb 20, 2025 at 12:58:46PM -0800, Stephen Boyd wrote:
>
> > Lay the groundwork to run U-Boot as a payload on ARM coreboot based
> > devices. Move the coreboot table parsing code out of arch/x86 into
> > lib/coreboot. The headers like cb_sysinfo.h and coreboot_tables.h need
> > to be globally accessible, so move them into the top level include
> > directory. Introduce helper functions like
> > board_get_usable_ram_top_from_coreboot(), dram_init_from_coreboot(), and
> > dram_init_banksize_from_coreboot() so that boards can still override
> > these common functions while also supporting booting as a coreboot
> > payload.
> >
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
> I see how the abstractions get used later on. The rest of the examples
> in tree today are of the form foo_dram_init / foo_dram_init_banksize, so
> we should follow that form instead. And I'd be inclined, but I'd like to
> hear Caleb or Simon's thoughts too, on just overloading the weak
> function we already have and when we don't, #ifndef CONFIG_SYS_COREBOOT
> the existing snapdragon function. I suspect we might longer term need a
> bit different abstraction here to make it easier to override things when
> U-Boot is a payload and getting this information elsewhere.
>

Ok. I struggled for a bit trying to understand the design of the weak
functions. I'll rename it and have it overload when nothing is
different. That means board_get_usable_ram_top() can override all the
time. The dram_init() and dram_init_banksize() functions likely need to
stick around though and be called explicitly? Maybe we can have some
sort of 'payload' level event hook so that depending on the payload
that's detected we can call a function to setup memory.
