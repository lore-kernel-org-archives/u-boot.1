Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BCCCE8347
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7907188E6B;
	Mon, 30 Sep 2024 16:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727706427;
	bh=xrj3CGSFXR3zJRUXWq+Ji6cvE6WsCq2QZ67yzkrqihE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y69UqYFyGGdwAY7cTP5onXnvC2sT7vnX5l0k66oAlERv++XMcDgU9HVQ1lGNp98zt
	 09RhmtxRA8Yk9TOM+YP2HOi9Rzk/kyEDma4ZaAyTHALCXeLVA7EcM254oF2XrH+UeA
	 dDbknMc+/19Vu2znG66bh0VfEQ0rEbVA4u7JtAHCxA7RQA6XRqnHva7KN442SnvWV0
	 MgiBODw9kgj9nr6ZReXRtUXbCFF2cAmBlKdwk7uvXfr5vvWbRLsE85V1BRN/tfplRA
	 s25kLRAX6tnVOMtxhZMoJ6RKA8M5G8gqva5hHNLvzLm8MWvvkGfJjgp9QqVyvonTHx
	 j0sEb6mSSvbcA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1034888D9B;
 Mon, 30 Sep 2024 16:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727706426;
 bh=xrj3CGSFXR3zJRUXWq+Ji6cvE6WsCq2QZ67yzkrqihE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gppo2gHyRW7B6BT7aIohojKoUUR/kyW0Magv+Z36KWXOEoKiGAgJZG5m6to+eCMuc
 VoIe+h6H6o9lup4YMEbEFVzueNWAcg1gxkKdGYhscY+pxHYuBaI8xZ6y8Zl6GqZZNx
 3zHCdsTuV5Zwr6iuNdWaY7kNGwwsAGgsNwgwrlj9FaMAYdg2xxesks35IzJumT7Z92
 +cuffAEe1qrmBzYw3X80MFm0cVe1escE9ABl2rl5am1P1bIi4ZxIe0HheL2+hJagQf
 fjcdUFJM7gmJWFkrFEB4GoBWYQEUtYmO3auuYsqLg0yxsQX1aXdY4xdodN/SHk2nMn
 d8tnAtCrFaNPQ==
Message-ID: <367fb155-8ade-4b49-91bc-9b135a7cc994@denx.de>
Date: Mon, 30 Sep 2024 16:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: cdns3: Fix missing cache operations for
 non-zero Endpoints
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, mkorpershoek@baylibre.com, rogerq@kernel.org,
 vigneshr@ti.com, jjhiblot@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20240930093407.2998969-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240930093407.2998969-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/30/24 11:34 AM, Siddharth Vadapalli wrote:
> Transfer initiation and completion for the non-zero Endpoints are
> handled by cdns3_ep_run_transfer() and cdns3_transfer_completed()
> respectively.
> 
> Failing to flush the cache associated with the TRB Pool within
> cdns3_ep_run_transfer() results in the transfers never being initiated.
> Similarly, failing to invalidate the cache associated with the TRB pool
> within cdns3_transfer_completed() results in the transfers never being
> completed.
> 
> Fix this.
> 
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Marek Vasut <marex@denx.de>

Tom, can you pick this directly for current release ?
