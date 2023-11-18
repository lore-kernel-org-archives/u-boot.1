Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719FAC54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 18:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C48870E2;
	Sat, 18 Nov 2023 19:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.b="abb9VuWW";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKRuvd72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF756870E2; Sat, 18 Nov 2023 19:44:42 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E6B863FD
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 19:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaredbaur@fastmail.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id BBAEF5C01BD;
 Sat, 18 Nov 2023 13:44:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sat, 18 Nov 2023 13:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1700333074; x=
 1700419474; bh=+c2ovXrR4rG9QCuiIE+V7qTy/vBmSzRvxRnAAib6Ll0=; b=a
 bb9VuWWiKZk3TJGALIVMCVEUrghCeyyO0VMmquTjMg5I6Oz4IlX2n/0ZotSkQras
 FKpjLNdYFohSNtu6pKcvEhAGtwV/3v4EANLVAiRXpqawaMcgGXGvqdMaQpI9Bj6R
 BIeW79qPs6GxgMqO0lt5R4k7C1QnuTwLtXA75/J35SsDiXNnVZGHPokb6ih4+gKj
 3BNtjfkxAFNQuHAIUgcJc3cnq1O1J4W2ih/WD4tPJ+S4oOIsXr5KjfOghSBpxIok
 T4/viY7LphbifrQT2pwIy9bkFYAAJB9P9JSp/P5w8uF3zodPqtizK2zsftianE0O
 EfenrPY39SD2GCr4pSr7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700333074; x=
 1700419474; bh=+c2ovXrR4rG9QCuiIE+V7qTy/vBmSzRvxRnAAib6Ll0=; b=N
 KRuvd72ttOnoa36zd7N+6/MLbUhoqkNYqt5dEjcDtpbK0C4Pw53c6HvcBZ/5gukD
 1Yv3beVeXCZDM9a1CEn57rpuH/t9Xk3epwvmI/oiBcoki1GsMf2J4jsQMZ71Cneq
 fS+9Z+T6RnuwQqnSn5v0wc7i7m76QduAmrIejRpgV3OOQJZ/X/e36CxU4i1hJO8T
 qWgAyhgYkN3DADDn3xuGh1J4lJmuaZhoXI3LCXbKg+nxg2eZiSO2VqJCyJG6ZAsx
 sZTSZB1AdNHWAWPXC7/dkxezYyUgEf7CgktmfWRVzHVUj3zYRfPaZ/twIBJVV7Vs
 XOvWwqKTzXgQcW3BNGNZg==
X-ME-Sender: <xms:EgZZZYOk78jukyLQ1v9OpVaOnpJUjVdLH4jd2c16e0Gf-KDZ9A4lPQ>
 <xme:EgZZZe_ZkGbXnsfQrxa7I0o_yg3UXhZyzFjOfonXWIi05eoXW50lKFYt7KgBX9m8C
 930tsveStO-3_Cs30k>
X-ME-Received: <xmr:EgZZZfTcLfHzdiVuZ7gWACgXQ-hvhsPTMLDX_kG1pXcsX-ptxVCIavQCMRWYRmg6GI9VvJ1Ge89IpEWnWQCmvdEdJAMMSM5qa6esSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegvddgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheplfgrrhgvugcuuegruhhruceojhgrrhgvuggsrghurhes
 fhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehleevgfduvdeutdehke
 fguefhueeujeetudfgvedugfefjeejkeekkeekfeehudenucevlhhushhtvghrufhiiigv
 pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghrvggusggruhhrsehfrghsthhmrg
 hilhdrtghomh
X-ME-Proxy: <xmx:EgZZZQu43XL16Ysz2uRgfjo5vVgkpjCF1XmtrrOR7P2G4qPNCXQISg>
 <xmx:EgZZZQcDKYx5ejUP75IhIIOd8Fk5heGdfmz2KfAy4TRND9aI_yL_-w>
 <xmx:EgZZZU0wiePyBdb5NKk6W46z-EOVi0D8EWinMnx_0zvpCO2Ed2fTmg>
 <xmx:EgZZZYkktjYhWCgeM6x-eZBeahYRRCJ_NmxOKuwuNeRkodeqxNeqRw>
Feedback-ID: i1961441c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Nov 2023 13:44:34 -0500 (EST)
From: Jared Baur <jaredbaur@fastmail.com>
To: u-boot@lists.denx.de
Cc: Jared Baur <jaredbaur@fastmail.com>
Subject: [PATCH 1/1] Write upper-case BOOT.BIN to zynqmp MMC
Date: Sat, 18 Nov 2023 18:44:20 +0000
Message-ID: <20231118184426.2808502-2-jaredbaur@fastmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118184426.2808502-1-jaredbaur@fastmail.com>
References: <20231118184426.2808502-1-jaredbaur@fastmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Nov 2023 19:47:00 +0100
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

The zynqmp bootrom will not boot from an SD card with a fat32 fileystem
with a lowercase boot.bin file on it. This means that using DFU to
update the boot.bin file will render the device unusable since it is not
written in upper-case.

Signed-off-by: Jared Baur <jaredbaur@fastmail.com>
---
 board/xilinx/zynqmp/zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index f162803084..bcccf5b7c1 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -647,14 +647,14 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	case SD_MODE1:
 		bootseq = mmc_get_env_dev();
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=BOOT",
 			       bootseq);
 
 		if (multiboot)
 			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
 				       "%04d", multiboot);
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".BIN fat %d 1",
 			       bootseq);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ";%s fat %d 1",
-- 
2.42.0

