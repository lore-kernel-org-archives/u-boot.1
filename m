Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499C5CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 05:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DDD3833AD;
	Mon,  1 Sep 2025 07:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BwVu+lkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A727833E9; Mon,  1 Sep 2025 07:34:05 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB1C831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 07:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3AE91105B27; Mon,  1 Sep 2025 07:34:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1756704841;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3PsVSSYSm1tQjiIBQ42qKyLzkxrTZbtvl8f2KKZeHMA=;
 b=BwVu+lkCvMpWr2z/Hc6r1+7BLmHcL5MIm5SAOZjQxESJKYYReUFnZl9Wc1AVQuO8bfpRGd
 JcATgA/ARNG6aqBWGflzYhXO913ItW8o60pM9kPdMXmcUBoZzJDuHDJyfOTW4uc5GLrjzs
 XjfbY1IEVSDMLSFhaH5TdO6GvFzjzkh72vLOFIqpOYXGkPeCq3TzmypDQ9LXTn9xh4MKcn
 Ao4sOF947EtT0WITKVDbn5slGoZEjGn/WvwFc27ICrT5Bh8BkoI2+/egDbKwDcc715JTCw
 tEFx9W2vL54lSlOQ3LZUE/OFHKj3zk8Q1P7ulyloBAB5s+3iqInhzwwjBbE3Ug==
Message-ID: <300fe3e3-d21d-3b92-b054-c5c231cdbc1d@nabladev.com>
Date: Mon, 1 Sep 2025 07:34:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] tools: Drop meaningless comment from Makefile
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <ae9c0d66-01ee-4d58-adc4-66ea36e62cc3@siemens.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <ae9c0d66-01ee-4d58-adc4-66ea36e62cc3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Jan,

On 23.08.25 13:29, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Introduced by 245b1029e1af, probably a debug left-over.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   tools/Makefile | 1 -
>   1 file changed, 1 deletion(-)

Good catch, thanks!

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
