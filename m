Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4D9C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5663260740;
	Mon, 21 Sep 2026 16:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvD4XIpPDfm5; Mon, 21 Sep 2026 16:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 61DF160762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009936;
	b=UxheqQukPe8hR3SZqsxYCSCIOcxBvU/guXcxEDWHYVYQ5VZv7uyTPXdHGPYuyhILvc7u
	 F9McglhhfB3Zg0WYV93Xho08lIaqEtl96C0Yxw1tbmhHo6u/OEBexILOPryQZ+aDE3Qp4
	 wGniIRUOlmEfIl2zGxh5j5dWwDKNex4FOrVqSr8XZ3OT9NI4OxmuJfRXKx8c3a7da2DEf
	 Gil1BysXC5PEUDo3BtNkx2sK7DYS71PdadOJJ8wsCbGjgT085nBrw8uTiD5gXF0VAuDfn
	 QkARgtiaec9FQ80Z2/busBCchQcOQ/f6tmHBXleHQ0M5UW8QEl0+0xoWN95Zq8if9vA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009936;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tuAj473ZF4dkJfJf9d5/+FcXH5eRNsn++k2cSgnpvfE=;
	b=PNeOlXpao1BepoAyZPUWZKF1kZRd/xS2vwnvXo0EZB7D1RpC6FL3XmOjXk6lnB/qeqtj
	 HItBXK2+Y57UG4HjhVNFIQOQD8wkkQ1A/91xwcH4AAScrvIWfnsPY+7ltaLcboJWJiqZl
	 9sZp3pqKEeBasGvp/OdY1wNKZ2bbLFz9WvMItdOD9cKLSSt7pyvBUxIlpF1YuxAShl1Bl
	 k3wRskD5Rp7oeRuBYj5wSfl0uX5ih55ROneBgSisaxv/iddRRpe+xQ5cob1zQK98b/gN4
	 vaxARRO4nGtldzwQBh4bTGBO8L9ojItzaakp0ofEiYGqFA6a9KtMMdkJRFD4ozq6Zkw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009936;
	bh=tuAj473ZF4dkJfJf9d5/+FcXH5eRNsn++k2cSgnpvfE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mN2auvbLlsqn7NZNRe6WMazli4XN8+Nn2LhVC4LPd/tOdGNehC9I0SwEitKKpVst0
	 f+zDEWfmCbZyfKjqA70tT8UTgHgoZ/YKjdp6OEghpkkcN50uJQx1RP1AW0qwPC1MzN
	 RjL24GTNAfSV2AF9nDNroYqvODtQMwo8aVJYjSdel5b542zwAIyIZ8l0/k4KI3ywgg
	 l52wlWK6NVVdxA4dg4mSvN+bz19IpUeWiukNbzLO49H6cTXzthdpoE3tHP6h99MarS
	 7rxAoAKr3CgvQohQ31gqDN0RHBOKzcmJ/KpgVOSLo5x6cFzjSpNA2R4MdM2YI8bEZY
	 CSjvxcJKZiIqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61DF160762;
	Mon, 21 Sep 2026 16:58:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D15EE12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3D1540AA0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YdITXsJADmGi for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D50740A57
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=84.16.66.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790009932;
 b=NOWYIdP4e7TXm0qoJs+gzByMZ9NxStXe2yUBzQq4BGdbVYtd7hbFd3PNlfflDI6ehRvN
 tBVTFtooRVAaD7cLbLmfBlvB2ceYYqCskALOIzdDEpmtaCqDA9QEElBUBAIv/bcn0B0Y6
 TXuyLg9CMZYgN4j8X3joAMKrq8IJaWtrCX/I25ecF5z1anfKL3zHFbiHIlpUR3a6jHdQ3
 /TQQahanxr7DRTqZt2hb8vE/FGQ67yUm2BW/kePUBEm3li/8GOe4vvfip0XkyIPvxx7+y
 192KmBfbM/rwixbKthl/0v24wsaKsthUkqupTrpfi68LH+f74Cb/Bc5fNzdqGpIV2gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009932;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=tuAj473ZF4dkJfJf9d5/+FcXH5eRNsn++k2cSgnpvfE=;
 b=mm4Ra24Y5DyCjGTpjKCtKBB1bzj3sqKBbJZODiiSVCWhjsLTLYYz1fHS8rj877nMLzQ7
 hxYpFTKizbyC3ZZ5lVtwUByBS3WP/pT7h6JfCO9PhEev5mb9KqvOCHfOOxVdkXFpgM49t
 B2GJwYuAwXt9sPSnedbLq+lWOb/OLpHSdzocyLu6a6mP1pQoJEpJNiZGFttEG77y3M5Hh
 HD7s5s4BLr+B1hGjIcgaBlYzDzipUl5RiBpRAhlAuFYPbEK8ytnZPvhoRZkoAaKI0Uouy
 EUvy6qrPs5vKsgMYbKODZ9XKC769XETYJPWNlQq3amGUUWy3FHxrQ7HkIp/c2r1Fe3w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fMi75eBd; 
 arc=none smtp.remote-ip=84.16.66.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.170;
 helo=smtp-42aa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fMi75eBd
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1D50740A57
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:58:50 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hpTvr4WvXzhPS;
 Mon, 21 Sep 2026 18:58:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790009928;
 bh=tuAj473ZF4dkJfJf9d5/+FcXH5eRNsn++k2cSgnpvfE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fMi75eBde1zAqAKVHVLgCEt8YuwAo1o12X/nckvKiReNbgbsXPkEUncyB+g/8+ouP
 70coz5KNZV53U6XVU6AgkC/RcOucdl5zYpAxedFvCJzCfbAqHvajXzcsHZWnPJsPPW
 le10W41xNaa68x24wHfSA1qjlES6M2NNVNrykJLbmJ5Iu67GNz945COIm3DXKCbNtY
 2Mo0BF2wNxbwWh2SXW8/iUmycOac2gc2PfEXMPM0qPkvDlxHXzNMdpo9AMjdxXAqf1
 UtJIN01ROanBgwd5EhtmM0OXC85GEJHDklRtORwdrwpgCat900kcPSBYbsjqrv6lFN
 0lRuD2W6f+THg==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hpTvq2ZVQzf7L; Mon, 21 Sep 2026 18:58:47 +0200 (CEST)
Message-ID: <f5d86815-d43c-486d-981d-711ec94f0b6d@0leil.net>
Date: Mon, 21 Sep 2026 18:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] rockchip: SoC info and reset cause printouts
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.u-boot-project.org
References: <20260920-reset-v1-0-42820216369f@gmail.com>
 <ad7869e9-d7ee-4130-b924-ebcf9719b93a@kwiboo.se>
 <CAC928HZ1x8vM+cQ7BoLEu5EuKzeHCcjMnsCvBugvf+24O4te=w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAC928HZ1x8vM+cQ7BoLEu5EuKzeHCcjMnsCvBugvf+24O4te=w@mail.gmail.com>
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

Hi Massimo,

On 9/21/26 6:51 PM, Massimo Pegorer wrote:
> Hi Jonas,
> 
> Il giorno dom 20 set 2026 alle ore 17:49 Jonas Karlman
> <jonas@kwiboo.se> ha scritto:
>>
>> Hi Massimo,
>>
>> On 9/20/2026 4:15 PM, Massimo Pegorer wrote:
>>> Looking to provide a way to print reset cause on a board equipped with
>>> a PX30 SoC I ran into the following existing issues related to Rockchip
>>> SoCs:
>>>
>>> 1. It is not possible to select DISPLAY_CPUINFO configuration option
>>>     with ARCH_ROCKCHIP, except for RK3399 RK3288 RK3568 RK3588 SoCs, due
>>>     to incomplete definition of type 'struct rockchip_cru' caused by
>>>     Rockchip common implementation of print_cpuinfo() function: see
>>>     0f9872c4db11 for the RK3588 SoC "workaround", which I feel not
>>>     optimal. Note that DISPLAY_CPUINFO has default y if ARM; therefore,
>>>     it is deselected in each Rockchip defconfig except for listed SoCs.
>>>
>>> 2. It is not possible to deselect DISPLAY_CPUINFO configuration option
>>>     with TARGET_ROC_PC_RK3399 due to missing get_reset_cause() symbol
>>>     caused by mach-rockchip/Makefile skipping cpu-info.c. I do not see
>>>     how e230c579a3f6 commit separated the reset cause from displaying
>>>     cpuinfo as proposed.
>>
>> Please see the series "rockchip: Add and use rockchip_sysreset_bind()
>> helper" [1] that already should resolve above issues.
>>
>> That series has some loose depends for a clean apply, but the idea is to
>> fully move the resets status handling into the sysreset driver and start
>> cleanup of 'struct rockchip_cru' use.
>>
>> Please try, review and possible build on top of that :-)
> 
> Thanks, I will. I missed it as I re-joined U-Boot mailing list just a month ago.
> 

Welcome back!

> What's the status of that series? Is it going to be applied to u-boot/next?
> 

The status is that it needs people reviewing and/or testing the series. 
I'm the sole maintainer at the moment for Rockchip and I have a day job 
so I put as much time as I can/want to in it but it's limited, but I'll 
eventually get to it.

You don't need any permission to review or test patches on the mailing 
list so please feel free to spend some time reviewing other people's 
patches, any help is welcome :)

Cheers,
Quentin
