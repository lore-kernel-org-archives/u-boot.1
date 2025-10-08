Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D45DCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C8C8407D;
	Wed,  8 Oct 2025 22:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BX1ejLVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AC683D40; Wed,  8 Oct 2025 22:59:47 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2189B83948
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f489502e5so185325b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957184; x=1760561984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dlcnreQvzDInOp7pZACDNLmJy44W5ahN+o6Mq/aTDbY=;
 b=BX1ejLVJvxNGKvFAUkP7MiEG7abonkfwqRikMNOL9p9/HPYHNMZLi9b3huvslqcAh9
 VbmOFlGOHsG+fytWqOSYNlh7zkyToIL6f/2ZAQMN1Do0SiOMYe9spGEodi2ZVQ4JcTht
 8+6uU0t9okaG3qdecVD73seGxoX1EC/Rd9K8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957184; x=1760561984;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlcnreQvzDInOp7pZACDNLmJy44W5ahN+o6Mq/aTDbY=;
 b=oWQXtmzh1fgiF9UF9MjrnyMSGP3ibce9SnnD3WBsRv2bBVhrxfpkfJ9Cle8CDUedYe
 fj/Ivokx0KyRDwDNq35eUBU7JNR5Dko59H49K0rX29QRg23DsWcrR575g+TuLFM7nvVz
 GCor4m7arfu3EHTmRKGA2WVVm0CJYKRMwcrbWBFiCGIUlw87rVvWoOUjHbUXgfsOpewj
 NbWysq72yzjRK1kUWoG5JQ5lHKprgsbmaCtChuAmWFMChCUkQmNIENbbIhAxg6L76A0G
 neLGExzVJhTJIFoZpHzr3TJWEpkfgwbQMm2CH65X/snUygzS78rYF6Oxdtg/86n05ngY
 MONw==
X-Gm-Message-State: AOJu0YzxSU1EliZQaPbUOovte2Gayaw+hVFM2xSRqaY0ljXoRECnCXm/
 TSrg+D5keFMCHAJm/qMeeykfdxtv3/8HrsPCnvllthjnwIaxi64hxnIKYEW5AhrJw/Q=
X-Gm-Gg: ASbGncswlzm39fY9NYXkgx0RcJr1zNYBD86y+9KA8Us4LD5H7W+Rgt6i9KsqdxaVZBC
 Md6FdR5DP86MmNdTSdP14IXWbvawMZ/Hut3MXKU32ojNem1FpH13mLkUA8SGxGb2t1iWCQXxASa
 3RS1EyfRLmvsCZGROOS7MxwNEvt/bQ0ux9wWSxW/OcjVYf04ueFJv6c+ZjRbhdZefORDRV6Kxq1
 42X0df/oadeK0Qnn2XQ7EmD2L7roiiiyE3PIY3/idW6pnXQMtE7lxT4T8oYE1XykicDxEIudgAX
 lmzBTRul0lgh/all5nUMYyu2qYOjv9suTZiop1ekaScZMh1esPzH2174/asXJ+JDON6XRptYK9c
 lQeL919ZAIvUgHYqJW8L7xDn0hSfoz2L5entkKPPHvkAVnWic/l40vGGLRk4/UK887mJAzEHY0m
 1ToqlBF8Md
X-Google-Smtp-Source: AGHT+IH24XPPpOZS1Msd4uKN9EwhHyCEZWnaNo9sRnHsRNpGq3GzLAsstnDmChWy0K5EEnB8rNwYbg==
X-Received: by 2002:a05:6808:10d6:b0:43f:7a07:44dc with SMTP id
 5614622812f47-4417b3c1266mr2302564b6e.42.1759957183889; 
 Wed, 08 Oct 2025 13:59:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205616.3562560-1-trini@konsulko.com>
References: <20250925205616.3562560-1-trini@konsulko.com>
Subject: Re: [PATCH] rtc: Make U_BOOT_DRIVER entries unique
Message-Id: <175995718268.3059512.7809534881088144586.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:42 -0600
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

On Thu, 25 Sep 2025 14:56:16 -0600, Tom Rini wrote:

> All instances of the U_BOOT_DRIVER must use a unique name or they will
> lead to link time failures due to name space conflicts when both are
> present. In this case the driver was reusing the max313xx name.
> 
> 

Applied to u-boot/master, thanks!

[1/1] rtc: Make U_BOOT_DRIVER entries unique
      commit: b7f35d30155c05d11e08c972fedaa86b11a226e6
-- 
Tom


