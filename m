Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53378C5DF82
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 09:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F2981066;
	Tue, 18 Aug 2026 09:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MC7vtBS9hoIC; Tue, 18 Aug 2026 09:00:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA8AF8112E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787043652;
	bh=zC/IemMsWSFE7KR9mWoXuJHYwZ1Seo88B4RxWb3MOT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dE4Sca/1QuBqK3d1V1xcgQBir/Plygj3Ch/GlXCZHYlyaXuaWIqafb4VDXyHtLyxI
	 gpa08MCcIpySgDfkapBGxyj+z9aiKRKoaGrZFCbexsrKBHBc038Q7rIr6inuVyw3Yw
	 mqSLGtpgN98ze2tAcoBq8/tbbb/aK5+b3fE0/lwldD9dvniIs/54RZa6gfP2995nIg
	 0gpEQ7SCzpvP36xJ1GiiXmrDR/T3x+H1w561axaZsr8Rz5q1z4bhGDIr5YVaQF2gm8
	 +hePPEiDorKcscpiCXa5A+DX0rNM9qQJlE8PhrcWXt5tO4FzWqqCejMwAkTssdqmTO
	 o8bWmvVlzBs5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA8AF8112E;
	Tue, 18 Aug 2026 09:00:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58544333
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ACB940144
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVj37QNgM6UQ for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 09:00:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2952040059
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2952040059
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UYoTexwh
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2952040059
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 09:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE86242B9F;
 Tue, 18 Aug 2026 09:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC571F000E9;
 Tue, 18 Aug 2026 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787043647;
 bh=zC/IemMsWSFE7KR9mWoXuJHYwZ1Seo88B4RxWb3MOT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UYoTexwh4qMtzxz7aLgfUCN3+EvlsaHevr5G7Csz+6CmtHvl7ps/exA+AgrqlFDrz
 VHF57meiE4IZ57Bj4Qgd+zobUQ6SrWJCfBCZJ+8ebk5MRpJOkMdO7qWDoYWnlc4WCt
 A5hXa3aWAYiatGXY9f95+JnljmHNWZ8MyiHTU7lRgvsMWYNg9gzVo/DZqLuE6HXFE1
 wOeF+TYjnpqNvnhMjkmG78rioQimX6Xrjo8C3ch6BnGhFZzfJiWCTJN19JjiweEfsH
 3F51mpX1cMS24e6JfHq3hzP6iU4FEOkwnKCTUU+ybR5ssO6bcG13IBzVIA3Ny+JCUx
 BJMBnLn1TMVrA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 18 Aug 2026 11:00:34 +0200
Subject: [PATCH v3 10/11] arm: u8500: Give Golden panel regulators unique names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-ux500-external-sdcard-v3-10-a5d94930f3bb@kernel.org>
References: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
In-Reply-To: <20260818-ux500-external-sdcard-v3-0-a5d94930f3bb@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The Golden device tree gives both fixed panel supplies the same
regulator-name. U-Boot requires regulator names to be unique and aborts
driver-model initialization when binding the second supply.

Add a U-Boot overlay assigning distinct names to the 1.8 V and 3.0 V
supplies. Include the common U8500 overlay since a board-specific
overlay takes precedence over it.

Link: https://lore.kernel.org/linux-arm-kernel/20260817-ux500-dts-fixes-v1-1-24379c6c2495@kernel.org/
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

