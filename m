Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7282CCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 05:52:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1879183968;
	Wed,  5 Nov 2025 06:52:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PgAv13fT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3F983A2B; Wed,  5 Nov 2025 06:52:09 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39B8835B3
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 06:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5561A108E16; Wed,  5 Nov 2025 06:52:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762321926;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=/9vauSjTF8ZmVgIGYtbx8rYZMOCHqamuJg4YSz1e7RY=;
 b=PgAv13fTv/iHjGu+7tLa5MQbqOjCXPWbdA8oBg6BF/Bts1gat5wnfsizQYOKfbx7qOkHY5
 ALqjTsjelktOZzLOKDizJS3Pvxqt6VwJRHBxIVpvAy+e1GETvN/CGDsoFn13+6CofdP0fe
 FE5cstFKMngWRASfTg9jdIbmFu7yyQfSaUAyg+Q9OrJAWqY1Wzlj5e8V1TpOqksnBTO8ZW
 tdCdYeASctGwRcDoF+4GTxgFVOuH0TatzRzAHgyAE86rJCrJWu+0aqkZo29lPp9lIcl2E4
 FHw93QZa4Ltqk6YqTBZyXS3i+t3RTKVdMNmoIipzFeyLkSG9uQG5A3vUeb3K8g==
Message-ID: <8413ebc9-a8f9-02e2-7d2a-7b64d96529b4@nabladev.com>
Date: Wed, 5 Nov 2025 06:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/3] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
Content-Language: en-US
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>
References: <20251104174458.3385564-1-ravi@prevas.dk>
 <20251104174458.3385564-3-ravi@prevas.dk>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251104174458.3385564-3-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Rasmus,

On 04.11.25 18:44, Rasmus Villemoes wrote:
> In scripts as well as interactively, it's much nicer to be able to
> refer to GPIOs via their names defined in the device tree property
> "gpio-line-names", instead of the rather opaque names derived from the
> bank name with a _xx suffix. E.g.
> 
>    gpio read factory_reset FACTORY_RESET
>    if test $factory_reset = 1 ; then ...
> 
> versus
> 
>    gpio read factory_reset gpio@481ac000_16
>    if test $factory_reset = 1 ; then ...
> 
> This is also consistent with the move on the linux/userspace side towards
> using line names instead of legacy chip+offset or the even more legacy
> global gpio numbering in sysfs.
> 
> As dev_read_stringlist_search() depends on both OF_CONTROL and
> OF_LIBFDT (which matters for the SPL case), we need some .config
> conditional. However, it only adds about ~50 bytes of code to U-Boot
> proper, and dm_gpio_lookup_name() most often ends up being GC'ed for
> SPL, thus adds no overhead there, so for now make it a hidden symbol
> which is merely a convenient shorthand for
> CONFIG_IS_ENABLED(OF_CONTROL) && CONFIG_IS_ENABLED(OF_LIBFDT).
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>   drivers/gpio/Kconfig       | 16 ++++++++++++++++
>   drivers/gpio/gpio-uclass.c | 11 ++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)

I can remember, that I also experimented with such an approach.

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
(Changed my EMail address)
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
