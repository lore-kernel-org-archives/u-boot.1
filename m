Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D92C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4FC83AA6;
	Thu, 10 Apr 2025 10:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kjSoRpdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A58D83AA9; Thu, 10 Apr 2025 10:49:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A1983A98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EF1A75C4BBA;
 Thu, 10 Apr 2025 08:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD8EC4CEDD;
 Thu, 10 Apr 2025 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274959;
 bh=2zGnYB9ZsuE6hhcJQdOy8qhTNNsw0bwtB5jnwzsQFdA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=kjSoRpdPP6VtiHn2SZI4DfPMQjpJnkeI5+6fCLOQ0+945qKIYphnHIgt490G02dhU
 eb0yT6zeq/8kb8HwtK5cck356ltQHmoX87404ZmWAj4TkTMfeKgAYOtUY5nhQn3v6f
 aFnydXddQh2jNKDaMyW7wEnvLTdDKsWvMlNgTbS0A5zcfjidxIGNgNSpb4nQL93i0y
 3DqVdW5KJ/pYWjDkC/390yICmLs9T1jSxyPS4PWGGHseFU32Zpc6tLquc+aRAOcMTG
 6u9XrzMkUB0xPqxPpo3cXRhhmT9knV1ty7bffI7WdaDhwF00TxaO+hyZUmTDVimSQt
 0gxHvepWCs+4A==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250331162611.1557759-2-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-2-admin@hifiphile.com>
Subject: Re: (subset) [PATCH v2 1/3] usb: gadget: atmel: Add SAM9X60
 support
Message-Id: <174427495638.286402.9855514984625058076.b4-ty@kernel.org>
Date: Thu, 10 Apr 2025 10:49:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79
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

On Mon, 31 Mar 2025 18:26:07 +0200, Zixun LI wrote:
> Compared to SAM9X5 the only difference is the DPRAM memory from the
> USB High Speed Device Port (UDPHS) hardware block was increased,
> so we can reuse the same endpoint data.
> 
> Also add compatible "microchip,sam9x60-udc".
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/3] usb: gadget: atmel: Add SAM9X60 support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dc22cf37af6d604513f8c6f02d4cb551d5a59435

--
Mattijs
