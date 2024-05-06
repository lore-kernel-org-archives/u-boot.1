Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4FCC10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402DF881DE;
	Mon,  6 May 2024 12:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="UjgIk+3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D3288013; Mon,  6 May 2024 12:27:02 +0200 (CEST)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE9AB880CC
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1714991218; x=1715250418;
 bh=SCVgZpM//uD9Vx3BAbE5d2B04DGMf4ODy/pg6hFd0ZQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=UjgIk+3nimnTmli4TJIqYf6EpruePjG58gOUORk/XfXC7MNHJowsoBrQWj6QGmHaM
 b3Y/BmHIHQliL0uLfFHo9yddQjRxclfFJVnyFtmyG4pulhWTe1H+9x9xznZBHKGUqp
 vbbcJ+FlIls2Q0kHGTJGZsxSjGJGjAdgDU8IwH6LVc5d/eMrWDKAEQN0Uh3NCx3SCo
 VYDAJhXd7PpNuk8ynkSfedzsYq3D8CY+XeKvxg929Uec30h6stUMSC3s4FJ13D5RHa
 tn/nyBgdFEFOCMbknnQv6ItS6NAuHKYTxXVbgo9rySvYbP8X6GVpRSn9TM+unkrWMM
 etAT9UYIKOJXw==
Date: Mon, 06 May 2024 10:26:54 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 1/2] clk/qcom: apq8016: add support for USB_HS clocks
Message-ID: <20240506-msm8916-hs-usb-clocks-v2-1-34f741b3a2ec@samcday.com>
In-Reply-To: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
References: <20240506-msm8916-hs-usb-clocks-v2-0-34f741b3a2ec@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 729e10c62820fa6eb6ed8bbbea5faea5cd509430
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

The newer "register map for simple gate clocks" support added for qcom
clocks is used. As a result gcc_apq8016 now has a mixture of the old and
new styles. I didn't (and still don't!) feel comfortable enough in this
area to update the existing code.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index d3b63b9c1a..3b8c88c769 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -17,6 +17,8 @@
=20
 #include "clock-qcom.h"
=20
+#define USB_HS_SYSTEM_CLK_CMD_RCGR=090x41010
+
 /* Clocks: (from CLK_CTL_BASE)  */
 #define GPLL0_STATUS=09=09=09(0x2101C)
 #define APCS_GPLL_ENA_VOTE=09=09(0x45000)
@@ -52,6 +54,11 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
 =09.vote_bit =3D BIT(10),
 };
=20
+static const struct gate_clk apq8016_clks[] =3D {
+=09GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
+=09GATE_CLK(GCC_USB_HS_SYSTEM_CLK,=090x41004, 0x00000001),
+};
+
 /* SDHCI */
 static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint =
rate)
 {
@@ -117,13 +124,38 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ul=
ong rate)
 =09case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
 =09=09apq8016_clk_init_uart(priv->base, clk->id);
 =09=09return 7372800;
+=09case GCC_USB_HS_SYSTEM_CLK:
+=09=09if (rate !=3D 80000000)
+=09=09=09log_warning("Unexpected rate %ld requested for USB_HS_SYSTEM_CLK\=
n",
+=09=09=09            rate);
+=09=09clk_rcg_set_rate_mnd(priv->base, USB_HS_SYSTEM_CLK_CMD_RCGR,
+=09=09                     10, 0, 0, CFG_CLK_SRC_GPLL0, 0);
+=09=09return rate;
 =09default:
 =09=09return 0;
 =09}
 }
=20
+static int apq8016_clk_enable(struct clk *clk)
+{
+=09struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
+
+=09if (priv->data->num_clks < clk->id) {
+=09=09log_warning("%s: unknown clk id %lu\n", __func__, clk->id);
+=09=09return 0;
+=09}
+
+=09debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
+=09qcom_gate_clk_en(priv, clk->id);
+
+=09return 0;
+}
+
 static struct msm_clk_data apq8016_clk_data =3D {
 =09.set_rate =3D apq8016_clk_set_rate,
+=09.clks =3D apq8016_clks,
+=09.num_clks =3D ARRAY_SIZE(apq8016_clks),
+=09.enable =3D apq8016_clk_enable,
 };
=20
 static const struct udevice_id gcc_apq8016_of_match[] =3D {

--=20
2.44.0


