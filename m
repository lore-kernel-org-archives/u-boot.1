Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D46C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DC5820B7;
	Mon, 28 Apr 2025 10:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HtsC9D02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE8E482145; Mon, 28 Apr 2025 10:37:03 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A0C80EFB
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:37:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 13ADB4A72B;
 Mon, 28 Apr 2025 08:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE07C4CEE4;
 Mon, 28 Apr 2025 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745829420;
 bh=XV7l3IdNDdw4/meHPUpsGDg45jN3apRiRqLSJFmuWDc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HtsC9D02TyWZi1xbtLtEIKViqsSn5GDNQS3xpwC9+FmeLWLWdvp1I+pQsLVVhPfBi
 sAyFj9UBKObsVLhuGcfPzo4ScTHFyuwis3yggPng0z3tvM3i3kmBr+/ZbB2GaW1SDU
 HBZ06ACilnsncuGS5EqHCRYhMKLct//hxi4UWHsqCVZ+doeXdgG1C/Y1Y+ozHoZpfM
 57K9RQ4hjq5quSWdOsDlQQe+9cF61jmirFxNUUMvbQcR2Yr+6RNCIJTLktTaZ3UOba
 ii34iwLdkyXrLWc4c1UbpkFZ5WNmVCSRzcieC2NBAr00GjUUaTiygT+/MVwG8dlH7L
 xbVGMbhgkIqNA==
Date: Mon, 28 Apr 2025 14:06:52 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 me@samcday.com, marex@denx.de, robert.marko@sartura.hr,
 seashell11234455@gmail.com, ycliang@andestech.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/3] configs: qcs9100_defconfig: Enable SYSRESET
Message-ID: <aA8-JChaN9WxC6Ew@sumit-X1>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-4-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410120208.4142087-4-quic_varada@quicinc.com>
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

On Thu, Apr 10, 2025 at 05:32:08PM +0530, Varadarajan Narayanan wrote:
> Move to SYSRESET for implementing the reset command.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  configs/qcs9100_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d25398..1fb621b27ce 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -16,3 +16,5 @@ CONFIG_TEXT_BASE=0xaf000000
>  CONFIG_REMAKE_ELF=y
>  
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_QCOM_PSCI=y
> -- 
> 2.34.1
> 
