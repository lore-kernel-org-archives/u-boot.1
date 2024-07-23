Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1883C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67941887FE;
	Tue, 23 Jul 2024 15:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742757;
	bh=b8vuOX0mLsTNV/klz0w1ofGH50rE0v3un2hGUy7K82M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGneTKfvoI+faOarHhJzM3rcOE6/k6UiSD6L0OkZQ5CmPZgLYFTmaHPmBkU+uhXrT
	 Jk+52AUWnhf9cMGZf7WQHeqJmeO0Y/F5mQ4utHGTReaHytdce8bfs7hkPgze5HWwyA
	 PwsKGcCpYmV1JmeDsVMFy975niQHqV5pDPZWxXwVok2IyuYDCx4HbNoxaPvwhSK43e
	 fR19JqVNx8bVMJ7z/pHH5P5auPWux3A+HsHsKj6RPOSkFELMyCcQG4cDvCma6RhSf7
	 zNbq4fH9J2B2LqvLPWhjSusFWMOyT5obekf4Oe31fpdC6uZNV7MsSYvU9qoPNz5wBu
	 LRsYIggi6fUSw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8D8E688756;
 Tue, 23 Jul 2024 15:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742756;
 bh=b8vuOX0mLsTNV/klz0w1ofGH50rE0v3un2hGUy7K82M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pGvaFJEUQruNbhqytSjf5T8EXKQ3MFlsqRnMZ7rBnBSebHAUzwRuhrxiLd9JkyP8b
 x/45Q5/Xp0I46JJsUJSG2RXZDekiNVu6NeyXG897LkcNtsMR4Al1CFj+BXPAqPxAu1
 btnc1oJsOi5znleRV8z0tq7Mbt6YrxLN5orIHQHI7fHOukWmFWuuX+baAdoOi7QKCr
 4bKQ0kYdZv00oDaQwd03t6lfkgSGxKXO/yB7pn1ftBhO0cOqyVf3oynk9ZHYlSrOYo
 l4xwSBjfA1dGV+UfovDjRnbLXunO8TkxjjmDPEmfiQb9JJ3ix0Xx24n5y0okekZEo0
 Xsd/Wur92/hRg==
Message-ID: <be9d18f3-00ae-49ba-9fdd-2bc4ccb37a0f@denx.de>
Date: Tue, 23 Jul 2024 15:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] usb: gadget: atmel: Sort includes
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-2-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-2-zli@ogga.fr>
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

On 7/23/24 3:18 PM, Zixun LI wrote:
> Sort includes in alphabetical order.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
