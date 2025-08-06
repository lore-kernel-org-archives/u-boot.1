Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBA4C87FD1
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 04:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FAD83965;
	Wed,  6 Aug 2025 06:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754454643;
	bh=vZTScFbtEAMhcUqgnlW6iyLomk0+Aq4b/fY78Gum3SI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RDTj/wjR5uCIpU+Wg42D8MnfS1stT221FvqIAu3jyYDT3L7ReBbp5UrvkqZqoiF6j
	 zYr7tZwm2eT6fDqZ8U0uf2eLRd/1c8pwTXbdT0UNpsuqA31NUzRDaUHwibBIlg9Ais
	 wOgwc8qZcPio5KELL3RdeARcMUUPJZThwZLx9T9fIvF3KjPJY79q48tzNZz9ytBPOS
	 f+y/OHIvLgCMECf/y8qNRkFCK/uEuYe3qXIF2fG5yIWAGr+kJd/MkOA06n0ETHpHOu
	 ntmCiiiFDJuiCpG49+A+5zst/hX4GMPz+aoDw3Ky6pP9A8bwTFiN4ndPbqwHeF/uxU
	 yWgxg82h2Jijw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F218283968; Wed,  6 Aug 2025 06:30:36 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7013F83950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OyQOvc7x"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E0781038C126; 
 Wed,  6 Aug 2025 06:30:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754454628;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=vZTScFbtEAMhcUqgnlW6iyLomk0+Aq4b/fY78Gum3SI=;
 b=OyQOvc7xXLjngoJX43O41cOmnZwduG2wOzGqIPB7J7oBGALfT0O66nBl0p6dHgeVutkxYd
 69vx+omKVuCaot7cihmQG6hx2Hrv9ugPQu50dv2ujgeUJEzOh9GW0F1HtznugiIKZV9TP/
 n6mpfdh9+pz3Cdmcq8XFcoN42tk1+rw4yCifNjiqtKqYXUQ9KB6RCAA77d6srMOlp9o42J
 k6VARPsL85DL2uSAxLyKDN+y2RyUe9WvnuIHPHlt4k34wQswzfTmq7+meF2kZ0+HQ8k2CT
 ln0PNhRLGR+RuiOfM6HqgJ4xwFhCE0uhPyGJVPrvjVgdvfH7Ev0zs+UneCR3fw==
Message-ID: <abcb54f3-3976-f433-e987-ae5246b0779d@denx.de>
Date: Wed, 6 Aug 2025 06:30:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 06/11] sunxi: Add support for I2C1 on PB pins for the
 V3/V3s
Content-Language: en-US
To: Paul Kocialkowski <paulk@sys-base.io>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
References: <20250805174827.3696191-1-paulk@sys-base.io>
 <20250805174827.3696191-7-paulk@sys-base.io>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250805174827.3696191-7-paulk@sys-base.io>
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

Hello Paul,

On 05.08.25 19:48, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
> 
> Both the V3 and V3s support I2C1 on PB pins, which is often used to
> connect an AXP209 PMIC on V3 boards.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   board/sunxi/board.c  | 4 ++++
>   include/sunxi_gpio.h | 1 +
>   2 files changed, 5 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
