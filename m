Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A5BC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C69283623;
	Wed,  9 Apr 2025 12:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CJNnFs+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532DB8362A; Wed,  9 Apr 2025 12:28:11 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4389383622
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso7130351f8f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 03:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744194489; x=1744799289; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ElJYLrgiaYATiCYlGlZl06Q6W+TtVkSKUo8F35UJ+58=;
 b=CJNnFs+IWVUrp30WlNRA1mvaoY757qRzMDhj4obBkvCxD13RVyid2ZvXGCLyvCO7YW
 zU0SSfy9MtBvltV0Ql7CAXl/1+dlUpWu6c4yBuqOBUYZvnwzI+HWmCFoW2rTzUUQbCA/
 ABZFLFxI9GrV9pkaPn+vi0DLT8qpKDIuFA2OI7SAbLB/jw8NSIEsYjqRIX2a2WyJL7ad
 YxSlC/C4J0qRBLQ71GAg/S8JXy/kBA6NxmyzKUU+/gCQ+xJNmWYR9WeIIobPH70ELH/z
 GdvQ2gbPeZpSjfYvn4yoyD3yccOzNhLGxlvtt8LDsmFNQgQlCMTdwlZ++jXXMBO/DF+y
 YSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744194489; x=1744799289;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElJYLrgiaYATiCYlGlZl06Q6W+TtVkSKUo8F35UJ+58=;
 b=mqmcPFuStALq9qBOXOdxv3ZDtjB6NermJflQy8BGo8MaSEcSS7/8YEEc/uEHDd0rGG
 Jdad9mZNc+ndT4FJwb1tWvwlPAjI6Cc3PsEXXQ+5OIU79k/j7Xio1DMOP6dK9P+GeK64
 3wWT8COBFmSRyxpkGkMOagIp2fAyr+m1aQ6Gyn/VnT3C7BCrj6siwwRobwJcFuEnPgTv
 ZDleiZa0FdgS0wzbBGtfUlOISz03RpyR/vIlqKaxUrGQxzdpKjSOdBZujnbyLQm9WpTs
 kzpBksFyJ4p2zAPoBs7n1xhZU/NDmdpVT7L8cxYbpir9OWGzUHSMjSblTPG8fvb7zzVi
 +wNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX64vUCcnj7ByYhaPiihMPcuM+FbT6dR9Xu/d6DGY0qXYBU2zkOyTGglbgrpS5kOcLfUNgMcvE=@lists.denx.de
X-Gm-Message-State: AOJu0YypRjSHN2BFtqRKxYiF3viQHnWa3XB5FKs0W4Ii2eq5ZVsGKfRr
 tp13iSxQ6YGaM56uBxGqLzVEcpF6LnB28LpSOebvPqhqU123iRZHkh+PD5MFuZ8=
X-Gm-Gg: ASbGnctmXUklYPySW38JxJz7Rzctz2o2zRNuDqlDBBf/4taPTWeMHNtRhmjfm3XHrpc
 yj6VN1SKcdnownhB9lPQfqdtB9KwSTo9DM04R3jYaXDsv1dozxV8pGkwGIzGTbRSWs9Ln087UxV
 8XfAe0gFuUy/+cp/HBlMXn4CvwmL3OF7gF5VWFh0O+wCv1jQwLKNVs/yxc01+UTtuEG7lcM1oeA
 CwarXtc1z+1w1MWoQoHf/skSAV7Dp0Rs1quSxSjwLD6K7A/t5yVRQ/jI0e0gvp990EkROt7cf6Q
 2Z2ZUSb4iW/L00ZB3ZQFoMs//5mWsLw83JZH9Q==
X-Google-Smtp-Source: AGHT+IGbMOrE0A70S6UcGCIC9Ja9RleiyiZwk+TrtcJhKeSsgH96PDV/4pnklf/rSbUUoMqNC/uokg==
X-Received: by 2002:a05:6000:2a8:b0:39a:c9fe:9710 with SMTP id
 ffacd0b85a97d-39d87aa1ad6mr2290585f8f.11.1744194488593; 
 Wed, 09 Apr 2025 03:28:08 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893fdf6dsm1238428f8f.90.2025.04.09.03.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 03:28:08 -0700 (PDT)
Message-ID: <de6de8da-f7ad-4880-a0da-48ccdd30066a@suse.com>
Date: Wed, 9 Apr 2025 12:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] board: starfive: DeepComputing FML13V01 fdt
 selection
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, u-boot@lists.denx.de
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
 <20250409071836.26629-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250409071836.26629-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 09/04/2025 09:18, Heinrich Schuchardt wrote:
> We support all JH7110 boards with starfive_visionfive2_defconfig.
> The relevant device-tree is selected at runtime based on EEPROM data.
> 
> Support setting $fdtfile to the file name of the DeepComputing Framework
> motherboard (FML13V01) device-tree.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v3:
> 	rebased upon Mars CM removal patch
> v2:
> 	no change
> ---
>   board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index b8cd509bc89..5fe888d4072 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -17,6 +17,8 @@
>   DECLARE_GLOBAL_DATA_PTR;
>   #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>   #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_FML13V01 \
> +	"starfive/jh7110-deepcomputing-fml13v01.dtb"
>   #define FDTFILE_MILK_V_MARS \
>   	"starfive/jh7110-milkv-mars.dtb"
>   #define FDTFILE_VISIONFIVE2_1_2A \
> @@ -63,7 +65,9 @@ static void set_fdtfile(void)
>   		log_err("Can't read EEPROM\n");
>   		return;
>   	}
> -	if (!strncmp(product_id, "MARS", 4)) {
> +	if (!strncmp(product_id, "FML13V01", 8)) {
> +		fdtfile = FDTFILE_FML13V01;
> +	} else if (!strncmp(product_id, "MARS", 4)) {
>   		fdtfile = FDTFILE_MILK_V_MARS;
>   	} else if (!strncmp(product_id, "VF7110", 6)) {
>   		version = get_pcb_revision_from_eeprom();

