Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324691125811
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 18:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85F5584013;
	Wed, 11 Mar 2026 19:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGtH+HpT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87CA684035; Wed, 11 Mar 2026 19:11:22 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A679A83FEC
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 19:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439a89b6fd0so158408f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773252680; x=1773857480; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vdOtFh0BZ6IXrv6xJ0pqbKih1eB2TeMoQrArhLNmysE=;
 b=CGtH+HpTg0kcA0r2d5t6Ya4qvmg8wXqNpP4ms64rquWIYsSW9rF5XlPX5f50cH8Q0i
 Qu5W/2Yc+vu6DsJyz4W2bh/So/o0WuO6l0LVebpWZqm4il4/0LmnLTFBBFAWQ0ts7XVW
 Ciu62j5+pdSexvGvbwlQ8q0jhp7HdODSJF96/g7Mt+YfXozO5qmFFeJzUmHRKjO8qGgw
 G8ZVgPAM5VpVIIE7GVW9UCAhQm41yAuGg1QSWkvLPYMnH4knNMljZ8gSNCPjosuCN2oW
 5r04eM1El/jmmRZYuhXSFx6uP9FPAiMyh30H3NYlRWbNO3+HJ+2wzQmerAMcafDFL5Hz
 kqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773252680; x=1773857480;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdOtFh0BZ6IXrv6xJ0pqbKih1eB2TeMoQrArhLNmysE=;
 b=I8rLZzvimy9fpDjdHqCiASx6F4wAOgNl+6WoPHgXXw3aP6UPeGY7SGREdh0io4DEoK
 gZMATESrGTTxIum2gAMXRNmyFTTlAvFgrB/hAENHI/7kRTemsgcP+K2nZPGzlpLhnIjP
 y0sseXNOT8BVtHPMOcmNRvch22eCqs8e4T0LYH91Q5OsXc9RbLRZpQHJrS/zR42oMeRk
 Y+3zLSKY2catJ6hl7LL/3ke1Sjv+HIbx3YNiYZz1NWsFsTu8ZmfUUQWJg39XxccqJb/5
 thODguAcvk0qWlu+NygLzRi6ZBRcnmWhzGLan7Egg6sKYKsDAJAwQf4JG7L6VsoWp8d1
 jhuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoArMINnWI2ovOAaEi5VldhLWlkgTaCL+JhhxFrMNxYK664mcJg9POPNhnBXbTbbucXwS7ebk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8HVc60TRb7GyoDlndmGNqNQ8GVRYVQqRW/TD0bDp6yC+5blqJ
 MsHrSYL/Lf90Vkbib1gSgtfivH+bWb6K2fGyee9jkii4M0mPAIxgQbYr
X-Gm-Gg: ATEYQzxuGjPOVr36K/ae94DxKFu9avabVIbQaVUfnXp18K99RVGqrgj8A7Li/k+i2Ji
 7Rkno+71mXRP8kpNPgTv6cWo+U6YTYWhy4Hvy2BNN3UPuuVpkEgTeVqpb3G5/Rzs2Is0cF0K4Bw
 DkO6Nz21azlbAF2MN9MvJhTZjIwGg/E/yp1xTOHB4/zaEAtMhapjtTergK7fVM8Ek3S9auRUsw9
 cXaBRtz9Ouot3C6t1qXaZYHUxp3tfpLfaD1L9rXicx9W2RO8STC+MjMzbalgq1r8LvDh6iEhGNM
 lss7Ok0D15Vhhdx6wLALZLs8+SVotIcjI4DuV7bggl0rLHaVtg2JunwuDZHmeP7aULKDQLp66ux
 xLB8CPgPZDjTXmCz2xxOnCuaHx6IruFvtbJVO5NxXwfNOSrpbRiXIQ7MVTbDx+uWhMd1V/u8qgR
 FM4s0qXt7jvMP0gZDg7BjLhyuCfbNtCD2e+21csT0Nl/5clzNZkNYJlYJNhIjzmwQMK8nqHV/Q3
 YA=
X-Received: by 2002:a05:6000:26c9:b0:439:be4e:6e58 with SMTP id
 ffacd0b85a97d-439f821fe85mr6834846f8f.47.1773252679663; 
 Wed, 11 Mar 2026 11:11:19 -0700 (PDT)
Received: from ?IPV6:2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c?
 ([2001:9e8:9a:de10:fba3:eefe:bd9c:fc8c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2187aasm954740f8f.30.2026.03.11.11.11.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 11:11:19 -0700 (PDT)
Message-ID: <b8787924-38ae-4bd2-9d18-ec8bfc93eb79@gmail.com>
Date: Wed, 11 Mar 2026 19:11:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] mips: loongson: lowlevel debug serial
To: sgdfkk@163.com, duhuanpeng@139.com, u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
 <20260311084129.12809-4-sgdfkk@163.com>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260311084129.12809-4-sgdfkk@163.com>
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
> set pin to uart alternate function and enable uart for lowlevel debug,
> also future pinctrl driver can base on this code.
> 
> Signed-off-by: Du Huanpeng <u74147@gmail.com>
> ---
>   arch/mips/mach-loongson/include/mach/serial.h |  16 +++
>   arch/mips/mach-loongson/ls1c300/gpio.c        |  66 +++++++++++
>   arch/mips/mach-loongson/ls1c300/serial.c      | 104 ++++++++++++++++++
>   3 files changed, 186 insertions(+)
>   create mode 100644 arch/mips/mach-loongson/include/mach/serial.h
>   create mode 100644 arch/mips/mach-loongson/ls1c300/gpio.c
>   create mode 100644 arch/mips/mach-loongson/ls1c300/serial.c
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

