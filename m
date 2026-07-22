Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D0FC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 22:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63A1580F38;
	Wed, 22 Jul 2026 22:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_Dgf65O_Vi5; Wed, 22 Jul 2026 22:54:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B035680F43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784760872;
	bh=xTtznC98LHZfcdrIBx3s0ePUA1DWqDpWlUhOrSgRw4A=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=Zqw9WS44d+ti1ty5lV7dLcQmh50TxSuyGSRfHBqMoo+RHf74wQEbDCm4xX6osiObR
	 Sww63cCQVunW97rTolA3fwqZ5DbqdSnIuDb4eVVj0ATS1aiJtCDg0kntY2p++v3oaY
	 KwenX7GIubdJc1SLPPs0aDMZGvqoJdbt3Z50KMJ7VXyKwSCezcz50vUWmrL+ch1K6/
	 n0dNbIMFRDWnln3AJkR9J+C9F7XjIZ5ZirZzrdaLFBrj9kI65/pn3zjN6qroNq670v
	 r+RxglaqY5aWa5TzgfiG3bzIz9GRjTF9cEu0sRe5fS20pzMGuzQkAF+wbcytmpbUOV
	 oKNUb6/C7Zmeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B035680F43;
	Wed, 22 Jul 2026 22:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1048B2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA85240A0A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RgaQoOnJk0Ro for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 22:54:30 +0000 (UTC)
X-Greylist: delayed 97553 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 22 Jul 2026 22:54:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 14C8140A09
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14C8140A09
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14C8140A09
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 22:54:29 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h58hL67GMzMlHx;
 Thu, 23 Jul 2026 00:54:26 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: renesas: Add SDK SCP 4.36 map to Renesas R-Car R8A78000
 X5H CPG clock driver
Date: Thu, 23 Jul 2026 00:53:37 +0200
Message-ID: <20260722225422.88023-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 84h7hguyn3zahjaggtrj45sdmzad7hyq
X-MBO-RS-ID: 5350181e56cfc96fdce
X-Rspamd-Queue-Id: 4h58hL67GMzMlHx
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784760866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xTtznC98LHZfcdrIBx3s0ePUA1DWqDpWlUhOrSgRw4A=;
 b=wrYhYifu2yi3yEOA20g88YtqqgA3n0KiLKDWlueMmguHiPw115pgkbQbZyL2RT6DqSKv3o
 ulOwWRCl471qKuGwRDwoJUxHujlXMF5dJ8JPfmZmPS4e/M3A36ie3LzRX1ejnt13HiTWOO
 ztHt6Qi+/sMA1SdHmsSwzpd3PVRBNbGyt7/r/LIuS4pO3zGpqtK6gWlXEW7KGQON2LoskA
 gSw/fs4BZef2/Mc8yOxHAJwx4GCSSxT5IeVYoMVlk5l1ci3T3nhbLUAwkyWIJaUOVfzlKw
 pvXBfRWlY1sDJSq4P7qbRRngv5dZ9ju+k23f0d64YR9ievWRkPvuHuaNz1/Tbw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784760865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xTtznC98LHZfcdrIBx3s0ePUA1DWqDpWlUhOrSgRw4A=;
 b=GJyyOxoMV7h87liTm1+8Z1MK9M6hjuQQIuiO5cfjLZdM2EEaODR8wPiDAurNB8qx0eP9Zt
 RsoP9OJyBGi42GW53uOUudn6dXGQ3pVBf+dz2SwZwurHuKVZA8MCYzUnNnb1EjT4CGe5iV
 axw2F4Bdku8zP0nHCv+VVT67LCBK5CBy+MflAzgrOghNgjeC2AMv9YWPQdufNTJND7q172
 d4k2jsrUzvSxCPBPurTpcZ7iSAdEOOix6lc7bG1g3JdzRLeEOV1hWU8awf0YpBP4acNSco
 YMVte+HxfXUJcrpqzy8Nv3xa3Y8rp5Dpkk0Rz8i5f+nMLtuRhqsJL+qmwCRjNg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=wrYhYifu; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=GJyyOxoM
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=GJyyOxoM;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
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

The SCMI IDs did not change between SDK SCP 4.32 and SDK SCP 4.36.
Add SDK SCP 4.36 as supported version and reuse SDK SCP 4.32 remap
table.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index e9ca06476f6..67d820bbde8 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -105,6 +105,7 @@ struct clk_map_in {
 #define GEN5_SCMI_SDK_4_30		0x010c0000
 #define GEN5_SCMI_SDK_4_31		0x010d0000
 #define GEN5_SCMI_SDK_4_32		0x010e0000
+#define GEN5_SCMI_SDK_4_36		0x01100000
 
 static const struct clk_map_in gen5_clk_map_dt_sdk_4_28[] = {
 	{ SCP_CLOCK_ID_MDLC_UFS0, 202 },
@@ -186,7 +187,8 @@ static int gen5_clk_of_xlate(struct clk *clk, struct ofnode_phandle_args *args)
 		map = gen5_clk_map_dt_sdk_4_28;
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_28);
 	} else if (priv->basever == GEN5_SCMI_SDK_4_31 ||
-		   priv->basever == GEN5_SCMI_SDK_4_32) {
+		   priv->basever == GEN5_SCMI_SDK_4_32 ||
+		   priv->basever == GEN5_SCMI_SDK_4_36) {
 		map = gen5_clk_map_dt_sdk_4_31;
 		map_size = ARRAY_SIZE(gen5_clk_map_dt_sdk_4_31);
 	} else {
-- 
2.53.0

