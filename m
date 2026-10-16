Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF72CCA464
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BE6181499;
	Fri, 16 Oct 2026 12:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fOx5oXwXni0d; Fri, 16 Oct 2026 12:42:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A1B5881489
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792154542;
	b=W6zv55jmrCzKUkf+OqwtZ4yBR6fpQ64/RoS5iTYrM5m8yz6+b++fEOcBWIXqcku6xw3C
	 Q7Uc8ONN6Cuxxem705cRc9asROyHqcDmFi/cWXfrlDwtHnODf63/LtI+2MGQ50DStQnBe
	 rSkQUekoU9ZRXLM/FGsWzZv4WHXvBsRpFqHRu0Y27Vwkap/P19uaWYgbrhsNouzWhXP6V
	 rW6agJ6B8L/dVfkwU4HADeUTDtfSrk6LD3T6l/pRJ2QoO2Pj38zJPSNcw4aaaP42+zydq
	 t9PgRxOiex1DqpheCJ9ScOqImd1684ohh9T02jV9uJ6wPVkqlSMZzGZPFc8p6Cwsi1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792154542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IvKC8ycvUa5OPQERstpi5uDVYYfyHWELxPYzrgAGINk=;
	b=H4jUg+GMnKLJ519s3+rZhMp9EZ6OzRa4+IE1mI1y6VBxY/MXbugvkPAyn7A3PmPmMhU1
	 rutRQsfTcCeeLv/2+11xjZaQmghoTSc/J3HNMiFTOt/7r+KXaM/cDXv8/9ujAxX2Ytw7r
	 buYMWi/9xHQ6fwq8W9R3VJsQKsivajK3CfPAmKk2fTc8NyOABV3gTajJV0bhrQNzGEJpG
	 PsBzfnXfq7DJWhtMcImt0xa7iJ81aTweYoPTKPUCmh/nO5TE9qjwwNVVXdggWWjKOIpXa
	 +y+spUu3uNBXfWmn3+HaGMdVOyvzXbvUwR4VBKGNi+ZX0l5zSgfQlCFa8z/PMdpScPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792154542;
	bh=IvKC8ycvUa5OPQERstpi5uDVYYfyHWELxPYzrgAGINk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJhNZefH3OGLALQAIUo5LiuFBrO3GWceoctvlY4c57Cgf19Ho6R/KcmWNiiRVO9cp
	 3seB9wYzfcIJP2SOMk2MyJOjwmQvGFOe1R+2TH21xIJ87hXxL64nlUxZLY1x7anb2Z
	 5Dgi6J3iwCi9la00wKCZq/D8KwUpMi+14ZFm3mRJveMbQQfcfq7bnjG2QXANkPSlR+
	 UdOuZQ7KNbmpyWL3X3apehH3+r9Kpo5hJtGZUpsE12mm/fnMvvoWsb34yU+1Y1vZvD
	 vqj6dKksUmSpBTYNNSOBjicrfAhovVLQcwSlW3sEvWifO/Ay43jSaif6srful+ohFn
	 7X8SPw2FaOyiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1B5881489;
	Fri, 16 Oct 2026 12:42:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 948D9255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A7E1409F6
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:42:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RbHY44vhgFeU for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:42:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 95931409E3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792154540;
 b=Kuktuk6yqoUHnTY4970z4toXgxmnt12OUHYEXnEV6dQkB7RkknBtN1HEAk6SoYYGPgCe
 NYBNHlPfawODaBYIrE52ynYsw9AiByUOOuWDftrWKbCIVt63qIoRd9vdvdJb2sAi6OnP9
 6zIO3McScvCYVUQLR50E2j65vdbqFRYWpHDZ4ZyXVxaK4fuRITrBvP7ZuH2Lkxgk6KDBs
 cAgtRBJKgm6R/zw0AkuQbnDLnmEwuBXYxxW3XmXDiD/2KJdB8fVXZAftpHnulkiybcxam
 qsx93wTUqvDpJgmQQvli6oS0jub/tAr7pcYYI4PJS9wY6XYMneeSF86DsZIriBG36aA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792154540;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=IvKC8ycvUa5OPQERstpi5uDVYYfyHWELxPYzrgAGINk=;
 b=CAjPpP2CN0OyLlB0NWWaGAyNNztJe6YNfjWoYa4EyHWwddHFRnZCcpIlxfG+MAG1CMnu
 qG26ohTSy5cJ6rzS0LKCsJqcu/hJJn/8D33o2VMDcGu1KpMbBUuXejruZnnZ0NDhxBuzv
 0+ZqqcQ8zChJfkz+kW0LR1Ew32xPZH8lPpy53lIjpJ42ihugHLc9viSORZGLQPRiEy3kb
 Nzyd4RLouNpUXlvlJGIjw8CvJizSKz6QblOxFGURlTfgtkDctHQODrC0cAH+rvmt+zWdx
 voPh9kmEbuRAQr+xZEG+JFBKMHDkpez1TqC7Bz3e5dJdGTMCtb4Qd+h3eea+SJxILPA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DKEYli3I; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DKEYli3I
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95931409E3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:42:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CDF441160;
 Fri, 16 Oct 2026 12:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8A21F000C4;
 Fri, 16 Oct 2026 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792154540;
 bh=IvKC8ycvUa5OPQERstpi5uDVYYfyHWELxPYzrgAGINk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DKEYli3IQUSYDXakg4/ZioXsOJYYavGf5G7RIFgOA3Iz5WTrW9Dfdd666SKaWjRh6
 R4BbbkbTtWt9Vrhw0HPogYkwlLqf7dCzdSQQkSOuZlwFCWV/cRsVs3qPa55bmYCVvO
 H0L+58PfLvWXTgvWxRwLpLaQoBtGWqftHKsAJDPI81XshltMHeEALtJ1IdzZgmN/Tf
 buqNRMCP8PZ6BwxYnK9UchpegXos+2R0izLBtSkekyN47hAqLJdYZg+niSD3naI2iX
 cMeE2cnPby87MsOCpr7MoRXCvdy3QptzFQY3yJbMqcP7bLoPEug+fXPbVNZayW+39+
 1iFl4SuMamhsA==
Date: Fri, 16 Oct 2026 18:12:13 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v3 0/3] Add preliminary support for MSM8917
Message-ID: <atIbpYy2Ql2OzLxt@sumit-xelite>
References: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260916-msm8917-support-v3-0-35103cb4e01e@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, 16 Sep 2026 at 04:16:01 +0000, Reza Kurniawan wrote:
>This patch series adds preliminary support for booting Qualcomm MSM8917.
>
>Specifically, it includes carving out reserved memory regions (no-map) at
>early init to avoid security violations, A Global Clock Controller (GCC)
>driver providing essential clocks, resets, and GDSCs needed for U-Boot and
>a pinctrl driver to configure pin parameters and manage GPIOs.
>
>This patch series depends on the GDSC flags series by Luca Weiss and
>Alexey Minnekhanov [1], specifically patch 4/4 ("clk/qcom: Treat different
>GDSCs differently") [2]. On MSM8917, MDSS_GDSC does not have POLL_CFG_GDSCR
>and requires polling the GDSCR register directly instead of CFG_GDSCR,
>which is addressed by [2].
>
>Changes in v3:
>- Drop "clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit"
>  in favor of Alexey Minnekhanov's series [1] / [2].
>- Update MDSS_GDSC in clock-msm8917 to comply with the new 'flags'
>  member in struct qcom_power_map introduced by [2].

Series look good to me, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>Changes in v2:
>- Change license to GPL-2.0-only
>- Mention the source of the ported code
>- Add error check for out-of-range pin selector
>- Use macros for RCGR address constants
>
>v2: https://lore.kernel.org/u-boot/20260912072619.244101-2-imkyufie@gmail.com
>v1: https://lore.kernel.org/u-boot/20260910095339.110427-1-imkyufie@gmail.com
>
>1: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com
>2: https://lore.kernel.org/u-boot/20260715-gdsc-flags-v2-4-27704470a24c@fairphone.com
>
>---
>Reza Kurniawan (3):
>      mach-snapdragon: Carve out reserved memory at init for MSM8917
>      clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917
>      pinctrl: qcom: Add pinctrl driver for MSM8917
>
> arch/arm/mach-snapdragon/mem_map.c     |   3 +-
> configs/qcom_defconfig                 |   1 +
> drivers/clk/qcom/Kconfig               |   8 +
> drivers/clk/qcom/Makefile              |   1 +
> drivers/clk/qcom/clock-msm8917.c       | 210 +++++++++++
> drivers/pinctrl/qcom/Kconfig           |   8 +
> drivers/pinctrl/qcom/Makefile          |   1 +
> drivers/pinctrl/qcom/pinctrl-msm8917.c | 645 +++++++++++++++++++++++++++++++++
> 8 files changed, 876 insertions(+), 1 deletion(-)
>---
>base-commit: d27c992cebb95bd903d09f3d1da55032a7a145da
>change-id: 20260915-msm8917-support-e56f0d21881b
>prerequisite-message-id: <20260715-gdsc-flags-v2-0-27704470a24c@fairphone.com>
>prerequisite-patch-id: a1b270485786a326cb40fda882935fcc0fbf3bba
>prerequisite-patch-id: 1d4a1450016d914394cf6a7e24ec9e5bc12fe80a
>prerequisite-patch-id: 568826d73bd992c6ff16681ad33e6891e25af5f5
>prerequisite-patch-id: bad5df259c02085a5aa51d130459ae1eecd0f638
>
>Best regards,
>--
>Reza Kurniawan <imkyufie@gmail.com>
>
