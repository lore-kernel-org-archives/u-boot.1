Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A17D3CCB6
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 07:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F6C82BF2;
	Thu, 15 Jan 2026 08:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O9gQKj7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C9682C7F; Thu, 15 Jan 2026 08:10:42 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F3080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CAB4D60157;
 Thu, 15 Jan 2026 07:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8121DC116D0;
 Thu, 15 Jan 2026 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768461038;
 bh=qJn4HN2N8Algp78fFSp4eCd8y3C4h0aZD/hcHBWG6wg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O9gQKj7Ujmtp+99zAjYyPR4ni97KacmsTr8BnqVG72LdRt97376WsrO/naRjCUIdm
 46359UH3hMnjWe4/tc+OBRcmuDeX7LvTiNZQldAT0tLJ9By7yY6d8X0vzpDVZ8r4QB
 b3nZgAt9rb9HXdb+MYgmg7XYA2V4XLSkBisLvfyZzTGHN0cOhqBabjyZX+YqOW8ixq
 AmLBrs04CQAidB8Cg2T/G4Ev3D7sqc8fLB35CxrVmOkfPc3DIHymFJyrYPLWBx5j1c
 gfFbL8+wEdJiLazJvxryJ3++K/UnBQQgeCB7DgQss+CgvQvtS51yXSATXQaoDHiKfT
 6I4LBBLd648RQ==
Date: Thu, 15 Jan 2026 12:40:30 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, alexeymin@minlexx.ru,
 danila@jiaxyga.com, david.wronek@mainlining.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable
 all drivers by default
Message-ID: <aWiS5ixFCnbK3_sN@sumit-xelite>
References: <20260107154745.571319-1-aswin.murugan@oss.qualcomm.com>
 <20260107154745.571319-2-aswin.murugan@oss.qualcomm.com>
 <6037846c-ca4d-4927-a6c0-f8f0cfb96f80@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6037846c-ca4d-4927-a6c0-f8f0cfb96f80@cherry.de>
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

On Wed, Jan 14, 2026 at 06:29:55PM +0100, Quentin Schulz wrote:
> Hi Aswin,
> 
> On 1/7/26 4:47 PM, Aswin Murugan wrote:
> > Introduce a new Kconfig option PINCTRL_QCOM_GENERIC that, when selected,
> > enables all Qualcomm pinctrl drivers by default. This simplifies defconfigs
> > for platforms supporting multiple SoCs and avoids manual driver selection.
> > Individual drivers can still be disabled if required.
> > 
> > Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - As per review comments made default y for pinctrl drivers
> >    based on PINCTRL_QCOM_GENERIC config 'default y if PINCTRL_QCOM_GENERIC'
> > ---

"---" is redundant here and may be causing issues with the b4 patch
pickup.

> >   drivers/pinctrl/qcom/Kconfig | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> > index 725200d94c8..580308621b1 100644
> > --- a/drivers/pinctrl/qcom/Kconfig
> > +++ b/drivers/pinctrl/qcom/Kconfig
> > @@ -6,8 +6,17 @@ config PINCTRL_QCOM
> >   menu "Qualcomm pinctrl drivers"
> > +config PINCTRL_QCOM_GENERIC
> > +	bool "Enable all Qualcomm pinctrl drivers by default"
> > +	select PINCTRL_QCOM
> > +	help
> > +	  Say Y here to enable all Qualcomm pinctrl drivers by default.
> > +	  This is useful for generic Qualcomm defconfigs that support
> > +	  multiple SoCs. Individual drivers can still be disabled if needed.
> > +
> >   config PINCTRL_QCOM_APQ8016
> >   	bool "Qualcomm APQ8016 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the MSM8916 / APQ8016
> > @@ -15,6 +24,7 @@ config PINCTRL_QCOM_APQ8016
> >   config PINCTRL_QCOM_APQ8096
> >   	bool "Qualcomm APQ8096 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the MSM8996 / APQ8096
> > @@ -22,6 +32,7 @@ config PINCTRL_QCOM_APQ8096
> >   config PINCTRL_QCOM_IPQ4019
> >   	bool "Qualcomm IPQ4019 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
> > @@ -29,6 +40,7 @@ config PINCTRL_QCOM_IPQ4019
> >   config PINCTRL_QCOM_IPQ5424
> >   	bool "Qualcomm IPQ5424 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the IPQ5424 SoC,
> > @@ -36,6 +48,7 @@ config PINCTRL_QCOM_IPQ5424
> >   config PINCTRL_QCOM_IPQ9574
> >   	bool "Qualcomm IPQ9574 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
> > @@ -43,6 +56,7 @@ config PINCTRL_QCOM_IPQ9574
> >   config PINCTRL_QCOM_QCM2290
> >   	bool "Qualcomm QCM2290 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the Snapdragon QCM2290 SoC,
> > @@ -50,6 +64,7 @@ config PINCTRL_QCOM_QCM2290
> >   config PINCTRL_QCOM_QCS404
> >   	bool "Qualcomm QCS404 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> >   	select PINCTRL_QCOM
> >   	help
> >   	  Say Y here to enable support for pinctrl on the Snapdragon QCS404 SoC,
> > @@ -57,6 +72,7 @@ config PINCTRL_QCOM_QCS404
> >   config PINCTRL_QCOM_QCS615
> >           bool "Qualcomm QCS615 Pinctrl"
> > +	default y if PINCTRL_QCOM_GENERIC
> 
> Indentation seems incorrect here?

With indentation fixed, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> b4 doesn't want to pick up the patch from lore so cannot check if it's an
> actual problem or not. See:
> 
> $ b4 shazam --add-my-sob --add-link https://lore.kernel.org/u-boot/67140dbd-1b93-43d1-b218-0b57a762ce1a@linaro.org/
> [...]
> Applying: pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all drivers by
> default
> Patch failed at 0001 pinctrl: qcom: add PINCTRL_QCOM_GENERIC to enable all
> drivers by default
> error: sha1 information is lacking or useless
> (drivers/pinctrl/qcom/Kconfig).
> error: could not build fake ancestor
> [...]
> 
> Cheers,
> Quentin
