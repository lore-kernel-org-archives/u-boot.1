Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D2606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ByV1cEyL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iy0/GK84
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CBC6607C4;
	Thu, 22 Oct 2026 07:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5tR3CLHaOtZ; Thu, 22 Oct 2026 07:27:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF8A5607F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792654063;
	b=Hy64ygpTmgbZm7CAXlOzyhw7bYV+bLLEhMNwjGwgBUUku2brJk3sDAL76Q8kyn5TK9Rb
	 q4qQ8Z9NBkjop/7v9rATUZ2vmoBB5CFQqx78cX/C9iGCnvmDGxNzJcaY7Btf2R0G4TsZo
	 QneaoEDK5MOqRhLcqkfmUyl64H3JcgukVyo1J2u2OrXCvdmD5oO82MuzH+HaLRWTXnPq4
	 PFdswisZTGAS/NbYd4OpaFKwdbn6pMzuBU6n0tzUrro3dFG/T+bS1rxmqxCGQloo7aHrH
	 zMaAXMMX1gH89iVEAAX4pe/4hwGIgblK2K7O2iG1GYmNmF1F+GwXFWaKAePMvcyk1KQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792654063;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=B4A4ubRgGhY9Es7NG5WrM7Lg278hAHMOfLemASExMEw=;
	b=MBtQoo6xWbFF94RUHr5QujS3CyNrBFUccuzhWIx3GLsDDBJvPrtQRPhUeBB19c8hxDE/
	 xtKxRKaAItXs3MLNGJhkygjKil1d1haVcWZ+FxwhRIvYcsKQo+mTSrjnKvUtmRr9c7Dss
	 gzYh2Gzdjlf1PHegmrmfQOSVg708csf7Dd9n0dK8EKe0Sf+lWN/Knmmn7uSQWjlm4V/q7
	 nYbtKovbOna5BIryDtXWu9vLQAUrEUyyN4jEN2SRH+jqZAtfV6RfiifKzM6bg83ZuyjdF
	 RWA417ygUci2Xrk8PM4x60LsFiMODLJvIXVxP2HWSaCAMLw/JE9QUZUDO2qAYlCOMwA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iy0/GK84";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792654062;
	bh=B4A4ubRgGhY9Es7NG5WrM7Lg278hAHMOfLemASExMEw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ByV1cEyLqDrc9m7ruOQAKfIah1rUErAc8Dy0pqTQ4ga4dHEOXC93fCj5LpcLlXy7X
	 8Ol5FKLKRM+aarPH9xL9qtambXKqFPqo1oyL8ExF30fcWnkRNSxpuAW4ggY7bl1aYG
	 d0dp86ue7zQXMWJGWmVyKmusCyR+nNUv9XBA5WHKuNOAUc+SAr2amE8JtPE1pQnbye
	 LxOlCKQRSq2eIg2keOx5SbOu/vD3KsjW9YGqWgH79Is+/5VVC0sP0kLp6ZK+VAbUsN
	 uybZAyyMnjLgovmvbQ6QSSVkhOgctAKeSY3q5JhTsLQe2sQC3WYUpKWvYyzASW3zN7
	 g1EwB+ZABJMOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF8A5607F6;
	Thu, 22 Oct 2026 07:27:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D68EA371
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C83F360787
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CsEj3Ytb2P3e for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 05:59:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DE156068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792648751;
 b=biGYRe7oPY5XHzwVrTFDh/ivfKyCJ10xIYiavNck4lMsp6O7SI22K2wURuV9OB6+TJRQ
 l60GNCG0SLdXosc37chRNi0/oh/tKG1jTBbjiYNzey7Yg8Ct3m3W9j742jAI1L34fPYa4
 NxGFg18s1k8Lt0g4+nhCUiUX3BTNi2L9gpr+c314gNc4Z+8dlvPXWZ/bvzlT40pTxI2K0
 fK5QfSWqCT4tvVGugUKEE/PY6Kn7Rtj8GKXOPT++JV527/qW65uHy2PH7Qo9CBZdpyEHo
 F6ZfWD8g4p5fIiC/4Jy/+L09f6vVpmqa3zf9dLbOkzF9zTOllvHhyJ+YG9gVAJQM+lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648751;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=B4A4ubRgGhY9Es7NG5WrM7Lg278hAHMOfLemASExMEw=;
 b=fYhYX1NbUi8H8ZmRWHyPhkkVAooiykLoiJMXoUVr3lbbJ+k46FDvt1DRtd6XTiwTU8NI
 nfCSqLqM08B6E0TASiJfJSF+S9c92/U+/MrVCi9aYSUokpOiPCaFK7fBQL0F56COXoCCr
 UvWxR50NwfvhPYe2OU1XVayvh7FB3Kk3A6SnQGVhGlTvCPXAs7lDA55tVQLIEbtbOUJko
 UBSoSo/7PHpLOBkrovOOfIkx0eAnpM2EPVB+8E8NAeGYQBCw/JKxyrlIMZpaYytnKpMxi
 8g3++7waUZNOtLp2M3cy/AEbhGTjxUbesKn2ewhDShPWN+Y1OK59gAq0FnNFeMb67sA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="iy0/GK84"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iy0/GK84
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DE156068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 05:59:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24FFD43A89;
 Thu, 22 Oct 2026 05:59:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792648750;
 b=fXMN38OsJ1L8/vPYJcKnUfRmamCtljTU2/NkCH/1/q5V5Nh3aNq0JXM/iYDNQJUFLHVO
 AZE5/VwlY8M1U7efVLsdVJ4yE+z6fbgYEWr7VyqztMoJfqFE/IiQdvjqK+8Yb/3099hXo
 MxOOrEKjstPiO7sElX7niLqfHSqWqsy1UqNuwa7eneir4bQr+9FbdQlrQ8RmlK/o4zEX8
 TMgYRWk6Do24EEDEE1pFUBgRnjAIshKciK7dvZCb8Hsz8B5CtXqw2KPp+viCrZRmLCQpr
 w61ZF6xuIacB+8rLpc44oEkf2/r9icIXc87zJCMXiOekcrYyDsCEhFLImM+5w37WonA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792648750;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=B4A4ubRgGhY9Es7NG5WrM7Lg278hAHMOfLemASExMEw=;
 b=wrUN2kN7EMY+YfctMliUSnHieVZgbleDlfC/qOEBkcxPBYQ0qA2u02Y1w4Hj+lJFrG3Q
 11xTVM1gyLmde/NG9ywtDnljprAC7dn3O5xqxZuBu8qXIdb5OvEUYII9x+Eh/8ZHjqm3s
 UdpDTcz0Zp1/wsseDxX0VyufEk2/Vfzfj2WXe1N/Lg8nTzk+OCdvOONYjInFE4+ekn4BV
 6fXt52FWBtyUJYlhdN1py8s9DXnob0rhE3W5AQptGQZ3Lo7NnlRRfn+J7OiqsjFeQSfTt
 WFa/8M7+sMgo1i76JsfJWIL0JcLaNnEjjZEI7KblbNA/GR+p/WDguqdhO67DXSal/qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id EA14C1F000C3;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792648750;
 bh=B4A4ubRgGhY9Es7NG5WrM7Lg278hAHMOfLemASExMEw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iy0/GK84hED2MYeCbTbN6OklYzxfl+lbrXYroh0w4/0SdIuQL5enlp78gssl4GKan
 3XcqmyaGIoPlIKValYa85FkUY88QGG1ityRCqMmlNVnSWliLciMyCiZiYkv9cmbUG7
 emZQN3f1BYWxnUNKIO91+ukROr+6Q8NhFr6tifs7hM/0IKlFCyNzr/sKveC5WbUi7U
 EN03ghzjSOvQMs1XiGzNedbtZD/MzI1m/c7t3aYK3Hdso4jYbd3XwjihFAy/b62lxX
 sA5azBSOmfWHI/5lRQUsJYl7AcEoY0kYUkKC88SIhz82HUJ7Rq0R7+jlLhNn+BjdkR
 X4tbQ/akoELMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 4A7FF434FD;
 Thu, 22 Oct 2026 05:59:08 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Date: Thu, 22 Oct 2026 05:55:01 +0000
Subject: [PATCH v2 1/2] arm: dts: sunxi: Add Orange Pi 3 LTS device tree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-sunxi-orangepi-3-lts-v2-1-46b9df5f9e43@gmail.com>
References: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
In-Reply-To: <20261022-sunxi-orangepi-3-lts-v2-0-46b9df5f9e43@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792648514; l=11093;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=espeeHKSdUJSLMoyoJ6FeRtCWohYsLQ7OdpeHpKZ1BQ=;
 b=+TxxKDwOfGldjgmmAD5Ii2XPkyYwSOLGyPzgmMLLa/Ai3ENnvfepq7LHqHnEDFin6khFi/nuz
 cN/LHxOZXOcA+y43OMja/5ytCVXpx6+H+A70MDY0hsJaUdqPitIAMX3
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailman-Approved-At: Thu, 22 Oct 2026 07:27:42 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jernej Skrabec <jernej.skrabec@gmail.com>

The Orange Pi 3 LTS is an Allwinner H6 board with 2 GiB LPDDR3,
8 GiB eMMC and a Motorcomm YT8531C Gigabit Ethernet PHY. Its Ethernet
power, reset and wireless module wiring differ from the Orange Pi 3.

Import the device tree submitted for Linux in the linked patch. Keep it
in the local U-Boot DTS directory until the board is available through
dts/upstream, and include the current upstream H6 SoC and OPP descriptions.

Incorporate the clock naming, supply chaining and BLDO3 always-on fixes
requested during Linux review. Describe the PM bank supply and the
DCDCA/DCDCB polyphase arrangement. Program both RGMII delays in the PHY
with the MAC delays disabled, as proposed during the Ethernet review.

Use green PL7 as the power LED and red PL4 as the status LED. Keep
the red status LED on during Linux startup and provide a U-Boot-only
override that lights green and leaves red off in the bootloader.

Link: https://lore.kernel.org/linux-sunxi/20250413134318.66681-3-jernej.skrabec@gmail.com/

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
 arch/arm/dts/Makefile                             |   1 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi |  11 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts.dts         | 362 ++++++++++++++++++++++
 board/sunxi/MAINTAINERS                           |   6 +
 4 files changed, 380 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f08..248b4faf 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -634,6 +634,7 @@ dtb-$(CONFIG_MACH_SUN50I_H5) += \
 dtb-$(CONFIG_MACH_SUN50I_H6) += \
 	sun50i-h6-beelink-gs1.dtb \
 	sun50i-h6-orangepi-3.dtb \
+	sun50i-h6-orangepi-3-lts.dtb \
 	sun50i-h6-orangepi-lite2.dtb \
 	sun50i-h6-orangepi-one-plus.dtb \
 	sun50i-h6-pine-h64.dtb \
diff --git a/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi b/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
new file mode 100644
index 00000000..5d37f8fd
--- /dev/null
+++ b/arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "sunxi-u-boot.dtsi"
+
+&{/leds/led-0} {
+	default-state = "off";
+};
+
+&{/leds/led-1} {
+	default-state = "on";
+};
diff --git a/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts b/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
new file mode 100644
index 00000000..3460b216
--- /dev/null
+++ b/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2025 Jernej Skrabec <jernej.skrabec@gmail.com>
+// Based on sun50i-h6-orangepi-3.dts, which is:
+// Copyright (C) 2019 Ondřej Jirman <megous@megous.com>
+
+/dts-v1/;
+
+#include <arm64/allwinner/sun50i-h6.dtsi>
+#include <arm64/allwinner/sun50i-h6-cpu-opp.dtsi>
+#include <arm64/allwinner/sun50i-h6-gpu-opp.dtsi>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "OrangePi 3 LTS";
+	compatible = "xunlong,orangepi-3-lts", "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 = &emac;
+		ethernet1 = &aw859a;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext-osc32k";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+			default-state = "on";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+			default-state = "off";
+		};
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		vin-supply = <&reg_vcc5v>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <150000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC jack */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_wifi_3v3: wifi-3v3 {
+		/* 3.3V regulator for WiFi and BT */
+		compatible = "regulator-fixed";
+		regulator-name = "wifi-3v3";
+		vin-supply = <&reg_vcc5v>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
+&de {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	allwinner,rx-delay-ps = <0>;
+	allwinner,tx-delay-ps = <0>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
+&hdmi {
+	hvcc-supply = <&reg_bldo2>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+
+		motorcomm,clk-out-frequency-hz = <125000000>;
+		rx-internal-delay-ps = <1950>;
+		tx-internal-delay-ps = <1950>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <100000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_wifi_3v3>;
+	vqmmc-supply = <&reg_bldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	aw859a: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_cldo1>;
+	vqmmc-supply = <&reg_bldo2>;
+	cap-mmc-hw-reset;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo3>;
+};
+
+&r_ir {
+	status = "okay";
+};
+
+&r_pio {
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp805: pmic@36 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x36>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl-led-ir";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-audio-tv-ephy-mac";
+			};
+
+			/* ALDO3 is shorted to CLDO1 */
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-io-pd-emmc-sd-usb-uart-1";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18-dram-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-pc";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pm-pg-dcxoio-wifi";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-io-pd-emmc-sd-usb-uart-2";
+			};
+
+			cldo2 {
+				/* unused */
+			};
+
+			cldo3 {
+				/* unused */
+			};
+
+			/* DCDCB is polyphased with DCDCA. */
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&rtc {
+	clocks = <&ext_osc32k>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usb2otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_id_det-gpios = <&pio 2 15 GPIO_ACTIVE_HIGH>; /* PC15 */
+	usb0_vbus-supply = <&reg_vcc5v>;
+	usb3_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
+
+&usb3phy {
+	status = "okay";
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index df745f14..e84219e2 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -438,6 +438,12 @@ M:	Andre Heider <a.heider@gmail.com>
 S:	Maintained
 F:	configs/orangepi_3_defconfig
 
+ORANGEPI 3 LTS BOARD
+M:	Cristian Filipescu <filipescu.cristian@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
+F:	arch/arm/dts/sun50i-h6-orangepi-3-lts-u-boot.dtsi
+
 ORANGEPI 4A BOARD
 M:	Chen-Yu Tsai <wens@kernel.org>
 S:	Maintained

-- 
2.47.3


