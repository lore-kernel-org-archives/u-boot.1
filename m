Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA62BC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 16:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9DE88683;
	Mon, 10 Jun 2024 18:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LKt+K+Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AAC88675; Mon, 10 Jun 2024 18:51:14 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D57588665
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 18:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3d22368713aso1057340b6e.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718038271; x=1718643071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CFZFhFgr+yVJkMDpZwSio43kv4Cq/OiHF6msk4FVe3s=;
 b=LKt+K+VqP/fabYGerzuhKH5AVTs8f6oo5/v7UpiI1/MxJltd72CsYMbG1StTCdISIr
 ileSb2hyWLi54N2//yjNewNZA31xWJilAt0/Abl/Kmm9fjTBHwfMffemorkacmYD0K6f
 2gTpi2NhbyAYvR1aPcoGDy+QgZcFuiBw1ebwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718038271; x=1718643071;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFZFhFgr+yVJkMDpZwSio43kv4Cq/OiHF6msk4FVe3s=;
 b=YnfxLLXG+7uVK+flWVMfD6OeuPBPTgEsBUyBgI0i9GOBZ2eXiPxJ6I00QS2wgPq3JV
 9m0ZdIVq7nJR9alzH1xetyID0EhaR51775Rgo+i8UyBrb31HYzhPlBuLzsunyxJybHKm
 ci/P1gRXH39jUxVhFzqE+lBF/0fp26FwVpgAOoh+si2Nk+w5Ml5pFEdrLXVFnyaqsOer
 AH092XK3rNvdKFTt02cfCHwSOJ0kZ3cQNSLknn0epJQXRdxDt8icWHGy8jDZJ9BpLmpk
 bVvw//be3UJy2uaWraYui8q2rt56TWBTiUysiKjj2zjBXal/vzgivEZYsZQkLed90lbu
 t0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdeesVf/rnZWazfFCqd9QqTWxdTndEPNJc/Zj7k3p1XZFn/nm6AI0VXFR8508G8qFEd17nBnyYX8PSa+YyJ/XrP5ZmAQ==
X-Gm-Message-State: AOJu0YwlLNYUAc1fMGDaZYnHGUYmP+p2XzdN9zygMI/GlMxBUCn2T/Sb
 eJubdw8HoYWB+CzA6EkiNo8tfWegEL7IwZ6aKK3qIdMe4WEzjxhdKZusldzOWz4=
X-Google-Smtp-Source: AGHT+IGQkOzwrI2nVU4wPH59Q5qQegfJtj11lJax1P7fjgzs9Xlvv9XJVzacl4l6LHs4HOsBRN8Ezg==
X-Received: by 2002:a05:6808:10d3:b0:3d2:1f5d:f992 with SMTP id
 5614622812f47-3d21f5dfdebmr7622106b6e.32.1718038271112; 
 Mon, 10 Jun 2024 09:51:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d20b66cb57sm1668475b6e.10.2024.06.10.09.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:51:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, marek.vasut+renesas@mailbox.org, 
 laurent.pinchart@ideasonboard.com, ilias.apalodimas@linaro.org, 
 xypron.glpk@gmx.de, eajames@linux.ibm.com, paulerwan.rio@gmail.com, 
 u-boot@lists.denx.de, mkorpershoek@baylibre.com, 
 Roman Stratiienko <r.stratiienko@gmail.com>
In-Reply-To: <20240523070606.91108-1-r.stratiienko@gmail.com>
References: <20240523070606.91108-1-r.stratiienko@gmail.com>
Subject: Re: [PATCH v3] abootimg: Add init_boot image support
Message-Id: <171803827023.2405130.6966749018460676849.b4-ty@konsulko.com>
Date: Mon, 10 Jun 2024 10:51:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 23 May 2024 07:06:07 +0000, Roman Stratiienko wrote:

> Quote from [1]:
> 
> "For devices launching with Android 13, the generic ramdisk is removed
> from the boot image and placed in a separate init_boot image.
> This change leaves the boot image with only the GKI kernel."
> 
> While at it, update wrong error handling message when vendor_boot
> cannot be loaded.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


