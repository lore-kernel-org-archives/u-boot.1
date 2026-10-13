Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB25CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B324403A7;
	Tue, 13 Oct 2026 11:43:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebXk-R2xz_h7; Tue, 13 Oct 2026 11:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B053E403CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791891820;
	b=PRgOthzTDjfiUt+2RU4Z4VuNN5aKBriV66T24nfzSthggtGHGC+WfeOSwNnKVvd44zf0
	 qtgwVuHJlksWpVsWkTbOEt9M92aCAgMFACV8iDAq2r6osa7/KXuErXm2RynHDjndYFvSv
	 XMgnQ+lN4Z+9G+7eLz42MQFOxI/7kdQLhIpaA7EuF5nW50XrYGCQyX5dMRkWYUwQBeW8H
	 3qsb1PUxto7478N8rDfmA9wSjbKdCUDbDD+okcmdQE0zs+PqrJoOStYuOzPl6DDwiUFfC
	 OyMG+6LIyXE0z2hrnvmc3vNnMliUmU80M3NIOlyiQEV3KOW/OKf291BfVI/5oIpbGdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791891820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6hmGmq/roylCZdoLSHaIeEqkVCrUb+xQZdPPBeuQgbU=;
	b=J31hxQPdb9tifia4a9xvfYLjdE9I5FEnP57O0ZziI4+Ng6A3Hr8bews4MZjOvZJoeQTh
	 HMHcrabpWmVGFM2DuDtXwyxzIXK8fCTnfP81O4vTafM0ar4l/FSzYhdUHSLYIh0a4AZLZ
	 s2HWiOOkWGICBAaykbMVIZ8T17yswBWPhq7hir2gswukre6/rA7p/f6YGYWndOSAD9eif
	 /kuDo4Z7wXbE6/VKiV8onI93karO8VDbSdWSDSyLWn99CpdPOq78aF0YhAVxAVxscDvuO
	 Pv46rXmm4TR55WmkMd4OitDwR3aFtrtFeaVR5MVMBlKi0mIiyfKsEVQUsuJhO1zh88g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791891820;
	bh=6hmGmq/roylCZdoLSHaIeEqkVCrUb+xQZdPPBeuQgbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W8BoxgpvdVIdqWkF8Dd2wKadCh+1v8wR2rhTjt13Sdtm7t7uiqpaMzrHDhQWk3bX2
	 sY39jX8oRFzkaDQld18axLzWL5DONZ9Y0nr4vBfcJQNEe7D7HRRdv7bB/YSdtBoBC5
	 5W6e0t4EdzuMG92On8Dh1fYfph94S0650fcvQqP3ULiLL8QjgoOWQigl5jzyOdlBTO
	 uTFy60MwS7uuLUoxlWOUCEKmE5ixC01T/xHstHXeR27EWt+31lHfadZgqTKoAIEW15
	 H4tzK5gutYSVVjGibflCuQb4G0jrvuH3O1UNn6NPzQleeCiaDEGDKzocs7cZaBmQOM
	 36+oSeQCsYj2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B053E403CE;
	Tue, 13 Oct 2026 11:43:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4DFDE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8DEDF809F6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OMaTql4hFnh for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:43:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D546809E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=84.16.66.174
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791891817;
 b=thD4lC8m7ImjytflzsOC8GPEsyvsA4PLBM2duNheR7MqNRuD5BPTJwJcb8X+tMgYyOv+
 u6Eamefw1mp+/MtTMYQYuZGBnrUAIh9NyhCzuOJ2G4RyrhWeDKAwWLba9O/n3rAywDep+
 d81brnLBDIWAuo/4BCICelYIc+0vM8/OU75RLOKoSGOrByfa7899SZ66WvOALg9P2uM2h
 U2XicSO55wumG9ggzvse5to8CF8+9RpakQ3n8ywnlAnVSfUVDwFEWOw6CyJAI3RHZd+Ac
 5msKZkACI75ytOBeQvEb7PZDgzMyZZR7wkuGWjLed8c4gp/djm6+/O5uDgaIS4fYPoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791891817;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=6hmGmq/roylCZdoLSHaIeEqkVCrUb+xQZdPPBeuQgbU=;
 b=C7cv1xxI2baMiAz4sVI3KQ/iawJI08AExLSIj8XCC9jY2gH7FyzcRk5Jyg8nXkd1oj+i
 xsVahHHTzKJUCjhxAS/yS+RoFw40RfYxsOk7lAw5nwmIIOuUitUBOvN00UpcCoJvsr84N
 9QC4yewTy3F6vPt1wNShnisysTHOlyulSbOb7mxDTzxOG3OMiqurtn4+rYx/rIbCbLN23
 QM4jL0NxNeCVWUi1ouX+xKgffDkPhL/QXv0bhkp103N5PMLxD5f5Fahq5yePEZwGuF1Au
 DB4qMG2RVeEjq0ZCUyhnaL8szBPHEUfeogXVWFgCbkW4ClXPIAn534/w+VP9R4A3iPg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=MVU3eAp1; 
 arc=none smtp.remote-ip=84.16.66.174
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.174;
 helo=smtp-42ae.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=MVU3eAp1
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D546809E7
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:43:36 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3ssx5x7FzHly;
 Tue, 13 Oct 2026 13:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791891813;
 bh=6hmGmq/roylCZdoLSHaIeEqkVCrUb+xQZdPPBeuQgbU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MVU3eAp174u9mtGiX9vv5rJHpfASGTThMkisliJPSIj1OQWBFVhuYzq5JWj3mKjkJ
 h6pDJPnwk+YDTfZZM+TpOaTNePJIlGoVhVPvYt3Bjnxnt6LvIRjN9W7sTDPEtPVFYU
 W0UmU3DrowhiVkEG26LB5MHO1LKrFFXL3I9rmqYy8ju5ZfvCxtR1mmMZJkYbnmd5Cu
 /xI1z6PN6YkYWq7rmAi+fO95D6X1XI43xbnw2vUPB3dosGV9xQoGaggaWawxMReTBM
 QzvbYXZPZIMbpbJb1LdnIBmAa2A8LkWuV7EUefkCKtRKl06Pth5NWH0hCmMw+N9msv
 M/hqzz+CRovSA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3ssw1Dqvztp2; Tue, 13 Oct 2026 13:43:31 +0200 (CEST)
Message-ID: <d94eac45-2a7d-4433-bd82-0ccc2286e38f@0leil.net>
Date: Tue, 13 Oct 2026 13:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] rockchip: Always init clocks in SPL build for
 RK35xx
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <fdb4cc14-505c-4dfc-b6bb-4b13f7c84275@0leil.net>
 <b20fed8c-4d7a-40bf-8e23-2c2440499f29@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <b20fed8c-4d7a-40bf-8e23-2c2440499f29@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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



On 10/12/26 6:59 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/12/2026 6:11 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/12/26 1:15 PM, Jonas Karlman wrote:
[...]
>> The RK3506 clock driver is notably missing from this list of "RK35xx
>> clock drivers". I'm assuming this is because support for the RK3506
>> clock driver got merged after commit c6bba31dbdd4 ("rockchip:
>> spl-boot-order: Defer probe of boot device"), so it means if it's
>> broken, it just never worked in the first place and we should rather dig
>> into the problem instead of doing what we do for the other RK35xx SoCs,
>> was this your conclusion as well or did I just incorrectly extrapolate?
> 
> The RK3506 clock driver currently initialize a few clocks from bind()
> in XPL :-S
> 
> So it is not affected, or rather it worked around the issue for USB/RAM
> boot in a different way. Should probably have mentioned something about
> the RK3506 situation in cover letter.
> 
> In my work-in-progress branch at [1] I have a "WIP: clk: rockchip:
> rk3506: Rework early clock init" commit that re-work that clock init to
> use similar probe-after-bind style. I likely just deferred rk3506 for a
> future refactor series as it was already "working" and the diff to
> change it was very different to the patches in this series.
> 

ACK, thanks for the heads up. Marking this series as Changes Requested 
on patchwork as you said you'd send a v2.

Cheers,
Quentin
