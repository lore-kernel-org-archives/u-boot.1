Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB5AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFA888876;
	Tue, 23 Jul 2024 15:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742774;
	bh=+V5jB7LHzp0Pl4G+md6po3YQ821eR7Op90G4CAhW9LA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=okItFAlaoF66079rqRM79pRe9fVHrMY+gNhLXT7XMKCt3I8qdZLTsIF3lenma3TIC
	 SPKFi9WiKQxvP+EkRC88u8uiEV/h5Yw0uzhi1joKHw22lqHBrBJFu+mPhJo3Rqj1Nr
	 l4yJbn8yZ7BEf+rfglGJIvhkvfaLQZtfnQYdB6PqMQIlNTqTbAy7gRykOw37Quapch
	 1Q9oZyoK9O2iyfRYZx1WU1Fb5GtQ1XNC3FWlJEbq/w9rWV/LX4fbOJ3WZKLHN8ZpRl
	 tWdhkSUvIyAigJwZjgOPDtfyC7OybCqSQCJVDUxAKeYnaB0A6nDU/TZC+xYlcLHOVO
	 8oDDErhcrp5Dw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2E26288883;
 Tue, 23 Jul 2024 15:52:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742773;
 bh=+V5jB7LHzp0Pl4G+md6po3YQ821eR7Op90G4CAhW9LA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PV8ATcoqXndaRUNUvBi+AmPP0PjzFh2TvNqUKST+WW5abLWDu8owEXizqpd2vUF/P
 80+tvo7SFelNePCil3x8lfca3f6dPr9IVg6ib9bSS+MPGCQwcJSFFTZ8Jo7ga8+urk
 p7nIWMeGJedz8bQWmunUkjeOOUy1HBW4frXo5kOOll4SIlmWMxrUYRE7MDsDZLMXmp
 Dl9tDpDRyVS1J1b1n6oftBf44CqbJ9sg0kkIhMhMZPrbKKBVLMdCjZBSNpYolVAgeG
 KV8zZF9kWhUMX7mDxoXL59VrIEHV5yryuZ3dmMZ0+gmJL/XvwoAGwkb0ixeyZf3RZf
 9aBDX3HJUCo9w==
Message-ID: <af814ec4-ff8f-4582-ac47-fd5e352c6053@denx.de>
Date: Tue, 23 Jul 2024 15:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] usb: gadget: atmel: Rename
 atmel_usba_start()/_stop() to usba_udc_enable()/_disable()
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-6-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-6-zli@ogga.fr>
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
> Rename atmel_usba_start() / atmel_usba_stop() to usba_udc_enable()
> / usba_udc_disable(), remove atmel_ prefix to be inline with other
> functions. Also avoid confusion with DM start() / stop() functions.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
