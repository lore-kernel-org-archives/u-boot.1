Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9FDCD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 14:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3EA284862;
	Mon, 25 May 2026 16:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VryhOHXm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B7FB84866; Mon, 25 May 2026 16:30:29 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C7684841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 16:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso1719369466b.2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 07:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719427; cv=none;
 d=google.com; s=arc-20240605;
 b=fChUhzS4thIizW14g765po/RpzqraVm/k3qqgFDgcxy1/5wDPmbJLOngMoP1+IBsgH
 y3yUA0SsGt5LfKKGS3Ls6qPH0BdFEbgusRhic+RXuVwbVfxxiRHddlvUIm80ZJDuiA4y
 RR47x9kZLXZA/mIdCHQQ3EtSiflXriVhxF/BDEat77Drtf27qdZEMxWlZ99nfz6pusg8
 BVK8j7MkHSiuCmdOECTkxawZ4RbtNENT8J/zt5ifFUFrOu1PcSG4HM0Q15qL7Rr7vRcy
 AyaG96kEehrZ4ZiFVlMsNEZTlBsTxBYq40Cei1Z2Y3EUJRb02dVDXRMd16PzZJXLwPhF
 XVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vnVqazZdsO8ZHbOPFXR86fTiMCald25Y1Azti0/dV7w=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=QaOFdrffBQ7CQ4JhdaDSwTlgzvW/HrwOCnhxLITC0d0oBKpcmJc2bqggUeeDToDOhN
 oWOvQEdU1gqVZCcLodxjTHbG0/0wMRpoUubFrkxCa2ty7egJLuWmtGRvGuvrqycL2cQk
 eL9Gg/ZfADN2WMtX+lOQ0No7rTC0dCe3sC1e7S3Wp9Ugnd7THgSwyOfGf6LnhnTAcdpY
 44PDxgnOUm7C6gsOVPFo9QV0fRMQeIbPMP9fv7hvJbsViybUu9nuhR+rywaFELTy37Wj
 hlkVIC2m2LYVZsoLk8iTnLDyRBZKztztZgouZ8GilTbIiUPKtGHKSc6oNjHUKnuyl8RK
 4k/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779719427; x=1780324227; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vnVqazZdsO8ZHbOPFXR86fTiMCald25Y1Azti0/dV7w=;
 b=VryhOHXmqaq8bMinjxA09buzINi0JAW3O+tuoWSJzzJrzHmqKnPF/G+rCWcD9K578n
 JrLYoA04EvFJOEEL3VVY1pVCSgpE7/j/XXYuUGqC6VDEadb2LGgtUrJnd39JIdcRZRvJ
 UTaDwGQBpyJamXr87JqAXKm5mNrZzmeeRxnU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719427; x=1780324227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnVqazZdsO8ZHbOPFXR86fTiMCald25Y1Azti0/dV7w=;
 b=DIFVDmMuqcPefGUprVnhAkH0vXGY0/j+8J73a2YeD6TaHWx65MBvz67S1GcesCc5UL
 CX8Qv2rbj+Fk7divK4fbAiOC9NSUWUwn999IhzVwYgYy6WVnt2sEWtncBKHsYk4maDxR
 dJz0oEks6Vh3lgAa1JhpWMCWS/BuHqDkMMD5A6A8EsS1wicMCzrQOA8IG69jL0FUqVzH
 6VqSd7OYqvxg6Pd+jX/9RGoPxWusch1SpV2gDy8/p8ucKAx9yxkQe5MxgL7Ni39sLnmy
 pJKmnKTp5yzs6UYtc21PFa+TgwEQITljOBHRSMxxZvydgHOM6mUIMHU3VoW1/cgCBUM3
 swQw==
X-Gm-Message-State: AOJu0YymK0weOTCPWpGm7fFVwv8P6wWX8GkCsCXOPYPqt6zkYsmUKNZf
 7Egy1S1KL/DFYdWcVIri2le9PktEVFArK3NUMPpsdtlpSDiCe2bsGS21cc2KljPhxZ3nVqi1OUA
 CwTVSrFl2fMFcOljtoJnVHO1/6KfVvcgLdFgSi1MR
X-Gm-Gg: Acq92OGPYykGn5ARQPN+rGhPxyPPRK0LOP31VHUWYPCiGG9w7LCY6NmKvkq6DlxwPw/
 c2bextD3xMTYYE/y734yiqrvg0jcOdBuo8jIJF3aHHzk1MsrwXHACY2ADarPNN4AD1wzfEme7XC
 3cKWV6/LAhuvAiG6VWWQdX77jLIh2/UKK1jf4TU5Y5FEABocRFmx0dMubGuv8azPGYy/t5fyS8e
 TLaIldhW8uo9UbEWSPg/Mv7eiVdgQh8tpeZm4inprVwLcd8hN9OVzIN/+P7rMAh2FprLPk44CjD
 izrDqmOljL+UdAWZpoVHO7IcTX0=
X-Received: by 2002:a17:906:844b:b0:bd5:2e64:afba with SMTP id
 a640c23a62f3a-bdd2580be79mr637219166b.29.1779719426856; Mon, 25 May 2026
 07:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-2-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 08:30:13 -0600
X-Gm-Features: AVHnY4LASc6IoVKJKtLvdzZTldr2CGrKPnkkYM-lmtC2dFVmbk6rp2Z5hn0h6xc
Message-ID: <CAFLszTim9bZvePN7XYx8UxQpvT8CnjzT5VUNd-mqwrXuH8bm0Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] sandbox: Drop special link order treatment of
 start.o and sdl.o
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
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

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> sandbox: Drop special link order treatment of start.o and sdl.o
>
> On hardware architectures, we need to treat start.o (generated from
> start.S) very special due to the constraints of being a program running
> on hardware in an unknown state. These objects are treated a little
> different than the rest by the linker and linker scripts on various
> architectures.
>
> Sandbox is different, and doesn't need to do that. In fact, it can lead
> to hard to diagnose problems because of just how subtly different the
> treatment is. For example, the comment about LTO in include/event.h
> introduced with commit 87a5d1b5d012 ("event: Add basic support for
> events") was only a sandbox issue because of the event in start.c and
> in turn linking start.o isn't treated the same way as an archive with
> all its sections considered.
>
> Correct all of this by removing the 'head-' lines for cpu.o and sdl.o
> from arch/sandbox/Makefile (and unused cmd_cc_sdl.o lines) and change
> arch/sandbox/cpu/Makefile to treating them both with 'obj-' and not

to treat them both

> 'extra-'.
> [...]
>
> arch/sandbox/Makefile     | 9 ---------
>  arch/sandbox/cpu/Makefile | 5 ++---
>  2 files changed, 2 insertions(+), 12 deletions(-)

> diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
> @@ -5,9 +5,8 @@
>  # (C) Copyright 2000-2003
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>
> -obj-y        := cache.o cpu.o state.o initjmp.o os.o
> -extra-y      := start.o
> -extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
> +obj-y        := start.o cache.o cpu.o state.o initjmp.o os.o
> +obj-$(CONFIG_SANDBOX_SDL)    += sdl.o

The sandbox-specific cmd_cc_sdl.o override already covers sdl.o once
it moves into obj-y, so dropping the duplicate block from
arch/sandbox/Makefile looks safe

Reviewed-by: Simon Glass <sjg@chromium.org>
