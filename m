Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203FCCA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D930440BAA;
	Fri,  2 Oct 2026 16:47:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bwng_qTimisu; Fri,  2 Oct 2026 16:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D71EE4084B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790959660;
	b=ccdLGK8fF/cFzU5el05Ze5xgN5BtXVZKSjKK+JzY5yOQPBQnTqeBIuI6GP4Oxy5EFfrt
	 TKqWOQWGfDO4y1qiPxHgar/rwev4Lj39YBYiu0uojd/l9cK7w6TdkLCgL8cXh18PaWQ5r
	 47iJU2YdxIEA2axFybCP7BX1U7rlejBt+0mAokO8tztOfNmKC6c8bw1Lrzw7Ydr2bi6/b
	 SYSVv27zVd21lf65FeyQOE4TX0/s21xXpBtzTHie8pRNKWCf2I/SuMoVj71f0HxWWv/6m
	 X1A+eIaOsIVzWXnOjjHmMwH21hPqrjgzOZJBR7096ieVevRkPUyV+5F4DPWnTqcpXRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790959660;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tJg2Yd8pKC+PBNuU517PkiEQxJ/syKGp1Byfo61tPFQ=;
	b=DSa0NZC59RpP5HTM1W4md8LgTKwEZ2/OpZIoq87NHNRxQs+kEUFBXbZ5P5L/1EDUHfAc
	 CSmqJYBMEZ15kxlvoTzNtRXqgNCjDtzzUw6YfTNXnzR2guM61jV/x+grwKUy2Sz1dvKfi
	 4YFqz7Xb/SIsqTY+id5KKqHXHddyi6MslC1WLheq0QOiY/03/gFxqV5a9LJKyt2P55beW
	 D8TlJYVxRTpdQm7dssL4pkWmeutMclIRp3KFy3721n+Ytb2D7pw39J2GOzYsYe1cLJmhs
	 w+ykbcwvKoNc+ZmW9uGOHfqbP6gZi+ZLHbTr8EnfnZDofdvzCM1H/fAUPva9qUVfhew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790959660;
	bh=tJg2Yd8pKC+PBNuU517PkiEQxJ/syKGp1Byfo61tPFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MV9Ln2B1iY/dB3/Xgj4PnY0LgrOyT0/0SYFXLnbwkzoNQSUWl+YZ8MC1W31f5VMXc
	 8dcBUfTs8GiIXNccQtIueXdA35uay5oK2ycCEAaqURrS5G1Mz8LgZWpgla3cvJHHGA
	 QA6NU6hU4qiRyDV45z2lQ1kUfeNOj3bw6pSa10zmIqxcEcyrsfGxGEkR2MWvC1lvUm
	 IXvquszQ3poVwWZhm9kUjnwQD7qm3nZbHc0rNCHHZKv1pSKgs0+minMWcaAOjtWJA7
	 JmJnJfjp9M/KAUozQS/AuvUZuCYXh2bQ5bPIB6d+BQD8SVeerkhiYCmpJWoy8Yc6XG
	 MLHgd/1aZQYeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D71EE4084B;
	Fri,  2 Oct 2026 16:47:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3956834D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1EF564055D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46JrctcbTlZr for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 13:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0EE11400D1
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946878;
 b=TUWVnGONAZdGgs3V9kJlo6iS9lKEoEY4H29vBCWFjpacXawJRyHRKEove5ps/mZZpMa8
 DqAMmLzHpf20DQK9nhZlB5WSNE69Hnj8bhxJSCQkQGpR4hXJwoLlM/wKagEpOw8yMhm2X
 vc1QsIYPh5FovI2/x5MwjVXxPAPAMUo880kKLnHXdaLu1J33lofCKFT3GifCAcavJ9Vxp
 5CJIKxxVMkDADftAgugOCUCC1ZXkKSGAcXtjngkryDDHOr8KdjjHO27UNOepFbKgdmcRu
 YEOZbVGUWKVwEGYhFHF2ZSrM2dZea9tvSn7hdmcdi7sPndmE0EerlKYRejCt0/ReA0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946878;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Last-TLS-Session-Version;
 bh=tJg2Yd8pKC+PBNuU517PkiEQxJ/syKGp1Byfo61tPFQ=;
 b=UvAtj7ZmHc9bJpPnoxZKBLBAd0fIHNvJxiAQB4ljH1VYTEEMK8mjuuozozdP75a96P/Z
 fLHfOnO+/D2YzBQasTk9oUzTOLcVIuXMXugzLl64/E37BkxaLLCoUSquYAogxKI/4vOvh
 0kmmDC+Mhj7PlxOIF5k9oMV2k38GPp5/Vsb0TunmxXqCsJNjtYqZR6yWTZFWDRFczKdny
 jkyr7j1VIAGE07JHjCcovTYSScjfhfhZaPngoS0aj7nL5GePrXKku7n7JC+gxkWgTcRoE
 baobbqhhxYDGeGyoUDFSLDSzCg4DBU11QSaWOHRAo4wtfzjM82OmzwNVqPtmAxKujlw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=G2W5Tla0; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=G2W5Tla0
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EE11400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 13:14:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 175AA1A10E8;
 Fri,  2 Oct 2026 13:14:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DFE3B603DC;
 Fri,  2 Oct 2026 13:14:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E9FC2103281F4; 
 Fri,  2 Oct 2026 15:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790946873; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tJg2Yd8pKC+PBNuU517PkiEQxJ/syKGp1Byfo61tPFQ=;
 b=G2W5Tla0yyEKSa/q+NL35K+EydiZ8oDaE1gCjVQ5bUZlOqznSldDzR3jSrSmX6BcRRQhRZ
 94Yi46gpPp1GA8UK5SJ6Gw/HjHPl0SwDvm/tw/3B52jEl8Um+fuDBU0WoEMzSk3SlfPWrS
 y8x3ypX8ZtLt/TRdA7JHVEPdpFo1hTcb/aRIuaihByeFoRAvoBq1yszLQQW/2QA6z5o4jb
 iISJcUcHC6WEY4wQRUZj9OJAFPJrfBaKvFVyANgrrxJJA3ueX75zRm80GwSqanDvPZWxNI
 4h3VdKoP4PdIx3vdCwo5uQxQGDWAL7V+n8AcHhLjciCTHGvfuOoQ5/2wGvNNwA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 02 Oct 2026 15:02:26 +0200
Subject: [PATCH 08/10] spi: atcspi200_spi: Add spi-mem support for the
 Metanoia ATCSPI200 variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-mt2824-v1-8-bc44cf0e0289@bootlin.com>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
In-Reply-To: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?=
 <randolph@andestech.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 02 Oct 2026 16:47:21 +0000
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

The Metanoia variant of the ATCSPI200 core adds hardware command and
address phases along with the dual and quad I/O data formats. Expose
them through the spi-mem operations, which is required to use SPI NOR
flash devices at full speed.

The Metanoia variant is detected at probe time with
device_is_compatible() and gets the mem_ops assigned, following the
same pattern as the Octeon driver. The Andes instances keep the
generic spi-mem fallback built on top of the .xfer operation,
unchanged.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/atcspi200_spi.c | 176 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 72b612c6560..a229b196de1 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -10,6 +10,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
+#include <spi-mem.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm.h>
@@ -30,6 +31,7 @@ struct atcspi200_spi_regs {
 	u32	reserve1[3];
 	u32	format;		/* 0x10 */
 #define DATA_LENGTH(x)	((x-1)<<8)
+#define ADDR_LENGTH(x)	((x-1)<<16)
 	u32	pio;
 	u32	reserve2[2];
 	u32	tctrl;		/* 0x20 */
@@ -49,6 +51,10 @@ struct atcspi200_spi_regs {
 #define WCNT_MASK	(0x1FF<<WCNT_OFFSET)
 #define RCNT_OFFSET	0
 #define RCNT_MASK	(0x1FF<<RCNT_OFFSET)
+#define CMD_EN		(1<<30)
+#define ADDR_EN		(1<<29)
+#define DUAL_QUAD(x)	((x)<<22)
+#define DUMMY_CNT(x)	(((x)-1)<<9)
 	u32	cmd;
 	u32	addr;
 	u32	data;
@@ -364,6 +370,164 @@ static int atcspi200_spi_get_clk(struct udevice *bus)
 	return 0;
 }
 
+/*
+ * The dummy phase is generated in units of 8 bits: one unit takes
+ * (8 / data buswidth) SCLK cycles. The unit count is programmed in the
+ * 2-bit DummyCnt field of the TransCtrl register.
+ */
+static unsigned int atcspi200_mem_dummy_units(const struct spi_mem_op *op)
+{
+	unsigned int cycles;
+
+	cycles = op->dummy.nbytes * 8 /
+		 max_t(unsigned int, op->dummy.buswidth, 1U);
+
+	return cycles * op->data.buswidth / 8;
+}
+
+static int atcspi200_mem_adjust_op_size(struct spi_slave *slave,
+					struct spi_mem_op *op)
+{
+	op->data.nbytes = min(op->data.nbytes, (unsigned int)MAX_TRANSFER_LEN);
+
+	return 0;
+}
+
+static bool atcspi200_mem_supports_op(struct spi_slave *slave,
+				      const struct spi_mem_op *op)
+{
+	unsigned int cycles, units;
+
+	if (!spi_mem_default_supports_op(slave, op))
+		return false;
+
+	/* the address phase is always transferred on a single line */
+	if (op->addr.nbytes > 4 || (op->addr.nbytes && op->addr.buswidth != 1))
+		return false;
+
+	/* a dummy phase without data cannot be expressed by the controller */
+	if (op->dummy.nbytes && !op->data.nbytes)
+		return false;
+
+	if (!op->data.nbytes)
+		return true;
+
+	if (op->data.buswidth != 1 && op->data.buswidth != 2 &&
+	    op->data.buswidth != 4)
+		return false;
+
+	/* the write and read counters are 9-bit fields */
+	if (op->data.nbytes > MAX_TRANSFER_LEN)
+		return false;
+
+	/* reject dummy cycles which cannot be represented by DummyCnt */
+	cycles = op->dummy.nbytes * 8 /
+		 max_t(unsigned int, op->dummy.buswidth, 1U);
+	if (cycles * op->data.buswidth % 8)
+		return false;
+
+	units = cycles * op->data.buswidth / 8;
+
+	return units <= 4;
+}
+
+static int atcspi200_mem_exec_op(struct spi_slave *slave,
+				 const struct spi_mem_op *op)
+{
+	struct udevice *bus = slave->dev->parent;
+	struct nds_spi_slave *ns = dev_get_priv(bus);
+	unsigned int format, tc = 0, units;
+	unsigned int len = op->data.nbytes;
+	const u8 *dout = op->data.buf.out;
+	u8 *din = op->data.buf.in;
+	int timeout = SPI_TIMEOUT;
+
+	/* reprogram the address length for this operation */
+	format = in_le32(&ns->regs->format) & ~(0x3 << 16);
+	if (op->addr.nbytes)
+		format |= ADDR_LENGTH(op->addr.nbytes);
+	out_le32(&ns->regs->format, format);
+
+	if (op->cmd.nbytes)
+		tc |= CMD_EN;
+	if (op->addr.nbytes) {
+		tc |= ADDR_EN;
+		out_le32(&ns->regs->addr, op->addr.val);
+	}
+
+	if (op->data.nbytes) {
+		if (op->data.buswidth == 2)
+			tc |= DUAL_QUAD(1);
+		else if (op->data.buswidth == 4)
+			tc |= DUAL_QUAD(2);
+
+		if (op->data.dir == SPI_MEM_DATA_IN) {
+			units = atcspi200_mem_dummy_units(op);
+			tc |= units ? TRAMODE_DR : TRAMODE_RO;
+			if (units)
+				tc |= DUMMY_CNT(units);
+			tc |= (op->data.nbytes - 1) & 0x1FF;
+		} else {
+			tc |= TRAMODE_WO;
+			tc |= ((op->data.nbytes - 1) & 0x1FF) << WCNT_OFFSET;
+		}
+	} else {
+		tc |= TRAMODE_NONE;
+	}
+
+	out_le32(&ns->regs->tctrl, tc);
+	out_le32(&ns->regs->cmd, op->cmd.opcode);
+
+	while (len) {
+		unsigned int event = in_le32(&ns->regs->status);
+
+		if (op->data.dir == SPI_MEM_DATA_OUT) {
+			if (!(event & TXFFL)) {
+				out_le32(&ns->regs->data, *dout++);
+				len--;
+			}
+		} else {
+			if (event & RXFVE_MASK) {
+				*din++ = in_le32(&ns->regs->data);
+				len--;
+			}
+		}
+
+		if (!timeout--)
+			return -ETIMEDOUT;
+	}
+
+	while (in_le32(&ns->regs->status) & SPIBSY) {
+		if (!timeout--)
+			return -ETIMEDOUT;
+	}
+
+	/* restore the timing register like the legacy path does */
+	out_le32(&ns->regs->timing, ns->mtiming);
+
+	return 0;
+}
+
+/*
+ * The Metanoia variant of the ATCSPI200 core adds the command and address
+ * phases along with the dual and quad I/O data formats, exposed through the
+ * spi-mem operations assigned at probe time below. The other instances keep
+ * using the generic spi-mem fallback on top of .xfer.
+ */
+static struct dm_spi_ops atcspi200_spi_ops = {
+	.claim_bus	= atcspi200_spi_claim_bus,
+	.release_bus	= atcspi200_spi_release_bus,
+	.xfer		= atcspi200_spi_xfer,
+	.set_speed	= atcspi200_spi_set_speed,
+	.set_mode	= atcspi200_spi_set_mode,
+};
+
+static const struct spi_controller_mem_ops atcspi200_mem_ops = {
+	.adjust_op_size = atcspi200_mem_adjust_op_size,
+	.supports_op = atcspi200_mem_supports_op,
+	.exec_op = atcspi200_mem_exec_op,
+};
+
 static int atcspi200_spi_probe(struct udevice *bus)
 {
 	struct nds_spi_slave *ns = dev_get_priv(bus);
@@ -373,6 +537,9 @@ static int atcspi200_spi_probe(struct udevice *bus)
 	ns->mtiming = ns->regs->timing;
 	atcspi200_spi_get_clk(bus);
 
+	if (device_is_compatible(bus, "metanoia,mt2824-spi"))
+		atcspi200_spi_ops.mem_ops = &atcspi200_mem_ops;
+
 	return 0;
 }
 
@@ -394,16 +561,9 @@ static int atcspi200_ofdata_to_platadata(struct udevice *bus)
 	return 0;
 }
 
-static const struct dm_spi_ops atcspi200_spi_ops = {
-	.claim_bus	= atcspi200_spi_claim_bus,
-	.release_bus	= atcspi200_spi_release_bus,
-	.xfer		= atcspi200_spi_xfer,
-	.set_speed	= atcspi200_spi_set_speed,
-	.set_mode	= atcspi200_spi_set_mode,
-};
-
 static const struct udevice_id atcspi200_spi_ids[] = {
 	{ .compatible = "andestech,atcspi200" },
+	{ .compatible = "metanoia,mt2824-spi" },
 	{ }
 };
 

-- 
2.55.0

