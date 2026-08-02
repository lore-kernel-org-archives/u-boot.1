Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CB2C55174
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 21:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09178606CB;
	Sun,  2 Aug 2026 21:36:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yvc36R0o3tMO; Sun,  2 Aug 2026 21:36:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CD78606AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785706616;
	bh=gWjb9+cDA2RpO/oy17hCdhz9FI9G7P9hWxXw7b+618M=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Dg8a3ZAPl1yD0QLKEoE6YepHxGSMn0IgDqcYVKxhHmYDl8AIeWrC3bbZCd6izSALo
	 xEyVtYZ+MQ6oWRsCVokB9dKUjnxy9H1pulQuJSCgWnfWUA1zYZrF+diOTjpKMPb9K9
	 JH7spQHEoMisBTGMz3bsObeBCcgdYIaSqSnvKXik+cE4ttfUG1qLX/zgR1Gtp8QCrs
	 U6Pwng0a0upM8hunQWbzGU2N90dcyUeODFwFbMYF9Q/DCXa8xAOlGy/09DULyQfNeB
	 f4KMssnyvKA6CSfu7hKwONYZUFtZz3R5NXIn59MGi/6/g1Y+wq1/tbWN2kzlZWE/E3
	 9SvdeWL4p0DwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CD78606AF;
	Sun,  2 Aug 2026 21:36:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31EF026C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22FC3405A6
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSOlvDT3irYX for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 21:36:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 000654050C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 000654050C
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 000654050C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 21:36:53 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCtRl5JjHz8v0l;
 Sun, 02 Aug 2026 23:36:51 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: dts: renesas: ironhide: Describe all reserved
 memory
Date: Sun,  2 Aug 2026 23:35:49 +0200
Message-ID: <20260802213643.134847-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 538629c36ee8de29ef0
X-MBO-RS-META: 4ew7iy5ncn8crfjrpjdd5oaywxzrq844
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gWjb9+cDA2RpO/oy17hCdhz9FI9G7P9hWxXw7b+618M=;
 b=vLSburEq7zdLTLV1uKr5fRIVsLZCF20Ql+6Ng55qnCgZVxV+8frMDhxhz+bo+LRqgT+Onf
 5OhCPac/RctPUuZgEGOnoTjIFYU0AMICTA5CyTUPZJC7jqnfmDmUVHe47It94TM+uCNAcP
 iBt81Uzx7YwUFte/3MVrFJQWrAFuRvCvzyLEfhORJulHBwnTOgfNuIS9hKwAvjpMyZyOlf
 y2H6pfflv9gJ4qnqSoWWI9gK+Ix011bRFeknB6xuB1Kd07R5iZY0hCQk4QEkMzodJCE605
 le7H934h7XXG87ZYOi2dh/MlWKOTFWfju7a0SFHs5bNeVdUFQx6tWYsjl3X+Ag==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785706610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gWjb9+cDA2RpO/oy17hCdhz9FI9G7P9hWxXw7b+618M=;
 b=cLsjBiHyJtI4Yyf3BtVaBGk5evX2utgkNy9sQ82++3xrpX6P/j5wKOJMmaAnbKXNFOPxuT
 yaABFifaEsfsPYTZTMXRyt9m7UvEU4u7QpziGlEZWaljn6Zwqf4vfr1fXmSks9V/M7TE1E
 BIcj7IvhZ/2d0tyF/tegH1HQ7Rjc8m4YxOfYGFPQN9LVH/El0KD84YKpVZKbR+wC0WrZfL
 0VuVcwB5j+Ssk8dw5b8y1tjYHmINBCbaXvoZ+HJAUqy8il4Eh2dVvjX4HhVkVETdKjOS9S
 QImFYUozVUYHUW2Uq5F2RyREKc/OLOOLwGMxUZsmX+ezryOHE0sCeenNuBmJpg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=vLSburEq; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=cLsjBiHy
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fully describe all available DRAM in the DT, and describe regions which
are not accessible because they are used by firmware in reserved-memory
nodes.

Replace the first memory bank memory@60600000 with memory@40000000 and a
518 MiB long reserved-memory no-map subnode. This memory region is used
by other cores in the system.

Reserve 32 kiB of memory at 0x8c100000 for parameters shared by IPL,
SCP, TFA BL31 and TEE.

Reserve 512 kiB of memory at 0x8c200000 for TFA BL31.  The upcoming
upstream TFA 2.15 BL31 uses memory from 0x8c200000..0x8c242fff; rounding
up to 512 kiB is slight future-proofing.

Reserve 32 MiB of memory at 0x8c400000 for OPTEE-OS, which is the entire
OPTEE-OS TZ protected DRAM area.

Neither TFA BL31 nor OPTEE-OS modify the DT passed to Linux in any way
with any new reserved-memory {} nodes to reserve memory areas used by
the TFA BL31 or OPTEE-OS to prevent the next stage from using those
areas, which lets Linux use all of the available DRAM as it is described
in the DT that was passed in by U-Boot, including the areas that are
newly utilized by TFA BL31 or OPTEE-OS.

In case of high DRAM utilization, unless the memory used by TFA BL31 or
OPTEE-OS is properly reserved, Linux may use and corrupt the memory used
by TFA BL31 or OPTEE-OS, which would lead to the system becoming
unresponsive.

Ported from Linux 7.2-rc5 commit
5250b3b1ad99 ("arm64: dts: renesas: ironhide: Describe all reserved memory")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index 299716f96a4..21b03df849a 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -15,6 +15,13 @@
 		mmc0 = &mmc0;
 	};
 
+	/delete-node/ memory@60600000;
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x80000000>;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -32,6 +39,36 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* First 518 MiB is reserved for other purposes. */
+		firmware@40000000 {
+			reg = <0x0 0x40000000 0x0 0x20600000>;
+			no-map;
+		};
+
+		/* Parameters set by IPL. */
+		parameters@8c100000 {
+			reg = <0x0 0x8c100000 0x0 0x00008000>;
+			no-map;
+		};
+
+		/* TFA BL31. */
+		tfa-bl31@8c200000 {
+			reg = <0x0 0x8c200000 0x0 0x00080000>;
+			no-map;
+		};
+
+		/* TEE TZ DRAM. */
+		tee@8c400000 {
+			reg = <0x0 0x8c400000 0x0 0x02000000>;
+			no-map;
+		};
+	};
 };
 
 &cpg {
-- 
2.53.0

