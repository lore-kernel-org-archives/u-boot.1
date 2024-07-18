Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72C2C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA85B88633;
	Thu, 18 Jul 2024 15:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e+E7kMrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F9B88636; Thu, 18 Jul 2024 15:28:29 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364A288548
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so4940206d6.3
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721309306; x=1721914106; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcdECpK4+D9/UIsoAyvnYobgpsjTP5Zd2Z3ucx9k134=;
 b=e+E7kMrrJzg7fcvh9KtdC1y2X0Zc/KIj+Np2BV3rEuH/6NAwUdryuUm/j3iaLPm4jS
 GP5pXv+nPTSknk89frcEhphpyQ8Irc7Z1aDmX6xnydJ4ymXxUjN+k6n7XLSbe0sUyZ8C
 FgRV2rvFCex3gq2K8pjprsQwug/hTviI7UPOAgc6uK4MW/D0t8Si0SPUju9gy+KUL3S8
 QlLhq7PTgcD+Ji3S0+na6nLFm1W8EZZt6iTTlQsKwyGk93R6Q9f055MEBEgh6POf2TUx
 R+/qiCW8KCLiJUKJxGzdmKahqjLDS0wIiYySB3RguavN2ckIaxcaa3Rd64aDdMphlu+H
 fS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309306; x=1721914106;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcdECpK4+D9/UIsoAyvnYobgpsjTP5Zd2Z3ucx9k134=;
 b=g/1mqdEuJq8zVZnEkb+pz7Zt0BMFmPRX+5iHJWaAUOA7VFnfXPuFwJQq/2a8HTFMPc
 9shJ69KDQzIct26bhHVcFQxWgMGk0Q/f0alwlPXo8WrBWJoJ8mJ80i1iJj2JOMOkyo57
 Uqn9J9bJzrtfthM6fp1KXV/NiULWDLzsKcWCxqN+p2fcL7lxewAERI99aNAhooN6Ql81
 RJpSrv1kOHsBr27ZNG/hrecrsPx7qCIyKa4bUKD2Z6GIc/Ocn+btGi5qTOC+e0yvFQhs
 E0jbry99foY2GgS5A9+8o5WyuH4cGFM/RHrs9p5A4uCgoOibzI8vBa9U+gu0oH0EAkOS
 US2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUae0Td8278QnHbG+ec3Gu5MgiAmF7QcYqJ6QtlSMJUdO9UDYYjd7JeVRfhl5CFs/ErOAPc4Vz1qLq6a9s+KBShoX+Nig==
X-Gm-Message-State: AOJu0YzV30pn3cVrz+9GRdvT0fNZcO0RB0WeAeoSYaSjCPGT4KYoQ+fm
 lB9jGQkfZBc5VZcaabaGO113r6c6DQEuQZYWC9/tkxKnO+bjLwsg
X-Google-Smtp-Source: AGHT+IGMiLlG+prgI9aS5/u3RH2s54qesOeQyulRuRpokozJYMTdzWtqQAeKzx96gD8q7SZdLbg+hQ==
X-Received: by 2002:ad4:5d66:0:b0:6b7:a3f1:3248 with SMTP id
 6a1803df08f44-6b7a3f1341amr11482016d6.25.1721309305974; 
 Thu, 18 Jul 2024 06:28:25 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c675468sm7939736d6.133.2024.07.18.06.28.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 06:28:25 -0700 (PDT)
Message-ID: <26f6d85c-7d22-fb2f-d18b-5adcf494bc34@gmail.com>
Date: Thu, 18 Jul 2024 09:28:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/21] sandbox: Enable SPL_LOAD_BLOCK
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-5-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240713070055.2172883-5-sjg@chromium.org>
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

On 7/13/24 03:00, Simon Glass wrote:
> Enable this option for all sandbox boards so that the FIT-loading code
> can be used without generating an error about block devices not being
> supported.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   common/spl/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index af43b5f5d3c..970a4a346e4 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -288,6 +288,7 @@ config SPL_BOARD_INIT
>   
>   config SPL_LOAD_BLOCK
>   	bool
> +	default y if SANDBOX
>   	help
>   	  Support loading images from block devices. This adds a bl_len member
>   	  to struct spl_load_info.

NACK.

Enable one of the many configs which select this one instead.

--Sean
