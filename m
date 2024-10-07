Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C7ECFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6D488B11;
	Mon,  7 Oct 2024 15:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IBNpFdkK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FC788AE4; Mon,  7 Oct 2024 15:36:55 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9712B88CBF
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c87c7d6ad4so6128933a12.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 06:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728308213; x=1728913013; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XhDvd9pHs48YOPhkkqgow8S21VAJJTy+qTi/D2Ok8j4=;
 b=IBNpFdkKJET/fmORCAk4XkGLdL4/GNEdZQQxniVj0iEH5bE4ZyN4At0wrCxZ4cYn06
 k8EWctF2sKYcgpoYqA1ZbT9FzItoOLhnBk+7oOVlRFjarFthpw5eeDRK2Gqd9V6bvcHD
 +htOtk4ddpgbr+2/c0bNI6xCTfxgoy6e7mnk/ymMOW3PXf6mAWJzE463uh0fonPnki4A
 5kLUpyKucyccvS7gfxbLkypIzliMZ3uVirAZuGigJ67O7q16HT3SZ7sjqRYY1pAyI4Xw
 2sVZH1Nr3/FuMHULT6RtsI+14YvfEtC0oALnWrJOJ/+3WuS13tw0LnHCqAlRSP3opopW
 RMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728308213; x=1728913013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XhDvd9pHs48YOPhkkqgow8S21VAJJTy+qTi/D2Ok8j4=;
 b=qyEMmbO2bCXgGucIc9X6IpHTpC6OPlmTpW9A6/ZqTrZhtfNPMEQO1AHbslgIFbBJ4+
 ZPjnNqECMl4znt49MD4kJywaP1DMh4Re6HXN919KfawjoSK6Bk9neq6lG3W5ivpJLDJG
 Q0utXxPW0YZK0UY5PNGOahiJR6tptrIJNpb0Dw32u1Q5GKhyaJKoV457ladOnJkYbCjB
 hNronU6X+3iHNLkB9M3U0jlkbczwM8vQPVLPqFunDfy3aKax8QkFabqEbb9AtoSJEEnN
 BnLe2JYhgVNxMfQhvaVFfmqPMI0PYlWvvkFHDGPQoyvRvrH3OD5tDNC26m+ztmfBBdVB
 0BbA==
X-Gm-Message-State: AOJu0YxobVu2tXb+t6YeN9ma2gfZ/MuYO1Kcbu0wybY7qJdl51rTPwgd
 OsFJk5BT+ZgQV8UV+Un14B5vGwoe8wz55OQ3F5FFIiROoH0lm7o7Cy22iEqkp53J90sQORuEtLV
 OnPVJQw==
X-Google-Smtp-Source: AGHT+IGUXRjogNFPx5wdV+N3+mVEJzeufQlaBCuhchvL0b9eHBVUt1j5GfVIyXtFFqhtd5GBYk1yUg==
X-Received: by 2002:a17:907:3f16:b0:a98:ec66:5e3f with SMTP id
 a640c23a62f3a-a991c053bcamr1338194266b.58.1728308212822; 
 Mon, 07 Oct 2024 06:36:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75?
 ([2a01:e0a:3cb:7bb0:6f4b:a50f:5140:7b75])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994254846dsm287106966b.131.2024.10.07.06.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 06:36:52 -0700 (PDT)
Message-ID: <7a2d12f6-0357-45a8-94c5-120472d3d6f8@linaro.org>
Date: Mon, 7 Oct 2024 15:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 for CPU_MIPS64
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241003142030.1610222-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241003142030.1610222-1-jerome.forissier@linaro.org>
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

On 10/3/24 16:20, Jerome Forissier wrote:
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. Fixes an issue found on malta64 with QEMU:
> 
>  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>  31                      if (!strcmp(name, entry->name))
>  [...]
>  ld      a1,0(s0)
> 
>  (gdb) p/x &entry->name
>  0xffffffffbe04b0d4
>  (gdb) p/x $s0
>  0xffffffffbe04b0d4
> 
>  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8f1f4667012..8f4df849801 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>  config LINKER_LIST_ALIGN
>  	int
>  	default 32 if SANDBOX
> -	default 8 if ARM64 || X86
> +	default 8 if ARM64 || X86 || CPU_MIPS64
>  	default 4
>  	help
>  	  Force the each linker list to be aligned to this boundary. This

Superseded by https://patchwork.ozlabs.org/project/uboot/patch/20241007094206.2928071-1-jerome.forissier@linaro.org/

-- 
Jerome
