Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3019ACA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 17:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEE3360824;
	Tue,  6 Oct 2026 17:34:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DWV9vXLGyopf; Tue,  6 Oct 2026 17:34:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D104F607E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791308048;
	b=XDOdDgFPSU+vwPPH5X0YGsAEuwwAwflbSZLt2F5aOKSLTpxUTwi9hJ/wjYGy/VUwXgHG
	 gXlW9bWoGloMNx1c+GP6LUuhxNNqdJKZC7w3p+lEcX122/ZxI2FvF0keaMXKJvAOittd+
	 jmDglKc2EP8FD8gWPjCql0Mv+fozvxBtGUsSQmqnwiQlM4ohG3V/X6HIqoKovwl5SlYT0
	 Hk6jmtGnDvekRCPExWee2CD6lx0Hl8ma1zRNK0MMlqTZyfDwGqo8svG8CCzLnTvgSOj20
	 dUvqpNAohMs3Fbl7zmEEK6DVozQf9bl2//MomdvnJPOfL1iAOt9S4lgzoHG5Cg6zn0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791308048;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vadrgfRktuyLQIPWEWJh7KdheMW3ESUO5elvbp2N9iA=;
	b=YZaRGUY0sA7Tv0cu7x0lgbbtvhb18nz996UZq+cgs9V1/2/i/EQWy2G+GMOl/OCIpfG9
	 81FvxtcNWq5U3/ZSVQMaC1pNh6ZnBUb7TQQKUfMTiuzDT1PUKgjhGkukmHJZVatPUv5HB
	 cX1J79OsUxPXIL729PLweu6aZJ4sObgdecXS5bvUyO+9CKsFL12RtbOhvmaHijkPmF/l9
	 5o7FGLgqYOEkURrOJZN88II+f5y3FLf8DdpHCUW4nuhy/C/dvZ+M2/pDeSPFxB0TdEzsG
	 Gs7CkZZ/75w3rvEDsVoiJJvdCJxcaJaPWdDW19Ewafk9Ji1HQZkqMcJ5W92MAPSCfMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F74MUbUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791308047;
	bh=vadrgfRktuyLQIPWEWJh7KdheMW3ESUO5elvbp2N9iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p9XQN2SgQHuqX0Rge0/cUDAboApQ0xpjP2PaJlSbzexXzoVIj5WFyTh+62Ot3/BkO
	 4IwWQ2AKk4lkYTuraXCYwYck5Inx0vGJmCBzvNDdbWKLnXrkFTVg5LMSsmtzweuZmr
	 v08GjEMKW7S+3d93lz6T6yrH7hl25iSddV/NU1S5A/r6eDCUIZbTujLQqn9hlLWKcD
	 6aglrpvOVIlPPlKaYnP1LcbJ6hnI/pIFtYoCmTIjxXr26tX+xYLMZQyLEeW4AMlt/N
	 Yxj4T10Qtgcz4MnI3t03haL0oOwFPZGGmwvpJXw5WWKIucaoK878AMiiL07On2l7xR
	 Uv0LT4jbRoioQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D104F607E5;
	Tue,  6 Oct 2026 17:34:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90CF622B
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 17:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767CC607FA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 17:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pLhMqBwkeAlh for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 17:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 18AF6607DA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791307720;
 b=kZA/ox/zAxLTXuw7vbdvIF8wBWMm3Rl0FG0SG6hiyWPV0FgyI3jhZH+2437Ti2QZucSr
 dmQNYY/1wcSA7OgZPYy6OGmAvEkiQLWwEDovZrW08FvvaRAseSm38+5hKxgc3p9Ks1EKf
 JRZTG7uXEy7sZKnur9Y0uDqxqMP7hjgyHRKYZq3t53d45mvPGuxTh829qiCEAZHWsxbe2
 mALZlimPteC7xFqFqJSPx3fTHPsYQMQT775YYDpLUbs0o9gM4ENAbBZuqtppzYwjeFGDL
 hFCK+tbZvoNM61FQdxIoNp9jeE9jAncFfUPFwcjeYcPdX4BSukHLIY8xi1wJZUkbwXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791307720;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=vadrgfRktuyLQIPWEWJh7KdheMW3ESUO5elvbp2N9iA=;
 b=q0gMXLKSlcxhC0aAX1CBQesf4uPI2+8EjbM6s3k7P+9CTol9xThKDRRXtRC1tFUy0aIJ
 hLNzRsTrtE+0ufCnyeRDRpbDfEESzZIcF29EDsvzHiE17dPToQGZZeB/otpsoV+U6IreI
 8Itc7cwFZNPLHZ/034LrJZ4uSWEKe+WrvCESmU0IwnNcy0P6Sg57rE7WYUziUaYl2oAQk
 FwVZ7siwQkrvfE7yldhkkaUM2lXDs9uGZ8Hhv9EKaIC0iaHaGFbO+2iForyLg4YRIhmuo
 dre7xr70H4NwKw98IjGWVIqW9At83C1/amkp12gDnW6krZhOpx2iSdMbxjyo1wbt/Gw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=F74MUbUk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=F74MUbUk
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18AF6607DA
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 17:28:39 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3a89d1ca907so52581a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 06 Oct 2026 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791307718; x=1791912518;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vadrgfRktuyLQIPWEWJh7KdheMW3ESUO5elvbp2N9iA=;
 b=F74MUbUkPBaCIvo1hHcV2Td/P3v04UNjPmS1SBiy9A1Cs8LklZE841A4IC1LLwiZ9N
 jju1h1xXW9FlmqZxfmeKcoMuo0A+MDVDb6+qZ9Q5p++MLOssNJC7YqTNDKeFxCzi9Uw3
 CQKxStNl9P7UVFYs4e8YgdjQjjEXJ0PkW+1UpkaAtbZPjThacqYvvff1seo8qCmjd8jH
 2Oh0hYMYVD5eq9oAYRyKlVpnYCz7OhodXfaKR9ehZNK0TdpG8utApLoQ+8WkWdzy+D1c
 WDy8VFLQcjZ3CXPufV+TbfUD3e94hAS8tMlJT0krxPj0Wky4rLsM5sLS1JJB3iEOqszJ
 XgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791307718; x=1791912518;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vadrgfRktuyLQIPWEWJh7KdheMW3ESUO5elvbp2N9iA=;
 b=XnzVha5s9s+ia9S1INhIHZBt6z2vD92bdzj8RzQBoRyRnEbjnbLeiv/rZSx0K03k3K
 MeLr/Hw+um/2N2D4bPeeFDCcQC4MMpXixlMJmlxpjFRXFiFpVuQWmC1u+7AsYm0BqXn/
 6PQ9n8T54s7qKC9K7JzwK0E5bqlZNh9K0B6gjotoLEWJJjnKeEZZyz9DoDd/yiKKcbDK
 bqqzqvzGtmw/xe5q6Oqn+J3Ll1JghxIVdjqZLXNzM7W53pDMNYB1ZVYHwFRMviBcpngL
 YWKsvzOL2nM2LY7+2peCLNoXtPcN5UXe8LyVRo4BKltvjSc3TTAEOLF7k6I38s4bGeuG
 umAw==
X-Gm-Message-State: AFq9FYLwy7wmbLverLYcDAiVy85EQu2wJnmlNpDwGrr7h/ehmyx2iUf/
 PO+bJahZNOhOXtf2pjRHxv2Hyi+rsA44fXLwhrVHjPBNdhjoqW22JgZNMtkA9pbqdII=
X-Gm-Gg: AYBFou2Zbh0BSS0iZBR7hDyy6+hI84B0eNEm1Ue1ZVsceNVRbxOVgTBIz/crSWEYW0F
 o9Tz573pf/N4zkZgvwpEBfADc5oMpoJPaC644q6rsPIQJQ71XPJ8c/LJ278dAVSySnbgDsKoyg9
 qsswiE39w/yxhbUIoggl5YUPT/ToJZAV1RwsM10A+FcAcoSzYmgvsUAZV0CWyiT4egWithaW82w
 6pdpzKFy6DZOGPq++ROEXGo+nL1qTw0/FUSFsvJnVU0xVTKk07d1UW31KvoTLf+juay+GrJZCX9
 5iPjt5dDLy4uCTgZjAEgU9MgZW4yZqezd8wpy1CE0nsaf+nY5nN8LPh7vhm4fpOMN6NiR2JGtr4
 DHdWwlqzkLI860s2tqRYIM6AU0OTioP6kh3QFwWZbVfeXMko86P2nJ47XRP7pet+SX1B3aQDjqm
 8696ZhwvtpiEeZFJK01pFM7C9mSqDdo6NYa/0dREi/5ze3FiSf958EE35uQIOERysRK/rquktMc
 MGVZnD70DO8Gf+obOXBFEcLFM7T4LCu
X-Received: by 2002:a17:90b:2742:b0:3a6:dc51:cce9 with SMTP id
 98e67ed59e1d1-3a87373de73mr1753687a91.57.1791307718352; 
 Tue, 06 Oct 2026 10:28:38 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::ffae])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a89b625d01sm425476a91.14.2026.10.06.10.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:28:37 -0700 (PDT)
Date: Tue, 6 Oct 2026 14:28:28 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>, 
 Alexander Koch <akoch@initse.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Leo Yu-Chi Liang <leo.liang@sifive.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@nabladev.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
Message-ID: <asUuBvxgzECTfr7l@hiagonb>
References: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
 <20261006-cv18xx-rtc-sysreset-v2-3-67872888384e@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-cv18xx-rtc-sysreset-v2-3-67872888384e@zohomail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Oct 06, 2026 at 11:45:08PM +0800, Zhuxu Ran wrote:
> The CV1800B system reset driver uses hard-coded RTC register
> addresses. Initialize a register map from the RTC node shared with
> its parent device instead, and propagate register access errors.
> Require the RTC driver that binds the sysreset child. Preserve the
> existing reset requests, including the warm-reset sequence used for
> SYSRESET_COLD.
> 
> Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
> ---
>  drivers/sysreset/Kconfig            |  6 ++-
>  drivers/sysreset/sysreset_cv1800b.c | 90 +++++++++++++++++++++++--------------
>  2 files changed, 60 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
> index 16ef434a8d9..c9f2a552b47 100644
> --- a/drivers/sysreset/Kconfig
> +++ b/drivers/sysreset/Kconfig
> @@ -60,9 +60,11 @@ config SYSRESET_CMD_POWEROFF
>  endif
>  
>  config SYSRESET_CV1800B
> -	bool "Enable support for Sophgo cv1800b System Reset"
> +	bool "Enable support for Sophgo CV1800B system reset"
> +	depends on RTC_CV1800B
>  	help
> -	  Enable system reset support for Sophgo cv1800b SoC.
> +	  Enable system reset and power control through the RTC subsystem
> +	  found on Sophgo CV1800 series SoCs.
>  
>  config POWEROFF_GPIO
>  	bool "Enable support for GPIO poweroff driver"
> diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
> index 9cd62772ef4..fa76c8cf38e 100644
> --- a/drivers/sysreset/sysreset_cv1800b.c
> +++ b/drivers/sysreset/sysreset_cv1800b.c
> @@ -1,64 +1,86 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + * Copyright (c) 2026, Zhuxu Ran <zhuxu_ran@zohomail.com>
>   */
>  
>  #include <dm.h>
> -#include <stdbool.h>
> +#include <regmap.h>
>  #include <sysreset.h>
> -#include <wait_bit.h>
> -#include <linux/io.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
>  
> -#define REG_RTC_BASE             (void *)0x05026000
> -#define REG_RTC_CTRL_BASE        (void *)0x05025000
> -#define REG_RTC_EN_SHDN_REQ      (REG_RTC_BASE + 0xc0)
> -#define REG_RTC_EN_PWR_CYC_REQ   (REG_RTC_BASE + 0xc8)
> -#define REG_RTC_EN_WARM_RST_REQ  (REG_RTC_BASE + 0xcc)
> -#define REG_RTC_CTRL_UNLOCKKEY   (REG_RTC_CTRL_BASE + 0x4)
> -#define REG_RTC_CTRL             (REG_RTC_CTRL_BASE + 0x8)
> +#define RTC_CTRL_UNLOCKKEY	0x0004
> +#define RTC_CTRL		0x0008
> +#define RTC_EN_SHDN_REQ		0x10c0

Looks like the tabs for 0x10c0 are not correct.

> +#define RTC_EN_PWR_CYC_REQ	0x10c8
> +#define RTC_EN_WARM_RST_REQ	0x10cc
>  
> -#define CTRL_UNLOCKKEY_MAGIC     0xAB18
> +#define CTRL_UNLOCKKEY_MAGIC	0xab18

This line change is purely cosmetic. I think it is fine since you are
changing all the other addresses, but I just wanted to highligth it. 

>  
> -/* REG_RTC_CTRL */
> -#define BIT_REQ_SHDN       BIT(0)
> -#define BIT_REQ_PWR_CYC    BIT(3)
> -#define BIT_REQ_WARM_RST   BIT(4)
> +#define BIT_REQ_SHDN	  BIT(0)
> +#define BIT_REQ_PWR_CYC	  BIT(3)

Same here, looks like the tabs for BIT(3) are not correct.

> +#define BIT_REQ_WARM_RST	BIT(4)
>  
> -static struct {
> -	void *pre_req_reg;
> +struct cv1800b_sysreset_priv {
> +	struct regmap *regmap;
> +};
> +
> +static const struct {
> +	u32 pre_req_reg;
>  	u32 req_bit;
>  } reset_info[SYSRESET_COUNT] = {
> -	[SYSRESET_WARM]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
> -	[SYSRESET_COLD]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
> -	[SYSRESET_POWER]     = { REG_RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
> -	[SYSRESET_POWER_OFF] = { REG_RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
> +	[SYSRESET_WARM]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
> +	[SYSRESET_COLD]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
> +	[SYSRESET_POWER]     = { RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
> +	[SYSRESET_POWER_OFF] = { RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
>  };
>  
>  static int cv1800b_sysreset_request(struct udevice *dev, enum sysreset_t type)
>  {
> -	u32 reg;
> +	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	if (type >= SYSRESET_COUNT)
> +		return -EINVAL;
>  
> -	writel(1, reset_info[type].pre_req_reg);
> -	writel(CTRL_UNLOCKKEY_MAGIC, REG_RTC_CTRL_UNLOCKKEY);
> -	reg = readl(REG_RTC_CTRL);
> -	writel(0xFFFF0800 | reset_info[type].req_bit, REG_RTC_CTRL);
> +	ret = regmap_write(priv->regmap, reset_info[type].pre_req_reg, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, RTC_CTRL_UNLOCKKEY,
> +			   CTRL_UNLOCKKEY_MAGIC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, RTC_CTRL,
> +			   0xffff0800 | reset_info[type].req_bit);
> +	if (ret)
> +		return ret;
>  
>  	return -EINPROGRESS;
>  }
>  
> +static int cv1800b_sysreset_probe(struct udevice *dev)
> +{
> +	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
> +
> +	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	return 0;
> +}
> +
>  static struct sysreset_ops cv1800b_sysreset = {
>  	.request = cv1800b_sysreset_request,
>  };
>  
> -static const struct udevice_id cv1800b_sysreset_ids[] = {
> -	{ .compatible = "sophgo,cv1800b-sysreset", },
> -	{},
> -};
> -
>  U_BOOT_DRIVER(sysreset_cv1800b) = {
>  	.name = "cv1800b_sysreset",
> -	.id	  = UCLASS_SYSRESET,
> -	.ops  = &cv1800b_sysreset,
> -	.of_match = cv1800b_sysreset_ids
> +	.id = UCLASS_SYSRESET,
> +	.probe = cv1800b_sysreset_probe,
> +	.ops = &cv1800b_sysreset,
> +	.priv_auto = sizeof(struct cv1800b_sysreset_priv),
>  };
> 
> -- 
> 2.55.0
> 

Best regards,
-- 
Hiago
