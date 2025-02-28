Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D4EC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 08:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4AC808B6;
	Fri, 28 Feb 2025 09:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eYvlW6KP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C16809A5; Fri, 28 Feb 2025 09:16:14 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13F3B807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 09:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390eb7c1024so562077f8f.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 00:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740730572; x=1741335372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bk2Ux4p20IOB1Kw/kemvQdmV/4M5z8rvl8B4xPhIX0=;
 b=eYvlW6KP7ztskzUM91eGQnQ+MoxYC7LeHzZy6/c0Xp0nAZDGAqCgUjV0oVENfEPZi8
 X+zV0E434KAp3qR5V/xjKvG+b8sxQ642e5ywaKjlEQYeCGtzjMnmSKK24W1w/PEF9eLx
 xIHZuHYlL2Cjz4Ga0JJwGYf8e/pcj0fA0rko8Z0aGwXvY9nlv61hbknm5/AOUr7Hzg4/
 +cdlni6jphyqDZh0qmFuYxn9BznUWlJ/dnSgxze7Ovc5sM4FnKX6QFO6+Psdhc9CVVKt
 bFmb2TGDJ6QpPRoi4yZdp711ziuGOfOAQPcuA/fKB1vzXmy4u0hpQ2ehRMRd/ZsjYizx
 b1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740730572; x=1741335372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bk2Ux4p20IOB1Kw/kemvQdmV/4M5z8rvl8B4xPhIX0=;
 b=PKyDbAtlVQIoJtqI5r3nZ8eCOZH9ywzVMH3ZaWE0/cOYgoHkCVJvN8/umjs1PC2UND
 KeEs/bIZrGyPhx4SoEX8/ZjbI9xUBaXeUn5VaXxuSDRQ93LlJQ82wDPLXDbIORE73/qm
 iH9Ov7Ix2xtwLYHYc2jKz/4kucorJ+7LLXM6XzDnrtgN0ic70x+VJCkJYs89KrkXCh56
 FXfzfXlZEP3SqwokRm9HZ4FJcZGgvO8NAqYZlrf31d8mg6FsK3Ir+8HMNVse3WTPlwCQ
 gR1quffDXWYyGZWCMlBTPVR58RX+dfnbRNBq+/E1TmrwV29Gksc62qvekaDdQixKSYqS
 v6XQ==
X-Gm-Message-State: AOJu0YxqHvg1Qn0DA9klqtdG+BCwz6khduUDiKI3P/aeozAq3x17UY0d
 pV4XmbtXZhdmDNXAT30C9qkxIabEqdCLVWQzsVECRkXj9bhbJvLE
X-Gm-Gg: ASbGncvnrNy+kDRZq2mBIMw1DkDxf14Kw8QvzOvRBjXOKNFkmqLVDEijTpvDPM6aHxb
 Puop1vV0c7YYcQmIG91eN1bnEPRFRyaLoXWxOkpO/hRYaAC3xTDzl6Iod7YRgS539Lv6d/pkQDI
 u11EAgv2n/Go4sdrfCK3aZD05+o7oDBbuOCAEWo0yue95j7wNIqnVSEP81K+OdAU5ws6AmUHnl9
 6qXbH+FG/oYR/6nNwweTDn/xC2DzqrNuITWNTYEWUqNamU+WMz9rw2KXr902DEg1zS2yA49a239
 cuVB2y1pa2Ll4il538CclEPunN0=
X-Google-Smtp-Source: AGHT+IEDodUXqiGrUaU+WSstg28hlFpPtJF9Y7g1O1mE4RrMWLQt2RZBjrvNBPAmPvCtaf6hpIOkCw==
X-Received: by 2002:a5d:5886:0:b0:390:efa5:9f6 with SMTP id
 ffacd0b85a97d-390efa50b8dmr965399f8f.51.1740730572272; 
 Fri, 28 Feb 2025 00:16:12 -0800 (PST)
Received: from localhost ([2a01:e0a:10a:44e0:93c5:f3b0:4ae5:83bf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6d17sm4384917f8f.28.2025.02.28.00.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 00:16:12 -0800 (PST)
Date: Fri, 28 Feb 2025 09:16:08 +0100
From: Benjamin Lemouzy <blemouzy.ml@gmail.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, alison.wang@nxp.com, sjg@chromium.org,
 trini@konsulko.com, olteanv@gmail.com, Benjamin Lemouzy
 <blemouzy@centralp.fr>
Subject: Re: [PATCH] board: freescale: fix LS1021a build
Message-ID: <20250228091608.7c14c49e@gmail.com>
In-Reply-To: <20250228041001.GA30605@nxa18884-linux>
References: <20250217153603.100767-1-blemouzy@centralp.fr>
 <20250228041001.GA30605@nxa18884-linux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Peng,

On Fri, 28 Feb 2025 12:10:01 +0800
Peng Fan <peng.fan@oss.nxp.com> wrote:

> On Mon, Feb 17, 2025 at 04:36:03PM +0100, blemouzy.ml@gmail.com wrote:
> >From: Benjamin Lemouzy <blemouzy@centralp.fr>
> >
> >Fix build error "undefined reference to `is_warm_boot'" when
> >ls1021atsn and ls1021atwr boards are built with CONFIG_SPL=y and
> >CONFIG_DEEP_SLEEP=n.
> >
> >Signed-off-by: Benjamin Lemouzy <blemouzy@centralp.fr>
> >---
> > board/freescale/ls1021atsn/ls1021atsn.c | 4 ++++
> > board/freescale/ls1021atwr/ls1021atwr.c | 4 ++++
> > 2 files changed, 8 insertions(+)
> >
> >diff --git a/board/freescale/ls1021atsn/ls1021atsn.c b/board/freescale/ls1021atsn/ls1021atsn.c
> >index d1acccec11..6d64df7cc4 100644
> >--- a/board/freescale/ls1021atsn/ls1021atsn.c
> >+++ b/board/freescale/ls1021atsn/ls1021atsn.c
> >@@ -159,7 +159,9 @@ int board_early_init_f(void)
> > #ifdef CONFIG_XPL_BUILD
> > void board_init_f(ulong dummy)
> > {
> >+#if defined(CONFIG_DEEP_SLEEP)
> > 	void (*second_uboot)(void);
> >+#endif
> > 
> > 	/* Clear the BSS */
> > 	memset(__bss_start, 0, __bss_end - __bss_start);
> >@@ -181,6 +183,7 @@ void board_init_f(ulong dummy)
> > 	enable_layerscape_ns_access();
> > #endif
> > 
> >+#if defined(CONFIG_DEEP_SLEEP)
> > 	/*
> > 	 * if it is woken up from deep sleep, then jump to second
> > 	 * stage U-Boot and continue executing without recopying
> >@@ -191,6 +194,7 @@ void board_init_f(ulong dummy)
> > 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
> > 		second_uboot();
> > 	}
> >+#endif  
> 
> Please use 'if (CONFIG_IS_ENABLED(DEEP_SLEEP) {}'
> Then no need guard 'void (*second_uboot)(void)' with if defined.

I was torn between using the new syntax and keeping coherency with the
rest of the file: I will always use new syntax now!

I saw you submitted the V2: thanks for that (and the review).

Benjamin

> 
> > 
> > 	board_init_r(NULL, 0);
> > }
> >diff --git a/board/freescale/ls1021atwr/ls1021atwr.c b/board/freescale/ls1021atwr/ls1021atwr.c
> >index cc9665c041..937e766069 100644
> >--- a/board/freescale/ls1021atwr/ls1021atwr.c
> >+++ b/board/freescale/ls1021atwr/ls1021atwr.c
> >@@ -410,7 +410,9 @@ int board_early_init_f(void)
> > #ifdef CONFIG_XPL_BUILD
> > void board_init_f(ulong dummy)
> > {
> >+#if defined(CONFIG_DEEP_SLEEP)
> > 	void (*second_uboot)(void);
> >+#endif
> > 
> > 	/* Clear the BSS */
> > 	memset(__bss_start, 0, __bss_end - __bss_start);
> >@@ -432,6 +434,7 @@ void board_init_f(ulong dummy)
> > 	enable_layerscape_ns_access();
> > #endif
> > 
> >+#if defined(CONFIG_DEEP_SLEEP)
> > 	/*
> > 	 * if it is woken up from deep sleep, then jump to second
> > 	 * stage uboot and continue executing without recopying
> >@@ -442,6 +445,7 @@ void board_init_f(ulong dummy)
> > 		second_uboot = (void (*)(void))CONFIG_TEXT_BASE;
> > 		second_uboot();
> > 	}
> >+#endif  
> 
> Ditto.
> 
> Thanks,
> Peng
> > 
> > 	board_init_r(NULL, 0);
> > }
> >-- 
> >2.43.0
> >  

