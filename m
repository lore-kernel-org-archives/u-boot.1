Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE0CCCFA1A
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 05:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0095E83956;
	Mon, 10 Nov 2025 06:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="FOf4JIur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D33283971; Mon, 10 Nov 2025 06:56:54 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D91F83655
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 06:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9285F10A4B8; Mon, 10 Nov 2025 06:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762754211;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=6KwavkwtUzkG7rN6nkZrkWXT40f0+QYE+UwzSvnNLcI=;
 b=FOf4JIurrde3hwnioe+MpoiI7GAjl0mQlIscsa41QBTRqi6W6t/Y6cVQPjsCxs+N/uNnvP
 mIC9w4hAKg34BE+BCp418Qs2CbSSbuUTyupWmuuaAW9Yq4tycB1zi2Aq+KVVEdpN6dzy04
 gRch0JKV9cvss+tnEikbCVx+LpHcvxZYeGDFdR/L+hiMIz68qxV7MsjXc7XBLUTFUWdtIV
 c899nxHQ6TcshJ6htpIMnjSIe25Em0HjMv3wRpSh+6IULNKF4W+M3MfiFfk7DfglD25mR9
 gQzhGFK96Yz3BhdZE0wE05zdhhtdWfCA2w2uBSiTLB/9UBZaXfvGOJWa2JWpEQ==
Message-ID: <3dd6f4dd-8474-3098-ec5a-fed56701c217@nabladev.com>
Date: Mon, 10 Nov 2025 06:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] rockchip: i2c: fix incorrect STOP flag for the
 interrupt enable register
Content-Language: en-US
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Wadim Egorov <w.egorov@phytec.de>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20251107-rk-i2c-illegal-v1-0-3e5fea13a899@cherry.de>
 <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251107-rk-i2c-illegal-v1-1-3e5fea13a899@cherry.de>
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

Hello Quentin,

On 07.11.25 12:39, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I2C_CON_STOP is a flag to be used for the con register, where it is bit
> 4 to send the STOP condition.
> 
> To enable the interrupt the controller sends to tell it's finished
> sending the STOP condition, it's the ien register at bit 5.
> 
> Let's use the proper offset.
> 
> My hunch is that enabling the interrupt is useless as the interrupt
> status register is always up-to-date and enabling the interrupt is just
> so that the interrupt is available via the GIC. However, U-Boot has no
> interrupt support and the logic was working well before this patch. This
> is just so people aren't side-tracked when debugging I2C issues on
> Rockchip by checking all writes are proper.
> 
> Fixes: 3437469985df ("rockchip: Add I2C driver")
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   drivers/i2c/rk_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

The series is delegated to Kever Yang, so it is fine for me,
if he picks up the series!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
