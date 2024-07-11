Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEF8C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 05:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1DB3885EB;
	Fri, 12 Jul 2024 07:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="Ja/3yozb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7161A87FC7; Thu, 11 Jul 2024 21:38:24 +0200 (CEST)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 681DB8827D
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 21:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
X-Envelope-To: kever.yang@rock-chips.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1720726700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nNzB71q3ef9KInPezsmlQA4fWC2/378osp8+0tA2v0=;
 b=Ja/3yozbUBKtmp+1hEduKrRQrr2yfA+O0Q+4evBVLNxkiQPOIwVtnRvJtqAJbKUvFFyqxj
 pG1SSAErRzW028S82et2dHOu4Bo+0K8N88BPc1TPmgS8jp1bDmIUK8bVHBttkUC8NWGcpf
 WUoZKez7diyDcUimGsySXP7qbJfWz70KpTXj398qZ7dj/CwtbAicvlQ/n216F1T2I1k7c9
 Z7QE1DhIMwHyOZoj9bwSoFckWoq8PJG1BANA0dC1fcbYBCerZ2z/G15qCJJYHmvwhjnUFL
 z4cd7QoCscYtmQ8SJ3el4IUa6ChCaORGjfSSY1Zy1/HZ7PSkgxFF7PTJtW7z/w==
X-Envelope-To: sjg@chromium.org
X-Envelope-To: philipp.tomsich@vrull.eu
X-Envelope-To: chenjh@rock-chips.com
X-Envelope-To: andyshrk@163.com
X-Envelope-To: cnsztl@gmail.com
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: frattaroli.nicolas@gmail.com
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: gajjar04akash@gmail.com
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: david.wu@rock-chips.com
X-Envelope-To: eugen.hristev@collabora.com
X-Envelope-To: frank-w@public-files.de
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: stefan@agner.ch
X-Envelope-To: didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
Cc: David Wu <david.wu@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Stefan Agner <stefan@agner.ch>,
 Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH v2 6/7] configs: rockchip: Enable ethernet driver on
 RK356x boards
Date: Thu, 11 Jul 2024 21:38:08 +0200
Message-ID: <2086393.9F9pDXStbY@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231001191730.4167035-7-jonas@kwiboo.se>
References: <20231001191730.4167035-1-jonas@kwiboo.se>
 <20231001191730.4167035-7-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2276470.1dZ1CPmI8s";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 12 Jul 2024 07:05:58 +0200
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

--nextPart2276470.1dZ1CPmI8s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Thu, 11 Jul 2024 21:38:08 +0200
Message-ID: <2086393.9F9pDXStbY@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231001191730.4167035-7-jonas@kwiboo.se>
MIME-Version: 1.0

Hi,

On Sunday, 1 October 2023 21:17:21 CEST Jonas Karlman wrote:
> Enable DWC_ETH_QOS_ROCKCHIP and related PHY driver on RK356x boards that
> have an enabled gmac node.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> ...
>  configs/odroid-m1-rk3568_defconfig        | 3 +++
>  configs/quartz64-a-rk3566_defconfig       | 3 +++
>  configs/quartz64-b-rk3566_defconfig       | 3 +++
>  ...
>  configs/soquartz-blade-rk3566_defconfig   | 3 +++
>  configs/soquartz-cm4-rk3566_defconfig     | 3 +++
>  configs/soquartz-model-a-rk3566_defconfig | 3 +++
>  11 files changed, 35 insertions(+), 6 deletions(-)
> ...
> diff --git a/configs/odroid-m1-rk3568_defconfig
> b/configs/odroid-m1-rk3568_defconfig index 3dda5c1f9170..96b4e9ecdaff
> 100644
> --- a/configs/odroid-m1-rk3568_defconfig
> +++ b/configs/odroid-m1-rk3568_defconfig
> @@ -82,6 +82,9 @@ CONFIG_SF_DEFAULT_BUS=4
>  CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_MACRONIX=y
>  CONFIG_SPI_FLASH_MTD=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCIE_DW_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/quartz64-a-rk3566_defconfig
> b/configs/quartz64-a-rk3566_defconfig index 6853cd6c44b4..bf4d4cd2b8ed
> 100644
> --- a/configs/quartz64-a-rk3566_defconfig
> +++ b/configs/quartz64-a-rk3566_defconfig
> @@ -81,6 +81,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_SPI_FLASH_MACRONIX=y
>  CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_MOTORCOMM=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCIE_DW_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> diff --git a/configs/quartz64-b-rk3566_defconfig
> b/configs/quartz64-b-rk3566_defconfig index aa29fff14643..358687ab5d7f
> 100644
> --- a/configs/quartz64-b-rk3566_defconfig
> +++ b/configs/quartz64-b-rk3566_defconfig
> @@ -79,6 +79,9 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPI_FLASH_GIGADEVICE=y
>  CONFIG_SPI_FLASH_MACRONIX=y
>  CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>  CONFIG_NVME_PCI=y
>  CONFIG_PCIE_DW_ROCKCHIP=y
>  CONFIG_PHY_ROCKCHIP_INNO_USB2=y

Some time ago I reported to Jonas privately that I had a problem with
my Quartz64 Model A and B and that I bisected it to this commit.
I just verified that the problem is still present in 2024.07, so I
guess it's time to report it to the (right) Mailing List.

The problem: packet loss, varying, but sometimes massive
Q64-A: The packet loss was usually between 8% and 30%
Q64-B: Packet loss up to 80% sometimes and this also resulted (then) in
its inability to receive a DHCP address.

https://lore.kernel.org/linux-rockchip/27139798.WhXITi6ROJ@bagend/
is where I brought this issue (also) up publicly, but that was on the 
linux-rockchip ML. The discussion that followed may provide some clues.

When looking up the mail I'm now replying too, I noticed a reply by
Stefan Agner with very similar symptoms, but on Odroid M1.

And the fix in my case has always been easy:

diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index 1ea8e0f40cc..641452f9162 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -67,9 +67,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_MOTORCOMM=y
-CONFIG_DWC_ETH_QOS=y
-CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index f61b2c181a1..aae5d66edeb 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -65,9 +65,6 @@ CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_PHY_REALTEK=y
-CONFIG_DWC_ETH_QOS=y
-CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_DW_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y

IOW: a (partial) revert of commit 25f56459aebc

It _could_ be that the issue is also present on the various SOQuartz
devices/boards, but I don't have those, so I can't check that.
But AFAIK they are rather similar to Q64-A and the change has also
been the same ... as was the case for Odroid-M1.

In case it's useful I have a log from the serial session with the
Q64-A (212.5 KiB) available.
Serial on Q64-B doesn't work, so I don't have that.

Cheers,
  Diederik
--nextPart2276470.1dZ1CPmI8s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZpA0oAAKCRDXblvOeH7b
bspYAQC+qFW4JlXsFvfMHanmtsoSCAHo2AqNqTbymzf+i49DngEAw5y20UpSmncw
ugf0c8ggJ+V4H7W/fitKix0KqelozwI=
=fpOR
-----END PGP SIGNATURE-----

--nextPart2276470.1dZ1CPmI8s--



