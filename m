Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628B6C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DB281E02;
	Wed, 19 Mar 2025 16:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="H1f6ayDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70C981E47; Wed, 19 Mar 2025 16:45:38 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0C781A0C
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail; t=1742399134; x=1742658334;
 bh=hWMVFnWYKhVq6rPodugJxN86vU+4RzAg/rquiYw8nsU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=H1f6ayDWB5Axf2vAn4Vm7Pv1uI7vN0H/cz0MCfNoASyzAv7DV2xH9oU+wXTpuA1b6
 RuYqMCLRyIgBDbmRrpPKzEhK/v7hsTB06k81yqxtN+OdpKjlokq2JnsqBScgnAkju/
 RLvtdTLwJEE1Fa9f0MFNi/WuHdSh+DiTq3QSfiLFA5Lv3r+EpJt+CfhoAcXgtQ17rh
 lIHig7eK/fKrqGUd6AJYga1TuX1tgver4NdyaUUynpU9rSOFVynIwjYlKWEYyQa7sl
 JP9n+qF/t8V+6K+dUdM2Q1bWi+QmJFKTbTSpeuDG1vI24RPcOas5M1wRs0XgGoZDuq
 ZQw0EN+B9Fi2A==
Date: Wed, 19 Mar 2025 15:45:29 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH] clk/qcom: sdm845: add missing USB3 clocks
Message-ID: <20250319-sdm845-usb-clocks-v1-1-ddea854f62ec@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 28a0e11381ad331ce44b12bae1b5e5daa52ff5d4
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

These are necessary for USB gadget to come up properly, now that
qcom_gate_clk_en fails on unknown clocks.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm84=
5.c
index adffb0cb2402a6b27e0e998af2f121c519301820..1b85b05632fe1100a6ad60dbd43=
0272d8ae1e77a 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -77,7 +77,9 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong r=
ate)
 }
=20
 static const struct gate_clk sdm845_clks[] =3D {
+=09GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,=09=090x8201c, 0x00000001),
 =09GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,=09=090x82020, 0x00000001),
+=09GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,=09=090x0502c, 0x00000001),
 =09GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,=09=090x05030, 0x00000001),
 =09GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,=09=090x5200c, 0x00000400),
 =09GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,=09=090x5200c, 0x00000800),

---
base-commit: 69fb899133b6c374eff11b13482371bec6898a01
change-id: 20250319-sdm845-usb-clocks-9b794fd89522

Best regards,
--=20
Sam Day <me@samcday.com>


