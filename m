Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B871E88D70
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 05:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C9084178;
	Sat,  4 Apr 2026 07:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S9UwqaP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330D284189; Sat,  4 Apr 2026 07:10:01 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E734884172
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 07:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fnkDP5WtGz9txV;
 Sat,  4 Apr 2026 07:09:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775279397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=euE9iNynuu+iEn+DDDUjDoj6OxATP25pf4XOH7pFQPg=;
 b=S9UwqaP4id3GUJDCDnrEnLZoY+FvN7+N0dHDI4+PIwkSsSC2H0KI/WqKhTB9W7jMhf/fSl
 jZqG1T2t0now2Ub+DAjl/cszCQ74sg6ujdOF+8j6sBT0InDOrQUOiMT80TGxSw+vHmMAP+
 Za+NySKmtChiczCuaUePXmnOxKdMHxGrpSFEztIBpUh+IOBNnFc1Je3iLGyKhDtb6HOwBM
 caVQWhmIyHAczSh+ZvhN1dbZEgPTvG7BtpoUzWPB2FuWU6uD8oxuiGiPtF2UGKmVkILxuH
 RGgWcCVo5+2VnbhkR6v4Peh4itAEdJTovIvZE00N6JT8ehdeGcHWUvdZCi5cuA==
Message-ID: <7c546ff6-8d17-412b-99fe-42a786b02929@mailbox.org>
Date: Sat, 4 Apr 2026 01:27:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/6] doc: board: nxp: Add Quickboot documentation
To: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, viorel.suman@nxp.com,
 simona.toaca@nxp.com, ye.li@nxp.com, ping.bai@nxp.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, semen.protsenko@linaro.org,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1775121078.git.simona.toaca@nxp.com>
 <bf216cd8652419e9ce7b9133775a2ea4509fe763.1775121078.git.simona.toaca@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <bf216cd8652419e9ce7b9133775a2ea4509fe763.1775121078.git.simona.toaca@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: scmq4bh7nje88f1j481whg5etbo4fwog
X-MBO-RS-ID: 197a052279d622b3643
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

On 4/2/26 11:40 AM, Simona Toaca (OSS) wrote:

[...]

> +DDR QuickBoot flow
> +------------------
> +
> +Some NXP boards (which use OEI - iMX943, iMX95, iMX952 etc.) support saving

boards or SoCs ? I think SoCs ?

> +DDR training data (collected by OEI during Training flow) from volatile
> +to non-volatile memory, which is then available to OEI at next cold reboot.
> +OEI uses the saved data to run Quickboot flow and avoid training the DDR again.
> +This significantly reduces the boot time.
> +
> +The location of the qb data in NVM is a space left in the bootloader by
> +mkimage, with the size of 64K. The qb command searches for this space to
> +save the data. Thus, the NVM should also be a boot device.
> +
> +U-Boot provides no authentication for qb data, only its integrity
> +is verified via the CRC32. The authentication is done in OEI. With
> +the exception of iMX95 A0/A1, which use CRC32 as well for verifying
> +the data, the rest of the boards use ELE to verify the MAC stored

SoCs or SoC revisions ?

[...]

> +2. using qb command in U-Boot console (by enabling CONFIG_CMD_IMX_QB)
> +
> +- supports saving on the current boot device, or on another, specified device.
> +- if flashing via uuu, the command can be added in an uuu script (boot device needs to be specified)
> +- use 'qb erase' to force DDR re-training
> +- use for: saving qb data during flashing / controlling the NVM to save to / forcing re-training
> +
> +::
> +
> +        # To save/erase on current boot device
> +        => qb save/erase
> +
> +        # To save/erase on other boot device
> +        => qb save/erase mmc 0 # eMMC
> +        => qb save/erase mmc 1 # SD
> +        => qb save/erase spi   # NOR SPI

It would be good to have a way to instruct QB to save the data into 
backup location.
