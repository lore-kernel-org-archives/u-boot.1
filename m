Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B429E77173
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 01:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9415689575;
	Sat,  7 Dec 2024 02:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LIwPcbSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FC489451; Sat,  7 Dec 2024 02:03:15 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28E258929D
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 02:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46695478d03so38795501cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 17:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733533392; x=1734138192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fac36hx8YFll4x8XXGPMBTtX88vlblm25kB1BANZpuE=;
 b=LIwPcbSVvcGZvIUAk8Dknuqb9Ebg2cfy6pP31MUz23F7JpDUK9zHg/xQpjSeyMeIeh
 jiZBk2E7S5jFnBdqTR4t5C+HbIU8TMzkHjAaVQiJ9lJCrUIUU6XdSzCmVR1Jko6v+QU3
 khIlDwl4rn/SdGD7Fn+mtL0JvN2I4ydo3ZAGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533392; x=1734138192;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fac36hx8YFll4x8XXGPMBTtX88vlblm25kB1BANZpuE=;
 b=Pe3DK3JslfXZQwVriVyL2kMwHOIC08XP6kLdFbzgBVsqE5ACCILbRlfWxb927jkjq0
 UFKoYneZi63ImZF4WMHA2pYn26WTODLfICJVeN5q86zJphm//YmH0SnxAm6VGpFZs8my
 jaijP/8Dqx88iq+842R1Ub+U5NrKMGb7JvxjAzLksit0UKiNqFiWsnzT33ViSFhZgSkk
 jO7Si4nLUYCZjoOoEi7Oj5fqBIuP8Nuv2jkxIG+X6VMJa3oCPCk5IcWP2CNFDrJTBoRq
 PMkd+zZGEeE/2zfCcvRE50la+4NYcYXzRAE4KHyZgsLAa6ajxtIL5q5fYFA58hjI4+YU
 wP+Q==
X-Gm-Message-State: AOJu0Yy9DNOh5Sv2HGUnCwWyI4bqC3hMLYoxn7BBAMT6r80VkSGQMXti
 HAfApgfNMKzkjN+6AsvLsidgUseGS9U+HL/c5zw5PXhIBR8GNXtaZKYo0KkZNPOTKrgGhQ0B8Gn
 N5XU=
X-Gm-Gg: ASbGncuQsPIQEVULsHP3e7kW+b7N+srmxx8RSV5DZEgMb+5smqAKT2fHKnZFQz21A+a
 BbVkrjBaM/xd93U9xxuz1qefFFpq4vHtkTUpzESJ6Go2593WE7/+4f2IzqBZ82sK6Paov+/jPCX
 VTCfCn/x8lwUJsJOMzL4/LCE1ua3duil7Inux4BEq+zd9EAPcu05nip+wzkU0qAmDPvStKXFpxt
 9eoI1S2BOzzf1T2PhJokUwiwNw+TZgPjWF0PfkcOlsZP42s2Q==
X-Google-Smtp-Source: AGHT+IFNQpWMu5g5j4bkE8K7RH+nkQ1tMLU2LqntfwhiMUvteRn/ls0y985OEjl1APTBZOvBnmm3Ow==
X-Received: by 2002:a05:622a:1314:b0:463:5bd4:59b8 with SMTP id
 d75a77b69052e-46734e675c7mr85759011cf.40.1733533392155; 
 Fri, 06 Dec 2024 17:03:12 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297cd6a2sm26834331cf.84.2024.12.06.17.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 17:03:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>, 
 u-boot@dh-electronics.com
In-Reply-To: <20241120160135.28262-1-cniedermaier@dh-electronics.com>
References: <20241120160135.28262-1-cniedermaier@dh-electronics.com>
Subject: Re: [PATCH V2] env: Switch the callback static list to Kconfig
Message-Id: <173353339058.3658905.15704207788942489481.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 19:03:10 -0600
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

On Wed, 20 Nov 2024 17:01:35 +0100, Christoph Niedermaier wrote:

> Switch the callback static list from the board configuration variable
> CFG_ENV_CALLBACK_LIST_STATIC to Kconfig CONFIG_ENV_CALLBACK_LIST_STATIC.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


