Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C083D111A8
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 05:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB33B83971;
	Mon,  1 Dec 2025 06:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="SjvciYnm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF9883979; Mon,  1 Dec 2025 06:53:17 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C368E83966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 06:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8973D10BC1E; Mon,  1 Dec 2025 06:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1764568394;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=PobFTt8vetFnPW2MIOISrb86XvG6Jju7P14ev8+KZy8=;
 b=SjvciYnmwZbY0kTScSFL9YXoEi19Vq0f7ybp9hn+g9acLSfsEk+kg8o9Zyz0fsB6B6mWVh
 sesSqbvLo6xyLAWhhsSGYLAEWyhpuokS8fKQwNhQWbuBAzdkF0gBImZrNGVxf/gsT+JwZf
 uDDh3rVAMg1WSRvEdBWjx+DmpcBUhLDl8VYQcHrSs2KtJOPbR/8zDADXoK++92oyFcAFTT
 BtoVDBm48m+BsqyFVLO/FlOfbMoSPx8y+pvB4en8oPEPjIXCLdj7hKOzWTkLq434RAJjDi
 qVhY42hHt1GZn4lrNhEgCgp8PNBVRAuBhZ9l/5HB4kcYTlLcIP8y9D97m0tqDg==
Message-ID: <0f467b11-0b5c-9a95-149f-255c32ca69a2@nabladev.com>
Date: Mon, 1 Dec 2025 06:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: cdns: Add timeout for RXDV status bit polling
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>, 
 git@amd.com
References: <ba53d57c179f3390b32bc6094f3ffb5f4cde931e.1764169953.git.michal.simek@amd.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <ba53d57c179f3390b32bc6094f3ffb5f4cde931e.1764169953.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Michal,

On 26.11.25 16:12, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Add a timeout mechanism when waiting for the RXDV (Receive Data
> Valid) status bit to be set before reading data from the FIFO.
> This prevents infinite polling loops that could occur if the
> hardware doesn't respond as expected.
> 
> The timeout is set to 1000ms (CDNS_I2C_RXDV_TIMEOUT_MS) and uses
> the wait_for_bit_le32() function to poll the status register. If
> the timeout expires, an error code is returned.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/i2c/i2c-cdns.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
