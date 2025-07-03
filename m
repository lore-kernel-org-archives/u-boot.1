Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3638C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4568C82103;
	Thu,  3 Jul 2025 18:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tObixeDP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C11E801BE; Thu,  3 Jul 2025 18:29:36 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB08C801BE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-739f2508ffaso81947a34.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751560172; x=1752164972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v9QICtWf2LjYF2fNgN6IAgQgQ2YTsIMwAKuBqpebmo=;
 b=tObixeDP+AMG2KJUkRpquk9bWhkDXSLTlKPg2tycCgSoUgRSHUdKywpeXa+0HN4gpP
 rxuCeO+vSATh9zKjWifaKvUNwVtEa4gd1J4EvY43y3PQaNBOUZrgp/lNI4hlHr6/o3Ng
 wYoXFqUAJMLoKKduZ5ArW+E/gLISrjCSb7H7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560172; x=1752164972;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v9QICtWf2LjYF2fNgN6IAgQgQ2YTsIMwAKuBqpebmo=;
 b=vIZs8e2WDoF803tpM2DwAlVwoRpmzD88kWIqSTiQqy648HJ0bdjflrWhS1ewJNPtPW
 w7jwDT+JOENczIXfm9cm5qLYqUqLkXzj9TMlkWEqIV3WGGo2Pkd9qfDM4PBDNmmLTPEE
 9I1fseAriwdpk/9d0HSHYNP53rz+bPhdiuYKP5mN15QBpS/1jsh+FQHXQsiGrmQZm2Gz
 PSeT8tasQQsHLLhXFI6iQV688YEWjO89ZABR1+e0fv0jO6TZImWVS2/u2NgrbXpJnYTq
 wuxUaSJj2HrKarB5SbtDhKAO4PXl2ipy/txxVECpi/b3Yy2G/PnParo9jZoYGeDQxTtY
 1Eig==
X-Gm-Message-State: AOJu0Yxr/F9Tp3RkDxz8TCSQK977fQGyneF11DfU3Efjoc/WxF35AHws
 jvkCWEmgwbhoOOtLX5QY8jY575aoTEvblanC5+ED3thuGtTNc6y35zSABptO58m04vc=
X-Gm-Gg: ASbGncu/CW7AP1clv5KYgBw2sD7yeVIOCGnqvE6l8hSsM3gV5xBz3EJHGE4s8IQkN3v
 kjOn4u7in2CojnJ2n88I0wQNbvtPu4nIkqH4OqzJ+IPJHAa3FrB03TpTObRHi6FpMtnTuMGNLMU
 2TzGuAUhg/467KYRE6OBtivqgl39PCIWWamFG6H2AMsDCrYI68Jgm6uqQKB6tawpM9ix9paa8RB
 6xdjxaJVs5klhO63k0U/jNu2WN9Zq570S89544XZNrGMA0VaSBQXAfseXUFgYVd4LaZlHlOEl4Y
 9IJSGDe4Rsvakd5ndkiMLwlIuDx3c4Ku/LGHx1cmENCNW1l4Szcli9svsZJYOYDgirSLWXROa9u
 CUqVYt7VxfLiac78+NWspFvDaPBkhbA==
X-Google-Smtp-Source: AGHT+IEMOiLp/6sJLt+Jsg6GB0me8QP3gc8C+63NtJg1+vvuKB/3IWk4VvNwUoptwyildjyS0fOCMQ==
X-Received: by 2002:a05:6830:6588:b0:72b:a064:fab0 with SMTP id
 46e09a7af769-73b4c950342mr4771951a34.3.1751560172676; 
 Thu, 03 Jul 2025 09:29:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f7714c4sm19400a34.28.2025.07.03.09.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:29:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, paul.liu@linaro.org, sughosh.ganu@linaro.org, 
 javierm@redhat.com
In-Reply-To: <20250703110655.482467-1-ilias.apalodimas@linaro.org>
References: <20250703110655.482467-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for efi-next-03072025
Message-Id: <175156017165.3012248.3576179122691503329.b4-ty@konsulko.com>
Date: Thu, 03 Jul 2025 10:29:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 03 Jul 2025 14:06:55 +0300, Ilias Apalodimas wrote:

> A pull request for EFI coming from the TPM tree.
> New protocols are added to the EFI subsystem
> - Android Generic Bootloader (an EFI app loading Android) needs
>   EFI Debug Support Table for hardware assisting debugging.
> - EFI_PARTITION_INFO_PROTOCOL is needed by a new OS Loader Redhat is
>   working on that natively supports A/B filesystems via EFI.
> 
> Sughosh added EFI HTTP support to eficonfig and finally Andrew fixed
> more issues reported by smatch.
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


