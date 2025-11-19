Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38329CF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B7783EFC;
	Wed, 19 Nov 2025 10:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RjZSJkLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E0883A8C; Wed, 19 Nov 2025 06:14:25 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C8383DE0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:14:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Takahiro.Kuwano.infineon.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 288F4434FB;
 Wed, 19 Nov 2025 05:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB870C2BCB6;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763529256;
 bh=+gD2w8b2a2vprC2oFCzU1lOcQqucOq0/DJ2+AZgNE5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RjZSJkLNwdRmFljM/BsBargeiPBPQLQvXv8A0/ORUNLyr4I3I0VM3nzlQTAk+W9r8
 2Mn1+G2Zq+YNLPL4zqmVA3o8+wCIMarGzVZtwmWScWuO3r7BVNEVvfNnByL4moAkCZ
 3/mrk9sSKBFGAeHxNQwIAamB2oLV+busGdsDRZYstOyAa1eQCSBj07XEik0aAGDrO/
 cnp3LxADH7nBZIWvljUP+EjAk5q8MUlCkqcFkPdKvC8wGPWGlQk2cgSVDvJ/tZ6kfb
 V38ar7VKS7yoCbiXYfpV0XpLGaUrzrzk+czwxJHTSRotrS/z1JmMuI7aeOCtAgoKaF
 oRBsklMluD1dA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8CBCF256C;
 Wed, 19 Nov 2025 05:14:16 +0000 (UTC)
From: Takahiro Kuwano via B4 Relay
 <devnull+Takahiro.Kuwano.infineon.com@kernel.org>
Date: Wed, 19 Nov 2025 14:13:10 +0900
Subject: [PATCH 11/11] mtd: spi-nor: Call stacked/parallel post init fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-amd-cleanup-v1-11-c555bd85e6e4@infineon.com>
References: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
In-Reply-To: <20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com>
To: u-boot@lists.denx.de, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Vignesh R <vigneshr@ti.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Havish Mutya <havish.mutya@amd.com>, 
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Daassi Bacem <Bacem.Daassi@infineon.com>, 
 Shinsuke Okada <Shinsuke.Okada@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>, 
 Takahiro Kuwano <tkuw584924@gmail.com>, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763529253; l=1426;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=Tg+dA3mBGmNn97VIjQKqueub32h6w19dYeeUbobngh0=;
 b=70z6GmNnastkl8xKkcCZFkC8mcNjNOBHrRkbEZMxVPBKiBRZKt6w8/lXdrSBZTnHg0ndlacK1
 EGmyghn/MdFDQowsOeekKqTSOf+A0bhGj+4/NqlvkHKShU3nLXPR7Lx
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=
X-Endpoint-Received: by B4 Relay for Takahiro.Kuwano@infineon.com/20250227
 with auth_id=566
X-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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
Reply-To: Takahiro.Kuwano@infineon.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Add support for stacked/parallel mode by calling post_init_fixups() from
core.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/sf_internal.h  |  3 +++
 drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
index 8b1a48f045a..a9825a0b317 100644
--- a/drivers/mtd/spi/sf_internal.h
+++ b/drivers/mtd/spi/sf_internal.h
@@ -108,4 +108,7 @@ int clean_bar(struct spi_nor *nor);
 int sst_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 	      const u_char *buf);
 
+int spi_nor_stacked_post_init_fixups(struct spi_nor *nor);
+int spi_nor_parallel_post_init_fixups(struct spi_nor *nor);
+
 #endif /* _SF_INTERNAL_H_ */
diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index acfbc0bb702..f9b6971e535 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4363,6 +4363,16 @@ int spi_nor_scan(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
+#if CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)
+	ret = spi_nor_stacked_post_init_fixups(nor);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_parallel_post_init_fixups(nor);
+	if (ret)
+		return ret;
+#endif
+
 	nor->rdsr_dummy = params.rdsr_dummy;
 	nor->rdsr_addr_nbytes = params.rdsr_addr_nbytes;
 	nor->name = info->name;

-- 
2.34.1


