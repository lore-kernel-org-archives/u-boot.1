Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9D5CA6017
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 22:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FE9F4092B;
	Thu,  8 Oct 2026 22:05:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hwdvws_vyut; Thu,  8 Oct 2026 22:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F41140925
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791497152;
	b=abj2HF4IVKEtCT1MyYlELxhkLEWj6SBknpTMOcq7KDKXXM1p+kKPnbnWBBGQYF6Sw8u1
	 9Kh44RrH4fRV0PpwXe+Dlcr3sjwsKqhUe5xNfxGtZBS/LkxmL9g3/y2TuvZEnjvbKN6dL
	 34stEYginqcikQBIWHGlpul9S66bffbOZeGYSnOKGCAK7bLXninH3hniLHZKprzI/8DNU
	 ywJjw06al7GPFScl9BC2xx9eQCpR3AMG2u++1yk3FPcz7cAGr9CWiq2jwDdUk+qbGp0Wm
	 /PxZ5azg3OZAc2s+P9AQwmtbKgUTSiCWkdWLDzNU7MJ3urcNA4KSKGdNtfDcF2e+c6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791497152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AiPbyx4ImegBfwkw/yWOWbEXhMyXEQ3C35+hLTq1RbQ=;
	b=Q6T3xPy+roc92kyRrFjpbJLhJNwB+tPeDLCeIyoTkgsuTIye0JO93XfG/7EbNDzjA6UW
	 LrzQWfo4ls6E8hPZVqDpPv/JujXT4ljyfjzYnlZbKjQO/i6niNpJsNEZvUMg6ahK9+7Xp
	 rfNKeeGvpmI4aYnW2ZLcXLV28jJBlMn316GcfVEB1IG4LCmUK94J53RPS4XPfSFi/bYOF
	 JTZY3gHSKqMazvBdBGsBQ1xn7Sz9ors8J5c9iRXueXMFzd714GDgjGhjJsB8PD9lZcCQG
	 SM0I5ZuW/soc9uDsmcNqWAErMXRoB2qEGFyPKN4VJFWtuzxYkIwz1mCPEVPAGGlVcmg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791497152;
	bh=AiPbyx4ImegBfwkw/yWOWbEXhMyXEQ3C35+hLTq1RbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaH39Ys7P8tLpHJutOvBpe/mF226dhK4dzq1ThC1hNml3oQUPJpartAFEJxah7pd/
	 /UzcFYrefghZEEBssOc+4aLcg4iuHG4xj3QjeSEWdAk9meW0JxHlilbznK72HNyY5N
	 8crBPdYAAg1iWhw8RJatbQKfcESX8TTud0YjXJbLe1jopuaiDPjloQCqZ/v1bN864Z
	 eH42caUqFk04Hkb9ARq+8vtY3MORVWqpfxEn81qwalYvQWMRTd3ru8fNYXXjNkh45r
	 OcRTnVMq7ySmWXCSmo9YWHlDHp8Wyy45tjIdZ0p34lku2oY0OtSQQ+zh80pD3M5wLz
	 7LkMN4nH0dL3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F41140925;
	Thu,  8 Oct 2026 22:05:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AE0C2E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C1BE813FC
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5-LK-Hzv7Ih2 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 22:05:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 27656813FE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791497150;
 b=WQ2CSQ+ajEqFN2v63zc2UdeNK2pP2o4P5/vJwTmOjw4Dh9Iozhu5E2L65zYbsYcMJZ0g
 uIcpSCEARKcLUUf5WQeD16U+mEEVlin1gnr8qo+9qyZfVEliyqhm253FFPNPMC+VYnVk5
 4dcfbQE1UquJcs4IBPRLBVzOJOq5t93BNc7v1SGqJiGQHsvlYqcW0o2CG5MG8QMxK3hhM
 GjX2M0L9PWIIZKMaBVpIwz+j1+SbkF337UTom6Pi9uH1QYi8s+cYgqAo84s0gsvpkl5r1
 xH8q1Lj1UW6BER4mvu+43WBQas3BQtaVrmnhZTBZt3fK3M0VZO+H6tkxduPeLUoH9OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791497150;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=AiPbyx4ImegBfwkw/yWOWbEXhMyXEQ3C35+hLTq1RbQ=;
 b=awZoMw9bfzP07Oym+U7C4zuwUhnSRsacNye9YJnSX+O1CMm2Ong1GwyJxH+bp6yOLaCt
 yvSQJkmNveFARB/TKhsxglZCz3SvQ7fQKkQ7RKxMns4UC99Kj5iK0YyKzBsD9U1at5jcX
 H3piLH1kRYVz/1hx+rdRDILa3AblD9v29hYAo7gYl3e2EQjbDaDg54AXMEsfo4HGl/64s
 bLNU56IMi/ApfDVXQ34srhSJBPB4mc1uaHPHNjYAB5FsHFdGM6eRHJZrKkvjXP2VpObJG
 Mag9miPpaBoHMVCRJ0jE9jVfiMD4OZD6n6ik6/LkY5HbU7xIUUnDvI6eaqBvA55+7ZA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=T7Qn8s1t; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::8fa9; helo=smtp-8fa9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=T7Qn8s1t
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 27656813FE
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 22:05:49 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j13mX2f75zDYk;
 Thu,  8 Oct 2026 23:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1791496748;
 bh=AiPbyx4ImegBfwkw/yWOWbEXhMyXEQ3C35+hLTq1RbQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T7Qn8s1tyQszY5b99rhJiWqcqNYgflEYCQgZhK+Lnq719280xIbEC4GIlaN04XMG6
 uixAxzITIPuvh0c9GXSK2qCyEERrYAJB0M+AQ2VuO9cyPgURt0ooYetFOZ9NAK666H
 W5odmnGp8YN0F3IFgK3Zq8akabYbDajitAwQ90ATsksNr9g1plc5aM83CTxA5HevbE
 /RFXIPdU0U5PBUrZiL82oba4FRw3Ggk0UcxXYiNgiP9PUPWm4D/OteWbt9G0O9rVRU
 l+JWi23GojE2KmW7vWiXE8ISMDtWUvr0YFoOc5dVQorxT77l+wGxDFlrX78ry+LgRt
 9JCRS+w2ISVsQ==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j13mV4gqNzw5B; Thu,  8 Oct 2026 23:59:06 +0200 (CEST)
Message-ID: <78e51676-d35a-4e49-9d74-657716f59efb@0leil.net>
Date: Thu, 8 Oct 2026 23:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] rockchip: rk3568: Remove unneeded syscon driver
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
References: <20260804105721.2402406-1-jonas@kwiboo.se>
 <20260804105721.2402406-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260804105721.2402406-5-jonas@kwiboo.se>
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

On 8/4/26 12:57 PM, Jonas Karlman wrote:
> Modern Rockchip device drivers use syscon_regmap_lookup_by_phandle()
> to get a regmap or use a constant to get the fixed base address.
> 
> Remove the unneeded RK3568 syscon driver to discourage new uses of

Isn't drivers/clk/rockchip/clk_rk3568.c using it? c.f.
syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
Maybe one local test you could do is delete ROCKCHIP_SYSCON_GRF and 
ROCKCHIP_SYSCON_PMUGRF temporarily from 
arch/arm/include/asm/arch-rockchip/clock.h and rebuild. If it builds, at 
least the obvious ones are tackled.

Same remark for the patch for rk3588 and its clock driver.

Otherwise this looks good to me, thanks for the cleanup, much appreciated.

Cheers,
Quentin
