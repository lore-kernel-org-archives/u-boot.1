Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03288C48BF6
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 21:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE9D8801D;
	Sat, 16 Mar 2024 22:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OaSnc9tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9398D87D09; Sat, 16 Mar 2024 22:50:32 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6E68800B
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 22:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C2AD66069F;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D123C43399;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710625826;
 bh=iV6It4X1DC/19Z7SUI4LQcOh1RsflLqegwHHHxOV7eI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OaSnc9twSHPTOm6YHXKimAz1x+gYVDCQXlIxU8mAuQf3lI0+X1il7izOxWp7RPRxs
 3ZC1ZGfEnTL//szDFxlQd3Wjmb5hTBgvuuzvB9odH0ZKdu6WTme4wPn2FLxNv5qCUJ
 qpGR+yPJkQbsxO7hzfruFaIe+7SfGgYHG7F/M37SgKoyU9hc+my/NsrsOCkKPUqRj5
 qkMOH+c1GRAM4Yon+R2w/04/7vjkp6Tb+jWBqewrxMDT/eAj/xzn5xpXGCRloFD0DC
 navChMNNap7+9t0ds4dtKx+M7djDLEbRUJ4lWl7o6+jw56VeSNUilCQIyrv14suivf
 GHOMa8Wahph+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 614D1C54E6E;
 Sat, 16 Mar 2024 21:50:26 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sat, 16 Mar 2024 22:50:21 +0100
Subject: [PATCH v3 4/7] efi_selftest: Add international characters test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240316-vidconsole-utf8-uefi-v3-4-4e8a3d349447@jannau.net>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
To: Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141; i=j@jannau.net;
 h=from:subject:message-id; bh=vvgCL+bpYJ3yFHjvmsah3TdozXuBIy3nC4D7AIESVaI=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtRvIgqxylPdZIsfLsxkqRQ7H3xO/sbyCR9SK9iyzEoD1
 bJvlRzsKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJHaWIa/Ao5aa7kOCBu9PDBx
 w8ywLPfYpK7k2KW+Yt77+Ju05J8vZmS4wSk/T37ffSfL9qUhqlZSv8V3y52KnbBNi3uLNuOKyMP
 8AA==
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
 lib/efi_selftest/efi_selftest_textoutput.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selftest/efi_selftest_textoutput.c
index cc44b38bc2..917903473d 100644
--- a/lib/efi_selftest/efi_selftest_textoutput.c
+++ b/lib/efi_selftest/efi_selftest_textoutput.c
@@ -31,6 +31,21 @@ static int execute(void)
 		0xD804, 0xDC22,
 		0};
 
+	const u16 text[] =
+u"This should render international characters as described\n"
+u"U+00D6 \u00D6 - Latin capital letter O with diaresis\n"
+u"U+00DF \u00DF - Latin small letter sharp s\n"
+u"U+00E5 \u00E5 - Latin small letter a with ring above\n"
+u"U+00E9 \u00E9 - Latin small letter e with acute\n"
+u"U+00F1 \u00F1 - Latin small letter n with tilde\n"
+u"U+00F6 \u00F6 - Latin small letter o with diaresis\n"
+u"The following characters will render as '?' with bitmap fonts\n"
+u"U+00F8 \u00F8 - Latin small letter o with stroke\n"
+u"U+03AC \u03AC - Greek small letter alpha with tonus\n"
+u"U+03BB \u03BB - Greek small letter lambda\n"
+u"U+03C2 \u03C2 - Greek small letter final sigma\n"
+u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";
+
 	/* SetAttribute */
 	efi_st_printf("\nColor palette\n");
 	for (foreground = 0; foreground < 0x10; ++foreground) {
@@ -119,6 +134,12 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 	efi_st_printf("\n");
+	ret = con_out->output_string(con_out, text);
+	if (ret != EFI_ST_SUCCESS) {
+		efi_st_error("OutputString failed for international chars\n");
+		return EFI_ST_FAILURE;
+	}
+	efi_st_printf("\n");
 
 	return EFI_ST_SUCCESS;
 }

-- 
2.44.0

