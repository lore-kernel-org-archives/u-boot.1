Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C4DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3DE88727;
	Thu, 25 Apr 2024 06:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714019307;
	bh=qqJWBkuYoK9oWobNwD8M2QLCDZZUyHTjuD+AGrPhm9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qaLAydYfODcHujSxa9998eBN/uRPw4ZhrjoHEzYmgqVVCyA/Ad7wTMe6NgfnKQFUK
	 Sp7Q706GO4IwWI1B1SzVckCseT2WvEGi00SCggCAepgVjTK2UzwQUzEvaxuSUgl2K4
	 0/M+asoOoGJ4sB0flaaashZyi8P/Jw7r9fgfFJrFj2rNTQdmmTGpZ2S39H7S2NyqRY
	 ViHnAC+xJJ26a+02v7jgNwGtKxuD93Hq/7ugxEh5iEy+jA50rrLa1hwj+8X7SGnxMB
	 5x0Ki2lf9oKaLZW21yST7PbxRBHSX10TAhcXOYoDR7xzWKbjd7031Ngxk44uuC0Wbw
	 zUCPsoQVriCRg==
Received: from [192.168.1.107] (82-131-156-115.pool.digikabel.hu
 [82.131.156.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 07C008870C;
 Thu, 25 Apr 2024 06:28:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714019305;
 bh=qqJWBkuYoK9oWobNwD8M2QLCDZZUyHTjuD+AGrPhm9Q=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Cl4GqZUS8BuFgLv0zmVfA2hmnoh2Lc46c9GdrvdKZaNe9X5eHAIzldClCtQlkwE/n
 mfihrFBt/I5iKQmbuMt+XuZYyXM8C4vDftcRUnJHWc5RrKJUTW70bpNUv88JNww4sj
 V2J6iiR8VRT8Y+uNF795z8BUNPdkJCZhCwiYlpWeNNFRJBcIgiDm5aA1JTGl2r+BiE
 iAgDEz1Gda3TuQJO0bgdnbZdf+cfSlbYS+LJ6Kuf0kUcQxyE6Mn3pTwY55wr4+5gl5
 1IK2fQ0BIdK5RwK9owGrlv+eOLIY/PgbEMJiGUgSQ4LJaYurvSbNzacEMDlSl2BSKp
 JSYlesTSBwEGQ==
Message-ID: <ea2ae539-abc4-30a6-5ffe-911f46f22f70@denx.de>
Date: Thu, 25 Apr 2024 06:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/2] i2c: Add support for Qualcomm Generic Interface
 (GENI) I2C controller
Content-Language: en-US
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240422-topic-sm8x50-i2c-v2-0-f9ad61c33b07@linaro.org>
 <171387260254.2280908.3755821257633373339.b4-ty@linaro.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <171387260254.2280908.3755821257633373339.b4-ty@linaro.org>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Caleb,

On 23.04.24 13:43, Caleb Connolly wrote:
> 
> On Mon, 22 Apr 2024 11:33:51 +0200, Neil Armstrong wrote:
>> Add Support for the Qualcomm Generic Interface (GENI) I2C interface
>> found on newer Qualcomm SoCs.
>>
>> The Generic Interface (GENI) is a firmware based Qualcomm Universal
>> Peripherals (QUP) Serial Engine (SE) Wrapper which can support multiple
>> bus protocols depending on the firmware type loaded at early boot time
>> based on system configuration.
>>
>> [...]
> 
> Applied, thanks!

Hmm.. where do you have them applied?

At least you should wait for an Acked-by from me! Especially in xz exploit
times, we really should give custodians some time...

v2 was posted 22.04.2024 11:33 and you applied it one day after!
(And yes, I was on holiday...)

But okay, v2 patchseries looks good to me...

> 
> [1/2] i2c: Add support for Qualcomm Generic Interface (GENI) I2C controller
>        commit: 75db9ede12d06693a3ced8c901b74065a1922a23
> [2/2] configs: qcom_defconfig: enable GENI I2C Driver
>        commit: ad12acd7a8f5aeea5816d5c2fc37c205c403eee0
> 
> Best regards,
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
