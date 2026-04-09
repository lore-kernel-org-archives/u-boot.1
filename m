Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C3710FC456
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 00:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4E3841CD;
	Thu,  9 Apr 2026 02:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="hNz8sCwf";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="wBZb5ZHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E4883CF5; Thu,  9 Apr 2026 02:06:49 +0200 (CEST)
Received: from fout-a7-smtp.messagingengine.com
 (fout-a7-smtp.messagingengine.com [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A17840D8
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 02:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 1CE62EC0105;
 Wed,  8 Apr 2026 20:06:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 20:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1775693206; x=1775779606; bh=gSeZPHVta/QdhpWHafv2VLPz7ZOjHH9D
 oOFsgdgKOIU=; b=hNz8sCwfnQFTX+UxY45TB60OpnKITWdDn8zIsVAtDLfyvJAp
 eXpc1DkvuMFdMYI+GFUZ//02CObpEM9brphdArc5xT/d6HxmsX8/OpV7fCBfKm87
 HtU4Jmsp3zj1gYQz19DvQTbAt7vZWzSsMVUtelN7ykBd2OAqgXu0twwnoiUTzB3g
 HexKgYpte5XQZ0hG+GRlC9wBIKCRfa41Iz1sDfUx7O3Z9IlCeCR9S+IyfRrR69xa
 e4u0lfWcGC8asJjyRkL61F1IA32Uy/NFA/ZPRMb0437CMsul2yR+itFgpgHwxz6l
 kbkFKIjP4/iMosu3UuM12059bu4iRViOkvflUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775693206; x=
 1775779606; bh=gSeZPHVta/QdhpWHafv2VLPz7ZOjHH9DoOFsgdgKOIU=; b=w
 BZb5ZHLjHB8vmgxaDaM2++TTbdXvS0bSfQC60wlX+WEs13pDWpolVp7EMDX/q45n
 X1kaajXmIl7Yw9qQP1TIYkdvHTZ2Z5e0SAQUvPjFYNcfSOfEavnetf9hwHJoZxpN
 AaTBESCLW4VYwHgZSGyU6Ghw+Hn0ukyr3Qk+fESEpPtZDyhiL5DNrdFJfCroV260
 +skBiYDF/xHjaNWnhpqX8ExI0A0vyS4q0wOqjCLV0xJfL8nLbvlaT0pMb5s+N36+
 8ASpHaHaJO5t1EN8pTE0Oj1j/642N81d9413hqMkr2c3BjwDMdnVVExay4zRmIdu
 cdCXD447bfPP2DRL3TBtA==
X-ME-Sender: <xms:lu3WaaUMM_fkhSVYV5XKgvIuA6WlO_-IPDNR6JA-BU3t-GtIIuwGyA>
 <xme:lu3WaUjpDgTVnI5h6gFhdaBV9QGxs4YRiqJxyibKpycm5IB1qt8lLVdFJCD7RjlR-
 HJck6eO0IVKW2mU-Gtn-19heOpp3z93QuNBlN0fGB4gc7DU52-x>
X-ME-Received: <xmr:lu3WaV-BFogHVZHxa2c73yCyckS6y3SJvdNfdNwl5IyvF6roCP5AnyUQ9ZG-iKq5tIRiTmtwv28BehqfWiKqAQSojSJDzie_3NxEO98SCkZjmS5lRYq35pXL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeelkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
 ertdejnecuhfhrohhmpeforghthhgvficuofgtuehrihguvgcuoehmrghtthesthhrrghv
 vghrshgvrdgtohhmrdgruheqnecuggftrfgrthhtvghrnhepffdvtdfhkeelffffgfejke
 efteeuhefhiefgfffgkeduueejheffteffleetgfehnecuvehluhhsthgvrhfuihiivgep
 udenucfrrghrrghmpehmrghilhhfrhhomhepmhgrthhtsehtrhgrvhgvrhhsvgdrtghomh
 drrghupdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
 pehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdprhgtphhtthhopehuqdgsohhoth
 eslhhishhtshdruggvnhigrdguvg
X-ME-Proxy: <xmx:lu3WaeBa_GyLmQzMB2jHnm1TKPLjLc8g0U57Gib5nUQt1uwaaD0Dgg>
 <xmx:lu3WaSKkLANbVdh2vdbBCAKAS_Rz1ExEFT5q-txAZCmstDt6COwn2w>
 <xmx:lu3WaRlmovL2pjQ8C6F20naSXYdzspR-SzEk2urcBUHYy5PA9pouOg>
 <xmx:lu3WaQH3aTjJ9SrbQcC2AGTljSVbbAzAWlkH5TUP1kecXl5SJYZWtw>
 <xmx:lu3WafXhhZpIyWAd1uxWgc3yQDyYV0QRUfqprvDzvQilq9-PQuZBcWhS>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 20:06:45 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Thu, 09 Apr 2026 10:06:35 +1000
Subject: [PATCH 5/5] configs: ten64: switch to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ten64-add-usb5744-v1-5-2094496f72c8@traverse.com.au>
References: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
In-Reply-To: <20260409-ten64-add-usb5744-v1-0-2094496f72c8@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775693197; l=1507;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=74ABKXZMtvDVUWb5dLTMA8sFqpfIkiWBGwvO3rbnTcE=;
 b=CK7vWbYXaKm4eHoU4bRlAetzEv/+V2hu89oprZvDLKc/Q5YAuoGSWqoO5KK3R77D6Gp1HXwtd
 8poRZWSjOcGCQ/EPLKXfP9oXs3L9UiLS9TLnBjSRzey4Ep/0EOb+hgO
X-Developer-Key: i=matt@traverse.com.au; a=ed25519;
 pk=SM+aGm9Y2fPJ2prfH/b5lab73fTBrKL5UsJwdzv7Pbg=
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

Two recent additions to the mainline device tree allow us
to switch away from the local U-Boot copy:

* Board/embedded controller (traverse,ten64-controller)
  is now in the mainline device tree.
* USB Hub (USB5744) connections were also added to
  the mainline device tree but not in U-Boot.

The LS1088A and Ten64 device trees in U-Boot were actually
'synced' to mainline some time ago, so the content
(except for the changes mentioned above) is identical.

Signed-off-by: Mathew McBride <matt@traverse.com.au>
---
 configs/ten64_tfa_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/ten64_tfa_defconfig b/configs/ten64_tfa_defconfig
index 2c5227193c0..cb20b0de0c5 100644
--- a/configs/ten64_tfa_defconfig
+++ b/configs/ten64_tfa_defconfig
@@ -7,7 +7,7 @@ CONFIG_ENV_SIZE=0x80000
 CONFIG_ENV_OFFSET=0x500000
 CONFIG_ENV_SECT_SIZE=0x80000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="fsl-ls1088a-ten64"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/fsl-ls1088a-ten64"
 CONFIG_QSPI_AHB_INIT=y
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
@@ -23,6 +23,7 @@ CONFIG_BOOTSTD_BOOTCOMMAND=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_SYS_PBSIZE=532

-- 
2.52.0

