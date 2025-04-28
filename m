Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725FC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 07:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79CD80AE1;
	Mon, 28 Apr 2025 09:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PH4tnHbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2CF980BAD; Mon, 28 Apr 2025 09:43:17 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAB08056A
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 09:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F1FF45C5F68;
 Mon, 28 Apr 2025 07:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE57C4CEEC;
 Mon, 28 Apr 2025 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745826193;
 bh=9ncEfRVXN7hDRkAdciej44ERJ4ttYO8Rq7VGoaFUxYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PH4tnHbVK710eCM0D3wvw5UiKIRrCqZCTC7RfBLmihrA4PBAahPqLZT7LYx+TCNkI
 MSjuadbOvlp6tGRx/zxPKNEGeXUoHe+uP/+A2pbEy7fM0dwaa1+io61UvazkUsPAGq
 YsxQeodiWrNXROTmijAZDLPIjtXBhPW5iz2NDoD1++Flj9Rnj1lNMGlkY8wBnufhHV
 +uFdFDkGU/bJBo5B6KvyMh7AFNK1DvmhpZXEh6Wqn3j3B0kHj6xTpaPhgUiUQGhGn4
 69yC8zfofhzwYvVBkrnDzbxo/1f0mpu/+EwJTVDLR8SkPmx69mnstYNovu7WbJJLrl
 wtmY+zchocCog==
Date: Mon, 28 Apr 2025 13:13:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
Message-ID: <aA8xi7NRR-jy4fni@sumit-X1>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
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

On Thu, Apr 24, 2025 at 11:16:40AM +0200, Stephan Gerhold wrote:
> Fix some issues in the clock-apq8016 driver that I noticed while testing
> U-Boot v2025.07-rc on the DragonBoard 410c. Make it possible to poll the
> clock status with GATE_CLK() to avoid potential race conditions.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Changes in v2:
> - Rename BRANCH_CLK() -> GATE_CLK_POLLED() and clarify with comment (Casey)
> - Add R-b tags from Neil (I assumed the rename is minor enough to keep them)
> - Link to v1: https://lore.kernel.org/r/20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org
>

Nice fixups, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> ---
> Stephan Gerhold (6):
>       clk: qcom: apq8016: Fix SDCC clock addresses
>       clk: qcom: Move qcom_gate_clk_en() to C file
>       clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
>       clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
>       clk: qcom: apq8016: Convert GATE_CLK() to GATE_CLK_POLLED()
>       clk: qcom: apq8016: Fix SDCC clock warnings
> 
>  drivers/clk/qcom/clock-apq8016.c | 17 ++++++++---------
>  drivers/clk/qcom/clock-qcom.c    | 27 +++++++++++++++++++++++++++
>  drivers/clk/qcom/clock-qcom.h    | 26 ++++++++++----------------
>  3 files changed, 45 insertions(+), 25 deletions(-)
> ---
> base-commit: 233fda6af674736dbc6ff37a9ef003b9fa4b8074
> change-id: 20250419-apq8016-clock-fixes2-66ace5b26ab4
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 
