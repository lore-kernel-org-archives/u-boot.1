Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5E8C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 12:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A2BC8081A;
	Mon, 17 Mar 2025 13:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742215578;
	bh=nNF+NQKhf1aul7uzKwJxVh6CT+mgUK3Txpo/qNMol3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PV9Co77j7dto1zUU5gErF3WrBnn2n8L30Mz8tF4BLxjwXMWp9IqtVErKWZPSgQRjs
	 KqRCTPMEnV4jJcr5XZCYwbdWpJsV348zzpSbjE/UpbIBUBAwDmpEf8rD7L9KSCJwDk
	 bMUDRVkAlVejbco8RLuBVXl9nyWEj7U39nwPJ5mue/eVhvpmMx/DrxRYULwTRx7iW5
	 cZBiSMC/rfwH07ftDoEw7HP4bULgcmJa6GmAyu3FiJQaWWDfC1usWEiHFwOCAVzXQw
	 n9j75LoQS/HINYfbgaY4N1qQE8fWosj0bKH90iMqQ9uOw+gX72EkOT802ExPd+MUxJ
	 dap1xy7ggfLuA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 547D180F4C; Mon, 17 Mar 2025 13:46:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57AEE80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 13:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="a7cjYo5P"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1C06F102901E2; Mon, 17 Mar 2025 13:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742215574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nNF+NQKhf1aul7uzKwJxVh6CT+mgUK3Txpo/qNMol3o=;
 b=a7cjYo5PRQXI0Y4fJXbjS4OhTAVe3AwcQMIl8+dMwYY/CnvaaQuV1M9ohNp0B3MemsyBZb
 wYZiuliqMl00rbbcnjjVzuw7tlGYUOtGA3GgWPDiP4CSnuvyzT2J2gdqDcckVbVmEZmSFK
 1Fw8O53MB2nFFgSfi/8g4CzFmorsPgGxlmy2xekBNrEOabV9jANeFjf9T0/ns29d5ASBm2
 /ixA1CUMklUdY/vxg0OOBBzt2+WIC3hF7cwn5mWbs1T3X5d++o1bYwjGclSUe8AhUjLotU
 s3Tjd5AJv2fTJ8Qe/WLuPv8aq7Mguc118OYSHyLzVOHFG208lE8WC4tFLw2LTg==
Message-ID: <0867604d-b857-46c1-a148-8d10a1cb55b6@denx.de>
Date: Mon, 17 Mar 2025 13:44:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Add USB driver file to visionfive2
 maintain files.
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Hal Feng <hal.feng@starfivetech.com>
References: <20250317113627.84885-1-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250317113627.84885-1-minda.chen@starfivetech.com>
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

On 3/17/25 12:36 PM, Minda Chen wrote:
> Add USB related file to Starfive visionfive2 MAINTAINERS.
> The N: pattern can override this.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>   board/starfive/visionfive2/MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
> index 898e284ce2c..f1d2deb9f5c 100644
> --- a/board/starfive/visionfive2/MAINTAINERS
> +++ b/board/starfive/visionfive2/MAINTAINERS
> @@ -3,5 +3,6 @@ M:	Minda Chen <minda.chen@starfivetech.com>
>   M:	Hal Feng <hal.feng@starfivetech.com>
>   S:	Maintained
>   F:	drivers/ram/starfive/
> +F:	drivers/usb/cdns3/cdns3-starfive.c

What about using 'N: starfive' instead to match on all files which 
include the string 'starfive' ?

>   N:	jh7110
>   N:	visionfive2

