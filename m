Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC30C0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDB8810FC;
	Mon, 27 Jan 2025 08:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="jbpTv/gT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6640280FF7; Mon, 27 Jan 2025 08:49:22 +0100 (CET)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1778111F
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737964157; x=1738223357;
 bh=zc6XYyu5G9kCK4ZI7E9MIoEWCI63VL7i1L9u4zf4F1Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=jbpTv/gTKHUxMp2elSvu6k6kXNSwo/LqtGQxJrvxyp9T11Yv4TaggQi8XA6tRUflq
 6wQNC+pQGwAcrh/lSgwyJkJN9e8DuL41d2TnT3XBHsSSTFSqs01fkxsfBzDYa1OWXa
 0UWUHrJRxu630Ti7xcMQ8mQpzbqd3USlT+3SCWquYAQ4QiellCDHObWqQ2UDXIGdVc
 EG6PWewzKbadUVMma+vDmFp+lGsDKDfI4lHcHkeKMGDGkBhQKLU7TcQn11Alg9JjDX
 fdotKoDV8II/TmkNyNxydsHEpHOAP6+2X8FLZiJnt4xmS1m7zJqEsoUqg7BzHYLa+/
 tEIEmnAbx1cPw==
Date: Mon, 27 Jan 2025 07:49:12 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 3/4] clk/qcom: apq8016: improve clk_enable logging
Message-ID: <20250127-msm-rng-fixes-v1-3-00f5d2284314@samcday.com>
In-Reply-To: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 115aa5f2f1fb48b307fd085de3f9334c2da32ba1
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

Properly warn when an unknown clock is requested to be enabled.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/clk/qcom/clock-apq8016.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8=
016.c
index ff5e7ca6f02148427240b80fb08efdd356934cd5..7628e7f3ca299286ddeed7eabe4=
b336e011704c5 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -140,12 +140,12 @@ static int apq8016_clk_enable(struct clk *clk)
 {
 =09struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
=20
-=09if (priv->data->num_clks < clk->id) {
+=09if (priv->data->num_clks < clk->id || !apq8016_clks[clk->id].reg) {
 =09=09log_warning("%s: unknown clk id %lu\n", __func__, clk->id);
 =09=09return 0;
 =09}
=20
-=09debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
+=09debug("%s: enabling clock %s\n", __func__, apq8016_clks[clk->id].name);
 =09qcom_gate_clk_en(priv, clk->id);
=20
 =09return 0;

--=20
2.47.1


