Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6721AC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 23:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D1188C08;
	Thu, 22 Aug 2024 01:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724282777;
	bh=3NZ8CmizpK+LWXBa5K05RX63izWSM1S2NeBxPYV1XeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOJPUAxvG2Udcemr3ph3dhS/NFxHBbyPLw0IerQEdRLGwVEGiSUv6y5B+cPIKxSor
	 uk/VPVKKtWhRk6jZbJL5HyPmQRA5qvYBIbBWIFwXhB4gkUwLlMf6cBztbjEYVyl0WV
	 TxiYEUnWCjccBClt3U/9SmmCADQZ4Nu+5l3TeZAur47atL8nlPKua8W4Qf7DXM8bbR
	 W4B1RqBAUsM/UegUXHTkup1UEt0iX/zGPiGzZv6aYtPd/5PkucDX9iVywazpEY36La
	 OeXC9Y1freAD2IfFAlQbdQSxrsESL+1TCbYLlVZjATCv72FxSUdX+uLqkzTqVmmNe+
	 EoWbi6BA0wYtw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4BCDC88BC4;
 Thu, 22 Aug 2024 01:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724282776;
 bh=3NZ8CmizpK+LWXBa5K05RX63izWSM1S2NeBxPYV1XeI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NDvpVuPTJKOZn7CrsqFur7OEGjUCREb0n4IuGQnPRHlhYuoJbVjwkPL4RKUh8Segr
 Wf3VSTCZ9P+OvQV6nFhmcw9mTOzAKYPGcW3PNbBq6dbYQ02PjovE+VrGR/u96m4bty
 tQy6g0EZYf9iy3Ca1RCqwy0v3grOtJwkXFBwaABmyxzKpj8K59citZpm3+ZAW6tmn+
 K2WAK18CZ6jztvvYmG8ojMZPlRQ8cs1oKwBDVoQRdimMcDCKQXW3Gv/aaVOIqR/cKX
 GcGAn973iMjuUUYUEzKP8a+dDGuSSE7WFZ8DwBvBLYwsA7zzCsaS/dy4iFnA7eelAx
 VN2/6+IE+YgZQ==
Message-ID: <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
Date: Thu, 22 Aug 2024 01:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Zixun LI <admin@hifiphile.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/21/24 11:58 PM, Zixun LI wrote:
> Hi Marek,

Hi,

> On Wed, Aug 21, 2024 at 11:43 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Wouldn't it be better if usb_gadget_register_driver() started in
>> disconnected state right away ?
> 
> That's what I did initially. But since g_dnl doesn't do connection after
> register (I explained in cover letter) doing so will keep g_dnl always in
> disconnected state.

Would it be possible to fix up the g_dnl ?
