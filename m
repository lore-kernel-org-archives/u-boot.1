Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AC6C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 04:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC58E8800C;
	Mon, 22 Jul 2024 06:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721621452;
	bh=N6jahHnNLNv99K8u4nyIMvxRU0hiKdDzcrl1lcaW0D8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dzEhJF7Bm7+1hemTLIFb9S1dP3Mzqgn6CMrKV7fB00/WF06Je1O+eABDsck4WnYSF
	 E1A8f0Omx8h2r16e5vwmhhLEBogDLoB69uC3xvZ2Y06bFjdCfNSAyCdNqPFezEUdnV
	 XRBElppQ81ss6KbUl9n25VCfjiajhTKs3ZO9XWmWXFkoXTqzG42XM/vi/frMa/6gq2
	 l8LN5RFvQgMtZX0O3mj41sWgq5r17ioAL4o3jSkTq9K9sz3EJdj2G3ECI0cC8tCDCt
	 jGMIOxNIMgZtCcTQGXcgsTPugNsQqmvenwufumznj2DT1ih3HbdJDedjibRlxAVc/e
	 bZP9J1AUQuXTQ==
Received: from [192.168.1.107] (87-97-112-163.pool.digikabel.hu
 [87.97.112.163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EA49C87FCD;
 Mon, 22 Jul 2024 06:10:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721621452;
 bh=N6jahHnNLNv99K8u4nyIMvxRU0hiKdDzcrl1lcaW0D8=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=stnDUvhVz583gE4yQjCsq+LIxWIzmUNprd9oZXPoAzoswgtbnBj4bIH0GL/MmlsYx
 da0lU1cJr15hKoIz3uFUU+GH3f2OF2xSwLKZBJ3xwz33T1jR9cZWUukv9we9AwouFy
 3sVXHbOECiiX2wdL6/tE0W8Twdq+Oy1EokFE8Mv8NgP6cFEZZJBZl9mICifgV79ap+
 /G9E2WOOfVqjz75O4rj3n4341M+sVxPUjq1EjIK1IBax4nkIewTzxabd1dkzjB6irR
 s+YAB7YlEOAx9gqt0xM0Usz8TA/68l7AnIZ3XPjevJxRxA529dpEEH4Kd6ui80Mkap
 kw2s7+7ushVYg==
Message-ID: <44ce0337-0bf5-b773-89bc-79a54488c04e@denx.de>
Date: Mon, 22 Jul 2024 06:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 11/20] keymile: Remove use of legacy I2C
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Holger Brunck <holger.brunck@hitachienergy.com>
References: <20240718173611.4014274-1-sjg@chromium.org>
 <20240718173611.4014274-12-sjg@chromium.org> <20240720013611.5d7408ab@crub>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240720013611.5d7408ab@crub>
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

Hello Simon,

On 20.07.24 01:36, Anatolij Gustschin wrote:
> Hi Simon,
> 
> On Thu, 18 Jul 2024 18:36:02 +0100
> Simon Glass sjg@chromium.org wrote:
> 
>> Drop this old code to permit removal of legacy I2C code.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   board/keymile/Kconfig         |  3 --
>>   board/keymile/common/common.c | 69 -----------------------------------
>>   2 files changed, 72 deletions(-)
> 
> Please do not remove this i2c deblocking code. I've updated the
> DM_I2C conversion patch, it preserves this deblocking code, but
> legacy I2C code is removed:
> 
>   https://patchwork.ozlabs.org/project/uboot/patch/20240719232422.3403700-1-agust@denx.de/

Can you add this patch to your patchseries and resend a v2?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
