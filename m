Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60403606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mwpRwysQ;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=sNRiIcjX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD692406AB;
	Sun, 22 Nov 2026 10:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zW5rhZA-U88q; Sun, 22 Nov 2026 10:27:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB3C1406A2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795343227;
	b=KdsabcMp7wHZgAQ8uzdqd49+Ilolsqoyl+LnjY9DtEi27uOlzwpkOmXCdU16K1bv0A20
	 HpzILdJXr1/sdQcolg6elN+WsLklheAoOrFUOcEmVirE/DnJHl87Mlr9N02X+10+DFWu+
	 3RaLFVIA1D9T+l5HXS7o+M7jqt6+lK9bbgiooeRBqI9Y8yOasmoWI9AGGjeGooWOF3s12
	 sqRNppAVFzub4dljcPN9OvdR7f1gR4M+RzIyH1VvbAYi93FlUklZY4hmh2UafTIlQ7JXi
	 2+smnecwtQJtqOagfpachdwSNTQo40BT1YfptbBE5ytd2Xv766Z9nJYow5tGciD8ZdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795343227;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 Mime-Version:X-Mailer:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eH/nrO1CLFMwM2D2T4Ncpi5sb0plyCU8U3KU43U7bsM=;
	b=DUkFGrqe3oiLjPDsFoqZ4TULk2fdGorzhtABFmuI6HdJtXT40SdKTFHTRAlEYusRVWQ9
	 WkcQjjVohJThpMCs1n87kEUtEArdTF6IguSw/2xFB/CoxRehcSi1KqHaDYjyeV8IfevHr
	 pIh2310VHM1kXi/bAIy1lxWHGg4Yo471aMmKYelMMBzHar5YB8+F7UpcFdlQTLKodlzjH
	 1wlrUI9WNaarR5Kve9qDzn4iUrhOYtJsDax/WwjUFoWQKzE41qgFCrfCieAoLcxqBifq4
	 O4Hp4vv1uqHStetuOKMsEQAOCBI0L3wwnhcX2DRg5FIww1bkQpfRHC7CdVVw40ENCBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=email.cz;
	dkim=pass header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=sNRiIcjX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795343227;
	bh=eH/nrO1CLFMwM2D2T4Ncpi5sb0plyCU8U3KU43U7bsM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mwpRwysQuD2+ph1U/mrTmWWRshH/gxuyUQsRaUF9nQgh221eZowiXep+XergfvmsY
	 NqOERLM1a8fwwUqhwZKaaHbh8vUgxE46GIlsu0HJS8V6rJVwwxktVRm5qIxcl6j0Ef
	 fmVkJhv/sVN4U+ueRy+/eOKr79l7ZgL9hznX40eYl5qVbXDXk30yhS5Lh8u/mq+/ji
	 Y8RGs/sgDFTNWyh0N3+kMEzdUHAIghtPbYY3LhY3t8OU8cvAbgDd8zQYL5Sv2tQXNx
	 yXHe0YPJWirNEHb4CVZa2A1VChJrY/+ZHFhXVmYh3VeiiVVPTrewrkE9DJ0r33jKH4
	 E9SZCI9O0tmqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB3C1406A2;
	Sun, 22 Nov 2026 10:27:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83896310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69116406A2
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M2cSP-VjhQIJ for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 10:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BBE87406A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:64:8a00::1000:abe"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:64:8a00::1000:abe; helo=mxe-2-abe.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=sNRiIcjX
Received: from mxe-2-abe.seznam.cz (mxe-2-abe.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:abe])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BBE87406A0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 10:27:01 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxe-fd4f7c85c-t5fgh
 (smtpc-mxe-fd4f7c85c-t5fgh [2a02:598:64:8a00::1000:abe])
 id 699bca10976f78ba69154408; Sun, 22 Nov 2026 11:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1795343208; bh=eH/nrO1CLFMwM2D2T4Ncpi5sb0plyCU8U3KU43U7bsM=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=sNRiIcjX3nY14KPdCLhK/VIEehK3Vy0v/V4Qket+e21j92bbyFRXSqbr3tIJPiTLj
 lov9vHw7NYWtWblv1EWWEWU2VEGPAH9NNeur+Smt3w13K+USXvyZa54qfVqJwwkDAR
 DXwpIhVrvETH3tVw4vSaQyF41ZP/Xzgez37F68PpsoVLK8RW3/dS8q5a0X/TFRGJjY
 nY3ns28cVrVFgFmv1EEylgcxtYDo6JgdP5SFNS+TIQHPqie6+O52kjiG44ag9IUkj/
 39TUTauUHhvaPwCvVLt/SJn87Z8QVDCcHKYactklIwHU6h5dQx6TD+uPxXUFWwto0q
 QhoTQwDT9Erxg==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.34) with HTTP;
 Sun, 22 Nov 2026 11:26:30 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Gaurav Jain" <gaurav.jain@nxp.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Heiko Schocher" <hs@nabladev.com>,
 "Johan Jonker" <jbx6244@gmail.com>,
 "Utkarsh Gupta" <utkarsh.gupta@nxp.com>, "Marek Vasut" <marex@denx.de>
Subject: [PATCH] crypto: fsl: add DCP SHA1/SHA256 hardware acceleration 
Date: Sun, 22 Nov 2026 11:26:30 +0100 (CET)
Message-Id: <31O.Zrul.2S7BCX2NICx.1h0iDM@seznam.cz>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.22)
X-Mailer: szn-email-ebox-5.1.34
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a driver for the hashing engine of the Data Co-Processor (DCP)
found on i.MX6ULL and i.MX6SLL. It implements the same hw_sha1(),
hw_sha256() and progressive hw_sha_*() interface as the CAAM driver,
so the hash command and the FIT image hash checks use it.

The driver is based on the mxs-dcp driver from Linux and works around
these restrictions of the DCP:
- All packets except the last one must be a multiple of 64 bytes long.
  Whole blocks are hashed directly from the input buffer and the
  remainder is buffered until more data arrives or the message ends.
- A zero length message cannot be hashed, so a precomputed hash is
  returned for it.
- A channel error is only cleared by a soft reset, so the DCP is reset
  before each hashing operation and after a failed packet.

The hash state is kept in the DCP, so only one progressive hashing
operation can be in progress at a time.

SHA256 is about 5 times and SHA1 about 2.5 times faster than the
software implementation.

Tested on i.MX6ULL.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
The results were compared with the software implementation for all
message lengths up to 300 bytes and for random messages of up to 40 MiB
split into random chunks.

The hash command and FIT image hashes were tested as well.

 drivers/crypto/fsl/Kconfig   |  10 ++
 drivers/crypto/fsl/Makefile  |   1 +
 drivers/crypto/fsl/dcp_sha.c | 320 +++++++++++++++++++++++++++++++++++
 3 files changed, 331 insertions(+)
 create mode 100644 drivers/crypto/fsl/dcp_sha.c

diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
index 41de402c530..a9868245bb4 100644
--- a/drivers/crypto/fsl/Kconfig
+++ b/drivers/crypto/fsl/Kconfig
@@ -100,6 +100,16 @@ config FSL_DCP_RNG
 	  and a Pseudo-Random Number Generator (PRNG) to achieve a true
 	  randomness and cryptographic strength.
 
+config FSL_DCP_SHA
+	bool "Enable DCP SHA1/SHA256 hardware acceleration"
+	depends on MX6ULL || MX6SLL
+	select SHA_HW_ACCEL
+	imply SHA_PROG_HW_ACCEL
+	help
+	  Enable hardware acceleration of the SHA1 and SHA256 hashing
+	  algorithms using the Data Co-Processor (DCP), including support
+	  for progressive hashing.
+
 config FSL_CAAM_RNG_SELF_TEST
 	bool "Run the CAAM RNG self test on affected i.MX6 chips"
 	depends on FSL_CAAM
diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
index 14b53db7844..1e2e73695eb 100644
--- a/drivers/crypto/fsl/Makefile
+++ b/drivers/crypto/fsl/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) +=3D fs=
l_blob.o
 obj-$(CONFIG_RSA_FREESCALE_EXP) +=3D fsl_rsa.o
 obj-$(CONFIG_$(PHASE_)FSL_CAAM_RNG) +=3D rng.o
 obj-$(CONFIG_FSL_DCP_RNG) +=3D dcp_rng.o
+obj-$(CONFIG_FSL_DCP_SHA) +=3D dcp_sha.o
 obj-$(CONFIG_FSL_MFGPROT) +=3D fsl_mfgprot.o
 obj-$(CONFIG_FSL_CAAM_RNG_SELF_TEST) +=3D rng_self_test.o
diff --git a/drivers/crypto/fsl/dcp_sha.c b/drivers/crypto/fsl/dcp_sha.c=

new file mode 100644
index 00000000000..255e11dbeeb
--- /dev/null
+++ b/drivers/crypto/fsl/dcp_sha.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA1/SHA256 hardware acceleration using the DCP on i.MX
+ *
+ * Copyright (C) 2026 Tomas Paukrt
+ *
+ * Based on drivers/crypto/mxs-dcp.c from Linux
+ * Copyright (C) 2013 Marek Vasut <marex@denx.de>
+ *
+ * Hardware restrictions handled by this driver:
+ * - all packets except the last one must be a multiple of 64 bytes long=

+ * - the hash of a zero length message cannot be computed
+ * - a channel error is only cleared by a soft reset
+ *
+ * The hash state is kept in the DCP, so only one progressive hashing
+ * operation can be in progress at a time.
+ */
+
+#include <cpu_func.h>
+#include <hw_sha.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <asm/io.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+#include <u-boot/schedule.h>
+#include <u-boot/sha1.h>
+#include <u-boot/sha256.h>
+
+#define DCP_CTRL				0x000
+#define DCP_CTRL_GATHER_RESIDUAL_WRITES		BIT(23)
+#define DCP_CTRL_ENABLE_CONTEXT_CACHING		BIT(22)
+
+#define DCP_STAT				0x010
+#define DCP_STAT_CLR				0x018
+#define DCP_STAT_IRQ_CH0			BIT(0)
+
+#define DCP_CHANNELCTRL				0x020
+#define DCP_CHANNELCTRL_ENABLE_CH0		BIT(0)
+
+#define DCP_CH0CMDPTR				0x100
+#define DCP_CH0SEMA				0x110
+#define DCP_CH0STAT				0x120
+#define DCP_CH0STAT_CLR				0x128
+#define DCP_CH0STAT_ERROR_MASK			0xff
+
+#define DCP_CONTROL0_INTERRUPT			BIT(0)
+#define DCP_CONTROL0_DECR_SEMAPHORE		BIT(1)
+#define DCP_CONTROL0_ENABLE_HASH		BIT(6)
+#define DCP_CONTROL0_HASH_INIT			BIT(12)
+#define DCP_CONTROL0_HASH_TERM			BIT(13)
+
+#define DCP_CONTROL1_HASH_SELECT_SHA1		(0 << 16)
+#define DCP_CONTROL1_HASH_SELECT_SHA256		(2 << 16)
+
+#define DCP_SHA_BLOCK_SIZE			64
+#define DCP_SHA_PAYLOAD_SIZE			64
+#define DCP_MAX_PACKET_SIZE			SZ_1M
+#define DCP_TIMEOUT_US				1000000
+
+#define DCP_REG(reg)				(DCP_BASE_ADDR + (reg))
+
+static const u8 sha1_null_hash[SHA1_SUM_LEN] =3D {
+	0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55,
+	0xbf, 0xef, 0x95, 0x60, 0x18, 0x90, 0xaf, 0xd8, 0x07, 0x09,
+};
+
+static const u8 sha256_null_hash[SHA256_SUM_LEN] =3D {
+	0xe3, 0xb0, 0xc4, 0x42, 0x98, 0xfc, 0x1c, 0x14,
+	0x9a, 0xfb, 0xf4, 0xc8, 0x99, 0x6f, 0xb9, 0x24,
+	0x27, 0xae, 0x41, 0xe4, 0x64, 0x9b, 0x93, 0x4c,
+	0xa4, 0x95, 0x99, 0x1b, 0x78, 0x52, 0xb8, 0x55,
+};
+
+struct dcp_dma_desc {
+	u32 next_cmd_addr;
+	u32 control0;
+	u32 control1;
+	u32 source;
+	u32 destination;
+	u32 size;
+	u32 payload;
+	u32 status;
+};
+
+struct dcp_sha_ctx {
+	/* written by the DCP, must not share cache lines with other data */
+	u8 digest[DCP_SHA_PAYLOAD_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	/* read by the DCP */
+	struct dcp_dma_desc desc __aligned(ARCH_DMA_MINALIGN);
+	u8 buf[DCP_SHA_BLOCK_SIZE] __aligned(ARCH_DMA_MINALIGN);
+	/* used by the CPU only */
+	u32 algo;
+	unsigned int fill;
+	bool init;
+	bool term;
+} __aligned(ARCH_DMA_MINALIGN);
+
+static int dcp_hw_reset(void)
+{
+	if (mxs_reset_block((struct mxs_register_32 *)DCP_REG(DCP_CTRL))) {
+		log_err("DCP reset failed\n");
+		return -ETIMEDOUT;
+	}
+
+	writel(DCP_CTRL_GATHER_RESIDUAL_WRITES |
+	       DCP_CTRL_ENABLE_CONTEXT_CACHING, DCP_REG(DCP_CTRL));
+	writel(DCP_CHANNELCTRL_ENABLE_CH0, DCP_REG(DCP_CHANNELCTRL));
+
+	return 0;
+}
+
+static int dcp_sha_run(struct dcp_sha_ctx *ctx, const void *src, u32 size=
)
+{
+	struct dcp_dma_desc *desc =3D &ctx->desc;
+	u32 stat;
+	int ret;
+
+	schedule();
+
+	desc->next_cmd_addr =3D 0;
+	desc->control0 =3D DCP_CONTROL0_INTERRUPT | DCP_CONTROL0_DECR_SEMAPHORE =
|
+			 DCP_CONTROL0_ENABLE_HASH;
+	desc->control1 =3D ctx->algo;
+	desc->source =3D (u32)virt_to_phys((void *)src);
+	desc->destination =3D 0;
+	desc->size =3D size;
+	desc->payload =3D 0;
+	desc->status =3D 0;
+
+	if (ctx->init)
+		desc->control0 |=3D DCP_CONTROL0_HASH_INIT;
+
+	if (ctx->term) {
+		desc->control0 |=3D DCP_CONTROL0_HASH_TERM;
+		desc->payload =3D (u32)virt_to_phys(ctx->digest);
+	}
+
+	/* dirty cache lines must not overwrite the digest written by the DCP */=

+	flush_dcache_range((ulong)ctx, (ulong)ctx + sizeof(*ctx));
+	flush_dcache_range(ALIGN_DOWN((ulong)src, ARCH_DMA_MINALIGN),
+			   ALIGN((ulong)src + size, ARCH_DMA_MINALIGN));
+
+	writel(DCP_STAT_IRQ_CH0, DCP_REG(DCP_STAT_CLR));
+	writel(DCP_CH0STAT_ERROR_MASK, DCP_REG(DCP_CH0STAT_CLR));
+	writel((u32)virt_to_phys(desc), DCP_REG(DCP_CH0CMDPTR));
+	writel(1, DCP_REG(DCP_CH0SEMA));
+
+	ret =3D readl_poll_timeout(DCP_REG(DCP_STAT), stat,
+				 stat & DCP_STAT_IRQ_CH0, DCP_TIMEOUT_US);
+	if (!ret && (readl(DCP_REG(DCP_CH0STAT)) & DCP_CH0STAT_ERROR_MASK))
+		ret =3D -EIO;
+	if (ret) {
+		log_err("DCP failed (%d)\n", ret);
+		dcp_hw_reset();
+		return ret;
+	}
+
+	/* the digest could be speculatively cached during the transfer */
+	if (ctx->term)
+		invalidate_dcache_range((ulong)ctx->digest,
+					(ulong)ctx->digest + sizeof(ctx->digest));
+
+	ctx->init =3D false;
+
+	return 0;
+}
+
+int hw_sha_init(struct hash_algo *algo, void **ctxp)
+{
+	struct dcp_sha_ctx *ctx;
+	u32 sel;
+	int ret;
+
+	if (algo->digest_size =3D=3D SHA1_SUM_LEN)
+		sel =3D DCP_CONTROL1_HASH_SELECT_SHA1;
+	else if (algo->digest_size =3D=3D SHA256_SUM_LEN)
+		sel =3D DCP_CONTROL1_HASH_SELECT_SHA256;
+	else
+		return -EINVAL;
+
+	ret =3D dcp_hw_reset();
+	if (ret)
+		return ret;
+
+	ctx =3D malloc_cache_aligned(sizeof(*ctx));
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->algo =3D sel;
+	ctx->fill =3D 0;
+	ctx->init =3D true;
+	ctx->term =3D false;
+
+	*ctxp =3D ctx;
+
+	return 0;
+}
+
+static int dcp_sha_update(struct hash_algo *algo, struct dcp_sha_ctx *ctx=
,
+			  const u8 *src, unsigned int size, int is_last)
+{
+	unsigned int len;
+	int i, ret;
+
+	if (ctx->term)
+		return -EINVAL;
+
+	while (size) {
+		/* hash whole blocks directly and buffer the rest */
+		if (!ctx->fill && size >=3D DCP_SHA_BLOCK_SIZE) {
+			len =3D min_t(unsigned int, DCP_MAX_PACKET_SIZE,
+				    ALIGN_DOWN(size, DCP_SHA_BLOCK_SIZE));
+			ret =3D dcp_sha_run(ctx, src, len);
+		} else {
+			len =3D min(size, DCP_SHA_BLOCK_SIZE - ctx->fill);
+			memcpy(ctx->buf + ctx->fill, src, len);
+			ctx->fill +=3D len;
+			ret =3D 0;
+			if (ctx->fill =3D=3D DCP_SHA_BLOCK_SIZE) {
+				ret =3D dcp_sha_run(ctx, ctx->buf, ctx->fill);
+				ctx->fill =3D 0;
+			}
+		}
+		if (ret)
+			return ret;
+		src +=3D len;
+		size -=3D len;
+	}
+
+	if (!is_last)
+		return 0;
+
+	ctx->term =3D true;
+
+	/* the DCP cannot hash a zero length message */
+	if (ctx->init && !ctx->fill) {
+		memcpy(ctx->digest, ctx->algo =3D=3D DCP_CONTROL1_HASH_SELECT_SHA1 ?
+		       sha1_null_hash : sha256_null_hash, algo->digest_size);
+		return 0;
+	}
+
+	ret =3D dcp_sha_run(ctx, ctx->buf, ctx->fill);
+	if (ret)
+		return ret;
+
+	/* the DCP stores the digest in reversed byte order */
+	for (i =3D 0; i < algo->digest_size / 2; i++)
+		swap(ctx->digest[i], ctx->digest[algo->digest_size - 1 - i]);
+
+	return 0;
+}
+
+int hw_sha_update(struct hash_algo *algo, void *ctx, const void *buf,
+		  unsigned int size, int is_last)
+{
+	int ret;
+
+	ret =3D dcp_sha_update(algo, ctx, buf, size, is_last);
+	if (ret)
+		free(ctx);
+
+	return ret;
+}
+
+int hw_sha_finish(struct hash_algo *algo, void *ctxv, void *dest_buf,
+		  int size)
+{
+	struct dcp_sha_ctx *ctx =3D ctxv;
+	int ret =3D 0;
+
+	if (size < algo->digest_size)
+		ret =3D -EINVAL;
+	else if (!ctx->term)
+		ret =3D dcp_sha_update(algo, ctx, NULL, 0, 1);
+
+	if (!ret)
+		memcpy(dest_buf, ctx->digest, algo->digest_size);
+
+	free(ctx);
+
+	return ret;
+}
+
+static void dcp_sha(int digest_size, const unsigned char *in,
+		    unsigned int size, unsigned char *out)
+{
+	struct hash_algo algo =3D { .digest_size =3D digest_size };
+	void *ctx;
+	int ret;
+
+	ret =3D hw_sha_init(&algo, &ctx);
+	if (!ret)
+		ret =3D hw_sha_update(&algo, ctx, in, size, 1);
+	if (!ret)
+		ret =3D hw_sha_finish(&algo, ctx, out, digest_size);
+
+	/* return an invalid hash on failure */
+	if (ret)
+		memset(out, 0, digest_size);
+}
+
+void hw_sha1(const unsigned char *in, unsigned int size, unsigned char *o=
ut,
+	     unsigned int chunk_size)
+{
+	dcp_sha(SHA1_SUM_LEN, in, size, out);
+}
+
+void hw_sha256(const unsigned char *in, unsigned int size, unsigned char =
*out,
+	       unsigned int chunk_size)
+{
+	dcp_sha(SHA256_SUM_LEN, in, size, out);
+}
-- 
2.43.0
