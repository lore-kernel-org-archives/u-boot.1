Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B62C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FED88D00;
	Thu,  2 May 2024 15:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="CqRCWEe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5BC88378; Thu,  2 May 2024 15:17:08 +0200 (CEST)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA9788361
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1714655826; x=1714915026;
 bh=mdAk5izBOY//fJ4gA5Fsm8JLte41MXOgZ6EHx/UHDvo=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=CqRCWEe1GFHEZiICtTSA7hxVpx4vZer8dywvLtwZzgRjB6nJo/i/nTHHA/KNCDPyE
 Oq/FaM6Npk/kXTCErMD1CSCR2YExZ5S/AHqpMBJI08IXhquv3zTdLpq0YUHmlbciIZ
 3o8LRqMhYVBt0Al45i6GQZL00vvbWWnJ9nKfmwU9tHpXkI9h0k8Azi1cfGsl/nYhwc
 9+YZdziw1F3WwAjOUPBWMZWSyycJaN9LIhUD4ccKwwR+L2peWwdS7Hxx9Mlv8LhwET
 Hy9kG4VjNsThuwEs7bhJlviXYxFH6FCHvhgSzT8w/KgzvhJAVUahMw0tKJ0LgTTSJI
 qmf42b7Nvcidg==
Date: Thu, 02 May 2024 13:16:52 +0000
To: u-boot@lists.denx.de
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Sam Day <me@samcday.com>
Subject: [PATCH 1/2] clk/qcom: apq8016: add support for USB_HS clocks
Message-ID: <20240502-msm8916-hs-usb-clocks-v1-1-eeccf483b68d@samcday.com>
In-Reply-To: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
References: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: a382db0c1549b186093a3790eb84841eec136301
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 02 May 2024 15:18:08 +0200
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

Some groundwork was also laid to dump the state of these gate clocks
with the recently-added qcom dump callbacks.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index d3b63b9c1a..745371a289 100644
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
@@ -39,6 +41,11 @@
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
=20
+static const struct freq_tbl ftbl_gcc_usb_hs_system_clk[] =3D {
+=09F(80000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),
+=09{ }
+};
+
 static struct pll_vote_clk gpll0_vote_clk =3D {
 =09.status =3D GPLL0_STATUS,
 =09.status_bit =3D GPLL0_STATUS_ACTIVE,
@@ -52,6 +59,11 @@ static struct vote_clk gcc_blsp1_ahb_clk =3D {
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
@@ -106,6 +118,7 @@ int apq8016_clk_init_uart(phys_addr_t base, unsigned lo=
ng id)
=20
 static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 {
+=09const struct freq_tbl *freq;
 =09struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
=20
 =09switch (clk->id) {
@@ -117,13 +130,31 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ul=
ong rate)
 =09case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
 =09=09apq8016_clk_init_uart(priv->base, clk->id);
 =09=09return 7372800;
+=09case GCC_USB_HS_SYSTEM_CLK:
+=09=09freq =3D qcom_find_freq(ftbl_gcc_usb_hs_system_clk, rate);
+=09=09clk_rcg_set_rate_mnd(priv->base, USB_HS_SYSTEM_CLK_CMD_RCGR,
+=09=09                     freq->pre_div, freq->m, freq->n, freq->src, 0);
+=09=09return freq->freq;
 =09default:
 =09=09return 0;
 =09}
 }
=20
+static int apq8016_clk_enable(struct clk *clk)
+{
+=09struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
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


