Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCF0C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A850B883A9;
	Mon, 24 Jun 2024 14:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="xBHD/lGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6878E8837A; Mon, 24 Jun 2024 14:40:30 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904F188137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:40:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719232828; bh=VD4zS4vLM2AANRmBvpCm2cdV3RAzqDRgjQiAizgGN6M=;
 h=Date:From:To:Cc:Subject:From;
 b=xBHD/lGYg3zd69j1YiJs6OPpMwOn2e1iEkXkW4Yn7w+pTdlNVyYydFk9oa8FaRo5C
 eyBD7Kzyxd8ud0AQXj47hogGJGCnUsWZYpOLXdNbUJvwSxpOtkCrJWRY/usSqeyIl6
 QbcgUsj4uE+OfS4jGjHDdzzdceJuuLoEq4nYjEkzbPx8BNVJ2jQuOps76+yoHVPmDD
 DMM4rv2WDLAToEZrLlVrF6fwRQfcU5tD0Ta2jfm7oIiPdOaHx0JNrW8xX1hTCbCOTB
 RINLxQaIClMLfl+EFS9gt3RI3785h2YubzzcUVwjdjUGAcaDVjth9hrwEJE115COIv
 54sL83HAqw/Ww==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 46BA6402E8;
 Mon, 24 Jun 2024 14:40:28 +0200 (CEST)
Received: from mailhost.u-ga.fr (mailhost2.u-ga.fr [129.88.177.242])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 42A90100068;
 Mon, 24 Jun 2024 14:40:28 +0200 (CEST)
Received: from zm-mbx1.u-ga.fr (zm-mbx1.u-ga.fr [152.77.200.25])
 by mailhost.u-ga.fr (Postfix) with ESMTP id 254646006F;
 Mon, 24 Jun 2024 14:40:28 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:40:28 +0200 (CEST)
From: ETIENNE DUBLE <etienne.duble@imag.fr>
To: Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
Cc: ETIENNE DUBLE <etienne.duble@imag.fr>, 
 joe hershberger <joe.hershberger@ni.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot <u-boot@lists.denx.de>
Message-ID: <1506177052.15003206.1719232828107.JavaMail.zimbra@univ-grenoble-alpes.fr>
Subject: [PATCH 2/3] rockchip: fix wrong PCI range address in rk3568 dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [129.88.53.250]
X-Mailer: Zimbra 10.0.8_GA_4611 (ZimbraWebClient - FF102
 (Linux)/10.0.8_GA_4611)
Thread-Index: gsCTMu6Dd5jYg2yKhz8AMJXZz7CMPw==
Thread-Topic: rockchip: fix wrong PCI range address in rk3568 dtsi
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 152.77.200.25
X-Mailman-Approved-At: Mon, 24 Jun 2024 14:52:21 +0200
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

One of the PCI ranges was wrong in this device tree.
When testing with a FriendlyElec Nanopi R5C board, the
2nd ethernet interface (labelled "wan") was not working
in u-boot because of that.

With the correct value (found in FriendlyElec's downstream
u-boot repository), this 2nd ethernet interface now works.

Signed-off-by: Etienne Dubl=C3=A9 <etienne.duble@imag.fr>
---

 dts/upstream/src/arm64/rockchip/rk3568.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3568.dtsi b/dts/upstream/src=
/arm64/rockchip/rk3568.dtsi
index f1be76a54c..06aac034ca 100644
--- a/dts/upstream/src/arm64/rockchip/rk3568.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3568.dtsi
@@ -150,7 +150,7 @@
 =09=09      <0x0 0xf0000000 0x0 0x00100000>;
 =09=09ranges =3D <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>=
,
 =09=09=09 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
-=09=09=09 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
+=09=09=09 <0x03000000 0x0 0x80000000 0x3 0x80000000 0x0 0x40000000>;
 =09=09reg-names =3D "dbi", "apb", "config";
 =09=09resets =3D <&cru SRST_PCIE30X2_POWERUP>;
 =09=09reset-names =3D "pipe";
--=20
2.34.1
