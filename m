Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E70C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A28D8852D;
	Mon, 24 Jun 2024 14:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="o3JYh8H3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9048837A; Mon, 24 Jun 2024 14:40:16 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1562988137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719232814; bh=XpgCxsLjzZZx9lAL1X0kdCchmOWRcXFmmWvazs6O+zM=;
 h=Date:From:To:Cc:Subject:From;
 b=o3JYh8H3RaIlv72JAvt5vR54TJmk6e7M7NMY3z4gDGppGg8OEd2u1xweNU8KjaS0W
 botpg4kE48c6tfMbx7sFy8RcEh5vZRxEpegbi4NRwHdHiEGBra9hCY9Y4H0+8T8KEa
 NlWAH1ZuFCGeTmcmZ0I3l/b5ErSwNy/PCQsUwmu6+qdsbxgftaTC9S92QR2EXlr/kh
 ph9Hh8SQXCt72T7H7jZQdflaiMeBVsfBJKyD8z+Pa4Stm0pZ6XZ2e2VwV+CpenKnsd
 wMOx4EVwcD2n26DiauF0DgzxCGGjonznOtPu4txd0K8jiK+VtKfKNyO3BWz2xw+Aga
 Hq6pmrh6s/F2w==
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id BCC94402C2;
 Mon, 24 Jun 2024 14:40:14 +0200 (CEST)
Received: from mailhost.u-ga.fr (mailhost2.u-ga.fr [129.88.177.242])
 by mailhub.u-ga.fr (Postfix) with ESMTP id B8CAD100053;
 Mon, 24 Jun 2024 14:40:14 +0200 (CEST)
Received: from zm-mbx1.u-ga.fr (zm-mbx1.u-ga.fr [152.77.200.25])
 by mailhost.u-ga.fr (Postfix) with ESMTP id 9BC046006F;
 Mon, 24 Jun 2024 14:40:14 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:40:14 +0200 (CEST)
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
Message-ID: <1978999632.15003049.1719232814587.JavaMail.zimbra@univ-grenoble-alpes.fr>
Subject: [PATCH 1/3] net: give a different name to rtl8169 interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [129.88.53.250]
X-Mailer: Zimbra 10.0.8_GA_4611 (ZimbraWebClient - FF102
 (Linux)/10.0.8_GA_4611)
Thread-Index: HI29SiIfIDW7O0WwaHPk4KwLK/Cvuw==
Thread-Topic: give a different name to rtl8169 interfaces
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

This commit implements the .bind member function,
and gives a different name to interfaces:
"RTL8169#0", "RTL8169#1", etc.

This was tested on a FriendlyElec Nanopi R5C board,
which has two RTL-8125B interfaces managed by this
driver. Since they were given the same name, it
was previously not possible to select the 2nd one
using ethact or ethprime environment variables.

Signed-off-by: Etienne Dubl=C3=A9 <etienne.duble@imag.fr>
---

 drivers/net/rtl8169.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index 93e83661ce..b30d51731f 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -1091,6 +1091,16 @@ static int rtl8169_eth_probe(struct udevice *dev)
 =09return 0;
 }
=20
+static int rtl8169_eth_bind(struct udevice *dev)
+{
+=09static int card_number;
+=09char name[16];
+
+=09sprintf(name, "RTL8169#%u", card_number++);
+
+=09return device_set_name(dev, name);
+}
+
 static const struct eth_ops rtl8169_eth_ops =3D {
 =09.start=09=3D rtl8169_eth_start,
 =09.send=09=3D rtl8169_eth_send,
@@ -1108,6 +1118,7 @@ U_BOOT_DRIVER(eth_rtl8169) =3D {
 =09.name=09=3D "eth_rtl8169",
 =09.id=09=3D UCLASS_ETH,
 =09.of_match =3D rtl8169_eth_ids,
+=09.bind=09=3D rtl8169_eth_bind,
 =09.probe=09=3D rtl8169_eth_probe,
 =09.ops=09=3D &rtl8169_eth_ops,
 =09.priv_auto=09=3D sizeof(struct rtl8169_private),
--=20
2.34.1
