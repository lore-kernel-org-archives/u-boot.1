Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E87D18151
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B11CE891F9;
	Tue, 15 Oct 2024 00:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728944489;
	bh=pro8bhxQRuRbzBQZhTm7lemCf0YH9ix+uoDtYfkvyf4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cI4KVXNT8N6gdgcQVS/TnQZbuEDTd7H1fCASQMiOYTkJQakPtyUTFJf/yWgi7RDoe
	 oBtJ4TF8ugR0X2zAS+5VygcRYXt9HkYQcuiAZeg2kZf+mfBurJgN4ct3qSww1TIGHB
	 +tvd4MxjcDa09gkOc3uu7n87r11mFENFxCquzUev2zX/HfZmqRp4oUsp40LzIso7Nj
	 m2YuNcD6OEon/KqkochMp91P6fZEvgQhENYHTJjmMNOM/iAbQox51evRVj0ZhsvvgC
	 ZvBtEY6sJhA30c/RJjwwK3xGsybMbprTnckdK3FaCpechVmCfCF7rm0CdmtGUz0mNs
	 khPAvifD967oQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0B2A888EB7;
 Tue, 15 Oct 2024 00:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728944489;
 bh=pro8bhxQRuRbzBQZhTm7lemCf0YH9ix+uoDtYfkvyf4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bxJk4u5eN4dirMWmVkZ/46Vq1Ddq2O21JRUgJvtM9leN52qzYgc/N2NVDn7aURyZK
 zOMkDtDc6EP0pJVTizMVvde9RMlY0jORTMZO+RcwdIDAbuqycSnkhaqDPaXeLUiqHZ
 XzdBKHaCkf3LeB/SyBRxt5PqVKOi3esPidxmMPBORbrGYXsGUEdZk9Iy9OP6FxfOL3
 TXY/s+dPqBmhFCmdsnJt4jYvMXYnf+ZvML0TGhCFR/u+kwc1rRdmDKUr2P0B77Ww1t
 JcsaPOhv9diKFjy6UMcyivUIHbqO0L4Xz+YEezzQ3ynmgkJF5VBbeCqZEwolIhPl2o
 zfbS3wtaEnMbQ==
Message-ID: <6c21a300-24f7-4a84-a985-fc39fe53e15c@denx.de>
Date: Tue, 15 Oct 2024 00:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241014221523.2912260-1-alexthreed@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241014221523.2912260-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/15/24 12:15 AM, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some versions before it used to require 64 bytes.
> Bump min value to 64 bytes to be on a safe side.
> 
> Boot with 8 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
> 
> Linux source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>

Thanks
