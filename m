Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73B606A31E
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WAtmYKqG;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=dKHatpRM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A26E8608AB;
	Thu, 22 Oct 2026 11:09:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApZHRsorVNVM; Thu, 22 Oct 2026 11:09:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B3F260888
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792667387;
	b=MSiW8jYQogujWa+NoZiYYvI3may+K58k0f3wZr6kqSDEsPTe8mZ70WvIVrdHGQpz+tT6
	 ZqpW9YicJg0YkY7njnn4xMqjYREPw9iZvNr19TYvdxt5x+3uIivG6yjrELfOB2t1BiQ1Q
	 yb2Wqq0zM/N2B5zuz0a8KEoyC9ReqerO/R4wXvbM85BK8jJcc4vqwNUyLTujw9/YoEAoz
	 kjd48icRwdSnDcMnvlVVDgwzJh0hm+fqkLIyLiyJHzFc01wm8eIpKjatyGXHI60al5Pgy
	 6swFSV62u4bkCoZVmCnNXXsht64yVIFVVNDNY8vNRR5E677jARRcP2iklUex0WMACUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792667387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=coUFkbqVMhHW9AMG5v6scYFsV2iis9tEn5/Zn1lBwJk=;
	b=VLi/Z/XldsKdcEFzllqOpvLorMaX8NYOIiFFYt0xamHOCRrMmfiX+4zJsgNPeQ3JF/vt
	 xCJxRWJT8FpdNQWDTm63rc8nF09WLnVwayOjpWQfKo+cRPpc/yA+li9D1/r+CSjS6c9SV
	 vx4aE99YW9rVtnXE5kLc+HhskTf+Xul9j/Ga17YG0jemwHZioXN/xOdLam3bL/Vdi7LAy
	 pPK/fdhYOnmmDveH6VVyJlDquUlQxFt0jVXu3hU4SLbebWfm+41EwbvlPoe1i/zdVcB+I
	 oSKJF1e8+DIlF1qt7Uf94MQpZzcTcDO+7wBM9LUKWL/yrWRmJjzUghcuB5s2Z6svg+w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792667387;
	bh=coUFkbqVMhHW9AMG5v6scYFsV2iis9tEn5/Zn1lBwJk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WAtmYKqGjj3czF16W3O3eGJ5G646PnNVIqz9TtJmAqv01bYxJH1xr6ndkLAqis3gB
	 PIVeOVhuK5lGc1LUx7IpHqpVfMd5HT4x/jQFLdBpfnEPz8SPmWd/RuIZqonD4r/Zjk
	 J60AYwJi/yXh4TvHzmrTMhCs3mA2KCxXQQiHLvWZ9AXrTxhpGpM+2RArt1VHNC9h8Z
	 ZOsquX0a/EmuWcQdAYdSXevKZSVvcYVZ1OV+fsnjq82zfVtHbsLVNPa0Z+ip74eglj
	 umvFxOlzYj+bf/LoQIRB+m1+yV2ugP+fwI4vryqPTACA6MlT5hrh5ltp0dn+pywnTn
	 29bZ/A9jr8VjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B3F260888;
	Thu, 22 Oct 2026 11:09:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E388371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1426F4098A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-q3mnqSOchc for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 11:09:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BB1B407C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792667384;
 b=bH4bVCy/OVLdMiP1hhTfOnUKnveU33TaJf91Ild7fyLt/OF6+3iiHtlV45c3CSLziZ6u
 5ssFbTQrJ35QYhm6c79JiOHY2aL/LhcJZyfcljHQ36R3iGj0aacRopFXoDM4JUbjRJowW
 Y+/zcFgWI0gOpE8AO8TKDyOIm2IwvRCrfLQhRvt+1N2qY3THWlKFZnpQNT9+2JDUr4hjQ
 ofy6Jn6rN8Cc4+9JajmYnBsXR3+IrG9gvQIFGTq96JxqQ/Rrj3Cmbpln7HyrCHCP289zj
 IJ9hklotPCBg8AYEYoTcpF61b30WH56Frvkw+OrBNvjQOhsVUoYvUhvtWZ+nXIAyAog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792667384;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=coUFkbqVMhHW9AMG5v6scYFsV2iis9tEn5/Zn1lBwJk=;
 b=dBFKkZndOkc4NALnnSvBE7q2NHfDB6qKlr6l0uccoDFW1BfmpoRPNhCTXjB+BbSisAOl
 Yk3jyTEee6L5OSgdIDICjdFNj//OdX8dWWvcV/AF90un2BrUjrYdMc/EEOnQaWS2qTaAC
 UG28vEInlQ7KXL/xJgitmQWApT5WqK7O6/y2oOH7PWWJwDITS8YqC9+oHEq+LXIQpoEds
 DTROpgSyh1GPa0bwzodjHh6rV1bB/GkvNy0ha9IU2Wd4nPQO0GKt0NdUm1KTTlqr6yoKV
 skVWrUubWvhunBu+9FRR2C5PL5VlHrk7a3ttjGBP1tYt91aYn1ZTNFS3ETlHHQ2uaFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dKHatpRM; 
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=dKHatpRM
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BB1B407C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1792667375;
 bh=coUFkbqVMhHW9AMG5v6scYFsV2iis9tEn5/Zn1lBwJk=;
 h=From:To:Cc:Subject:Date:From;
 b=dKHatpRMUtKVe1VBUMAVTbt+hHm2vf1+wg+QfJKjXqkWMsCrVwutYYu25KtsEhIEk
 Hop4MDT+nNr9C99t6RAtg+HdQmr1TwvmAUVpZZf36BkLJunyiV3d2QMDA24FBJHKzt
 zTmIWpFSG+uxhEHuVgpRD3t9WIJRfzeYFDZwqKRCcVjXeeo6NnLW0w8DvvWuaRaCeu
 J6fBqPj7ELlHIVnKmIrhR3yWqGOggVItWd0OR8VfIvpn9C9uYxW4C6hDXa51/aCGDw
 9e4INeajfkbibS0uSeam4XdS5hLUIfIaPwfcWlBeKBPxf+CwQnsvwBr8JRNmXHE8PL
 h7cCGbvNJ9WEA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id A3872B220F5E;
 Thu, 22 Oct 2026 13:09:33 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: u-boot@lists.u-boot-project.org, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: Leo Liang <leo.liang@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 E Shattow <e@freeshell.de>
Subject: [PATCH v2] configs: starfive: enable mtdparts on visionfive2
Date: Thu, 22 Oct 2026 04:09:06 -0700
Message-ID: <20261022110913.1415753-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
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

add default mtdparts and mtdids consistent with Linux v7.3 Cadence QSPI
driver .get_name() handler cqspi_get_name() and jh7110-common.dtsi

Signed-off-by: E Shattow <e@freeshell.de>

---

This allows us to update the documentation to be slightly less likely
that the user would type the wrong offset by using mtd part names:

-    loady && sf update $loadaddr 0 $filesize
-        StarFive # loady && sf update $loadaddr 0 $filesize
+    loady && sf update $loadaddr spl
+        StarFive # loady && sf update $loadaddr spl

However that documentation update is planned for after the mtdparts
addition lands in release. It would be preferable to derive mtdparts
layout at runtime from device tree; if there is some way to do that
sensibly please offer some advice how to do so in the review. Thanks!

Refer to discussion of mtd-id for SpacemiT K3 [1] and Linux v7.3 Cadence QSPI
driver [2].

1: https://lore.kernel.org/u-boot/20261022103907.1415045-3-e@freeshell.de/

2: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-cadence-quadspi.c?h=v7.3#n1724

static const char *cqspi_get_name(struct spi_mem *mem)
{
        struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
        struct device *dev = &cqspi->pdev->dev;

        return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev),
                              spi_get_chipselect(mem->spi, 0));
}

In the typical situation for JH-7110 SoC then dev_name(dev) is "13010000.spi"
and spi_get_chipselect(mem->spi, 0) returns a value of zero.

Changes in v2:
- use Linux v7.3 cqspi_get_name() typical result for mtdparts layout
  name; this is done for compatibility in the non-default configuration
  of matching cmdline mtdparts mtd-id when Linux MTD_OF_PARTS is disabled
---
 configs/starfive_visionfive2_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 45de1c1cb671..e2a1f10dbc0a 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -78,6 +78,9 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_WGET=y
 CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=13010000.spi.0"
+CONFIG_MTDPARTS_DEFAULT="13010000.spi.0:960k(spl),64k(uboot-env),-(uboot)"
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
 CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
@@ -107,6 +110,7 @@ CONFIG_SPI_FLASH_EON=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
 CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_DWC_ETH_QOS=y

base-commit: 903c9578eeb36d72f087082da494c605ddaed3b2
-- 
2.53.0

