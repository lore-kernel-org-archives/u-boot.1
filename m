Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847FECD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53B30848A1;
	Mon,  1 Jun 2026 14:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="B5XLtQ/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBE484701; Mon,  1 Jun 2026 10:03:48 +0200 (CEST)
Received: from mail-4396.protonmail.ch (mail-4396.protonmail.ch [185.70.43.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD465846F8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 10:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780301025; x=1780560225;
 bh=Dv3FUOAHt7tixNf8zoIYywKiZmtLf1BkJw46OpdWcoM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=B5XLtQ/nXCA3rZ2gutKK/jJHxlKEG+DrnflMYkN/NN+URZ6tdevKdQj27/9gsbPrI
 i3FyxDaoJ5WN8HGuY9XZjPdJOEXISBqrL+1wansbdEiES8OQUYXQtldKwVtZdXLWIk
 rP22sIWsEnUMxXlYvHjBPM1rRnkZ5kHfg6JMhf0s9I3beQdgYnefJKofUSYiShV8xi
 VThT4xQn125J4YAIy0YWvN1KnJot3n/FYmDsrG0P5wLh9AaU3Yr+V9/faHrCeVFpMI
 U4G9CgX0AfmJAEunUp52BmKaxHaq/NumMCXFVUJdjTy4KomqFUxdFqZBzJsJG+ssl4
 b6cyIA38cy5BQ==
Date: Mon, 01 Jun 2026 08:03:40 +0000
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>, Sam Day <me@samcday.com>
Subject: [PATCH 01/16] serial: msm: UARTDM <1.4 support
Message-ID: <20260601-qcom-armv7-v1-1-c4b7f7aae1eb@samcday.com>
In-Reply-To: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
References: <20260601-qcom-armv7-v1-0-c4b7f7aae1eb@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: b812e45a244605c91e786111e8ac09cc7d45e6cb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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

Prior to ff701837850e, this driver already operated in the packed FIFO
mode that is supported by all UARTDM versions. In order to work around
longstanding issues with the RX path, it was switched to the simpler
"single char mode", which avoids the necessary CMD_FORCE_STALE usage
that a non-IRQ polled environment like U-Boot requires.

Interestingly, the previous iteration of this driver would already have
worked on older UARTDM versions, except it was referencing the newer 1.4
register layout. The older register layout is supported by *all* UARTDM
versions, so in addition to restoring the packed mode behaviour, the
registers are switched up a bit.

I spoke with Stephan Gerhold about this at length and we decided that,
to ensure there's zero risk of re-introducing the previous issue, we'll
maintain both modes, preferring single-char for 1.4 peripherals, and
packed mode for everything else. This ensures we don't regress the
autoboot behaviour of db410c.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/serial/serial_msm.c | 140 +++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 124 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 18d15b7b15b..10948e2aede 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -23,7 +23,12 @@
=20
 #define UARTDM_DMEN=09=09=090x3C /* DMA/data-packing mode */
 #define UARTDM_DMEN_TXRX_SC_ENABLE=09(BIT(4) | BIT(5))
+#define UARTDM_DMRX             0x34 /* Max RX transfer length */
+#define UARTDM_NCF_TX           0x40 /* Number of chars to TX */
=20
+#define UARTDM_RXFS             0x50 /* RX channel status register */
+#define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buf=
fer */
+#define UARTDM_RXFS_BUF_MASK    0x7
 #define UARTDM_MR1=09=09=09=09 0x00
 #define UARTDM_MR1_RX_RDY_CTL=09=09=09 BIT(7)
 #define UARTDM_MR2=09=09=09=09 0x04
@@ -38,18 +43,30 @@
  * The baud rate is the core clock frequency divided by the fixed divider =
value
  * programmed into this register (defined in calc_csr_bitrate()).
  */
-#define UARTDM_CSR=09=09=09=09 0xA0
+#define UARTDM_CSR=09=09=09=09 0x08
=20
-#define UARTDM_SR                0xA4 /* Status register */
+#define UARTDM_SR                0x08 /* Status register */
 #define UARTDM_SR_RX_READY       (1 << 0) /* Receiver FIFO has data */
 #define UARTDM_SR_TX_READY       (1 << 2) /* Transmitter FIFO has space */
 #define UARTDM_SR_TX_EMPTY       (1 << 3) /* Transmitter underrun */
+#define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
=20
-#define UARTDM_CR                         0xA8 /* Command register */
+#define UARTDM_CR                         0x10 /* Command register */
 #define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
 #define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter *=
/
 #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
 #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
+#define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error =
*/
+#define UARTDM_CR_CMD_RESET_STALE_INT     (8 << 4) /* Clears stale irq */
+#define UARTDM_CR_CMD_RESET_TX_READY      (3 << 8) /* Clears TX Ready irq*=
/
+#define UARTDM_CR_CMD_FORCE_STALE         (4 << 8) /* Causes stale event *=
/
+#define UARTDM_CR_CMD_STALE_EVENT_DISABLE (6 << 8) /* Disable stale event =
*/
+
+#define UARTDM_IMR                0x14 /* Interrupt mask register */
+#define UARTDM_ISR                0x14 /* Interrupt status register */
+#define UARTDM_ISR_TX_READY       0x80 /* TX FIFO empty */
+
+#define MSM_UART_TF_RF=09=09  0x70
=20
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
@@ -59,27 +76,97 @@ DECLARE_GLOBAL_DATA_PTR;
=20
 struct msm_serial_data {
 =09phys_addr_t base;
+=09u32 chars_cnt; /* number of buffered chars */
+=09u32 chars_buf; /* buffered chars */
 =09uint32_t clk_rate; /* core clock rate */
+=09bool single_char;
 };
=20
+static int msm_serial_fetch(struct udevice *dev)
+{
+=09struct msm_serial_data *priv =3D dev_get_priv(dev);
+=09u32 sr;
+
+=09if (priv->chars_cnt)
+=09=09return priv->chars_cnt;
+
+=09/* Clear error in case of buffer overrun */
+=09if (readl(priv->base + UARTDM_SR) & UARTDM_SR_UART_OVERRUN)
+=09=09writel(UARTDM_CR_CMD_RESET_ERR, priv->base + UARTDM_CR);
+
+=09/* We need to fetch new character */
+=09sr =3D readl(priv->base + UARTDM_SR);
+
+=09if (sr & UARTDM_SR_RX_READY) {
+=09=09/* There are at least 4 bytes in fifo */
+=09=09priv->chars_buf =3D readl(priv->base + MSM_UART_TF_RF);
+=09=09priv->chars_cnt =3D 4;
+=09} else {
+=09=09/* Check if there is anything in fifo */
+=09=09priv->chars_cnt =3D readl(priv->base + UARTDM_RXFS);
+=09=09/* Extract number of characters in UART packing buffer*/
+=09=09priv->chars_cnt =3D (priv->chars_cnt >>
+=09=09=09=09   UARTDM_RXFS_BUF_SHIFT) &
+=09=09=09=09  UARTDM_RXFS_BUF_MASK;
+=09=09if (!priv->chars_cnt)
+=09=09=09return 0;
+
+=09=09/* There is at least one character, move it to fifo */
+=09=09writel(UARTDM_CR_CMD_FORCE_STALE,
+=09=09       priv->base + UARTDM_CR);
+
+=09=09priv->chars_buf =3D readl(priv->base + MSM_UART_TF_RF);
+=09=09writel(UARTDM_CR_CMD_RESET_STALE_INT,
+=09=09       priv->base + UARTDM_CR);
+=09=09writel(0x7, priv->base + UARTDM_DMRX);
+=09}
+
+=09return priv->chars_cnt;
+}
+
 static int msm_serial_getc(struct udevice *dev)
 {
 =09struct msm_serial_data *priv =3D dev_get_priv(dev);
+=09char c;
+
+=09if (priv->single_char) {
+=09=09if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
+=09=09=09return -EAGAIN;
+
+=09=09return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
+=09}
=20
-=09if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY))
+=09if (!msm_serial_fetch(dev))
 =09=09return -EAGAIN;
=20
-=09return readl(priv->base + UARTDM_RF) & UARTDM_RF_CHAR;
+=09c =3D priv->chars_buf & 0xFF;
+=09priv->chars_buf >>=3D 8;
+=09priv->chars_cnt--;
+
+=09return c;
 }
=20
 static int msm_serial_putc(struct udevice *dev, const char ch)
 {
 =09struct msm_serial_data *priv =3D dev_get_priv(dev);
=20
-=09if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+=09if (priv->single_char) {
+=09=09if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+=09=09=09return -EAGAIN;
+
+=09=09writel(ch, priv->base + UARTDM_TF);
+=09=09return 0;
+=09}
+
+=09if (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
+=09    !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
 =09=09return -EAGAIN;
=20
-=09writel(ch, priv->base + UARTDM_TF);
+=09writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
+
+=09writel(1, priv->base + UARTDM_NCF_TX);
+=09writel(ch, priv->base + MSM_UART_TF_RF);
+
 =09return 0;
 }
=20
@@ -87,10 +174,21 @@ static int msm_serial_pending(struct udevice *dev, boo=
l input)
 {
 =09struct msm_serial_data *priv =3D dev_get_priv(dev);
=20
-=09if (input)
-=09=09return !!(readl(priv->base + UARTDM_SR) & UARTDM_SR_RX_READY);
-=09else
-=09=09return !(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY);
+=09if (priv->single_char) {
+=09=09if (input)
+=09=09=09return !!(readl(priv->base + UARTDM_SR) &
+=09=09=09=09  UARTDM_SR_RX_READY);
+=09=09else
+=09=09=09return !(readl(priv->base + UARTDM_SR) &
+=09=09=09=09 UARTDM_SR_TX_EMPTY);
+=09}
+
+=09if (input) {
+=09=09if (msm_serial_fetch(dev))
+=09=09=09return 1;
+=09}
+
+=09return 0;
 }
=20
 static const struct dm_serial_ops msm_serial_ops =3D {
@@ -156,8 +254,12 @@ static void uart_dm_init(struct msm_serial_data *priv)
 =09writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 =09writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
=20
-=09/* Enable single character mode */
-=09writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
+=09if (priv->single_char)
+=09=09/* Enable single character mode */
+=09=09writel(UARTDM_DMEN_TXRX_SC_ENABLE, priv->base + UARTDM_DMEN);
+=09else
+=09=09/* Make sure BAM/single character mode is disabled */
+=09=09writel(0x0, priv->base + UARTDM_DMEN);
=20
 =09writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
 =09writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
@@ -200,6 +302,8 @@ static int msm_serial_of_to_plat(struct udevice *dev)
 =09if (priv->base =3D=3D FDT_ADDR_T_NONE)
 =09=09return -EINVAL;
=20
+=09priv->single_char =3D device_is_compatible(dev, "qcom,msm-uartdm-v1.4")=
;
+
 =09ret =3D dev_read_u32(dev, "clock-frequency", &priv->clk_rate);
 =09if (ret < 0) {
 =09=09log_debug("No clock frequency specified, using default rate\n");
@@ -211,7 +315,7 @@ static int msm_serial_of_to_plat(struct udevice *dev)
 }
=20
 static const struct udevice_id msm_serial_ids[] =3D {
-=09{ .compatible =3D "qcom,msm-uartdm-v1.4" },
+=09{ .compatible =3D "qcom,msm-uartdm" },
 =09{ }
 };
=20
@@ -254,10 +358,14 @@ static inline void _debug_uart_putc(int ch)
 {
 =09struct msm_serial_data *priv =3D &init_serial_data;
=20
-=09while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_READY))
+=09while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
+=09       !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
 =09=09;
=20
-=09writel(ch, priv->base + UARTDM_TF);
+=09writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
+
+=09writel(1, priv->base + UARTDM_NCF_TX);
+=09writel(ch, priv->base + MSM_UART_TF_RF);
 }
=20
 DEBUG_UART_FUNCS

--=20
2.54.0


