Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8D9C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E15987F22;
	Mon, 26 Feb 2024 18:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="AwpjzDSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EEA387F21; Mon, 26 Feb 2024 18:58:31 +0100 (CET)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387D087F2D
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=cq8fTs66LSBUULx7uG42adfeuHzx+u91Z8hSoDsVQ+s=; b=AwpjzDSNakgBQZnY4ROcRV9uUm
 a0gEGYDVd7JR89xzDQkwMXpgauuf3KwgNLAvLntK5IEd2VqaV0mISTrf4QWW+4HuhLZAUSg+a14Zl
 qY4uSGihTGZ0l6n836/ce6G1f91FFyjAiOfA7Ur6USnLKs8KL9aYisse7DUf+Oc6g69EPTxdjyioU
 sfK3gVHpXmkzglgbnY9+m1JEVkwVfHY26TLKiONQ6E046uZufG92Z6Bp1D01eMM/gnndK/o5bUBGb
 vIHn/zatYPgDz8ViFHKXEvgvniVEvISHpIkujEgOH52y6IBgYKji6YX7S2Bez+6G+wr1CLWLLEhMB
 yRv2wgDw==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1refFB-0048F0-0U;
 Mon, 26 Feb 2024 18:58:25 +0100
Date: Mon, 26 Feb 2024 18:58:24 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] serial: move sbi_dbcn_available to .data section
Message-ID: <ZdzRQK-LmwegGBBV@aurel32.net>
References: <20240226163226.126288-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226163226.126288-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

On 2024-02-26 17:32, Heinrich Schuchardt wrote:
> U-Boot SPL loads the device-tree directly behind main U-Boot overlapping
> the .bss section. reserve_fdt() is called in board_init_f() to relocate the
> device-tree to a safe location.
> 
> Debug UARTs are enabled before board_init_f(). With sbi_dbcn_available in
> the .bss section the device-tree is corrupted when _debug_uart_init() is
> called in the SBI serial driver. Move the variable to the .data section.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/u-boot/+bug/2054091
> Fixes: dfe08374943c ("risc-v: implement DBCN based debug console")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/serial/serial_sbi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
> index a51a96c1ef0..f3ecfccab43 100644
> --- a/drivers/serial/serial_sbi.c
> +++ b/drivers/serial/serial_sbi.c
> @@ -17,7 +17,7 @@ static inline void _debug_uart_putc(int c)
>  
>  #else
>  
> -static int sbi_dbcn_available;
> +static int sbi_dbcn_available __section(".data");
>  
>  static inline void _debug_uart_init(void)
>  {

Tested-by: Aurelien Jarno <aurelien@aurel32.net>


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
