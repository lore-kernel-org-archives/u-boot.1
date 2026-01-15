Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3496D44C51
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FD1D80325;
	Thu, 15 Jan 2026 15:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZ9vJZBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C206183015; Thu, 15 Jan 2026 15:39:09 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD2680077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:39:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F04A0409C6;
 Thu, 15 Jan 2026 14:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8690CC116D0;
 Thu, 15 Jan 2026 14:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768487941;
 bh=F+Y5ncz1EcXeLz1ijmrLHgp9wHSxD6mh+cAK+gUeg24=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=MZ9vJZBgoPZnXsTOBQaylGbNf2ENrxy1YBXwJyPWR9xaMmHUklkgSZqq8Z+VsYGFQ
 wN5ODCgWlOg94uBXtW50h6MluYhVaOU5PLMk0D7NEUVN8lmRbZaXJLQA/W3xktuONY
 +IfkLquN6MDp16/xwFLk/9alWeDgsG49kWunrO59R2SA3h0w5VUr/kJofgDm9RYfsq
 yTmX3E01YB/J/JvbwVWpbcxWKgMCNDf2zMs/1UQ8TIFjM5vedflaqQBj0B8Qp5pfan
 KU1W5B08b6p+LKeknkRI2s803/LKo/5ZL4YlVQLuRb+7Sqf3/HusAYeHTf10MBmHGH
 L/8G6AOSVbvyQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Maxime Fournier <mfournier@baylibre.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jerome Forissier <jerome@forissier.org>
In-Reply-To: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
References: <20260112-bootconfig-v5-0-79b242159ac7@baylibre.com>
Subject: Re: [PATCH v5 0/5] android: add bootconfig support
Message-Id: <176848793953.800740.6208131084197077272.b4-ty@kernel.org>
Date: Thu, 15 Jan 2026 15:38:59 +0100
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

Hi,

On Mon, 12 Jan 2026 11:55:36 +0100, Guillaume La Roque (TI.com) wrote:
> This patchset add support of android bootconfig partition[1] in u-boot.
> With Android boot image v4, all androidboot.* arguments must be
> passed via bootconfig instead of using the kernel commandline.
> 
> [1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/5] boot: android: import addBootConfigParameters() from AOSP
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/6b0f079ba260b37a5b3577e6429ba721070ee2bf
[2/5] boot: android: Add sandbox memory mapping support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/8f6d43557056c73469c1e70d2949ebef6ce5ce44
[3/5] boot: android: Add bootconfig support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/733f5a601989f5404947c4b268d40724bac414f6
[4/5] cmd: abootimg: Add 'get ramdisk' command
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/892409d4fc04d585fc974e33ef63b735d401e11a
[5/5] test: abootimg: Add test for bootconfig handling
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/75e8e42657d4f3d2f8704f6f61de1aa54efed815

--
Mattijs
