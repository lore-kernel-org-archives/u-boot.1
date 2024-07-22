Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54493C3DA70
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 23:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888C18867C;
	Tue, 23 Jul 2024 01:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721692692;
	bh=U0bZq155WHSGWcilbOZBtQuxgAbaKmxqNLjcZ/EaHIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oueq7L/t1zc54Fh2uv/FV524ub7SGg3nw6RbRrli4oaRt3O98I9MUzhQF3322rUTH
	 alMr4UoB+EuYaMaXhF96+wl55sJ/qKB1HX0jqGqs6VDnSuE7ESgwf9LUZ5+oSnpRVG
	 DIN3VLc/KCChze4dUbx4dgsRn0GDIXJQui7IWJlSzc0fdCfQa0aQ+bVpHUSIuedDxm
	 02SwdaS2LxONQutoP3cqrVla9JWHl1tS7yn7fyYNKRGYVKSqd66zcfL4eUfb9F5PWi
	 7yL7BRgpq5AJcNPWFI6HRg7TNjymvSfhJcZqRfeG/BdCPzOPE3RUi0h+3l5C9ghNsu
	 QJ+OkWqagmvMQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8F891885E7;
 Tue, 23 Jul 2024 01:58:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721692691;
 bh=U0bZq155WHSGWcilbOZBtQuxgAbaKmxqNLjcZ/EaHIM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=My+b6liOP53Emrkc0iS5yC23jHT8dR+EHmSiWw4VWZvtWKXhT7oOqsco5XY4T3t5u
 fh5iCf456kq//69AZM/IoCfUtuCJBYIX+6lkreVuUNBpnxGy+MFmLuAskyaH99VY04
 Jw7qxi6PyO7F3y8k8mah5nKIiWolA6odyO5GYYb0nKb4/bHYqOK4sQezhzI0aRC85/
 VgkL4dXJjmzzAbwQ2CdFmb5eywX7rSWJ2BvrK8J1wBKkvaQnE/Y58yt96b46o4VqPN
 sjCemZmh6x8joqGsan3E69jw8VxYjJjtlVQcnLXgcOu8j2bSNg7K6ussdl8KaaXVYq
 oZgZB562S4uag==
Message-ID: <cd446203-327f-408b-b387-043dc22b5877@denx.de>
Date: Tue, 23 Jul 2024 01:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] usb: gadget: atmel: Add attach/detach support
To: Zixun LI <admin@hifiphile.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>, u-boot@lists.denx.de
References: <20240722202426.190986-1-zli@ogga.fr>
 <20240722202426.190986-4-zli@ogga.fr>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240722202426.190986-4-zli@ogga.fr>
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

On 7/22/24 10:23 PM, Zixun LI wrote:
> Add controller attach/detach support by using
> usb_gadget_ops.pullup() method.
> 
> Signed-off-by: Zixun LI <zli@ogga.fr>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
