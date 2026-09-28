Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC82CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B316780FFA;
	Mon, 28 Sep 2026 13:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id swZ2oGg_tBXo; Mon, 28 Sep 2026 13:42:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9713C80D1B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602962;
	b=Quc6sHqcQqKI3bdJrRZTim3jx1aOIaxN5f/Bdbz7i6IRZRhUEIogfuLXskxQ8QB5upu0
	 LHvDujn+BGP6ltJrAtSyX2CebM39eIxXdK6RcuymQe/5qBuhukJeB6IzmMNiHeJAm/YyN
	 eaDoSO7UVMPzhAn2ZeHxO5yBLgEtNNd+T7dE3V902m+xEckz2SHmWIOdOTDdbFk68gNTO
	 aalYmvsjkwMF+EGWscIf7YHCOVmT0kkh+T3Cv0/re9PT1Ctn/INtlBXRK/AnmUvGFuOcK
	 rRTeHp3huAxx5kYmDif5BFvHtV7v9c2zkxzZVeCzLADxosQeW34qAU+5X207x8MAakw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=seTfk7Gm2uIGSdtugFWiHxvewnyTUJb7CwNFjg3qHDc=;
	b=fpw5Z8QIGLv7AQAuxg8gwnRqtL4WWoW6eQ/dfn6b/ZznAGX+IcnYh3K9zh1NyTdB/e4M
	 c1VJcnN1H1T//H8wPp4doYcIPp2eiGa+8dqBfwZMlR4E+P9DZTRvYOAjAAgkmWyJXLZfi
	 K35RpCzrsWltpNEKgg8/ojT29tJI91SwTJqs6gX11H96QlLo7Z1vvqbu+FJ9/2s8usbok
	 aMgJwekRdLkSloX75aEvPsNRQx/YJD49gB9+7VNKcEbcEy1/mNTgnbwxLVRFEMxHCuCnp
	 2W3ADHKVDSQA2vcj7xtBm5SDM/PeayatAfVy7kZZvMwnKsANI/wFjLbJox3ZKDXdb6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602962;
	bh=seTfk7Gm2uIGSdtugFWiHxvewnyTUJb7CwNFjg3qHDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VEPKShOWkzcOR3Z3Eb0hfWh0DvrdTtVo96q6nowf3KR32YYmNTWq9hiomuhfHNhUc
	 cAYtlX0uf7GkcILQWzOwfkwWDENRXPWnJah5vJt8JRTLz90MgcuhnQY7nu0pt4m2HI
	 KMqTx60cThQlQzUhRp4ytwBtf64VXb2nwdT/zQ4Rhlw3DV+dPnxiUh3GeBHGA7Mhjx
	 zKgeq/KkLPTuBSOpFYH7osNLdQFlO3x/1E0wRZjzlu7JYW3MfpxrEmTYf3poflPUUc
	 tKURYo0raJyeOBxDtmAhrEUjSjzhhIYYzsMY1bgvWwIdajuKn6s/vwpSQjKuZrudQb
	 H9CTBG94nzupw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9713C80D1B;
	Mon, 28 Sep 2026 13:42:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE17B361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF44160601
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NiH10sdEPpX for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C42E7605E4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593532;
 b=gvs/pRt2nENnO615OsC1aRNUKO91JHjdZNiNB7rGmQmOzcYfbAOAwzwBuKVbat0OUkqp
 ZkPs4V+nZxfmilhvjOfWz5aJTavGje+JFKBWbx1a2U0IDP54VNFcuk8RqQH+3sa4igbmO
 jFXhfA4a46V/q/E+e1Fmh/5rse4N27354avun79d3JL3Zkhj2BgIpRZJAsL/1KWurIxQA
 kLSFqhlA2AYCpbPf3fpMHnvEcEDwa6HTvPd/jVZlWedDtW6Qp4DEpbAeOFGX7bx2xMfFn
 XLpTjjDBLeCNBn/Bm839bPRVA1IbwU4CAHNHdQhh7EDZdLEzhk5I/R4OL3b5Uq8z/SA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593532;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=seTfk7Gm2uIGSdtugFWiHxvewnyTUJb7CwNFjg3qHDc=;
 b=dVCebPlDxajDlE55yquxeKDZm40sq8keV850EUOdvBp8xITGJXs84Fal2HrDHOmVb4lQ
 FlNHQltPs+PI542V3V+N7EsWgkVh1dqeP+enICi/Aj0GiKdRwaWX7O0adpHf7q+1Jqhcs
 USwX9cYAyOJ8Dhnr9AkcysEAa1GcvrQhOJug7yeVl1wkzntX3en0/iyff4HmW2MIGZZix
 iFXyouD6T5YQoU4pQliXkYAgt4vwG+ADSGREehrlV3aw0eQOHozEL/+MP54Nma7zZUxQW
 WaS9eRsbKo1N3GbnTIcQ1qZfA8TMpoS6XukJkchRb0qpLoxGgEDt5+vu45EoOdmCeyw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OKQuej14; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OKQuej14
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C42E7605E4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:31 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so1810909f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593529; x=1791198329;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=seTfk7Gm2uIGSdtugFWiHxvewnyTUJb7CwNFjg3qHDc=;
 b=OKQuej14Io/7tYZTd3KCJH26ZlT60MTOPbuW1P4EUBvAfn1GMBaAw3D6ocy0g/oFKr
 QjGXt9km8KLKhnjOz4amDc4Yns14POgHw04GLmDPhD/MtU2dA3KjV76FOrjmYD4npVyQ
 qSQLY49tkzbC9QGO1++h9hENJXD7yGWw57dEke7PLt1kAcgOE3qDtoxAj+Wr1CeYopQ5
 vJ5LNk/Xh9++pbNDzNg2JLnxdGyv5TctApKqvnMs4vqO4y0OXT5HnlZ8RDjxiSlox/8I
 Y1zOsbHiPAACR0UkDkzE8gcQ5/yYdDFOReD23JUROpQcnYFyYloe1eyccvMx7zrJw9nW
 DOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593529; x=1791198329;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=seTfk7Gm2uIGSdtugFWiHxvewnyTUJb7CwNFjg3qHDc=;
 b=i6cyReMrozOFtTNEeBBvD7KHHUjRgndnBekFyXkgxtUbrNXLlmxUgdwhvEIeDwqY/Z
 Td3ZFfqfplSFxN30ma5Z8PFQf7EnrXHBFaYfP9uKyKqoHB03TVX8dAEvNpO71BA9mNyK
 WnzLVYz5zADEsj4JzA1TFZlKqmO3c7/2wtkKd/VIQYSpDmlFMlVbW0KJwIzv7EyDgg3N
 Lb+xP95NjBE4K5M7cIj8wqxolgKE0RoT5HX8+cZqrzot2ZMpxxBuV4va7bl6gUsAQ69E
 umRGjPLtSitUHi+dclvonJKeeVoUQ2pFYK8O8f92rN66V8Ge+WRlrLSvE8WUS9q9+xPF
 YFcQ==
X-Gm-Message-State: AFuF++l++ylQ6XSJ6IsaaXeN7k6nuR9PiqS1hkj15bFFIALvnN4HwSbZ
 2blOYqtvwDRVESOS52Pk9rv//nmgA117p++LrccQ4TMiZZvL8jMKYBLhqgrdyh1V8ms=
X-Gm-Gg: AYBFou0tZS4z2SIiDKaXXNa9KExZTfHrm7xO1eXeS9Cm/0+2JYJDJyDDUq5WijyzD6u
 V6XCgNRKuiQs0+XFlgO2I7TmZ7BXSBCRvThauSxEpIqznYNGP6OsK3gSaKgYGiDOazRNK1wgzrj
 pFUlkXuaiKowbkEvBF7SPkwZwoB9jylsaq63RybCMLGo5q1IsWuvQA6I6wUMxktfm+E5EtOw61X
 tE1D7zw69S+9mxZ+tvcKuccPZYpR7w/roVEOFJ7toGLgrH5wxi1Pv+mbVcMb94tyINiF+l/RwZI
 3s1xFNFNBncBwGBvNwmRK7Rpx7wyn37sT4qUS/VTx6EZvJ0BAG15HU7k7ZQJAw5T7AwB0fddwXA
 J6Fsy0uAqX+sFywFrBPFxLZnBrJDMXSfWjjzUrMqcl1hnJL6rDTDdHxScKLijZzc6aLk3EaUxfT
 RD9Cput5zTz3dT4lao3O+XZuwj4x3FpIt1vMlT2KQjA8dnZkXPdtovgHP2PTMNSNbiVM3iBOKvW
 CVh5cmKlczOmPZENqYHNkNWmCja8Omtt7i4uECpuxvpX9d847hK3UL6xRMJlL1krKNOt2Rky1cS
 uG9p0mU4lXD9jvJoteFKJL2ffn3d3qd7xM+xTGhVc1azs6DLjQ0=
X-Received: by 2002:a05:600c:4ec6:b0:4a0:2b0:1cb2 with SMTP id
 5b1f17b1804b1-4a002b01e4amr55680345e9.20.1790593529158; 
 Mon, 28 Sep 2026 04:05:29 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:28 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 12/13] configs: turris_1x_nor: Enable CMD_UBI,
 drop NVMe and SCSI
Date: Mon, 28 Sep 2026 13:04:33 +0200
Message-ID: <20260928110434.70686-13-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable CMD_UBI so that the NOR build can boot a kernel from a UBI volume
on the NAND. CMD_UBIFS, which defaults to y with it, stays off; a kernel
inside a UBIFS volume would need it.

Even with LTO, the ubi command does not fit into the 768 KiB NOR image
next to NVMe and SCSI, so drop those from the NOR build. The SD card
build keeps both boot targets.

Tested on CZ.NIC Turris 1.1: with the MAX6370 watchdog stopped first,
the NOR build read the OpenWrt kernel from its UBI volume on the NAND
and booted OpenWrt.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
The default environment does not call ubi. The boot above used:

  setenv bootargs ubi.mtd=nand_ubi,2048 rootwait console=ttyS0,115200
  wdt dev watchdog@2; wdt stop
  ubi part rootfs 2048; ubi read $kernel_addr_r kernel
  bootm $kernel_addr_r
---
 configs/turris_1x_nor_defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 35df37fbc70..c5aaf55a75c 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -55,6 +55,8 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_UBI=y
+# CONFIG_CMD_UBIFS is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_INITIAL_DTB_READONLY=y
 CONFIG_ENV_OVERWRITE=y
@@ -63,9 +65,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 # CONFIG_DM_DEVICE_REMOVE is not set
-CONFIG_AHCI=y
-CONFIG_SCSI_AHCI=y
-CONFIG_AHCI_PCI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DDR_CLK_FREQ=66666666
@@ -101,14 +100,11 @@ CONFIG_SYS_MAX_FLASH_SECT=128
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_FSL_ELBC=y
 CONFIG_NAND_FSL_ELBC_DT=y
-CONFIG_MTD_UBI=y
 CONFIG_DM_MDIO=y
 CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_PHY_FIXED=y
-CONFIG_NVME_PCI=y
 CONFIG_PCIE_FSL=y
-CONFIG_SCSI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.54.0 (Apple Git-157)

