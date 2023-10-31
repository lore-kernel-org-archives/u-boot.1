Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5361AC4167D
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC9587B06;
	Tue, 31 Oct 2023 08:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698736500;
	bh=01rXqlIil3hBmF1udIV+1a9DUdXHUDK9ppeAVZfk6xM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ti1IYbtXnffSIVSvx8vguDDPJUG+VWyVElv/8WN9wJEDMEbKZtc81v+hWQkJgGN56
	 p0QWVjz11ehYaYSS9kKWBv62S0ANog39+kHTHbbUKKLuMFklgkylEm7ds2a6DxHMsB
	 U4SzLaGvCypdplJZKcOut39b98u2yjY5hjRfzwQ7M0KZAOssq/wbT0ThQQLBs5foT6
	 07UVdMnZaG5l/HiaDMlCYgMoQBbkyJh+yvdc9LfSudQtVLec3QyfjV3bkf+OPSfMpB
	 rq6uYZ7TRPZR0k3LBYvS4j7yuu/yx/tpLp2/HtsbnwEAGsM/arrK9mjCz4zSp6nbK4
	 FVJoyZcfW+WwQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F8987B08; Tue, 31 Oct 2023 08:14:58 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFC087AFA
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SKLxV66Gnz9scL;
 Tue, 31 Oct 2023 08:14:54 +0100 (CET)
Message-ID: <2f42b8da-118e-45f2-a76a-813bd034e693@denx.de>
Date: Tue, 31 Oct 2023 08:14:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] spi: cadence-quadspi: Fix error message on stuck busy
 state
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <856ada64-ba6e-4f32-bbf5-23030df85238@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/30/23 17:20, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We are not iterating CQSPI_REG_RETRY, we are waiting 'timeout' ms, since
> day 1.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
> We are unfortunately seeing that message right now, rarely but then
> prominently...
> 
>   drivers/spi/cadence_qspi_apb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 9ce2c0f254f..d033184aa46 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -171,8 +171,7 @@ static unsigned int cadence_qspi_wait_idle(void *reg_base)
>   	}
>   
>   	/* Timeout, still in busy mode. */
> -	printf("QSPI: QSPI is still busy after poll for %d times.\n",
> -	       CQSPI_REG_RETRY);
> +	printf("QSPI: QSPI is still busy after poll for %d ms.\n", timeout);
>   	return 0;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
