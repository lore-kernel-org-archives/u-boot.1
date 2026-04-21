Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A00F5A8CA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 00:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FF584309;
	Tue, 21 Apr 2026 02:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=traverse.com.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=traverse.com.au header.i=@traverse.com.au header.b="ttIDU7zP";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ku7lVoaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B8384297; Tue, 21 Apr 2026 02:05:12 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E148430F
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 02:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=traverse.com.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matt@traverse.com.au
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C069B7A0177;
 Mon, 20 Apr 2026 20:05:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 20:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=traverse.com.au;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1776729909; x=1776816309; bh=icyCnrTmFiJUdxIocHswmnSX8xRlJZLr
 3GFK/DUNmlQ=; b=ttIDU7zPh8lQOxGEqh14B4R6TRJlJcq7GIZO6f8r8kNcYFf7
 GUwJK9LBbYwCzFhU6s0qSVoZlM6bz69gbJDutV/2yprRxvkOHvpWzj4Lt4xtYA4L
 rrZIh/T5XeLyJZQSCukU2StvW0OolDLLL31bf4lMUcQAWBzFtJM0vKjRKdf4y35Y
 5uuy3IdfAnRXZJGJfJk1VQrI3/z67OUF6HWD471heMZRRNf1MrFSrjCzPh0bJweb
 JVDVCQy/v4UVFSQObHSMQuddqLhSW8TuvahdQBJvpc/DQodipD2F//fuPPhc9cls
 nV3vLUkOCV21Ar40aKY8KnzXSNsgP6BK07JT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776729909; x=
 1776816309; bh=icyCnrTmFiJUdxIocHswmnSX8xRlJZLr3GFK/DUNmlQ=; b=K
 u7lVoaAc3ZpVI+lyZUYv+aorQBNZ1AaZ3dxHbN1cYiI86OLRlaarxGtv4K54V2+U
 oviTYXW1SpKYv0Ms7ZXgfvYYKAvfg0oBEkM4SPIS84a362WT4UTmA1COHN+B+OHW
 0pX7E6CwnO38MK6MSeXF6Oah1giifsNQkDsXYzDqNLyxXYV12u6fWJf+i/Gm6Uaw
 X3aV3dxLS6nBcmng9+X2MJbzVXQAXXm8+N8XCNI98lvFIL3/HZunXMbuMBmdjSNS
 1JKXM6e5P5NpsK067qUPdPuqEV4QPsjqowjfzJ+UebpnFz49/lVS2Ca2FRGhQQGL
 RJKzf4lfGygIELY3wa6CQ==
X-ME-Sender: <xms:Nb_mae6nqEtcr6aO72Hqho0PS-nNxSSrs9JxSVFqP8V2QuYP20Pu4Q>
 <xme:Nb_mac0JpP6-cq1nBWPcoAzxErB3ummuuY0hpZ0OYFZ4nNcO5oxCGYHixr8YxMybj
 9Q4Ascaa2QRbmAKrr9h9R9Nb2nEJIJRKPa1J1l1XlBVMD4LCHAd696q>
X-ME-Received: <xmr:Nb_maRuKIh3vajkfv5v-tPTA5CjKIbz9vp13GiHpH7w2e5WA-aKwjTc1ZrrRwMAEJQrWFQnUgSQpvcdE5ZuEjsseRx92MHd6O7Vx3UTqpm4hgDv02lmSsTZr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehleelvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhvgif
 ucfotgeurhhiuggvuceomhgrthhtsehtrhgrvhgvrhhsvgdrtghomhdrrghuqeenucggtf
 frrghtthgvrhhnpeffvddthfeklefffffgjeekfeetueehhfeigfffgfekudeujeehffet
 ffeltefgheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruhdpnhgspghrtghpthhtohepledp
 mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrughmrghrrghordgsvghgrghrih
 esrghmugdrtghomhdprhgtphhtthhopehquhgvnhhtihhnrdhstghhuhhliiestghhvghr
 rhihrdguvgdprhgtphhtthhopehmihgthhgrlhdrshhimhgvkhesrghmugdrtghomhdprh
 gtphhtthhopehmrghrvghkrdhvrghsuhhtsehmrghilhgsohigrdhorhhgpdhrtghpthht
 ohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepphgvnhhgrd
 hfrghnsehngihprdgtohhmpdhrtghpthhtoheplhhukhgrshiirdgtiigvtghhohifshhk
 ihesthhhrghumhgrthgvtgdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulh
 hkohdrtghomhdprhgtphhtthhopehmrghtthesthhrrghvvghrshgvrdgtohhmrdgruh
X-ME-Proxy: <xmx:Nb_maa7FTjxGhgD-HPQ9IR2ZJBNVWHbzgYhdMzPRZ4UeFVXmDRW8ug>
 <xmx:Nb_maVd7k1xbEPt9QzRmMFp8dd92VNxqHZzeuAfvjmZb9k8xl1UgyQ>
 <xmx:Nb_mafyUm4nKMWrefDv3X65YV_kXOY-Y3S24UBzTk_SbbGwgEdFfuA>
 <xmx:Nb_maS8QD7PtvUWRbLxMboFwSAC778sskwrN1FT_Qc-KutAsopSxVA>
 <xmx:Nb_maXekjdI0o8m1aYJm2aG2wBhz01q5aXvm-zoTrBneaZwO5wVEJ1_p>
Feedback-ID: i426947f3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 20:05:06 -0400 (EDT)
From: Mathew McBride <matt@traverse.com.au>
Date: Tue, 21 Apr 2026 10:04:39 +1000
Subject: [PATCH v2 6/8] configs: ten64: switch to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-ten64-add-usb5744-v2-6-eaa81288e393@traverse.com.au>
References: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
In-Reply-To: <20260421-ten64-add-usb5744-v2-0-eaa81288e393@traverse.com.au>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Mathew McBride <matt@traverse.com.au>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776729881; l=1502;
 i=matt@traverse.com.au; s=20260115; h=from:subject:message-id;
 bh=dM4bwGwwZUMnHIiKkgN8gTaNWMPJTjtAaiJmGSRF8ko=;
 b=F/3GJtvALxG+J9YDw4oXAStgBOkq+l23nqByjHcLM9zhwODQoiYMpChzMCk0/LW7MVt/2v7Bm
 4MLEMdPSxxRDklStaRd1MUukrb2zI66hnXamohPdthjvwoe/cPu64A4
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
index 65363d013a0..26d41b3f366 100644
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
@@ -24,6 +24,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 ramdisk_size=0x3000000 default_hugepagesz=2m hugepagesz=2m hugepages=256"
 CONFIG_SYS_PBSIZE=532

-- 
2.52.0

