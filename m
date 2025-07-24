Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D90C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 01:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F538353A;
	Thu, 24 Jul 2025 03:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TSF0AAJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 545C0835B0; Thu, 24 Jul 2025 03:37:31 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E9F82B0F
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-41bebd9dd8dso139733b6e.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753321048; x=1753925848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnPPNZaakNAolvHE1H5kfCmFK6twVJko63kiPTEeXyA=;
 b=TSF0AAJTykFMr/9tPqn2ow8fXVj65gLvO/XXdH62GqrHaBLsx0N+dRoP6lhR+UTXmc
 D2kggM5m2qAlVOO4GNWXKTUOOckiFzOkDjnlV62IcjC1bA7x9yB3DNGdIFnvVWmuxakS
 cUHw6cPF3W/Xg25/XTAAKW+ugRHm0OCA9b4Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321048; x=1753925848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnPPNZaakNAolvHE1H5kfCmFK6twVJko63kiPTEeXyA=;
 b=O1LqhkR9+NnRsPPPMX7y9fl/nm7BYrPGG2FyLkCnaq4EkX1OpN0VRJkOxEVs1TH/NQ
 qs3eVZWnRuH23zGr94KBkeL3Yn0CxwHQkQ7Pzs7Xt+hLVDACNxWQovvKboq518TNmjg4
 GV/qfXBL9JmGpORd1fWWYKQKvw6LtIWkIYrveSx4HqkICeP37Smeg5jRTsMOBFYW9klu
 INWVTp+eXrfYINc/aSUGT12uKXpnb8hCbgptB47EdcaVaBY8vbX1BR6xvPUhUtnCVWhe
 IyfzRPPoMIS4/shrLLrycjRYnUFAQO67lN2KE37Yz7vwb1lG3eoQ4L41wnhnIhwF8wBe
 NMXQ==
X-Gm-Message-State: AOJu0YzoN3Gp/EGiWl0sHnp6CZZJMS7Rcuve9yFZvKeecRpbqJfn7RjP
 1chQAzVNHI7kLTePOaKcyuMkEeOEzlbN4AzRlgjx0SKsnf8uKgreaKz5bKwmS7Yhy8g=
X-Gm-Gg: ASbGncvmNjSiesPV/ZXwXBAdccD3AdkQKUi6OItJ554P/EQnVInen/tDjn3aRnTqkX9
 h8l/BEjNEMEojlwYa8flUyuUWM/xEmCaQ0L5gb4IDsH/eE7QB7bRwJMwVqU6DaSL3DCrAhSRRqz
 8NurzkoYNYXy+JLiSU6mDfxYKpNgvRjKv3ZsdRHvfDf9M4QCr1D4chBU1LRdTLpE/OVcFcM3mjO
 hLSzIP0WKrzOI/oXVThTW+Nonl9aFI/hRcfPaH6rB7M65XoiWtxmNw7y0gCm80lnIpnZbUH6M16
 miNOk5HoiJzP3zteJku1Lkq3A3Bi2arYyrg/5u68tddK7+RzYvF7HTIj/CpDPnZHcSHcLujN0tj
 YVbF1w/iMVD97p9eZNnwGnZq9b7uo7bcTKgE07/gFLQN/V/LAaxPOydM=
X-Google-Smtp-Source: AGHT+IGf3+aP9+TYLAqNP9uJUG9U2kxspCCSFvap0zBSJBUf2Ma5AZ5YFxunAZIcihIySE/xLMJXsQ==
X-Received: by 2002:a05:6808:398a:b0:40b:3816:6637 with SMTP id
 5614622812f47-426c6049210mr4178002b6e.24.1753321047740; 
 Wed, 23 Jul 2025 18:37:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-618fb4431a3sm102604eaf.13.2025.07.23.18.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:37:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250715-abuf_test-v1-1-d4eef5cb79e7@linaro.org>
References: <20250715-abuf_test-v1-1-d4eef5cb79e7@linaro.org>
Subject: Re: [PATCH] abuf: Remove code that prevented test code running
Message-Id: <175332104663.263924.16896177628768985432.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 19:37:26 -0600
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

On Wed, 16 Jul 2025 10:03:30 +0100, Andrew Goodbody wrote:

> When abuf was introduced some test code was prevented from running using
> a 'return 0' early in the functions. A comment said it crashed on
> sandbox due to a 'bug' in realloc. Some time later a bug in abuf_realloc
> was fixed but this test code was never enabled.
> 
> Remove the early 'return 0' instances so that the test code can run.
> Also remove some checks that relied on the implementation details of the
> U-Boot memory code as these can fail on sandbox which uses system memory
> code. Besides that this code should be testing abuf implementation not
> the underlying memory code which has its own tests.
> Finally use a new #define for the allocs that are meant to fail to
> ensure they do fail on all CI platforms.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] abuf: Remove code that prevented test code running
      commit: d29c1092ebe113d31bc95792644350592d1211ff
-- 
Tom


