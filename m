Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A418606A89B
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EuzkPYoO;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=Ka+o2XZE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E03E560DB7;
	Fri, 13 Nov 2026 18:46:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kG63ODlC7coZ; Fri, 13 Nov 2026 18:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E331C60D6E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794595566;
	b=Y9PmjvD+Hd/wWPWYbWd4OruREMYRGTuAZj/a9aDH6t6PdTkrYGqh4KDtijlzuHIP+nDF
	 Hj/8fXwl0X3iJoAJBPQihza0F8dXAjN1SaARMRxsTGDLqUD6b2dMxqnwFFkb+ao0vCfRD
	 I8rFUWb7Lya6q0OEicxyDFmaUgBFhQMFuBnHexK6vfX3+OmGf7rBHs3Hg80HIKsJnWlrH
	 Y/fc0FoL4mHKJLlPO/JR92KphOuxH3icb0E7669cePrdzFLN1URQ34hRPRtRlGf1GMKDs
	 Hx5f/PH7cGi6ArUs6j20nK/ug1ZQDwl13rTtUBynnAIXHMWMRFVSyH6v4u00i7I9Efw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794595566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gmJYlgbMv/tgZtckiNcZR4cnGx2ofzvmGyOGSpkaeVk=;
	b=WtAbA9BWxrn3TraV8Jqw2L+p2zCqYsEgjguJX2B9qOFsqqK8bI1k9vDxmCcc1anvQT2y
	 U/QxBlbdL87iO/f8+b0TAJltb0r5AYgf2SzrX1DmTvGIwXUaAZFBEBGXAjLxnC/JhoZrh
	 XvpvhR0iCvxPu2YBauB8mSeUHiEnymtyblFFthDV+inNdx6zhRiROeXbG42wKNL3GHyhe
	 S7c42FpAFp5QigsJBhh8WTHRCf/mJdwk/97YzMmFQBIZICxD6NBmDE/i0sM+E35C6g2Zi
	 hM1nmMPEU3kc9/6umWRVdZuDgt9pBOV9dERXhFkexFYpS9ypI1y+YL4N4IdRgoYWH7A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794595566;
	bh=gmJYlgbMv/tgZtckiNcZR4cnGx2ofzvmGyOGSpkaeVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EuzkPYoO5CQOtu5GQax6hH7wWEQR9EPDMgvYiNHzhSMbt/9bXNIYh/ZSz2B07y17m
	 5wdP4tlw2UQGZMVNBYoIF+R6zns3keeANuO/qsaDiFrWwkL0WQk2HO1hjX2HmJnVOz
	 ayQFjRtxgVEmWCreCXOFzxVKrQXCMNBr7lD5NALdQHOVOr2p2m9Tm2di3Q5kZHQQzk
	 8k+QfIk7z/z3kVtUNKW72wF7WXsNQRftLbEWZOJ8BCslLScRbZMkHVkmVRtTYMVUQA
	 cw3T9M3wS11KiSmR2qK6DTtOoo+O6W4RhVU9MPny6lREikKXgNupPCP3PkEtyfDAHO
	 QPdXBkbZ7LkSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E331C60D6E;
	Fri, 13 Nov 2026 18:46:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D335E150
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D07AB409BE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:46:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwEe3fVid9BC for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 18:46:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5779B409AE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:e38::42a8"
X-Greylist: delayed 14920 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 13 Nov 2026 18:46:02 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Ka+o2XZE
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:e38::42a8; helo=smtp-42a8.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch
 [IPv6:2001:1600:19:e38::42a8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5779B409AE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 18:46:02 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR5n36ZgNzM7p;
 Fri, 13 Nov 2026 19:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794595559;
 bh=gmJYlgbMv/tgZtckiNcZR4cnGx2ofzvmGyOGSpkaeVk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ka+o2XZETDO+gSov+QOQXhqK8raJY7UoaJpUgw6MkuukDuYRh4cuxKT2PREUMy1f3
 MoQTPXIIZdxXiZmXYl4xaD4S8cUo6nxewXlvcVh/b120cKXaXwhWLTjtprvOFJBaP5
 fC1n7Yh67R1UIidNu8JiUD2sIc3pBMD0ULWLAmHW3o0jUD7NPpYADcvTb3KzCDCLQt
 sDjG7KrceqynTGUSGwjz/tH/toGeEQF6fALxX48/CuvCW7zd6ueS2MPaJ8lqo7DjRY
 vQle3t92HOmRX3Jhqb4Y5HZs/CFMb+tUTC0mt6MDUFT3zGMLhrVszYD9pJ6ipqA3zY
 CgCX9QCx1Wc+A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR5n23hLmzN6r; Fri, 13 Nov 2026 19:45:58 +0100 (CET)
Message-ID: <bb670929-3db2-4626-8a82-f2791b0c6064@0leil.net>
Date: Fri, 13 Nov 2026 19:45:58 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] clk: rockchip: pll: Fix automatic PLL fractional
 parameter calculation
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261111222834.157842-1-jonas@kwiboo.se>
 <20261111222834.157842-3-jonas@kwiboo.se>
 <ffdd97fa-13f2-4488-8d66-193f01ee029f@0leil.net>
 <b5041ac3-5958-46a7-9705-eff81a426395@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <b5041ac3-5958-46a7-9705-eff81a426395@kwiboo.se>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/13/26 6:53 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 11/13/2026 5:40 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 11/11/26 11:28 PM, Jonas Karlman wrote:
[...]
>>> +		frac_64 = (u64)f_frac << 24;
>>> +		do_div(frac_64, fin_64);
>>
>> issue: fin64 will be cast into a u32 even though it's a u64
>>
>> I think you want div64_u64() here instead no?
> 
> I think just changing to use something like following should be enough
> to fix the core issue with f_frac << 24 being truncated to 32-bit here.
> 
> 	u64 frac_64;
> 
> 	f_frac = foutvco % MHZ;
> 	frac_64 = (u64)f_frac << 24;
> 	do_div(frac_64, fin_hz / rate_table->refdiv);
> 	rate_table->frac = frac_64;
> 
> The issue was found with AUPLL rate 786432000 on RV1126B being assigned
> in vendor DT, it was not included in pll table and instead triggered the
> auto calc and with this patch the debug print ended up like:
> 
>    frac div running, fin_hz = 24000000, fout_hz = 786432000
>    frac get postdiv1 = 1,  postdiv2 = 2, foutvco = 1572864000
>    frac get refdiv = 2,  fbdiv = 131
>    frac = 126e97
> 
> With Rockchip common 24 MHz fin_hz clock I do not think we have any need
> to use u64 for fin_64 and using div64_u64() here, casting f_frac to u64
> should be enough to solve the issue I faced.
> 

I agree on all the above.

Can you rebase your v4 on top of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commits/WIP/20261110 
(or wait Monday for when I send the MR for next and it's merged, to then 
rebase on top of next instead)?

Cheers,
Quentin
