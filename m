Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21505C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 05:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F7DB82B9D;
	Mon,  7 Apr 2025 07:17:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="YnZcPCxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAF1682B7E; Sun,  6 Apr 2025 22:09:25 +0200 (CEST)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com
 [95.215.58.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706D182B63
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 22:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1743970162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSwKdb1Qwj4dLUmivrQ/x9HEYpV9z5WXJKLkXePDM1s=;
 b=YnZcPCxDVOTLr0i8zSsfE3H+deuCoulD1CIsBmn4zg/p3H/3IDnjTa8e2WVZWrSnvDAijb
 Iyz8qnUt5m0Vzz8fIsrwl4Gh5zhbbKZ4gef73Rc9EiGi9LQmPiLMTtVii8L/k+QsA6wcZ/
 61i8nNl/gukrAdafX3E63cBPWCRYc3EEIg6cfTuMgDeXH6eVUrZZ8me2AXBEBVu8Gwj3je
 nUiRBr0SNvIlWlm8I77aepdijzS1PQ6ZJYHF0c3iQFEzL/DFaqXq1gl06YsZCWSyK9+7p0
 WiCy9N7mBsg/tOkMOH7Ge53rNLZIR/IrRE2Q7TKk+FG4VprhYrKpFtJRUC5Wkw==
Content-Type: multipart/signed;
 boundary=2a9b8816f841e00ffc5169555bc8b8ba92e416981b2ed8f42427abcf179f;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sun, 06 Apr 2025 22:09:13 +0200
Message-Id: <D8ZTTOA3Q6Q1.39Q6ZX28395IG@cknow.org>
To: "Diederik de Haas" <didi.debian@cknow.org>, "Kever Yang"
 <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chromium.org>, "Philipp
 Tomsich" <philipp.tomsich@vrull.eu>, "Joseph Chen" <chenjh@rock-chips.com>,
 "Andy Yan" <andyshrk@163.com>, "Tianling Shen" <cnsztl@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Nicolas Frattaroli"
 <frattaroli.nicolas@gmail.com>, "Jagan Teki" <jagan@amarulasolutions.com>,
 "Akash Gajjar" <gajjar04akash@gmail.com>, <u-boot@lists.denx.de>
Cc: "David Wu" <david.wu@rock-chips.com>, "Eugen Hristev"
 <eugen.hristev@collabora.com>, "Frank Wunderlich"
 <frank-w@public-files.de>, "Stefan Agner" <stefan@agner.ch>
Subject: Re: [PATCH v2 6/7] configs: rockchip: Enable ethernet driver on
 RK356x boards
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-7-jonas@kwiboo.se> <2086393.9F9pDXStbY@bagend>
In-Reply-To: <2086393.9F9pDXStbY@bagend>
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 07 Apr 2025 07:17:49 +0200
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

--2a9b8816f841e00ffc5169555bc8b8ba92e416981b2ed8f42427abcf179f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu Jul 11, 2024 at 9:38 PM CEST, Diederik de Haas wrote:
> Some time ago I reported to Jonas privately that I had a problem with
> my Quartz64 Model A and B and that I bisected it to this commit.
> I just verified that the problem is still present in 2024.07, so I
> guess it's time to report it to the (right) Mailing List.
>
> The problem: packet loss, varying, but sometimes massive
> Q64-A: The packet loss was usually between 8% and 30%
> Q64-B: Packet loss up to 80% sometimes and this also resulted (then) in
> its inability to receive a DHCP address.

I just build a ~2025.04-rc5 (i.e. 'master') version and tried it on my
Q64-B and the problem is still there.
Furthermore, there have now been several ppl on #quartz64 IRC channel
(on Pine64 IRC network) who have confirmed both the problem and the
'solution'/workaround. Hopefully they'll also report here themselves.

> And the fix in my case has always been easy:
>
> diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3=
566_defconfig
> index 1ea8e0f40cc..641452f9162 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -67,9 +67,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> -CONFIG_PHY_MOTORCOMM=3Dy
> -CONFIG_DWC_ETH_QOS=3Dy
> -CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
>  CONFIG_NVME_PCI=3Dy
>  CONFIG_PCIE_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
> diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3=
566_defconfig
> index f61b2c181a1..aae5d66edeb 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -65,9 +65,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=3Dy
>  CONFIG_SPI_FLASH_GIGADEVICE=3Dy
>  CONFIG_SPI_FLASH_MACRONIX=3Dy
>  CONFIG_SPI_FLASH_WINBOND=3Dy
> -CONFIG_PHY_REALTEK=3Dy
> -CONFIG_DWC_ETH_QOS=3Dy
> -CONFIG_DWC_ETH_QOS_ROCKCHIP=3Dy
>  CONFIG_NVME_PCI=3Dy
>  CONFIG_PCIE_DW_ROCKCHIP=3Dy
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=3Dy
>
> IOW: a (partial) revert of commit 25f56459aebc

I didn't try it this time; I just dd-ed my patched 2024.07 version and
then everything worked again.

It would be nice to get this fixed. I don't know how to fix it myself,
but I'm happy to test a potential patch for it.

Cheers,
  Diederik

--2a9b8816f841e00ffc5169555bc8b8ba92e416981b2ed8f42427abcf179f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ/LfbAAKCRDXblvOeH7b
brk5AQCSGmtUVyu0aUL3H8/8iuyacrvnUBmsjlmvxPmfcvnxpwEAlG2SLKQkasxT
xNtBnqDPHjPl60qo2RHLVFzFPrEcqQY=
=Eyz2
-----END PGP SIGNATURE-----

--2a9b8816f841e00ffc5169555bc8b8ba92e416981b2ed8f42427abcf179f--
