Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D12E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38CD884238;
	Tue,  3 Feb 2026 14:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="eNmLfIUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4578410B; Tue,  3 Feb 2026 14:09:15 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92127840B1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6609D26F7B;
 Tue,  3 Feb 2026 14:09:11 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4QGYfHQWmx8; Tue,  3 Feb 2026 14:09:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1770124150; bh=bBK0Mq/HEThQQBCD4RWrA0Y0aFtFAv5RqgmSFfbraJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eNmLfIUiI9yoV9L4wJKM1MZLEO9ZOkDMXqBW+AZiZ4KQ4V22dpD8TXGpO3JsOkSrH
 kZ/2Nd5TLW5QPOa+0mItqVmwn52x4pyu4TB3BycdC117YWWjxLfFOMcjXXc8cR7I5Q
 qjFE6KKy5bN6ELTDtE0/r1LbiiN50ZQRushsNeNrgAmKH1jpdD1mR407yx/K/UYd6c
 pZa01CqbjB+QnVkcRyy6mA38gcKEGI3jFZjh3YmBFE4/ON61Jcfld1Qkh8FZ84W2QQ
 kx0vjEd5ayCyohANpUy8jhByvBwR1CwCeBr0jOKhpTUCpvtOlxrs/W1l25OYMazWzp
 Wft2808L1MCfA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Tue, 03 Feb 2026 18:38:46 +0530
Subject: [PATCH 08/11] ARM: dts: exynos7870-a2corelte: add properties to
 make S-BOOT happy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-exynos-mobile-external-dtb-v1-8-a16a0e57991c@disroot.org>
References: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
In-Reply-To: <20260203-exynos-mobile-external-dtb-v1-0-a16a0e57991c@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:35:06 +0100
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

Add properties in the DTSI file which is required for S-BOOT when used
an external device tree when booting into U-Boot. S-BOOT is Samsung's
proprietary bootloader, which chainloads U-Boot.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi b/arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi
index c22ed7efea5..7d97afcc64f 100644
--- a/arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi
+++ b/arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi
@@ -4,6 +4,11 @@
  */
 
 / {
+	/* These properties are required by S-BOOT. */
+	model_info-chip = <7870>;
+	model_info-hw_rev = <0>;
+	model_info-hw_rev_end = <255>;
+
 	chosen {
 		#address-cells = <2>;
 		#size-cells = <1>;

-- 
2.52.0

