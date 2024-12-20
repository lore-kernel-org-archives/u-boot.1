Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F092E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCF780317;
	Fri, 20 Dec 2024 01:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="r1ZlMcgm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uEWFqLOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8538033A; Fri, 20 Dec 2024 01:03:51 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB26780326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YDnh52gd1z9tVG;
 Fri, 20 Dec 2024 01:03:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b30pQ9/5wj3x1Se/sY8lDK3Up8vvu+HyJQSDsN5uba8=;
 b=r1ZlMcgm8KrcSLxorm1Rzw9mLa01B0l6m0UiwpcODKHWfSn5/pv/wZBoDJKYTCwyFGd5Eh
 CwdDQhxumo23uB452VdUJLE/lrF7vMoVY2EVLXlxF9RJ2yQAXUYoKQ+7o92nHQ5sYYkx9N
 ovw0h681tASqLbqke0ch92fvOBgUkd2uqDPpUnQLTT6nCeNtRKMn4fWHTfDrpO2irOo9b5
 SVuGergmmejW8uhR65EunWJqx6ScmV99dMFktJEv3gm5sABb6f/NidpqUWaO/sJbUj4Vwb
 bMaoii9ZuLEW7wXRa0puYx2NFIE+ZERsBCU1CBQu7EC7lvsEdO/YFrQMxAnO/g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734653027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b30pQ9/5wj3x1Se/sY8lDK3Up8vvu+HyJQSDsN5uba8=;
 b=uEWFqLOPDG2TwFaSU689Jwzf5BJ9c652OSLgi+s4bVQfOE1XKXzdsFv+ihEmszAcQXdFAI
 BdmQAK3THgF4O/2owEcF5HFcbbRLDxhSDhKEIaAGjMQ94syCth+80+8QW/KzABOnv1FJSx
 b0aXOtNfUcCUxtbIGH75//2drS0wa7nih3RVR5dnmjXlc4+9DXZbrwa1DwDuG/u7dceOeQ
 PPYH4XLjkp7bXFFDsgKCl6eJ/hieuNhiwxFZy3mWN60ovtm9fQcCVkdP4w1UNglNo08oMS
 T88NMjGavc0hO6PiXsINyMKFuSpQsn5y6ft2OvUqHwnedEKMxH4TNFmFZGcsCQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] arm64: dts: renesas: Add R8A779G0 V4H remoteproc DT node
Date: Fri, 20 Dec 2024 01:02:15 +0100
Message-ID: <20241220000320.167110-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241220000320.167110-1-marek.vasut+renesas@mailbox.org>
References: <20241220000320.167110-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d1c5ac74a617fe666e3
X-MBO-RS-META: 5h4719srwckdxo9nhnwyyzgzre7ai3u1
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

Describe APMU controller as a remoteproc device capable of starting
the Cortex-R52 cores in Renesas R8A779G0 V4H SoC DT. The APMU IP is
in fact a power management unit capable of additional operations, but
those are not used by U-Boot so far.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index 90f021299c5..2e731b628b3 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -165,6 +165,13 @@
 };
 
 &soc {
+	apmu@e6170000 {	/* Remoteproc */
+		compatible = "renesas,r8a779g0-cr52";
+		reg = <0 0xe6170000 0 0x80000>;
+		power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+		status = "okay";
+	};
+
 	ram@e6780000 {	/* DBSC5 */
 		compatible = "renesas,r8a779g0-dbsc";
 		reg = <0 0xe6780000 0 0x80000>;
-- 
2.45.2

