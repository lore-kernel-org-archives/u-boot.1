Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22109CA0EC8
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F22488C81;
	Fri, 30 Aug 2024 02:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PcxIzjfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E04788D13; Fri, 30 Aug 2024 02:24:09 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A529488BDA
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-201fae21398so9147725ad.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724977445; x=1725582245; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbFIlInI9N1Kom4h/CuZ/DFGvtfUyjpnBcnmFT+Thrs=;
 b=PcxIzjfl9yXVsDMgf/M4Bq2lwRX8JaE+oYofBztPrllL9uvpXI34l1dtSpEoNoifTG
 lFy759fQXNNbD6sgB2sTVQZ601hasmmLzEjt+8GGK/wI6qvoX0uSpw0+8zOJoy2H9atH
 XCFCA25bk9AHB4M3thtJbs5Dn+QviI6bfn5zsP0697GVO2yLNFWR+ossqSur6oZVNDOO
 c1BqvRIjeIo7RzcctwNYpZkQygh1v+rPi22XOP5AKmWV3C0L/oe8+ZZI2rTWOBbEgHYc
 nMislBSrWvrMLzr/7CfdIr+a839uoMg8Phwukp3++shmS1v+UOjdg10lxQ8IzYIvmESk
 PWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724977445; x=1725582245;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbFIlInI9N1Kom4h/CuZ/DFGvtfUyjpnBcnmFT+Thrs=;
 b=Y9BjwbxuYmFyA1W7JMgNZReeqtRIPyhJB7IqIId5xxvAVFgf/0e4ta5foHYO5buKP/
 JVotERzF+/HH1sjBezrHSUVIbvKX9+fiLPA5XTzSP2VL0hUvI4XMcZ21Z+ZD/btzTNn4
 IBNZEBzDCQfhfMr+xGDS/CL6F+Ucy63sWwG1RcKzqyuOtamC5maGPycfAg5MaEHyi90+
 8FKXtuxWlgeQEnfSnz1mIE7rLdec+kHBRMoHJnW/1UNQwZefosW20eXWmTRD5oGmSsws
 9U7MC/Tu5mjUk+it+KR2+XG0sE0zprky4KBR2aHaNdw82q1svKRSNTQtUnlvGOsVvvoM
 /Z3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfMY15+IifHqJ+uVOhieS7gCLjJtl7mNfXnspOWsE4jYMn156/n0jQ48hYSIP8Hn0Jcx3E3c=@lists.denx.de
X-Gm-Message-State: AOJu0YwSgWv6upbrRVDtCf9Lo24qsloV71/bcamvslQytB7mOjqJ0M4B
 TBy2NpiUusG93Gpsl61ZmFBfQKI0wQWmB8DBmrfXetydO2K4irBO
X-Google-Smtp-Source: AGHT+IFcuGDiyYDpsa3B9XwnsvTpk9QeKyU7fSfpU4An6tCXJsx0nakla2zONVgf13+ZNul6tXS6mQ==
X-Received: by 2002:a17:902:d4cb:b0:202:32cf:5dbe with SMTP id
 d9443c01a7336-2050c4a1977mr48387475ad.58.1724977444865; 
 Thu, 29 Aug 2024 17:24:04 -0700 (PDT)
Received: from [192.168.0.8] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-205155564dfsm16693255ad.266.2024.08.29.17.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 17:24:04 -0700 (PDT)
Message-ID: <c8fb13f6-4c1f-473e-9744-df7657a7f756@gmail.com>
Date: Fri, 30 Aug 2024 09:24:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Disable chip erase for S28HS02GT flash
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20240730120557.12728-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20240730120557.12728-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,

On 7/30/2024 9:05 PM, Prasad Kummari wrote:
> From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> 
> Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
> for the S28HS02GT flash, the NO_CHIP_ERASE flag has been added
> to enable sector erase functionality instead.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
> Changes in v2:
> - corrected commit subject.
> 
>  drivers/mtd/spi/spi-nor-ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index 0908fb954e..1b737a3507 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -383,7 +383,7 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
>  	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
> -	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE) },
> +	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE | NO_CHIP_ERASE) },
The 'SPI_NOR_MULTI_DIE' is not defined in mainline u-boot.
I have submitted another patch:
https://patchwork.ozlabs.org/project/uboot/patch/20240830000537.18862-1-Takahiro.Kuwano@infineon.com/

Thanks,
Takahiro Kuwano
