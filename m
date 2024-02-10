Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C0C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 12:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF5B587EBB;
	Sat, 10 Feb 2024 13:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pyxTIsAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC31C87EB3; Sat, 10 Feb 2024 13:47:02 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7DDA87EB0
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 13:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 743CECE16AC;
 Sat, 10 Feb 2024 12:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D7FC433A6;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707569212;
 bh=FEDqLydM+FFw2JowoI5UJYQfpgkU34t4LgGNMGxZBn0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=pyxTIsAiHnDZpJbjyrmVq0J/rxkYOgHVGo8kHNCOSMdlJxqcVvnsqQLNcFEcOzzEE
 vWV4o4NMYaLb0t+zz7AAWgp9dXyZoo8xscgSOeibNVLkXPVGf+oJx5uz/n76sY5oVf
 yZAhdMN48pDFTxvNxuAPPEKrKV6bOZutAkfVeXbmB+GLVgJk6jtal+Oc1gtE2FXiBO
 /W7gbH1YFshbanjYAfNdXDe04tofBrQPxYY86ctnwtBkwXwjyMpTxO5tm2jg2h7cUa
 HHslYovyJZA7WZz7banIkQCgA7fI9Y2YdTBWkESH7TAkD5jonY7SqEQfyP86/0DK/c
 dlVLNcihzKMkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4AC4829C;
 Sat, 10 Feb 2024 12:46:52 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 10 Feb 2024 13:46:43 +0100
Subject: [PATCH v2 5/6] efi_selftest: Add box drawing character selftest
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-vidconsole-utf8-uefi-v2-5-88c03db60de2@jannau.net>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=j@jannau.net;
 h=from:subject:message-id; bh=GZoCC0DSNZV6PjfmSuk03NSxTlmJrrpiaf8kDJ9d6uM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtTjBVbNeext+zyeW+u8fsXjxH0l6L7V9buTpsmJ/nrse
 2TWva09HaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACaiPJGRYd2vwON8AQc9vQ+V
 BAYEiPiVTg9e0KW2/cHD+XnzuXRaEhkZDrOyH/O+0lc0lbe2smnF+W18dhvC813LpcW1znzafuE
 rKwA=
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

