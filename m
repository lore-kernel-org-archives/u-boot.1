Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93428CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 18:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 341F860706;
	Sun,  4 Oct 2026 18:40:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eePVYd3xEue1; Sun,  4 Oct 2026 18:40:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8853B606D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791139253;
	b=A/8qVCYEZjv0awdTUIjsI3xwX58EE8s0ldpull49kVBn+9Hp2Y3Kv1v/jXRs4nJEaNHB
	 nYdruNYmXotDnMqSjICIcNAAiyeX42Y5VV/LkwItfif75d9/+Skl1LrmtYWhAQnOAR9vi
	 9YurqvHVyhEVaCrWCr/pCMe9x3Zv0EcwtqYQOs/N0agVMiTJCWu9PDohfQfK6CacJW3Wz
	 D6Jp2VHXhYmk8zVKGcmc/+DFY6NXikeJhQSS6BuJ4RLnFhljqkkb2C76oNM0img548xyA
	 dYLIQjA/hXpx4zVcbCJ3VexIJfYVHoFoCPc+t0ZJpOiC1rYB3nGLGoWt/1aqbFWSuFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791139253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sp8hXsYXDxdUpjVLzRpa/iQWu1GcHBTQXAgK/KKFh1E=;
	b=WADHTwgGxfFfnoxVxMh84t3SUvcZqBg43gSuJwDAzxFSEv9V5VS8oUSmS4zLtRkXgzD8
	 UmGIJ9QcvNo2u0+U0w0T19edn7EgMfzUB6BjcPTePBbnu3R9iSph19kg5T/13cTIa/oyl
	 nmNlRG9DHOL2syAewTox14SIAECJlfYYdGpJ2FcMbCiw6qVGt63jwIOpuu2G6cx/G0frA
	 TFuY3oElaRZACC3+VCngDtvOQsgBMqJcN9AMyYJRqRVUpQuof0EHUls/twRmzvftKVrL2
	 ddmFBFnlsrluZectXbolKvtx2ub1QdVSGCJ7JDTNoZSx7peiGxz+FxZUKuG++mBi5AA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791139253;
	bh=sp8hXsYXDxdUpjVLzRpa/iQWu1GcHBTQXAgK/KKFh1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VShEaclRWHXUn2ToWMBfx8JNofCi7TEICM/On21wltr78UkDRnRpPtCHn2VXnP0aI
	 3kQmlT620dOheaYt+MJZp919c5y2GWuFnLuep/TOPICSQ5bP0v9DA0ifPFvviyRJ1D
	 zIxmBU+CB7pM4LcDhGX2wM2sbX6TPevRMQgco3vD2ua6HY5P7TzaMgWM8ckw+BPkbO
	 GewOFger/KC8KgSmmxYBeRZr+V7iqLlGPmi3rOj2oqw1N1chNyFHolqgdRSxZHAAGA
	 O8bOzTx+G+UD9It+VyJXvLOunNPJIxg3SQH/m3aAE4RWFkE0PrrHEUXIwOWw9r7urd
	 dZ7xx+3Aru4Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8853B606D6;
	Sun,  4 Oct 2026 18:40:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EB5DD22B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCEE140049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g-W3apVbizAK for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 18:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 13BD34002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791139251;
 b=Ozt3KPVaEIscDMUs+oIksLlsabiIoU2QXHsbeoLal/Pi+F24+HANyt8TziUi2ownrep4
 0X2RjmhhrSwt4tWtgHnwM2prrgRfMMSpaa9srNk73JJswYqWQ66Dg2Dxsh58O0mBG0XgI
 WYdin9OzPvEBmmpi3nn3gK1dRgB3vqBzd/rJLYuTkzqxaRJvJVrPpzU0zNeUSaqFfhiBY
 pE1RBbTKF1UQG0NnpWc0YJJSotSxNSFUvDSng/93V0myf9Qk3rWmmAqA9JZJ5PTyBmoJa
 szhDNFV99r9v5ankzZnMXoBob5gmDdZRWLaY+AIsZKyWA6DmAY49OnSWtuqjbLAd67g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791139251;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=sp8hXsYXDxdUpjVLzRpa/iQWu1GcHBTQXAgK/KKFh1E=;
 b=KELIYZSKDNyJMPdxywoyAxClwPpr1ZKk5Q+VxHJ57S1/uaMknv4Csq5iAQ08vnoNICug
 HNGLC9FvIYpbdaKYYZmWckvfNQL1xnOGnxYrSWsA8wA+/6LJz9kQ42OrdRsjT2PKymOSw
 PRJ4lvv80rRKdvbST53Un05tSm26MFZZrEtNZlVWNk+c4CfPVtcOrJHtZHf4i5CDH493V
 DPZxGNmRaLe44Mh9zw4MbwpZPPhkiHauKONqPLP+QylpMT7TEWB2KHshbKm8NMmpMWuRb
 20bgFg1/MTMfEnPlox4yic8LazJFkMcF0mJ0fO1cviHVHVvWB2nDZkT6gQGBE+V3eiA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=OF9hFPEI; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=OF9hFPEI
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13BD34002B
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791139249;
 bh=sp8hXsYXDxdUpjVLzRpa/iQWu1GcHBTQXAgK/KKFh1E=;
 b=OF9hFPEIh3G5Z7ieirl4boHyFn9rSk8Hm9lWa4OHsg6FowPD66DJ8J5eoT71g5yyN8MzvTrd+
 3yp+9oaEqSoX1oBvzEv65Jl85sForreZ67duSmcfsP6VYfyx2Q5tyqSH6JJ4DuT29eBiiWkQuQ3
 cE1ltilUGNFi8ug6FwXI9ixQWfBp6nASv6M5nIiXvJeCFakHnT7KnB3TC7Mk15wlQIdaysUhwIH
 DPz1X1r39wSsvf6ncJpyVPjRrW7culPfhRJJQTtZP9yD5bHc5/1JOL1pgVfslxeDfxJ0nBn2xfg
 tijKcHYY0AxiuBKDgxHEP0UZZR8Rzr0LfJ9F1fZx7/+A==
X-Forward-Email-ID: 6ac29dabae0725cde34e6615
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1f7854c0-ced3-40a3-a903-c3f63ce620f1@kwiboo.se>
Date: Sun, 4 Oct 2026 20:40:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: rockchip: Remove useless SPL_SHARES_INIT_SP_ADDR
 check
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Quentin Schulz <u-boot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261002-config-v1-0-11bb20983682@gmail.com>
 <20261002-config-v1-4-11bb20983682@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20261002-config-v1-4-11bb20983682@gmail.com>
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

Hi Massimo,

Please use more neutral wording than 'useless' in subject and messages,
e.g. unneeded or unnecessary.

On 10/2/2026 6:36 PM, Massimo Pegorer wrote:
> The ROCKCHIP_COMMON_STACK_ADDR configuration option depends on
> SPL_SHARES_INIT_SP_ADDR, therefore the logical AND of the two options
> values is equal to the to value of ROCKCHIP_COMMON_STACK_ADDR.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>  arch/arm/mach-rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index 5ed774159be..8e377066a43 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -798,7 +798,7 @@ source "arch/arm/mach-rockchip/rk3588/Kconfig"
>  source "arch/arm/mach-rockchip/rv1108/Kconfig"
>  source "arch/arm/mach-rockchip/rv1126/Kconfig"
>  
> -if ROCKCHIP_COMMON_STACK_ADDR && SPL_SHARES_INIT_SP_ADDR
> +if ROCKCHIP_COMMON_STACK_ADDR

I am pretty sure this was needed with the older Kconfig, however I was
not able to reproduce such issue, also possible the 'depends on' was
missing during early work on this.

With rewording this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>  
>  config CUSTOM_SYS_INIT_SP_ADDR
>  	default 0x63f00000 if SPL_TEXT_BASE = 0x60000000
> 

