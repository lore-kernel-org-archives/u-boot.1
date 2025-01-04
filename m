Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF860E77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 17:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF768056B;
	Sat,  4 Jan 2025 18:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lIs7lJM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559E48056E; Sat,  4 Jan 2025 18:05:46 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C350803DC
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 18:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8DBBE5C57A0;
 Sat,  4 Jan 2025 17:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7002EC4CED1;
 Sat,  4 Jan 2025 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736010342;
 bh=go+qBVVfIVlCZFtcIvS9ndeSXgtPqBJTbu0CcTy4eRs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lIs7lJM+ASBhoE4jRDZ+fjQncLkt2Vci+xXiLj6mOLR9m6MWWjufG9JE1sMc0GeCw
 YwwzADfYzjfTYEIZjSQI/nxxrlf1iQlAqvoh8FsJta692NBMB7t4uxkqsInp3tI2pH
 D8oVCFC+LfPJRR8rrzzVc3x4sNIQsDZOnVyS0HI/7TcHhhXIpu3q8gJgB1mcYQjGO7
 D4Dm/CPPd8W346UsiPBLNLI+AhNU1c4AztdIR79ahVJ8adZ+8BQ61w6B4xSaq2ZR/A
 eltNunUI1wGhf6Oxzr5sawlHkxQrrKccNc8Laie+iOe+OiWkTphJbk3dCD+elFxBTw
 3a7u80AJhBhow==
Message-ID: <63829810-b338-4e5f-aa48-ad371f60d01f@kernel.org>
Date: Sat, 4 Jan 2025 19:05:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: am62x_evm_*: Set DFU buffer size to 256k
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>,
 vigneshr@ti.com
Cc: u-boot@lists.denx.de
References: <20241220215334.372542-1-j-humphreys@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241220215334.372542-1-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8
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



On 20/12/2024 23:53, Jonathan Humphreys wrote:
> OSPI flash writing was broken on am62x SKs as the OSPI flash device has a
> 256k sector size but was set to 20k. This breaks OSPI flash writes because
> the current implementation of the SF DFU backend requires that the DFU data
> buffer size be the same as the sector erase size, and the USB DFU config
> fragment (for both A53 and R5) reduced the size of the DFU data buffer,
> presumably so that it can fit into SPL's much smaller heap.
> 
> Change the SYS_DFU_DATA_BUF_SIZE to the erase sector size, which still fits
> within the post-relocation heap size in SPL.
> 
> Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

