Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB69C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E9B8808B;
	Sat, 16 Mar 2024 22:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dksBr6Y1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3558E88018; Sat, 16 Mar 2024 22:50:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D7C8802F
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F289E60A6C;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D39BC433B2;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=B/C0wjgBkZr7SXKxNej8ieg+Oux2+g9tTinular2ev0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=dksBr6Y1qPL9rYXQ8q5fK7YOLl/Vquvr7mLrHIPbIjRyCiJCqzf6444AcAg/5kPFQ
 kMz1SDy5jm5l51Iy0tPXoU7C6yuBarjBGUNz4nipJ/gEl1+ZAZ9phhVwJ/ivehnNT6
 jsw+ANu8erAh5qG2CaXadx4ejR7U/AkhEG8b0YKzRddT5c48sCo1SJRB9oNFAfg/q/
 hpC7acMDgl3wBa3Cxia2OWcMSaDJHFSF5UVF2WH1KSmvEdnG/mL/8jV/DPtTwoLZvM
 CUCO9Ma1ilmzE7QO3bcvv7cK6R1JemOLuJzBpOuayGwCphcByWepWNXANvYNqVGtx1
 Ps/Ns1glHQo4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 76705C48BF6;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 16 Mar 2024 22:50:23 +0100
Subject: [PATCH v3 6/7] efi_selftest: Add geometric shapes character selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-vidconsole-utf8-uefi-v3-6-4e8a3d349447@jannau.net>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=j@jannau.net;
 h=from:subject:message-id; bh=hYWsFfe9/MO1IcHBjYtWqpX5zvOcIH05xUAd27c+G1g=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIgozRXfmnJYoFZe4uE1RaO2ko94cYnJqb6euvG83n
 c1eQVa4o5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwEQuJTD8swuX9eRYWvkmob05
 q9j4Gk/qz/VxoVrzZL79Ond6RRvnLkaGbQ1f2izMu+NC2eZ0mT/uDlmlGRHx66WlQtqB+zo/bKd
 zAAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Draw symbols from Unicode's "Geometric shapes" page which translate to
code page 437 code points 1-31. These are used by UEFI applications to
draw user interfaces using EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.
The output has to be checked manually on the screen for correctness.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_textoutput.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index b56fd2ab76..2208a9877a 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -60,6 +60,13 @@ u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
 u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
 u"\u2500\u2500\u2500\u2500\u2518\n";
 
+	const u16 shapes[] =
+u"Geometric shapes as described\n"
+u"U+25B2 \u25B2 - Black up-pointing triangle\n"
+u"U+25BA \u25BA - Black right-pointing pointer\n"
+u"U+25BC \u25BC - Black down-pointing triangle\n"
+u"U+25C4 \u25C4 - Black left-pointing pointer\n";
+
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
 	for (foreground = 0; foreground < 0x10; ++foreground) {
@@ -160,6 +167,12 @@ u"\u2500\u2500\u2500\u2500\u2518\n";
 		return EFI_ST_FAILURE;
 	}
 	efi_st_printf("\n");
+	ret = con_out->output_string(con_out, shapes);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for geometric shapes\n");
+		return EFI_ST_FAILURE;
+	}
+	efi_st_printf("\n");
 
 	return EFI_ST_SUCCESS;
 }

-- 
2.44.0

