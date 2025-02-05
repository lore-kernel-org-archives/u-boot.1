Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09CDC02199
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B972F807E1;
	Wed,  5 Feb 2025 18:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="D5ZcNTYr";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="gXeEzR3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1336807E1; Wed,  5 Feb 2025 18:18:37 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0CA80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=D5ZcNTYr1vpiQpVO+v/xTKrqPaw+UtZUEsXLbCKgLK3QIwuzEMl9PRG406nEd2qda39WLTw8QYdnpAdeaoFoip67I4DNbEftqAJTih4Ik0fz95u70i8MTP23tjc5Y8e2Tam0iqxDdeVA2TGafj9yflR85IJd+C1YQjSgDnCKDzFmSl/NN0uhDdbzkC7o63fDouNvHNUPR5U9IzCY4vHjQCjBLSA2c70r4bBRlqa5PxRfOUTxpCcDkJFG1BZyzUgWtmSb60Bs2KFUeNml7iZ/T8WJ4nTvEx4D1mDWFDD+bKMJq8UYxLrRQNVZLVDpjaxtWvIBG362ToQ8asPERr18+w==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=RfxYG6x3XvrqTgW1KrVfOvz45K5SLchmp/ZxZsyg09A=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=gXeEzR3jBrXuotckMXx/GuhUCvahO0Hz/kWNfO7l9sRm8jnWYgVNIw9mgTRvZ9AjE+DDPdbKtgHGilhFJnDyBqVathElZ+5uzxmPdnhJzGquZagEFtcOGSa4aEoBTx214vq+l8LNlAwkLOeupRRTU7xahYfQD+R27spipTHx0AMFbIz8QayLJ86ycmuUUM1ThgV2gi1j0exMFPoVuWVBfQyZI/Z5ZoYCFc5Y9jxRZAkmfMpV98D4eq7EQiGHtPCxW4HI0h5Wh83ETtNg/0LdSZQgozYR2+VpikY/snoi8J8qVz1m0ixH3nuImnc0GaHhdh+/6W297DUg7Nva/jzduw==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=RfxYG6x3XvrqTgW1KrVfOvz45K5SLchmp/ZxZsyg09A=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:33 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/5] rockchip: io-domain: Add debug logging for regulators
 during probe
Date: Wed,  5 Feb 2025 17:16:11 +0000
Message-ID: <20250205171634.826560-2-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250205171634.826560-1-justin@tidylabs.net>
References: <20250205171634.826560-1-justin@tidylabs.net>
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

Changes in v3:
- Use dev_dbg instead of log_debug

Changes in v2:
- Made added IO-domain driver logs verbose and consistent

 drivers/misc/rockchip-io-domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/rockchip-io-d=
omain.c
index 025b6049a9f..a0573c52193 100644
--- a/drivers/misc/rockchip-io-domain.c
+++ b/drivers/misc/rockchip-io-domain.c
@@ -344,8 +344,10 @@ static int rockchip_iodomain_probe(struct udevice *dev=
)
 =09=09=09continue;
=20
 =09=09ret =3D device_get_supply_regulator(dev, supply_name, &reg);
-=09=09if (ret)
+=09=09if (ret) {
+=09=09=09dev_dbg(dev, "%s: Regulator not found\n", supply_name);
 =09=09=09continue;
+=09=09}
=20
 =09=09ret =3D regulator_autoset(reg);
 =09=09if (ret && ret !=3D -EALREADY && ret !=3D -EMEDIUMTYPE &&
@@ -353,6 +355,7 @@ static int rockchip_iodomain_probe(struct udevice *dev)
 =09=09=09continue;
=20
 =09=09uV =3D regulator_get_value(reg);
+=09=09dev_dbg(dev, "%s: Regulator %s at %d uV\n", supply_name, reg->name, =
uV);
 =09=09if (uV <=3D 0)
 =09=09=09continue;
=20
--=20
2.45.3

