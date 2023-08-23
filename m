Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493BEC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC0CB864E8;
	Wed, 23 Aug 2023 22:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692823575;
	bh=65wo1slCoDcGQAKKl9ix+J4idDG3ZDaETD47nZ1vTxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zAf4w1aHk5TG7Ij6Eyp/ZyCXsYbjzhI1biAQQFIIFjKX8aoHr7jXMdKlgQWrLqLIG
	 QoYXDA3PfRkjW584AGUvKdNMvaTY2Q+Avfo2qY6pM6iTAiKk1zy6tiV9cHqjb4eyUM
	 CzIfCErzq8aauwixY3zM2mRG3c/KlTNrAo2fQOK4VVa3bfvu/VUHPwt2M1LLO6xtXf
	 ivJuwzsF79XYC7/2FpieAkp8MprGK8PzRfZRrml4Wto1kLnGRElIzkS2nQ04uV+hQ/
	 4WGjpliwFTq4ohdSsRrDrvWaQ+e1AMvsEp0vZUxTUb+JeD7bJ7xilTJiWqT90XF+mo
	 9HptZezi4LG9A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E3E4586432;
 Wed, 23 Aug 2023 22:46:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692823574;
 bh=65wo1slCoDcGQAKKl9ix+J4idDG3ZDaETD47nZ1vTxQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sZKSFLsWhZJ4g5QOtmQeg3ep674D2SkujJioV/chuv/NSkA73y0tHbQS1l+5aJYqY
 OQNjPHBpyQaXtWkGFDvT+RtIUh8tPuL4T4gs6ifqyc8kZIBo3K6nNP5JvyKhDSrgdS
 TOEEog+0xsnUA/FyMotWP5Ci+t7u6t2yOFLdMOOHAOMBgfmJcedFDSzSTKmUgtbzYx
 eNwqRbmbD8H1wvrgpna08vk7zYODBw42UwwGKR10rWBwgsiLiX8EPyKbm+CfCsaDvL
 ccyuRHYszhUq+xvy1v9+2hAm8uWBLcaXLTXaAQ/JXnkAHxh7HTjchKkvFPjrGtPJZd
 I5YH3jf5r874g==
Message-ID: <bbdab138-2499-ad95-d4a8-dfada7e72651@denx.de>
Date: Wed, 23 Aug 2023 22:46:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
 <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
 <20230823203526.domqjv74ttdwfo73@pali>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230823203526.domqjv74ttdwfo73@pali>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/23/23 22:35, Pali Rohár wrote:
> On Wednesday 23 August 2023 22:32:18 Heinrich Schuchardt wrote:
>> Looking at the MAINTAINER file it seems that POWERPC should be set to
>> orphaned.
> 
> And this is only just because of your fault folks here, as you have been
> completely ignoring any my patches for improving this situation here and
> finally after more than year of my reminders more of you wrote me
> officially that would ignore any changes from me.
> So go and complain to somebody else, not me.

Why not pick up the PPC maintainership yourself ? You are qualified 
enough I think.

There is a whole thread on frustration about getting patches reviewed 
and upstream here too:

https://lore.kernel.org/all/20230816180808.GB2919664@perftesting/
