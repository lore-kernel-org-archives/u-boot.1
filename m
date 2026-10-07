Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F04FCA5FFF
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 09:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40CD405A5;
	Wed,  7 Oct 2026 09:36:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1gwbZbr63QDi; Wed,  7 Oct 2026 09:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 263BB405D1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791365809;
	b=WlBqmsVs4hLV3NDb0TrFX/tWi1R1EPAfym+rgFS3+fCX4P+qMf/5fEpMW0/rjxE3sGXk
	 7TZ0q9khbxR49L11BR7jezNOlJRFHn6lee3t0sj/Wvl42gAMoJgsrLuxXGbddTzZx7o4M
	 4qCR65ejhjjW2OQMCa9SuQY2obNy+2qslutoLlrTUR8AI+dEuygU4omciXQSszTY+aF7d
	 0aoxVTJc0slVv1zLlns6+t4J4bg+QISGhgae0l1fHKbMWntaDgRGm5OYAs6WHj6PKZTKA
	 Whm7Jm4u6ZQr5bVfoCcPr15+dOB4t8yktkvyzt44dNEgswj5FMxwkeQ8UjNpOLp9f8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791365809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nx4BSnQh05oo5ZGU1CkIRTp4bDe4NnZqsSUeNy1DZ+Y=;
	b=dkvq7nxdI07Au7e6E9QVLkxRleBaMo52zrOddj8JSGhQu7ITm1lHFIAYfkSlYChgx3Ud
	 fBYnLcN2c8NTvQwAWjetNLmFTa3hCLdlY+3FemxBet37adfoG0kkEy6BebwH0moTUBJkx
	 pMEbtjpH9nolOSQ78Kda3IxWUC+1yDQ8Rwx5ixWoAt1BOWwky+vbrgbTZk9v2uotW2xah
	 6L6dbAQM42D/D3mRa4CSrr65RM8l/IFTy0NZXZQl4pQn10RTR7741E1IfEFFEcirRAOkS
	 mL+9uyDS3FBeldgYSksY5kzpJXQ4DotIfpiyJT8f/wuwqhwYrskijWx++PGQ/7pmybQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791365809;
	bh=nx4BSnQh05oo5ZGU1CkIRTp4bDe4NnZqsSUeNy1DZ+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WGHuiz635PcabxUjHGUDHvhmjFNxaQ25kAKBFEdAupQspUY7GLox+dZtG8mKl+ZEN
	 oUp/R8ecXGGvcCTtraN7JVJYy0h88x5imouVmRDRuc/bweuxv+/9vNPmYIezh3U0xQ
	 dxVwB3Z2jZTowaf16KBiwmCcDp3AvM3qlWjm+j9gtja5X76ChBSxj7jBEodrF3mMYa
	 ME0mtEeXlOEnUrAgnw8Ae2/mBC2yU9+AIS3gKrLME3qnbVfx3yMSLvuJPVwpJTyHxp
	 hSekC+c1FFRJ5K/WfrORmQ7kp/uWyWzq5K/tU93lbodpU+yRvr5Yb96xttEwMbxf9p
	 zj3sZ6FKBL1yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 263BB405D1;
	Wed,  7 Oct 2026 09:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21EB4317
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07E2040080
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:35:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lF0ith3XhxSA for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 09:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 80ABE40210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791365720;
 b=EAfuriZpCP9Yc4Oyb1wL/fkInPoeGIJDIn9fyvEAhC4Q7voN2xdl/DknXTVMl59lbCg6
 PVy5YaE79gkj75pC4WgDmDSYY0Apv9R0ocljswMRY/73ocTqPBqBuo7yH2SqdcwStHzE3
 CN/LHhyDn3REvxVJjGD1z7T2SZ93JOm9jc5RQ0ssJbeDKGtG6mfdbeu3oOuCZ3c4DLeUv
 wBCXIXBiOuQHvL7SrLy9tQHm9ftsXnVYF3RWUc4SX5bXAb+pmpzrDq6OMFgsr1vN1tJ2+
 tBOv7mWa55YIbpMpNY1OmsE1umgEej1b80tVN32SOSnPdOwUYOhIIj53+ZhIqCtL3Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791365720;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=nx4BSnQh05oo5ZGU1CkIRTp4bDe4NnZqsSUeNy1DZ+Y=;
 b=fhtxUA4RZMuPuJ0NwI56VwPLnwrB5Ffkuqo9s9UdG2hinUePIvX7g1D8nzVe5XeRd63x
 z2+mlZZO+kGIQG4AT8cLWQ0ftuzTLx0+xCDtaJuBYh5V2NFXCZSKozkv0NzKfDbESQnIL
 0JZz0Qjh7IrbnWRcEqsvyTR04h3YaUkd8Zt01lVNWxe2oBQgKvYLhJKoPFbvz20U4dBvx
 QCEjkzNQj0I6HQ8Uv1viuTFMLU+ZXz613gGv/kaEXmarNmCeJPkm4KAK3b8ICz4yhh3TJ
 pynS3jVKLCNkHb2Bck6wjfjZ6usMNNYZiwR+Lps9S/cX5G9nD19MHES9BYHVIoI94rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=g8549FOz; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=g8549FOz
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80ABE40210
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 09:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1791365656;
 bh=nx4BSnQh05oo5ZGU1CkIRTp4bDe4NnZqsSUeNy1DZ+Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=g8549FOz4DwFj/G9ThXOz3Eoh4c+2V+gx4U6tHZUKUX/yDZxXl+lwSfut3bEeX2iO
 HiL1WEHqGcHS5V3gsytQwCjeJS3tE3sqoFWR23S7zePazsbs33dN+ZC6+mYIb6srAC
 y5x3TfHkqhBPRonSAi1mK6Od3nfZnntfGtmMwLG8/C2QdkuZdL2NDjde9jSveRhTxT
 1E4LI0xeYGrdXyMQUUvbDrgKyM7jiw0XZTWF8rnEageY+8aTfcQLFWbOjNmx2/uNBa
 FHlRUYWWly+k3idq+xoZVId3eLx5rMsRPJG2FV3xAwTa2AgVmxdgl3jkbqnt0mE4e8
 CYkN+uESqWNew==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id D0176B220CC4;
 Wed,  7 Oct 2026 11:34:13 +0200 (CEST)
Message-ID: <0ca9ef8b-67d1-40f2-b4ad-c9b53bce7019@freeshell.de>
Date: Wed, 7 Oct 2026 02:34:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] spacemit: k3: add clock and reset support
To: Yixun Lan <dlan@kernel.org>, u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Raymond Mao
 <raymond.mao@riscstar.com>, Guodong Xu <guodong.xu@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@flipper.net>
References: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260923-01-k3-clock-reset-support-v2-0-6ec0abb1c7b5@kernel.org>
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

On 9/23/26 02:34, Yixun Lan wrote:
> This series try to add clock and reset driver support for SpacemiT K3 SoC,
> the patches are largely based on upstream linux framework.
> 
> The reset BITs definition lives in the same register with clock
> controller which make them tight coupled, so I'm also putting reset
> patches in this series.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v2:
> - add complete PLL clock tables
> - drop patch for SPL
> - Link to v1: https://patch.msgid.link/20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org
> 
> ---
> Yixun Lan (8):
>       clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
>       clk: spacemit: ccu_mix: add inverted enable gate clock
>       clk: spacemit: ccu_pll: add plla type clock
>       clk: spacemit: k3: extract common header
>       clk: spacemit: k3: add the clock tree
>       clk: spacemit: k3: add CPU PLL rate tables
>       reset: spacemit: Extract common K1 reset code
>       reset: spacemit: Add SpacemiT K3 reset driver
> 
>  drivers/clk/spacemit/Kconfig                   |    9 +
>  drivers/clk/spacemit/Makefile                  |    1 +
>  drivers/clk/spacemit/clk-k3.c                  | 2049 ++++++++++++++++++++++++
>  drivers/clk/spacemit/clk_common.h              |    1 +
>  drivers/clk/spacemit/clk_mix.c                 |    9 +-
>  drivers/clk/spacemit/clk_mix.h                 |   27 +-
>  drivers/clk/spacemit/clk_pll.c                 |  124 +-
>  drivers/clk/spacemit/clk_pll.h                 |   43 +-
>  drivers/reset/Kconfig                          |    1 +
>  drivers/reset/Makefile                         |    2 +-
>  drivers/reset/spacemit/Kconfig                 |   22 +
>  drivers/reset/spacemit/Makefile                |    4 +-
>  drivers/reset/spacemit/reset-spacemit-common.c |   93 ++
>  drivers/reset/spacemit/reset-spacemit-common.h |   40 +
>  drivers/reset/spacemit/reset-spacemit-k1.c     |  128 +-
>  drivers/reset/spacemit/reset-spacemit-k3.c     |  242 +++
>  include/soc/spacemit/k3-reset.h                |   21 +
>  include/soc/spacemit/k3-syscon.h               |  271 ++++
>  18 files changed, 2955 insertions(+), 132 deletions(-)
> ---
> base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
> change-id: 20260824-01-k3-clock-reset-support-815a0045526a
> 
> Best regards,
> --  
> Yixun Lan <dlan@kernel.org>
> 

For the series,

Acked-by: E Shattow <e@freeshell.de>
