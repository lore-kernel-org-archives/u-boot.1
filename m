Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D362C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B6180AE3;
	Mon, 10 Feb 2025 14:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OuklY6b9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8AD80AE5; Mon, 10 Feb 2025 14:26:56 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C601780821
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3EC633F2F0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739194012;
 bh=4VMN/DHxUM5SRKjp2nUFWpMBw8WxLAe5YrvOc/MQvZI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=OuklY6b9spRtwdHqQ+SlnKsMHVbjOagrh+94zba+Sk3CNJMCSyorRqakw9urjiE96
 aAxKdXtmLpOGpQqX0X+PRdwMQ99Zt5+3D4jbMgnou+bvCqpF2h022bqwB8Lpszn0ob
 g3pH0XipBw8CRpwp+bUngcYyeDa5CT9OgKN88pkxFmnsHka+TgbQNxgFGXEauLn0nP
 I/hBKKqu8wxSDG/Ih4PGmptTpDW+pdOOUIr+LWXhWDWZDYjN9LQe21Syx8bnH/e/y1
 fKuCmKPxL/vCbPUd2Z8FeAQYIPDgnoqRxejjAKj9sdNys6dcK97PZo9EhthFLWje1r
 14JdNTOpONwuw==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43933eb7f7eso11183755e9.3
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194011; x=1739798811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VMN/DHxUM5SRKjp2nUFWpMBw8WxLAe5YrvOc/MQvZI=;
 b=V6coiqzpx9tuJQLiPYfy+Faxzp3ucncO2CoVF6skQ7LAJFM+rGo4XjGuM3LcDMbSWp
 4X6W5ZSmOeCqMqiKlwWBevoK68BKJZJIbE9DfTkNf1i2sUU9OgeALcbLvgyjwn3+Js8c
 kjNYhvA3SPs9tbFgjf8b5Qg1X8q0VObK9T6p9ZKRzQt4KsfJguTycAA1B61wnwlbyIDp
 6GV2ijjK8HeVhIRq8dUV+5ut0u3AWHwtFdm5gXH51JYG7sQbCyYTtJ+V/yLjSX6M6YYY
 nyAS5qc7VuS0PJHjCSccKu797wUb/OlXXj7bzYfMg3A/UkwABMlY/3u8NPAksyjgTVaT
 DkVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRYiJNCylR56HmTirYSkF2hU6QoOuSmfvUMplRjPDT3b4tnkIIiZUCQkO9raEIw8nwrVDcUDI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9jLG76/Di1Bv+lSiBH4ENPr4sX8hJwlX5BwzxtGSYanwIGkNG
 ntrgKuYI1HxPDxzhvAcc+Ej2nj6YzfMWKqYlxpUDTQfeVb6qiz5Mqbupb/ZyrVc9LU6OciH8Sar
 dl7f6nhXmChSgY8IYEDPxTRTHqUY26DcZqi9QPc1XPtniKY1LZrsK8tCSMLPC7Wkr3YA=
X-Gm-Gg: ASbGncs52XD37slQO7nToYMnecFwud8TOGzuvpCKG3dDSmvOtPi53xKUP6BESj62ixs
 RtQQfPkCpoSOsV1w4Y8U5AoTjXZ1jMi4S1bmZ5sF3VtSksTcxCwYQ32XRL5eCQ/hbNYkvoOstS+
 bnKINYhSRoqUciyzHJd/3cxE7q/qhKbONFxTBxCPi95wOGZaofHn24fzHefiYcnNYMDutdfp79O
 /STW6/7cZ3Cjko2izs2AYhFQXgWNdQQbVLclHSGNYtaI1cbxqA/4mIjYM+vyDUdSeFaYzeba+tz
 8OCXfDDIakCLXt9JQ9/Ahn6XBY/aYtcvmy4CKKC0EPXb2Js4GUT5DnZ22dbfgJlVB/U6g6MBppA
 rww==
X-Received: by 2002:a05:600c:8706:b0:439:350a:ab52 with SMTP id
 5b1f17b1804b1-439350aacbemr74618735e9.30.1739194010644; 
 Mon, 10 Feb 2025 05:26:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8ioPSNpp6JFcekf8AzOu+nw0kHdizUw3tmD7cRW18docrScoPNS6b2GFbbNi4Yd0aGSGY1A==
X-Received: by 2002:a05:600c:8706:b0:439:350a:ab52 with SMTP id
 5b1f17b1804b1-439350aacbemr74618365e9.30.1739194010124; 
 Mon, 10 Feb 2025 05:26:50 -0800 (PST)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94d753sm180450075e9.11.2025.02.10.05.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 05:26:48 -0800 (PST)
Message-ID: <d2705cf9-af15-4783-a980-b484fbd25ff2@canonical.com>
Date: Mon, 10 Feb 2025 14:26:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] riscv: dts: starfive: don't use a default
 configuration
To: Simon Glass <sjg@chromium.org>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, H Bell
 <dmoo_dv@protonmail.com>, Andreas Schwab <schwab@suse.de>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de
References: <20250210111830.72055-1-heinrich.schuchardt@canonical.com>
 <20250210111830.72055-5-heinrich.schuchardt@canonical.com>
 <CAFLszThq9je_KBA3wxJdBKG8NO_8z+hki8_h5LMqKgOZDVhsEA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThq9je_KBA3wxJdBKG8NO_8z+hki8_h5LMqKgOZDVhsEA@mail.gmail.com>
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

On 10.02.25 14:08, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 10 Feb 2025 at 04:18, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Booting JH7110 systems with a VisionFive 2 device-tree used to kind of
>> work without causing harm to the hardware. But there is no guarantee
>> that this will hold true in future. So we should not rely on it.
>>
>> Before the current patch series booting failed on unsupported boards due
>> to the lack of a device-tree in the binman generated default configuration
>> when reaching main U-Boot.
>>
>> By setting the default configuration to non-matching value booting will
>> now fail on unsupported boards already in SPL. This allows SPL to
>> continue with the next boot source for a possible recovery.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          new patch
>> ---
>>   arch/riscv/dts/starfive-visionfive2-binman.dtsi | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> index 05787bdb92d..dd0faca6824 100644
>> --- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> +++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
>> @@ -13,6 +13,19 @@
>>   };
>>
>>   &binman {
>> +       itb {
>> +               fit {
>> +                       configurations {
>> +                               /*
>> +                                * Do not boot if there is no matching
>> +                                * configuration. We can't remove the default
>> +                                * here. So use a non-matching value.
>> +                                */
>> +                               default = "none";
> 
> The 'default' is optional [1] but the spec is silent on what happens
> when the default is missing. What do you think it should do? Perhaps
> we should add a property to define the behaviour?

If there is no match and default does not exist, we should not boot.

In our current code we don't boot if default points to a non-existing 
config. But having inconsistent FIT images might not be the best idea.

Maybe it would be better to use

#ifndef CONFIG_MULTI_DTB_FIT
	default = "conf-1";
#endif

in arch/riscv/dts/binman.dtsi to avoid having an invalid default value?

Best regards

Heinrich

> 
>> +                       };
>> +               };
>> +       };
>> +
>>          spl-img {
>>                  filename = "spl/u-boot-spl.bin.normal.out";
>>
>> --
>> 2.47.1
>>
> 
> Regards,
> SImon
> 
> [1] https://fitspec.osfw.foundation/#id4

