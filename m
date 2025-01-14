Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE3EE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 05:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8657A80657;
	Tue, 14 Jan 2025 06:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736833791;
	bh=NhFQgNHzbDD4Ddk4L2d5bCKuj9Q8xDjG+IbKAGmyh3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OYxPgmR+S8mqwvXiHrbIqPiMCFE9SzzwAz5zE/3ORCsCAlIaxnAdxJwP1sqOWhB0L
	 kdH7srxxY2dqejxoY2RFGR5VL27t5t36zaI35SNz0j7I/LsaNQ+uaUw7hHe3xKHWdF
	 T6uvj1veqlI0QkY08n0ePXv9tAspLxiGD4sJIC6CPTE3p3uHW2knellyc+zeoMLJk5
	 E/PU6uYRP1Xox1A2kjsGiAgHsAHUTGWgMqUCp+BhTTiBHxsNVAsiy6fUewAGdtqHy0
	 W9jF+WyhzsdgZwXjv6egWPeSsvm/LGmiZQ+F7skTAEAN+ESIMEECPqzWlrrGW30PSq
	 K/ou0pRZWx5Sg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7A6806B7; Tue, 14 Jan 2025 06:49:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C25580619
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ScONu1CG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9137E10485886; Tue, 14 Jan 2025 06:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736833786; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NhFQgNHzbDD4Ddk4L2d5bCKuj9Q8xDjG+IbKAGmyh3w=;
 b=ScONu1CGreDUDVyCAnoT8wpwXfGJE7vEuw91CmC5W9acooPKB/PXsu+IsmHD2czPi+gX9O
 v/Xkqz1wEYkS+9oMrcnW6/CmN4Z1lJT05o8zfgU5BuCcnTQi3UUU5Jm6i5W0ytqnf6OoRZ
 U+F6x66tLTsPNdIciISVkyApX+O57bQwT9qH6cIwH70SmB0y9dQH2tasikj5AgGPhv1j12
 9X0fjox014eL0VCrDw1yToyU1w37ogtajg+s3MHyspUu6ILDdD+fGNHSQE98ctDuDtyYsz
 3AlMYLH03whZC7/faNLsULVaOPT1BlY2FmNipZSjHcdlYqzNBcP2524hAks7bw==
Message-ID: <fa756b86-3fda-3e4f-ad18-63f157d4c465@denx.de>
Date: Tue, 14 Jan 2025 06:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] configs: capricorn_cxg3: Enable CMD_WDT
Content-Language: en-US
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Anatolij Gustschin <agust@denx.de>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250113211518.1276899-1-alexander.sverdlin@siemens.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250113211518.1276899-1-alexander.sverdlin@siemens.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexander,

On 13.01.25 22:15, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> Capricorn boards have WDT (WDT_SIEMENS_PMIC) and U-Boot is not configured
> to trigger the WDT. Enable the "wdt" command to be able to stop the WDT
> from the command line.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>   configs/capricorn_cxg3_defconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
