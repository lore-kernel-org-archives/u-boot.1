Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C496FC2BA1B
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 00:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D7485894;
	Sun, 17 Sep 2023 02:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jSStN1qc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321B485E44; Sun, 17 Sep 2023 02:01:02 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57AF8585E
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 02:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 239A03F13B
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694908854;
 bh=Zofkr/ENRYkyGZF0SYj1snVg2DzUV5SR8jTJBkLdTwE=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jSStN1qccILkeItP9sSS/4RIwaHV46uCCbciQ7vaHqFgo/cZa2myYZnHsEIADYW/e
 opwo4aeiMoJNUqBzqcBS2EVA90Isl7t+AD8uy9GR8skIe087fUT0LtDyQmjk1QNU5G
 rn7tW/rq+8C4P4nSqhJqKAO7NfdsPRurRZm/rnc1F+G0LGNV/7654+4CzIHHB38nBp
 ORbnG7f5YdplwVPjtPyPTpgfiMoyWejenaRtghgUgBkj3rOD8t0jHGD2X5msXK2FnD
 lmCDUwH6Ndz7kCgH20/bF49KaabIAPzgBWaeOWFhqPqTHVw5aP/GMXYu5klL/Br+Qd
 MNU3Ul9zDYhpg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so26708745e9.3
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 17:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694908853; x=1695513653;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zofkr/ENRYkyGZF0SYj1snVg2DzUV5SR8jTJBkLdTwE=;
 b=XbITs7Bsrj8KuN2gfzkT4BG1GMlubkisSTxIFvhjpeWME29c6UJDVWTuITGdqiZJ8F
 PECNNuVMXfBNgegIYJkuBO9a4kc5X9SxDy9IfwXoYHHxMKR3cythAS3JWZuWU6m0Njcj
 xpHrMD87kWpXGgx5IZFcMsGT6Y4E9qybSzRxbRD83u7syxuQrdW4rVtSJZ4KRwLVISW+
 m7tipkXenEgQMTo9DecMA6LLakfrXFgAxcjcTQHb9X4FdwG0YYNt2sVAtGKvY8Uqghhc
 c6K48AxyfePKX2xKGWB0cOUKHzE+t9PWH9GfEbg8WCfqxe/bykywmbKfC20McsT+27fX
 WuNQ==
X-Gm-Message-State: AOJu0YxuyZYWRnK/5vpmtJ7H94+ut5aywLTTr6WkqDbWfqHIIfW1Apnc
 Fc3RvzpPshRnKQgADZ6M4MmHkZgD+u9HhIj69AxEm6TbJU5mSwRnRjY7n/mq8pzxnA4kcFMjW+5
 qwZqW9jE0IkrrdAOShaTI+jDpCSmIqGc=
X-Received: by 2002:a1c:f717:0:b0:401:cb45:3fb8 with SMTP id
 v23-20020a1cf717000000b00401cb453fb8mr4958566wmh.38.1694908852691; 
 Sat, 16 Sep 2023 17:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHLRBZwKuIfLBMuiWdsj979qiZxbssfrpdyWuKImY/0c7Bfo8UrafFhTLBCFWG5/HMXLNqEQ==
X-Received: by 2002:a1c:f717:0:b0:401:cb45:3fb8 with SMTP id
 v23-20020a1cf717000000b00401cb453fb8mr4958547wmh.38.1694908851668; 
 Sat, 16 Sep 2023 17:00:51 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c214d00b00401dc20a070sm11299595wml.43.2023.09.16.17.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Sep 2023 17:00:51 -0700 (PDT)
Message-ID: <047fd798-5501-42fd-a5cb-ff1d84043f96@canonical.com>
Date: Sun, 17 Sep 2023 02:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] riscv: dts: starfive: generate
 u-boot-spl.bin.normal.out
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
 <20230906120008.86717-3-heinrich.schuchardt@canonical.com>
 <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <7e069c36-fe99-3701-9572-1363b694645b@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 9/17/23 00:19, Jonas Karlman wrote:
> On 2023-09-06 14:00, Heinrich Schuchardt wrote:
>> The StarFive VisionFive 2 board cannot load spl/u-boot-spl.bin but needs a
>> prefixed header. We have referring to a vendor tool (spl_tool) for this
>> task. 'mkimage -T sfspl' can generate the prefixed file.
>>
>> Use binman to invoke mkimage for the generation of file
>> spl/u-boot-spl.bin.normal.out.
>>
>> Update the documentation.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> Tested-by: Chanho Park <chanho61.park@samsung.com>
>> ---
>> v2:
>> 	Fix a typo in a comment in tools/sfspl.c
>> 	Add Tested-by credit
>> ---
>>   .../dts/jh7110-starfive-visionfive-2-u-boot.dtsi   | 10 ++++++++++
>>   doc/board/starfive/visionfive2.rst                 | 14 ++------------
>>   2 files changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>> index 13f69da31e..defe2b605f 100644
>> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
>> @@ -103,4 +103,14 @@
>>   			};
>>   		};
>>   	};
>> +	u-boot-spl {
>> +		filename = "spl/u-boot-spl.bin.normal.out";
>> +
>> +		mkimage {
>> +			args = "-T sfspl";
>> +			blob {
>> +				filename = "spl/u-boot-spl.bin";
>> +			};
>> +		};
>> +	};
> 
> This should probably be:
> 
> mkimage {
> 	filename = "spl/u-boot-spl.bin.normal.out";
> 	args = "-T sfspl";
> 
> 	u-boot-spl {
> 	};
> };

@Jonas
If I replace the node u-boot-spl by the suggested mkimage node, I get a 
file spl/u-boot-spl.bin.normal.out which is identical to 
spl/u-boot-spl.bin. It lacks the header that mkimage should create.

Replacing the blob node by a u-boot-spl node is possible. Whether it is 
better readable is a matter of taste.

@Simon:
Could you, please, have a look at doc/develop/package/entries.rst. It 
seems not to fully describe how binman is controlled via the device-tree.

* A blob sub-node for the mkimage node is not described.
* A mkimage node which is not a direct subnode of binman is not mentioned.
* Why the target filename must be outside of the mkimage node in my case 
is not evident.

Maybe a more formal description of the schema in a yaml file would help.

Best regards

Heinrich

> 
> Regards,
> Jonas
> 
>>   };
>> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
>> index 941899a0a4..f5575ab68b 100644
>> --- a/doc/board/starfive/visionfive2.rst
>> +++ b/doc/board/starfive/visionfive2.rst
>> @@ -65,18 +65,8 @@ Now build the U-Boot SPL and U-Boot proper
>>   	make starfive_visionfive2_defconfig
>>   	make OPENSBI=$(opensbi_dir)/opensbi/build/platform/generic/firmware/fw_dynamic.bin
>>   
>> -This will generate spl/u-boot-spl.bin and FIT image (u-boot.itb)
>> -
>> -u-boot-spl.bin cannot be used directly on StarFive VisionFive2,we need
>> -to convert the u-boot-spl.bin to u-boot-spl.bin.normal.out with
>> -the below command:
>> -
>> -	./spl_tool -c -f $(Uboot_PATH)/spl/u-boot-spl.bin
>> -
>> -More detailed description of spl_tool,please refer spl_tool documenation.
>> -(Note: spl_tool git repo is at https://github.com/starfive-tech/Tools/tree/master/spl_tool)
>> -
>> -This will generate u-boot-spl.bin.normal.out file.
>> +This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
>> +as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
>>   
>>   Flashing
>>   ~~~~~~~~
> 
