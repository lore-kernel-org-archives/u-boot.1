Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37792CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C78DD40634;
	Mon, 12 Oct 2026 16:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dk2xF8D7SPA1; Mon, 12 Oct 2026 16:16:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDE0340586
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821807;
	b=YWgALppThtQjQir/6nxZJPAdvzAmNDyEea6g9TjgTv3/T2LIni11XEyBhrow0itup5Fy
	 671NiM+65LhsqvLJCPJOVqX51uDzq6taPkXRhwmeT24dXCGXVeAa1lvaoDeCPILAjwmQP
	 E7FJzTxux2AZBK0llaE9aYANygsINM5TjGT7Y7Nbm8eUvvo2Y/LIqFeR2gH0fbGcqIGdD
	 lkXeZxpesRaNXANvAYBg42SVoxgbIwppM3xbUvivrCIDPhIrEecYGp8pGPpL92/54id3N
	 CNETvAs/x3l7X6WxHTz6LcwnC40UQXk7r97y7jijPMUBR/EQs4SlCre9GPOkYrgOULw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IJqDmA1+sQH02fXZyJoKO8ASm2d78a6KPeZ6fRpPiRo=;
	b=oxEuiKvlkWbH21YWpim5X3P8mnHIAs/sUhD4CVg+Khq6kHtfLybMy5w7+K04XLsGS4kX
	 pKaU1JPA6xJ6TeQeL5dT4fZPVY67wfY7szSHAtRPpSzIDfjjNPN8na10fdMjAAPGA6SOA
	 k6RNH5LJzagQrDh0y783NOX8tHu9cUkvjPgjSV7JNu2Edkg4q1pZqXWiTglH2+ngQhcKG
	 6mw1zMUPcBNaxYpClkJVT1sWhruOBrim3FFbEG78TMLG+5uVcXNM+6S6owpDa3ltkEH3u
	 dHwxyL63akZk5Z5X9azVRuI1QVbM6CDpVyrL+0UEqRM1wd3WxMy0wr7gaA4e9NfyZ8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821807;
	bh=IJqDmA1+sQH02fXZyJoKO8ASm2d78a6KPeZ6fRpPiRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r22bOdjOJhaG85/utWBAJKjzoVeUaAhPBiPBfBAfTrQdP//rH5KSkjmh5yXBT+wRq
	 EemJ94sSvtv90uNB6Hi2BiYsM+TbfOF80GQGRZTvyyyo2m+jgk7nv9uUtJUerfexKX
	 524gXFtLz4FX9FYJ7t+YTEA/VgmyHNAotxx/ksMECjRFIPUzkhdJN7xM/wJjxSCuCC
	 EauGvGrWx1ofDrOgQPhMVt/2ymJ6Al8B3kxrBr79RiyA3yZs3uiayw/BHZwbkZjX2N
	 RpWADZ3CDKaL2JWpwdtyk9JIlxMsdMnYyrMt1cbROCXQP2wRWDPH1P8sfY6piTGppp
	 6w3/mSG50Efgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDE0340586;
	Mon, 12 Oct 2026 16:16:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56E3B9CF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C47580DD6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Gtx1J0g82Je for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:16:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 78DE180C7A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791821804;
 b=iGnM0HM+AH4vNV2SgTUuY9MSXkD18kxsB3ErvSfWgnwOyxohCSG1lNXB43aUkynGp5r8
 oPeF+Olomh4N/h25NH+ucObxNvKDuxTBuF5ztiiZhIud2zW++xqXHrwHIH6DG9cCPOaKZ
 bFa8Dw+yltQcOnW8GfsSxnsCY1mrHFjZWGofyJW9Gm4y/e2NmG6fEuuIZe5umOAkX+YCd
 Dm5Dq+dGYu2xQopyTAzcYvKx4tKJsFvH7XtCGbxLQxmJadVYq8q1dKwbcDb18ekfmHMPg
 nLJZlx1FXLdy7JHEhsrLCcEcDN5EUC/4hAaNQdRTXCmJxFLWZ4iNIdZFmjk/fXzyf9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821804;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Infomaniak-Routing;
 bh=IJqDmA1+sQH02fXZyJoKO8ASm2d78a6KPeZ6fRpPiRo=;
 b=KX5iqNbgDrs10h5n3BMHT3FDCoJFtCvodkfTjtB0e8AKuIJ/MtXzhvqfnXaUzYj4f32y
 e5NbI0+pLyXFOwH4BegTudxwWV4JSk2izq5S/s5G+FC7cd1lRRe8zD0yhrmCJkJI6+b+Q
 gAGuqh+s5VoX+Ckxq0DryUvrHVG/E2ekvR8hCOmxXTF4FCFgmKFT1qGsNgWfS4lOooiuD
 Il8BJ/EGstNvYcb+3Fc5D9xDryDxEpdWMexTLFCOOpRajIDusZmk92fzR/rqvan8lzuhX
 L0WQrPOs4U0AXNUMTTiBAics70ngWW2p6b6FuwWlAd8xYIrNnSlvXJOdRTWluoYRgcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=NwDDxoqq; 
 arc=none smtp.remote-ip="2001:1600:19:5550::190c"
X-Greylist: delayed 324 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 12 Oct 2026 16:16:43 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=NwDDxoqq
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:5550::190c; helo=smtp-190c.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:19:5550::190c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78DE180C7A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:16:42 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j3MzX1p6GzmYq;
 Mon, 12 Oct 2026 18:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791821800;
 bh=IJqDmA1+sQH02fXZyJoKO8ASm2d78a6KPeZ6fRpPiRo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NwDDxoqqwLvCJVSaI5Nb0bCIo2i5mBY0nWoSt6B7cFgKyVSBn1mQBXqxnhvCOLpmF
 QzWbFdHKCgJnX2I8/C6cB9+LOqsiWW+6k+3JOTlrJtif3E280L5H4AeUg+1Nis96Bt
 p0u2kugDfE+4Rhh4ERNO5h82f8M9GTyvghNvzmnHvaDQSsOpfjp0/GTOjuTcGEbjRU
 LY3eZSsT+J4RIuFcWq8FetOJa4vuVWg9MuSkWDvBr8Fz8pvVg58YRvkvOlOFU1dq/W
 feomBg0xp+srLSsCmcJwKmHP+GRM3fDijlD6tu+z+1E+oMnXtOK3ZCc9oWNtMB6ROc
 DrYWKP36mjNNQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j3MzW0XSCzZ9r; Mon, 12 Oct 2026 18:16:38 +0200 (CEST)
Message-ID: <e7d919d0-c6e5-488c-8728-5607aefdbeb6@0leil.net>
Date: Mon, 12 Oct 2026 18:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] rockchip: rk3588: Remove unused rockchip_get_clk()
 helper
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-8-jonas@kwiboo.se>
 <af324bde-f2a8-4425-8d57-944ae5567c84@0leil.net>
 <27039afb-0ef4-4cb0-b752-d5083d3cfd14@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <27039afb-0ef4-4cb0-b752-d5083d3cfd14@kwiboo.se>
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

Hi Jonas,

On 10/11/26 12:55 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/9/2026 11:55 AM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 8/4/26 11:44 PM, Jonas Karlman wrote:
>>> The rockchip_get_clk() helper is typically used by SDRAM init code of
>>> older SoC generations or to help get the CRU base address from the clock
>>> driver private data.
>>>
>>> RK3588 has no uses for the rockchip_get_clk() helper, let's drop it.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/rk3588/clk_rk3588.c | 8 +-------
>>>    1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>> index 9b112e45f1de..272d28e973b3 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>> +++ b/arch/arm/mach-rockchip/rk3588/clk_rk3588.c
>>> @@ -3,15 +3,9 @@
>>>     * (C) Copyright 2020 Rockchip Electronics Co., Ltd.
>>>     */
>>>    
>>> -#include <dm.h>
>>> +#include <linux/kernel.h>
>>
>> Why do we need this included now?
> 
> It seems to be needed due to use of check_member() in the CRU header.
> Will make a note of it in the commit message for v2.
> 

Please instead fix the CRU header so it lists what it needs in its own 
include file (separate commit prior to removing the unused function 
please), otherwise we'll need all includers of the CRU header also 
include this.

Cheers,
Quentin
