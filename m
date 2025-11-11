Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD3CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256CE83F98;
	Tue, 11 Nov 2025 21:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U85DaLvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D37BB83C35; Tue, 11 Nov 2025 21:15:03 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7317F83B83
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4501b097976so51518b6e.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892097; x=1763496897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FKLEJMFV+UsAQMhDE4M3s3Bf1Jf79w1nnJn99l5Qb6w=;
 b=U85DaLvwRbRDW8egM+TSlRzmU2WkKhx1mbAoR8IsvgQ/Sh20JQm8M0U3FyBDrKM0EV
 vfJGIkB65YesiTbKObL3Q7gr+gCH82w+XFtEHduaYfJKYCIczwwBJYQxCEW1xubhDIVf
 5yxQ8WV+EWV9BquozWoICgBM1F0VY3ydmWYjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892097; x=1763496897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FKLEJMFV+UsAQMhDE4M3s3Bf1Jf79w1nnJn99l5Qb6w=;
 b=xNkS5FweMNcXfyl6eMjLMcSWR9iuZyy6BE+JsapbXGEt9yBUGE4vgS0PHfMboQ2xoA
 yWIXdiPupAh59U7gAP2qA+U0EIiGeS63v2JSxeKUvIyd5lh3aRSDqFegVGXHrcN8mmyg
 MGhUrpR3BfK2NA/TGUekMQx86fWR56AQqp4X5Uyf9J3/E68N+qmvntBmtMTzKlSaWZdD
 1ahtnJFN5mCCXOCSBtkJDAh8Qgpqtvq9mVL1dRoj6Bb59Qeu7QmHpa4YrTU5VF+ZJPyJ
 qQNp8f5L2LKJYPwdj0d/HWPyJY4XamRtA4IFLu0mCvwX/4T80QZ6h6o7un4VRY2LqSOW
 Jveg==
X-Gm-Message-State: AOJu0Yx1ki3pfGSmiAljZ8vxd7eY4lbDa91nrOY3DEznoTu5n+ZYs/OP
 KYWo4e/jYyF2x4xr8UywrE9pwlgmLEqgavmNcFTo0L+Ieh0P8EcLPjvnzJaazvthnyXlT7NvTym
 CnWY2chVzXg==
X-Gm-Gg: ASbGncuoS1UWoUecJ3gHwYJ906gXX2NoEAmOcOV88EqTXkDu3qdGlIMta1pQkbxkDYT
 DCO6eIvhSqleE8Jb1+o8UVwcEZDBFaKaLcmz2exZJMmb12exlGzcm+KPrhM6nejHIFhuvSaccqG
 vBSHokoss/6bW/yO6BpI5qpX3Ge4FHWk8vA0JSxJB94t35XByCiWxrCPwe25dro1csqJrNxISTy
 MVf411H8IlajGT6t/D73mdl6kad0Uza3NT8nfg3WgdNwS2/mevhR4KatMUJaS2QybbbkgG0H768
 2IUSfSxhd6DY7xLTYVUwNr0fwZePUckzioNVgbVcJlevPUQmYIT5W5k3a49euV9hF9cBoqlwe4c
 K0kPyTBn5kp+fsG/rzJo9t9AdX/sGImeM+EyqK155oTxu5u/PbSMB02J69F5TZG2hWfeztKY5EK
 uz17I2R6V9dqrbWqksZEi1D0SmpknVfybdKSormw==
X-Google-Smtp-Source: AGHT+IH4WV6HSNhL0ZPvTQoPRCMMRwATqwn8WpOsgzwJgZc6GAd/kT7N5i0BNLbMSSlX/IWRMh0QsQ==
X-Received: by 2002:a05:6808:6f91:b0:437:dade:463f with SMTP id
 5614622812f47-45074583a1dmr213468b6e.34.1762892097175; 
 Tue, 11 Nov 2025 12:14:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, yegorslists@googlemail.com
In-Reply-To: <20251104104028.3813594-1-yegorslists@googlemail.com>
References: <20251104104028.3813594-1-yegorslists@googlemail.com>
Subject: Re: [PATCH] gpio: OMAP: add dependency to TI_SYSC
Message-Id: <176289209651.737015.1661177842135521980.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:56 -0600
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

On Tue, 04 Nov 2025 11:40:28 +0100, yegorslists@googlemail.com wrote:

> OMAP GPIO driver needs TI_SYSC to initialize its clocks when
> using a devicetree-based setup.
> 
> 

Applied to u-boot/master, thanks!

[1/1] gpio: OMAP: add dependency to TI_SYSC
      commit: 749ec886046d1a5dff87aa41f3d46a06ef558169
-- 
Tom


