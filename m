Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366FFC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 12:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E5588477;
	Mon, 24 Jun 2024 14:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imag.fr header.i=@imag.fr header.b="rkFLWXfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8917F8837A; Mon, 24 Jun 2024 14:40:36 +0200 (CEST)
Received: from zm-mta-out-3.u-ga.fr (zm-mta-out-3.u-ga.fr [152.77.200.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0AD88137
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 14:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=imag.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=etienne.duble@imag.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imag.fr; s=2022;
 t=1719232834; bh=Trh1vYljCGBfeLzUnxCPUpeh1nNFpdNu3cuxPlZl/z8=;
 h=Date:From:To:Cc:Subject:From;
 b=rkFLWXfeRnpuJJ/DEPXrTZ3GBXq0XeTmVoliD46s+7Tphv//wJGCO3Wp937eMlk7N
 9Tb8m6cW4VMWmlKR8TqjEBiKKrp0jIelOB8+9nhkwkN6gRNO9KK8haKHqcWl+NywoS
 vsgrcTeIYOt3n5o6d04RBBEldBVZkA7BAZ1gxI2BIcp+CSqFUkzHAtOMmyUQwB57oW
 hX76cyZEHSQV3eUV2gQ7MUabyXBEsTRE3Ph5iqdQu5Q+BfwlC3wRAjM5TM1U07nTHY
 wpR5IXbeqqo4CWAksxa/ijDtODesZeMhDmkdF/gTQHS0Oc73ZNqdW+QxRFzDGgY77+
 Wq32RrSJBcf5Q==
Received: from mailhub.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 6296E402E8;
 Mon, 24 Jun 2024 14:40:34 +0200 (CEST)
Received: from mailhost.u-ga.fr (mailhost2.u-ga.fr [129.88.177.242])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 5F6A1100068;
 Mon, 24 Jun 2024 14:40:34 +0200 (CEST)
Received: from zm-mbx1.u-ga.fr (zm-mbx1.u-ga.fr [152.77.200.25])
 by mailhost.u-ga.fr (Postfix) with ESMTP id 43E706006F;
 Mon, 24 Jun 2024 14:40:34 +0200 (CEST)
Date: Mon, 24 Jun 2024 14:40:34 +0200 (CEST)
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
Message-ID: <1097774847.15003262.1719232834237.JavaMail.zimbra@univ-grenoble-alpes.fr>
Subject: [PATCH 3/3] net: RTL-8125B -- write mac to MAC0_BKP
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [129.88.53.250]
X-Mailer: Zimbra 10.0.8_GA_4611 (ZimbraWebClient - FF102
 (Linux)/10.0.8_GA_4611)
Thread-Index: qdRVx/O8xTvENFyyHgIYL9coeK7rzQ==
Thread-Topic: RTL-8125B -- write mac to MAC0_BKP
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

In the case of RTL-8125B, Linux reads the mac address
from register MAC0_BKP instead of MAC0, so let u-boot
write the mac address there.

Note: writing to MAC0 is still needed too, because this
register is used by the hardware for mac filtering (the
board will not receive packets if MAC0 is not set).

Tested on a FriendlyElec Nanopi R5C board.

Signed-off-by: Etienne Dubl=C3=A9 <etienne.duble@imag.fr>

---

 drivers/net/rtl8169.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/rtl8169.c b/drivers/net/rtl8169.c
index b30d51731f..7c4d658c6b 100644
--- a/drivers/net/rtl8169.c
+++ b/drivers/net/rtl8169.c
@@ -153,6 +153,7 @@ enum RTL8125_registers {
 =09IntrMask_8125 =3D 0x38,
 =09IntrStatus_8125 =3D 0x3C,
 =09TxPoll_8125 =3D 0x90,
+=09MAC0_BKP =3D 0x19e0,
 };
=20
 enum RTL8169_register_content {
@@ -881,6 +882,7 @@ void rtl8169_eth_stop(struct udevice *dev)
 static int rtl8169_write_hwaddr(struct udevice *dev)
 {
 =09struct eth_pdata *plat =3D dev_get_plat(dev);
+=09struct pci_child_plat *pplat =3D dev_get_parent_plat(dev);
 =09unsigned int i;
=20
 =09RTL_W8(Cfg9346, Cfg9346_Unlock);
@@ -888,6 +890,19 @@ static int rtl8169_write_hwaddr(struct udevice *dev)
 =09for (i =3D 0; i < MAC_ADDR_LEN; i++)
 =09=09RTL_W8(MAC0 + i, plat->enetaddr[i]);
=20
+=09/*
+=09 * In the case of RTL8125, linux is reading the mac
+=09 * address from register MAC0_BKP instead of MAC0,
+=09 * so let's copy it there.
+=09 * Note: we still need to write the mac to MAC0 too
+=09 * (cf. the loop above) because the hardware uses MAC0
+=09 * for mac filtering.
+=09 */
+=09if (pplat->device =3D=3D 0x8125) {
+=09=09for (i =3D 0; i < MAC_ADDR_LEN; i++)
+=09=09=09RTL_W8(MAC0_BKP + i, plat->enetaddr[i]);
+=09}
+
 =09RTL_W8(Cfg9346, Cfg9346_Lock);
=20
 =09return 0;
--=20
2.34.1
