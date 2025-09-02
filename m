Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA5CCA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:13:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4198783AEA;
	Tue,  2 Sep 2025 11:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4DB183236; Tue,  2 Sep 2025 08:57:38 +0200 (CEST)
Received: from lucky1-04.263.net (lucky1-04.263.net [211.157.147.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308C780422
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 08:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=techyauld.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yzheng@techyauld.com
Received: from localhost (unknown [192.168.167.13])
 by lucky1-04.263.net (Postfix) with ESMTP id 254AF16374F4;
 Tue,  2 Sep 2025 14:57:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 0
X-ANTISPAM-LEVEL: 2
Received: from localhost (unknown [118.193.106.122])
 by smtp.263.net (postfix) whith ESMTP id
 P2913T140657360369408S1756796251323466_; 
 Tue, 02 Sep 2025 14:57:31 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: yzheng@techyauld.com
X-SENDER: yzheng@techyauld.com
X-LOGIN-NAME: yzheng@techyauld.com
X-FST-TO: ilias.apalodimas@linaro.org
X-RCPT-COUNT: 6
X-LOCAL-RCPT-COUNT: 0
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 118.193.106.122
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <fb63ab9cd467b68062c48889f5f6070f>
X-System-Flag: 0
X-SENDER-AREA: CN-CN_110000
Date: Tue, 2 Sep 2025 14:57:30 +0800
From: "brock.zheng" <yzheng@techyauld.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, heinrich.schuchardt@canonical.com, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm64: Properly clear BSS
Message-ID: <uh5aatnz6vsinpsbturhhrolndxme7d2jdhnsyxqzeubyw34tw@2olttyn4kxah>
References: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
X-Mailman-Approved-At: Tue, 02 Sep 2025 11:12:53 +0200
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

i am glad to see my patch been reviewed.

I can not access the international network easily.
so any of you can fix / rewrite / change that patch.

If I can see the fixup in the offical git repo, I will be very very glad.


On 2025-09-02 09:08:12, Ilias Apalodimas wrote:
> Date: Tue,  2 Sep 2025 09:08:12 +0300
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> To: trini@konsulko.com
> Cc: heinrich.schuchardt@canonical.com,  Ilias Apalodimas
>  <ilias.apalodimas@linaro.org>, brock_zheng <yzheng@techyauld.com>,  Simon
>  Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
>   u-boot@lists.denx.de
> Subject: [PATCH] arm64: Properly clear BSS
> X-Mailer: git-send-email 2.50.1
> 
> Brock reports a breakage on an RK3568 SoC. His patch is
> correct but he never followed up on the requested changes.
> 
> We currently use ldr to calculate the address of __bss_start and
> __bss_end. However the absolute addresses of the literal pool are never
> relocated and we end up clearing the wrong memory section. Use
> PC-relative addressing instead.
> 
> Link: https://lore.kernel.org/u-boot/zfknlzcemnnaka5w2er5wjwefwoidrpndc4gjhx6d5xr6nlcjr@pasfayjiutii/
> 
> Suggested-by: brock_zheng <yzheng@techyauld.com>
> Reported-by: brock_zheng <yzheng@techyauld.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/lib/crt0_64.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index f3f279f2c39c..3e7627aa389b 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -158,8 +158,10 @@ relocation_return:
>  /*
>   * Clear BSS section
>   */
> -	ldr	x0, =__bss_start		/* this is auto-relocated! */
> -	ldr	x1, =__bss_end			/* this is auto-relocated! */
> +	adrp	x0, __bss_start
> +	add	x0, x0, #:lo12:__bss_start
> +	adrp	x1, __bss_end
> +	add	x1, x1, #:lo12:__bss_end
>  clear_loop:
>  	str	xzr, [x0], #8
>  	cmp	x0, x1
> -- 
> 2.50.1
> 
> 
> 

-- 
Brock Zheng <yzheng@techyauld.com>


