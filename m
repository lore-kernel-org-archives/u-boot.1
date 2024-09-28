Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D16BCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 22:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1D288901;
	Sun, 29 Sep 2024 00:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aBlW31W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DA9588C44; Sun, 29 Sep 2024 00:19:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B603E885B3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 00:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c70e=Q3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1727561946;
 bh=M2E50hcrZH6VHGIWQSVtgOkjppJt/SM8zNBzpVDSnEE=;
 b=aBlW31W7VlgJ5AsXrBZmaLltqeEywCy5V78AvV1ber6pNDjxleMUFBwSERrHOzsEowBiQS+Dg
 9BXv8znX8H+YBDE8EJj4yfBs+ksYEtUvszYrzWcaJAIayy/5gxztbqsgL0uR2Kd8p7ZHeGjSDxL
 zdlcmTYrelygm0qt++qodmmtPCTl4Jp6cKT9znHuNnunakSqewyGvqDNUrGACg76TrRffJHZYFB
 OTpq74EKRRZ1ozaRKC4Q2JB9ka1Ihif76HRUFu1zRc1YdnJBFHntEcopXSdFDJtQHlBtqhHkFu4
 uM4jGv3ISwH9Pdka8XpVVsPuKpAc0Im02L7aG1tLzujA==
Message-ID: <b76e04ae-eeef-4c97-9930-c8f59d5051d4@kwiboo.se>
Date: Sun, 29 Sep 2024 00:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/30] xpl: Define CONFIG_SPL_BUILD only for the SPL
 build
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>, Ian Roberts
 <ian.roberts@timesys.com>, Nishanth Menon <nm@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-14-sjg@chromium.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240928200030.194546-14-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66f880d9ee3ee57cb79315c8
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
> Make this define mean SPL only, not TPL, VPL, etc.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  scripts/Makefile.autoconf | 4 ++--
>  scripts/Makefile.xpl      | 9 ++++++---
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 

[snip]

> --- a/scripts/Makefile.xpl
> +++ b/scripts/Makefile.xpl
> @@ -21,9 +21,10 @@ include $(srctree)/scripts/Kbuild.include
>  
>  -include include/config/auto.conf
>  
> -# This file contains 0, 2 or 3 lines
> +# This file contains 0, or 2 lines
>  # It is empty for U-Boot proper (where $(obj) is empty)
> -# For any xPL build it contains CONFIG_SPL_BUILD=y and CONFIG_XPL_BUILD=y
> +# For any xPL build it contains CONFIG_XPL_BUILD=y
> +#    - for SPL builds it also contains CONFIG_SPL_BUILD=y
>  #    - for TPL builds it also contains CONFIG_TPL_BUILD=y
>  #    - for VPL builds it also contains CONFIG_VPL_BUILD=y
>  -include $(obj)/include/autoconf.mk
> @@ -31,7 +32,9 @@ include $(srctree)/scripts/Kbuild.include
>  UBOOTINCLUDE := -I$(obj)/include $(UBOOTINCLUDE)
>  
>  KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD
> -KBUILD_CPPFLAGS += -DCONFIG_XPL_BUILD

This change look strange and this line should have defined
CONFIG_SPL_BUILD prior to this patch.

Regards,
Jonas

> +ifeq ($(CONFIG_SPL_BUILD),y)
> +KBUILD_CPPFLAGS += -DCONFIG_SPL_BUILD
> +endif
>  ifeq ($(CONFIG_TPL_BUILD),y)
>  KBUILD_CPPFLAGS += -DCONFIG_TPL_BUILD
>  else

