Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06FBCCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 05:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CBBB83956;
	Mon, 10 Nov 2025 06:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LUpBKmxk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EB383956; Mon, 10 Nov 2025 06:57:22 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6454E83655
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 06:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9936C10A0BB; Mon, 10 Nov 2025 06:57:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762754239;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=f8q41NH0EICloXeshM6ZMTT3+KCZU3/6OsbUOdXLUq4=;
 b=LUpBKmxkZ+zvzcptYunHihoHrl9t/CSczvKANmn5/jKIsi7NCNBa+nrp1VQqrzsOWe9RWh
 2KQGwySyL5neuyRQblVW5SoJgjp5dZEDc8ZkVXENw9YF0UlAD8c8+X1e3N5g+ACHRkT1rh
 tEymsKjRNuz0+xe2pHemTSMIDUSC8N8+xHjJfQOpskf/7WUeQOntQeZf1sGYqK+ZPqLqEl
 HEDIUJyobaPzonWM9pJ7nJgKqtoXi1Xf26Y18Br8SSdqMG9e0lvvgy3gNMZeUFQCh8AXny
 aeE7wExct+SYWacV8m8tLpHdzfz5c1dF3MEO4hCcIiZ+o7eRwOUntlqH4xM6oA==
Message-ID: <9bbdf7c6-2b5c-b553-238a-4699cb03f33b@nabladev.com>
Date: Mon, 10 Nov 2025 06:57:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] rockchip: i2c: move ACK comment where it applies
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-2-3e5fea13a899@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251107-rk-i2c-illegal-v1-2-3e5fea13a899@cherry.de>
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

Hello Quentin,

On 07.11.25 12:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The I2C_CON_LASTACK is kind of a misnomer as setting it means sending a
> NACK as last byte acknowledge when the controller is in receive mode. It
> should therefore be used only when there's no more data to transfer
> after this.
> 
> Move the comment in the proper if block.
> 
> Sync the comment with the Linux kernel's while at it so it's more
> explicit.
> 
> Fixes: 5deaa530280f ("rockchip: i2c: fix >32 byte reads")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/i2c/rk_i2c.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
