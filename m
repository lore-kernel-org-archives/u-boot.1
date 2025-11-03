Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E3CCCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 23:11:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6F082A9E;
	Tue,  4 Nov 2025 00:11:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdBKV0n+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 630F3836D1; Tue,  4 Nov 2025 00:11:09 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7C5C8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 00:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c29466eabaso1306876a34.0
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 15:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762211465; x=1762816265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YNR+YlvXPZ6f5aO5b1ynHRGN+bMAPTUdYuaA8xkqoOw=;
 b=OdBKV0n+xYUO/QNrrsMQN4PvxURZ1pFtU8om4jJGMQQGMbw4F+n+ZWF1TZr0tRnOmA
 EyX3JLfcTdCkjVVQoHVeF+2fUQiRblFM23GPLyyE/a5pJw5KcMhq880kNNwAmRCL4MjK
 2N4usHkc9KwLVBwRzOabX+PgbmigHBLeVsPKyxY+1Pn/MJb1akA3SUSSjntil6DlyZXa
 kVV5ox5BvCXGPNlUlsn55MC9YgvdMJ3OabWw+rF9x7sdYd/f95ey7xkD9arlGxDdRzWg
 qQuhSsBIIy1dOjLkwYmKzjFumeggK96YziPsmYn47NH7gxB65GTJL4wt8Dg991LjVXvN
 Uzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762211465; x=1762816265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YNR+YlvXPZ6f5aO5b1ynHRGN+bMAPTUdYuaA8xkqoOw=;
 b=cPf5YNbh2BLVvgyu5Qo5+IgR1jVRYFEicyQJD305BOFhfjzn13FwdF9MQ9+IHVgCZ3
 UGyR6gi0y/2AOjH9wuxPpmneFYWeOStKtmDAb7gqFdWKjbXEnJXY0pEYQoOkbKeZ1t47
 eoH75OJ2Xv4ACkkBLeuEW/Ej8VCB3R0S/dj7LK96rF+nxuvy/nAQ7L9ceo810Hg3usLj
 fkFexjHNB5OI6EO8tlk4S9aKbl5xj7wnQiALniechPnr5aG08rxLdPRbWacTd/NgQ5Vj
 CZmaeXowKbt5YzsOkNby1mJc55go3hp7UAOttOG3Pd3cUHzyNY9xE/qX7ybsD7yRe+CY
 hgcw==
X-Gm-Message-State: AOJu0YzwFBvQFjy31uInQCsicCbsFyel/wS40i4/HqPG7+2TmAEytQUc
 TAF8knYxYtuInwJbsH9z/AKsGIAgyC1qxV4r+MYmz63ImNfY8xoQiHlkl6Ad+aqMDX2pqntuzie
 l1qg8pXkVo12GU3NA3k+RIY7eiz4myYI=
X-Gm-Gg: ASbGncv7KkYHUCMn3O2jnHdtiLxs34H7CcniaXfVdlZn8fPrbhSk1GmgGN2HOVEwJdM
 b6eYyPrDxHgoloeCfHWNo8WE9nFcOGdmTI9pwV3Gue5NB7UhPn0AvHN4lIgT2+8g+H4NIJhBkbH
 QTZHHoxo39+0ZItyVQlSsJP5LZhTOaxTxxcUYpcs662kJTlzuPKKFIuCYTlxkJM0+lPlHBAxI7s
 0Th3DcreuJG9Mm/dbBOi6QHlxRjbYWABdm6yftB/jLFHC+vVZuhfx6uv+0sm/S7ngPUuZyr
X-Google-Smtp-Source: AGHT+IE2+0L1k5L9G+3a7ra6MCW3KXhXVs5JZ2Jd6lX1HTwbNzDkzg9nOW3LEpK3j0JFtmKmknL0niVxpNfTNlCWqOI=
X-Received: by 2002:a05:6830:719f:b0:749:566e:316 with SMTP id
 46e09a7af769-7c696717cafmr8003857a34.15.1762211465375; Mon, 03 Nov 2025
 15:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
 <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
 <20251103230540.GV6688@bill-the-cat>
In-Reply-To: <20251103230540.GV6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 07:10:54 +0800
X-Gm-Features: AWmQ_bmsqwHah30ohDXHVSyeU8IMsXpjigjQrC1OF8pYSr2f3HXUILo5rGVxy-c
Message-ID: <CAN7C2SCCMKfjnfB2FnH1svrSJ1dN_chtUVmsTcaP6-8_zSiEzQ@mail.gmail.com>
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> Because ".config" isn't valid, you need to have $(objdir)/.config be
> checked, and in turn that has to depend on the appropriate target (we
> have some stage that says that we are configured, I forget which).

```
make clean && make mrproper

make
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
make: *** No rule to make target '.config', needed by
'include/config/auto.conf'.  Stop.
```

Still not getting this, sorry a bit.

> > > spin with "make O=/tmp/somedir". It also looks like it's going to impact
> > > every board, and either fail or add some build time? Make sure both say
> > > "sandbox" and "qemu_arm" both build at least, if not a full CI run.
> >
> > For build time -> There could be 4 line of code to check.
>
> I do forget off-hand which methods of doing "something" in a Makefile
> are cheap and which result in firing off a subshell. But for a handy
> feature for one SoC I want to make sure we don't slow down say the world
> build of all 1400 configurations. For a maybe useful example, see how
> the "checkgcc6" target is handled, and maybe we can move all of this to
> live under arch/arm/mach-socfpga/config.mk and so only get invoked at
> all there.

If config.mk can also do this job why not just move it.

Brian
