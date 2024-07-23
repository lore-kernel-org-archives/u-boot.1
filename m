Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31D4C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C764388847;
	Tue, 23 Jul 2024 15:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721742763;
	bh=o5YhNQYeDAZXzhP8xhqfcFxf3W9P+ZyOFEDbKaHUYug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LlQ75uTpFUKQHZTASvyACh6gyqM7SIj5EOKHSZ04E5src3+5v2jClLWRi37ldmxQ+
	 jp04p2AYRVvOdhHJWDJnXpeT+hGxMwB9bfOlHJvGRikXujWRWKgkH98sFiHhk/jvaF
	 cQ+Q5pRbJS1CG9NgKOGozUpxbSB6j56pJlSo7WQYGLWev9gMx+SKhGja4ZtW+U2Qec
	 D5yKE285T1o880ktuAbTyXGsord4glAKsZi6EMMVdQO9e7EvstGQmkPk8N8CDDHQdq
	 g8EA48W3s80R7WJv7oQ4Pj/29zVQhAzgdFW0bKcO7TWypJ50LFHXPjlzqnxzcr4SJH
	 SMxwGHRAZN3Tw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 536C18876D;
 Tue, 23 Jul 2024 15:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721742761;
 bh=o5YhNQYeDAZXzhP8xhqfcFxf3W9P+ZyOFEDbKaHUYug=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=asL1AhTW4tW4msYZFx233fpXMIb5zxs1gMJgMnn1NW5PYN53rNXYBL2ZtjRhVgIrC
 6sI92NZeNejKDvM86QYB4XCbksgWoVZbIpqToAWobY28utAGygCzZZDl7ukZGALVbD
 Ul3OwopPJpy8y0VMva0K2CRHbgl83K1A/6jANpC6um9AZJvXD7J6/PLuK2vVSEtDuQ
 KRJ31BhLFF1aaHrL7ucTfukRbWSuJU5quTE597jDdusr0Ob/zyKb3e1LuV7XBflw50
 VlB0QvkufE2FtMZYWl60sj2TkLF5/Z8QpL52496RVmZB9lS+YMwWo5yOeJfTzNsRgv
 iAktVrk8BkSfA==
Message-ID: <2ac69981-12a4-4fc6-b185-4dbaae3c3b38@denx.de>
Date: Tue, 23 Jul 2024 15:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] usb: gadget: atmel: Replace printf() and pr_err()
 by log_err()
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240723131817.262596-1-zli@ogga.fr>
 <20240723131817.262596-3-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240723131817.262596-3-zli@ogga.fr>
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
> To have a uniform printing function, also drop linux/printk.h as no
> longer used.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
