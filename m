Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08057606A32A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UnHvV/6r;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=FCR7i8f2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5EC740B2B;
	Thu, 12 Nov 2026 09:53:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4yuRLbEf3yB; Thu, 12 Nov 2026 09:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC23B40ABE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794477201;
	b=FhtVEZwoOeKElCtlNeS+m22yFiJh/xDDM7l53itvPYIS+zMJDx1dT7J2WgaiuVFPoKUi
	 DFrreSvqBnmKjPM0QkLc2PLC32th2ndA+U7rn0r/VKNxPO6+UgsZ/FAyA2EqTh8xmhGks
	 CwzG+VGZBmEoTypKvaAuNPup4e/9x5+nXGLgE6BpcggBc/ukeE+wvpjephRDl0qrAQx0f
	 AGcBS87o7G/T71Km5a5UMsWHKZRwtx/kUKibjn+nkA8asakmysBZKK45CJOp8Qu2e4oq0
	 FJvxPfRGEGU7XB3D4xdtfhFY7PIBtMn1qYIdhLGqxkdJypZcQKvdVSCV28HAApW1oQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794477201;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B4ameVPFf89oYYrjr2RY31S9r6HBJqqGiNRjQbCUr9I=;
	b=gORPVD6Ukh2+KJeHbz1Td0sJBWvzTf+n7mHYs9e0MjF+WSO5aS0szXUOWOLiqqPTVZOn
	 gPQC08WVFFjDpPmQmyA6tova0wJiH2Zz9GHgfso7sCSPG6eV90Y2hslrqacdv11uk5fMm
	 7fkkFLuTQd5VI961BTYT/I8M7C4KgtNneTNmkLVYon1ciEGnpb5XrpHB0jYWCkKNP8Bwc
	 ldUgU3/Ly9yFXlb5qO3tlbSBj53XapUdgJSZxUyspghfjGZFx7G+k36fqOD+TCBEJmh/X
	 o1Chyv+LetTTMpfMBi3kzmfKBegWTSZcf2hL+ScZ993n7TALY7qWWVO7TXXnpDH45aw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794477201;
	bh=B4ameVPFf89oYYrjr2RY31S9r6HBJqqGiNRjQbCUr9I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UnHvV/6rz2/82VR/gOSGsRAA+9ldYC6Xl9vN1TCCsf3q1ly3K4kFsudRBTz3tk1eP
	 PfLIP6lpwEe/kBs8BJ1TtrinjyfQfRh7e0KUOdIlaBeMfaTzS40eLQHscRTt+rSUtg
	 JFNoyUQrpc57J9jNWmfZ4Tq9AoSDQCPnPMEji+BDM15Aev7LXa2lCuUEM/MrnFIA5A
	 RFgyHyzydpuGv+PzZYTgEGrnk2poNYhCnHf8yAGGWpodud5CobLXU83sSjIjyJqQBx
	 o5kODHFlxCWIR4U45Hh9DS//kTsTrvWMtx7+0H50hqf9SmF+C+aRsOqOTvJBL2MIKq
	 ZWfqlKCcs1xtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC23B40ABE;
	Thu, 12 Nov 2026 09:53:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 83091235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 09:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7489F608A9
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 09:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4G7nZYFtTvEx for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 09:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C7A9F6060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::8fad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::8fad; helo=smtp-8fad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=FCR7i8f2
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::8fad])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7A9F6060E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 09:53:17 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jQG0q1rLfzJjN;
 Thu, 12 Nov 2026 10:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794477195;
 bh=B4ameVPFf89oYYrjr2RY31S9r6HBJqqGiNRjQbCUr9I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FCR7i8f2m2XbPE1lPB3rNwzh9kJtbenMod4i89Ue7+NyDXy2hZudpIDvRlPAfxHNk
 RfdNOPCKooWUuSfSoffImWHBwpmLeFqHzC3GCRvOWh7YZE1WNML89ooLmRPwVz0cP9
 aAL/d3y/Wig2pkJOaOzARaJ41C6yeF1xYVHrpPYwQsH9S1OnJkXitlKi0j7TxZyTIQ
 3jvmSnpCCXXqXDP5jRRtl/umey4tDbx1dTjaKqFmtBpHGkNSVqKm6v+8DjMnCpre8R
 BD4VfK2W68JbmQtGv65D3sCFszLNz+SGRrqik//l2kuS4mzOVYS4ozlruARrp53Ezs
 82ETMWgc66gXQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jQG0n4qpCz5vx; Thu, 12 Nov 2026 10:53:13 +0100 (CET)
Message-ID: <bbbf38a0-53b3-4081-bbf5-adb87e1d5f26@0leil.net>
Date: Thu, 12 Nov 2026 10:53:13 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add LCKFB TaishanPi 3M
To: Jonas Karlman <jonas@kwiboo.se>,
 Xuechao Han <220110626hanxuechao@alu.hit.edu.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org
References: <20261111165135.245826-1-220110626hanxuechao@alu.hit.edu.cn>
 <179441628581.251684.11046053143224226025@alu.hit.edu.cn>
 <7f90a097-1b57-417d-9e35-d66b1cf898f1@0leil.net>
 <5f481ac3-f885-4b14-a67e-680f2d9f36f1@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <5f481ac3-f885-4b14-a67e-680f2d9f36f1@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 9:05 PM, Jonas Karlman wrote:
> Hi,
> 
> On 11/11/2026 6:51 PM, Quentin Schulz wrote:
>> Hi Xuechao Han,
>>
>> On 11/11/26 5:58 PM, Xuechao Han wrote:
>>> Hi Quentin,
>>>
>>> I sent the v2 patch a moment ago; the changelog in it is only a short
>>> summary, so here are the detailed replies to your comments.
>>>
>>
>> When there's still an open discussion on some part(s) of the review,
>> please do not send a new version until we've agreed on the outcome of
>> said discussion(s).
>>
>>>> issue: Device Tree is a representation of the HW, so hacks are not
>>>> welcome there
>>>
>>> The DWMMC driver does not use cd-gpios at all: its get_cd callback reads
>>> the controller's internal CDETECT register, so supporting cd-gpios there
>>> would mean adding a generic GPIO card-detect path to dw_mmc, which affects
>>> every dw_mmc platform and cannot be validated on the hardware I have.
>>
>> That's exactly what I'm asking you to do. Adapt the driver to support
>> your use-case. If other boards also use cd-gpios and you break them by
>> adding support for cd-gpios, then they probably had an incorrect Device
>> Tree to begin with and they'll need to fix it.
>>
>>> This pinmux is also very common in the same SoC family - rk3576-evb1-v10,
>>> rk3576-evb2-v10, rk3576-nanopi-r76s and rk3576-nanopi-m5 all select
>>> sdmmc0_det in their pinctrl - so I followed the same pattern for this
>>> board. With that, the SD card works in 4-bit high-speed mode.
>>>
>>
>> It doesn't matter what other boards do if they do things differently at
>> the hardware level. If they do the same thing at hardware level, it
>> might still be they are doing things wrong and doing it the right way is
>> better than doing it wrong because everybody's doing it wrong. Jonas
>> said[1] that other boards seem to be doing it wrong and they probably
>> should get their pinctrl fixed as well.
>>
>> Does the SD card work in Linux with sdmmc0_det_l? If yes, then it means
>> the Device Tree is likely correct and we need to adapt U-Boot driver to
>> support it, not hack the Device Tree in U-Boot only to make it work with
>> the U-Boot driver.
>>
>> You have two options:
>> - fix the Device Tree in the Linux kernel so it uses sdmmc0_det instead
>> of sdmmc_det_l, and remove cd-gpios. Your "U-Boot doesn't support
>> cd-gpios" justification for doing this change will not convince the
>> Linux kernel maintainer. You can try, but I'm pretty sure you won't get
>> positive feedback on it.
>> - add support for cd-gpios in dwmmc driver in U-Boot.
> 
> The cd-gpios should typically only be needed for cases when a different pad
> is used for card detection signal or when card detection is not triggered
> using the controller detection logic due to e.g. controller detection not
> working when powered down and GPIO func instead can help detect when a card
> is inserted and power on the controller (rk3588 if I am not mistaken).
> 

Yes, we had (have?) this issue on RK3588. I believe another reason for 
using cd-gpios is if the polarity for the CD signal is inverted compared 
to what's expected by the DWMMC when in the CD func (and not GPIO func).

> Not sure rk3576 has similar detection issue, if a new card can be detected
> by Linux using internal CDETECT (no cd-gpios) after being powered on without
> a card inserted there should likely not be any need to use the GPIO func mux
> (with cd-gpios) for the board.
> 

The power domain for the DWMMC needs to be off for this test to make 
sense otherwise we don't know if it's not going to break in the future. 
For example, on RK3576 the power domain for the SDMMC is the same as the 
one for the GMACs, so we need both GMACs to be powered down/turned 
off/disabled so the power domain can be turned off automatically and 
then we can test whether the CDETECT function works as expected.

Cheers,
Quentin
