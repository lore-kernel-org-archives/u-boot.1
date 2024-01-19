Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD85C47422
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE00F87B7D;
	Fri, 19 Jan 2024 01:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705624675;
	bh=Pf0x/WKYknaRALZFkWJxnthapYWJQ2zZef92fYF4ETE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mQpGlO0diy1/wF0mHb2vcB0916VOn5Qf5y9PNhVq1nsha7GMrdbkCgcJ0T/7mPBbv
	 p0sk/UhE06fCwEAWR/ydECAlkEgyIox6vseq+Y9qrr8ZuUV0d5dVr/mGinOp6tWliE
	 XvWLSJha+8WZLDhge+zThy2Nwae33szn6tdQ7nMjThhsLib5inqMHXdkk2O01B4hq/
	 Rw0Ouf98x8SCuHJ6clMnBuwql3dhRxaYA+X9IuAnSn5DNF3Pcsz24ZIrwfbaxpNkfn
	 gCn3wjOrY7AK6fJH/aniZXO0zGlKOapHXJl+FbFEKJQtggYENaVThqewaUjIfri37Y
	 95DAtjn7Ik9tA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E79058753C;
 Fri, 19 Jan 2024 01:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705624675;
 bh=Pf0x/WKYknaRALZFkWJxnthapYWJQ2zZef92fYF4ETE=;
 h=From:To:Cc:Subject:Date:From;
 b=qc+RW0wjkBwiaSzCyl+nqGNmrmyNftvs7PBtJ4hxhW0xnxQ1vjsqEc66srmYGUwlC
 xMwg8PQiJtHVToUpoVtVMWRZQeMZ0NLcqbkvu0OLbIRoqXMgcboOfxUDfqZ+aG+UOs
 spvQJS87mb+jRF34/ZmVmleTuLqSE1zGvxiGOq4+8yP2sPGJhFuoB9r0OZrrF9/Q0h
 gC7HmHRCacIx41eu85K0+N/fmNo27rK903gk/MD3dbt+bxVeePUyqczvBstA/UNfbC
 pr5fpHbacJ0nTAkQ/GcoIdqzj+VnVAqd5Djk+5YD+f6LqoPJSg1AT0/3Dy/G7IHRi4
 0jKbyk2ZBc/VA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable SPL_BOARD_INIT on DH i.MX8M Plus DHCOM
Date: Fri, 19 Jan 2024 01:37:27 +0100
Message-ID: <20240119003742.251587-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
during the SPL start up. On this particular system, spl_board_init()
is used to reconfigure GIC clock parent to PLL2 500M, which is the
configuration expected by the Linux kernel. Enable SPL_BOARD_INIT .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 configs/imx8mp_dhcom_pdk2_defconfig | 1 +
 configs/imx8mp_dhcom_pdk3_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index dc482abad85..4f907ce00d0 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -54,6 +54,7 @@ CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index 3442af6f00e..9972e2d96b6 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -55,6 +55,7 @@ CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

