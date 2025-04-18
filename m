Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E91C369C9
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 00:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0D0382CF1;
	Sat, 19 Apr 2025 02:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="WGSB/sdW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78EC8298E; Fri, 18 Apr 2025 23:04:42 +0200 (CEST)
Received: from sonic306-3.consmr.mail.bf2.yahoo.com
 (sonic306-3.consmr.mail.bf2.yahoo.com [74.6.132.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C01D800B3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 23:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dullfire@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010279; bh=0L7TAsm08/TPiFsRpdlDfEkBeiQ9HteE+inSkTpBayY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=WGSB/sdW8fl6mqMAIDNjfP6LnLtoS/ID2qxLdrZlTMsuME2GkgfwI8XppoGV6IUvGcRK6mflRFk+KMAhQYpna5yA4aSHqU3SrBl1AtM1e2FM742lDo6djFV+56vEPB/9s3lJNnvo0VQpypLtVKQG2tjrG9Y+7ZdyjfTRoIfPs94oHl18mUVdRvhAToi8V31D0wFOCvXmKBFTC8T+Pi6CkrwrQ2Dkf6tJ20cJ2+5825hzb+j60HFSABUv0mZ9eObeOwRsw6TkXCzZqYfHugAeLNwGPZ7bwnNBljXe13ymcbVRUgdkLkjWtRIL9zJ242vLE1jytXNIQhw2ymKsDwDJ3A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1745010279; bh=XAfKH72BGwlV0e9I78HFkekzb+mfDM9j4ifNudIxuBO=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=fszwxjQcDy9lcRhIAdDVVTv8IqPlEGWs6Py7Sm7ipjDSlRSYPiGUGxXwk3nBCpohchmCMOP1DuM6rWHbiDBFk42bdfDk2p6wA/GU3FqjheQgNEYsGUOkv3pZsJcq1Ne2M70L8LRjuaqPJ9JSY0PH9eV6UVULNILw7UfxAo+MQdod/affXQhNcpqQ6YiaYKbZoYjhjGMLTsE5jfHkDcj1q3rVbjczWCT+pIX5Y5czK1WEgN6C4ZAnDL5bADuSHqoLQppoN5h6RylHiibaHYxRGJ+LQBOKB6XOnq0vVeIaG5c8TnFJHSDBrnKNqq6ZtLh4BmnKoVjnES81F172eIOHnA==
X-YMail-OSG: uDG2RWoVM1mUk77LT2DutYbjEQJCjOUTiqeex_NcTX8psRRfs8ND1sfVQRjWdjS
 qP_QoDxTjPblf_w08Vrhz8iYZ1q61Ob8My_WWriZ5q5QNIrIWaqIEbAye9EfSagcTikMeYcVpydH
 _FuCxorVDhuGLgVEOx8VmK1_Ro70H8QJOUsTmoNGvCTUn.SsTceLWrlbv1R.YgRZXzd5D0zTrCQC
 .LrYOD2FI4JlZD5d0xFaZljOihfREgVPdECUeqoyta_ddqiXc_Uc9X11aU16qpf3vMWBlKWju_u1
 9QeoCx2VDNTfr8zuni1jTEEnxVnPACm0ouAD3Xv9XcEhw4RFq.oGQvJmb_MbPGzjm6Io0UlCmLuC
 cBavPLM00PgfTf5mqGsDrPmhPvio9.mjconBY8KNceXV4OZsbBEFt5HV4Kog1Umm5V_BnhGINcQA
 krErkQHsYaUXHFNA9gzbyL3NciFG.wRiKva5anSUl.uhaDPSqdTZksVmPH2KvnYx6qpXk7UABrRa
 vkXiofTuoNBJjGYcG10pZqGU3bK1M9jotWQW2kza2HIbcDGeDxk.kYqjjCTlzjsZlHmPDBSaYyGL
 B47E0_twdut.JBTLlvKbhxpo5w4NNytITs4dZ.96r4uEgvJyrl2W6UC5eK6GWGYJ7ayatFjUebDN
 QPY64fs.bRKK9gvAQtxFFQQ_AlxOpOHRhBA8wcYaSDIjPrfCQ2OURZyIT6gE2QQ_3EoSZMTORmdi
 6oCzEKIm0yd_6GelUOo6ueCJd8JmGWJL_P46_yFcJY0lxzJOgPqZq_fPG0evFS9XzstEJy3zQhGS
 g.yxhwjiq18MYXfk_s84kelL3AeU_hGakScJcGrurWDadbOLr_EEzOUhl7ut.GsIcoDV3L9sCepM
 .FXzwzd7ajsOV739DSVxpq5ZQgZQ46D6N4vwvQlGfF9oCERhtFLuotbzd62l8thP7Gp0ZGx7br6I
 fLG2Dzsr3mjQLMe2Yt8oltQX6rW26KDrEknhh89zIjyOgJl7oSSzXCiZ.37JgF2Q1eGDjmTUGo7S
 hhEWRzbVb024uvQNrWMBXlEyv4KyBE.C1fP5YJDL7CQGekY74utfwe9y3hOFpLUQbzWxW5uzzuJ_
 qviDRzy3ocM2qpA3k4.gF0do8EsGLERbbyUya9Lm1L.uE3VWcSyFl4iyoRN0rj1Ow1RXNGH__4iY
 WK8upOfarhi4ZwDrsLhFWNGiB4k651TIOy6kCcu8DPwDop89oajDECfHY1tlIIJauT2v12a8uwPv
 vteqaSCQWHjv12KeGsZnm7AujMc6rOxTQZ0hqSozldP_YDXq3qircvG2M1fC4GbmLKBLOaxVHb3g
 KCsUcIMmdxsCBVGrwDyY1c3hwiazbPcKxM6962ZuYOu_X5MXmeyMWauodsF2UYWoLxKfQrjspmmz
 MZWTnxbYUsWuxgMLp0Pc4Pwbh61EtxYJUwCpikpmWg4.taISgahE0BFoSbPB_cWUQjFAnfTMSa5u
 0EjGQUeHfGSGOKq2rRfIOGSCOyRIKJzLnzF_O2_t_pNGNLQ7T0C1Gelk1cac1kbX32CL33kf87Kn
 uduKRtOR2Zq7FgkHqUX1a22THE_rksi42LtL__.ouPMHxm5p.qHIWUG2q492IJl9ecdkYQD6QSTr
 N9d9d9XgnZxpHmrHGBuOcw4sGoF__GPHp.RFJkArJMUNNJkINC1eMfC_Y7KrYWBPDrSkmLw3f5Cy
 AjyZCZliSjfaC3cm7Ds90AX6ROsqjYi_pO6pQYOPCxhHB035rwUVmc6q2RMFiD1WZOmkBsz80v6v
 Nf.acGXCrNwZLcxvTLr95CNIJSwqDE4NGtprzaktJ3qf8TLSHwdVfNSZXwCnM8KpnDqWbsJKem_J
 vwXbL5EaP5B83HS9TfAhvhAHPE4QGZQm7IQuRabXXxUJoUokl5WN3NuVXU6V4I9zxPB0Uev.Q_Mv
 EmomY_6ID.5yse.6HkwB_lHzRtQkpd4CdVmFyNNcmTWgjwWJyM4r8Abo50Qlq4ql1mbUigNCDLE1
 Ffr8pxawj7C4CIkUYU0DEB2XKHbv9H5pJSgKu8qA4pnDXnqE14iaH9ejiT4wf7I3s6_AQqc5rgCe
 zjtzW4f80OIkZ8AmIefav5mfhnoSzEe7CPLcBaKVLUeTd4EC6MH.URVl7J6lgI49jqH_cxYroSTc
 fz3pIebQlfh.goFTNBJSFoclDHIl7KRLWqmlr87pDjpjwkOlR0eSqpjyjn.p5c65YsSDSt3Id2rV
 LXgNg9HadVKbdizbHXE_frQLBqcqBTTigqsNkLwQ3kqGTM9sA5z0g3FY0XTwXTcAmmxkZjuyE9Wf
 kMK4PxsL5WQ--
X-Sonic-MF: <dullfire@yahoo.com>
X-Sonic-ID: 635e0706-e11f-4c0f-8cdf-c722d657e3e7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 18 Apr 2025 21:04:39 +0000
Received: by hermes--production-ne1-9495dc4d7-vm8nz (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 8db398f23f7fc84b9cb4fa664124209c; 
 Fri, 18 Apr 2025 21:04:34 +0000 (UTC)
From: Jonathan Currier <dullfire@yahoo.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Haibo Chen <haibo.chen@nxp.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: Jonathan Currier <dullfire@yahoo.com>
Subject: [RFC PATCH 1/3] spi: fspi: involve lut_num for struct
 nxp_fspi_devtype_data
Date: Fri, 18 Apr 2025 16:04:28 -0500
Message-ID: <20250418210430.27458-2-dullfire@yahoo.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250418210430.27458-1-dullfire@yahoo.com>
References: <20250418210430.27458-1-dullfire@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 19 Apr 2025 02:13:29 +0200
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

