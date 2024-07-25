Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481ABC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 18:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7170B87C38;
	Thu, 25 Jul 2024 20:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721933832;
	bh=etuKW1wSEGXrQ/3gtyoov3WlMHgStKTE9Z0OmsrLIOI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LvYoCpPFZJHycOIPwAr/kHPBNzKS7vouuA3TngDQMm23Ms/v+lULmynp41En/cpKZ
	 tUDwj32FE06eBLfwfJGBKJGsPSTi8yi/9JtfXaJ1QT10RmAM16VZ6zXD/uzea53aIK
	 mD7/z/j+Li3pPSqbkea+u/k2V1ypeL/aPDItMoxpMTUjirgVeuawwm2o6pKXDL9EqD
	 80hPERflrVSVMQv7yyM6QVTao0tHV2YfydlxKmzRfqVTIryKrLZYCbXGhJ7xVqaz1C
	 T9Oj/4gEmdrKvEjlHek2Fn8Wa2sxJ3fLZYkpw7pCmWLNIDmT5j0GKOISJ4stIOpJft
	 zizSirM0iFuCw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8C9B9879AF;
 Thu, 25 Jul 2024 20:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721933830;
 bh=etuKW1wSEGXrQ/3gtyoov3WlMHgStKTE9Z0OmsrLIOI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mB+qulEPfGQIcfLtVV+czRtb/wD+cIjY0nUy08setGic8o2UPtezQSm8ZhqGPe7M2
 NoPbgBfWk3UREuVuo9Au5aKxzGTnU9B1e+FoAVlpg5uWKY25n8uoQdGqaLDi/rNIUg
 vO7tl2ok3yewv23eWXP1DLH2hUDuePZnjHYjgR3deSIeVptEu+cJqQ6graQnxrKD08
 CLvtTCmOXmY92VmISvoTkRQzZj0bWA4SKkSsU+YO2pdlulcYjhqXp64FsAQDBfYxa9
 BrC70hbaa+kgxmpPewaEWCtNTtFHmeKQcfF3+lZgvoZ4qK9RvQXnUGsvhuvbSa6MO9
 k/ucQDHYcTNYg==
Message-ID: <24112707-c09b-4600-9e7a-a3d071e87952@denx.de>
Date: Thu, 25 Jul 2024 20:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and
 DM_USB_GADGET support
To: Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240725153204.358925-1-admin@hifiphile.com>
 <0e0a053a-56b8-470e-98bd-80e61417e5df@denx.de>
 <CA+GyqeZURHRsM3MZcUzY3+tyu0SeBM7aPbYd48JmSxqVuuZw=w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CA+GyqeZURHRsM3MZcUzY3+tyu0SeBM7aPbYd48JmSxqVuuZw=w@mail.gmail.com>
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

On 7/25/24 8:48 PM, Zixun LI wrote:
> On Thu, Jul 25, 2024 at 8:24 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 7/25/24 5:31 PM, Zixun LI wrote:
>>> Changes in v4:
>>> - Release clocks if probe failed
>>> - Add missing endpoint data free
>>> - Addressed comments
>>
>> Please collect any AB/RB/TB tags that were provided in v3 too.
> 
> Sorry didn't know that, should I spin a v5 ?

No worries, wait a few days for more feedback (if any), and then collect 
them for V5 and send V5.
