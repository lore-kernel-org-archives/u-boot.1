Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4C606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F45K3c5b;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=hYXssjiU
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2A16409F7;
	Thu, 26 Nov 2026 18:30:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qC2Grw3JkOpG; Thu, 26 Nov 2026 18:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4986409F0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795717815;
	b=rj/xhaX9y7FMMgmqxZ2lBr4/RQWoHQGnbi90MxO4e1PsJtqduok24m7PGmz3mIXsFBTb
	 hu5C+AsRVft+PoIID0RqUSRM8yYv2wt+J4OnYUm+vvlVM6gxjbh9eLDbeD4VRK4kKxbVM
	 m6+RTgqy/akcjvxlJzO1LUDTEAQxuPycQwltKeiDjVV4fjiT4UibavSC8aQQRa6deQVO9
	 j746xynjW7C6+6b3SaBwuVFxzrjbneFqYWg8+BaiEx6gNQQdScf7i2OjheQM1xg7K+Low
	 yrf94xpx8SX4LeZXupP3XFHCKT9Hw7X08nVE9z7vskJCXuE2ey5AiQTGvjxYh0KwYjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795717815;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o9CWzv14vV302eNW4HP2ICsafmRYzIr4TD9GKXVKljo=;
	b=Nbhm/DApsEZAivGUP3f3RcHFXVcfesssV16VxQ32dxXwf3eezUe5qQ/zHThbmQOm7BIC
	 wzB4K4i9vmrlez7bPY7Ync2E+xBgbkwyAInNMHydXILizW30oDIS6bAmcRCCl0jXQ1Xky
	 BlFsPbsEz2lpRV2eLAMPuvrRJLPbtDIyukX3j+0SLE98rvKo24A25yBGypvjRz5XufKRP
	 3mFNZ7jLkYnfCa4y4YABFwcKyhm0y7m2wCTmzcAGaYNFukAWygr+dxNjrpuimlhHh2thg
	 IMc/doXSCzH5UCoMpS3ewDz47kRf3sU2WKHYD2g/ew/BbwhVTo3+z99IcP/FzPMjyqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795717815;
	bh=o9CWzv14vV302eNW4HP2ICsafmRYzIr4TD9GKXVKljo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F45K3c5bE6L84CPXsiqhxNHZ0hkCx7A6jKY3nIFynLMfzSmX1d2yxHed5xdbOlMoo
	 DJUKVY3BGWZ9gVTK7Qnc06ILxtkQmX4zYLe9NphiNTAhJUpzgCIId0YQT5fmyJ/pJI
	 SCCnB/rRtxi4R8NWHfePGFzP99VRnYxYulq37q07b9wp2vowQDVrXDxdpL5ekYewlY
	 0MVcj6nnLr2gjFALmhDWs7rolxQmNS0VP0KyZLT3oz0dTvKDNqnQBFuBEyw+JLnrPF
	 uw6RqJK6CjIMCiiLWY8dtYj6BYlbE02KqYbfdLvmi7TZilJABuBkIffwcc/EZiUY7M
	 npO03MQVOIl3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4986409F0;
	Thu, 26 Nov 2026 18:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78BC132D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E151811AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFsNzydPyyci for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 18:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B62F9811B2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:fff0::bc0f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::bc0f; helo=smtp-bc0f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=hYXssjiU
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::bc0f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B62F9811B2
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 18:30:11 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000 (Postfix) with ESMTPS id 4jb4pm5tRfzqSf;
 Thu, 26 Nov 2026 19:30:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1795717808;
 bh=o9CWzv14vV302eNW4HP2ICsafmRYzIr4TD9GKXVKljo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hYXssjiUPG3V6csqkYfDg6Wt5BkYKRQO+LemUx/8B9WF/SSF7A24Rg8nau4WL0owX
 xZtLLu2pPAB9qimCvJ1p8RbfL2Fpe86YTXyvGGQFZiebnzklgnSXa0SDUL8ZKI6xMN
 z5TYWct1axWr7o5AzI6Mfmg7xw68MHAhZYzgDDzy36sEphahc0EPpOsspBraSwNXdw
 vwcki5izOUJ4IkPGHCIlU2JUBFes+T79dKR8JMmtJWJ3Fy/qXHmvz/btSRLG2hp7X9
 sfawRMd7dDvtZYFBmDTDU9NiS+TXqqGyevxRe1YxlYCfKHPh9sGbV/fX1wEvd1Vei9
 DXegYN/DX4wzA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jb4pl40nGzXpN; 
 Thu, 26 Nov 2026 19:30:07 +0100 (CET)
Message-ID: <d979fd41-f31e-4dfa-81cc-896af3167dcb@0leil.net>
Date: Thu, 26 Nov 2026 19:30:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk356x: Set twice the SD/SDIO card clock
To: Igor Velkov <iav@iav.lv>, Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.u-boot-project.org
References: <20261110-rk3568-sdmmc-clk-v1-1-482eeb42f571@iav.lv>
 <672d8b9e-079e-4705-bbb3-e26a3983195f@kwiboo.se>
 <20261111-re-jonas-rk356x-sdmmc-clk@iav.lv>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261111-re-jonas-rk356x-sdmmc-clk@iav.lv>
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

Hi Igor,

On 11/11/26 1:39 AM, Igor Velkov wrote:
> Hi Jonas,
> 
> On 11/10/2026 6:29 PM, Jonas Karlman wrote:
>> Please instead fix the U-Boot rockchip dw_mmc driver to do something similar
>> and move current 2x handling from rk3399 and rk3328 clock drivers.
> 
> The 2x is in 13 clock drivers: rk3066, rk3188, rk322x, rk3288, rk3328,
> px30, rk3308, rk3399, rv1126, rk3036 and rv1108 (eMMC only), rk3128 and
> rk3368 (dead: set_rate lacks the SCLK_* ids the DT passes). rk3506,
> rk3528, rk3568, rk3576 and rk3588 don't double. rk3066/rk3188 are
> rk2928-dw-mshc, which Linux does not halve. Moving the 2x into
> rockchip_dw_mmc touches all 13 at once; I can test rk3328, rk3399 and
> rk3568 only. Is one series on that basis acceptable, rest compile-tested?
> 

Jonas and I have boards we can test this on, so I would prefer to go 
with the cleaner solution, provided there's one. Otherwise we'll forever 
make the same mistake for each new SoC using the same IP/compatible. A 
single commit to change all clock drivers and the dw_mmc driver to use 
the divider is the way to go, for bisectability.

Please note that this applies to *all* MMC controllers matched by the 
compatible, and there's usually more than simply SDMMC (eMMC/SDIO/SD). 
The * RK3288_CLKGEN_DIV seems to also be applicable to MMC with bus 
width 8 and DDR52 (see implementation in U-Boot and Linux).

Cheers,
Quentin
