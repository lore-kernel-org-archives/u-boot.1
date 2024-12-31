Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4CCE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C18D4803C6;
	Tue, 31 Dec 2024 19:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668804;
	bh=1yenvxh4fm6RwU9aKZm08vW0mTkArzjK7/qhgUwu3h0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c2/UXvXk/Vs6dABUql772ttPoPEKw2WiZZK7g8UZzeYeAvNTFlQ4nKHj6wDYgr0kt
	 cPHqEGHXiWZZMeKQzG9+6/ybZmudO3MN4tkNGvgars7T9u0bcN81Gu5Q7JcB+FP9lR
	 /UHdzsD8GgES55725YLm3WqYDI9GDGYn9OpwS2NOD/iHKsXw4HGb+B4tMuf/U93jr8
	 A4CPWtCyyJoiZmvBnavps7CajUxQZwxA+6UqduVyiH+KD3Gg9Qo90FuqxP31CzCuGJ
	 jJQ8nue94C9jD77/GpBd8Ht46nS26s2MJ3mEDA+gHJ2QMMax2hUgJ93HnCY23d+jBa
	 TTbI+2qXQXUHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F8E801CE; Tue, 31 Dec 2024 19:13:23 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE3C8021D
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QsvZywEy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E60DB10486D86; Tue, 31 Dec 2024 19:13:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yenvxh4fm6RwU9aKZm08vW0mTkArzjK7/qhgUwu3h0=;
 b=QsvZywEybWexNz0QWpM/SLGMRfeZzsBLMpgfNKcnsIi3WxXXtWDtI4ovK1ZFKSYoKri5Li
 S6i06IHz1G33lLLWJ4uNXxk6UQeNdo6EpNRlqA6lhSYZ//7Y8xAQ5x8NwWdT4NupSqJ8Tw
 nMSPNwrBreUwgYdM9HBEVktQUeAiCUjpzNetbcC2AQKuCJJ2DJiY1a37A1zVoDzQPO6JmK
 b3feKQM3s5xCs8adKl5+okG6ZhwPXqH4yztdtMIkvF5hI+jJCouydFW0HedeGy3rxYNLSO
 qhyHxjXaRmOhwxWOs2gFJD5YEEqEp9WETvIUmkHN5yzHAwFXd2jTqHFT1BZ7Mw==
Message-ID: <54b43988-c43b-43dd-9b69-1d354765bf35@denx.de>
Date: Tue, 31 Dec 2024 19:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] usb: dwc2: Align macros with Linux kernel
 definitions
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-5-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-5-12cd9b8a2358@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> Update the DWC2 macros to match those used in the Linux kernel, making
> it easier to synchronize updates with kernel. Also removed some unused
> macros to cleanup the code.
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
