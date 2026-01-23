Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE0D778BC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 22:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C000839DF;
	Fri, 23 Jan 2026 23:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MCKGVldD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02FD183A6A; Fri, 23 Jan 2026 23:33:21 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA368397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 23:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45c733ccc32so852458b6e.0
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769207597; x=1769812397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fg8H4oHQMzkJOVkvlgk1JvUZHcS3fpIn9Ksuu/DMB9U=;
 b=MCKGVldDp1ZYpcsKHpmL7o8UQIgXs4prGZyaB2m1lYPdm6wwF7k49ZoV9W68JdnVvY
 c6hbF0KhjIz2jE0h2MsDO6TGPISfH3XzMF+KwXJbrx4Z85yWvGSN2PZNy8ftdmpwhSXb
 4bRMXXkDqmo/6lKIoF88Lmm+TX1THS9upUU9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769207597; x=1769812397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fg8H4oHQMzkJOVkvlgk1JvUZHcS3fpIn9Ksuu/DMB9U=;
 b=J6UmVc4RZ5a/9CHPwDnLimFEDqGZfOAQ/GS7WOrShq/9zt+rzoj8kmcup5FfGuNC8U
 nEDeru14dU/WmLuXbJLrGd+0dgHbLII+hxODE77oUGG+zpMJrA7upR+z8kvwpkrSYPmN
 WjBLREcD2dAu/USW6sAhx5Cmh2IHucThOb+OfoeeddEInGdpsXc5pLoMnGQNs3Z2QR3k
 XJoSzmHeA5tEQtD+WyTRI2I59yvtjbF/kdcmUBAbFczfMYOa+1gBanfRpLXT9xxD4X+y
 GAGMlcd9t4JYcrxnGwDcYEeCyk4Ye9atsG/CQue2YU+X7hpqC86uz5KcMxF/WGhoFBlp
 ZASA==
X-Gm-Message-State: AOJu0Yz9ZgNH6GBjArEF7guWFaRsRMoDK9ggaNPjOVKcsPwdXXIta6Bj
 RpCkbrvw35CMPh1HcSZt3lkmncYevAdPV3alfgDhxDbAqwGAel2qKvWAlRxEwW1EOLA=
X-Gm-Gg: AZuq6aLyTelj+SpBTqCbOE9uTJs2/GvkH3ILW+11qgYbM0T/Yg6xEqwN8GoD6VHe7KQ
 k3oe8IPnrNqvy0SkTLen/d8DH6+R8+Gp/HfMeXcvX0G4lCw76FnGvHsif9fbh9wCpqo0jV5fIjD
 Iy0oImJJ6UzuSCBZiad35v0BFGqo958u0oLICgg0N6ZJ6c24vjmMIy6IzFQJEHi+FRhklmx7KZO
 BP3wXH8UaNn3ugRUjYJBlWzXCND+4yTQbulgRL8oRnRA0evYDGuyzM0jQ3DL0x6ioCFevfC9yvr
 +wIrFHdl3X72yzXxXc87XjnSBPFqsiYCM42hm/gawbdi/K2Ky11sJ0C/RiC6/Gu2BGM7Nk8KKDa
 ezcpsTITa0JZPKDeRMqO6SQSJH7McDMac8z9R7J1c4Cb7rFwGpYFsynm+rwKYZFtdquRAuFjjqP
 RZt5YBlSpEtKQBbmvVPZTtHBIf7fA24ArdNYz1L1JjrKJvNQ1+HieyfNhwFSo15v1/Z3jbjlSKM
 r8oLwWQ8sGhoXwxFMLj6zwU9l7J7bvjrg2vQg==
X-Received: by 2002:a05:6808:250e:b0:45c:71ff:1f6c with SMTP id
 5614622812f47-45eb1cbaf28mr2328241b6e.35.1769207597325; 
 Fri, 23 Jan 2026 14:33:17 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eb40e32desm1900894b6e.5.2026.01.23.14.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 14:33:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: adsp-linux@analog.com, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Caleb Ethridge <caleb.ethridge@analog.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philip Molloy <philip@philipmolloy.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, Yao Zi <me@ziyao.cc>, 
 Jerome Forissier <jerome@forissier.org>, 
 Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
Subject: Re: [PATCH 00/12] sc5xx: Add complete board support for all ADI
 SC5xx boards
Message-Id: <176920759551.2792764.4393744502494646019.b4-ty@konsulko.com>
Date: Fri, 23 Jan 2026 16:33:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 11 Dec 2025 03:03:51 -0500, Greg Malysa wrote:

> This series adds the final pieces to enable mainline U-Boot to build and
> boot all Analog Devices SC5xx SoCs and supports the associated carrier
> board options. At this point it should be viable for new users for these
> platforms to start with the latest version of U-Boot rather than our
> vendor fork, however some features (such as OSPI support and falcon
> boot) remain unavailable until we are able to unify our implementations
> with the mainline implementations.
> 
> [...]

Applied to u-boot/master, thanks!

[01/12] mach-sc5xx: Introduce Kconfig symbols for image addresses
        commit: 280dbbbf6e4645595015c2a15add6dcc10795b4d
[02/12] mach-sc5xx: Rename SC_BOOT_MODE
        commit: ca8cceb12f10253e73141a136ca3dcd7f1f85927
[03/12] mach-sc5xx: Kconfig: Make EZKIT and EZLITE carriers mutually exclusive
        commit: e01743624ef9d1de087f82352cc52e71ec3d8812
[04/12] mach-sc5xx: Add preliminary support for binman
        commit: a6927e717565ebab18fcbba3cb9a50457119d83d
[05/12] docker: add Analog Devices tools to docker image
        commit: b36007b01620905f16eff864a09140adcff670fa
[06/12] board: adi: Add SOMCRR infrastructure
        commit: 48a45b74aa56b65c6d5776e2c5c4fb3c4bda3ee8
[07/12] board: adi: Add support for SC573-ezkit
        commit: 34d41f8da617ad9ca4527fac7764671159463b4f
[08/12] board: adi: Add support for SC589 boards
        commit: e382cb2be4ef6f205b6f3231801ee2d7d24d2906
[09/12] board: adi: Add support for SC584-ezkit
        commit: e1d6232874f663c0db758567f77d0ddcfd9da4be
[10/12] board: adi: Add support for SC598
        commit: c9e893d6266dc83dd053998cdf73957b623e2eb5
[11/12] board: adi: Add support for SC594
        commit: be7937847b7ca0e1ac44a1982c58343a3a8ad0f3
[12/12] MAINTAINERS: Update ADI entries for new boards
        commit: b0df2df8d4787b60214987d06fff1410beca26fb
-- 
Tom


