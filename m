Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1944606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lToWIaa5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqY08Iy6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD41160ADF;
	Wed, 21 Oct 2026 22:19:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-_GKFx7QW_T; Wed, 21 Oct 2026 22:19:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E61A60B20
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621170;
	b=Ra73S++dZd8HUVgnJ1CFOi0+/VpKWhoATLvvaMUgksUjb2UzYMOl6sgomOsU3IWn7gt9
	 fkprrSL55BPJZQglSZcUwwTSgpFwVf2Y0GRw8Rur8KA9TIRa0bsP03GHJbaqdU9x4ZLAB
	 ClbhLGMME5ocUksVNhEQFFy8ob4ECsloeU258orR34BWI27ygw6nLVCm2QRymQgJNwVGf
	 kn6RJMufCkvK6xhZOX5CnKSLPhNTgP3SDktjlGwAGGwEpqMiG2OXa77+3ODU+nV8+THuo
	 QmaeTNbOF1+6/niWlsqvtVogFhFJfeXs4eV2/VjK6SHh0u+SIIF+S012u+7xlJqqHKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=vzeoh03Ff3iiqCFZUyHo7k2vI2IqL8M372A7Hj9g0iE=;
	b=rtO4FB+2GDRGqK6POxyYK6RDiK3NR5Le1CkbhOrkAcyO/cqKMPZLQhthS4XkpcjpBSMe
	 ffJytMwYz6NYE3Y7JKJj/XKxoUQqnk86JP9VZKHuMJuMZQjIjMI1PKklNnp81BW7qfS7Y
	 76jUnd0uD9XTJYrjw+v0pDdtcbL/4TOcXCzD6jfV8dOpRj/EdtFarwQIOtFFDybE49afQ
	 harBc1BWvSGwX6s8kewnRTWCf+dQVpwU3VUSMokqw78hErm1X4quwEyQ2FFLTzOF1CbpY
	 7sca3eU65C1kcuJU2RdR0TC4mdWn9QfflbR6dm0nf4QA6PIYVGD9JeTngXgGeOW5a4w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqY08Iy6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621170;
	bh=vzeoh03Ff3iiqCFZUyHo7k2vI2IqL8M372A7Hj9g0iE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lToWIaa5PZ2+E/soI7Jln5JdPwqYPC//wd+5p7i25DcKv+R5OCI50cJ0IsSDBlI2d
	 WQTBChFs6EBis6pAwk4TOTrilrN45VFexxFloG1I+thBakmRoBZ51NVin1CL8+qyiY
	 S/hCVBxtEk7nelpt4POF0+AD0qXm7g9+Cmcs4itn/vFfwQ2yWaGJiSIfD9OVYEW8ia
	 NFw9C0HPJLMUaPUCeYACIkjGZXywg3bGDm74IOhHt6RVlPSIFSnYjIAcigY9Ksleej
	 V+qMrkkuQ9ILebBG+Lsqd1CVJyS7QhmpR9vz5lRBCj5a41w7XW7PkDSDUvl9n4xoIE
	 Dy2CAwO7P3t0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E61A60B20;
	Wed, 21 Oct 2026 22:19:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C9B41AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F28F960A3B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRMFnJBWd4f7 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 21:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 389966131C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792617425;
 b=acIQ6kgGVjxylFbYxHFiSTJIKXRHmEav0BoOszeV/w7c2U1Bet4VB/eE9ca+Wmss2n9s
 6btfamJTZw1wkKCfx7ZtD+/UanUc3ssPPiWfsENNJoov/rBFLMvSGwl1FitoSRXQD+uth
 AIr9lY1bwhxaJRepf2mM7cThKQljT8gs4lI3QQa6cbEHfZJnyZjSmBdHKURwGx7pnijtK
 BA+UXUhhLa04oZTwpPF8L2bxuaZc4vVYLBKR3zKLSNJ0Co03+9T7Mdy1P8M7MxxTxyoKY
 mq3ogpnIbJhEWbKFhGiU5AvIb6Si5aJSId6x/QnZ1p/AByv9Ji6E/UYxY9crrlaMj4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617425;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=vzeoh03Ff3iiqCFZUyHo7k2vI2IqL8M372A7Hj9g0iE=;
 b=kpkl1sr2b/lXdAB5Qo0CkeT678mAQhg3An6ddWaAP0YFOpu4jy2vsBGo8zOkiU4ADtcj
 8gb8rwgUwXHEzWvDy1g/JPkw5T46fzt0KMh5RLdrIG+xYhIoLbZuLMR3mpXoUwvX2vszQ
 w3bV7qILHEnXsc3OsK/bwfeX3RepU1skJ+QCuIMwLiOMPKoO50WDTEYoun7NvsDn1WaN1
 PGR67IzpAD0QqoiRK05Tq0X8OdLXssOSwF+EhOQwwxBjE7betC0EhAeogWXwBeTU+7Gwi
 gqLwy3UPge4flNVrTAZX/Bb03qjmGyfKUSS9T58j07lFE6qgvCTzNSf1biXzlLK/Xug==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cqY08Iy6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cqY08Iy6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 389966131C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 098AF43DA3;
 Wed, 21 Oct 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792617423;
 b=Dbxxq0id7z3t+ndnVaTwAE35Xxf7H19zhNVS7SEFcEYoaARcBEpQRpHt+BYNEvjnP0qs
 Yr/lGGoktwG+wuNEMkWTnXj9GexfEIvH/m1XpK27FKgEX2N33x6z6TeN196HXax+WhJDL
 D/K9F4NTzykY0OpSl0Uzcry7S6wd9VFEOcchxyw2bBcgUTLQ6v6rxusZclU55jJZdXI4u
 WPZqXMqSU736cNnzdVVQ7asacP1QvdlPQRXSIDHo4/zMn7VUfVZ6JMby5eHnH/O/ONWvr
 o6JH7IHgBu3OHs/p/uu7ZzqCTxeCwUxjniEzCYRrlK11W9pirxeLX7ulMZvcgRR2SiA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617423;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=vzeoh03Ff3iiqCFZUyHo7k2vI2IqL8M372A7Hj9g0iE=;
 b=XsltHnYh8tLbJ4mHg817mzUNk8e/V/O339aBxdsttGfbyJ8FJU31VawaeitTQjsGtJ0k
 ZMjfHOcmRURGFfbgHDHRwU9NpluYQx69f3+FbEqTefflR9laUFCgMa/LAWh2UlV/J9Veq
 y9BGVQBm2A5AmSPiiEHELOl+OQNMe62k18fAhe3WHt7SlE6WW0ToI9+B8/RmwqsPg68O3
 dMBZ5AwcD21MlC9sJmfh26piAPs++YEQ9xQ3Uvl9ts+7pu7nUGNWmhb/muze1fZ1ahVm4
 OGY9Z9wQFSs3bPPdNYuz1ztagwSbn1xUDiEAdiTdzOz0ebWPNlctjQeNU9k2rsho2CQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B04121F000C4;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792617423;
 bh=vzeoh03Ff3iiqCFZUyHo7k2vI2IqL8M372A7Hj9g0iE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=cqY08Iy6p5YJ7E1RgpiHFGyfDSdEsFByWxsUDaT+TG9qgKNoiGroCCU6Gs0GsImla
 qg3R8KXcTx8jYI7uiltZkfX+Hwk7pj24Scvg+TEOhpo5ocssAzVZzEnVwC2coDgLYl
 YKiJ85TZcWAm0iB7bqjZW7AsvAE7L+sxUeuaUq5hxRj/zr3M1mTIbMJ0dTnkfvaF3C
 GWNe7jsD1eOt6vNXdz2DFnU4XULepKBu8WnDbhAnq06BukyvZgOJto0hJX2K+4n5SS
 AAnZeJNNZt+JKak9EC4z/qCm6PTo4NoqnR4gkcOvJOdt+2J9E9Ads4nflGvFW3v9wC
 c3UultEGhyJ5g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 447FC43484;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Date: Wed, 21 Oct 2026 21:13:03 +0000
Subject: [PATCH 2/2] sunxi: Add Orange Pi 3 LTS defconfig
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-sunxi-orangepi-3-lts-v1-2-19a3df928d8e@gmail.com>
References: <20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com>
In-Reply-To: <20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792617188; l=1891;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=HvU21ZMzEGvwYkPObbwn9lpHNTQRijMbSEhw2+ViKhA=;
 b=FJNrwcRX4fl0BLBBnIUcqbJKTDoXAlzMNRTPk7jQ37ir7d50h42S8IOLccCIKr3DnrOlq2l2z
 J2rmZ4KcW6iD+lpYHZlsVom7ACVjIsWh7sNqne/W+8vtDJhrrGTXv3o
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 22:19:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: filipescu.cristian@gmail.com
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cristian Filipescu <filipescu.cristian@gmail.com>

Add a separate configuration for the Orange Pi 3 LTS, using its local
device tree rather than the original Orange Pi 3 board description.

Reuse the H6 LPDDR3, SD/eMMC and USB configuration from orangepi_3.
Enable the sun8i EMAC and Motorcomm PHY driver for the LTS Ethernet
hardware, and omit the AP6256-specific Bluetooth fixup used by the
original board.

Use the green power LED on PL7 for the SPL status indication.

Extend the board maintainer entry to cover the new configuration.

Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
 board/sunxi/MAINTAINERS          |  1 +
 configs/orangepi_3_lts_defconfig | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index a7c17fb4..40e1c505 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -442,6 +442,7 @@ ORANGEPI 3 LTS BOARD
 M:	Cristian Filipescu <filipescu.cristian@gmail.com>
 S:	Maintained
 F:	arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
+F:	configs/orangepi_3_lts_defconfig
 
 ORANGEPI 4A BOARD
 M:	Chen-Yu Tsai <wens@kernel.org>
diff --git a/configs/orangepi_3_lts_defconfig b/configs/orangepi_3_lts_defconfig
new file mode 100644
index 00000000..5e5d872c
--- /dev/null
+++ b/configs/orangepi_3_lts_defconfig
@@ -0,0 +1,19 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h6-orangepi-3-lts"
+CONFIG_SPL=y
+CONFIG_MACH_SUN50I_H6=y
+CONFIG_SUNXI_DRAM_H6_LPDDR3=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=359
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SUN8I_EMAC=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_SUN50I_USB3=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set

-- 
2.47.3


