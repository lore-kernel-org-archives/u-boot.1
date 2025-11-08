Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0359CCFA13
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 13:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7303283EB7;
	Sat,  8 Nov 2025 14:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DMtaAFB0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E257883E72; Sat,  8 Nov 2025 06:38:34 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC9583E81
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 06:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+dang.huynh.mainlining.org@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F2A1744493;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D650BC19425;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762580307;
 bh=E2iyK7L5hZGjVAvJ3XeyONClrO7qN9WiC0rPIx3lsSY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DMtaAFB0VAB0TZTnQpXzDS4JEQb+5VIdKUtweKSZV8aMQlZF6ayruD/xgg+l3/Pyx
 e7fvQ69YHyNQWq3oWVkGQrGKd3gHkNVRAZaJEy5+Mrrvj41rY4fZjMtNZBvN+isl05
 L7L8punuac2k5FxtZ1RrxFtTGEbvnrCKGs+pVsOrdukxayKAjMT/Nym9R8iod3PsJO
 5ZsRa+rVm7Fno+DN4gvpynV7TU1sew2N2nemxOJGblwh9mpF7pQcYDXdLfsAv0+OWK
 RfcN40OjFt/ilk3COhqULHOlg+atkvbbwkXPHFjZqhY3HN60nroxuNhKKT32eIENHP
 TSrFaAGScohrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D0C55CCFA1A;
 Sat,  8 Nov 2025 05:38:27 +0000 (UTC)
From: Dang Huynh via B4 Relay <devnull+dang.huynh.mainlining.org@kernel.org>
Date: Sat, 08 Nov 2025 12:38:04 +0700
Subject: [PATCH v6 08/12] arm: dts: rockchip: rk356x: Prerelocate VOP in
 U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vop2-pt2-v6-8-d04c699262fb@mainlining.org>
References: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
In-Reply-To: <20251108-vop2-pt2-v6-0-d04c699262fb@mainlining.org>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ondrej Jirman <megi@xff.cz>, 
 Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dragan Simic <dsimic@manjaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Piotr Zalewski <pZ010001011111@proton.me>, 
 Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762580305; l=566;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=5I30AlGYVLKJp+oQjDrislkk86yMIEw46an0SuM8cSY=;
 b=ZFsaj5B/5KdIYDVNubYZ4NBkx8o4HXGH2rWDz4uK0YTNy10jQEG/0j7d4wUhCtoP5JW5Emih2
 DK9mwHFZyKtCUfstOMSlSMKV3U2xeT2Jcfh2tkzA4W8nK8W+k9kQzAP
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-Endpoint-Received: by B4 Relay for dang.huynh@mainlining.org/20250917
 with auth_id=526
X-Original-From: Dang Huynh <dang.huynh@mainlining.org>
X-Mailman-Approved-At: Sat, 08 Nov 2025 14:06:07 +0100
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
Reply-To: dang.huynh@mainlining.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Dang Huynh <dang.huynh@mainlining.org>

We need to prerelocate VOP2 memory so the driver can work. This
will only support U-Boot proper.

Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 738b9673d35..1ed06239f05 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -170,6 +170,10 @@
 	bootph-all;
 };
 
+&vop {
+	bootph-some-ram;
+};
+
 &xin24m {
 	bootph-all;
 };

-- 
2.51.2


