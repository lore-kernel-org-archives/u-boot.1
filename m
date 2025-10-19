Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF00CCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 11:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9C883890;
	Sun, 19 Oct 2025 13:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S2bmXuuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05C083893; Sun, 19 Oct 2025 13:36:37 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFCB83837
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 13:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c3d7e2217so3280023a12.3
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760873795; x=1761478595; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X1kY5hOMLucubo1z/aVxLy38TspS1/IcH/RDT0eHX4I=;
 b=S2bmXuuRo19xKHhpkXfPrGLMDZvL9FJhhXB0CBNRBagmK8UtFpUJaawb9WealJKA+z
 wkD5o40kGn9P9oOyJ/lg0xqbXYa3HnBU3SnO0YdmAjksDPHQhbl0/ajL8RSiasy0yMCI
 0Qe38HQHkKXDBuAIjgrivgSRzGSSvlw9Rb1pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760873795; x=1761478595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X1kY5hOMLucubo1z/aVxLy38TspS1/IcH/RDT0eHX4I=;
 b=Bv/zKmwTaKoYcL2ecnmd9S0C6cHRfBe05Dzi+jLh2jln62JSr0mvUFOdqZkGQSj4yd
 ljyJLd2bYbDvMrxZa27uL5Jr2aNj37jBkW+T81xrE59GbAgOEwfXMrg4FNweA/EDbxWC
 G15RQpV9ze0VKhBVLM+d9EP/BkQWMWfxZXJCiAaN2YWN0/KoCQ6+8Suk2wDNb2Uucki8
 ZeLQWN7D418PCLFpeJ8EXxs4TCTqTetuIYigNnwL34l+FG/CBEvOpApdwxruy2M58Bn0
 g52plqqmpYqj7xRNrS0TTDkOUunr1jxzVedzlghuodYxMW4k/9MqFvQeoZ6GWgfYClsz
 J8Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9GOxh2gisNXVWY7y0vDMVREeNS3osclXbOGQGsvIngU2jMhbq1ymolgOp0Vm/Sj6eJgQNpTo=@lists.denx.de
X-Gm-Message-State: AOJu0YwsKADqpjO/LwPrBEZPnhzBuYCg9Nd9Ea5n8QEA0F1gEWCXDeHS
 Imc4z+4nd+iCxFPPAoNEBtxGvCc1oqV2A5A80A71S4WY0cu3lCIkNCLEllBQP5hoTORUDJeOBR8
 LfLLWGqRxscDgq9yw8fCqpRRN6efC9ZoSoQY1IK24
X-Gm-Gg: ASbGncua75wFQ0tiO6kX5WfJk8vuWRtU1PVFy7RIbIA/Lf0YOIAmOfOs3t3Un04rACJ
 tyQphysRq/yG5u37WwXpDjNSSnvgxbe1YYZ0kCc1FJSgO6ceSC8XslolglEsUVzl/UHzrWm489D
 jLKj4A5m7RBjMPOZQqSlvElQ/a8YOFo+uU7fN8TgYwWalNwhZFG7hTFCRNsczUOg1KOvN55EFFC
 /rEuZRehzM2PqnkgRcwqunx/iGp3Hg5+BGWY3FLCXPsx1BHo5kdgsgOrupMFLKGx9kK0FvC
X-Google-Smtp-Source: AGHT+IFrn0qczrGWL9GQU9VLpBgLVyUDxE96+2opdvKcdkofQyq8a60TwnjXwXB5tjkNWOsFDZqgE78RjJMxXmXx4r8=
X-Received: by 2002:a05:6402:3595:b0:63b:f238:8fe2 with SMTP id
 4fb4d7f45d1cf-63c1f6b1f7cmr8734372a12.21.1760873795048; Sun, 19 Oct 2025
 04:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
 <20251014220352.GA338016@bill-the-cat>
In-Reply-To: <20251014220352.GA338016@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Oct 2025 12:36:16 +0100
X-Gm-Features: AS18NWD_BpW-r9ycCc5W3rpNdtfVRl7r1apecOKKT12hOZQjJMFFQl9nQgGr1c4
Message-ID: <CAFLszTj9tbFwTcwMrk56UYZ0Cq1YyNx1Fwk=5P-MFNr=u5LOmQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] clk: support arbitrary clk_register() sequence
To: Tom Rini <trini@konsulko.com>
Cc: Yang Xiwen <forbidden405@outlook.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

Hi Yang,

On Tue, 14 Oct 2025 at 23:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jun 21, 2025 at 06:54:17PM +0800, Yang Xiwen wrote:
>
> > Currently U-Boot clk framework mandates the sequence of registering clks
> > to begin from root, and then its children. This is an addtional
> > requirement that doesn't exist in Linux kernel, which makes clk driver
> > porting more difficult.
> >
> > Let's handle this entirely in clk framework and give driver the freedom
> > to register clocks in any order.
> >
> > This is done by assigning the parent "lazily". It will cache the parent
> > name in the core clk struct and try to refresh it when clk consumers
> > call clk_get_parent(). It's transparent to clk consumers as long as they
> > only use APIs provided by clk framework.
> >
> > I've ran `ut dm clk*` and verified these commits does not break any
> > existing testcases. Though no new testcase is added because I think
> > existing testcases already test the logic very well.
>
> Sorry for the very late review. When I build this on say
> rock-4c-plus-rk3399 this is the size growth I see:
>             rock-4c-plus-rk3399: all +228 spl/u-boot-spl:all +500 spl/u-boot-spl:text +500 text +228 tpl/u-boot-tpl:all +552 tpl/u-boot-tpl:text +552
>                u-boot: add: 1/0, grow: 1/0 bytes: 228/0 (228)
>                  function                                   old     new   delta
>                  device_reparent                              -     120    +120
>                  clk_get_parent                              56     164    +108
>                spl-u-boot-spl: add: 4/0, grow: 1/0 bytes: 500/0 (500)
>                  function                                   old     new   delta
>                  uclass_find_device_by_namelen                -     172    +172
>                  device_reparent                              -     120    +120
>                  clk_get_parent                              56     144     +88
>                  uclass_find_device_by_name                   -      68     +68
>                  uclass_get_device_by_name                    -      52     +52
>                tpl-u-boot-tpl: add: 5/0, grow: 1/0 bytes: 552/0 (552)
>                  function                                   old     new   delta
>                  uclass_find_device_by_namelen                -     172    +172
>                  device_reparent                              -     120    +120
>                  clk_get_parent                              56     144     +88
>                  uclass_find_device_by_name                   -      68     +68
>                  uclass_get_device_by_name                    -      52     +52
>                  strncmp                                      -      52     +52
>
> (using buildman's 'bloat' features to report size change). I'm fine with
> the growth in U-Boot itself, but that's just too much in SPL and TPL and
> we need to figure out if we can avoid that somehow.

You could add a Kconfig for this option, like CLK_LAZY_PARENT and then
use CONFIG_IS_ENABLED() so it is separately enabled in SPL, and
default off.

Also please add a test case to test/dm/clk.c (or clk_ccf.c) that
covers your changes.

Regards,
Simon
