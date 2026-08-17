Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299A3C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02970407B7;
	Mon, 17 Aug 2026 13:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3b9abYl0EHAb; Mon, 17 Aug 2026 13:34:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E125E40819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973681;
	bh=C9jnlAfzcqenjsrkhAnGY67DVxVEOkl2ZS05uSd95Gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vzQyYRpr2p7dT3K4Grp4/uJ3J/3O+a0GrCoK0ibzgPciXZui+0CxIoqgrAmCbMn/k
	 BPymBdgOJs6aW7cqnlitK7zm3m3uTNv3TJZ84Hc6bGgFh9jAGhYbLFF50RI4N1/XAS
	 hX5YLrd49uxpCrtafJ33SPjDbI0542+DuDtZIZCHBH1rCD6a46MHiiYTl3hJXXdUft
	 X2c+fxK3xA5/i10Pf/mKZz8VMI8H3w06VUoN3F5bw4xHStAtfAECNWc2QSL4Uz9Yj0
	 AaYEMIBfdgDirhM0KAtTQn0jFuqbMdOaG+rmaZ/yOjtU+W+Dn5BF3QEaOC00xRvjle
	 kIMv5XKf/rxFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E125E40819;
	Mon, 17 Aug 2026 13:34:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42A4A147
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3513140099
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ql16nZ2NNP64 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:32:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4ED9A40090
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4ED9A40090
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=AnPoAp4u
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4ED9A40090
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:32:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B39641AFA;
 Mon, 17 Aug 2026 09:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17441F000E9;
 Mon, 17 Aug 2026 09:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959127;
 bh=C9jnlAfzcqenjsrkhAnGY67DVxVEOkl2ZS05uSd95Gs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AnPoAp4uLv7bYcRvrjZ5z7UHtjEZihw11Py+6D1Y/GCU4ARX9/KM8G4Hkyj16/d2g
 Cl3g2QdTqvgvEuVG3j8ls5KINLywnjT1aCQgUeufujruwqPe/xkaas5iqlJHpdN5tr
 RW1ibu6mo6IcIant1WSN0qPjlemxMVhC5RV+pTM9qozQTpiXTVnSgv8akK6tiR1FAj
 /xT0OfO+N+u2AU1QpGPVKODxitUW/9W8rGm3x1XzxLgyFZN7yXnY14rxwGkMsy+Utk
 /EEQP9k/SaqA9AUx0Y/D0XoJCurP7Ke+SgzqEMiILXEwGy7ymp+XsAN7JWo0W4qsBt
 Rb1n3juohmzDw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:57 +0200
Subject: [PATCH v2 8/8] arm: u8500: Give Golden panel regulators unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Golden device tree gives both fixed panel supplies the same
regulator-name. U-Boot requires regulator names to be unique and aborts
driver-model initialization when binding the second supply.

Add a U-Boot overlay assigning distinct names to the 1.8 V and 3.0 V
supplies. Include the common U8500 overlay since a board-specific
overlay takes precedence over it.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
new file mode 100644
index 000000000000..647b3f73c413
--- /dev/null
+++ b/arch/arm/dts/ste-ux500-samsung-golden-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "u8500-u-boot.dtsi"
+
+&panel_reg_1v8 {
+	regulator-name = "panel-fixed-supply-1v8";
+};
+
+&panel_reg_3v0 {
+	regulator-name = "panel-fixed-supply-3v0";
+};

-- 
2.55.0

