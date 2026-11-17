Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE11606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RiEBlJvj;
	dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YK2b6Deh;
	dkim=pass (1024-bit key, unprotected) header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b=SdzQxm/v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5AFD607E7;
	Tue, 17 Nov 2026 19:49:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mEGJXicKNM3z; Tue, 17 Nov 2026 19:49:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB76C60739
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794944987;
	b=Ozn/3IDU20apjCNIYhPC8DmhSyOpDpomjAuxvKMuyo7SlXRtMdb8MjRj5hOX/Qb9HzVE
	 Rdgbfxm2vzMDnX49BdgTPLY5wh3EA+GNDOCuMEZZ7bns54SSgwtKJAOhrvYThjhhU6nFh
	 qJ6j8KKmYSJL9VwjgYNz8poRmdkEwL8YpyV2fNe4FhSvg34AtXjhU/tuQDFAE0XCGAK1C
	 7Vv8SjO5/6jhqVA+9IeZ/eR/nTUPFZFr9xGQDl9EC5qY+xiHLRqD0y5Y1vxWguf3WQk/+
	 mo2nRAHasgbeLKm6XGKcyBrTmOz5NyfXNmlY8wyr46EJl1NP3py+EOHgS2O/LVwpyqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794944987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:CFBL-Feedback-ID:CFBL-Address:
	 X-Forward-Email-ID:X-Forward-Email-Sender:X-Forward-Email-Version:
	 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
	 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qtt7TcIZb+R3JGnLzUsVo6WgUztNy28bMorwsdswl0w=;
	b=bmRaV2RZX4Sjv6K8ZjRnUgdrZRAS7PaW7k21Mwm16cLXmMqKvxLcd2DECM11m/dlw/Ts
	 Z73GlKX9H2OKiiqe3eaPrWlqK9LQLFRGGh2SF/x+KzhFzXa7awc1Bc80kpBOxd7s6Ra3Y
	 hObp1MFazsy8ySXFvBbSwvML83Ulh2+AFSL/f9i0dS8aVyda6bABdxnXFktik3u5kLvYS
	 vWJVPjSZ+n9WYj0q8+irON8Q7rRFkW6S8lJrtHFdXPXD+0FAJXellGJzPk/juZe4rs+S5
	 la//PwuMexO3mhcerEeD03U1fIKa8/ye/2Kg2x3RpcPaGm/sQoBVvzpPoCwPCIerE0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YK2b6Deh;
	dkim=pass header.d=forwardemail.net header.i=@forwardemail.net header.a=rsa-sha256 header.s=default header.b="SdzQxm/v";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794944987;
	bh=qtt7TcIZb+R3JGnLzUsVo6WgUztNy28bMorwsdswl0w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RiEBlJvjRiMQWn1FX1BbVHZWsyv9B6nqEqLaHjOApIwABTPzakrq8Aw2hMjiYMssP
	 KOo2yWWbtCktB3APV6Pi5lS3zk9LMZlgQgtdhYu6bYujYfFZ00Sz7UZx9U5ThNt+5V
	 dWhUzhAnNSF93gHB3xVmfWjTEbpUI0qviYxOh5JaBjQRJD/hvqOATcg9AgiId8/6w6
	 y30X6LQWn3FppVTxJNfweEIQ74W4J5SBlAHxJxs2MLerwco6aHri+cgyIK4+GuQVli
	 L3fXUYPrdJyz237ONRcQcucFDiw2tY0O48/Y2tIq1equFiw3KP0+84X7LvFmR76nRm
	 shY2M1dPhQE8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB76C60739;
	Tue, 17 Nov 2026 19:49:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D71C1E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F311460761
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ICZTIZPCFtF1 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 19:49:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1BCCE60739
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=121.127.44.73
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=2ff8=jh=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=YK2b6Deh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=forwardemail.net header.i=@forwardemail.net
 header.a=rsa-sha256 header.s=default header.b=SdzQxm/v
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BCCE60739
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=fe-e1b5cab7be;
 t=1794944981; bh=qtt7TcIZb+R3JGnLzUsVo6WgUztNy28bMorwsdswl0w=;
 b=YK2b6DehVSnIkKA6GhV0DUYFg+8v/5wIsYuHgB3UX5WRpFcjBR/SjGJfi5Ux7nqJ1VFoFh5ss
 dDaHsErAidfd/rhgeVKa/GuZYwPQqtAQWkh4Ivnnu4bD7Dy016o5untBm+rfRKxSNPfUULqToVo
 1/m01gKrDMB0SKA3v/NG1/0ZoKav1p99iv8u782+s9eSagxf0YY71RmZdpZO5Kyj/nNbqBz+Ep5
 8AqJxd7+qpjoc6xEfMpAGeMUwCxwBUMgdIw4i52i+S2+9Pf23KM/OFtA2JCflkFWBoaxrYj9D6O
 8b4KEGFPJdOgniaW4fcGV/0NonflEpb8RajqtBQaqJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=forwardemail.net;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From:
 Content-Language: References: Cc: To: Subject: MIME-Version: Date:
 Message-ID: CFBL-Address: CFBL-Feedback-ID; q=dns/txt; s=default;
 t=1794944981; bh=qtt7TcIZb+R3JGnLzUsVo6WgUztNy28bMorwsdswl0w=;
 b=SdzQxm/vP25PxmyXUTn5ZCumfx2NMj1AlmWv21qXv7SD01Vj2/mnkh8PnwrFVbw/qRffyeH+e
 a6VI4RiSmZMlzQE01WSMHiW+VFi/5V97BbiCfSzaaE3UVNzrzD5yV7IYSu1pxpf8kb8LX1uBCob
 mE6o+RSF2LH1t1W1MgyQ5Fg=
CFBL-Feedback-ID: 6afca1c5f6345fcef6bd695f:83eb6c6eaf010e89907d23a5917ad511
CFBL-Address: abuse@forwardemail.net; report=arf
X-Forward-Email-ID: 6afca1c5f6345fcef6bd695f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.19.28
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c336839f-36fd-42ec-9db0-322d5c13eebe@kwiboo.se>
Date: Tue, 17 Nov 2026 19:49:38 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 3/8] clk: rockchip: rk3506: improve PLL_CON() user
 friendliness
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261117-rk-clk-better-con-names-v1-0-25521d4e37c3@cherry.de>
 <20261117-rk-clk-better-con-names-v1-3-25521d4e37c3@cherry.de>
 <94e836e4-fe65-4891-839b-1998c02c2b77@kwiboo.se>
 <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d4467ddf-13e3-405e-9c89-93bdeb02a5e1@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

On 11/17/2026 7:06 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 11/17/26 6:59 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 11/17/2026 12:37 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> There's no PLL_CON8/16/24 in the TRM so one needs to do an additional
>>> lookup the header file to know what exactly this refers to.
>>>
>>> Use new macros that reflect the names used in the TRM.
>>>
>>> No intended change in behavior.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   arch/arm/include/asm/arch-rockchip/cru_rk3506.h | 4 +++-
>>>   drivers/clk/rockchip/clk_rk3506.c               | 6 +++---
>>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>> index 9ddd6215fc53..331b100ced54 100644
>>> --- a/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>> +++ b/arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>> @@ -48,7 +48,9 @@ struct pll_rate_table {
>>>   #define RK3506_SOFTRST_CON0		0x0a00
>>>   #define RK3506_GLB_SRST_FST		0x0c08
>>>   #define RK3506_GLB_SRST_SND		0x0c0c
>>> -#define RK3506_PLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>> +#define RK3506_PMU_GPLL_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + (x) * 0x4)
>>> +#define RK3506_PMU_VPLL0_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0020 + (x) * 0x4)
>>> +#define RK3506_PMU_VPLL1_CON(x)		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE + 0x0040 + (x) * 0x4)
>>
>> Please consider something like following:
>>
>>    #define RK3506_PMU_CRU_OFFSET		(RK3506_PMU_CRU_BASE - RK3506_CRU_BASE)
>>    #define RK3506_PMU_GPLL_CON(x)	(RK3506_PMU_CRU_OFFSET + (x) * 0x4)
>>    #define RK3506_PMU_VPLL0_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0020 + (x) * 0x4)
>>    #define RK3506_PMU_VPLL1_CON(x)	(RK3506_PMU_CRU_OFFSET + 0x0040 + (x) * 0x4)
>>
>> That would closer match what I had prepared for existing and have
>> prepared for new SoCs, i.e. RK3562 [1] or RV1126B [2] ;-)
>>
> 
> Yeah, I wasn't too happy with what I came up with.
> 
> So, I'm actually wondering if this is just wrong? Shouldn't we rather 
> have a pmucru driver, separate from the cru one? Then we don't need an 
> offset relative to CRU_BASE, only from PMUCRU_BASE (so the hardcoded 
> RK3506_PMU_CRU_BASE - RK3506_CRU_BASE, or currently 0x10000, can be 
> entirely removed).

The upstream dt-bindings header and clock driver for RK3506 already
include PMU clock ids, so not sure that would be possible (or easy).

> I briefly looked on linux-rockchip ML for an RK3506 
> base DTSI but didn't find any (but maybe I'm bad at searching :) ).

I have prepared and was hoping to send out missing GRF dt-bindings and
base DTSI based on [3], excluding USB nodes (missing dt-bindings), very
soon.

However, CI failed for my latest rk3506 branch so may take some extra
time to sort out final touches before posting, as I would like to cross
reference any RK3506 related Linux and U-Boot postings.

> I 
> think this would align better with other SoCs like PX30, RK3399, RK3568, 
> RK3588 and RV1126? What do you think?

For most newer Rockchip SoCs we seem to treat any consecutive CRU
related reg-blocks as a single CRU, i.e. RK3588, RK3576, RK3528, RK3562,
RV1126B and RV1103B. If the two CRU reg-blocks would have been separated
by something else I would likely have agreed, not sure it is worth
trying to change something this late for RK3506.

[3] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/blob/rk3506/arch/arm/dts/rk3506.dtsi

Regards,
Jonas

> 
> Cheers,
> Quentin

