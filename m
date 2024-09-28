Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF0CF6496
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 20:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288E388B29;
	Sat, 28 Sep 2024 22:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="royNqjPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A7888C6D; Sat, 28 Sep 2024 22:56:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEA788ADC
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 22:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c70e=Q3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727556999;
 bh=/6PZxOapO87TWivCh4KK48Km/BOp8U2n+R9H1Ius7F0=;
 b=royNqjPMlX4yXlUboZ5C8iJhuQ+ZtXZP1Cggz6oAjVo4pvIhqWSoDb66Nx1Utyo7vKsXsBa85
 Dw3fw7tUEq0SFJ8ALwikEpU6eWsBO9qHvOpp6+yD/4MLXGkxlOWt77qPmQc5GnDaMj/m9q3aIGq
 Wl8dT5NBzOpJL6jQhNzgBB31Ke5tUPT1vlTNsm0dsHwFVaX1+0CXp1DqjPaNXilHNNKl/qF11VV
 Jc0Z/bjN1E9tI1OFyze5DsmN3v0fflqFfik3J34KKPSrd8A+pfjhMgB5yrSpq21YNebZ1bVkBv7
 +iXLpoSJNDc53kEy3+4HJCimKg6ScIggpxTLjWuLTiVA==
Message-ID: <7a415f72-01e3-4257-ac6d-c21c1610abe9@kwiboo.se>
Date: Sat, 28 Sep 2024 22:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/30] scripts: Define CONFIG_XPL_BUILD for all xPL
 builds
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts
 <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-5-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240928200030.194546-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f86d82ee3ee57cb792fb77
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
> The new name 'xPL' is intended to indicate a build of any phase which is
> not U-Boot proper. Define it for all such phases.
> 
> Note that we also define CONFIG_SPL_BUILD for all xPL builds. This
> preserves existing behaviour, but future patches will adjust that.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  scripts/Makefile.autoconf | 6 +++---
>  scripts/Makefile.xpl      | 9 +++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> index b42f9b525fe..d7544022a31 100644
> --- a/scripts/Makefile.autoconf
> +++ b/scripts/Makefile.autoconf
> @@ -83,15 +83,15 @@ u-boot.cfg: include/config.h FORCE
>  
>  spl/u-boot.cfg: include/config.h FORCE
>  	$(Q)mkdir -p $(dir $@)
> -	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD)
> +	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD)
>  
>  tpl/u-boot.cfg: include/config.h FORCE
>  	$(Q)mkdir -p $(dir $@)
> -	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
> +	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_TPL_BUILD)
>  
>  vpl/u-boot.cfg: include/config.h FORCE
>  	$(Q)mkdir -p $(dir $@)
> -	$(call cmd,u_boot_cfg,-DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
> +	$(call cmd,u_boot_cfg,-DCONFIG_XPL_BUILD -DCONFIG_SPL_BUILD -DCONFIG_VPL_BUILD)
>  
>  include/autoconf.mk: u-boot.cfg
>  	$(call cmd,autoconf)
> diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> index 3091311a3d2..ad21d451a30 100644
> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -21,15 +21,16 @@ include $(srctree)/scripts/Kbuild.include
>  
>  -include include/config/auto.conf
>  
> -# This file contains 0, 1 or 2 lines
> +# This file contains 0, 2 or 3 lines
>  # It is empty for U-Boot proper (where $(obj) is empty)
> -# For any xPL build it contains CONFIG_SPL_BUILD=y
> -# For TPL builds it has CONFIG_SPL_BUILD=y and CONFIG_TPL_BUILD=y
> -# For VPL builds it has CONFIG_SPL_BUILD=y and CONFIG_VPL_BUILD=y
> +# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
> +#    - for TPL builds it also contains CONFIG_TPL_BUILD=y
> +#    - for VPL builds it also contains CONFIG_VPL_BUILD=y

This comment block was just added in the prior patch, and now changed
and re-formatted, why not just add the comments in this patch or at
least this patch should only contain the addition of XPL_BUILD.

Regards,
Jonas

>  -include $(obj)/include/autoconf.mk
>  
>  UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
>  
> +KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
>  KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
>  ifeq ($(CONFIG_TPL_BUILD),y)
>  KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD

