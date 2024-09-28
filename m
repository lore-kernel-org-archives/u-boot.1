Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E113ACF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 22:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8148B88A4C;
	Sun, 29 Sep 2024 00:23:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="A6sh2BZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3979C88AE8; Sun, 29 Sep 2024 00:23:18 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C578688901
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 00:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c70e=Q3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727562192;
 bh=NE67Ir1wfnFt19+57XC+qCw5rc3WtZu1KAf9QztHbU8=;
 b=A6sh2BZQvx2ZcCNymZE+MW1l5H0wXdRHKJUzwjey2EPPuz+flKEghOs0IX67x8iLampojnYUA
 8fZfgoxSvvZK4XU6LTyYiL6Bzofhddt5Pk5dEo0lUePWhCiVCe4nqCCl9QN3SeCKyJ4bcuFdKpr
 rdSh4zfw7qB6nB+RZhmHr8R8cDjl4zCxyktJ01zqun2ZLP1nmv/rZ8Rmca/UYv2DyeabPpOHU7n
 nP6KS8S0GG1Bd1kxZt9HdQkf5O41g2s2+AONEtWqcnOVg7qym6wCOkLKyuCwrBEdwYrwismsiTu
 WgG39klGp3Kd34th4o4bJSo15dNF4IPPrTZJ0LKNYugw==
Message-ID: <00b69273-b2dc-4a4b-be4e-5358afad9614@kwiboo.se>
Date: Sun, 29 Sep 2024 00:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/30] xpl: Rename u_boot_first_phase to
 xpl_is_first_phase()
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-22-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240928200030.194546-22-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f881cfee3ee57cb793184e
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

Hi Simon,

On 2024-09-28 22:00, Simon Glass wrote:
> This is a better name for this function, so update it.
> 
> Tidy up the function comment to mention VPL. Use SPL_BUILD in the SPL
> check, for clarity.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-omap2/am33xx/board.c |  2 +-
>  common/bloblist.c                  |  4 ++--
>  common/spl/spl.c                   |  4 ++--
>  include/spl.h                      | 16 +++++++++-------
>  4 files changed, 14 insertions(+), 12 deletions(-)
> 

[snip]

> --- a/include/spl.h
> +++ b/include/spl.h
> @@ -34,24 +34,26 @@ struct spl_boot_device;
>  enum boot_device;
>  
>  /*
> - * u_boot_first_phase() - check if this is the first U-Boot phase
> + * xpl_is_first_phase() - check if this is the first U-Boot phase
>   *
> - * U-Boot has up to three phases: TPL, SPL and U-Boot proper. Depending on the
> - * build flags we can determine whether the current build is for the first
> + * U-Boot has up to four phases: TPL, VPL, SPL and U-Boot proper. Depending on
> + * the build flags we can determine whether the current build is for the first
>   * phase of U-Boot or not. If there is no SPL, then this is U-Boot proper. If
>   * there is SPL but no TPL, the the first phase is SPL. If there is TPL, then
> - * it is the first phase.
> + * it is the first phase, etc.
>   *
> - * @returns true if this is the first phase of U-Boot
> + * Note that VPL can never be the first phase. If it exists, it is loaded from
> + * TPL
>   *
> + * Return: true if this is the first phase of U-Boot
>   */
> -static inline bool u_boot_first_phase(void)
> +static inline bool xpl_is_first_phase(void)
>  {
>  	if (IS_ENABLED(CONFIG_TPL)) {
>  		if (IS_ENABLED(CONFIG_TPL_BUILD))
>  			return true;
>  	} else if (IS_ENABLED(CONFIG_SPL)) {
> -		if (IS_ENABLED(CONFIG_XPL_BUILD))
> +		if (IS_ENABLED(CONFIG_SPL_BUILD))

Here is another instance where it made no sense to replace SPL with XPL
to just later restore it back to SPL.

Regards,
Jonas

>  			return true;
>  	} else {
>  		return true;

