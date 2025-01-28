Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB291C02188
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 01:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1415E81875;
	Tue, 28 Jan 2025 02:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738029007;
	bh=jP9MwNnOE3Jf56Iyz2LV/7044ppKaKI6jPAy90IU9bg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rkhp7iWKLQyXe8lJ7WXPF2/O3PbOjqMsW9cCya6zbI8VS1XMpPvodxaR1klJN0zxu
	 s+zZGg+e+7UPgxmVWTI3RxWzyIl83kIII/t2T7F7KVE30STO4JiHTdFO8ROHwhevoz
	 6F5ME9+wZAVSYV4VA6fY2QKWBgA4iGnsOHvZgVIRuLuPZ7s+vQ2RrHDTMexjIPzks2
	 RwueXySgU/svUMpt6PXsjyl9L/cqwe60Q9dOCE+FTupJc/Z7OmSA/nE+HNqNlPxxyF
	 5X/VqIJUlT1QNdx3BlPrqkfvrimyVoqv2+BhOnTOX631yR2fWtBd9glrgsZA60r0p2
	 HjIWnUScGym7w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8170E819B1; Tue, 28 Jan 2025 02:50:05 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B6481111
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QS725GLA"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A46C0103802C1; Tue, 28 Jan 2025 02:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738029002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jP9MwNnOE3Jf56Iyz2LV/7044ppKaKI6jPAy90IU9bg=;
 b=QS725GLAbukr/gW1Pf+tf3Z13WJWquioCPEhaM82Dpo3iZMc2Poxr2c66MC5K6t7z3KG3s
 24EQivUEt160vXk6/7qoneyRofoe+g0pc7WbfSNVhsmOiR88tfFTExKKwr1XBLspM74ivh
 u34lzp3kFGoXMdWbUTxJpia4ZjuH2kNnTO0ptKaL9p5tWdjxxPiY9FEFP5a169HzyURp3S
 Uw/AhSrETpiW4rr/TqwR2OOvLXZJ0a1x4al8oS3d+s3N7nusULoMws7/rBHTa0Z+yUxRrI
 BFVjkg6F1k04LEkmAPPGxbLznguXA/sRUN8hyaUc06P7Z5gYRi2r0hYqIqFvlA==
Message-ID: <2f367a3a-659b-4fe5-be34-e270ee941866@denx.de>
Date: Tue, 28 Jan 2025 02:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] USB: Fix NULLPTR dereference when serial# is unset
To: Michael Ferolito <michaelsunn101@gmail.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Heiko Schocher <hs@denx.de>, Kyungmin Park <kyungmin.park@samsung.com>
References: <20250128003010.971175-1-michaelsunn101@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250128003010.971175-1-michaelsunn101@gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/28/25 1:30 AM, Michael Ferolito wrote:
> The current behaviour of this function will dereference a null pointer
> if the serial# environment variable is unset. This was discovered on a
> board where U-Boot did not have access to the first 256MB of ram,
> resulting in a board crash.
> In the event that U-Boot has full access to memory, it will still read
> from address 0, which is probably not optimal.
> This simple check is enough to fix it
> 
> Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
The subject tag is "usb: gadget: g_dnl:" instead of "USB:" , with that 
fixed:

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
