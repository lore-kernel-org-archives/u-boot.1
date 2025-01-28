Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FDCC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 21:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D45F81E8C;
	Tue, 28 Jan 2025 22:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="pdtto6bE";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="rekCCOP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844E581EC9; Tue, 28 Jan 2025 22:39:24 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AD481ECA
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 22:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=pdtto6bEejLjIbyWHRMVR5f18C6HmQiwcmPTvVaTmMDl5ncGPMQ/V37FtCPS5lRQ2h1X4qOlglf1ZRuOipSO78jedgfEKFv6LG/JT6gucc/DoGFOmOgD4lBIcmdrGMRhdrkiFZluphpoPuCsqsZTGGyWbhkThYH/HN9VHsCumdGMJueUVf/ECvDhuFtIO0jIbxfPuLwS5jMQmvtBCb+4LXiKZmaiphEc9hDNDa2zor+zGqtCjeBOWIoQ84G/1CZ531OVrBmaJHaLuggy+A952OQJzbaNX+axwQ5wo5PUKEyCTnIENiNbH2L9vAihi5fkLgxo5nNwREQWm+vriLlOEg==;
 s=purelymail1; d=tidylabs.net; v=1;
 bh=uWeE0E+vvpN6nx9/+bSsnULbD2sbITjIZ7Kk8uiA234=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=rekCCOP6p025Wc2q0MYQ0YQ/j1TTbyu6ACUxpZXXz9QaGXopAUbbfHQnEaqTbHQr5a4qmIv9eXaD6zcB8jBAdEQPZgrGTbaHqRor6vchQWBJrJZb31M1g1zxYqtCEDv579EaOeVCIPCqZtxyE55BMpkG8SRVw/Yi39O/BeC2By8jvk8XoQlD8xkr/xJpYgiCqMZKz/23j0w8/vw2S9xD2J+/Idv5ob+XQyyOEE1jYZMT6fGx45wKKDKKQBoeowhZadDlpF7R0kl9Xgis+BM/SusL0S2HOW6fXBh40QjezLKAwwZU3RBD3PkU2uLA6JIYDAT75hk6pdUAbLj5o1zHBQ==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=uWeE0E+vvpN6nx9/+bSsnULbD2sbITjIZ7Kk8uiA234=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -499528210; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 28 Jan 2025 21:39:20 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/5] rockchip: io-domain: Add debug logging for regulators
 during probe
Date: Tue, 28 Jan 2025 21:37:33 +0000
Message-ID: <20250128213852.465664-2-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250128213852.465664-1-justin@tidylabs.net>
References: <20250128213852.465664-1-justin@tidylabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

Log the value of the regulators during initialization of the IO-domain
driver to aid in debugging GPIO voltage configuration problems.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
---

Changes in v2:
- Made added IO-domain driver logs verbose and consistent

 drivers/misc/rockchip-io-domain.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-d=
omain.c
index 025b6049a9f..fdefc9c5fe3 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -5,6 +5,8 @@
  * Ported from linux drivers/soc/rockchip/io-domain.c
  */
=20
+#define LOG_CATEGORY UCLASS_NOP
+
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <regmap.h>
@@ -344,8 +346,10 @@ static int rockchip_iodomain_probe(struct udevice *dev=
)
 =09=09=09continue;
=20
 =09=09ret =3D device_get_supply_regulator(dev, supply_name, &reg);
-=09=09if (ret)
+=09=09if (ret) {
+=09=09=09log_debug("%s: Regulator not found\n", supply_name);
 =09=09=09continue;
+=09=09}
=20
 =09=09ret =3D regulator_autoset(reg);
 =09=09if (ret && ret !=3D -EALREADY && ret !=3D -EMEDIUMTYPE &&
@@ -353,6 +357,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
 =09=09=09continue;
=20
 =09=09uV =3D regulator_get_value(reg);
+=09=09log_debug("%s: Regulator %s at %d uV\n", supply_name, reg->name, uV)=
;
 =09=09if (uV <=3D 0)
 =09=09=09continue;
=20
--=20
2.45.3

