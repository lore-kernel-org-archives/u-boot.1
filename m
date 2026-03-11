Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CCA1125863
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0F184166;
	Wed, 11 Mar 2026 19:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ir/2poU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5830984175; Wed, 11 Mar 2026 19:11:51 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 024D78416F
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso143559f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252708; x=1773857508; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vre8CLsqI4vWNUUfYCtvla/tvnlJy8aDbjOULJUcFfo=;
 b=Ir/2poU3ZqPg53ll15KVe72ShuZJolNj3TejC15rS2WsE3TfxdYY/TiHUSIgovvksE
 MFIvEHL/0QnNmKHWBq56JnCDjLEVI6offWqIzD622XawXC9LWc/4FEWrDpLVDQ1YH5+m
 +TT1e7TQgsUFJBrquuHVqlfEYTgQ6jl26T9/IU08QmZdMWNlFZQ5vRXa1+p0OeQIQ17R
 BXJrvrGdSJZStLE5Un955oI2dmTsHjLZJQIJ5uvkCxiAfcrRQZ8Z4+QEoT6wh86+7aQB
 pSpMHPVxNnyrtKKX+3de9HU1A4gPaGZbAZ5F2M1QIVK8vyULmShc215HjOcK48h0Ltk3
 qwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252708; x=1773857508;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vre8CLsqI4vWNUUfYCtvla/tvnlJy8aDbjOULJUcFfo=;
 b=aVQSRRb/wOgt76iqahyeVcEi96a3DFS4J9doOUheq2TNmfrOd3P4nFwgkf+Dm1r4Fy
 MoGyYNgipaaUAbAcHFb0RyCt58Fy2971iV2UcCFKQdL7jy0z9M5BIv1PLeo63LfrnjyY
 U8rsLOcg8VUTx0PxISmnUnSEqQjx/Xl2kkoUmb8unkbWRidM8425ZPDBv/zR8uqGyW8F
 I212aVo3KdVdSJXUY3KQEOyv5eZS1yptzrFt7J7YXUv3a0IsQ6lCzHxnVge5E9f7nEvj
 27BZLcDC7QxCqALZ8eZg97zocqJQ+9eyM2PVrpiHDEMAhtW3u7kDndkVLbVagXk0B5mH
 zyGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdbS4q6jujrS5pPCbQ9c/McMM5Vk+kDGywwn5RfbGnZBp/pbRwyBpjkviN8DyM8qJNlGvNbpw=@lists.denx.de
X-Gm-Message-State: AOJu0YwECjF3cEELvqTkxzWkflT7QCWE5AE79yaa7aGGbqT7ZXTebdXL
 7mE2dHZgdNS6tdGb+gMZUCXJeXtq3zmW1p0TDlTUlWBq4yCJN5eG27fHIDawbg==
X-Gm-Gg: ATEYQzztUbix2oTmDFrMCDwtCXOg5jBBAYiZytP0xOgJAT/pSH5BUCDXmB5Q+bx58hv
 +r/JOG9wfWWo2oTp4BeaoXLc1H+T1y8qa2Ml1NKltYf+fSWjdNwpESETtzbBUj+vwGoD6egkxkK
 yxzwW016YHNAYLWlGGuT66nCJSy62FrCL68e/KbAmtxxmXIw6uPuWFYJHdgtOet8dv7ZoKuGg+w
 sx7gZGwooi+h6KLSEYt6m7Q86Zh84+q1tyfoYDHjJUho3/72bG+YDdgEzB5eOV+tnikQp0ABlqp
 lew3/Z4EwGlTfrl2C+iEEYYg2wQ1ITxCjtxSfLi/UNPBWw3UzxM5xkjo6IZhwQobXlzvgbMmQQ6
 FvrZtBXY90Vnw8IfEnMfuQyptBsurVxfmEddQYPSl96qXAEOLoI3A9+S0MU0WmlnUtouXTVhBHp
 veNiOVEfReWLBbizyfb1zqji3SvcP2JK/ZU4Ykx+KYdEU1np3wiBTgaYIYgHnXoRVICqhTFVoxn
 Ew=
X-Received: by 2002:a05:6000:2505:b0:439:d7e1:fc51 with SMTP id
 ffacd0b85a97d-439f8222f84mr7250873f8f.36.1773252708248; 
 Wed, 11 Mar 2026 11:11:48 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1a78cesm989583f8f.11.2026.03.11.11.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:11:47 -0700 (PDT)
Message-ID: <361e8d81-510d-4e16-9aca-294a1dc0637f@gmail.com>
Date: Wed, 11 Mar 2026 19:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] mips: loongson: ls1c300 board support
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-5-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-5-sgdfkk@163.com>
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



On 3/11/26 09:41, sgdfkk@163.com wrote:
> From: Du Huanpeng <u74147@gmail.com>
> 
> - 64MiB SDRAM K9F1G08
> - 4MiB spi flash
> - ethernet DM9161CEP
> - UART2 console
> 
> Links:
> https://dfgh.top/loongson
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   board/loongson/ls1c300-eval/Kconfig     | 12 ++++++
>   board/loongson/ls1c300-eval/MAINTAINERS |  7 ++++
>   board/loongson/ls1c300-eval/Makefile    |  3 ++
>   board/loongson/ls1c300-eval/board.c     | 19 +++++++++
>   configs/ls1c300_defconfig               | 52 +++++++++++++++++++++++++
>   include/configs/ls1c300.h               | 36 +++++++++++++++++
>   6 files changed, 129 insertions(+)
>   create mode 100644 board/loongson/ls1c300-eval/Kconfig
>   create mode 100644 board/loongson/ls1c300-eval/MAINTAINERS
>   create mode 100644 board/loongson/ls1c300-eval/Makefile
>   create mode 100644 board/loongson/ls1c300-eval/board.c
>   create mode 100644 configs/ls1c300_defconfig
>   create mode 100644 include/configs/ls1c300.h
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

