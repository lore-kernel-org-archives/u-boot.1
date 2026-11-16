Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E7606A887
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZHeIfziV;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=D2w2lsMH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D18D98098B;
	Mon, 16 Nov 2026 17:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cdIk8uaShN4g; Mon, 16 Nov 2026 17:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E75BF80FAF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794848589;
	b=BfR+Finh1eoydD2ij/H5w0XBDoqOM1LTd7Zv3kCZiaEb+Pad3Hs7lmjjUiA3LdGyb4Ds
	 KjrDYJkZqVsXfKZ+cSbIUzCWyf40mAiZ01p7s7jGZ0C8CH08gUjqvA5589ddLW4rQ1PU8
	 yX6j/lIgxqFP5kNY+I6BuvsHAX1fb7XrmuIZ6D+mifeOqBgrTIpSW09uXMLhFQ3fNAZre
	 W6wVBpdULTdZpXcxgrJaow8g9E73Ma9HWKuEGtijF6w3UI59Agf/Gu09+VXLJ2qIKUcm/
	 aHajDX+X7D24yIRxwgT8WTVj9TFLMZzjGo5gtP++5mm8TkReyTTOsDB2eDuKuCi7z6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794848589;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g5QFonngtOlHfMy+UqmfSf0DJ652k5i4E4aYhNdPS3k=;
	b=lpeny1gjJxxMGRKVuJ8YkiSysohLAovYnoaZFL/dtvp+QPUSEd+xqSqScALSwgT5OP6N
	 Y400RdA5qdMSsmpMJobDyRoEjqPvhxJyPF3hewGOU1t7/EbgJUXxULk6feDaKJvOWhQjw
	 wXVME0LR0px7It2YjJZIzuwFz6TqRME3tcNbNJgEYO+G21PtFSdbIAKhvnz9RGVL26IGY
	 CDRiuqnGjGI2R/PJxwzmG8CjltQ1k45k+jQlpXcYTd+Dc9mpMyd/CD/p7p/mGqVVgmSQy
	 kn/7AhJOW9ONb+rNBuDw0dxqJNVAIXQBCBTusSIl9Fr1ju31rRqzhzfZ1nCUFKJYXjw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794848589;
	bh=g5QFonngtOlHfMy+UqmfSf0DJ652k5i4E4aYhNdPS3k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHeIfziVkYTfbVVjKPqb0AhRlHXs3+7zl2Gv1br/l5++jAgPughJ/tW0RAH4ecbku
	 xecZ576yRzYCBaum+FbWM7ZXWG+fr1ZDwywm2UvsxTwiDQDGZ/ZPLiUeTsyDDZc44w
	 mXvdaE0ai2UzbYBnIGt+ZnCFH3M0rWSr28ZLZr4sKSmkiyCRVCdQit1QejDLCxpG81
	 5WFEsTvIk+fZijZ2+POGLA6aV3YyhfQlp87O2DBR73NaC26vtXM4eQSPka5mNieREO
	 nPtzRnO8i9RE18bIuZu6wU18wLegoLXt9y/6UFN2FFEbwsU5Syydxof2PVJCRGLIdx
	 rLapbP1IF85GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E75BF80FAF;
	Mon, 16 Nov 2026 17:03:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DE041E7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C1BE405CC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fc7LiGUhiuKB for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:03:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A9FE405C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=45.157.188.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.11;
 helo=smtp-bc0b.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=D2w2lsMH
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A9FE405C6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:03:05 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvLv4qSQz2rMH
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794848583;
 bh=g5QFonngtOlHfMy+UqmfSf0DJ652k5i4E4aYhNdPS3k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D2w2lsMHq/PIGNkQ4sg3grmQGmbc6u8XGAHRiqrmj3q8DkTDb0UzgExhb8avVhtyY
 dWFwX5v8Ay5KsweCBSgCopFfGYxUr69OVx6arQA3Q7pRZ3aYau3vg7BMjHHpt3fDH3
 shhOM0eL0DCA8JvJNSc55jHiGN2azlhYQGND0IvTeZMkrj5l9uELmzipIP+k5Vm1BR
 gw4Y8SNg48jBiDdLBuN3gcklaY8LljWiCVJYqZI3k+bKdcKbLozwO/G3N/YTtZIdJc
 MywLacB7P3IavozYFxssVFKfWkvxfWwnIrnHPsEwIQphyq3OEgCi8lAqEvgvzm6DcH
 4/1aBeHQ+Knkw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSvLt5mVfzN9g; Mon, 16 Nov 2026 18:03:02 +0100 (CET)
Message-ID: <6cafd716-42c4-460f-acbd-2ee94100425c@0leil.net>
Date: Mon, 16 Nov 2026 18:03:02 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] rockchip: Miscellaneous RK3588 clock fixes
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261111231251.160051-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261111231251.160051-1-jonas@kwiboo.se>
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> This series fixes a few issues found in Rockchip RK3588 clock driver while
> working on a cleanup and refactoring series for RK35xx clock drivers.
> 
> Any refactoring has been held back for a future follow-up series.
> 
> Changes in v3:
> - Split the series into smaller series
> 
> Changes in v2:
> - Split "rk3588: Fix trivial clock configuration errors"
> - Update commit message
> - Add fixes tag
> - Collect r-b tags
> 
> Jonas Karlman (8):
>    clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
>    clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
>    clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
>    clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
>    clk: rockchip: rk3588: Remove redundant PLL register macros
>    clk: rockchip: rk3588: Rename PPLL register macro
>    clk: rockchip: rk3588: Align BxPLL entries in PLL table
>    clk: rockchip: rk3588: Use SPLL_HZ constant
> 
>   .../include/asm/arch-rockchip/cru_rk3588.h    |  5 +---
>   drivers/clk/rockchip/clk_rk3588.c             | 28 +++++++++----------
>   2 files changed, 14 insertions(+), 19 deletions(-)
> 

Applied to 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip 
(u-boot-rockchip-2027.04), thanks!

[1/8] clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3d65de11dc776409756fce5579c06a9cefb3ce58
[2/8] clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/4de7270740e042d7c27aacb9f12b3d16280574bb
[3/8] clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/4139c4e2950dc2f3c5269f2d604f2420999f9ba8
[4/8] clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/264835487a0c2dc21b61404b0bd1b0f89514927f
[5/8] clk: rockchip: rk3588: Remove redundant PLL register macros
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/dbd9ed3b8a328348d07df9a31c5e68ae32ef3faf
[6/8] clk: rockchip: rk3588: Rename PPLL register macro
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3dfc400ab7d91bf05a30d72db0974431a781290e
[7/8] clk: rockchip: rk3588: Align BxPLL entries in PLL table
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/0f8b254f8197987b774120ea244ed36f047c5799
[8/8] clk: rockchip: rk3588: Use SPLL_HZ constant
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/aa2b49798946f97dff8b5bb989ed50314deb18fc

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>
