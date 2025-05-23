Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79EDC54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 16:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B168334D;
	Fri, 23 May 2025 18:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="hhvA3Qwv";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="a4KcZN/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A7583278; Fri, 23 May 2025 18:55:09 +0200 (CEST)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1815583340
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 18:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=hhvA3QwvnUVUcBsG3Y8wgcwL3dVLAJrnt3gannDr6kr7U13anQdqTTo9fy/TaN4GHK2bMReobyfZBtXQCZ0c3ayERHOnFBjagQQ4v6LiuC95C/HDU8QgqRpZZyQSZB+koG+oES7gCh4jDz95Z19ko72lZ0RG8FuND3W4HmeQf2kMEc/3/f8Wm3oZgG9i2THBang491jr1zQq+6bL7/AT3wqri3EaCIGxW9u4IlpcLRtncmvLiG/m4wZbFlkjH8hm47L2bRp370HrsUuFn+2uoHg2DXX9zBYDWwyPJDdvDRUWJyGO9bp2VJybLztkmZaJceuVOZSHzUgDPbL0eMsf6g==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=lRcibXSLM6tKFzb572QSPEBJ3tesGzifwk6hcH08cgk=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=a4KcZN/4NggTfNyTLKWJj+hm+vLTk2F5zcFb/snumm2kb8BkAKLbq6MkVOAf8sXIUPcHCyn/VO/9BXxWNvVj3e/WPoqGRFDEpopQ3cQZf8nsSfNOW1FSj71VkIPBwAHJ0cSYVy70tXDSHFvQroOOdesXl1TSpzss7x7yWAdSRRcEk4g+4McHykaPQFqiMY/Sn3m3c1SL2zsJ3XC0XcL0jhgh/tjn/21QE4+4qhFCA1ZvGAsLUixr4oZCWmlCQBiFIWzHbBvKUMlJNA0trgV5FOsgzYO9nuImZJBwL4hOzJJ9CQ+7g/YSI09lw51GSUaS9ut1NsAktHB81fhBqZ9U+Q==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=lRcibXSLM6tKFzb572QSPEBJ3tesGzifwk6hcH08cgk=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2127220571; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 23 May 2025 16:55:03 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/5] rockchip: io-domain: Add debug logging for regulators
 during probe
Date: Fri, 23 May 2025 16:53:37 +0000
Message-ID: <20250523165406.40915-2-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250523165406.40915-1-justin@tidylabs.net>
References: <20250523165406.40915-1-justin@tidylabs.net>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v3)

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

