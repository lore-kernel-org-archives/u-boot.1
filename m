Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A54CD128E
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 12:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D5D88285;
	Sat, 30 Mar 2024 13:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="M03v2Srb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92AC088290; Sat, 30 Mar 2024 13:21:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C31288273
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 13:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5ac9=LF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1711801258;
 bh=MMxC0eBDL5APvWU93li26bBp3wqq3ggtR9QZ6cKboP0=;
 b=M03v2Srbe2qRBCG8tmk8kIk/oEc8Fwkj3cMunCnP9TNn5qN/U8Bmr6UwOnZjH+d1fgFnn/fJQ
 fudsIwIwb5Bsi4DTv3a7oKdzx1OoXpFjHrBdCZK32vFwtia3clXZS53ZX3aWr2kg/AexJiRA2xz
 t+xrw5wKSNPj4TbF9BcWGexWFM7tWFkGYpvmF7gKQhBG920LG7p9DxOl1RzU2COwdtW/4QY+V/9
 TjwoQ3LyUlziEhrMQ0S26xCgsuODmsx196coJGYbMMLTLqiOEUMJ4zGTDHALJVFUK9UY1QxZX4w
 T3BWadYgJ9m3UWGuqaeD8PYLA9g75qA55wAiR55WnYXQ==
Message-ID: <e11ab780-e849-4ef7-9a11-1531b3ff6364@kwiboo.se>
Date: Sat, 30 Mar 2024 11:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] rockchip: rk3588: Add SoC specific RAM bank logic
To: Chris Morgan <macroalpha82@gmail.com>, Chris Morgan
 <macromorgan@hotmail.com>
Cc: eugen.hristev@collabora.com, kever.yang@rock-chips.com,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, trini@konsulko.com, u-boot@lists.denx.de
References: <20240330050515.470025-1-macroalpha82@gmail.com>
 <20240330050515.470025-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240330050515.470025-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6607ef38a5d9ac9db0938cf4
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Chris,

On 2024-03-30 06:05, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add SoC specific RAM bank logic for the rk3588 boards. This logic
> works by reading the ATAGS created by the ROCKCHIP_TPL stage and
> applies fixups on those to ensure we aren't stepping on any
> reserved memory addresses.
> 
> The existing logic requires us to define memory holes to allow
> devices with 16GB or more RAM to function properly, as well as
> blocking up to 256MB of otherwise accessible RAM.

Looks good at first glance, will runtime test later.

Please move this out from being RK3588 specific, my prior request to
depend on !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) was so that this
also gets used on RK356x. On 4 GiB RAM RK356x boards the same 256 MiB
could be reclaimed with this.

For final patch submission please also remove all duplicated RK3588
board implementations of ft_board_setup() that adds reserved memory
nodes to DT, they are no longer needed after this.

Regards,
Jonas

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/mach-rockchip/rk3588/rk3588.c | 93 ++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 

