Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C169CE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 13:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D21B80269;
	Wed, 18 Dec 2024 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="s/rkAXZZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2D48029E; Wed, 18 Dec 2024 14:48:25 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8FE8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 14:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CE085A42635;
 Wed, 18 Dec 2024 13:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FDC4CECD;
 Wed, 18 Dec 2024 13:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734529702;
 bh=6K41V06Xw0Hd0RRZe2OnBZYf1p7Jxw1P4VUzwX9dpFM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=s/rkAXZZBJBkp6DkB0tPT2vCn6fCS/Jof4HMLjvRcWSUwcGQ+qanH2YfJeEwV+z7h
 Rh6GW8Wd7SgNGJZSSff3KhcwgEBPp8JMRHYCIAsBOvWQcBLt5DBAryDlNjMkdg0PYt
 R0fHOE7sgt5FhLW0qAJkOP69iQcgurDe2flcE9MRUyv2I/k+8zA1rI8UZcR9yP5+aX
 8zW+dzwjY9lnGpMiqfTfx6zlTioEv4Ornw6hY/TaPhaaebvoI4Ear7ZYreZSFwXTZA
 LjiJfzGfs5SWE2vc9xpP/5E3Gf7FLbB/7jqf1t5x9/eAgZSFJyc4iKKkxWQI9TT3Qr
 Pq+uu/fpWrYUQ==
Message-ID: <37bac450-af35-45d9-bbf1-fa21e744f20d@kernel.org>
Date: Wed, 18 Dec 2024 15:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] board: ti: am62px: env: include environment for
 DFU Boot
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241218124542.3519447-2-s-vadapalli@ti.com>
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


On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> Include the TI K3 DFU environment to support DFU Boot and DFU Flash.
> Also add "usb" to the list of "boot_targets". While at it, add a newline
> at the end of the file.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

