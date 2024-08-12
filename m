Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D7C531DA
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 00:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9088845A;
	Mon, 12 Aug 2024 02:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="xxCt9bQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22ABE884DB; Mon, 12 Aug 2024 02:46:39 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352A188247
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 02:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1723423596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awZJFtmTVnGhXjfmKc0lzGI21chaiYsKThxG0YD2SOY=;
 b=xxCt9bQDfP5DNMVLc6n7uyiRDKhuYxprqECLvgYjBAUqw5UD4Z4p0K+NN3zprm6HAhLDGr
 f0Vx4G7FtieqgRjGBMeLJIp4HtFQ9wZ15InbkESC6W6jaLQYW6tZtGkFDN5SwzqSxyLaR6
 VGP+gdCUMqk7Wj85fa36aS422xaGBUHtlHHTDatrmTwR1QXqLRI2b10LNUFtT6W/tL3E+i
 XpHECYR0IRQffWLS5FKeUnzlz09qGrCa0R7K7WdnvgpfuS4pMY+DftwyVCw1XJ5N9JyBx8
 vnKonHHvd/X81su8dk+hw+pYTwJaTJZwPufW14DhXkL2P3fMPobG2f5rx9R1kw==
Date: Mon, 12 Aug 2024 02:46:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: kever.yang@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] board: rockchip: Add support for rk3588 GenBook
In-Reply-To: <30bf7280.59c.19144046836.Coremail.andyshrk@163.com>
References: <20240811100255.1664095-1-andyshrk@163.com>
 <20240811100255.1664095-2-andyshrk@163.com>
 <04ce9048d54f6d68a46967485c6ccb0e@manjaro.org>
 <30bf7280.59c.19144046836.Coremail.andyshrk@163.com>
Message-ID: <b799c2bb7e30c7568aa3e482522efc6c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-08-12 02:37, Andy Yan wrote:
> At 2024-08-12 05:26:36, "Dragan Simic" <dsimic@manjaro.org> wrote:
>> Hello Andy,
>> 
>> Please see a few comments below.
>> 
>> On 2024-08-11 12:02, Andy Yan wrote:
>>> Add support for Cool Pi GenBook.
>>> 
>>> Specification:
>>> - Rockchip RK3588
>>> - LPDDR5X 8/32 GB
>>> - eMMC 64 GB
>>> - HDMI Type A out x 1
>>> - USB 3.0 Host x 1
>>> - USB-C 3.0 with DisplayPort AltMode
>>> - PCIE M.2 E Key for RTL8852BE Wireless connection
>>> - PCIE M.2 M Key for NVME connection
>>> - eDP panel with 1920x1080
>> 
>> It should be mentioned that it actually uses CM5 SoM.
> 
> Okay，will do in v2

Great, thanks.

[snip]

>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig
>>> b/arch/arm/mach-rockchip/rk3588/Kconfig
>>> index e751d64e1a1..dc53d559ed9 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>> @@ -6,6 +6,12 @@ config TARGET_EVB_RK3588
>>>  	help
>>>  	  RK3588 EVB is a evaluation board for Rockchp RK3588.
>>> 
>>> +config TARGET_GENBOOK_RK3588
>> 
>> It should be better to use "TARGET_GENBOOK_CM5_RK3588" instead,
>> to leave room for support for any possible future SoMs that might
>> be made available for the GenBook at some point.
> 
> Considering the name of dts is rk3588-coolpi-cm5-genbook.dts , should
> we  use TARGET_CM5_GENBOOK_RK3588  instead of
> TARGET_GENBOOK_CM5_RK3588 here ?

That's a good question, and I already asked myself the same, before
sending over my comments.  It's all about the way U-Boot names the
things internally, i.e. we've got it like "<carrier_board>-<SoM>-<SoC>"
this time, meaning that the "dependency graph" seemingly gets usually
represented that way in U-Boot.
