Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC02FD0E6C8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 08:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73D57892D9;
	Mon, 21 Oct 2024 10:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729498935;
	bh=WFIOKmb5twmsecGvk2F3b/fgrb6VaaA0v/A++8zMkUs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xRBy3Cf2GK7gMcO9HIMWz96mZ050DxZW6iOKodX3umLbJB9ZtN31eOy+7xP2a8Nof
	 rAzlG72xDisgjHZuEUkF9mZ/byVQEkugUViHFjAMToDNrMCWtWJ9CoYEA0g7XbiUlG
	 gqb2sy/B1OPaWm15L7a2b/WJtAFNrpfnAzZOQNmMX2CGA1fl8suHIg/Y/3X/mTf0pW
	 0FQrSJWnIz4rWvX8WQDhjR8njNmetLxvgZta7uJmYacLoYAIjwPVC7evM0AjdKOhhj
	 1Qdr0r7YfBLKu6odGtKkXP94lCAGYxwfTI7ptsvJ49Xw5BrAhLlhQUgIIEeBqtg8KI
	 1NO3f0F68nixw==
Received: from [192.168.1.107] (82-131-200-27.pool.digikabel.hu
 [82.131.200.27])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2B2CC88365;
 Mon, 21 Oct 2024 10:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729498934;
 bh=WFIOKmb5twmsecGvk2F3b/fgrb6VaaA0v/A++8zMkUs=;
 h=Date:Subject:From:To:Cc:Reply-To:References:In-Reply-To:From;
 b=sEMSLMal8/Z//NyuhAAbfUnEgki68UZikNZ3wkXt6/AhxZ0takH11fDMVBDoArMa2
 cm4iRxwc9A5dnUsFInRt2/n2CdGmOrJfAJj7J5Tw+8wwM/MLv+obKzCSSHrAbBQNIF
 QLsWh4ETe9bzuGED7pGABYw3jOpRi/oLZYZmQHb4SmI6oOSes2dv2rQKkqWP06GqnL
 CwNbCFlfjlM4/gcb7pvAFts0tnHwYD0qyMTVJBgpFvmJ9JK0i3ZxJuzxAEjcbfjTA7
 ovnhxVe1mjV9z6g14hA5m8uJKXEKQVnfJczREc11V8XqF9EZ12reO7HBvZtgXv8Aos
 HezXvuKcHunag==
Message-ID: <31687fe9-d494-b8d3-7ccc-c06e79218e49@denx.de>
Date: Mon, 21 Oct 2024 10:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] i2c: muxes: pca954x: Add MAX735x/MAX736x support
Content-Language: en-US
From: Heiko Schocher <hs@denx.de>
To: bigunclemax@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 u-boot@lists.denx.de
References: <20240919160658.197534-1-bigunclemax@gmail.com>
 <e0dfb68b-a168-01ed-e2ae-24f1ffc98430@denx.de>
In-Reply-To: <e0dfb68b-a168-01ed-e2ae-24f1ffc98430@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Maksim,

On 21.10.24 06:11, Heiko Schocher wrote:
> Hello Maksim,
> 
> On 19.09.24 18:06, bigunclemax@gmail.com wrote:
>> From: Maksim Kiselev <bigunclemax@gmail.com>
>>
>> Add support for the following Maxim chips using the existing PCA954x
>> driver:
>> - MAX7356
>> - MAX7357
>> - MAX7358
>> - MAX7367
>> - MAX7368
>> - MAX7369
>>
>> All added Maxim chips behave like the PCA954x, where a single SMBUS byte
>> write selects up to 8 channels to be bridged to the primary bus.
>>
>> Tested using the MAX7358.
>>
>> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
>> ---
>> Hi, friends!
>>
>> I have a custom board with MAX7358 GPIO expander.
>> This patch is the port of Linux commit:
>>   > 81694437b6eb i2c: muxes: pca954x: Add MAX735x/MAX736x support
>>
>> Best wishes, Maksim.
>>
>>   drivers/i2c/muxes/Kconfig   |  5 +++++
>>   drivers/i2c/muxes/pca954x.c | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)

Applied to u-boot-i2c.git

Thanks

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
