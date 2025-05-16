Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92097C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 11:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB1080107;
	Fri, 16 May 2025 13:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1747395598;
	bh=8Fm+NsHlL+r/3I0hTun74r9hVa/6PXHu7AHLV45r05w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z0O3lhyqXyk/GjvNHfJcFiymgvjXZWkMxWw/YYlARVTfs2k0UXo8lc2wFFTobwyrc
	 WwOogfD5Pu+AJgsMORX/cEYw7/IS3H2GGKbQs/ZSTcWpYg/L/CQNuP5MxXJs3mdJuF
	 724i4KBfz0esT2nVJPc/eH+joH+Z2JYqgKhx4msHNL4HZElz7AWQTCNIADKDPbXIYJ
	 82Q/Rpm+1v3NI9NzySOCkx32JPO8NGV04fhxz5QsWz3OI2jAumxMdeAWN5pGZASDcl
	 qC5sc88LF7DanhfKkfmk8n7fPs1mv5S0dRvAt5haezkwkiNRXq89MxmHPN8oHoOVkc
	 9BvxQDryi+/6w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A728129F; Fri, 16 May 2025 13:39:57 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADBFB8006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 13:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZzQ9P3gLWz9tHp;
 Fri, 16 May 2025 13:39:53 +0200 (CEST)
Message-ID: <f9a61c42-1c16-4734-9f68-8993bd1af89e@denx.de>
Date: Fri, 16 May 2025 13:39:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] Enable DM_SERIAL for Marvell Kirkwood Synology DS109.
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <swwa@users.sourceforge.net>
References: <20250506025843.11019-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250506025843.11019-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4ZzQ9P3gLWz9tHp
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

On 06.05.25 04:58, Tony Dinh wrote:
> 
> Many Synology boards (Kirkwood, Armada 37x, and Armada 38x SoCs) use the
> PIC16F1829 connecting to UART1 to provide certain functions. Mainly
> for LEDs control, but it can also perform hard reset, power off, and
> sending beeps.
> See dts/upstream/src/arm/marvell/armada-385-synology-ds116.dts for
> full description.
> 
> The Synology reset is not really needed in u-boot. In
> several Synology board u-boots such as DS116, and out-of-tree DS211,
> DS411, and DS112, the generic reset function provided by u-boot works fine
> without any board specific implementation. So reset_misc() can safey
> be removed
> 
> 
> Tony Dinh (2):
>    arm: kirkwood: Convert to DM_SERIAL for Synology DS109 board
>    arm: kirkwood: Remove Synology DS109 board reset_misc
> 
>   arch/arm/mach-kirkwood/Kconfig |  1 +
>   board/Synology/ds109/ds109.c   | 18 ------------------
>   configs/ds109_defconfig        |  2 --
>   3 files changed, 1 insertion(+), 20 deletions(-)
> 

Applied to u-boot-marvell/master

Thanks,
Stefan

