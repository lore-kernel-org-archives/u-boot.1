Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF908606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qspfd6XX;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=UYUMb1/w
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9EB6A81329;
	Thu, 22 Oct 2026 10:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8MuKmXaHyk2i; Thu, 22 Oct 2026 10:39:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74619812EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665599;
	b=Lzd6zgP/eLNTaxClqSO0fIscWcJHMJGnWvwMRF4bUyulgNLD7QnK6BRtUc6JnY5bPdSp
	 Lx9LOJrD18q5p8xxYxOHjBlDPZepD3vRFAhzTnPPc1a0GegVEk1jA3MDf1srru+pzT7bi
	 HxMfP6t7zf8MXTZh7IQVxvDQiIaYpePNr+GG8sONQgnvkHX1C6Bfd+1imwM0+U1NheYll
	 o8XKGMTeOymKPZ5wcw/xJjncVgC3MHxEWnjbOl9NQJexNF3V6Fefwud2Hv0+ZVkpAFPQZ
	 afPkYgijDBod3SJrIURBMc1Pnfcw6rcwwgvp3hXEJ+ABEVCcVDq72DFZ5KrHcJZii2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VU+U7pka3eFxFHKDhjxSaJB9089GXo+TJaWcPVHJd+0=;
	b=s3YdJ9rKpCesufNLsIbNKy+SgctERqarU2jRsFLhjyIWYhRWDDXE1FlFddnhU129zXw5
	 tSsiEFl7A+QsBNVC1Zrjk4r68qH1AfMthMtwL+m5ny3ApsyZ0TM3NDrRPItNKcC0Qgr1l
	 hwj75vCqtX2ShoR7RJEHOk8oeWCG/QyTQy+kvcVujtTxv+H22avsrBKpiPnuG5D6/Td8P
	 YfhjCqxt4+Qqw66Q6xQkfWAbSPOyJz4onkXr0tciAv1nInZObZZVgZrIqgrq35iyul4L5
	 NzNXa6aTQoeQ4z0h8eJxC7MJeNr0ooyT2m0cpYKbjUlgo5r9kPA62dX3HCKc8LaijTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792665599;
	bh=VU+U7pka3eFxFHKDhjxSaJB9089GXo+TJaWcPVHJd+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qspfd6XXsI27eh30KVsn/40jOf0NT3hAWnA/6DwqCLQn+F+KjS5v1hLquQokEecaZ
	 E6YawU2c6ozOaHwUZj6jb2b7bRohV3V9a5fP+hBaYPm/v/uKodmeVMb+rE5vm2DHpY
	 +KYdqz46GVryIzyjN2PK2Dju4Olz3nngdfNsTgve90FlH7NiRNMmYa+6weRjV5nS/Y
	 SNLj+2FE7aNtMZyV1z90a6xkAtehC8ZBgI63AQvKgInbQ0KpPCkGaWVRoUeSoCgSt+
	 0hK8T71xzIuI5CmAumj4eBcycu1RsQUfq8j+O0gRbm+ix73KrZ3jePrMiWTWXGNDbp
	 lLI4mJFlHu2Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74619812EF;
	Thu, 22 Oct 2026 10:39:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E0E8380
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2429860818
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id snaV2eM__BpW for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 10:39:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC5E56068B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665597;
 b=nhXGDptummGVETMmTInsJQwzFGsclW6ef6hOyZungKSKnTxQvyEwDCucCwua056tM+hN
 t5E7I5cqBm9zFlG4JyU2sO5a61dgOEoflCKZIsPLxc0djVZBfIUD6fuxTuFOPVhtO47rr
 QObDdejWGHWYT4NHKyG3BH/odpAe4BUoeMyu4FoTgXXFxsdd4Y90vTK9I4eYl/zmC2uO8
 cZU/ODQYhEWtd60R3ynFXD4JU4o7TXiwou3ffOxSDJlVI3J6PlBomkHNhKbmHNnxpMEXy
 a997E2iIziWgAcqrR58Q/MhxA0FY1fQWoD1vsn0xyS4IxG690Wz4sVs8f16h9N4pXuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665597;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VU+U7pka3eFxFHKDhjxSaJB9089GXo+TJaWcPVHJd+0=;
 b=K7+A85cCY6mZ32sgZnsiKm5bNCdSnrYtXlmWvMcDeDENHDQXjgxoKSUdsJLdhTErgWqf
 9efYtmFbX4U+ewRkWOVN09xeU7z2oqZ28SIw9Z8JVXwz5Fw3QpKASHPPki/I0T3XhloQK
 ql+ayxvD2t763WBITs/LHu4pNGFkCWsFTPU6gVm0fOqwbDEpPpl43K6i2WjHfsaVIPU/P
 a8e5xtWble9d1w1niR9k+igb1SEKiI5F6B8WOig1+amGiu20wqdSUrE5gd/LnuIpCma8A
 iQul3rihghuzpF0iOEMB7fanvRvAePdFn9Hxjmunmnou7Q4yPcGwG8+lXAlkITCcxnA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b="UYUMb1/w"; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de
 header.a=rsa-sha256 header.s=s2025 header.b=UYUMb1/w
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC5E56068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792665580;
 bh=VU+U7pka3eFxFHKDhjxSaJB9089GXo+TJaWcPVHJd+0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UYUMb1/wMOvMxfUwDvjFbec8BJHtPMLpw4tcUvD+QIOkmRZy5uFF910tltMGmtxpL
 o49/JWRCAHOh9K/SY32jIgTGa0BXcCck7eVJk6AV1vr690EW0lAEhGiyaROU0O5DI0
 uwnkg85fJa+pTqy0NBzMlyTC53Ey62vS0i9wLW9svgE8TUPEWB7BwVWefJ7yv1OZoJ
 l6f0ciL6/G+FjbVyV3KgnEzG/8EFP+tzQE3KSASenpQz8rntOOHqoiqacmYXHwSWmK
 0hlbujk7DZzhJw2bh5Wm38WSbeQxO+73ZIDW4RXcz8+HdXRAPm4u4QA/TcQ2f3gWa+
 Zb186ODn18KUQ==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 70923B220241;
 Thu, 22 Oct 2026 12:39:39 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>
Subject: [PATCH v3 2/2] configs: spacemit: k3: enable mtdparts in main app
Date: Thu, 22 Oct 2026 03:38:53 -0700
Message-ID: <20261022103907.1415045-3-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022103907.1415045-1-e@freeshell.de>
References: <20261022103907.1415045-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

add default mtdids and mtdparts consistent with Linux v7.3 FSL QSPI "new"
driver .get_name() handler fsl_qspi_get_name() and k3-pico-itx.dts

Signed-off-by: E Shattow <e@freeshell.de>
---

Write-up about testing methodology and the decision of what how
MTDIDS_DEFAULT is written for compatibility, follows.

With Debian 13 Trixie Linux as a baseline distro and build Linux v7.3:
tar Jxf /usr/src/linux-source-7.3.tar.xz && cd linux-source-7.3
xzcat /usr/src/linux-config-7.2/config.riscv64_none_riscv64.xz > .config
scripts/config --enable DEBUG_INFO_NONE --undefine CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT                  
scripts/config --set-val CMDLINE_PARTITION y --set-val MTD y --set-val MTD_BLOCK y --set-val MTD_CMDLINE_PARTS y --set-val MTD_OF_PARTS n
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- olddefconfig
make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- KDEB_CHANGELOG_DIST=unreleased -j$(nproc) bindeb-pkg LOCALVERSION=-mtdparts

# K3 append linux cmdline: mtdparts=
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
Removing MTD device #0 (nor0) with use count 1
[    9.946726] mtd: no mtd-id
$ cat /sys/class/mtd/mtd0/name /proc/mtd
d420c000.spi
dev:    size   erasesize  name
mtd0: 00800000 00001000 "d420c000.spi"

# K3 append linux cmdline: mtdparts=spi0.0:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
Removing MTD device #0 (nor0) with use count 1
$ cat /sys/class/mtd/mtd0/name /proc/mtd
d420c000.spi
dev:    size   erasesize  name
mtd0: 00800000 00001000 "d420c000.spi"

# K3 append linux cmdline: mtdparts=d420c000.spi:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
Removing MTD device #0 (nor0) with use count 1
$ cat /sys/class/mtd/mtd0/name /proc/mtd
bootinfo
dev:    size   erasesize  name
mtd0: 00020000 00001000 "bootinfo"
mtd1: 00080000 00001000 "fsbl"
mtd2: 00010000 00001000 "env"
mtd3: 00100000 00001000 "esos"
mtd4: 00060000 00001000 "opensbi"
mtd5: 005f0000 00001000 "uboot"

# JH-7110 append linux cmdline: mtdparts=
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
[   16.626705] mtd: no mtd-id
$ cat /sys/class/mtd/mtd0/name /proc/mtd
13010000.spi.0
dev:    size   erasesize  name
mtd0: 01000000 00001000 "13010000.spi.0"

# JH-7110 append linux cmdline: mtdparts=spi0.0:960k(spl),64k(uboot-env),-(uboot)
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
$ cat /sys/class/mtd/mtd0/name /proc/mtd
13010000.spi.0
dev:    size   erasesize  name
mtd0: 01000000 00001000 "13010000.spi.0"

# JH-7110 append linux cmdline: mtdparts=13010000.spi:960k(spl),64k(uboot-env),-(uboot)
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
$ cat /sys/class/mtd/mtd0/name /proc/mtd
13010000.spi.0
dev:    size   erasesize  name
mtd0: 01000000 00001000 "13010000.spi.0"

# JH-7110 append linux cmdline: mtdparts=13010000.spi.0:960k(spl),64k(uboot-env),-(uboot)
Loading Linux 7.3.0-rc7-mtdparts ...
Loading initial ramdisk ...
$ cat /sys/class/mtd/mtd0/name /proc/mtd
spl
dev:    size   erasesize  name
mtd0: 000f0000 00001000 "spl"
mtd1: 00010000 00001000 "uboot-env"
mtd2: 00f00000 00001000 "uboot"

# K3
$ ls -d /sys/bus/platform/drivers/*/*/spi_master
/sys/bus/platform/drivers/fsl-quadspi/d420c000.spi/spi_master

# JH-7110
$ ls -d /sys/bus/platform/drivers/*/*/spi_master
/sys/bus/platform/drivers/cadence-qspi/13010000.spi/spi_master

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-fsl-qspi.c?h=v7.3#n840

static const char *fsl_qspi_get_name(struct spi_mem *mem)
{
        struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->controller);
        struct device *dev = &mem->spi->dev;
        const char *name;

        /*
         * In order to keep mtdparts compatible with the old MTD driver at
         * mtd/spi-nor/fsl-quadspi.c, we set a custom name derived from the
         * platform_device of the controller.
         */
        if (of_get_available_child_count(q->dev->of_node) == 1)
                return dev_name(q->dev);

        name = devm_kasprintf(dev, GFP_KERNEL,
                              "%s-%d", dev_name(q->dev),
                              spi_get_chipselect(mem->spi, 0));

        if (!name) {
                dev_err(dev, "failed to get memory for custom flash name\n");
                return ERR_PTR(-ENOMEM);
        }

        return name;
}

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-cadence-quadspi.c?h=v7.3#n1724

static const char *cqspi_get_name(struct spi_mem *mem)
{
        struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
        struct device *dev = &cqspi->pdev->dev;

        return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
                              spi_get_chipselect(mem->spi, 0));
}

In summary of the above, for compatibility with certain non-default use
of 'mtdparts=' on kernel commandline we look to what each Linux driver
returns for its assigned .dev_name() handler, as the mtd-id name.

-E

---
 configs/spacemit_k3_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/spacemit_k3_defconfig b/configs/spacemit_k3_defconfig
index afe3a3b42939..f9408663619f 100644
--- a/configs/spacemit_k3_defconfig
+++ b/configs/spacemit_k3_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
@@ -36,6 +37,9 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=d420c000.spi"
+CONFIG_MTDPARTS_DEFAULT="d420c000.spi:128k(bootinfo),512k(fsbl),64k(env),1024k(esos),384k(opensbi),-(uboot)"
 CONFIG_DEVICE_TREE_INCLUDES="spacemit-k3-u-boot.dtsi"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
@@ -50,6 +54,7 @@ CONFIG_SYS_I2C_SPACEMIT_K1=y
 CONFIG_MISC=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHY_GIGE=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_SPACEMIT=y
-- 
2.53.0

