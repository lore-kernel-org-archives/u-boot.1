Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E66DE8FDA5
	for <u-boot@archiver.kernel.org>; Fri, 26 Dec 2025 08:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDEC384297;
	Fri, 26 Dec 2025 09:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ydo8b0P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13DA1842B6; Fri, 26 Dec 2025 09:37:32 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A699284297
 for <u-boot@lists.denx.de>; Fri, 26 Dec 2025 09:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F2847435AE;
 Fri, 26 Dec 2025 08:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C3C4CEF7;
 Fri, 26 Dec 2025 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766738247;
 bh=8F1xBxexAeSl2vMIgTbjduUuVR+no3BPSnKaNIxTAmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ydo8b0P6zJAfq/IJjoKF8VWQ3PyNaB9syQdeCOcOWMeJ3l1zfT8xxHhKzWC3T6uC0
 oc3yaXeTUtukJ+rD0HHUWF8MwjDsT0nKHWcHSkKCa83JxqK0CGpRssRhL7CbpvVZ7b
 t3FdqXio8Pt2M347GnQTpTJ7rH4pCs/mHQzPtKcWE6CZ3ClYXJmQnsvmYW/PqUvIcV
 7ptm/YIeVUnkgojS4l1+YchvphayVRV+680wB3I8jiHeO7yCs51g3JLig17lXcLKUB
 s95duwLyKxlA3D24PaTnYBuf+iRFtHXrAesR0ghWgxQtOBbPJtBo2GXCp0G7R+Habx
 Ub6VpAbzjC9Ag==
Date: Fri, 26 Dec 2025 14:07:18 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 me@samcday.com, marek.vasut+renesas@mailbox.org,
 alexeymin@postmarketos.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] pinctrl: qcom: Make pinctrl drivers default y
Message-ID: <aU5JPlsbh-ER7Den@sumit-xelite>
References: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
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

On Mon, Dec 22, 2025 at 05:21:42PM +0530, Aswin Murugan wrote:
> This is a follow-up patch series to address review feedback on the
> QCS615 pinctrl driver addition:
> https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com/
> 
> During review, it was suggested that since all Qualcomm pinctrl
> drivers are already within a menu conditional on ARCH_SNAPDRAGON ||
> ARCH_IPQ40XX, they should be made default y based on the appropriate
> architecture rather than requiring manual enablement in defconfig
> files.
> 
> This series implements that suggestion by:
> 1. Adding 'default y if ARCH_SNAPDRAGON' to all Snapdragon pinctrl
>    drivers and 'default y if ARCH_IPQ40XX' to all IPQ pinctrl
>    drivers in the Kconfig

I see the usefullness of this feature but in turn it will limit the
capability to reduce U-Boot size to an essential minimum. In scenarios
where there are contraints on flash size or on-chip RAM for U-Boot SPL.
I would rather favour something like following like:

'default y if PINCTRL_QCOM_GENERIC'

where PINCTRL_QCOM_GENERIC can be enabled from generic Qcom defconfig.

-Sumit

> 2. Removing the now-redundant explicit pinctrl driver selections
>    from qcom_defconfig
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Aswin Murugan (2):
>   pinctrl: qcom: Make pinctrl drivers default y based on architecture
>   configs: qcom_defconfig: Remove redundant pinctrl driver selections
> 
>  configs/qcom_defconfig       | 18 ------------------
>  drivers/pinctrl/qcom/Kconfig | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> -- 
> 2.34.1
> 
