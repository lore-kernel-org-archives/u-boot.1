Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F59C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EE5B88863;
	Tue, 23 Jul 2024 15:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742780;
	bh=2d9QfhXmU71iHvh67TPc1J1fKVF+NvwlfwCF8DVOfPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOKegtIx10DSYwVLMstLCYLtkoVQsttznYFwNQrHQULE1C+EXChlKtWdrcbJmP0FU
	 x0y38psv98KUOYYiU/sR2s1zn0e5tfIGR4z/1mOwsqAlR5DdPkGvXyaGImI20JK703
	 Nq+Xn3YLU8r5f/s4e2nirBszBii6qJJ07hDXOneuIt0EaxSxQCZRg9bKZhWdj8wTqw
	 baAbvnBZ/8gEhS18o61YRT888p2BRYkXfGWc1tPwsCkTuhfDk2zI1we2m9Sg3tCiss
	 Vpci7/khX48Vsq6Jy7Bu+jfTm2oET3MWvjyIst67dw3R37Cg5Lp0gC0kCrwx0XfGKC
	 eLkfFUajMEV9w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C599A8876D;
 Tue, 23 Jul 2024 15:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742774;
 bh=2d9QfhXmU71iHvh67TPc1J1fKVF+NvwlfwCF8DVOfPQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ISw6wFkbJdvcNR2Qf6ndXbtPcJoBZpVXQyVmml7qi5n56JzCU4D30Il1XsxC4J/2a
 Xn/n6vLKxQ9csAMPm5d3qRV91rUq4ugY2O8yzLtdMY6Raejl0CO167K+KDNvvtt+IS
 E9aZh8A5A4pOcqO7/5MVWfYqF3a7LFISqJ7HEBCcmSgws1lvOaCOLM8HuN0og9bJzV
 PJ9nutR+Wds08HkTBLv8ZUkBZDyinu1DGiPlHby7ap424+H+13NWH3TnlPGsthE+7x
 KVhFQdG/GryXDZJIrKReJswyUvm19kYX+kWgAework0LMT0eepGLBbrthd06/jdH5C
 kgx2FV1kw7VNw==
Message-ID: <19e38775-8e52-4581-8efb-246188b06734@denx.de>
Date: Tue, 23 Jul 2024 15:36:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] usb: gadget: atmel: Add attach/detach support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-7-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-7-zli@ogga.fr>
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
> Add controller attach/detach support by using
> usb_gadget_ops.pullup() method.

It is called 'function' in C, not 'method'. I think 'method' is C++ or 
maybe Java ?

In any case:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
