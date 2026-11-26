Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1DD606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G/FgRVzR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2c/R04K
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 314FE60A8C;
	Thu, 26 Nov 2026 14:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8hL2cV5o0t8; Thu, 26 Nov 2026 14:01:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FDD460A67
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795701673;
	b=gzmNpidPL4yszE7L0Hs9NVNzkB4bjRpsMoJyPKi73WZnDBYDFu0vRYaypFyxIc6MPcx1
	 tD4/LhGG3vzIEU2SxmfekOfjgx4bCqR6yWfrG18OOZWmwgtUhdyvEJkE9siBFXrAjzQks
	 4XJYXNx25zOeCa1T05U/2TBS0gFFfrATJhi8DNHYoN1NjfP3JEP+J+dbSJ/M4EdMFhPVX
	 ykwhu2yIKq2EnDLHtgMDcS9zPVEhmTqkUwW6qJq4mR15UsMzQOdIVYt7m84ckbaS0MF1v
	 4iI5ZlwbeTZjc7HqOY5MZSB8icrQ95Ol4K8z+6LkaSIDLbUDhp1x1frfRgG3EfN69hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FQXbK+9NIt3flv6mmODiTdeELh/wGFpxv1bmOuX5H2s=;
	b=eg+uQJKLiKMSC5dAAOY0LAfHeP6YedLYriAFrmewlAZc3tEUNIoEsehNFrz/K4bmx3pR
	 Q4MOm/KHCLoNPJ5L/GOv+frLBEp4BhNC4+yf3Q5THJvfeFjpCw+tn4jmzj97P4ORrnLeV
	 b5lb9ImMiHrWweAmIhH6aUhRPGt6osOmF/wAso+xhtwf+7Ni6tDa38fptGJioLRgPzYd6
	 6+u8e5D6PewQtvCymvWZUs0lSVdXmaveP/GacW4429Qdj6cp7HUTqcyFQ3AmjdZry37St
	 gpiV2qJmSlOEyg6pbKvRGnlmEj6gJ2xwayLhPmy5tTX3gH9kz6ZiTb8+xxh4r7n1pbA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795701673;
	bh=FQXbK+9NIt3flv6mmODiTdeELh/wGFpxv1bmOuX5H2s=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G/FgRVzRod1fTiHMFBndLoOiWoNmtaGYRllFiD7onbIQkm8Hz6DzqhAIVEUSsAPu5
	 55ZHOlr59/S/CauCAbRrwayeGdnXYyYkrKHnt3ET/0lNB8RCXWM4LpOj0m9EeTgT2S
	 FwGLv4rqByStfSErkN7EprWlGNE0bmNKo/3ElIY1Jk5wPf7f8m2AuU8squSJpZslMN
	 DF433I5kzGMRExIxLGlUQNs4GD4T3OJbKNQ/UYynLjj1xR1WJ30wMIGEJxfw+nBkmt
	 cVPGS4XQ9Bxx25gP9/PeW4LVy+KWksziRFg23QdK6EggpiMu5P2dq51jK2X3noj6w5
	 pDqcE9ZkaCo+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FDD460A67;
	Thu, 26 Nov 2026 14:01:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B724311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69710404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bjgXZwH9CRwr for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 886FE40111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=J2c/R04K
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 886FE40111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:01:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B9E89414DC;
 Thu, 26 Nov 2026 14:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A9B1F000C4;
 Thu, 26 Nov 2026 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701668;
 bh=FQXbK+9NIt3flv6mmODiTdeELh/wGFpxv1bmOuX5H2s=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=J2c/R04KyF8hKGXvgYpr25hQZET7BgkyFaxEA88lQzQkhZ/LAl02h6Fj2UmIWIyrm
 qKZFeWb63jTua1uDPDF2ZRPBQ4aN/uWhK31l4PpSnhK3kEPvNPXtmaERXEvdq8j1lD
 p581NMgXSsckWRjwxmriBxqqtcPrHe9esH9ASFBpubtahm5cm8KvNxnAg/FBNFAaRB
 622Y6LEQLqS01X6dv9hnrZC9ZRpv7M8SuFevy3fYT2LPCou+tp8I3NIFNTjhF8KeJ9
 KPfQFER8SbAOtvp4gn8oR0j4v4AyeHNgTmgvkrFYQkf3rt3RPkKL7V7tFlabeJVmsl
 lUwfojTj+1Ekw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 0/9] arm64: qcom: Add initial support for Shikra SoC
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, trini@konsulko.com, lukma@nabladev.com, 
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com, 
 Michael.Srba@seznam.cz, quentin.schulz@cherry.de, 
 william.bright@imd-tec.com, nikroks@mainlining.org, 
 macpaul.lin@mediatek.com, dlechner@baylibre.com, xerikasxx@gmail.com, 
 jbx6244@gmail.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
References: <20261124164700.1606518-1-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:30:59 +0530
Message-Id: <179570165966.130558.14577661340904472881.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-24 22:16 +0530, Aswin Murugan wrote:
> This series adds initial support for the Qualcomm Shikra SoC in U-Boot,
> including device tree, clock, pinctrl, SMEM updates, USB and configuration
> changes required to enable early boot on Shikra-based platforms.
> 
> The device tree support is ported from a Linux linux-next branch

Please keep cover letter up to date as now the Shikra DT landed in
U-Boot via dts/upstream subtree.

-Sumit

> 
> The series includes:
>   - GCC clock driver support
>   - Pinctrl driver for Shikra TLMM
>   - USB hsphy & ssphy support
>   - SMEM update to support higher host count required by Shikra
>   - Defconfig updates and Shikra-specific defconfig
>   - MAINTAINERS entry for Shikra platforms
>   - Documentation for Shikra platform
> 
> Thanks,
> Aswin
> 
> Changes in v6:
> - use CONFIG_IS_ENABLED() instead of IS_ENABLED() for TCPM check in qcom-qmp-usbc
> 
> Link to v5: https://lore.kernel.org/u-boot/20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v5:
> - Use GATE_CLK_POLLED() for CBCR-backed gate clocks that require branch-enable
>   polling before use in clock driver.
> - Align the Shikra USB3 QMP PHY driver with the upstream Linux
>   phy-qcom-qmp-usbc.c driver
> - Skip remote hosts beyond SMEM_HOST_COUNT during partition enumeration instead
>   of failing in smem driver
> - Add MAINTAINERS entry and board documentation for the Shikra IQS board
>   enablement patch.
> 
> Link to v4: https://lore.kernel.org/u-boot/20261021160916.3894471-1-aswin.murugan@oss.qualcomm.com/
> 
> Changes in v4:
> - Drop DTS files already present upstream.
> - Keep only the IQS board variant defconfig, remove the CQS board variant defconfig.
> - Add documentation for the board.
> 
> Link to v3: https://marc.info/?l=u-boot&m=178668446732727&w=2
> 
> Changes in v3:
> - Added USB3 support
> - Created defconfigs for IQS & CQS variants
> - Added WDT & fastboot configs in the shikra defconfig
> 
> Link to v2: https://marc.info/?l=u-boot&m=178595470886921&w=2
> 
> Changes in v2:
> - Added USB hsphy support
> - Ported Shikra dts files from Linux linux-next branch
> - Created config fragment for debug UART
> 
> Link to v1: https://lore.kernel.org/u-boot/20260615121828.1798789-1-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (9):
>   clk: qcom: add GCC clock driver support for shikra SoC
>   pinctrl: qcom: add driver for shikra SoC
>   phy: qcom: qusb2: add Shikra PHY configuration
>   phy: qcom: add QMP USB3 PHY driver for Shikra
>   qcom: smem: ignore partition entries with unsupported host IDs
>   tools: qcom: mkmbn: add Shikra board mappings
>   qcom_defconfig: Enable Shikra clock & USB driver
>   configs: qcom: add debug UART config fragment for shikra-evk
>   configs: add shikra defconfig, MAINTAINERS and doc for IQS board
> 
>  board/qualcomm/MAINTAINERS             |   5 +
>  board/qualcomm/debug-shikra-evk.config |   5 +
>  configs/qcom_defconfig                 |   2 +
>  configs/qcom_shikra_iqs_defconfig      |  31 ++
>  doc/board/qualcomm/dragonwing.rst      |  16 +-
>  drivers/clk/qcom/Kconfig               |   8 +
>  drivers/clk/qcom/Makefile              |   1 +
>  drivers/clk/qcom/clock-shikra.c        | 344 ++++++++++++++++
>  drivers/phy/qcom/Kconfig               |   7 +
>  drivers/phy/qcom/Makefile              |   1 +
>  drivers/phy/qcom/phy-qcom-qmp-usbc.c   | 534 +++++++++++++++++++++++++
>  drivers/phy/qcom/phy-qcom-qusb2.c      |  14 +
>  drivers/pinctrl/qcom/Kconfig           |   8 +
>  drivers/pinctrl/qcom/Makefile          |   1 +
>  drivers/pinctrl/qcom/pinctrl-shikra.c  | 478 ++++++++++++++++++++++
>  drivers/soc/qcom/smem.c                |   5 +-
>  tools/qcom/mkmbn/mkmbn.py              |   2 +
>  17 files changed, 1456 insertions(+), 6 deletions(-)
>  create mode 100644 board/qualcomm/debug-shikra-evk.config
>  create mode 100644 configs/qcom_shikra_iqs_defconfig
>  create mode 100644 drivers/clk/qcom/clock-shikra.c
>  create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usbc.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-shikra.c
> 
> -- 
> 2.34.1
> 
> 


