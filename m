Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5FDC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14628817C4;
	Mon, 21 Apr 2025 18:00:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="avoKjl67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBC898197F; Mon, 21 Apr 2025 18:00:13 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923A1815D1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so862164b6e.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745251208; x=1745856008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUcrwQmrjLHk9MhJyXooEUqVVA4wA6UqKq4a3ulg240=;
 b=avoKjl67Ht2Nc6F8NVNVqtw/7kl1wUPdG7NGbi7GgcJn3BP/PCHJSVQ3zanwLgS6rj
 CC1A5Q12O5XbHhGLrG8+jxkIXCuupAy2p1YUwnL5ncv/wM/tfMJkuDxaMQ/StTbBVK43
 cXEQCyZ8KXBeyohFv/eJ/QXfIPwIMxpwVLkP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745251208; x=1745856008;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qUcrwQmrjLHk9MhJyXooEUqVVA4wA6UqKq4a3ulg240=;
 b=YUbNNgZE8UWpXDOcVfFF03vkJr/r9xvs8+KWEqpLK+Ney0rNAVABtunBIQaEtHCOg/
 pwL7onWUPLkqlLCMel5CleDjbwoxCnR8j93jN5lgBKLRgNj4g4icVEFb5afgoVjMpefR
 6sYeeyl+ropMKuHK+HyDMiizrOYH2Tgr2yczGFvZYf4eT/thYSqz5t6rPvANnX6f2Rfp
 pIbG2tT7ILILCv5ENZfkpYo7oMqwBwmG/MqYuwBaiYYjnQfe950mWTABgr7aSj452AaZ
 I1Sgt4wKM6N8Or1MKeG07QrbksjV7ZqaFA0rdkJ2cXg7MAfNI46z7EsSgwQwivtfrUXn
 J6RA==
X-Gm-Message-State: AOJu0YxCe1AOzBj927gVsErK4PJ7YpmioL5BV5i+UaNf7L84ROMqtlSO
 Vx8h1guCFbMrq9qn9tjyGiG8joWjkkro9Z+KWPCtLR9eWcaEL/VxSxR7bOntg3bGE/IQ7ETFEqz
 O
X-Gm-Gg: ASbGnctL6gPTeS6EKFxPcDSGA4QBVn+XWjObB/wd4R1TJHvggjw7CvGaS5edmXCN3aw
 7OJQt3fzZnaQCkY1d/8NHhvVZC/j/kQDu2YA+DCYRKsVxeLSLahQQ4RiaFQHeTxIRs63CjOUxbl
 /gSYCyRRegmOxm3ua2LPwIjiWt4kS/FBkFTkhg8K+d0mA4Cns44C/9WWQ3JCKA+Sys2PiQ0AYKj
 59poQ0N2U29I4SptlwLVYs/P86zygYlRknG45TtPHcuIW7DpoIbi0+gdytgHQ2wdVo7E8F04yFk
 261BbyxkoUBimKWZ5943LXISndyTThH0VC9GnWKe4Ygw0AoA5vrSe0+KVbPpsld9LRpJxFGPjFm
 bMF+ujUv5eZs=
X-Google-Smtp-Source: AGHT+IF2OUWGr1yU/0bEdzXAeK3XhWzAta58LnGfkfQzoj1i6sUKVvxtEN1afMdwiIKb8JaI8ae9KQ==
X-Received: by 2002:a05:6808:8001:b0:3f9:c668:2cb8 with SMTP id
 5614622812f47-401c0a7b130mr6714045b6e.13.1745251207675; 
 Mon, 21 Apr 2025 09:00:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beeec320sm1580204b6e.25.2025.04.21.09.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:00:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <40af19f9-ff1b-4d33-a356-f60e3737b902@linaro.org>
References: <40af19f9-ff1b-4d33-a356-f60e3737b902@linaro.org>
Subject: Re: [PULL] u-boot-at91-2025.07-b
Message-Id: <174525120663.3501265.7301423824467577578.b4-ty@konsulko.com>
Date: Mon, 21 Apr 2025 10:00:06 -0600
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

On Mon, 21 Apr 2025 10:01:46 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2025.07-b , the second set of at91 features
> and fixes for the next 2025.07 cycle.
> 
> This feature set includes the addition of sam9x60 usb gadget, and a fix
> for sama5d2 SPL.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


