Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632BBF588C3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 13:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F57843D6;
	Mon, 20 Apr 2026 15:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QH+6QATz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794DA843E0; Mon, 20 Apr 2026 15:37:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E30C2843D1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 15:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 47A4A43FF9;
 Mon, 20 Apr 2026 13:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0ABC19425;
 Mon, 20 Apr 2026 13:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776692240;
 bh=YAJWm/RtpO1Y/KRnBbrCK4jWhLznlYZi/JqTR6YZpoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QH+6QATzMfe64HD15hHrBobeCYaqUfrbSabxSDBMgRw6FCv8HAO5EsaVfpdKRdnxt
 S66DQtK9iY8TaQ1erNTWDKsZtUHo7JpGDdy7YOeD4icMKGZ2ekpFgvYoWMsm7DeJV8
 pSiI5fJF5V5a4eTxDhfsNrNfK15u8AJcOJw4MCCcDi4Wj/tbwg7iTorif34Wq0xn+h
 ZrlAhMPx2bKxghxuthJClvLBiiissiM7HmHeD2klzK5N8zu4wyp0y0vKcYbXvT+OKo
 P6xcWgzi3OZTOTLX7c2RZhkcRTLaan1Io1M+02pUOu1wGUe9Rl3lNizvq5/a7C5zeF
 fDOToJbDsDDzA==
Date: Mon, 20 Apr 2026 19:07:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v3 0/5] Add partition type GUID support for environment
Message-ID: <aeYsA_UOFIg0BZOx@sumit-xelite>
References: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419-type-v3-0-ec49acd6870e@oss.qualcomm.com>
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

On Sun, Apr 19, 2026 at 03:54:02PM +0530, Balaji Selvanathan wrote:
> This series adds support for locating partitions using GPT partition
> type GUID instead of unique partition UUID. This enables the saveenv
> command to work with partitions identified by their type rather than
> unique identifiers, providing flexibility for systems where partition
> UUIDs may vary across devices but types remain constant.

Why don't we rather rely on partition name/label instead? That can be
common across platforms too. I would rather prefer a config fragment for
eg. UFS based environment or eMMC based environment and so on.

-Sumit

> 
> Patch 1 adds part_get_info_by_type_guid() function support
> Patch 2 adds scsi_get_blk_by_type_guid() function support
> Patch 3 adds support for partition type GUID based environment
> Patch 4 enables partition type GUID configs for QCM6490 and QCS615
> Patch 5 adds unit test for the partition type GUID lookup functionality
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Addressed minor corrections in Patch 1 in part_get_info_by_type_guid function
> - Refactor env_scsi_get_part and env_scsi_load functions based
>   on the choice configs in Patch 3
> - Add unit test for the partition type GUID lookup functionality in Patch 5
> - Link to v2: https://lore.kernel.org/u-boot/20260109070912.4106466-1-balaji.selvanathan@oss.qualcomm.com/
> 
> Changes in v2:
> - Compute blk_find_max_devnum(UCLASS_SCSI) only once in scsi_get_blk_by_type_guid()
> - Introduce a Kconfig choice config to select between UUID-based
> and type GUID-based partition lookup methods.
> - Enable above new config in qcom_qcs615_defconfig and qcm6490_defconfig
> - Link to v1: https://lore.kernel.org/u-boot/20260108064947.3237361-1-balaji.selvanathan@oss.qualcomm.com/
> 
> ---
> Balaji Selvanathan (5):
>       disk: Add partition lookup by type GUID functionality
>       scsi: Add partition lookup by type GUID for SCSI devices
>       env: scsi: Add support for partition type GUID based environment
>       configs: Enable partition type GUID for QCM6490 and QCS615 boards
>       test: dm: Add partition type GUID lookup test
> 
>  configs/qcm6490_defconfig     |  5 +++++
>  configs/qcom_qcs615_defconfig |  5 +++++
>  disk/part.c                   | 37 +++++++++++++++++++++++++++++++
>  drivers/scsi/scsi-uclass.c    | 28 ++++++++++++++++++++++--
>  env/Kconfig                   | 51 ++++++++++++++++++++++++++++++++++++-------
>  env/scsi.c                    | 45 +++++++++++++++++++++++---------------
>  include/part.h                | 21 ++++++++++++++++++
>  include/scsi.h                | 11 ++++++++++
>  test/dm/part.c                | 48 ++++++++++++++++++++++++++++++++++++++++
>  9 files changed, 223 insertions(+), 28 deletions(-)
> ---
> base-commit: e3405917a1806971d9e72a94186b299f05581e1a
> change-id: 20260419-type-c6a48a1c273d
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
