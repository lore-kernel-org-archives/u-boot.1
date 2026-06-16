Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199BCCD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 13:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D5884704;
	Tue, 16 Jun 2026 15:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="smtnIIej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC788848A6; Tue, 16 Jun 2026 15:23:08 +0200 (CEST)
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5CFA846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 15:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1781616186; x=1781875386;
 bh=St5V/Kzbqj8o3oKPPpuAORv9T5gQ0+0d6djgQqACxBY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=smtnIIejNbLID4QOVPLEmv/LsAoPaqKbLvWg5rD9Mz2W9k37MAQ+v/Rf8mXtruzrb
 95j+KAMm6WI40AM/oM9QM4m2iiIWATZwHVOvEfLlN1+WFn0kjnj+RlpPWEVuKeNSea
 2PJC6yBQt06FZs8F4Ypg8T1UxTAKiLtuq3KfF8BUV1u4Smde++Buevi1DM4KThxmfE
 lhozxLGRFdG6BpKTjrFHDUSo+Lj+1kxigCo2NrIy3wvdUBJULGs0IfcQ8x8l3LnyGl
 9HR4qoAzK7axqpQUOCawBXm2rUk7chwIbxqT6RnZc7ctkJYY6dWych9V9PaSBOPvMW
 qKrOfH1OI5Wvg==
Date: Tue, 16 Jun 2026 13:21:23 +0000
To: u-boot@lists.denx.de
From: anoduck@protonmail.com
Cc: e@freeshell.de, anoduck <anoduck@protonmail.com>
Subject: RFC: [PATCH] PinetabV device tree file
Message-ID: <20260616131946.404766-1-anoduck@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: a2da9db6b13ac429f0ad98c1cef0fc68f6720005
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

From: anoduck <anoduck@protonmail.com>

---
 .../src/riscv/starfive/jh7110-pine64-pinetabv.dts   | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.=
dts

diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts b/d=
ts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
new file mode 100644
index 00000000000..068a7e995b2
--- /dev/null
+++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-pinetabv.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2026 T Anoduck <anoduck@protonmail.com>
+ * Through the Graces of: E Shattow <e@freeshell.de>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+=09model =3D "Pine64 PinetabV";
+=09compatible =3D "pine64,pinetabv", "starfive,jh7110";
+};
--
2.53.0

