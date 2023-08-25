Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D2C6FA8F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 00:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A774286439;
	Fri, 25 Aug 2023 02:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692923845;
	bh=LwKThnYQ63chyW+tUc2X21PMuew6rSOxBtr4eVaE11o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rmF5LwhThb1MhDHZrbi7VhRqSqzmbOWAUkuQKpwoFZ0i2X+jD/3jNwZyKC3i3IfLP
	 e/u9vD1PMNyN+m6EncDqL89f58wC9HmQXKxHePpeTZDG8f7Tx4i6i8Iicz/HyB+oH0
	 xUWNH3A9bKn5c0It/Eg21EJIVMQH1G7zZzM1bwvu9AgRGxJm9NlrL9ohKE6zWpA/UG
	 ODxlHShQ5tR9kyAvQTL3QEvdWHKKLHCggem9CmGxWcyQQOZpatRpvJqwclD0NPx5gl
	 kErVGHZNmnKSwuwF70AYglYHJEy4XRD9Ou6GD4yUjS2A9wKK2N7OMsWx6e1fOHkk4v
	 Y6wdyM0i4REAw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9D27486386;
 Fri, 25 Aug 2023 02:37:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692923844;
 bh=LwKThnYQ63chyW+tUc2X21PMuew6rSOxBtr4eVaE11o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lWTNxG8r3JbJcS1WCXSfVnEZn2jGQ0c7r4kALjozSWcezOBmQ43wwC0NYxDZTXary
 JNkzmdGXa3ZnUHDHnseZ2q6ee+tgE/EU+xEVcIMsGDnNUM6pQqXZsjtHNXxRJbaJr9
 gDzPmIBImlQ2+NkibWJSV2xBHrX3ds2+5WpQw3afiGpsnbxmrOX+yxLC8/TrYDWbpo
 U+5/6LAzyKCH9OV7KP/Vj8vsAivGsgRdkszCnNEZlV5DfU5BMB5gAnX18sVMr6eKnO
 HJVaEf6TdjI4JP7dIjLXRh5GlQc5S8cf8atb/+IkguFanKEGy4JTwsarsDI8eJOjX7
 57Zh2yMoCrGSg==
Message-ID: <9e7cf469-747e-dbff-2965-a8f3081693d6@denx.de>
Date: Fri, 25 Aug 2023 02:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 2/2] phy: phy-imx8mq-usb: clean up clock code
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@gmail.com>,
 Adam Ford <aford173@gmail.com>, Martyn Welch <martyn.welch@collabora.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>
References: <20230713185608.3647122-1-tharvey@gateworks.com>
 <20230713185608.3647122-2-tharvey@gateworks.com>
 <98904f52-9deb-9fb7-35cd-7880b1f19155@denx.de>
 <CAJ+vNU3Ardy1i-4dO-ywKusDUC7vj0zAuDvfzvnpFejTjQa16A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU3Ardy1i-4dO-ywKusDUC7vj0zAuDvfzvnpFejTjQa16A@mail.gmail.com>
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

On 8/24/23 20:05, Tim Harvey wrote:
> On Thu, Jul 13, 2023 at 12:17 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 7/13/23 20:56, Tim Harvey wrote:
>>> use CONFIG_IS_ENABLED for clock enable/disable and change printf's
>>> to dev_err. Additionlly remove the comment that does not make sense.
>>>
>>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Thanks!
> 
> Hi Marek,
> 
> Who's tree do the phy patches go through?

It is assigned to me in PW, so I'll pick it up via usb/master , applied 
, thanks.

That said, if you see something stuck for a month, that's too long, just 
let me know sooner please.
