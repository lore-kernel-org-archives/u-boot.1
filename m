Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BA0C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A3987A14;
	Wed, 17 Jan 2024 23:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtHasoQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6290D8798F; Wed, 17 Jan 2024 23:24:39 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80CC8795B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 4064EB815BE;
 Wed, 17 Jan 2024 22:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC21C433B1;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=FEDqLydM+FFw2JowoI5UJYQfpgkU34t4LgGNMGxZBn0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BtHasoQZP9vVMDkUiX9LMUuLG4gY7qujB9p94y43QwVpPvPBrvtHeCPraosmFa3w0
 uCBlBzqzwZK2PQS9dbKCVOGF63DYjrpsvJ4/+3ZlqEK7A2sYj/SUGvlS+ZBby/opEH
 XqP410Z+6tJse6clmprRtFFaWKivj6P4UXgP6La9UfFnB5gdyyJZ1cNAMhwCOPC0Kb
 J4an33D6cpsDXlHxVAz0tkwwaXEoFZeax4MClgFPLsAeZyaDXZss5xK3cORpCMRf7M
 41bM+Laj/nqKBI0PQEnJWoEnm51dNohMx48zd/Mfr3mEiFGS6PyTs/dU4kekGZqS89
 iDM1afY+Tapuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE8C47DA2;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:24:31 +0100
Subject: [PATCH RFC 5/6] efi_selftest: Add box drawing character selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-vidconsole-utf8-uefi-v1-5-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=j@jannau.net;
 h=from:subject:message-id; bh=GZoCC0DSNZV6PjfmSuk03NSxTlmJrrpiaf8kDJ9d6uM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwQuWmgqXuD79wpIorm6fURj2e12mat+rdUve3Cg/H
 MiSKWLXUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCJfLjP894+71p584dx3NVOn
 ad3nS60tsmY5dUSxbTSIzlkx3+GFIsNPRp+dBvN+KkcnT/S0EjRiL9NIv9+Zc2oZh+/stbcSHFn
 5AA==
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
To facilitate this, add a three second delay after the output at this
point.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_textoutput.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index 2aa81b0a80..cc11a22eee 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -33,6 +33,19 @@ static int execute(void)
 	const u16 text[] =
 u"\u00d6sterreich Edelwei\u00df Sm\u00f8rrebr\u00f8d Sm\u00f6rg"
 u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
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
 
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
@@ -126,6 +139,13 @@ u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
 		efi_st_error("OutputString failed for international chars\n");
 		return EFI_ST_FAILURE;
 	}
+	ret = con_out->output_string(con_out, boxes);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for box drawing chars\n");
+		return EFI_ST_FAILURE;
+	}
+	con_out->output_string(con_out, u"waiting for admiration...\n");
+	EFI_CALL(systab.boottime->stall(3000000));
 	efi_st_printf("\n");
 
 	return EFI_ST_SUCCESS;

-- 
2.43.0

