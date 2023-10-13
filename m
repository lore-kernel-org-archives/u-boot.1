Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF017CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 12:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD34386E77;
	Fri, 13 Oct 2023 14:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697199060;
	bh=4aU4zmBVbgRWZr2719Ba6wGnWonduyM6RvunrOqtfZs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=EciOYzudFtdJ6z2WAG41Pn3pcuX2E0xC2UcuOsAG0yF+Ywk7jZuS3cG6DYFXocsAe
	 TB8xn6hxjitA2XIKaTpKXDgKgJ85eLjP/q6I6y1TTnyXS2GONM6efe/HXOrgit3Pb/
	 d1raHQXyfwczh5YHASq7peStXy1kBgpl3caMaZW11PJ2MqY1DqplSbMeN+E3GxhvsI
	 z2+IRoV5zu+xq3nSUzHkuwfbGPVBaj4wKMfNB8oYokA+UEyabbBzDOP5dXX+gMbCmN
	 u2hr0G1YFt4czo5JGMhb+wZnMWuIw2mLzN/pOPH//VY/n2qSVZmyKkANrdGx4gHcn/
	 5OifZQMfLjf/Q==
Received: from [192.168.1.107] (91-82-26-209.pool.digikabel.hu [91.82.26.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0AEDF86E02;
 Fri, 13 Oct 2023 14:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697199059;
 bh=4aU4zmBVbgRWZr2719Ba6wGnWonduyM6RvunrOqtfZs=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=as0ffsE9lifhSs9S9ZjIIGrqh4NxVgvibdwo1zGAqvkS0kF/uaOdjmoN9rXRnuWmu
 keRnd7d+Yy8k4XyKFPWOFqWsuUaYCCQHwJiwIgeEFTOFzZ0qa7L6VZBBoMv3kDcCA3
 2xpBbgExbPD/BOf+O8OMrxZRXnCbiHRRTIkNlwW+fTRgka6Q6OwrJAS2pQwtI7JIPT
 GZADx2AXOaHxuopeiDyAhNs4Gzh7o2AVsQJTYs18LppsUPZNBWey/4tYxb230R4J1q
 RvVObNOFrICTJ5dYdQd0el10XGX1dTc8luOGxhNXTfgDUkiLVdZ/1fZi1KaPXJSaSL
 VkM3y85ebLMdg==
Subject: Re: [PATCH 1/2] bootcount: Remove legacy I2C driver
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-2-pro@denx.de>
 <bf6e57d4-2dd7-5515-6ba0-c7e49447a579@denx.de>
 <ZSkrZIwVLeLe3S8Q@eryximachos.home>
From: Heiko Schocher <hs@denx.de>
Message-ID: <4ce22ef3-f213-879f-ba40-291dbdbc4e55@denx.de>
Date: Fri, 13 Oct 2023 14:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ZSkrZIwVLeLe3S8Q@eryximachos.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Phillip,

On 13.10.23 13:35, Philip Oberfichtner wrote:
> Hi Heiko,
> 
> Thank you for reviewing.
> 
> On Fri, Oct 13, 2023 at 01:21:41PM +0200, Heiko Schocher wrote:
>> [...]
>>
>> Hmm.. I find some boards in mainline which still use this driver:
>>
>> u-boot  [master] $ grep -lr BOOTCOUNT_I2C .
>> ./configs/sandbox_defconfig
>> ./configs/mx53ppd_defconfig
>> ./configs/ge_bx50v3_defconfig
>> [...]
>>
>> So your remove patch will break them ... okay sandbox should be
>> easy to convert to your DM approach patch from this series.
>>
> 
> 
> $ git grep -r BOOTCOUNT_I2C
> configs/ge_bx50v3_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
> configs/mx53ppd_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
> configs/sandbox_defconfig:CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
> 
> Those boards use CONFIG_DM_BOOTCOUNT_I2C_EEPROM, which is not touched by
> this removal, is it?

Heh, yes, sorry!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
