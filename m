Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058B606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 01:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rpZWne8V;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xt090HkA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5FBC80DB8;
	Wed, 21 Oct 2026 01:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1SUzUhkMCcf; Wed, 21 Oct 2026 01:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A82ED80DBA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792544704;
	b=afVlfbcwq39RJ25mda943m+o4mwZ6hAR3Dz/SZW8wjiRfOxq0zJKVxvyZ1yHjxBotrUq
	 +BQ+NZM3Vr5eUqt5bDAGiD07zSBdgcBc+Qc+BnjXVkd92Zz6XoAbol4JqW696HNYYkzvR
	 qrrfCbe1BrVbq0Q/ivnfXhOoxijHfEofpa325ujKbp7P0qKKoiWw3gsoryzpm2mKpzjNy
	 q1CYw+2cIgiIXD/jbtPGjkFEy49AFPHq8oSN6x5LPem26eN4A40espvMw31yIbVCMUwe6
	 qpE2Q3qojbodBJy/jkzsOmT6IP6FVIcZz70O/JDvC1C1v9xQZNfmLPsXVUwh28ANMaQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792544704;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=39zJVca2VmzzZ9fv5h5SSxNhyZE5aeg8eGbBh2i3xhE=;
	b=gZ2MYqXNL0qePUTRr7YSk9ODmW6fR8JLRwnCC0LPYBlRjzgfMxuVlolBvRMsVWZqoJVN
	 dVf9UWvU98aR2VJP+uHogq5ocUAPfaL4uXHgERkkkM4ax9lnBoSxOZZZhSQv/tmAyg349
	 5hl/8fIvh/SipnNq5+onJEoFM+tT5NYpdAjEtctXNvTqKLAdrDZXxl7bCA6ABOxt/WDM2
	 miqZl607RHFt0QOcpaIsvUvZlZ5Jcub5mW4omk55nHPTH1JtULrE/xL4cXt9oX1gty3aB
	 YUe7bF20/uVvOl0ZY8JGZaV/Qw3g6rIIXqv0zGlgdRg3oqHfusQrRppHf13pNN9a2WQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792544704;
	bh=39zJVca2VmzzZ9fv5h5SSxNhyZE5aeg8eGbBh2i3xhE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=rpZWne8VL4eTk6NPBdC57YSqHYXATW774QfrxshIWvq/WF720ekFH2A4vDrUri6Ll
	 SYR52XYz/C5AxrfeVk86j7KRsfNSn2lsFNJY8w2a9kkErvV9vPoCTxXGNlNY/bizkV
	 trmCCk23/ih97UbX+cPDEs+yxv88b3yipYi9rTTN8fvO6ST76OYe97fMwDc/QOXy9j
	 h61RZ9++2sJabLoquPSKDtFNSCvND2gZomNwbS0mrFxEKUh3x8sxT15OqGLXoS+q/C
	 O17xGuVPCUZWWh4ZfhYMUODFjzdjNIA1ykmo9/fvLXiPorgK1ks0QsJ9I3FEeUWJk6
	 h106967GZcp3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A82ED80DBA;
	Wed, 21 Oct 2026 01:05:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 51D193A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 39DDB407D0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVdrOUdUbylu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 01:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 49FA740769
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792544701;
 b=sbFAL4xSK+qtYLRCKuDNTZQX9QKGlCGJ0FfFMQKyzUVd3u7M8d2BMUs8VNG06Xlo/T3p
 FmbPZexcx3QdgsmNeRpmMNbphuLh/oeSpouSbECUwRDhI9kA8CSa6iOF8Nn50oWmZU6JS
 HpwfcQmcGI1+o4zyaQk9INAUjlJUh2LyDYFRiTeRi3U4ZVT/nZpdmoNO2Lz7micQlr/V0
 CGmZigHwCgbqNp/mxG1HMXghWf+DfS3/u8GvNqwu8WO5Mo23FFsoAx09gWn5JEsHlbFtY
 cDPUzu7DPeFaYn/rgxo1AZ9N1gn4nGz8CC4fgZOR01sf7FbF3FaZ1JgVkHA4bQhlx1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792544701;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:X-B4-Tracking:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=39zJVca2VmzzZ9fv5h5SSxNhyZE5aeg8eGbBh2i3xhE=;
 b=cq0mvv8GaBqMkgB55JMMSrGmuk8L2I3mq84D5XuYYSDPLbtvIEgHNLMwQPGROa87xuAR
 ewdolO5PDVdEZY0UWVwNlXuwvo0T/AV8G+FmnC8Lp8ecgapxUp1r8jSVWqY8e48b15DmL
 13H+NHaNZ/tPySXmT6awm7/1uF28AOx05QqgE0ac4zB1CH+L4gfrckrTzaV7IRFRxs8wZ
 PhHfCwnwBXTThPaHw/32+nX4RD1aG3J9VSfnYezEvSxH5EicejIHJAQ+UJZfwcgBctd8W
 FDk3GcVcKZsp2dvMf91pn5sxF7hRQ6F8NtBIwTjA8pZbL+a1fvSBTW9mjK7dXmvDOJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Xt090HkA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Xt090HkA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49FA740769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 01:05:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 104D6409E2;
 Wed, 21 Oct 2026 01:05:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792544699;
 b=qcwrdINnnlw0sfE36g9VimDihfNtgFnk0W4FQHWbDZq9gUGd0LwppkHuQYZCxsi9lAnC
 b3uMDNjDZfpnOgzR9KXidCrbFKU5AKEjX+5OXTK3G//hVTq+touU7AEpiW3EJqjQUfIq5
 W+/hG/7c7wM3z2Rqf1IPK/JSuBUGXnz2ZaqfUlmbeE/4HNdnbzBjAKBs01LYicdYckjP5
 zkbu8Fu5uhjKXdarpSp1BJwMY/VMTsQRVghmGZcqshUYdyN+sfvRJUNTcNovoq9elNvQW
 /O+FGpDWN8HPs2/SoVu3BagYT1WArSgbuaCrss4D/FMtFFXF6fIjI8C5MhvLDWIlpZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792544699;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=39zJVca2VmzzZ9fv5h5SSxNhyZE5aeg8eGbBh2i3xhE=;
 b=QHR6RWlrgG5WVwivdOupMVBXndSP2g7ddhzw3RS/JK57y2KLzLdne4Es0wclygc4c50A
 9AmQ5bfNlz23MJrld8sQW1iS+sf6gVAGFoT5USQp+ZTsIIyao4vMyOqinOT1Xq0bSrDds
 /iNg9Y6vD2bDGPZxV8lpfU3u9bgfeD1voQR5Ulgr0AYEl+FIw0D2mi5zrQdnLLE38zZ7S
 idn+SuyEpSvggtsWTqPWeEjTwSU8NSlZUSHHYem1K2fAoF8EahHVSJhkiszofCRV57KJa
 LDqCSJryL/KC39FEfgPhQ8Le3xNBbJMQEVzn0P0/kgAFOHs+b93dnPRTcpATSMYRDSA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6B2321F000C9;
 Wed, 21 Oct 2026 01:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792544699;
 bh=39zJVca2VmzzZ9fv5h5SSxNhyZE5aeg8eGbBh2i3xhE=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=Xt090HkAouqHu0Mnt76StnOHOsPi5i9cnCU+rTfHFmkbfMHw3Jun2PFIu5nyC8w3k
 tQofUmhRK6SWKnc9lZPrFFC6rSjzawt1Sbf0n0ktv9UtKJRBIbIMrC7uG//lkzwZb/
 gGBFIO12YhBYEbw+7fZdLIF073pFGkNYhwgzq7N3iJR2XBDyc2PWIZkJiZeyB22g5N
 xL/GofNvyUS6OixLK6hcDmBw4Mi+TwfSG3xZaz30OPwMjfPK93qLezp6QbSQAmv/gH
 iI1VKKVghCykcRP6RdGh6ptYh+H4ydeshJ8Casc5bjKobfZ5fN8QuloRxVquvahIzF
 YdVxfMNx3Regw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F19C2400AB;
 Wed, 21 Oct 2026 01:04:58 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 21 Oct 2026 01:04:56 +0000
Subject: [PATCH] board: rockchip: Add Kobol Helios64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-b4-helios64-v1-1-74afe8aa6d72@iav.lv>
X-B4-Tracking: v=1; b=H4sIALcP2GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyND3SQT3YzUnMz8YjMTXXPDNANDy5RUixTzFCWgjoKi1LTMCrBp0bG
 1tQBlaRCuXQAAAA==
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6017; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=3+UEmDnW08wUi5ddmfoslkMBlNYflMFw3+LKhxEgaU4=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFk3+Hdp2pWV7Ck++Ca85/78ld3rNl7247LcFTsp7cDmZ
 jFr+6btHaUsDGJcDLJiiiwTDmncylhy9a+/h/kDmDmsTCBDGLg4BWAiZuqMDDv+Xnu1z+bI/u9l
 vpGRem95d8p7FQnoiVjfYOK6/nTfOQeGf/qXf5goS1/4np612Gtdq5+21iznAKl7x3jFOf+emCE
 4kwkA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Igor Velkov <iav@iav.lv>

Add support for the Kobol Helios64, an RK3399 NAS board with 4 GiB of
LPDDR4, eMMC, SD card, SPI NOR flash, a 1 GbE RTL8211F PHY, a 2.5 GbE
RTL8156 on USB and a JMB585 SATA controller on PCIe.

The board uses the upstream device tree. The -u-boot.dtsi adds the
LPDDR4 timings for the open-source TPL and the vdd_log PWM regulator
and the vdd_center RK808 buck, which the upstream device tree does not
describe yet, and sets both rails to 950 mV. RockPro64 sets vdd_center
the same way, see commit f210cbc1f3d4 ("arm: dts: rk3399-rockpro64:
slightly increase center voltage").

Without the vdd_log and vdd_center nodes, Linux 7.3 reset or hung about
2.3 s into the boot in 2 of 2 cold boots. With both rails at 950 mV,
20 cold boots of Linux 7.3 showed no memory errors.

Features tested on a Helios64:
- eMMC boot (TF-A v2.13.0 BL31, open-source TPL)
- GMAC Ethernet (DHCP, TFTP)
- USB 3 host

Not working yet: PCIe (pcie_rockchip fails to request ep-gpios).
SD card and SPI flash boot are untested.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
No MAINTAINERS entry on purpose: I cannot commit to maintaining the
board. It falls under ARM ROCKCHIP via "N: rk3", and
buildman --maintainer-check passes.
---
 arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi | 56 +++++++++++++++++
 configs/helios64-rk3399_defconfig              | 84 ++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst                |  1 +
 3 files changed, 141 insertions(+)

diff --git a/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
new file mode 100644
index 00000000000..0f8e9353066
--- /dev/null
+++ b/arch/arm/dts/rk3399-kobol-helios64-u-boot.dtsi
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include "rk3399-u-boot.dtsi"
+#include "rk3399-sdram-lpddr4-100.dtsi"
+
+/ {
+	vdd_log: regulator-vdd-log {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <830000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-init-microvolt = <950000>;
+	};
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&rk808 {
+	regulators {
+		vdd_center: DCDC_REG1 {
+			regulator-name = "vdd_center";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <950000>;
+			regulator-max-microvolt = <950000>;
+		};
+	};
+};
+
+&gpio0 {
+	bootph-pre-ram;
+};
+
+&sdhci {
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+};
+
+&sdmmc0_pwr_h {
+	bootph-pre-ram;
+};
+
+&spiflash {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&vcc3v0_sd {
+	bootph-pre-ram;
+};
diff --git a/configs/helios64-rk3399_defconfig b/configs/helios64-rk3399_defconfig
new file mode 100644
index 00000000000..16cddc71e0d
--- /dev/null
+++ b/configs/helios64-rk3399_defconfig
@@ -0,0 +1,84 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-kobol-helios64"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_TARGET_EVB_RK3399=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-kobol-helios64.dtb"
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1f4e58c8be2..5a842fc6b30 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -92,6 +92,7 @@ List of mainline supported Rockchip boards:
      - Khadas Edge (khadas-edge-rk3399)
      - Khadas Edge-Captain (khadas-edge-captain-rk3399)
      - Khadas Edge-V (hadas-edge-v-rk3399)
+     - Kobol Helios64 (helios64-rk3399)
      - Orange Pi RK3399 (orangepi-rk3399)
      - Pine64 RockPro64 (rockpro64-rk3399)
      - Radxa ROCK 4C+ (rock-4c-plus-rk3399)

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261021-b4-helios64-71f019de8d7d

Best regards,
-- 
Igor Velkov <iav@iav.lv>


