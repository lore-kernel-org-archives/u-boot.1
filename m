Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF960B507C
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TWQ3tsbX;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=iO1+8ZCV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YmQok73M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87FCF606C7;
	Mon, 19 Oct 2026 15:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lqlifhuvBmE; Mon, 19 Oct 2026 15:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1A55606F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792423669;
	b=KIe8EIaD9FLGuQtOw43C62xJXvmK7z+3wmszu6YSmgp2AD2YtKaT9oNWd2sZL9BLqACj
	 /zXgG/e9bt4PyQnsvr2bkupX6OSMfaSaBZ9XjZYl6ZXMYuOVp1OmviZgeYf2TQVjtXRcL
	 K3qQcheYKkTwtMXAhEIXFQiRZh3CabKtuJYnpSFZmkQfPx7DWnVOJ0nsRFyuGOMtpnYdF
	 W67kYbDOqQiMaUXTiqdQGx64csw5alWxl2DZrQF6yFysO6japfAP2UigD6Q3K5jpRJ0IE
	 k8kI6mazWXok0yexbzSVSt+fJhitLrasmTQcsQKoSZKkyvVpSnwBKfeiqNBxwqYc9bw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792423669;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IH59y3KmI+lpuyYXpuz653f2mBj5OtucJtcBGkJOvhA=;
	b=KObmacTY61qPJrFRUoV9K4e5wvFuohPVliXAwsErFXtpcRCgcY9W5Wv32glXtAPlZ/yA
	 0MV+atU2hxcF/ViSXt2rvZTyISqLexY5yyzi6Ww6h+E4wSnDWgPG+ICk6nOvDhcNON1MB
	 kN4FHSeinAxiDcLmY+BKebIEmVg5r0JUJhbsoqRnUdkGbCrWPPoK1V15HWbqIr5Fiqavc
	 RCWoJQKbe/3oWX8u9iYOGbs+xpbbASbZPBTZaZNVUKY9D7WKcHbkeniGuUQ7qIl64xNdF
	 lDVgfpneQSRGeCyquFnQ+JbBhV+Mr7ollGUyvHoZyvUD4EO3KWfr/pVRcYp5WR488xQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=iO1+8ZCV;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=YmQok73M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792423669;
	bh=IH59y3KmI+lpuyYXpuz653f2mBj5OtucJtcBGkJOvhA=;
	h=Date:From:To:CC:Subject:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=TWQ3tsbXkuJFGsOFOPdfUAGXecEyRhBrnINnZzcW7oZLAeNzBEXRkDxGF+DzdNaBY
	 FbQgYJ0oe+e2mtICvhheCYrBiuD6FT5X8hdgJmLq3091A49EEZp6vRN8kfkwsKL21J
	 bE72maTBg7pFGpqL6GuoXWDDi71OBMnI2Qzs9D+rrA820OhoIpKF56aaznoZviTZXW
	 8fflF4YlgkJ3LxWlxbYlmc/BUvFeo1b/95QRw36xKEoBDCMiM6L1FPeLjSsUekP9AV
	 58LFJUT6g2KBeWRBVfyeUn4u8fdtKLs7ztrZCa79FZt6UsHPrZHR14FGLaBexRly/N
	 SX5F/xRVJmtow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1A55606F2;
	Mon, 19 Oct 2026 15:27:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E82C12F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 645CE6063F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQUtoaAkwkx9 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 15:20:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3B4A7605CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792423258;
 b=FOk1hAl5Byl0ALS5btQgz0X4cU7bcVuTSRzG0NdtKQYrGBpetgAkoQwdCFDQfNBb+y6v
 wiPJFttLAJuI6vGbAFmQUVFqnrq1eXk8B+ML+hrU+BxP8cSwi47kv4kN565KMI7U31qMY
 vZ4S4EIjBr8f2xGkqS4QpBxc3AnS+UEGa6WkaOLdkYyk8eJGOh5s4GugR8Z0e25SO9dXz
 UkAcju+bQcReCxHfIeHiiCJlhtL4clvN01VDlS9gfsc02d5LxxjAXSWVY/2hkHCFIFLXs
 B8LdolOEnSPXlNwRqljOzJLzSAlGkvflzncuh+hjYIU7rlYKSPFIjE0WkKaY/XMBuag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792423258;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=IH59y3KmI+lpuyYXpuz653f2mBj5OtucJtcBGkJOvhA=;
 b=PdffpRcfCD1p1oEPvEe+Fz0DjrDFupMM+XKf0sM2iKO+bolezGqLhP+NX9lCRp8J6RVd
 XHuD8fKv2yK/82XQUvBcKYkZvPSIwuOuK12Eu1mJDOZluMbUSECjZT2fy3ESmAZyRbsrY
 jbTojp76JwxuEM07AAktDt6Hh5+yUVstfWguMJo60whI5747oQyDWoDX7n5PBbDB37Tvm
 buWsbr0L4RHVZkIK5rDdKavxC2bqDUCwwB71VC6ksiw/9WYRBLqBvn2mzOkde79QYddUu
 u6q3FFBee7f1MFbRnMTcu0F6x1T3TurIgx96JehC8kOIPb2AACakFk2QOwvYr5SIL4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=iO1+8ZCV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=YmQok73M; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=iO1+8ZCV; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=YmQok73M
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B4A7605CB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 15:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423242; bh=IH59y3KmI+lpuyYXpuz653f
 2mBj5OtucJtcBGkJOvhA=; b=iO1+8ZCVL/wdw4wUewLSitEotP2UAOei5+OHu7aEt8VMJHGptT
 Yx1wqvOnzKn+asV3s64xr3/q48RkB/peo8k3XYLhrmEpaScEbFms1oi241QfcZ9Y2od2Vu4+O5A
 DGz+qp5ylS1Z1xy2nRJB7M7qZnTo/F68g/buyYu3UHtv5x2NSxeCqnO2G6a+tJ82+8WDGf19Pu8
 cIxOzjrmdivj7GPf3OSAA2dTvm++etb5ocH+Y+e2ho+DvL9Y5lbvlNn6X4rjHKldvciu5MaQ/5r
 wR45SO8jB4CQt+pd40YeE2Rcru2dugeOXpYOmZsh8ZypvzF1JxoxRavMQS1LQMFqqUw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1792423242; bh=IH59y3KmI+lpuyYXpuz653f
 2mBj5OtucJtcBGkJOvhA=; b=YmQok73M395QFvNosPEaNk029ni4CzlYF5PbB2nFs+8T1si/FA
 IQFhIXqnSowGv4ffTsVFQiUdJW+Cb+eJHxCA==;
Date: Mon, 19 Oct 2026 16:20:42 +0100
From: Bradley Morgan <brads@mainlining.org>
To: pepe.schlehofer@gmail.com
CC: Shengzhou.Liu@nxp.com, chleroy@kernel.org, christophe.leroy@csgroup.eu,
 dario.binacchi@amarulasolutions.com, holger.brunck@hitachienergy.com,
 hs@nabladev.com, kabel@kernel.org, marek.mojik@nic.cz, mario.six@gdsys.cc,
 michael@amarulasolutions.com, peng.fan@nxp.com, priyanka.jain@nxp.com,
 qiang.zhao@nxp.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_13/14=5D_configs=3A_turris=5F1x?=
 =?US-ASCII?Q?=5Fnor=3A_Enable_CMD=5FUBI=2C_drop_NVMe_and_SCSI?=
In-Reply-To: <20261018083516.49229-14-pepe.schlehofer@gmail.com>
Message-ID: <FC81E3D8-CE66-4061-BD63-CD49C929A45F@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 15:27:37 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18 October 2026 09:35:15 BST, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>Enable CMD_UBI so that the NOR build can boot a kernel from a UBI volume
>on the NAND. CMD_UBIFS, which defaults to y with it, stays off. A kernel
>inside a UBIFS volume would need it.
>
>Even with LTO, the ubi command does not fit into the 768 KiB NOR image
>next to NVMe and SCSI, so drop those from the NOR build. The SD card
>build keeps both boot targets.
>
>Tested on CZ.NIC Turris 1.1: with the MAX6370 watchdog stopped first,
>the NOR build read the OpenWrt kernel from its UBI volume on the NAND
>and booted OpenWrt.
>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Good!

Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
>Cc: Marek Mojík <marek.mojik@nic.cz>
>---
>(no changes since v1)
>
>The default environment does not call ubi. The boot above used:
>
>  setenv bootargs ubi.mtd=nand_ubi,2048 rootwait console=ttyS0,115200
>  wdt dev watchdog@2; wdt stop
>  ubi part rootfs 2048; ubi read $kernel_addr_r kernel
>  bootm $kernel_addr_r
>---
> configs/turris_1x_nor_defconfig | 8 ++------
> 1 file changed, 2 insertions(+), 6 deletions(-)
>
>diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
>index 35df37fbc70..c5aaf55a75c 100644
>--- a/configs/turris_1x_nor_defconfig
>+++ b/configs/turris_1x_nor_defconfig
>@@ -55,6 +55,8 @@ CONFIG_CMD_EXT4=y
> CONFIG_CMD_FAT=y
> CONFIG_CMD_FS_GENERIC=y
> CONFIG_CMD_FS_UUID=y
>+CONFIG_CMD_UBI=y
>+# CONFIG_CMD_UBIFS is not set
> CONFIG_OF_CONTROL=y
> CONFIG_OF_INITIAL_DTB_READONLY=y
> CONFIG_ENV_OVERWRITE=y
>@@ -63,9 +65,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> CONFIG_USE_ETHPRIME=y
> CONFIG_ETHPRIME="eth2"
> # CONFIG_DM_DEVICE_REMOVE is not set
>-CONFIG_AHCI=y
>-CONFIG_SCSI_AHCI=y
>-CONFIG_AHCI_PCI=y
> CONFIG_LBA48=y
> CONFIG_SYS_64BIT_LBA=y
> CONFIG_DDR_CLK_FREQ=66666666
>@@ -101,14 +100,11 @@ CONFIG_SYS_MAX_FLASH_SECT=128
> CONFIG_MTD_RAW_NAND=y
> CONFIG_NAND_FSL_ELBC=y
> CONFIG_NAND_FSL_ELBC_DT=y
>-CONFIG_MTD_UBI=y
> CONFIG_DM_MDIO=y
> CONFIG_MII=y
> CONFIG_TSEC_ENET=y
> CONFIG_PHY_FIXED=y
>-CONFIG_NVME_PCI=y
> CONFIG_PCIE_FSL=y
>-CONFIG_SCSI=y
> CONFIG_SPECIFY_CONSOLE_INDEX=y
> CONFIG_DM_SERIAL=y
> CONFIG_SYS_NS16550=y
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
