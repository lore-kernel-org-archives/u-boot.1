Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7890C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 09:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ED6280A9A;
	Fri,  7 Aug 2026 09:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8dU0L6d5Bn8H; Fri,  7 Aug 2026 09:36:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5053D80E90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786095390;
	bh=68fUuj6FPTJeBxZrPdTwXT2UxeVyixakjxJUDo9H5+E=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wL8XJKehYqF07n6u4h37B9NXyHLluH04lhfd4XE9Q+dvujtb1w3l7JEsqzhwnJLgR
	 649NfLo93ia+DX5hR1c7q0vmdthCUHZQimkNCYlMQmfePokVRPppXSs/jqeDO8FZYn
	 CxDTiNliFvRXYunn9fAmvy4dk30XlkSMYTMp5/VxyHvMwYA4bPZypbZw+nvgnCXacG
	 b2zS0YYW/JGxza69D2cBQ1M2iXNE/2uxS2cXTvxCI0X558/tIG9XisKVFSq7l17U0u
	 5YIXmnPYpIqnrGNnJ0IVhGus0ULSI+f9CFQjU0uuGoRuaeKCDacgcTHh0O8hVJgTm9
	 EPYbduBqHHueg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5053D80E90;
	Fri,  7 Aug 2026 09:36:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F86A282
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8101D80881
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:36:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 78dkHJtR-yjn for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 09:36:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.8;
 helo=smtp-1908.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 947D980E90
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 947D980E90
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 947D980E90
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 09:36:28 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGfD724R9z5yT;
 Fri,  7 Aug 2026 11:36:23 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hGfD60YLrzFsR; Fri,  7 Aug 2026 11:36:21 +0200 (CEST)
Message-ID: <cdb6ebf1-6d92-45ce-ac93-18135c23d3ca@0leil.net>
Date: Fri, 7 Aug 2026 11:36:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] clk: rockchip: pll: Fix double use of postdiv1
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20260730141308.1218014-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786095383;
 bh=68fUuj6FPTJeBxZrPdTwXT2UxeVyixakjxJUDo9H5+E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kvHkkBuNc84ysmGWU5kVafLCbk0t9WnZnKIwwtadsLzBuekHofj0thwNIiqK+vfWO
 G9sU1yl+DvFkTeVpmMR/Yj4n7JfIhO7/buGEdpRGGlE/grSkhHVMK2DaJSqafG5GJl
 GFoX9yglFenOZPOGGu84B8rBRBpMtfmPO48sr75ZbdbF8WtxQbQqyY6J6YHorn4tnm
 tLDISA/VcGnjEAM/n83tO7+bIcMZa3Zobtn0O4BSl7Tj/onPAbJG25AnjwbfLqj4rt
 IPBREYRHvmdT1KGEC5n51KYrq08dYzcW27YZkNMUExgUjvZuvSHXUYgP16+rZLQIiU
 tj1HOdE8GnIoA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=kvHkkBuN
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:12 PM, Jonas Karlman wrote:
> The possible frac_rate part of rk3036_pll plls is divided two times by
> postdiv1 instead of both postdiv1 and postdiv2 as the integer part. Fix
> this by using postdiv2 in the second do_div() call.
> 

I... cannot find which SoC(s) actually makes use of that function. It's 
only called when pll->type = rk3036 (which is 0, so anything that 
doesn't explicitly set ->type will have its type be rk3036), but all the 
drivers declaring a rockchip_pll_clock array specify something that 
isn't rk3036. So... is this dead code or what did I miss :)?

Where did you get the formula also, I couldn't quickly find a publicly 
leaked TRM for RK3036 (and since I couldn't figure out which SoC(s) use 
the same formula...).

Cheers,
Quentin
