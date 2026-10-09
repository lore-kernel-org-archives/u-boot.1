Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC223CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 10:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40C5F8137D;
	Fri,  9 Oct 2026 10:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAuM3E2kHK3j; Fri,  9 Oct 2026 10:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6580181488
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791540325;
	b=OBLhR58RgaYCkh0WxJ5d98hsUq2xw+AQjz3ATpF7yVHzxNDvsn3VC4Z18PAb1SNub/MI
	 Gh8JrmMPbMScQ4Ivuoh4ctfpO6PcOYi/zKvsTC46MldA9TJQ5X+Dmni0+ygBBaORbYlDs
	 b7lASqACAsImuiXiVZ3paWNbw9M4CfPKFw+rXDcdtnkuaYn2HJbe3Zvy8KMSeXqDAFXKR
	 1LHvo7hCk0n7qz5YWweaxfg9vOqe+GYR9Ton3HWt/c59EVcQh0sZFap+bnLJ29+7GIyMt
	 FjEVn3vsIgxVBg7bJ2Y4Nb/E6rG+EY3JPKHshMYy9OsnUyzvJb1R9pxG2yrcFXPWyQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791540325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+LvkKjvqlBfFPW0vdz1paxPj54RAh0r7XFmMrQthKeY=;
	b=f9vXe9SVrg8TaVgOy7dZ9O2InRRPlePPxW2+YptK+yd6/YkQ2uAQc7FukY8X0bv0iP67
	 jguXgy7Y8kmEIN7Oq3x7XIqoeJigfHqxleXZoLKnx+RK0SBUzgYJsGTEJJqmn5UOgHF/G
	 VKWd0M9PVLp91+1ynRn5r0+JDwlEiozlNq7edz0I9hlvH6A7GaPUSMUzKtrSGV0mjs3Im
	 nhSZQ/fvo5FN4nFALu8AALJfWFqQn9ViKlgIZ8vYs/7gB13D/EW0c4T+0BGCmB6XOYfOe
	 6zp55ov2DVkwoF2LufhgA5qBO/mq0Eh5BeMj96EGxbI460D0RrMJ74gapdSDFZP0H+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791540325;
	bh=+LvkKjvqlBfFPW0vdz1paxPj54RAh0r7XFmMrQthKeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zS50ZoHxdo+TMxEvJ1UskgsKlUxbDNEHyHAIok6zr4FGirI054sv8Zof8Jq6Kdvd+
	 9YHUPo2/jKh/+5bSrH6ny35yE3dnYxOStjKio51l/3yp9xfOf9rfEdWRf3eN4T0eA6
	 iatznsgdSlnxj+H/2H5QvtrKTuLW95xh/kEhE0QesKuJWseJySovS+i3Nlsk+MsE1N
	 7BCGHso8eo/XK2r+PXJb3LBE1DH+kvhdCpO9QcFtZb+4GD4ivyCEoHXK/e9mxKLmC6
	 vMNTPF+o01w5/mJE6TZNgDbxJ9lUxwLqCPAM02b7ozRjLlle5V+HZ4wppMswaOTMHn
	 DNKxs7xHVsXoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6580181488;
	Fri,  9 Oct 2026 10:05:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BCC7E422
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2FFC408F4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:05:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNBMA_wmGg7W for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 10:05:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A640740891
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::bc0b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791540322;
 b=IBMiri7wI7E0CxNqGc/al/9uwdoe5HpQJJLSVAw2p6jjwJ6Ab84+w6P64+Yc0PA9Wsql
 dyMwEVlYsoAk0f3awxlor5xprPLJrG/8kd6tSUDpnNzck6NBsOrJCymGzfhOxccoTAha8
 LoErGT3rc+6zKcjV6LVFozE4O5A0BEHRz9oxQWgGCBOJwIk5qFk3LBME16r740T5FvZ6J
 YIaRnJkC3QEVwWOah6qMXiRyIi22pj44h8cq1Mp7qqOLMtSNMjVZd7HYbnanLTLCdvzTk
 9aPfmlDKs3XUedAqsFdlH+m6VqGvXoyk9BWuge+vI1DfCOrNficZp9Vx1xWRyoMHFVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791540322;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=+LvkKjvqlBfFPW0vdz1paxPj54RAh0r7XFmMrQthKeY=;
 b=LpBP4x3zOCT02HWEH0+lndpWQ7An7PeN+GgQ+ATuHDyNRuuLn2dHSEOKYVrKWpSKUSCP
 ECrKsg4a5XQPTY40+DSrWWKtZLZT7F7TxoxW8HGlFuBgiDLYfEBlqk2kfBWubQaGcA4aK
 fVeOytX1w+TtErV5214UcCL0tJMLiIX9XlQjSUdLt7qfawtPOZJBcdVn2PSRjvRfeQHba
 s5ow8c45s13pVOyaL+FtUANoB1U/le0S2fOdmzQhLQKG9joLnFY90JJ8aM1Ea9jsHRtkk
 z3J3y7jSDVbIdn0p3s23REof9FXjBJX0B2PBfFZWJsRKaAsnNl/GzBjoeAuVjNozxXA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=ncziGviL; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::bc0b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::bc0b; helo=smtp-bc0b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=ncziGviL
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::bc0b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A640740891
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 10:05:20 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j1Mjb11z7zPM8;
 Fri,  9 Oct 2026 11:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791539858;
 bh=+LvkKjvqlBfFPW0vdz1paxPj54RAh0r7XFmMrQthKeY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ncziGviLtWDJK4Ghx7z5YROjv/Ug4m+HXIXQr1XDUsSszNa24CvRYWiOjAv4OyACs
 265OIusL/s2O5uoWUsxr1OgcOBMW8vggbrGOf/9lwnZ9mLDH2T4ZdoS5y4p6PY12Mo
 sCb055qOttZitVXn6Nso4LeqDS72/oNutB1pz2Opq/iNFdoNAR8zFl3xw/ENt06Bsf
 HSyE1IsitK8gOD+n7ywqqEMTi0D+TbWipyf09f5KSWjUbAueY2anLJBfQxtGECrq3Y
 D+omTTOEELmmj3UerFm5kkPXgucetuQSPLljrLAGtJgHKwaj9eNrxb5r/naZzHY4jm
 CbnLs2RvQ8PZQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j1MjY4JgdzJX0; Fri,  9 Oct 2026 11:57:37 +0200 (CEST)
Message-ID: <a8ecf218-0342-4b20-9f04-a4f02ae7a6a2@0leil.net>
Date: Fri, 9 Oct 2026 11:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk: rockchip: rk3568: Use fixed PMU CRU base
 address for PLL access
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20260804214442.2592597-1-jonas@kwiboo.se>
 <20260804214442.2592597-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804214442.2592597-5-jonas@kwiboo.se>
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

On 8/4/26 11:44 PM, Jonas Karlman wrote:
> The RK3568 PMU PLL helpers lookup the PMU CRU udevice before accessing
> PMU PLL regs. This may trigger a full PMU clock driver probe to get the
> PMU CRU base address from the clock driver private data, something that
> can take several ms.
> 
> Change to use the RK3568 specific PMU CRU base address consant directly
> to simplify and remove the unneeded complexity of using runtime lookup
> in SoC specific code.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_rk3568.c | 34 +++++--------------------------
>   1 file changed, 5 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3568.c b/drivers/clk/rockchip/clk_rk3568.c
> index 5a05f1b4de00..eaf51728520a 100644
> --- a/drivers/clk/rockchip/clk_rk3568.c
> +++ b/drivers/clk/rockchip/clk_rk3568.c
> @@ -94,44 +94,20 @@ static ulong
>   rk3568_pmu_pll_set_rate(struct rk3568_clk_priv *priv,
>   			ulong pll_id, ulong rate)
>   {
> -	struct udevice *pmucru_dev;
> -	struct rk3568_pmuclk_priv *pmu_priv;
> -	int ret;
> -
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
> -					  &pmucru_dev);
> -	if (ret) {
> -		printf("%s: could not find pmucru device\n", __func__);
> -		return ret;
> -	}
> -	pmu_priv = dev_get_priv(pmucru_dev);
> -
> -	rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
> -			      pmu_priv->pmucru, pll_id, rate);
> +	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;

Do we really need a static variable here?

>   
> -	return 0;
> +	return rockchip_pll_set_rate(&rk3568_pll_clks[pll_id],
> +				     pmu_cru_base, pll_id, rate);

This is a change in behavior, please have the change from return 0 to 
return rockchip_pll_set_rate in a separate commit.

>   }
>   #endif
>   
>   static ulong rk3568_pmu_pll_get_rate(struct rk3568_clk_priv *priv,
>   				     ulong pll_id)
>   {
> -	struct udevice *pmucru_dev;
> -	struct rk3568_pmuclk_priv *pmu_priv;
> -	int ret;
> -
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -					  DM_DRIVER_GET(rockchip_rk3568_pmucru),
> -					  &pmucru_dev);
> -	if (ret) {
> -		printf("%s: could not find pmucru device\n", __func__);
> -		return ret;
> -	}
> -	pmu_priv = dev_get_priv(pmucru_dev);
> +	static void * const pmu_cru_base = (void *)RK3568_PMU_CRU_BASE;
>   

Ditto for the static keyword here.

Changes are fine otherwise.

Cheers,
Quentin
