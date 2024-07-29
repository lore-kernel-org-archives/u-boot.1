Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D9C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8537A885EE;
	Mon, 29 Jul 2024 17:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QAWvy/O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E425885F5; Mon, 29 Jul 2024 17:18:40 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB338855C
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso1437293f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266317; x=1722871117; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZ0MhM/pileJKK0kJiV9iYrR3b6e7mj4NF8mZi1dVEE=;
 b=QAWvy/O7TWnQeX9/Ocu8lava17Au1o2EjTAz0lCy48gM0eDN/CuXRwxktxvgz7dML8
 +jE4wcNGANdk7boZy6cnWdHe92pxghVWwSvzWimnVYiK1KVSn8Qc5UOk0cuLOgknbSYJ
 03IbkSVUK8uNkAnBIxhLF2eCiPYMXe9kK1x64qbgYoHspFdMbrWGX+dY3mv7C5HiBmpw
 /40DuA/Rk+Dxc+rsCyAMq1vyJhDmhvdbh8/bDuVz1jrA2ChHvZ8KsNm/D7DmnUlN50qt
 PKDUG1JRZ5txN7AnfEvdaLb62WsCC4uWn6L5Q08MmfaSi6NipwC4HEZriSqqUxZ9FMDt
 2j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266317; x=1722871117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZ0MhM/pileJKK0kJiV9iYrR3b6e7mj4NF8mZi1dVEE=;
 b=BVzCqQMRegbrTuLP7NLji/bxUvKtFkZIuTPZ1YtqC9qnXXq6iZQV51zlwD2IV7JfFH
 x0J7lUliSNcMm4+JPcqfywtjKUkM3IMWGngtlvv40jEJHPrcU6azSgAfkErJk1sm9Mdd
 +MacXldMIb8CHRWvUJ5LpD4UJTxffBaBlxXdxLe2IIPkUrlON9DQYuPp1oyyZ1l9fZIs
 QfAoVwAMb4e8Fu30B7rD3+WF5EteehhR6Ada6bf9V+7fHLzfJjQLfW9abbsw9yYWCTXm
 jwn7I8XTKAlL/IcGOfm7qBj+8zBKhvzXIIfipfPdG8NdsVwUAOXWlWsoa7Wb2J0/3UEf
 5TFA==
X-Gm-Message-State: AOJu0Yw4r/DA+qE2uYyKI4IonPzbJ7sOMWazGdpQPCxwbyy2LshtcZ1B
 qaEq9JktJw9/C+iIm2QTztK7f2VicjgTJHfRvS89RIoeH5eQzJruRX/FxYuNK2I=
X-Google-Smtp-Source: AGHT+IF93q9o9OrpZpU7o4Qp1/COnCF5DZcphUAfFqn6dNJjnRykopMVvfkJOeEy0DTiTjjQOkxunw==
X-Received: by 2002:a5d:58c1:0:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-36b5ceee60cmr5045603f8f.19.1722266317479; 
 Mon, 29 Jul 2024 08:18:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:252e:e6fa:2be5:5721?
 ([2a01:e0a:3cb:7bb0:252e:e6fa:2be5:5721])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857e3bsm12461357f8f.81.2024.07.29.08.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 08:18:37 -0700 (PDT)
Message-ID: <a117047c-8429-4209-9018-b160e9373ff9@linaro.org>
Date: Mon, 29 Jul 2024 17:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/20] net-lwip: add TFTP_BLOCKSIZE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Baruch Siach <baruch@tkos.co.il>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <4dee5a89157f3dd0e0a8d17ab6ff42292bb7ce79.1721910373.git.jerome.forissier@linaro.org>
 <CAC_iWjLpwGzyNqqgs0YVZpR4=Vncnd7V_DVDcONX9OweyrDWGg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjLpwGzyNqqgs0YVZpR4=Vncnd7V_DVDcONX9OweyrDWGg@mail.gmail.com>
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

Hi Ilias,

On 7/29/24 14:29, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Thu, 25 Jul 2024 at 15:59, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add support for setting the TFTP block size. The default value (1468)
>> is fine for Ethernet and allows a better throughput than the TFTP
>> default (512), if the server supports the blksize option of course.
>>
>> I tested this change with qemu_arm64_lwip_defconfig. The throughput is
>> now 875 KiB/s vs. 313 KiB/s before. That is still a low number, but I
>> think we can't expect more without implementing the windowsize option.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  net/Kconfig     | 20 ++++++++++----------
>>  net/lwip/tftp.c |  2 ++
>>  2 files changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 952690d677d..7e5406bb923 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -69,16 +69,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
>>           this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
>>           be configured.
>>
>> -config TFTP_BLOCKSIZE
>> -       int "TFTP block size"
>> -       default 1468
>> -       help
>> -         Default TFTP block size.
>> -         The MTU is typically 1500 for ethernet, so a TFTP block of
>> -         1468 (MTU minus eth.hdrs) provides a good throughput with
>> -         almost-MTU block sizes.
>> -         You can also activate CONFIG_IP_DEFRAG to set a larger block.
>> -
> 
> Why do you have to move the config option?

It is moved from the 'if NET' block to the 'if NET || NET_LWIP' block since
it now applies to both.

Thanks,
-- 
Jerome

> 
> Cheers
> /Ilias
>>  config TFTP_PORT
>>         bool "Set TFTP UDP source/destination ports via the environment"
>>         help
>> @@ -263,4 +253,14 @@ config SYS_RX_ETH_BUFFER
>>           since all buffers can be full shortly after enabling the interface on
>>           high Ethernet traffic.
>>
>> +config TFTP_BLOCKSIZE
>> +       int "TFTP block size"
>> +       default 1468
>> +       help
>> +         Default TFTP block size.
>> +         The MTU is typically 1500 for ethernet, so a TFTP block of
>> +         1468 (MTU minus eth.hdrs) provides a good throughput with
>> +         almost-MTU block sizes.
>> +         You can also activate CONFIG_IP_DEFRAG to set a larger block.
>> +
>>  endif   # if NET || NET_LWIP
>> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
>> index 78de0bd0dba..1fe948c84ec 100644
>> --- a/net/lwip/tftp.c
>> +++ b/net/lwip/tftp.c
>> @@ -136,6 +136,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>>         if (!(err == ERR_OK || err == ERR_USE))
>>                 log_err("tftp_init_client err: %d\n", err);
>>
>> +       tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
>> +
>>         ctx.start_time = get_timer(0);
>>         err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
>>         /* might return different errors, like routing problems */
>> --
>> 2.40.1
>>
