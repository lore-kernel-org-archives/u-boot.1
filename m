Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A788C54E60
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFF88803A;
	Sat, 16 Mar 2024 22:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+SFB7wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B06A88041; Sat, 16 Mar 2024 22:50:34 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404BB88018
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F283C60A6A;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758CFC433A6;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=c8ly7lUZVcLDo2iF0sV3oPFecMZ2nLKBgi65IvrlYAA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=O+SFB7wt7z7DNnYkbZy5V4CdYkcwoPqr2UqUz7F6FzNcQAZLYzzdOllSn7Tb244ny
 6KknANpUfxcDbDSNmnbjoZwbDVazr9+rV9vjVGssXiNvz7rIKpsMVxNB12OPRGsY0U
 Sq7qA9hgRVJMul3uUzEn6l7uROHmCBN/92SOPqHkx9bsDhvuhZ5gvPgzbm4zLKqjqx
 ERLHreHmdTG4uy41yViMFRZQsD4BHArAXHrkWY9xAJ9f3UGvljj2j/sbvpbUijGDl7
 QczQQXDrx390Uev/ojIlT9vDKpysNvP3vvBJvXKpYWyVcR4p/9Z/SIDXBpV9+um35G
 m7PLbvCyVTgfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC2AC54E68;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 16 Mar 2024 22:50:22 +0100
Subject: [PATCH v3 5/7] efi_selftest: Add box drawing character selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-vidconsole-utf8-uefi-v3-5-4e8a3d349447@jannau.net>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=j@jannau.net;
 h=from:subject:message-id; bh=wEwJ0xrzxZBgOxXNRFVt8QAxWgkeF7bJcOttXZyj7lI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIgrKe6RdngaF9wdx6uXNfD3Jjn+HW+ppP2kpq4TfX
 xYuPMHQUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJJiQy/WZg3+snz3Q44t+v3
 xFKGtnfG29I+Vc3aHbRnO0vjY45Ndxj+2dpZL1zPZ1Fmpdc/Y+blGY7rFrbNFPd7p7Fjqsil7O1
 6jAA=
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

From: Andre Przywara <andre.przywara@arm.com>

UEFI applications rely on Unicode output capability, and might use that
for drawing pseudo-graphical interfaces using Unicode defined box
drawing characters.

Add a simple test to display the most basic box characters, which would
need to be checked manually on the screen for correctness.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_textoutput.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index 917903473d..b56fd2ab76 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -46,6 +46,20 @@ u"U+03BB \u03BB - Greek small letter lambda\n"
 u"U+03C2 \u03C2 - Greek small letter final sigma\n"
 u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";
 
+	const u16 boxes[] =
+u"This should render as four boxes with text\n"
+u"\u250c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
+u"\u2500\u2500\u2500\u252c\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
+u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510\n\u2502"
+u" left top    \u2502 right top     \u2502\n\u251c\u2500"
+u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
+u"\u2500\u253c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
+u"\u2500\u2500\u2500\u2500\u2500\u2500\u2524\n\u2502 "
+u"left bottom \u2502 right bottom  \u2502\n\u2514\u2500\u2500\u2500"
+u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
+u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
+u"\u2500\u2500\u2500\u2500\u2518\n";
+
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
 	for (foreground = 0; foreground < 0x10; ++foreground) {
@@ -140,6 +154,12 @@ u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";
 		return EFI_ST_FAILURE;
 	}
 	efi_st_printf("\n");
+	ret = con_out->output_string(con_out, boxes);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for box drawing chars\n");
+		return EFI_ST_FAILURE;
+	}
+	efi_st_printf("\n");
 
 	return EFI_ST_SUCCESS;
 }

-- 
2.44.0

