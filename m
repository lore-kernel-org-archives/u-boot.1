Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4F3C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32202871C7;
	Tue, 19 Dec 2023 17:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tMAUZym/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A713876E4; Tue, 19 Dec 2023 17:30:11 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE4E87561
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso56512625e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703003406; x=1703608206; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I37BfProkbUipmqo36X32ZdLhmG5uPtbDM+Bt1EH1iY=;
 b=tMAUZym/LPginTDeD2H4r6vrC/+Xa4/wMIkwoYdk0GLWlIIks/YofF5w8t6aFuH22r
 R+dywetk/rCYNq9NkLkUkh3iiUSTmyZlCgKnkMCgUHcv9QdryAYYIo5jDgMfnJhtSlEZ
 4w9PVG/FdYm83OIX3F0Sk6AGYMAzaXKxPfqUhiQaGo/RlHIaMLkongddZ1/LGFjGaTTC
 HzCt8O16kNQq9xr8+GRdYWJV00lQ6lSmwsPfNdRv2R/jcjdKJH/HJNPdLJBn4wSUcjxI
 Z99fASU3bUx5lGXqk6WcgvjkF/0KFduv1QECqb3WSNVLEqEfYMCvHEDP/BmKcUYCWCN9
 X/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703003406; x=1703608206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I37BfProkbUipmqo36X32ZdLhmG5uPtbDM+Bt1EH1iY=;
 b=FjJlrd0N3Nmu06kxbztO0NHANLyM4psXeF0+cm4Ddf6e9mEjjYeHESXZiKyClcmtso
 BUcjcY65pOneRicVSD0kOOVVidpJHx2SVcSE5GehmRO5jumFvwZPfYLqQDuDMRRtJrWj
 GfqUJvX/wlNVUXsSnKepB+dgxLkp+QwMZYzxgUHK3CQcS3DTs0U7HMDYjzugnUBCSm7f
 mScW4uwTygeCRndv0i8lGmKsBHkcfVfdkyKcwKcajVZ2bhrKCCvTOE2I9Qy4jbkcfYa9
 sz2hDcD/GMI9onywowhLDHX4XXrJ25JKpGUhy7MQjO1cTHyvc3ZtsXm7tQ3d5euTOJzZ
 rB6w==
X-Gm-Message-State: AOJu0YwAL7jGYP9+FpJ2pWazjpxLriW2HD7HfYxwG+O2ostgPRLi/BCS
 j5MhCPykdN+SDtudrl+QCU5z1A==
X-Google-Smtp-Source: AGHT+IE7hJc6uYLo7A09xxf6jBo6PiQopHscEEdCrdzF6vy5c9YElq2RSZh/YHWZJBUHAr3sc9LUGQ==
X-Received: by 2002:a05:600c:ac6:b0:40b:5e21:d361 with SMTP id
 c6-20020a05600c0ac600b0040b5e21d361mr10703603wmr.106.1703003406391; 
 Tue, 19 Dec 2023 08:30:06 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a05600c4f0200b003feae747ff2sm3584702wmq.35.2023.12.19.08.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 08:30:06 -0800 (PST)
Message-ID: <5cc0e3dc-2fe9-4788-9d76-bf0e64d8fdf7@linaro.org>
Date: Tue, 19 Dec 2023 16:30:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hmibsc: Enable RAUC support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, laetitia.mariottini@se.com, pascal.eberhard@se.com,
 abdou.saker@se.com, jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
 <20231218072428.1802969-6-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231218072428.1802969-6-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

Hi Sumit,

Please add a description to this patch (what is RAUC?).

On 18/12/2023 07:24, Sumit Garg wrote:
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/configs/hmibsc.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
> index 04052ed6dee..b614dec7870 100644
> --- a/include/configs/hmibsc.h
> +++ b/include/configs/hmibsc.h
> @@ -16,4 +16,42 @@
>  #define PHYS_SDRAM_1_SIZE		SZ_1G
>  #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
>  
> +#undef CONFIG_BOOTCOMMAND
> +# define CONFIG_BOOTCOMMAND \
> +	"setenv devtype mmc; setenv devnum 0; " \
> +	"test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
> +	"test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
> +	"test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
> +	"setenv raucslot; " \
> +	"for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
> +	"  if test \"x${raucslot}\" != \"x\"; then " \
> +	"      echo \"skip remaining slots...\"; " \
> +	"  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
> +	"    if test ${BOOT_A_LEFT} -gt 0; then " \
> +	"      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
> +	"      echo \"Found valid RAUC slot A\"; " \
> +	"      setenv raucslot \"rauc.slot=A\"; " \
> +	"      setenv raucpart A; setenv distro_bootpart 6;" \
> +	"    fi; " \
> +	"  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
> +	"    if test ${BOOT_B_LEFT} -gt 0; then " \
> +	"      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
> +	"      echo \"Found valid RAUC slot B\"; " \
> +	"      setenv raucslot \"rauc.slot=B\"; " \
> +	"      setenv raucpart B; setenv distro_bootpart 7;" \
> +	"    fi; " \
> +	"  fi; " \
> +	"done; " \
> +	"if test -n \"${raucslot}\"; then " \
> +	"  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
> +	"  saveenv; " \
> +	"else " \
> +	"  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
> +	"  setenv BOOT_A_LEFT 3; " \
> +	"  setenv BOOT_B_LEFT 3; " \
> +	"  saveenv; " \
> +	"  reset; " \
> +	"fi; " \
> +	"load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
> +
>  #endif

-- 
// Caleb (they/them)
