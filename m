Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C71C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 07:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379A080842;
	Wed, 12 Feb 2025 08:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="aEwtgTVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8CB80C8F; Wed, 12 Feb 2025 08:02:14 +0100 (CET)
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch
 [79.135.106.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87E380824
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 08:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1739343731; x=1739602931;
 bh=WdUsSv0Ci3vxm20r/XJarC6Xa5TOD8aXxZUDHg6tPFg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=aEwtgTVes/IcJ0pcBt9LYyFFdi87PZQBIF361cigDRTJ1Ch4imyoXLer9DYMQ6XQC
 /vYDfNvqLbdcm7Iq80qxTJIIEVt5/WavoJKPZiaXCeMJNsZdiT9mNWUl6YkItyfPeZ
 9GwpZSfbxiwQKM/S9nlY6OHXvAvXxTX0/j3fZ3bp8wvQyZQ7rId3ZYEvmfs/MRwvQ6
 4XzSzDqKBIBIIbjsSeJin9cElg7JoVEY/EbA+QWxiGT8Z/kss4FtbLcEaQd8N29sub
 Rtk8ce//CSa4ypGlWVKOgcsJstNzyOWfMCtDQHigb1ROkAgkccLyXYjb++xyrbCePz
 ko9jcyBxUst+A==
Date: Wed, 12 Feb 2025 07:01:55 +0000
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
From: Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Sam Day <me@samcday.com>
Subject: [PATCH v2 5/5] rng: msm: keep core clock disabled when PRNG not in use
Message-ID: <20250212-msm-rng-fixes-v2-5-645cf8d3fd3c@samcday.com>
In-Reply-To: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
References: <20250212-msm-rng-fixes-v2-0-645cf8d3fd3c@samcday.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 77f026d8aac25f5c20636fbd9324eb59cb7b90fc
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
2.48.1


