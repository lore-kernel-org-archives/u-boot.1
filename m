Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB912D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 08:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EACF89066;
	Mon, 28 Oct 2024 09:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730105225;
	bh=sUrT3beV/PYpsOKB3HvIozG/twVT8gxRUR2MTWVXAvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uAwhIrLpY/5MQ9n6UQHcduhRK0M6/YYcduwGdZPipv2TbmcKaRcZSK3ppqO5iqN18
	 O6BnEreTCVdP6zQPi2kEGMFhcIOc+U4E5wE0ndXcQhW4pTFfV7zQ3+V79SYyCqWyvL
	 S2/snlYB1n6hLh4/Rahida5p4hKIqXXD9p0U9OT3qXOUtg4dQlKA+LeOhllaFpE0nO
	 w9VpoNhWLwHQrdYYXxXbKkbDdfS8PSkUz33jsDNUBv4vP9A8eisLO8/OSECA7VYmFg
	 kcNf/BLNgiwoCLhFO3Vcc9XjpdcNXCCvCls1bs44AJK6iNCdbCcdXklyvAam/P1bwJ
	 Q93zyv0aHDvaw==
Received: from [192.168.1.107] (89-186-114-4.pool.digikabel.hu [89.186.114.4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0B5DA89083;
 Mon, 28 Oct 2024 09:46:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730105224;
 bh=sUrT3beV/PYpsOKB3HvIozG/twVT8gxRUR2MTWVXAvw=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=pXnKg6S+slJgnrNzePPQpBSKUXDiEFziSfZd+9ZYIHcTr/DH5yqDy7HmmUS33oLPN
 p6LxxFFf8qem5pCwl2nEGj7a5ueaD/7lRnX39I/QRQzKhsr5TINBYjkuIdKRytuRNx
 NYrRcUONrMLen5YlgPqPMaZjPJJGh/WcabR9gFb6bGdvAqMFBcPwrI1xReOggBzT2/
 BHep8RjP2SHGahw51GQYvktwlRxdPUT9qmmDaspl38DSPlqzWcuop7ys6hIDF79VVK
 hl2r+X1d/zWKDJZ866sfsroyhoR/cv/nvc7uksD84brV6TZVHUKxqAQJIxxDQWTTXX
 qvr6cNCgGPJgw==
Message-ID: <6c531544-9c94-8ab0-6a35-3b8f8b790db1@denx.de>
Date: Mon, 28 Oct 2024 09:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/4] i2c: mxc_i2c: Convert to use livetree API for fdt
 access
Content-Language: en-US
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: linux-kernel@vger.kernel.org
References: <20241023202855.1571188-1-tharvey@gateworks.com>
 <20241023202855.1571188-3-tharvey@gateworks.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20241023202855.1571188-3-tharvey@gateworks.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tim,

On 23.10.24 22:28, Tim Harvey wrote:
> Convert to using livetree API functions.
> 
> Without this if livetree is enabled (OF_LIVE) the mxc-i2c
> driver will fail to support scl-gpios and sda-gpios for
> i2c bus recovery.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>   drivers/i2c/mxc_i2c.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
