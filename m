Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5149EEB565
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 17:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B420C8416C;
	Wed, 31 Dec 2025 18:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DjAoUbJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2507D840AE; Wed, 31 Dec 2025 17:31:49 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E487E840CB
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 17:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-34c1d98ba11so11745160a91.3
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767198705; x=1767803505; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7DcXANPyfdO0tl4mMgQIElKgCSSTem6EhVY+kgegWwY=;
 b=DjAoUbJ6f5tcvRAgvuPvUly5PtsWXwBzoqE0kHhGYqFogWqS7SshmVKiT3rghMKvU4
 5tBHL2lli/xfP61t6eo+TR2HHtEvNWmY5GGTdj3Qy7/1me9lpmLzfcrxX/0TvXmvTuCN
 LefxWv5AHqHhrghArmDjgRZZP1p3K8astm6MrK+eGTD4K4d7aiXKqBFZGECeW5yT+EGa
 fMiWKixY72/SkwtShV4W2wzGJtJ695wik0iQqfagxh4nfbQebuS+fmBCUr4T9BsKBLkc
 6yKkeXbHX1hOeTf/3wHwCl603IWjRPnakQnANT9j/ZodriIguh8Tm3fZMf5bUZP3v/kR
 8YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767198705; x=1767803505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DcXANPyfdO0tl4mMgQIElKgCSSTem6EhVY+kgegWwY=;
 b=HdU9eJFQquwulaAYWncNWiuv58OAmNOpkcbFARMU6gIRyNuxKVtgWoazVp9NozZvaC
 mxpI2BzoU0V6EAFY+6cQZONVeZkCfalft9ySROkPCbPsr8DP5zT/I9z29nBMfOwztMbH
 d2G2SErA11AuMDfwzyjE3tF0ETk14ByGLsQEhlVYt/MhOqbkX9Zz5m4ArJgoDFot6pep
 4VsIjH98BWIk8r66nu9CFULksP/8BbOhwNGkJAenzq7Fw8Sfk1KniJ092nW7ciJZGF7o
 7PCWYKQeKIZf+uOvo4svnfZaQk1wZj+0V4yOC27wl58ZxEHcDSlMZMZxGghbeFaFk8AM
 fayg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBL3i2EE8T6QqCaMPon47X3njWaCFiiwx3ML6/9F45qHtfEE21qX4bTbnPN946Du73GJIRErg=@lists.denx.de
X-Gm-Message-State: AOJu0YxBYf96ZDbOHgJQysUN3TcaqITI76cCgBXGjlRJcSQThbyeIToQ
 ssx4JU//Yg1EvVK5v5Qu9JP9GilH5/L/0k2JXn9IN2eMggh2e+rwmdNp
X-Gm-Gg: AY/fxX5yebiB+qpfHNL5+nrUH58tOSJdrsLmBG2cNr5/qWpD8xkLfDo7Sitpg5Xymio
 djx9Mc7egVyJ/iJVK9If3cvaynxZnH77tu5cmF9RlAon9HsC6p6KISQUwR4kByseh1E0MeVPn5g
 9ExEEX3F3s0gKFr5GZqd/btugrJXItgo9FZXV+NwtFmx5bsT2Zipzbx+0wV2ddixkLL7jdgqDAZ
 fmeI4400cYYb8JjGEv6MVq28TcDtHl7BF/oGpxdc8UIZilJ/VGs0oZH+VjBTCu+0fVJosT1+319
 pH4HzJ8Y0IMDbKWsgTyWdtESk8N/UxLnwB+5eJ+rVITBUgozi+mHVW/dECWX6x6L3bzJ4UDu3sV
 j0DtW8DbGCfgoIq3S2016qDeDLFIaaTqsjWkes0UXK9McwhqcRFO/IhvHP+aUNMp1dWVVTUucPJ
 eBhZi761EXk/YCr26uP0+dOZV/
X-Google-Smtp-Source: AGHT+IHv2HwPStQ5SVfVDuyhJ62ZWzcPe2SbtV/CNc6m+y1J3Bk7FW++BPOu/n0YRdbL71q9uTkPQw==
X-Received: by 2002:a17:90b:54c8:b0:340:b908:9665 with SMTP id
 98e67ed59e1d1-34e921ed466mr32708242a91.37.1767198705249; 
 Wed, 31 Dec 2025 08:31:45 -0800 (PST)
Received: from google.com ([2402:7500:499:de94:671b:a2e7:4f81:f445])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e92228b64sm33184210a91.10.2025.12.31.08.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 08:31:44 -0800 (PST)
Date: Thu, 1 Jan 2026 00:31:40 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, me@ziyao.cc,
 daniel@0x0f.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [u-boot-test-hooks][PATCH v2] travis-ci: Add config for QEMU
 m68k virt machine
Message-ID: <aVVP7LjBqbfY1Q5P@google.com>
References: <20251230160651.3049301-1-visitorckw@gmail.com>
 <20251230161545.GU710860@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230161545.GU710860@bill-the-cat>
X-Mailman-Approved-At: Wed, 31 Dec 2025 18:47:14 +0100
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

On Tue, Dec 30, 2025 at 10:15:45AM -0600, Tom Rini wrote:
> On Tue, Dec 30, 2025 at 04:06:51PM +0000, Kuan-Wei Chiu wrote:
> 
> > Add the configuration file required to run tests for the QEMU m68k
> > 'virt' board. This setup uses 'qemu-system-m68k' with the '-M virt'
> > machine type and '-cpu m68040'.
> > 
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
> > Changes in v2:
> > - Rename to conf.qemu-m68k_na
> > 
> >  bin/travis-ci/conf.qemu-m68k_na | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >  create mode 100644 bin/travis-ci/conf.qemu-m68k_na
> 
> It would be good, but not a big deal either way, to also leverage
> py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py here. And I say "would be
> good" because really, we need because I'm not sure it will add any
> coverage over what we have today.

I checked py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py and it appears
to be primarily for network-related tests. Since I haven't implemented
virtIO mmio support for network access yet, I think it would be better
to introduce such tests in future along with the network support?

Regards,
Kuan-Wei

