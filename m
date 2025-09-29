Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97373CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 23:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87D983071;
	Tue, 30 Sep 2025 01:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vUcEA6tz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431C1832DA; Tue, 30 Sep 2025 01:03:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42237828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 01:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cbGvg2ds9z9tQL;
 Tue, 30 Sep 2025 01:03:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1759187023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ry6w9L1EScmBCHs2y9oQ5X+i8PliYDvImt+IFLhlDh8=;
 b=vUcEA6tzaJm1oshGRXyICwnWfBTJVnUARrprtdx6L54WcVQec7WVt+YFq0/yz9l0sO0bba
 51nY4ZhKsxlEQJNPM6gUYOYUaEytLmNBqy/3AWwVARfdfaiQjLrlEHkEDWkILed07M3xKI
 +d3+iliT91iWfKtMmNdrDTRCLu0wP+wj1KD/dW0SDk7SQCQYUUGIfVsXkSyephVFSh2Nkt
 viXrckbLJWAOcNhd6N+LEbesGAby+N3ExrnuhR7pVnyuwkmfjD4558HRgRqcCNNRq3sTZf
 jHaX9K2b4XeAZc/NsGCkXNYp+9lJnx182pS2RMWG+F8r6XMf9gmQq90YOQMzyQ==
Message-ID: <c7163cf3-b108-45a1-8b03-0a09a0429032@mailbox.org>
Date: Tue, 30 Sep 2025 01:03:41 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] apple: Set up file system firmware loader
To: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com
References: <20250929195241.70351-1-kettenis@openbsd.org>
 <20250929195241.70351-2-kettenis@openbsd.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250929195241.70351-2-kettenis@openbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: dc544dac730cfb6daa5
X-MBO-RS-META: eown5tdwj31mfdxjm5risi836g648ux5
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

On 9/29/25 9:52 PM, Mark Kettenis wrote:
> Find the appropriate EFI system partition on the internal NVMe
> storage and set the U-Boot environment variables such that
> the file system firmware loader can load firmware from it.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>   arch/arm/mach-apple/board.c | 59 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 4cd8979bdc2..d8b6787c705 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -8,6 +8,8 @@
>   #include <efi_loader.h>
>   #include <env.h>
>   #include <lmb.h>
> +#include <nvme.h>
> +#include <part.h>
>   
>   #include <asm/armv8/mmu.h>
>   #include <asm/global_data.h>
> @@ -771,6 +773,60 @@ u64 get_page_table_size(void)
>   	return SZ_256K;
>   }
>   
> +static char *asahi_esp_devpart(void)
> +{
Maybe try request_firmware_into_buf_via_script() instead ?

That might make this more flexible /wrt firmware location and user 
preferences.
-- 
Best regards,
Marek Vasut

