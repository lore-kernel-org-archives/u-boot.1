Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDD4C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D48282BA1;
	Tue, 29 Jul 2025 15:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hVAWDpZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4141B82E05; Tue, 29 Jul 2025 15:21:57 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B132F8129F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4brwww5WF8z9stk;
 Tue, 29 Jul 2025 15:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753795312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyUvIqoVIk4yRHPmAcSXgbGd3I6udVzgJcl8tuPR0Ng=;
 b=hVAWDpZp1CXpYAscslfiSLJaFpJ4cHw8sQLt8OdCEzXc97CCDl9aEW3vWgzIMK+hT0Doh0
 l+prLQOMhVBKpTqR6tC80WFAdUwgiRL6l1DgPTQRr2IpvMemnHeEzSD7HIvQv7iVNP0JG8
 auUCpswSFeBv9GacKd09Ve5o+3zwnIEcC3IWehmmybz2zAT7caE3PHCoVABYShDZ7EfK2b
 g1rEfC/lOMmtgd/s/G4rzAtxSAT2c5K6VCj0mtARb7LWqsYu76Kws4azQS2YUq/n5x/vhW
 ORI93dHJJMQ6mH3ajP7MwbdXmoZQ/D5+pk3FsMOpCHH23H1/9iwT8Ooa6r0dUQ==
Message-ID: <17049ab1-d4f2-4660-9818-7127cea61434@mailbox.org>
Date: Tue, 29 Jul 2025 15:21:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] spi: mvebu: Correct dependencies on MVEBU_A3700_SPI
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250702010405.18791-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250702010405.18791-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: usk37n7dwufhefxdbzgqetszz37zsg5t
X-MBO-RS-ID: dbeba35ee9020125c30
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

On 02.07.25 03:04, Tom Rini wrote:
> A dependency exposed by "make allyesconfig" is that the logic around
> this symbol was not quite correct. It needs to depend on ARCH_MVEBU and
> ARM64 and then select CLK_MVEBU.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Cc: Stefan Roese <sr@denx.de>
> ---
>   drivers/spi/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index a3513f0a3ef8..1ae36b5a348b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -351,6 +351,8 @@ config MTK_SPIM
>   
>   config MVEBU_A3700_SPI
>   	bool "Marvell Armada 3700 SPI driver"
> +	depends on ARCH_MVEBU && ARM64
> +	select CLK_MVEBU
>   	select CLK_ARMADA_3720
>   	help
>   	  Enable the Marvell Armada 3700 SPI driver. This driver can be

