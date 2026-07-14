Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF8EC44507
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 09:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6189E84CC5;
	Tue, 14 Jul 2026 11:49:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WQ/juq3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6AE84CDC; Tue, 14 Jul 2026 11:49:19 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13AA384C5E
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 11:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pbiel7@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso4018653f8f.3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784022556; x=1784627356; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8oSxUazGXQpnyt9n8DakWBf/O8KuUIzHXQqmJDV050M=;
 b=WQ/juq3airMnG0ze91O71XDvkgG6HTRq34/pibz31jvRiVtQc6NNsQ+HgbxY7MKnuG
 +UeeqaG/iF6Y0zu3Ah8Q9nhgz9aylFykdByCckJxa/AmCmWUAZoYPMT4P7e+q5u1iVYA
 T2KVl+YED5F3SWJz46R51kyfIvKWJT63z/AJBj9ROayMC05F1YA2ToSGCXKC6iXBB7X5
 i/raWmDYaPggTwAUhM9g7GYxQvFIP79itvN2JQEN30b+tk07Qb0Tllc/Wc8EUQNcqHDG
 +PJGjJA3FZ/7GMc6s2xuk4CAJq6oAPepGid8Nt6kQjXCDAUJ3G7NHAKgdN0KMW8FaAaH
 PvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022556; x=1784627356;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8oSxUazGXQpnyt9n8DakWBf/O8KuUIzHXQqmJDV050M=;
 b=RuKQ4PZpTjHDl6tGho1yJP7BFCsUHP2IqtoabtlNY+ndVULpUD5bl1BU6bOSRouO7g
 x6IRLQaM7f5hS+vZ+FCP9ov5zJiiYjgEjnfdK2Tq7TUlXa3WLDQGr88qqvnM9Trf6N3B
 /tm1LKoQt3A3WB1MOE+VRKxKpPZRbl+2NAXeP3/e5xXZCXiGPfrhvZ28SLT2NVX3w4ZE
 /keG60ruFdkzGp8rT6KqZJghfwkag3x3d99hVc5cjR3dIl0wnVgg0+GqOwCnvTD7KqdO
 Iwcaf94IAOmmeJNBUaIQjQgh7Z9T4WanFK7TMNrldi6lv+WK+ch66uQyiAjXA1y+pBy4
 I3gw==
X-Gm-Message-State: AOJu0YxeU4zM5QlcVaJZ/Vff7nVIfsILf9+aJlrYHjXMLG2Jmxv+nTFm
 67vJDUwJ3gTAqa63fIuB0WMeD8rmYlyiusjohcIwDg4o7Z4eH4cbiDj3KkI2PsA0I0E=
X-Gm-Gg: AfdE7cktAel4YDSCrzfJicJ/K5vrQXVwYVgsxVXWkyiwlSh9chIi8EfsgO+IaYO2Gc4
 K18vmcmrNP2vttY9gEGK6WMDPBuGJh9h/h/3JuNv8xfBm9YTFyQtCRyk4ErLf6jJi+6yw4Psgoc
 MjURGCoJ0FlBIWl6vxvd9JuhIIQJgP+AMFf/LtXv4+t3MkgqqoVxV0o5ouSgxJ5K/Jvla/Q8hGb
 J7wDnZW/YcN3UIK9KMtWFWDTf/kTSQ1q4GqUMWwdRyp8R7Qg3ZFQ0jcNZ/7SP94tDWTJ3CEB7oa
 ceeo3ZrTueuUFXMQWmbx28HVMSE1ehz6prd9eBSGq2+J7dOunNJRN8wduaQwMyQb3atMXvYq7tv
 1pEj3wld6jtt0LXL/8qvkLOh4ePfyALhAjFOe4otwYosz7PSoALLjeQzworbcdb5q/T3mYtzhF2
 6GHtzRZhhBEDcMVcowzA/ZRhNvnszociK8d1RNQwRK811xgXQeLnihJx9Z0yFYTnncV6v/QFMM7
 V9WZnpskn9/p/mMa4jvkns7XqV/mBsIgmO5
X-Received: by 2002:a5d:5d0c:0:b0:477:2e75:522c with SMTP id
 ffacd0b85a97d-47f2dce7e5amr13873310f8f.28.1784022556455; 
 Tue, 14 Jul 2026 02:49:16 -0700 (PDT)
Received: from localhost ([46.229.159.237])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47f464a9879sm7671502f8f.22.2026.07.14.02.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:49:15 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Tue, 14 Jul 2026 11:49:14 +0200
Subject: [PATCH] armv8: layerscape: Fix TF-A DRAM reservation with empty banks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-up-fix-ddr-v1-1-4834874c1e66@gmail.com>
X-B4-Tracking: v=1; b=H4sIABoGVmoC/x2MQQqAIBAAvyJ7bkEtNPpKdJBcay8mShGIf086D
 sNMhUKZqcAiKmR6uPAVO6hBwH66eBCy7wxaaiOtGvFOGPhF7zPO0gVrQiA1SehBytTVP1u31j5
 vVTDTXAAAAA==
X-Change-ID: 20260713-up-fix-ddr-80af76ffe140
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Ye Li <ye.li@nxp.com>, 
 Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2
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

The TF-A DRAM bank setup currently assumes that the number of
banks reported by TF-A matches the number of entries available in
gd->bd->bi_dram[].  Limit the loop by CONFIG_NR_DRAM_BANKS so that
a platform with fewer configured DRAM banks does not write past the
array.

The reserved RAM setup also checks higher DRAM banks before falling
back to bank 0.  When a higher bank is empty and board_reserve_ram_top()
returns 0, the old test succeeds for a zero-sized bank.  This can set
gd->arch.resv_ram to 0.

On systems with CONFIG_GIC_V3_ITS this value is later used by
ls_gic_rd_tables_init() to place the GIC LPI tables:

  gd->arch.resv_ram - GIC_LPI_SIZE

If gd->arch.resv_ram is 0, the subtraction underflows and the GIC LPI
tables are placed at an invalid high address.

Skip empty banks when selecting the reserved RAM area and fail GIC LPI
table setup if no reserved RAM address was established.

This fixes LS1028A systems with 2 GiB of RAM, where TF-A reports only
one populated DRAM bank.

Tested on an LS1028ARDB with TF-A modified to report 2 GiB of RAM, and
on a custom LS1028A-based board equipped with 2 GiB of RAM.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 33 ++++++++++++++++++++++-----------
 arch/arm/cpu/armv8/fsl-layerscape/soc.c |  5 +++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index a047494b1fd1adcc015a34520d6e2d7f8fe34334..497bf11b8983b208680a028a23677573f9d1edfd 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1381,32 +1381,43 @@ static int tfa_dram_init_banksize(void)
 		dram_size -= gd->bd->bi_dram[i].size;
 
 		i++;
-	} while (dram_size);
+	} while (dram_size && i < CONFIG_NR_DRAM_BANKS);
+
+	if (dram_size)
+		printf("Warning: CONFIG_NR_DRAM_BANKS is too small, %llx bytes left unassigned\n",
+		       dram_size);
 
 	if (i > 0)
 		ret = 0;
 
 #if defined(CONFIG_RESV_RAM) && !defined(CONFIG_XPL_BUILD)
 	/* Assign memory for MC */
-#ifdef CONFIG_SYS_DDR_BLOCK3_BASE
-	if (gd->bd->bi_dram[2].size >=
+#if defined(CONFIG_SYS_DDR_BLOCK3_BASE) && (CONFIG_NR_DRAM_BANKS >= 3)
+	if (gd->bd->bi_dram[2].size &&
+	    gd->bd->bi_dram[2].size >=
 	    board_reserve_ram_top(gd->bd->bi_dram[2].size)) {
 		gd->arch.resv_ram = gd->bd->bi_dram[2].start +
-			    gd->bd->bi_dram[2].size -
-			    board_reserve_ram_top(gd->bd->bi_dram[2].size);
+			gd->bd->bi_dram[2].size -
+			board_reserve_ram_top(gd->bd->bi_dram[2].size);
 	} else
 #endif
 	{
-		if (gd->bd->bi_dram[1].size >=
+#if defined(CFG_SYS_DDR_BLOCK2_BASE) && (CONFIG_NR_DRAM_BANKS >= 2)
+		if (gd->bd->bi_dram[1].size &&
+		    gd->bd->bi_dram[1].size >=
 		    board_reserve_ram_top(gd->bd->bi_dram[1].size)) {
 			gd->arch.resv_ram = gd->bd->bi_dram[1].start +
 				gd->bd->bi_dram[1].size -
 				board_reserve_ram_top(gd->bd->bi_dram[1].size);
-		} else if (gd->bd->bi_dram[0].size >
-			   board_reserve_ram_top(gd->bd->bi_dram[0].size)) {
-			gd->arch.resv_ram = gd->bd->bi_dram[0].start +
-				gd->bd->bi_dram[0].size -
-				board_reserve_ram_top(gd->bd->bi_dram[0].size);
+		} else
+#endif
+		{
+			if (gd->bd->bi_dram[0].size >
+			    board_reserve_ram_top(gd->bd->bi_dram[0].size)) {
+				gd->arch.resv_ram = gd->bd->bi_dram[0].start +
+					gd->bd->bi_dram[0].size -
+					board_reserve_ram_top(gd->bd->bi_dram[0].size);
+			}
 		}
 	}
 #endif	/* CONFIG_RESV_RAM */
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
index d85a630f8a3cb722034b131b94529688af4f55fc..24ccb8bb0c4ce737559254ca84dcf0e8bdba3e64 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
@@ -65,6 +65,11 @@ int ls_gic_rd_tables_init(void *blob)
 	u64 gic_lpi_base;
 	int ret;
 
+	if (!gd->arch.resv_ram) {
+		debug("%s: failed to reserve memory for gic-lpi-tables\n", __func__);
+		return -ENOMEM;
+	}
+
 	gic_lpi_base = ALIGN(gd->arch.resv_ram - GIC_LPI_SIZE, SZ_64K);
 	ret = fdt_add_resv_mem_gic_rd_tables(blob, gic_lpi_base, GIC_LPI_SIZE);
 	if (ret)

---
base-commit: f605dcee103c897b6f1a8873549a36949bd4e2a1
change-id: 20260713-up-fix-ddr-80af76ffe140

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>

