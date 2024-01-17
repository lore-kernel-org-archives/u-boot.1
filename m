Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79706C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7C28798C;
	Wed, 17 Jan 2024 23:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hk+qdXwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D82687B30; Wed, 17 Jan 2024 23:24:38 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E88087887
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 173BCB813DB;
 Wed, 17 Jan 2024 22:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D52DC433A6;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530274;
 bh=V2l1s+yxs5Rg0q3C5CYTBAFirhLWFne48i9MYVklN58=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Hk+qdXwLzM98zhuEunZUaDeuqRK1B45uLRd7oqPUxt84XqUZEEYvQ74VKOuNuHrq4
 jKss5FLT7X3pDdP8EJjpEe4WM+SMhjXg6I12uaniVhkHTrijaVSWIOKBc3m4mMmhJ1
 A0PiOmHi8bM4vVEP6pVtNT+s0lbFixkC9OjZgPqVkmokH+uVwHA46+eNyZUnyfCR1X
 pq/wjSkcPkO8P1pdAlSBpsxZoASBcHVL/leAmxbFKX7yHxHmWSS8guR3QSzJP8ER2n
 dIr6dBNqMn/oXPKPrg9Kzb3D+hW+BnGaHlXnnFusMXcIArtyt1sN7AXx9ow3llKkUm
 2gG32SiYLL0bA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC1EC47258;
 Wed, 17 Jan 2024 22:24:34 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:24:30 +0100
Subject: [PATCH RFC 4/6] efi_selftest: Add international characters test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-vidconsole-utf8-uefi-v1-4-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=j@jannau.net;
 h=from:subject:message-id; bh=xhSCbsHJtQ6v72d/HK7UQUIy+oFjZujSPTkEnV2wRR8=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtQVwQseKgff/39tVeY3/XO295eneVs8nDOZc2NDh7W3Q
 tCmMAapjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABPxcmb4n62dOPNw3/mXjRf8
 1r9jd7L6xD0laLbS6pJMv4rMg00sVxgZjjK+1NoWuu/6Yf8beqfCvlS3vMn6G2bJWs2zY2tJ1LJ
 EHgA=
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

UEFI relies entirely on unicode output, which actual fonts displayed on
the screen might not be ready for.

Add a test displaying some international characters, to reveal missing
glyphs, especially in our builtin fonts.
This would be needed to be manually checked on the screen for
correctness.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 lib/efi_selftest/efi_selftest_textoutput.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index cc44b38bc2..2aa81b0a80 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -30,6 +30,9 @@ static int execute(void)
 		0xD804, 0xDC05,
 		0xD804, 0xDC22,
 		0};
+	const u16 text[] =
+u"\u00d6sterreich Edelwei\u00df Sm\u00f8rrebr\u00f8d Sm\u00f6rg"
+u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
 
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
@@ -118,6 +121,11 @@ static int execute(void)
 		efi_st_printf("Unicode not handled properly\n");
 		return EFI_ST_FAILURE;
 	}
+	ret = con_out->output_string(con_out, text);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for international chars\n");
+		return EFI_ST_FAILURE;
+	}
 	efi_st_printf("\n");
 
 	return EFI_ST_SUCCESS;

-- 
2.43.0

