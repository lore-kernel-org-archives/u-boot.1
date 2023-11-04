Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955FCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 18:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44E987037;
	Sat,  4 Nov 2023 19:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iw2V65Vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F178B8704B; Sat,  4 Nov 2023 19:40:39 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC8487037
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 19:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-672f5fb0b39so19322746d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699123236; x=1699728036; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ja/FE5wN+tTL4Kr54S+UUTq69lbgK/uClyCwJTa5hF4=;
 b=iw2V65Vb0XCWSP7nvTS3tj0zTMibuy11p/h8R3OvFhNjjkESU3oAP5LNAYfVBWY4v3
 eo4bfguE6z/9Uzp+An4fPEfRhwQ4Rd7411eIxYrWWaMLR6piwfKjn83MZ2e0X7K+d3ym
 Y9ByExAxFUlT2XS6MKaICf4JBIzgjf53UdwIvnfwEEpsrQOZu5igOak6hhf5WekELGJ6
 w3EwyQ21OyoK//i3t6w+Qa3998qVPzKnrdvfmmbVa+EVmW8Q4KbUzf2Rd+OZ/aSewDmC
 nmjRAJcO/eBuSJx8pyD8dNzkVffGRzIg76ZDz7Hz7jAAxJDheDFWOFAjk3+tynv15oSw
 6P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699123236; x=1699728036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja/FE5wN+tTL4Kr54S+UUTq69lbgK/uClyCwJTa5hF4=;
 b=j7zLRTIfHgsuCILtwUdD/Nt7iYvCqo/MkUD5v0GDUm4Aq6Xdn1yZKYsE5nFfykpvPM
 W5p2tVXkuXd0x2zXwSPfALONQT2LXbGyABGEmdYHTiSa9fvwfoDbF8YTidn6IUdpFDXy
 zkb250IQuGyQn59cs12jh0iQeu5myDu0nk55YoBRtegeBCo4HiEUITBwPsllN1wuYx3o
 MmTIG0yz8FnWuOF1sUyjSbFKGZ6/AbBWKuplmKui8koSBu8xPlyErBXzUf2MyioufrRM
 Mebhh6OMq1hPfZdowOxJgFRywnLswhE+u2OzEatrtwqp1DrKBf1g/sHT8JTwIKT1xP7z
 86Yg==
X-Gm-Message-State: AOJu0YycI/405YR0WR8lOWRqLDiFvcwO6ERLQRCI1yB6Kl5GOuDwEY/H
 4EQkUd3/+J7EY25zy3tAO54=
X-Google-Smtp-Source: AGHT+IFJ4GXr/ZUzlj3TCJF03jyuJoGGJdQcfPZSQd7HT2n5QUjYITLbS854SHftoIr5Gy7SO23OTg==
X-Received: by 2002:a05:6214:c2c:b0:672:e2d5:7a7f with SMTP id
 a12-20020a0562140c2c00b00672e2d57a7fmr18346059qvd.29.1699123235999; 
 Sat, 04 Nov 2023 11:40:35 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 x1-20020ad44581000000b00647386a3234sm1845865qvu.85.2023.11.04.11.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Nov 2023 11:40:35 -0700 (PDT)
Message-ID: <d6968ccd-9bd9-56d9-030c-52892d137c07@gmail.com>
Date: Sat, 4 Nov 2023 14:40:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/8] clk: Add dump operation to clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, prusovigor@gmail.com,
 kernel@sberdevices.ru, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20231102122017.56995-1-ivprusov@sberdevices.ru>
 <20231102122017.56995-6-ivprusov@sberdevices.ru>
 <712d1810-93ad-8fd5-8989-1274b5ce49ce@gmail.com>
 <20231104180920.ubq4odp454n4wo52@pc>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231104180920.ubq4odp454n4wo52@pc>
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

On 11/4/23 14:09, Igor Prusov wrote:
> On Sat, Nov 04, 2023 at 11:24:32AM -0400, Sean Anderson wrote:
>> On 11/2/23 08:20, Igor Prusov wrote:
>>> This adds dump function to struct clk_ops which should replace
>>> soc_clk_dump. It allows clock drivers to provide custom dump
>>> implementation without overriding generic CCF dump function.
>>>
>>> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>    include/clk-uclass.h | 15 +++++++++++++++
>>>    1 file changed, 15 insertions(+)
>>>
>>> diff --git a/include/clk-uclass.h b/include/clk-uclass.h
>>> index a22f1a5d84..793bf14160 100644
>>> --- a/include/clk-uclass.h
>>> +++ b/include/clk-uclass.h
>>> @@ -25,6 +25,7 @@ struct ofnode_phandle_args;
>>>     * @set_parent: Set current clock parent
>>>     * @enable: Enable a clock.
>>>     * @disable: Disable a clock.
>>> + * @dump: Print clock information.
>>>     *
>>>     * The individual methods are described more fully below.
>>>     */
>>> @@ -39,6 +40,9 @@ struct clk_ops {
>>>    	int (*set_parent)(struct clk *clk, struct clk *parent);
>>>    	int (*enable)(struct clk *clk);
>>>    	int (*disable)(struct clk *clk);
>>> +#if IS_ENABLED(CONFIG_CMD_CLK)
>>> +	int (*dump)(struct udevice *dev);
>>> +#endif
>>>    };
>>>    #if 0 /* For documentation only */
>>> @@ -135,6 +139,17 @@ int enable(struct clk *clk);
>>>     * Return: zero on success, or -ve error code.
>>>     */
>>>    int disable(struct clk *clk);
>>> +
>>> +/**
>>> + * dump() - Print clock information.
>>> + * @clk:	The clock device to dump.
>>> + *
>>> + * If present, this function is called by "clk dump" command for each
>>> + * bound device.
>>> + *
>>> + * Return: zero on success, or -ve error code.
>>> + */
>>> +int dump(struct udevice *dev);
>>
>> Actually, this should return void, since we don't do anything with the return code.
> Good catch! Though there is, for example, zynqmp_clk_dump() that may
> return an error code. Wouldn't it be better to print an error message
> with the code in soc_clk_dump()? It might be convinient to have common
> code handling unexpected errors during dump.

Since this function is for printing, if the driver gets an error
it should just print the error itself. It can probably provide a better
error message than we can. And this command is mainly informational anyway,
so we don't really need to set the return code (e.g. $?).

--Sean

