Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44513CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 13:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6196080F0E;
	Thu, 14 May 2026 15:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dMZA5H00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B659683AA9; Thu, 14 May 2026 15:33:51 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06598039B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 15:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D73AE10D14A; Thu, 14 May 2026 15:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1778765627;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aJBJPno3ck9QkjZZ4gMpXaEoaGyuK6LJek2BUB1TI7U=;
 b=dMZA5H001Wp4UGQCshWgb5uU2Hhol5YxwKL4ugcsNUJhUpYc5Eu2ENcvxZx1M/CSaU+JKC
 8BA4kHyRWcAfE6Kcn+1PQwFsA4EaIUSd6O7p4B5PGZxgGlPMp3pnQt8OzkzOqNugO+WHk/
 GDxv5D7aX3T/vVQvptf1bF18XLlIraI2QWkaV4/ufR8R/v0+WgN85Y7QsMh0dImJHgo9QQ
 4N4T+HNFZQYs2BD1w5oWx9eZxjx8ED912+taYxIjQiKqRs7fbjrg1oenCEK+eyFlSVVXh4
 7TH4501Hmo2P1C/37ZJC9X08uHHKPLbmjoSRtfsHCyX5zSdpKJklH2IH17HY8g==
Message-ID: <af28050f-6c36-a11b-f522-518f6917bd36@nabladev.com>
Date: Thu, 14 May 2026 15:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: designware_i2c: Staticize driver ops
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, Tom Rini <trini@konsulko.com>
References: <20260508122102.512765-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260508122102.512765-1-marek.vasut+renesas@mailbox.org>
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

Hello Marek,

On 08.05.26 14:20, Marek Vasut wrote:
> Set the ops structure as static. The structure is not accessible
> from outside of this driver.
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Maarten Brock <Maarten.Brock@sttls.nl>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Add RB from Heiko
>      - Drop the const part, this conflicts with ACPI_OPS_PTR macro
> ---
>   drivers/i2c/designware_i2c_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-i2c

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
