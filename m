Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8934FCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 22:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B280488BB7;
	Sun, 29 Sep 2024 00:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZLDSZy31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0043788C4C; Sun, 29 Sep 2024 00:08:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5003888ADC
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 00:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c70e=Q3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727561303;
 bh=vw9kq1UTB1tgSxhlkqVwEyQ+ozx4dMui9zbz3WCaTpA=;
 b=ZLDSZy31rC9OdLS9TvrC8qPIGR4hlz6mb3rTMkP/ymySaSC8EIH/dFdCzu3CjkDjO10pdbjbV
 SJhAkJBVLTFnG6dyVGdH4I1qoWtteO4dZa67PypJUjcIDVsq2O3V/y2ucSIhoW6hhfm0JJacQVy
 xBM+a+w1QJ00d9qeft2l5QRU1BVX1+Y3TJN3MDFAKewXEWwjcGjRMIKeBDryrkkx0lkbnYhMnwS
 1hbYcE5bmjxdDqbbIZ8JnP/UBdq6U/2dgt/6rZ0B0N5bD1Uds7Lj9YBByakdiV7gn7ulNbueBca
 uKEfEt63mrHPXMGGY2E3pyYIOYBT6vxs4HK4hHaHLXJA==
Message-ID: <0ecc8823-65ad-4231-8b96-5c694c382df9@kwiboo.se>
Date: Sun, 29 Sep 2024 00:08:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/30] kconfig: binman: Check for SPL instead of XPL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-17-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240928200030.194546-17-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f87e55ee3ee57cb7930f59
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
> Now that SPL means SPL (only) and is not defined for other phases,
> update kconfig rules.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  include/linux/kconfig.h                | 10 +++++-----
>  tools/binman/test/generated/autoconf.h |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
> index a59f2a61e6a..ec9584b2426 100644
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -40,7 +40,7 @@
>  #define _CONFIG_PREFIX TPL_
>  #elif defined(CONFIG_VPL_BUILD)
>  #define _CONFIG_PREFIX VPL_
> -#elif defined(CONFIG_XPL_BUILD)
> +#elif defined(CONFIG_SPL_BUILD)

This change back from XPL to SPL is probably not needed it you did not
change it to XPL in the first place.

Just doing a mass search and replace is making this series hard to
review.

Personally I did not fully realize that SPL_ or SPL_BUILD meant any xPL
build before this series, so I would look at each SPL_BUILD to XPL_BUILD
and SPL_ to XPL_ change and try to understand the original intent.

I know multiple places where I have used SPL_ and not SPL_TPL_ because
of this, and similar have used SPL_BUILD for parts I only want in SPL
and not in TPL.

How should I best handle sending fixes where I e.g. have used SPL_ in
Makefile that instead should be changed to SPL_TPL_/PHASE_ and similar
avoid a change to XPL_BUILD because the original intent was just for SPL?

I will also suggest you rearrange some of you patches to make this more
reviewable and possible also make git bisect easier, maybe:

- any fixes not involving XPL first, e.g. _SPL to _SPL_TPL in Makefile,
  SPL_BUILD in Kconfig etc
- add XPL_BUILD symbol
- all fixes and cleanup involving XPL_BUILD symbol
- rename and use spl_ to xpl_ functions
- doc updates
- replace SPL_BUILD with XPL_BUILD in code, preferably in multiple
  smaller logical patches instead of a single big patch
- remove SPL_BUILD for TPL and VPL
- rename SPL_ to XPL_ in Makefile
- rename SPL_TPL_ to PHASE_ in Makefile, NAME and PROMPT

or something similar instead of doing the big search and replace early.

Regards,
Jonas

>  #define _CONFIG_PREFIX SPL_
>  #else
>  #define _CONFIG_PREFIX
> @@ -54,7 +54,7 @@
>   * CONFIG_VAL(FOO) evaluates to the value of
>   *  CONFIG_TOOLS_FOO if USE_HOSTCC is defined,
>   *  CONFIG_FOO if CONFIG_XPL_BUILD is undefined,
> - *  CONFIG_SPL_FOO if CONFIG_XPL_BUILD is defined.
> + *  CONFIG_SPL_FOO if CONFIG_SPL_BUILD is defined.
>   *  CONFIG_TPL_FOO if CONFIG_TPL_BUILD is defined.
>   *  CONFIG_VPL_FOO if CONFIG_VPL_BUILD is defined.
>   */
> @@ -107,21 +107,21 @@ long invalid_use_of_IF_ENABLED_INT(void);
>   * CONFIG_IS_ENABLED(FOO) expands to
>   *  1 if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
>   *  1 if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  1 if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  1 if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
>   *  1 if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  0 otherwise.
>   *
>   * CONFIG_IS_ENABLED(FOO, (abc)) expands to
>   *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
>   *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
>   *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  nothing otherwise.
>   *
>   * CONFIG_IS_ENABLED(FOO, (abc), (def)) expands to
>   *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
>   *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
> - *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
> + *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
>   *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
>   *  def otherwise.
>   *
> diff --git a/tools/binman/test/generated/autoconf.h b/tools/binman/test/generated/autoconf.h
> index 75af48f9116..6a23039f469 100644
> --- a/tools/binman/test/generated/autoconf.h
> +++ b/tools/binman/test/generated/autoconf.h
> @@ -1,3 +1,3 @@
>  #define CONFIG_BINMAN 1
> -#define CONFIG_XPL_BUILD 1
> +#define CONFIG_SPL_BUILD 1
>  #define CONFIG_SPL_BINMAN_SYMBOLS 1

