Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFF2FB5EBB
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 05:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA758409B;
	Tue, 17 Mar 2026 06:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uIZ8bq13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A1384067; Tue, 17 Mar 2026 06:07:16 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016BF8401A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fZg1X63Y3z9tRk;
 Tue, 17 Mar 2026 06:07:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773724032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hy18M6TBcDjMyW4ewxdkTftF3q/zxh3BVTLPrPoNSj4=;
 b=uIZ8bq13Hoau0Ry/cMw73UjhObhtn2K6R4iF7XoFO3+XTi7fZ3fiChgfQbdcVSOBodfStd
 BWirP9bwPqORpjdmjlSKz5TI0vc87FK3AbTdH4CErXW4pjAsyTrFZEVY+ANs7XsopHsLOr
 q11ebRTJDw3TnoTZ1e37WV0BrVBhRgo8sSK1YJGDz3by7qWwIjRwPrKJYaNMrUdoUrob80
 DlNfZkGhSSk/zIF6jtDtlLg78JWhxqRpjfvzs2RKoa/9GgyVf5k24/ZDhHD2FaAm0ifDOb
 uVj6u+c3lDvQQnw1h5ys79lyrB7SklnPvxFEuVQO0OKInEFbtu1CvpcMWBDd1A==
Message-ID: <533317d3-76f5-4e6f-a8f1-d879fc642de2@mailbox.org>
Date: Tue, 17 Mar 2026 03:32:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] optee: Correct dependencies for BOOTM_OPTEE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com
References: <20260317012452.4162719-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260317012452.4162719-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bb6f26afb73c0256547
X-MBO-RS-META: qhhyxqwubsijwdz5nz5ex97ezxz9c3z5
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

On 3/17/26 2:24 AM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for BOOTM_OPTEE. This symbol needs to select BOOTM_LINUX and in turn
> that is only valid for CMD_BOOTM or CMD_BOOTZ. Add this dependency.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I am looking for feedback on this, so I've added the board maintainers
> for the platforms which enable this option. It looks like this is only
> valid on 32bit ARM platforms, to start with and not 64bit, is that
> correct? That's why I excluded CMD_BOOTI from the list. I suspect that
> this should really depend on CMD_BOOT{M,Z} and BOOTM_LINUX, and not
> select it. If someone can confirm, I can do that instead, or someone can
> just do the replacement patch for this. Thanks!
> 
> Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: u-boot@dh-electronics.com
> ---
>   lib/optee/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/optee/Kconfig b/lib/optee/Kconfig
> index 34b9d8afe675..9251faf73cd7 100644
> --- a/lib/optee/Kconfig
> +++ b/lib/optee/Kconfig
> @@ -40,6 +40,7 @@ config OPTEE_TZDRAM_SIZE
>   
>   config BOOTM_OPTEE
>   	bool "Support OPTEE bootm command"
> +	depends on CMD_BOOTM || CMD_BOOTZ
ARM32 SPL arch/arm/lib/spl.c has this piece of code, which does not 
depend on "bootm" command. This is used by falcon boot to jump into 
optee-os , with the optee-os return address being Linux kernel entry 
point. So I don't think depending on CMD_BOOT{M,Z,I} is enough ?

77 #if defined(CONFIG_BOOTM_OPTEE) && defined(CONFIG_ARM) && 
!defined(CONFIG_ARM64)
78         if (spl_image->optee_addr)
79                 boot_jump_linux_via_optee((void 
*)(spl_image->entry_point),
