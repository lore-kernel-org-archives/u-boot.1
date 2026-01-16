Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84094D47CDA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B25C83952;
	Fri, 16 Jan 2026 11:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cGqErGWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A5283942; Fri, 16 Jan 2026 11:56:21 +0100 (CET)
Received: from mx-relay12-hz1.antispameurope.com
 (mx-relay12-hz1.antispameurope.com [94.100.132.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A406D82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate12-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=lgIsyvQcJYcwUSgcecohisKqtgNXJLmWFkJHjuDAXjs=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560978;
 b=sTnifpjM6+wtCauVNMNG4Ar92P94+NdBVxR5pnFdqf5MhhAkjcVtkeFGjFGw/gpC0hsstirA
 zgj+4aKC+zqVkHBs5/gkvrAlPOSm5PpvSAMj/8gbsxaA+0EpIq0EGefRiHOCVNSgMpDhvSuIop3
 7qeA1phyHK2igG9r6XqGdWjhgkyPYEYTNEIU2OUSH1L5MDkFhyDSqiCvFxE4I1Oz3UzmhnCQx/V
 vz4Y4HnVC/T1FwlYBqMWCk5CTNvwBPmWGAJg3hGITn8FH07oM6qJIAK7VK7NXARafbvTENJJtG1
 +aHmo2haAeBekhlQ+slzvOGansRAeb/VmJ00tFZi+t5PQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560978;
 b=nTPTPi0pcDb3gosUk/bzCwzM8mHnxfncvb72RgfiFaKmgYwnqYtnfuaJ/XnLr+0sjNFhATmO
 wfbe+u16XNs/fLjbF3AaRhkDTDbbQo8N5TwBXdbznDT5mTbsMtXKQKM8AH8kTKsZoj/AbkdqNgD
 +4g8KZE/KBOq2tTZ9DPnFWGZM4tB8DyU7JPGlU64i1mr3cM6AOi8J/GFX35nterH47LmVm4wb4F
 3etRNw+JULKzd+MZgGjVVqHKgsqYOKB0r2b/YkSCLvfjyjwjI4v1gWZh4Np09TOaPlC3D7LpAPt
 u13tfiNG/xtKHY8j5PCt9dzH5QfGxLdR48xLjcHiLw4ww==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay12-hz1.antispameurope.com; Fri, 16 Jan 2026 11:56:18 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 1C7AE220D98; Fri, 16 Jan 2026 11:56:04 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 0/5] board: TQMa6: improvements for config settings
Date: Fri, 16 Jan 2026 11:53:34 +0100
Message-ID: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay12-hz1.antispameurope.com with 4dsxbm3tPKzF25f
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: dc0bda6bb323f039896083e99d145c65
X-cloud-security: scantime:2.008
DKIM-Signature: a=rsa-sha256;
 bh=lgIsyvQcJYcwUSgcecohisKqtgNXJLmWFkJHjuDAXjs=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560978; v=1;
 b=cGqErGWXlzLviCUrgQpzWLSvgmRf6U2AJW2AA+36X1QxbxnyIWv1XTuNY1jMyAC+TdbbVM4n
 sPZG593SPzGeRolAj+csb2KqD4o35AWglW4/fseHPaR/lg8JdYRxezsrH9BNO9MxmGBc/0OoHMT
 hDRk/o1mABSdmXv7QMwm6aqWPjMavITMq7f0jpwUpRfp9ajkZtxlU42ZkDSb5ZuSZDnMN8BWb3c
 QakJohoFSUAgTOGsMKkL4ZnfHv3pQVN1vgwSYM88DOOosFV0xnDFVQEip5EcjWDjzXq5qpEpi6a
 n8w47+E82rwznhfA6b4QpPw1DcNK03t2LW7TH8KOVPXOA==
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

This series includes adjustments to the TQMa6 configurations.
The RAM timings are also updated.

Markus Niebel (1):
  board: tqma6: update RAM timing to verified settings Rev.0300D

Max Merchel (3):
  board: tqma6: Kconfig: select default SoM variant based on SoC
  configs: tqma6: mba6: add and use defconfigs with general
    configurations
  configs: tqma6: activate CONFIG_CMD_NFS

Paul Gerber (1):
  board: tqma6: improve config settings for TQMa6x/MBa6x

 board/tq/tqma6/Kconfig              |  8 ++-
 board/tq/tqma6/tqma6dl.cfg          |  8 +--
 board/tq/tqma6/tqma6q.cfg           | 37 +++++++-------
 board/tq/tqma6/tqma6s.cfg           | 25 ++++-----
 configs/tqma6_mba6_common.defconfig | 79 +++++++++++++++++++++++++++++
 configs/tqma6_mba6_mmc.defconfig    |  3 ++
 configs/tqma6_mba6_spi.defconfig    |  6 +++
 configs/tqma6dl_mba6_mmc_defconfig  | 74 ++-------------------------
 configs/tqma6dl_mba6_spi_defconfig  | 77 ++--------------------------
 configs/tqma6q_mba6_mmc_defconfig   | 73 ++------------------------
 configs/tqma6q_mba6_spi_defconfig   | 77 ++--------------------------
 configs/tqma6s_mba6_mmc_defconfig   | 73 ++------------------------
 configs/tqma6s_mba6_spi_defconfig   | 77 ++--------------------------
 13 files changed, 149 insertions(+), 468 deletions(-)
 create mode 100644 configs/tqma6_mba6_common.defconfig
 create mode 100644 configs/tqma6_mba6_mmc.defconfig
 create mode 100644 configs/tqma6_mba6_spi.defconfig

-- 
2.43.0

