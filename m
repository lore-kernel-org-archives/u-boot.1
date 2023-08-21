Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DA5EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D57D8717F;
	Mon, 21 Aug 2023 21:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LboJCpF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F60871F8; Mon, 21 Aug 2023 21:13:48 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF59871DD
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58e6c05f529so42057627b3.3
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=peuiP+2oF7jq6hv12ayPcC1Q+k0J97VbfzG1+254vzg=;
 b=LboJCpF4H6HMRp4p4673nLJGPCGkCDEBpaMOpOl8zS3+IlwZ62L+H1JPA+Xk9bzqC/
 lGSg0a6xEjn265sPaRhAPklN4HHc7+v32F0LduC9AwejmzJ+kNCgne+8uFktxmT+Qszy
 EK7WBY4BqOThIs2H4gEHV1eKUzmwTyYyr6MEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645219; x=1693250019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peuiP+2oF7jq6hv12ayPcC1Q+k0J97VbfzG1+254vzg=;
 b=XeX2YjfPTTGPT/A4zviSH/pnaDt7vliQ4HE5+mcH9gMSAQ4QLGS/V+FyXVD1LA8k1R
 +nyoeDVJ1Ne3595iRSONfKF/Vg68hA6KtdUD6Q9BN3aO49HDA8rZBGOaRj9QOZUKpet3
 1Eb8St7apks/eBT1GxLYnzTf1Riorpe7Jn9I5jjvoW06mDg0ElE6fHwLYCUC0WEzjUAl
 vtlLG3LzzGOdX9I+LOJVMlw4QciBaSVifo+NBAYojrFWTwGZcUis+udHgBqZfpe+BSfO
 Pp+wv6O2ByVVpF9GBEXY0tGb836kTr2V/1bfRIMKXx8v0ZMCH8drBg7VHwiQ4YyCuMj9
 dpxA==
X-Gm-Message-State: AOJu0YxlrHrrTa0Wf9X+Jm7Gi0s1YS979xKkdq7dYEzFukOyW2V29kmp
 t+w3kqARxExIEMriYDCaJW9JzmUq8AMSZdzWPgN8Cw==
X-Google-Smtp-Source: AGHT+IHKQRhsgkKuuzrsFqMt4f72ppjxq7hjCyxGSoYklaPMNOtPdsaLj/rDMDnuNOacG6GmfxMT4ofmDDzwjvKsQr8=
X-Received: by 2002:a25:fc15:0:b0:d62:ba45:539f with SMTP id
 v21-20020a25fc15000000b00d62ba45539fmr7843516ybd.43.1692645218739; Mon, 21
 Aug 2023 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
 <20230821135111.3558478-14-alpernebiyasak@gmail.com>
In-Reply-To: <20230821135111.3558478-14-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:54 -0600
Message-ID: <CAPnjgZ2Ct9YJq5bFLabnrmF6wO5HUfsNtwpg40GKcVeQwiG+wQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/13] video: Enable VIDEO_DAMAGE for drivers that need
 it
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, uboot-stm32@st-md-mailman.stormreply.com, 
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 21 Aug 2023 at 07:51, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> From: Alexander Graf <agraf@csgraf.de>
>
> Some drivers call video_set_flush_dcache() to indicate that they want to
> have the dcache flushed for the frame buffer. These drivers benefit from
> our new video damage control, because we can reduce the amount of memory
> that gets flushed significantly.
>
> This patch enables video damage control for all device drivers that call
> video_set_flush_dcache() to make sure they benefit from it.
>
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> [Alper: Add to VIDEO_TIDSS, imply instead of select]
> Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
> Changes in v5:
> - Imply VIDEO_DAMAGE for video drivers instead of selecting it
> - Imply VIDEO_DAMAGE also for VIDEO_TIDSS
>
> Changes in v4:
> - Add patch "video: Enable VIDEO_DAMAGE for drivers that need it"
>
>  arch/arm/mach-omap2/omap3/Kconfig | 1 +
>  arch/arm/mach-sunxi/Kconfig       | 1 +
>  drivers/video/Kconfig             | 8 ++++++++
>  drivers/video/exynos/Kconfig      | 1 +
>  drivers/video/imx/Kconfig         | 1 +
>  drivers/video/meson/Kconfig       | 1 +
>  drivers/video/rockchip/Kconfig    | 1 +
>  drivers/video/stm32/Kconfig       | 1 +
>  drivers/video/tegra20/Kconfig     | 1 +
>  drivers/video/tidss/Kconfig       | 1 +
>  10 files changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
