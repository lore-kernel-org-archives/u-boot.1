Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C2FC0218C
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 07:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DCB0811AC;
	Mon, 27 Jan 2025 08:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="wRfMXwGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E4F80FC4; Mon, 27 Jan 2025 08:49:28 +0100 (CET)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F9180FF7
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1737964166; x=1738223366;
 bh=VEP5MLlcSXw63SbVSNQhEGcswvlRjNHnrd/l4Jo2jns=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=wRfMXwGLpN13ma6P6DajtBb69Q/a0AgNT0y2ysb4kZOZPY8ngnfYL8gNxT2qN6X8L
 +wpAKUnl7YMse8HoyPGeh0BbB5SIt/yyNiAG/1arCTggzidlvtFi0cEzMjDpYFyFDL
 4cpSG30CCw5ChdhnCrQ8t4Jy2ggCaxU7wwN2hQt3DtBxl16J70fd3+bY+ASmbMs08j
 /N9dWJ0TGl+6QEv1u0zK5JASo4cNLKiTQ9eP1r9NDe84nU0Vr5VmLTw3AyYDg2BjYS
 UoE5mRj1U1FxtTg1ln84Udeq/w5RJpKnmB91lcop9VQ0rJTlfzyEeYzt2jEY+Z+wvV
 LT4ImJZPNZ0eg==
Date: Mon, 27 Jan 2025 07:49:20 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH 4/4] rng: msm: keep core clock disabled when PRNG not in use
Message-ID: <20250127-msm-rng-fixes-v1-4-00f5d2284314@samcday.com>
In-Reply-To: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 091d8121f6a52202684b1bdb37367fb83751717c
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

This is how the kernel does it. APQ8016E TRM also states that this clock
can be turned off when no random numbers are needed.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/rng/msm_rng.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
index 01505509103f28f7c91dd47edb83c23359163c82..aab602c5ed0bfed8b7cb9593fe2=
2a8cef8f0f61a 100644
--- a/drivers/rng/msm_rng.c
+++ b/drivers/rng/msm_rng.c
@@ -44,6 +44,11 @@ static int msm_rng_read(struct udevice *dev, void *data,=
 size_t len)
 =09u32 *retdata =3D data;
 =09size_t maxsize;
 =09u32 val;
+=09int ret;
+
+=09ret =3D clk_enable(&priv->clk);
+=09if (ret < 0)
+=09=09return ret;
=20
 =09/* calculate max size bytes to transfer back to caller */
 =09maxsize =3D min_t(size_t, MAX_HW_FIFO_SIZE, len);
@@ -66,6 +71,8 @@ static int msm_rng_read(struct udevice *dev, void *data, =
size_t len)
 =09=09=09break;
 =09} while (currsize < maxsize);
=20
+=09clk_disable(&priv->clk);
+
 =09return 0;
 }
=20
@@ -118,7 +125,9 @@ static int msm_rng_probe(struct udevice *dev)
 =09if (ret < 0)
 =09=09return ret;
=20
-=09return msm_rng_enable(priv, 1);
+=09ret =3D msm_rng_enable(priv, 1);
+=09clk_disable(&priv->clk);
+=09return ret;
 }
=20
 static int msm_rng_remove(struct udevice *dev)

--=20
2.47.1


