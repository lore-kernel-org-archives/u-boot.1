Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13C5C61CE7
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B8A82B63;
	Wed, 11 Jun 2025 14:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XEwDV+me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051A382B70; Wed, 11 Jun 2025 14:15:38 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C8282B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0203C5C48C6;
 Wed, 11 Jun 2025 12:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56757C4CEEE;
 Wed, 11 Jun 2025 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749644134;
 bh=KPbE4Be8dIX9HxOmF3pfMFsmuETBnPsdplJUDkYlf3A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XEwDV+meSXkXgbT+fJ/Dq0gF3wMgBe1M92tVHWLvQ7yDe9YkmaadYy+mBEb4W7Xcj
 Z2cZl2slT1QMvIgDcOZm1B9g+WJlF/ZXdOtyANE30iU48t+tk0i2wt1vqWdJDNn4xp
 ALQNZBVmwpcuGaQXnHgqIyc1V9kStL45Dt/Xxz3lmv93J0f+wGTZZH1gtr6Ho6nsu+
 PfX+YzsFsFuI12f9h12wFr9XJiPc4ZYh7EFszcQfCXOfF9pNZVd5HkfQsZhiCY3fvW
 1EXkClPrEigr/RjGaMPwV55ruNS6vMErCS8B5V1+rfrPZOTNAc+2wpJO/taCJDo7yp
 LEZi3p1okr0Ow==
Date: Wed, 11 Jun 2025 17:45:28 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Fix variable name of msm_clk_data in two drivers
Message-ID: <aElzYGfIOgtsF2Q8@sumit-X1>
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
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

On Wed, Jun 11, 2025 at 02:08:43PM +0200, Luca Weiss wrote:
> Just some fixes with no functional change.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Luca Weiss (2):
>       clk/qcom: sc7280: Fix variable name of msm_clk_data
>       clk/qcom: sm8250: Fix variable name of msm_clk_data

Nice catch!

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
>  drivers/clk/qcom/clock-sc7280.c | 4 ++--
>  drivers/clk/qcom/clock-sm8250.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
> change-id: 20250611-qcom-clk-variable-names-0cb615817b3e
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>
> 
