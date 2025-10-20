Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05FBCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C74282E34;
	Mon, 20 Oct 2025 19:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n2wqYRrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB02A831D5; Mon, 20 Oct 2025 19:44:45 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 552D482C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 19:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-651ca14a092so1692795eaf.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 10:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760982282; x=1761587082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rNPaLTW8EJuNLHqpytNFzCACfm9LAqHpC2ehwOgIKQ=;
 b=n2wqYRrQY4U/13ZClZFm1mHcfmtCBGIUtg4lSzG9/mpV0od2IvJj1p3se0laxTLi5R
 s1WvPr2x1vuuCttUtq/GUedYCiRHhJVlTrwNPaDADJKkUR8Liyp6WRZsviudpwdXUU7c
 pl9MkEtf8ELm5DwGtkbEScH8K/1wGpHmhET3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760982282; x=1761587082;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8rNPaLTW8EJuNLHqpytNFzCACfm9LAqHpC2ehwOgIKQ=;
 b=NAPStFHfroz9em0k8WBW56D5SxYC4O0MdXqYDa3yrNZ7y1gHmSl1FO1FoK4tTieW7G
 eWSkg9PdoNW8GoYmi2hRWYC30rTlIrdQqah5h5KRdcsjegZ6bIBNPm88sXLBI0mOTxX0
 5SttRLu0qA79Bz0B5aRzQdLXNEAKbVA+Ebt8G81bKvBTyzAqWtRV9K/TjBWSuxHK1igc
 llIYU9sz35BRz3wT5z6Y7gBO3OMJ3l7+DDT2CbOcsokLmt9RVssRJpZwi7fElikkWYcn
 r/VG1cmDdxW4DX4aPsEQFd4FEBHkoWCJX93Ot7WpvRrgwxhtItW6NRCOge2BNB3hSDWR
 67qw==
X-Gm-Message-State: AOJu0Yw1cK4mmdi1cmDtQzfY5mHGVNvipGFFHD94nnrSXtwoMQHQaMbg
 zHCBg/gZt5jyo4KQIyEEXxUOzfLIE1ZKGJAQldc2lt+w7OeVignH0auFoQfYmOmnS7g=
X-Gm-Gg: ASbGncs5x27W1rdg6+navg/pSufRscol4x2OJCPxYrJLW49y5trq/8rhUSSvmJCcszQ
 2uQ96gq6NSY1W/OFpVYzbM5Jg/hymowLilVtNcaam7mDvh7Ml+iv8UFN4EBcNMhEX3Os9GYU2ah
 rrqC625QSRWDmXxdYyTZqKIrCLB2HvnNu0E9N2irItueGw8g6TxqnxaSD3wWNupuy/2+edmIof/
 cUqZPI07mpfB1q5WbVgX8DwiF4+af5VNME3CGH/PF2YQdylkZbMDLHNjQKwRcwwEBc0wY/1WSkW
 k/bxn2jONR7M3UhEixMw/93nkpd32AcxG1UkDnFNifO2pe/+bv8XvMgQP3Rtvtfqqzw+goJ6Ohf
 5gQrPw4T0RHFO4Zva11fFC7el2GYw8ebcsF3JVmMEPVFEhvZs6iAJ53LTGj+NFP7atnqaNts9cf
 oS5WwE2z5obAhWdMD0cCrzQj/myCTiFDiETgAidjqPqnSSaEOh
X-Google-Smtp-Source: AGHT+IEUexmP0N5IDY/qxvi/ZHjKAUxnwaZXSU831EkE6/5e0U1rwH0ab1KvV7zv3ssDxO+hZQOHlw==
X-Received: by 2002:a05:6820:201:b0:650:130d:1664 with SMTP id
 006d021491bc7-651c7e6b63amr5835808eaf.6.1760982281974; 
 Mon, 20 Oct 2025 10:44:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c28879ec63sm2856455a34.6.2025.10.20.10.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 10:44:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com, kever.yang@rock-chips.com, 
 hl@rock-chips.com, tim@feathertop.org, marek.vasut+renesas@mailbox.org
In-Reply-To: <20251017193318.4124997-1-anshuld@ti.com>
References: <20251017193318.4124997-1-anshuld@ti.com>
Subject: Re: [PATCH v4 0/7] Add support for secure falcon mode: disable
 fallback
Message-Id: <176098227993.2643491.1631230898000604603.b4-ty@konsulko.com>
Date: Mon, 20 Oct 2025 11:44:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 18 Oct 2025 01:03:05 +0530, Anshul Dalal wrote:

> Continuing from the last series[1], this patch series addresses the requirement of
> allowing no fallbacks in secure falcon mode.
> 
> To do this in a clean way, all the falcon mode logic for each boot media was
> refactored to a corresponding *_load_image_os function whereas the regular
> boot is implemented in *_load_image, this allows us to easily return early in
> case the *_load_image_os function fails with secure mode enabled.
> 
> [...]

Applied to u-boot/master, thanks!

[1/7] spl: Kconfig: add SPL_OS_BOOT_SECURE config symbol
      commit: a3e67a96452983ae3b35a78cb2910f14fda9dd86
[2/7] spl: mmc: split spl_mmc_do_fs_boot into regular/os_boot
      commit: 2909b3bff076746938389b2ef320eea68c2b93db
[3/7] spl: ubi: refactor spl_ubi_load_image for falcon mode
      commit: 81951cfffdc85e07ddeb2fa33a1a0fbbac6806f0
[4/7] spl: spi: refactor spl_spi_load_image for falcon mode
      commit: a6a801fcd6cf5c484f8df6341573e364ddc948c7
[5/7] spl: nor: refactor spl_nor_load_image for falcon mode
      commit: b5446fd4787432ce3aaa9b974760276d9b0b01b5
[6/7] spl: nand: refactor spl_nand_load_image for falcon mode
      commit: d9a50f8f14a5e052c0731492d8223dd3b8332a8b
[7/7] spl: falcon: disable fallback to U-Boot on failure
      commit: d3ac0d60da066bf4ddb5a60174be8108fdc16862
-- 
Tom


