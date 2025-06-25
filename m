Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7051C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 15:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9D382D21;
	Wed, 25 Jun 2025 17:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CsDiebmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6003B82CFA; Wed, 25 Jun 2025 17:37:22 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9172882D83
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 17:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4067b7d7e52so12349b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750865836; x=1751470636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8v5EXu2aDSwcRpR4btG89VkouNHXlURDaVlvOIHIlY=;
 b=CsDiebmyRIiNvtYqjEvLHY2MS2sWPhYmbVq4O61mfvd0cTBOJP5Ya0ZJREIaMTspsb
 59+96mWgxt3kw9VAE5Yyc9mB/LtI6thyuXi0w90A6TA30cze4EIia7T2EVfluRJuEVI3
 SzDtgYVsRHZop81/sgvFmN+5JEuap9qDPJy8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750865836; x=1751470636;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8v5EXu2aDSwcRpR4btG89VkouNHXlURDaVlvOIHIlY=;
 b=EYDBjUAOt5CF1TjxTssIKo+MhbaC4TeJop5r4V7PNCtjs1Z0EyBOPmGmUxTivwSrCG
 9roq0dOtWYuj9mp0W9oH5UnmoKQT+PBFhoJ+7q8bRfK3ZE7QVOymtnxc6eQa4ivLPndP
 uTfhTrFrJp/ZW46Ikb1Jtglz30b19XI3kuhAFnLA0Tvym+zKd5kYAMUnOLKVa7jA7Hj5
 spGoaFN8fS703WKVD3DZFU84DF1MMWZ1Fy437i9RcuSEdXyYMYbcfr0frCrAuBDVj72K
 fgBvv4caGifM2o8v7QySt3pgJ04PqDeDmmn+ZMH0tO4p0wA5+4Gmi3s6mfdbwKaijAAE
 XUKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUprr4NdnU7AMYXM4jiJdZ5qfc45yJWgK83jnwCYsL43e4L+xicqhOMXICs56+yMgn8Jy1MiCc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxbv+pCGyt9uV2iYbv8uu+gBZvCPkfHo/cKG5L1Lbkfd0Ei8Z1J
 WWj9Jl/wWWgHv+lnsUbIEm2Ish7jGfEB/qEelRQVgJuhdSHwEnt3wmVLLWktJ2KIpZ9nShdvWse
 zKwFIvRc=
X-Gm-Gg: ASbGncvcfw16ij7cw6m5KhqwUsK5rAJYVRKjrVxlDEC2CNybQJ2ACeHUVqppQw42t7E
 GaEiGdm4K3WX/8sSaiIkoUOKa8UfZJsL6y1IU8Dk05Nm8AgszlvCRksaiXaq4kt0T2txsKYahyu
 wk2ravQw7Xa4q12Y997yIGub/uloABs5HIPg4uDFEaySwVKs1VHFcDIAj4TzPQlvz2sz61nLDBP
 SAZDFGCoGyycd8EsIPGfclQyszRILDnyW5QM88mEcHdlHFSKtxpEiIrUL+4DiZhDa+j+/eIqBHa
 JTXSnedgxDBF+mPBR8Z958leaPkd3/JtRm2Pq5LnyL0vPw6nhAn2dvItAFuwQu5Wj4s+a5/KINw
 MtBWotvoYKLFgraFopAQRgg==
X-Google-Smtp-Source: AGHT+IEAyrPpSzFuoZIGsziLNbizciFlK0mnzRBruSwL6Ux1COap9q0GlDEJHd16A3j3WiNxPyRddA==
X-Received: by 2002:a05:6808:e83:b0:406:6671:6d1d with SMTP id
 5614622812f47-40b05aae6b3mr2814869b6e.15.1750865836250; 
 Wed, 25 Jun 2025 08:37:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6c30aa7sm2212537b6e.20.2025.06.25.08.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 08:37:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <contact@paulk.fr>, u-boot@lists.denx.de, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20250624192738.13062-1-andre.przywara@arm.com>
References: <20250624192738.13062-1-andre.przywara@arm.com>
Subject: Re: [GIT PULL] u-boot-sunxi/next
Message-Id: <175086583541.1401475.1224819033827719234.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 09:37:15 -0600
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

On Tue, 24 Jun 2025 20:27:38 +0100, Andre Przywara wrote:

> please pull these sunxi changes into next:
> This concludes support for the Allwinner A133 SoC, the biggest chunk of
> which is the DRAM init code. Also includes support for a devboard using
> this SoC, the DT of which  got added to the kernel only recently. The same
> is true for another H618 devboard, so add the respective devconfig as well.
> 
> Gitlab CI passed, and I booted that briefly on those two boards.
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


