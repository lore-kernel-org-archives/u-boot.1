Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38536CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 10:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF6F60611;
	Sun, 11 Oct 2026 10:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZsbLK-MVhnk; Sun, 11 Oct 2026 10:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 300C460612
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791716134;
	b=UhE5xgIXQZedylTUrbD3uuA9lY+CmApbQYojPfEGhEYbQPvd+5JCYY5mKDf2vOJUzmG+
	 5VmQr8Ctdemgesbzqxv6OdvS0S69nCgDltEhip+6iLHfQW+WftVhHXbC2iu1Hwv+dWGbb
	 acnyeA6rcQPZ9zbJJDjvNhNFwMqI5S9Bem2Jfe452KVsFlkOXFTCUzqLTDU8XD2fcXwhW
	 pbSfF+YHZVdJlBSS3EzBY0KxPXd//xP2V8FImBjBVR7lTvAhUe0wm7iWLd63ct8IFUkPB
	 yao65RjUFvYD8yT4j7uS0thChqET7Y4iznF5tBQvwxawAN3tcoL83Abo1Fez5sdWVYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791716134;
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
	bh=Vei8Tk6LoT7uTSQD7aSRqjhFLmhNv6OOB2mVaWExTMA=;
	b=HJVIuh6ukN3r3BywzIE/4A5UyxJhIadcMXgKkRC4lHnjzB+RAAVAjaWnzjmYcdjRxPPE
	 HuQ+RRkudnAr4qBHOQxDGee20gynTOmAV803cjCBmWrNEB43iY2RHfQsnIykXfG77vczM
	 RkOMd8ubjfHWRxCdybPQe6PjpNzj6eXTb5viQleJw8VUevlJ7knK97aJ6oVw/KYvZjBfV
	 hOOkjoOqsGBwmwcmFLTc+2RMXFph2D5wMaKAJec6qIBo0lpO32UMsm34p+8jQRdYtt5Va
	 AFflV4Mjnx4Jy9NfONp1rOISUrfEV7P92DCwxOhxSFxF35zYBO6i6qLWabsX8mf9qhw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791716134;
	bh=Vei8Tk6LoT7uTSQD7aSRqjhFLmhNv6OOB2mVaWExTMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EqAAXLcK/sBszJIw51crMx9/3ws13UbHDAerDWsvmVpFnmXKphtRtUFAO4ctGrwpn
	 xubhVJB3AcHbQ4pFB2+8unCgrMlIkmEVDbrIdwsvoRIjdroYASMVDjJonXJ6vSU5Wb
	 pm/jVRI+hd3twLnbE3FSbkaF4KWlR2aAEBwS7ZWMfLOt83zE0bZZsz9CaZ99Y1jELK
	 XGJS7464wq4Sp9xWwRiGG9uOl1HU8q8pEe+pOjzJIkqFugr5Bs5T4kAsQGfcCciF/9
	 vtx75035bnonAPctssJxX/zDv2k7I/NSyfSLbDCLa734T4ZlSiOAcEglkyouzi3s1m
	 tgih6yh7kMeVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 300C460612;
	Sun, 11 Oct 2026 10:55:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4754C317
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44F534068E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZwE1ljG3O4k for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 10:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A43474068A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791716131;
 b=WBnreBrmBthK7XUKah34pJyjPKBvJr/VZacug01Zfxwt1uWw1XHczFFFH5nJJvZGnm0U
 RVuTQHALT4jsVsufFYviySrt4K+JXSAkHsn6s9LhPAui58S4j2wexHwAtK2cgQC2wK26v
 tIp8HwSRTodeGVALsh7n1wCq5fNG3xYkZ9tZGne8p67mCmF4XWYgjn4ZCt0qiHXKdV66N
 WSBa0DFfNabFfW915J5avZMZgreOlZ+h0HKGFJ0enUviz/bELenu0Ih0YHC2ZOxf95LG+
 mXQiboH8h8w7yMnwIbKrAB/1hgH6QDL2AxDo1RGEF9jJxE+A8WQku8t4mVcW4h9Ubow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791716131;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=Vei8Tk6LoT7uTSQD7aSRqjhFLmhNv6OOB2mVaWExTMA=;
 b=HQjxF1aqmbPjyz06vLZ+9f1Jrk7qlQFZu+AdyxbLWRreYm7JOeMmqiq6Xb7tuC7T11j9
 HVwZqQrk6W0KtebHraOBigRffai2JTJQA3poffJjMAkNIzIyG2yGuSDKiZ5zWZdGGaZTM
 dwvKOUGQH/x/56d+w2pfwNTAWhYuvNn79nUPwU8Bkfp21jD7mkJHJBAc1g0v2JZTgv5yC
 5tz2SuNb3FWu4A2BgehdEK2Tzb2xFMpwW/WxGR6pos/Z+HSzZ1IoKrWVB90ILKlIII8Ed
 uunq+ZpQmSssVCRX4l+OkCL138KaXyTuZaXX+hTVy4XB5gERMeprnFoH1jSW+HkUO6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=kpDvg5cw; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=7247=ib=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=kpDvg5cw
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A43474068A
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791716130;
 bh=Vei8Tk6LoT7uTSQD7aSRqjhFLmhNv6OOB2mVaWExTMA=;
 b=kpDvg5cwwzlidUrqjDBekDqAenF5SM2cBuAdk3yj7eXoiIJmuhoWfPBI8X/8EsCAvlIlTWMCK
 m9ptm1FslYa6C21hqNQo8FozQE0sD7jMLHdVr8l1liB2wfBUuyMzc0F/dz0x2IMooWUni+6NuDw
 qlw7fd8pkhUuBryGl9hmOhRjLjnysBeoCrIXyf6968Amot/qNetn0TKaQCqh8vOeZ+bCgSRrTDm
 +57xsCNilbcqtWBjcQ0IZmR5J1kT1C3SCZQY7eRNgAXNiQRiQYSiwJrk07mJ3Z9tIxHtr46TBoG
 qXY9twfEs6d/k5LPMMx9d7YssABPSPK2sm0aRyvh4SWQ==
X-Forward-Email-ID: 6acb6b1f06adeb7a8a894d2d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <27039afb-0ef4-4cb0-b752-d5083d3cfd14@kwiboo.se>
Date: Sun, 11 Oct 2026 12:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] rockchip: rk3588: Remove unused rockchip_get_clk()
 helper
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-8-jonas@kwiboo.se>
 <af324bde-f2a8-4425-8d57-944ae5567c84@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <af324bde-f2a8-4425-8d57-944ae5567c84@0leil.net>
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

On 10/9/2026 11:55 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>> The rockchip_get_clk() helper is typically used by SDRAM init code of
>> older SoC generations or to help get the CRU base address from the clock
>> driver private data.
>>
>> RK3588 has no uses for the rockchip_get_clk() helper, let's drop it.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> index 9b112e45f1de..272d28e973b3 100644
>> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>> @@ -3,15 +3,9 @@
>>    * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
>>    */
>>   
>> -#include <dm.h>
>> +#include <linux/kernel.h>
> 
> Why do we need this included now?

It seems to be needed due to use of check_member() in the CRU header.
Will make a note of it in the commit message for v2.

Regards,
Jonas

> 
> Otherwise looks good to me.
> 
> Cheers,
> Quentin

