Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B6CC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 13:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73B188545;
	Fri, 24 May 2024 15:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NixMxMxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED59F88552; Fri, 24 May 2024 15:06:26 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D52288246
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 15:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-354e0d4db6cso1877175f8f.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716555984; x=1717160784; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVjljqST71AgJTZ1A6rovcNnZ5PvYx8SRPuPg6Q8uhM=;
 b=NixMxMxH2r1HIBWvEeYu7jft9s2e1aDXc9R3dHCr/3brh2rezLjUrhdqLAVDOyGV5C
 VSjEmUDPA2jGYET5ul+h3jN/yX2PHANlHrNWf+PvWGyFmc4JmYFyNh27dcLmKBCWJzZn
 GNzBUcSUo5T2XfJRVd3lAGY33PMDGjakXal/Iy099c3neZ1yN2412cNv1EiuBmT5ATai
 IEMFoVMPwf+xt+ORHZP4OBIHA4O4zmAhctF68sT9NggyxF0Zobuiumuc3H8HP1b/jpYK
 F9bovLlB016whL0247cUy3USOa8L4ESI1oxwaYsczK2apCTYJbofTbaRWoAIaioMTAKL
 puCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716555984; x=1717160784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVjljqST71AgJTZ1A6rovcNnZ5PvYx8SRPuPg6Q8uhM=;
 b=w7toug+PMMdPhzdD0RTm6uj26HZNr1e1ZFHXieRmw+fxMz1Fdp9eAVRYcHSU9XV42t
 TfRP0ROcR24AHn2N7pmoGBqQ1S0y/aGZYImaNn+t/Z7MzO7u/Vob868Bh3p7KqfA+nZi
 lCibaVy9pA8250sKdNS1Ozd3TT+JRg3ZFjcSHrYARuqf9hOOIGSfNH004NYE5gXStI1a
 P50hrvXrjQ8qPqxzDOTsdSYlhV/VPbJwZiUSBm+fbIAK5JOS5pn0Ay1wABBA9/oKJ27h
 qjZ1DouAJ3H/kRryDeMnHdgVogWBqKLwc82EAmVus8JzmfgfkWChV3g/JJowKxe0z5oB
 Q2GQ==
X-Gm-Message-State: AOJu0Yyo5uC3nnWqlRKYcLatagQC2dcWSoY65GtoRKat8GDAh5TnlJxQ
 2xUkhpukPLH1ZjCtuYTO7cpb1joh0eSpuuRsOodH66HyZHLWudSzCVf7p2PGz5o=
X-Google-Smtp-Source: AGHT+IEK37YmKw8LnQZU09Z+OGBAOwuLmFHWqRrPH05cnRuiCjPHI8Ykh0KCXtFQD59Z4TDICkPOTg==
X-Received: by 2002:a05:6000:b46:b0:34e:81ab:463f with SMTP id
 ffacd0b85a97d-35506d5d0b0mr2014056f8f.20.1716555983799; 
 Fri, 24 May 2024 06:06:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c?
 ([2a01:e0a:3cb:7bb0:4db2:46ef:25c5:9c4c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35579d7dd42sm1572654f8f.22.2024.05.24.06.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 06:06:23 -0700 (PDT)
Message-ID: <c3c9968e-f8e1-43ab-b44e-e9f7eed343c3@linaro.org>
Date: Fri, 24 May 2024 15:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] net-lwip: import net command from cmd/net.c
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
 <8c97a1e0a572fde6a764c2d20bd0fc1376e1cf90.1716393035.git.jerome.forissier@linaro.org>
 <CAC_iWjJaaG3_sQLbzJAz6-wnVYy4ifgDxwGBrbXgEv8GXOw-Rg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWjJaaG3_sQLbzJAz6-wnVYy4ifgDxwGBrbXgEv8GXOw-Rg@mail.gmail.com>
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



On 5/24/24 11:38, Ilias Apalodimas wrote:
> On Wed, 22 May 2024 at 19:04, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Add support for "net list" and "net stats" to net-lwip/ by copying the
>> code from cmd/net.c.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  cmd/net-lwip.c     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/net-lwip.h | 50 +++++++++++++++++++++++
>>  2 files changed, 148 insertions(+)
>>
>> diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
>> index 2926399bd0..20d0d61176 100644
>> --- a/cmd/net-lwip.c
>> +++ b/cmd/net-lwip.c
>> @@ -2,6 +2,10 @@
>>  /* Copyright (C) 2024 Linaro Ltd. */
>>
>>  #include <command.h>
>> +#include <dm/device.h>
>> +#include <dm/uclass.h>
>> +#include <linux/compat.h>
>> +#include <linux/ethtool.h>
>>  #include <net-lwip.h>
>>
>>  #if defined(CONFIG_CMD_DHCP_LWIP)
>> @@ -43,3 +47,97 @@ U_BOOT_CMD(
>>         "[loadAddress] URL"
>>  );
>>  #endif
>> +
>> +static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +       const struct udevice *current = eth_get_dev();
>> +       unsigned char env_enetaddr[ARP_HLEN];
>> +       const struct udevice *dev;
>> +       struct uclass *uc;
>> +
>> +       uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
>> +               eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
>> +               printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
>> +                      current == dev ? "active" : "");
>> +       }
>> +       return CMD_RET_SUCCESS;
>> +}
>> +
> 
> Some of these functions seem to be a c/p from cmd/net.c
> Carve the common ones out in cmd/net-common.c and reuse them please

Totally makes sense. Done in upcoming v2.

-- 
Jerome

> 
> [...]
> 
> Cheers
> /Ilias
