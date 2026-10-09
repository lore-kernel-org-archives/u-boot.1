Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4B5CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:18:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C21940824;
	Fri,  9 Oct 2026 13:18:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id puX4CdqrS3U3; Fri,  9 Oct 2026 13:18:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C543640835
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791551892;
	b=RxeLaet/7KqFg46PIdL8hMO2da9zthPAJ1ZLlzRpMN+RVFdnNRdsLs0EKfoE1DXiz8vy
	 2Yi9k9sMuIadl5zDkAhYuigqWljke7a7GaHitL8F7zAyGP10JSilRjsJXKpX4d4eGe52f
	 UzX4hrACyhQP3lpjQAcCJlEmrQNxbh4FAUHkAUP9x1z0II9tQtZu7ke86J65vZFhxFkeA
	 OLcZNx/zV6dxmoDDgEm6c1j5vEJXANWNtXI5dmemuQM45eII9T1Mkf0mMS8WyGLB0eeOV
	 QJij2QZK58tfCm8PODcQT7uk9dHluX40baj5IitV/O8E7PoLqQ8m8ZoVMHviTb+kWXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791551892;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nRIwe3BmaUxBqANirrI9vBdK96UcREjzl5xLNgXyWWA=;
	b=I007fvR5x26nlDwR5yLpNuWKoXMI9f63Sb0qHYmlGcFO1iT1htUl29X8ApkzSRVNcc3J
	 rf4UsEF5pbKjb4ildEyQxwy2gDAEddKlbzSOFaoF0plptjOCZDloazvF6kXh+Q1up7Caj
	 YZiC7H/nxf4wVBU38NP8FEI3RxkoDRpT31fGdvHin1puPSAsyDOw+SvDzTfPTQxzIJ8LL
	 DwjY3osXBPL4SylKo0D+RcxfjI2orWnWC9YOwcg02J70SFbJt66FDBig3NnAOmkv5guS6
	 K5YAxFebFDLiq3H0yFn4Xyfp3k8SdROpyrAvtYiQLAmsBVVKHjis55i/f2LtUxPuS5A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=vLaSiKq9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791551892;
	bh=nRIwe3BmaUxBqANirrI9vBdK96UcREjzl5xLNgXyWWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xn/XEz70BAlDOANZElNkQHUesBZrnBqIgbWYLjlonvI+RKUyzp26v4xSSsy0zUUVG
	 pHn6nhn8o+xmZRfe2CtQVYlve/qUDwMpMK4z9cPwpuV8nEy0hKf0KnJpf3MCaSxSgm
	 wY7YuJanC1o4ynvyD68QWUh9recd8rl08urgtcfbZrs+WMHVTs2ZFhHhzNH/I42Mda
	 vP7OY3lGI9eCgrc20YOMF73cW2dFv2ySIksi5b8cfH2lFQUO8c+Hz9/yHZi4f8QT2y
	 lK6BR8gUAgUL+B/1Et0XjwmQL5XEPufm8OLWn2KXx3hpBZUJjjEVOd7vDB/QNFmf/P
	 /Hng7xZDb+AkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C543640835;
	Fri,  9 Oct 2026 13:18:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C24175
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1970E40835
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:18:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JsspWM73Ay3h for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 13:18:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B291B40824
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=121.127.44.66
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791551890;
 b=D1b9H6/v1aIGr0fSQjmxsZFz0Q7Rg5ESs+l2Q+Z4BxcGlAbmF/3C35EqAnJFnPZX8lrz
 3yGJz1pUB10AV4tnyfxI0ccUE7ZeGEqecrp1FbwzyKvRkJ1tQy6bye6OhR80nzKy9+XDp
 YdntWneoPLw6fqvjX5V84YNfYc43QFDkJcQfdw9jSaEi+b0Mu31i0xIE1LNZ4kdP01Emn
 QNl1A1BZX6v5K9j8CtUbPnSpGOwNLjyxDXwDgHVAR80O3bAOrBQNG4MawuWB23bkqw9DJ
 gqVtaj+p9QZPxR2C6pjPQFSPCZn4HcgcjkCygvpIxwhVSwnC30qGsQ+EpuPUcTjNUsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791551890;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=nRIwe3BmaUxBqANirrI9vBdK96UcREjzl5xLNgXyWWA=;
 b=X4/5JubFZmzGgC+b9H+sQV50cadjns8DSra6ozco8Vd5/P1cBiz7SxQKcTSErLWwnh6e
 WUsvBgxwVxw0xRxWX84y6kqKCai4G51zHOoHBfi13ehSyKU0+I1gjsmpZL+DsRwx208p/
 yElcqp7tL229WeP0ziv7CTk5V10TxCElA10pj3j6PKyLnms3h+tsFksIUaaAdHJJZ3gg3
 7iJivvxR01GSTHhA24dPUJFw7z3ppT0TtJrplirk844MWMUU/jyEflIbfa+/Tj4NAFvfw
 ZNxNgIq1WsddGUDqOGctZF9CDD+FIdCnJ8RA+k15rhTALKVSFu9EvdRoLlu/5DXlsMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=vLaSiKq9; 
 arc=none smtp.remote-ip=121.127.44.66
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.66;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=vLaSiKq9
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B291B40824
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791551888;
 bh=nRIwe3BmaUxBqANirrI9vBdK96UcREjzl5xLNgXyWWA=;
 b=vLaSiKq93v1xvE9jBAftSmHwwG7g++JSY8U5FvCsFo6ou3M5289EDkWFplQwW3Zgz+nCH1Xrg
 eUVNzSOhgMJSFQpvYRgSX3gb/yhkfKEwKd3LbOVXAzV+zsrwN/hsx9iKWthuW8xAvXOxa3a5Baa
 xKdHYaYhDfSSdPJEa3KDGyMI8Htukx867f/VkuvJc1FzwKLD5OioRr5SJ1/UwL5qm917yZ0v83X
 elz41SnI9uxwxa5FBL5gJh7QFRySYOU4ahvUaxdAuD8m0cej8GDCC1kg2mCYEdAoOyLKf2YnmJm
 fCBrULCvlSQMiT3aYqUf6uO2Bp7t8eP+5EO+VFNkFLBQ==
X-Forward-Email-ID: 6ac8e98cec5a50a7d2b6ba08
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d29a51e1-1ae0-4b42-9f7f-80d06549be6d@kwiboo.se>
Date: Fri, 9 Oct 2026 15:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] rockchip: rk3568: Remove unneeded syscon driver
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-5-jonas@kwiboo.se>
 <78e51676-d35a-4e49-9d74-657716f59efb@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <78e51676-d35a-4e49-9d74-657716f59efb@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 10/8/2026 11:59 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 12:57 PM, Jonas Karlman wrote:
>> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
>> to get a regmap or use a constant to get the fixed base address.
>>
>> Remove the unneeded RK3568 syscon driver to discourage new uses of
> 
> Isn't drivers/clk/rockchip/clk_rk3568.c using it? c.f.
> syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> Maybe one local test you could do is delete ROCKCHIP_SYSCON_GRF and 
> ROCKCHIP_SYSCON_PMUGRF temporarily from 
> arch/arm/include/asm/arch-rockchip/clock.h and rebuild. If it builds, at 
> least the obvious ones are tackled.
> 
> Same remark for the patch for rk3588 and its clock driver.

These are removed at end of the "rockchip: Miscellaneous RK35xx clock
fixes" series [1], v2 is incoming [2].

Looks like I missed to mention this dependency in cover letter. 

[1] https://lore.kernel.org/all/20260730141308.1218014-15-jonas@kwiboo.se/
[2] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/ci-clk

Regards,
Jonas

> 
> Otherwise this looks good to me, thanks for the cleanup, much appreciated.
> 
> Cheers,
> Quentin

