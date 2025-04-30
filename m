Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FEFC3ABAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EA082C2F;
	Wed, 30 Apr 2025 19:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lsnwgcOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEDF82C2B; Wed, 30 Apr 2025 19:03:44 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83B2082BB4
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3f9832f798aso103832b6e.2
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032621; x=1746637421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JxNiid4aRZSx8XZtlt56E5IDHicUKWSKY1MMg2BF7c=;
 b=lsnwgcOum5OhJnux+UjERQhduTPnXJdgeAeIMUbkF57ixsDfIArvBkX0FDoyhmhktf
 Rr2lFMPgL/Jx0LTIMukMrv54fxN/mpneg+6aeAg9zB14dZuY2kRju78KQEQ/ZPPPnr0M
 0ruceE0ODUlMITQVgMAWjjWz0wrYZrjm9Bg3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032621; x=1746637421;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JxNiid4aRZSx8XZtlt56E5IDHicUKWSKY1MMg2BF7c=;
 b=uVybQRs4SN10VO2O7HAsvOqYbhfT6uTkv42QGsrbhIZ0dF5PQ6ohdHxeqEEWPE+Gyw
 lpVEJzZm9MVcLQ3OZn9FOdg9t0PTWKMu6UvwHbUwfStJAu9ERGt6zzHwZHP7xu+or8KB
 80i4DJl7SDHTUFf9RuUJzLiIyliGKZPtsg8MyNrH0oBjqLrafAfMWrW0+zWP2fZLQfrZ
 b0dTfu6BlhFxTTvb9ZSwZNonmQehp12vQQzlBK2q7OQYTi2BRvbsMMKawaRyo61KzcQi
 zIOkKItfLszZ3YeN6RwGgtdLmAfn+gTZCsc45QyvYecIq6S5FoUJ6AclTXCLtYZtqOkP
 LE+Q==
X-Gm-Message-State: AOJu0YwPdnhUzYFs3WyzzknigZMo1DSpy3vzSxfGaj5k0ZsiImxwMvnR
 R/lZycbRm8FSjOoMbH8gBjY8XnLfMX224A+q7/GXJS02tJkjgDetPCMz02kNCTo=
X-Gm-Gg: ASbGncvpiXb97fb7aNxZVFf0LulQiYnGWVtIdeWl/eUsQrBdTqzrT2zIkzMhSzo/neg
 0bc9WyDtmyYNE54899tuzYi/UFoJSdISfcIfuurcscShhtIQIMiNi4DNYeGhPvDgk72i7kZwkm0
 AX3Z+5aZh1PFywZz3uxYFuoVoGlIBmbuwQ1KtxFzN4ROEYadRp3P/Sq/0OdeZPXXKhUvV0yHfH9
 qJS9qd2zCzeRJ/kfdGk0NEUxqHwkZKV+cAXkyJoBu7VQabcaSduAfcPr4dyR9HsEFF+fcZr5rM2
 rkv2xCyOWupjRv7lZ1YAamPmGbvHOwfESemc2wrST5KM2LrcLmAIQ39o23eNExlyWODBshLJ5sA
 L
X-Google-Smtp-Source: AGHT+IEwA5IIGK8Ntj4pY3OKur9hgnatSD0Zvsgj2bPfymSZRaZEYbIBaAR6rqAUL6tg1xF3ewHPKg==
X-Received: by 2002:a05:6808:22a5:b0:3f8:acb4:8d8e with SMTP id
 5614622812f47-4024397f419mr2621228b6e.39.1746032621252; 
 Wed, 30 Apr 2025 10:03:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com, 
 marex@denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com, 
 u-kumar1@ti.com, seanga2@gmail.com, sjg@chromium.org, 
 william.zhang@broadcom.com, stefan_b@posteo.net, quentin.schulz@cherry.de, 
 Takahiro.Kuwano@infineon.com, p-mantena@ti.com, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250327070443.680972-1-venkatesh.abbarapu@amd.com>
References: <20250327070443.680972-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] mtd: spi-nor: Add NO_CHIP_ERASE flag for mt35xu01g/2g
Message-Id: <174603261932.1760506.12956253964341895463.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:39 -0600
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

On Thu, 27 Mar 2025 12:34:43 +0530, Venkatesh Yadav Abbarapu wrote:

> Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
> for the mt35xu01g/2g flashes, the NO_CHIP_ERASE flag has been added
> to enable sector erase functionality instead.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Add NO_CHIP_ERASE flag for mt35xu01g/2g
      commit: 299371dc8ea1e777b12a1e7c95fc8f9c1d9542ee
-- 
Tom


