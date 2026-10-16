Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D57CCA490
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 23:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EB0B60A45;
	Fri, 16 Oct 2026 23:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ULGMBjFL7dw4; Fri, 16 Oct 2026 23:53:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 67ACB60A93
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792194800;
	b=ZoeyKw07cREs7FtZvxM2ozXQINsRKtl85JdpsHBvIHGb8EjetfHmkhQdw3+VewUNkhMU
	 aKD865tIOZq/OKGm3AkVzjpXsn6SkobRC06PYwuvaZ5xLOC6az1W1KXMWxRNa0xUaxWJd
	 2Uf/ioQ59OA5Inp5AueCVpf+XIU+fuYL6nNBh6PnGg8aX3hOPz0uMTzs8QKub8H0U2e9G
	 tM4PTH1y0/TsZR42QQyZ8LMnVnxzrgoQa+kcQvnIzo/JqJBFJV9I5/p4PrhPv9QWyFZUY
	 hdcyvnnZzak92S5Urenbo8Pe3A6hDK1BFDOLFgOGQF6Mo+vv/mAdw/SXNkVMgIcVmvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792194800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XUSxUpd8n6fmAY/xRulOVvXKLAkCLp1uLumhVzLVLd0=;
	b=ivDMi7/x2NAizaNyP4r2WwEx8J3zp8DUrYT2q11gixEV+DlEIO766bRlmkBY3uNbugXt
	 A7z4EGP08HNsBTECf7WJLDNfOs2bgHYk6GS3UtOPDj8VbHTda2eJZIZuQpFa9XBHMlBfB
	 zN67VaRJhjHV3sg5w9nwb013r3Va5hwDVpzRV38a8QhXL/lW8CsFkJmNxe7JkJxTK+v8Z
	 6vzq2syixMSfLu9c+8FUWOq9wn0AxI+vZG/2Sj4bkd3R2McK6ffZGHfv9CEa8Alhvi29d
	 kLpnUOHVDRv5KSATAa4EIp2x0n8FiztHVxm1EibJn9ufqFXOTckOvkpdJNAyjc+UyDw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792194800;
	bh=XUSxUpd8n6fmAY/xRulOVvXKLAkCLp1uLumhVzLVLd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSVHXPzln47yYM/EPmaI2czmRPgMTasF8ATll/t5a8GY77Mm/1ZphIr6ScS+lDUl6
	 wdGvcaqtdAsP6puRM0HVf5iuufMK1jnY5WSNVWvy2dYgZ39IAQl1n6B433MV5TkQ7w
	 jIdfq2r446mBNn33Q2xFTNjMMwkfzKwxEScauSqnbfRoJH0P62vuQIXqFxSfaFXTSJ
	 Qlj/QIHLGq1dq5SbE8ZjDB/O2heIUmuoHubo02qSMQX6P9MEM+uDqPWuUn8I2kNamO
	 TQk7/+yVEKAYYpY5UP2kfjUwfvo9BEPewdntJcuYrPT7tet9CXFLn4t05NNVwxm8+u
	 dJoXdkgbL1FNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67ACB60A93;
	Fri, 16 Oct 2026 23:53:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A58CC75
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 97B0D408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:53:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJbcBhJmm25B for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 23:53:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C4BC040004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792194798;
 b=sQoojO7aj4aF5NSdW3xleJi//lY/LS9zY0Gt1bx0mSYQEbghmtWR4xT4QQij7zK1cdQT
 RQFZrVCGKQt+1ZRVji7iJVEMwBwJs1kvZzAAxZrc6jCrwuvG58yP7VrtnDm+LayPpDM+7
 1blMgvTFlOV6eXIM48rnaq8371QtrRLTwIMjk0JlicfnIKvdfI8KfORjc9fxCukHkH3Ad
 V6KJBAJjWzAhrOlaVCbhoXGmcu0if2nVw9dA8Fy21yuzNwu9gb8M1WqUjhpiO2YiFKr4G
 E+5/1l1zYOexl8Zwh3k1yXFOhb/rQvf2DQujQYwy7Tw2Q5TfI3a5eSH8CeFQ8Oa45jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792194798;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=XUSxUpd8n6fmAY/xRulOVvXKLAkCLp1uLumhVzLVLd0=;
 b=e4HF73Ef5BirlibE0oUS0jVfU6LomFtSZVKwSgPFdzcjsx8MDclA1ZCY75cBzWjGWJLH
 OUVRLluxzMiehqiYLRQ0inX2FBTZb/Lk6Y574ZfhU9L83atoubrH8qK9cCMu1xn3i2Q5w
 XR236t6GgFqTDhA8TGtS2X0YE9zurCwjQpt5wFdO4mj9UdOcGqG5mX79aRTLWuEAAiJ8b
 UV/cmOcs5ia793Lmi9fJ91NCzOu+15huX8oPdj0x1htkJnsOzCVXssn7mcZRDOkQKAXpV
 dJwV4grKwxmCdAW3n35CsgKPjpZqIWZcvmlCN7Ld2CHbd4vYEoDlrdWsV6aonQXDFpg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=LUWMV2UA; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=LUWMV2UA
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C4BC040004
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792194764;
 bh=XUSxUpd8n6fmAY/xRulOVvXKLAkCLp1uLumhVzLVLd0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LUWMV2UA5qBRpDNQ/NL382IWip968WxcZNCOIlyqiguJjQAjDrstgbrUMPC5S12C4
 xEnKpJniXXk+eIpbzsTsCmLU/dgGAisC38tj1urxwOc/4a9CjJwywdPvMQZOYpNK4o
 sGEVI5dhuwyZFe7OJzHA7/toP0BmK5O0mdB+eY0WEcxxnrcUsjD6ky7detqG/hsFBc
 BTDBbGMwzvlkNFr3hWAvaMc4f+UXCT8HYB5rgYyFkuyTxgJYlAPqjuAUYLWeR9p1KF
 s2/BfWPl2Kb0R2YLvyQbGazOWg4WeGYy+zQPrnkAyrFSe+E9qpRBNsAWXN+Ffodnts
 d29fY3BqlI63w==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 9123CB2216DC;
 Sat, 17 Oct 2026 01:52:40 +0200 (CEST)
Message-ID: <63988a80-e07a-465b-bc84-90a201574ac1@freeshell.de>
Date: Fri, 16 Oct 2026 16:52:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: sophgo: cv1800b: Add SG2000 compatible string
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, u-boot@lists.u-boot-project.org,
 Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>,
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>,
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Michal Simek <michal.simek@amd.com>,
 Yixun Lan <dlan@kernel.org>, Andrei Lalaev <andrey.lalaev@gmail.com>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
 <20261016-upstream-v1-milk-duo-s-v1-3-e4bf386eea2d@gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-3-e4bf386eea2d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/16/26 12:52, João Paulo Gonçalves wrote:
> The upstream SG2000 devicetree (sg2000.dtsi) uses "sophgo,sg2000-clk" as
> the clock controller compatible string. The clocks needed by U-Boot are
> the same as on the CV1800, so the existing driver can be reused.
> 
> Add "sophgo,sg2000-clk" to the driver match table.
> 
> Signed-off-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> ---
>  drivers/clk/sophgo/clk-cv1800b.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/sophgo/clk-cv1800b.c b/drivers/clk/sophgo/clk-cv1800b.c
> index 248a69321fc1..93d71ad1c314 100644
> --- a/drivers/clk/sophgo/clk-cv1800b.c
> +++ b/drivers/clk/sophgo/clk-cv1800b.c
> @@ -744,6 +744,7 @@ const struct clk_ops cv1800b_clk_ops = {
>  
>  static const struct udevice_id cv1800b_clk_of_match[] = {
>  	{ .compatible = "sophgo,cv1800-clk" },
> +	{ .compatible = "sophgo,sg2000-clk" },
>  	{ },
>  };
>  
> 

Reviewed-by: E Shattow <e@freeshell.de>
