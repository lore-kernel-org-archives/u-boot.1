Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC804C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 08:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D3F8212F;
	Wed,  7 May 2025 10:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="oXRfKfd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B638820EB; Wed,  7 May 2025 10:36:34 +0200 (CEST)
Received: from sonic304-20.consmr.mail.ne1.yahoo.com
 (sonic304-20.consmr.mail.ne1.yahoo.com [66.163.191.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BC68007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 10:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606989; bh=0L7TAsm08/TPiFsRpdlDfEkBeiQ9HteE+inSkTpBayY=;
 h=From:To:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=oXRfKfd3hgbmGKbOD8f/Ga62M7PFjh7HlDX+3pzfimQZs2UfDl2X4JotE1/Dc2vsVgeSXhjVgm5m84QNJrnrgOYG9bGcSjpMWm7iA3sCx4yWI4y8O3clzyZ93r6bNfDAwCzUI7DCFxKx+6kuVexc2ER8+4MxB1BCO0ao8veefPF81ddzS17Vc6RtlOQedWbXu16shS2Xu/gW2m2fajWBOf0tmWc8Ee2FNf9HvpGOMYRJB3qJ+JDwvJhf49WALg77HNAuzmnMNwTT/LbWa2ny+EVnG9MlQ9Vvl4T+Bx7791n0gQbyTDvhy+CSis8vd9OnMOqPqo7E7sSlrNSMkDAGmg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1746606989; bh=ctYMI7yyZ9hVE53dMeaeAbUuhYdEekVG0/+UuTe+tHB=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=i0Av4m9+4EOx+oVGas5yvYbkEWScS6DpkExb/pa9ORhyg9dqAXfr3h1+T8WRUYYqzQahcMd7LgbH4Lu6X7BklCUbBQIDDjkb7urjgDdk+2EXI/6CPwWA40zRLzX5YX39Hjp78aVKS0tkyr/dEL5pjS3NRKWx4NqhuMEF7ocIuIc2PjSuZF5Moq+MdA9tNm3aEq21CxON5ZWbTk6EEz58fAZ9vqa93mqI9v74s1nHnPLA+salEhUmZA3K1s1f11wzJPeAQpPVVl8vQJqAmPQhYpM21GpIVhJ4BXO0E3m8bj0oSOxO+UWDikJTHi9oa+cpb+mFJaUJSOcb8PgZ1KPHWA==
X-YMail-OSG: uDJxAfAVM1n.5sQ.Kl5db.PODEGSRB6T0b3N8xG4VF0qk.56ByS2RZosGdN.q5a
 K5t6J2mrGxKMCNvIOEgoiY5kMcJXmkVceGyeojEAPZdxDYa45xEb6gavhHzTxTDHeIWjONG7hbLn
 0O8ExbT6He19COdKKbh183KBAMB5zxLvNOFzSUpLiM9zhMUg4zcbQTfHolYgw3sTUBX53nj.PF4T
 bYZtjvP3hW4coXqXFPVuJD75rymjwPLtelriEttS7Yj5F_W..lClr3cunQzSTBAwpwt5pZaa6KOS
 wu5rn4bkeVW6B6VyaB_s7XzjlcGwraZRUwuY.rnUhnyfyCAlTIr5MMg950TtXC_0ZS4VfkCyafzJ
 AYxyegIXjuW.QAs.9BgHhS3o3jhPXCjHaWOgSt2bIQA0iaDFEmiH63d5pkCBGXgQsJNCVUW2DxX8
 RII6yA9TzA3LD0ME1yaV0fm7.THT6G5yBXoH55UtsBqz77bSIoKgWcSjKG7RUGxsDva88tVOH5ts
 VCgThmTR5_YYAtWvxTzF4k4F0LAr2su115BKDUCn7WA_4PQqzmaArcZ7HY7nxyKexDgJ3IBboF.g
 67OWBx2P9mBqAsRzr9IXhyxFqLvxbtlS5RDZ6.0yRqookkL6yErWmt_5K8HAslJX4bLDo4BfCpM9
 tkT62re9UH6Bmnv2tPKnTuO0z36TU5M2o3t_SfI4hHO8.sTCGfmF9m3XIosbT.RJPYPilo1eMSsT
 agtgfNRk5A5kMgz2SoJBzSFeEBMYs_ioOG7.nxXSzH9mBieWtroGuWnm2IiAEU6LzCS5tHFKF1iz
 KN_LrGhiZUCrdg5z20REFkSAxv20KqemdJIH2hBulRaX.Gy2X4N6HFfaLNtEzzJvIq0UXbp2u9Xx
 BOO5P21cgYhEsqGN9BhPGlhowHnnBcLjSmCnauUHbHu.KdLkQLWZJCK9DtI8k_T_NKxknD49kZJr
 EnE2VKjKzwpXgPygEjlIb.xToUVTU7SxmplJoeZjV0zBjlfssz5nH7mgKiYpqi5V1.dhpoNgMcnY
 57GC2.6K5keMNjBTupF0Le6DQgnDriILL2IU2.gVHE6L1KhsMbNRJr49V4AwJj2Ee_zykxAvwN4z
 tF9Tjzd1tkxDEAIUyyAlnD_CgxPAlOpRRXcJpQp34nfMSqAL4JLKWJoIZIYyUsZUn82ManNXXEiz
 4nPvAzfnL3JqxTyYxdgPTOgSPXX4s6lXaM238tb.2Z2O0F6G02YmVlHuLjp7fzQKHJgIVG8xCA2I
 Ty0bH85waRLh4j9r2sAPrEgYQ6qIVqcMPdme7TJ7f9q6ULRqBNyBdLPsH3npp45.XZgPwo4tnU0f
 Yp1QNQUrGZTY7fEtXAnXinRibmLxV2HwcxfcK3AfGk4neAydKGiiSMkazdmJvQPZjGN75ta1DbgT
 or5eZQyuvbXaPN8QKgAUn8a._CTTx_BXwyC7Ai_s_23anH_tgN8TBbKjgPvmI809jFvQU4AEd_wa
 uwIoEn1yu.ADVBrxW.s.kkx6h2eigbqr9A52JLim1RhwXdIHeG3ibhTV5IRlUU88Cse4ihG5DsvJ
 37gj.efpyXAnIfWMOhNLcsDfuCdbewzjVTrWyXI8gH2xXBXoPh7UhZFrUDHPbPnh6XMbhIUs.Vmm
 GTZYbAFMIeoxasiMXgfXqJiRdQf0kwtv7VqiZo6K663hJaNdv2CD5QCkDXZRgZrWWJzgPmoKV8B0
 7EocpVQ7e23bMX426yLLm7M7zncxMIb8yEwgddpWZn3WLeWdkvW_c_iWJe6pLm46mLd4tlTgJshq
 A7An_ohAu.2mMPjstFMHKLyT5zHjBOTzEgRzMRa63iWxfG1.2fUBFuKW7BPukIvzumyuQM8vjrk8
 w3.6BBJKc7vA3_jt0LpTyijU_6DHHmgUfgRRXU.Lp0xHlK.K40ZGLYMEtWxpdfOja_NahUT.C7sp
 Hosam3T0YKjwYi4JRi6JjV3Zk_IpxFzCIhLOd.g1sghiAJJrYcZyH1LB0OvO6h5p58uhf.REotKF
 UgLPGKHbat2bysXbx2d.A2tYkvDhY7PkvpQg72hHX89XmD4RzAeTkMnqvxxhnubR5bXp9tSMEheq
 eDEh61Bc.VU0iuk_npPS67wIjzL0m01ehZtISraP6v053FptElXzWXI8oa6ooJcW8dHAlT4bA5KU
 HbxNf18r3GJzlKg3iuspZ.hcQVcO_2OQvgu1.8eWaUZaDVYI5HUW73sXpCUWtslKM2dilP8LGbsq
 kTkBHBZdRq28WSGWT09J4oetnHAazJx_t2ccw4rwAuYG.2MEg7oAa3tdgCbcy1VVVRO4wzzGbmfW
 8
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: f75723f2-9b4a-4e7c-8c05-faede1b7bf4d
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 May 2025 08:36:29 +0000
Received: by hermes--production-ne1-9495dc4d7-psbrp (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 052842e87b67683b25acc59308c8ae93; 
 Wed, 07 May 2025 08:36:27 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Mark Brown <broonie@kernel.org>, u-boot@lists.denx.de
Subject: [RFC PATCH v2 1/5] spi: fspi: involve lut_num for struct
 nxp_fspi_devtype_data
Date: Wed,  7 May 2025 03:36:20 -0500
Message-ID: <20250507083625.6195-2-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250507083625.6195-1-dullfire@yahoo.com>
References: <20250507083625.6195-1-dullfire@yahoo.com>
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

The flexspi on different SoCs may have different number of LUTs.
So involve lut_num in nxp_fspi_devtype_data to make distinguish.
This patch prepare for the adding of imx8ulp.

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20240905094338.1986871-3-haibo.chen@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>

(Picked from linux 190b7e2efb1ed8435fc7431d9c7a2447d05d5066)

Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
---
 drivers/spi/nxp_fspi.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 7489c896f9d..3d0f659ecb2 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -52,13 +52,6 @@
 #include <linux/bug.h>
 #include <linux/err.h>
 
-/*
- * The driver only uses one single LUT entry, that is updated on
- * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
- */
-#define	SEQID_LUT			31
-
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
 #define FSPI_MCR0_AHB_TIMEOUT(x)	((x) << 24)
@@ -242,9 +235,6 @@
 #define FSPI_TFDR			0x180
 
 #define FSPI_LUT_BASE			0x200
-#define FSPI_LUT_OFFSET			(SEQID_LUT * 4 * 4)
-#define FSPI_LUT_REG(idx) \
-	(FSPI_LUT_BASE + FSPI_LUT_OFFSET + (idx) * 4)
 
 /* register map end */
 
@@ -316,6 +306,7 @@ struct nxp_fspi_devtype_data {
 	unsigned int txfifo;
 	unsigned int ahb_buf_size;
 	unsigned int quirks;
+	unsigned int lut_num;
 	bool little_endian;
 };
 
@@ -324,6 +315,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -332,6 +324,7 @@ static struct nxp_fspi_devtype_data imx8mm_data = {
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
 	.quirks = 0,
+	.lut_num = 32,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -486,6 +479,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	void __iomem *base = f->iobase;
 	u32 lutval[4] = {};
 	int lutidx = 1, i;
+	u32 lut_offset = (f->devtype_data->lut_num - 1) * 4 * 4;
+	u32 target_lut_reg;
 
 	/* cmd */
 	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
@@ -530,8 +525,10 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	fspi_writel(f, FSPI_LCKER_UNLOCK, f->iobase + FSPI_LCKCR);
 
 	/* fill LUT */
-	for (i = 0; i < ARRAY_SIZE(lutval); i++)
-		fspi_writel(f, lutval[i], base + FSPI_LUT_REG(i));
+	for (i = 0; i < ARRAY_SIZE(lutval); i++) {
+		target_lut_reg = FSPI_LUT_BASE + lut_offset + i * 4;
+		fspi_writel(f, lutval[i], base + target_lut_reg);
+	}
 
 	dev_dbg(f->dev, "CMD[%x] lutval[0:%x \t 1:%x \t 2:%x \t 3:%x], size: 0x%08x\n",
 		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], op->data.nbytes);
@@ -731,7 +728,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	void __iomem *base = f->iobase;
 	int seqnum = 0;
 	int err = 0;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 	reg = fspi_readl(f, base + FSPI_IPRXFCR);
 	/* invalid RXFIFO first */
@@ -745,8 +742,9 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	 * the LUT at each exec_op() call. And also specify the DATA
 	 * length, since it's has not been specified in the LUT.
 	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	fspi_writel(f, op->data.nbytes |
-		 (SEQID_LUT << FSPI_IPCR1_SEQID_SHIFT) |
+		 (seqid_lut << FSPI_IPCR1_SEQID_SHIFT) |
 		 (seqnum << FSPI_IPCR1_SEQNUM_SHIFT),
 		 base + FSPI_IPCR1);
 
@@ -862,7 +860,7 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 {
 	void __iomem *base = f->iobase;
 	int ret, i;
-	u32 reg;
+	u32 reg, seqid_lut;
 
 #if CONFIG_IS_ENABLED(CLK)
 	/* the default frequency, we will change it later if necessary. */
@@ -933,11 +931,17 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
 	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
 
+	/*
+	 * The driver only uses one single LUT entry, that is updated on
+	 * each call of exec_op(). Index 0 is preset at boot with a basic
+	 * read operation, so let's use the last entry.
+	 */
+	seqid_lut = f->devtype_data->lut_num - 1;
 	/* AHB Read - Set lut sequence ID for all CS. */
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB1CR2);
-	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHB2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHA2CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB1CR2);
+	fspi_writel(f, seqid_lut, base + FSPI_FLSHB2CR2);
 
 	return 0;
 }
-- 
2.45.3

