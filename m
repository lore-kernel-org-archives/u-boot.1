Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAA2CD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 00:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1187D839A8;
	Fri, 12 Jun 2026 02:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="GCUU6gOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1BE84704; Fri, 12 Jun 2026 02:33:57 +0200 (CEST)
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch
 [79.135.106.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46F5838BB
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 02:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1781224434; x=1781483634;
 bh=Cw5X8jnCOSA0AgMLhFXswGerHCM4FO5Epg3HzwcoPZU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GCUU6gOhIw42vngktBtcCQYAE0O41QeMTlP4GcZbWQRTcLvBbHaDvdxkUiu0hntyY
 57UD3cvr0HsmeFSPUNTc9F/aHYNz11YcK33nkPVawT6zFXTDSnftS0qTUj0qqBSm5s
 1dM6/wXoLfdw/KruIUkwV7riPZtODU4eLC33xlAKZqRMwsmctgQZjck999n0B8Od6k
 UKPERcZ9CzohMWXvShmQMhhaovBGKwhJ+RwB47VDSwLM2m6VwJTVlRc9/rf+zdz/yJ
 O0/3ADhmiq63CwP6htXEaq2PsYPND8z80yBK1YWUDaV3c9H3ySqYz9Zo5G/SjGyDR+
 BfPHIBvNfk/rQ==
Date: Fri, 12 Jun 2026 00:33:49 +0000
To: u-boot@lists.denx.de
From: anoduck@protonmail.com
Cc: anoduck <9925396+anoduck@users.noreply.github.com>
Subject: [PATCH 1/2] feat(created-dts-for-pinetab-v): Created template for
 pinetab-v
Message-ID: <20260612003330.220595-1-anoduck@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: adf0a377299642712e1099ede46c5cb090823bd1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Jun 2026 02:48:57 +0200
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

From: anoduck <9925396+anoduck@users.noreply.github.com>

---
 ...jh7110-starfive-visionfive-2-pinetab-v.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-starfive-visionf=
ive-2-pinetab-v.dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-p=
inetab-v.dts b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2=
-pinetab-v.dts
new file mode 100644
index 00000000000..d7ef053a83a
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-=
v.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
+ */
+
+/dts-v1/;
+#include "jh7110-starfive-visionfive-2.dtsi"
+
+/ {
+=09model =3D "Pine64 Pinetab-V";
+=09compatible =3D "pine64,pinetab-v", "starfive,jh7110";
+};
+
+// &sd-vcc {
+//         compatible =3D "regulator-fixed";
+//         regulator-name =3D "sd_vcc";
+//         regulator-min-microvolt =3D <3300000>;
+//         regulator-max-microvolt =3D <3300000>;
+//         gpio =3D <&sysgpio 35 GPIO_ACTIVE_LOW>;
+//         enable-active-low;
+//         regulator-boot-on;
+//         regulator-always-on;
+// };
--=20
2.53.0


