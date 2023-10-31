Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8141FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 08:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5A038702C;
	Tue, 31 Oct 2023 09:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44A0870C9; Tue, 31 Oct 2023 09:26:46 +0100 (CET)
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de
 [80.67.18.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3FD78702C
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
Received: from [89.1.81.74] (helo=karo-electronics.de)
 by smtprelay06.ispgateway.de with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.1)
 (envelope-from <LW@KARO-electronics.de>) id 1qxk5C-0006dw-36;
 Tue, 31 Oct 2023 09:26:43 +0100
Date: Tue, 31 Oct 2023 09:26:41 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>, Roger Knecht
 <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>, Simon Glass
 <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
Message-ID: <20231031092641.0675aee4@karo-electronics.de>
In-Reply-To: <20231010124728.7930-1-marex@denx.de>
References: <20231010124728.7930-1-marex@denx.de>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
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

Hi,

On Tue, 10 Oct 2023 14:47:28 +0200 Marek Vasut wrote:
> Add extension to the 'mmc' command to read out the card registers.
> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
> supported. A register value can either be displayed or read into
> an environment variable.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Roger Knecht <rknecht@pm.me>
> Cc: Sean Edmond <seanedmond@microsoft.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> V2: - Update documentation
> ---
>  cmd/Kconfig           |  8 ++++
>  cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/cmd/mmc.rst | 26 ++++++++++++
>  3 files changed, 130 insertions(+)
>=20
[...]
> +	if (!strcmp(argv[2], "ocr")) {
> +		printf("OCR: 0x%08x\n", mmc->ocr);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->ocr);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "rca")) {
> +		printf("RCA: 0x%08x\n", mmc->rca);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->rca);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "extcsd") &&
> +	    mmc->version >=3D MMC_VERSION_4_41) {
> +		ret =3D mmc_send_ext_csd(mmc, ext_csd);
> +		if (ret)
> +			return ret;
			return CMD_RET_FAILURE;


Lothar Wa=C3=9Fmann
