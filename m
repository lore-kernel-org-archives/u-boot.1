Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3753C36002
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 15:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD15C82BF2;
	Sun,  6 Apr 2025 17:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dq78+3DF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FC282C6D; Sun,  6 Apr 2025 17:38:13 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7575582AA3
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 17:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-601a891ab8fso2087868eaf.1
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743953890; x=1744558690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/8KyGlx+Np6+YswQzbMluwVTG8BvhxFXHEf3cBqKWE=;
 b=Dq78+3DFKqQKDa0Q4LA+iHbOH6fiW7xspyD/ZOVgLhQYgFarUebk5rIezYaHYRDluO
 QRliwtLrEoyJWGY8i3Wr/NxZjOnxQBa0FzemR+voWN2TX+NvYxxRydXCic7Y/Cn3Ad2m
 UIZpLr+zDfHaNnpGje1r4d22BllgedhzZVoNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743953890; x=1744558690;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/8KyGlx+Np6+YswQzbMluwVTG8BvhxFXHEf3cBqKWE=;
 b=xNbvT7htJ75ZGb5kQKmeNudXwm4WL2hDH93sbienolD4ivXzFcNUN1GfIfbLNrrQCo
 Zz2fMoFIeMXrR6aCIHQm3Rge3DqY5HFWDaokjBa2swywR1+tK/pMCofq9PcZQT597Ued
 CsNqUWCSLHqsE/q6YXl7bNJpUohdxgumaTjXn0pyenAmI4Tppgo5bKKYN5AgFsnrOcw+
 cCb2UPiN6dvJGz72yceNi24vn4A0tkLmFoLn4ZhZWvfN7xQQlOozYDaBffF7BGVSRFxh
 9PWSHfERvpKVUfwu8/0X7vXJKBqx57VMTrEYKCP7GDCvFBX0rHqC2a3jlVyy0hPqQS79
 tEoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+SLleXz9GyFf+VRUytFU/LyWRXtucADgNe/iCU3fqKip+34FvOHwGXoDeb/XVVKkWJoWOPrg=@lists.denx.de
X-Gm-Message-State: AOJu0YxNmZvkdq8frk6jq8Soxq2qbcRFxyNvEiuWzbR2tFygX1hViYFB
 oMYtVpok30LLkL0YddfNZMVtKVUpWbyxUOEKWDC+Dcx71jboGSCquCL1/O/7UUk=
X-Gm-Gg: ASbGncuBFH6AR+Ft5sAZKppZKzqtZjTJc+cA88xtA56QIkIglILFZWltjrQdErUzmFh
 aqT42pNhKBZ9UW6jKKRKMvJbCoki51QKruseCaUhbL5r/vPQq0kOM6HGQUbUUn5usvPQuvn1xQC
 ZasxuY4ZhzHMR+1b3ZyZ+x5W07N7ufA6LDTmCxybmqe/ejbtnNEMZ7Gnuul9yGSg8BBvmvNTkrw
 p+C8/797wz+a6meE3TeQxF4jAew2Ub0Yd3woQub+AWU0DIwGyAgyrlu59IVJykeFM0LF5aLzqL+
 3zLnTq4vdh/cLGYmJxVKAp8LHg+mpjrq09ONz+ryQdbPUf4v6ezATgk075YmQJkAcaEWQoB+/ES
 wwofr
X-Google-Smtp-Source: AGHT+IF4YOlt59zlT60rAbQpg4t8twmrnMLXo6agzpVvO9bvlAFH/TjnN8V1JWp6sW3Mrv2hoYhCQQ==
X-Received: by 2002:a05:6820:c31c:b0:601:d8be:efcc with SMTP id
 006d021491bc7-60409f98c64mr6082765eaf.4.1743953890257; 
 Sun, 06 Apr 2025 08:38:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4cddd6sm1447384eaf.15.2025.04.06.08.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 08:38:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anurag Dutta <a-dutta@ti.com>
Cc: n-francis@ti.com, s-vadapalli@ti.com, vaishnav.a@ti.com, 
 a-limaye@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com
In-Reply-To: <20250320063004.1069653-1-a-dutta@ti.com>
References: <20250320063004.1069653-1-a-dutta@ti.com>
Subject: Re: [PATCH 0/3] Enable MUX_MMIO at SPL stage
Message-Id: <174395388889.154794.7807857191763307310.b4-ty@konsulko.com>
Date: Sun, 06 Apr 2025 09:38:08 -0600
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

On Thu, 20 Mar 2025 12:00:01 +0530, Anurag Dutta wrote:

> This series enables MUX_MMIO at SPL stage for j7200 and j721e
> as it is required for successful hyperflash boot.
> 
> Test logs :
> https://gist.github.com/anuragdutta731/b4c79ef8da56d8c50b38d953c9da4d45
> 
> Anurag Dutta (3):
>   mux: Kconfig: Add Kconfig options for MUX_MMIO
>   configs: j7200_evm_a72_defconfig: Enable MUX_MMIO at SPL
>   configs: j721e_evm_a72_defconfig: Enable MUX_MMIO at SPL
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] mux: Kconfig: Add Kconfig options for MUX_MMIO
      commit: 9b838d0d7b619e1c8f67a0df930d2a53c33e8431
[2/3] configs: j7200_evm_a72_defconfig: Enable MUX_MMIO at SPL
      commit: a434bcfbe68d44c6b4c4b7cd27b2bdc3081684e2
[3/3] configs: j721e_evm_a72_defconfig: Enable MUX_MMIO at SPL
      commit: d042761ec0043bd4fe9466bed5e2852ff5a8166a
-- 
Tom


