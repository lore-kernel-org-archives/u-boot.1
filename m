Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28776CD6E6C
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 14:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824EC8394E;
	Thu, 13 Nov 2025 15:30:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hFHgnoTc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rx7c7XKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C8583E7A; Thu, 13 Nov 2025 15:30:12 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E2E8003E
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d6jNL0gYTz9sbt;
 Thu, 13 Nov 2025 15:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763044210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CZmDFbGtpLfQD/oewnAyR4IpKA6RE2NrE+aG+Q7fEeQ=;
 b=hFHgnoTcL53A2lufdcw9PcWsOwbXyrzsuCQBgCXUVjnEucj/1W63DYq9XtrNQ/h4gjIZCF
 eAs4uQoyrW7LKhorcT9lyAU6RIfGPJD62Na6Nh/ahpcCMWpxwKB9LquSkB0Ln/xG+dDEqi
 9kH0Te+rpE60xA/nGxYG2HPiy7SVYKyday1u0CKasBAb06qusRsemuPWDc3Y0d8gpML+oa
 vDL/YrSkYN6okP4GaNT1NJpLTXgxZbNNg0jzFNTs3X2+cC1GF+8Wrig0TsvvfVp5rh8gbj
 cQK4XiyYFvU+1pdSxofuC+g0yXiRhsgzSPnyL17XePgwozWhss4V9ySULU5zdg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=rx7c7XKi;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763044207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CZmDFbGtpLfQD/oewnAyR4IpKA6RE2NrE+aG+Q7fEeQ=;
 b=rx7c7XKicWmXqvsjDcXY1zkptdTaZ+Ua8cNjDVGqQdjZzUwgBa7hXJBz2SFg0RraGhgkxy
 UBVQQCMNz7eloPavjt3SkeaUTV9n825x4pqTvDqGw4xJp9+XmhZF/2Af0AQvAx8a98ajck
 DiVVo8E8AptbVmtrE4vpZrK5GZSumQ+s0ho9f0KOM3SgNOG1e+L1Evm223U+AHmX/uYAAd
 zKHXN7Wajt6VHzCTAK6DOC62VAom7qpy0Mfa8LpRxzfdKHmO6TOiiGTsdjfFsMBDhSF+Ug
 Cv4W3NgBamhR7lSYUUwVRd3EBRfUt4eYeM62ZI1PPUWQ8TiIzi972xSKGEQwYQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] boot: Warn users about fdt_high=~0 usage
Date: Thu, 13 Nov 2025 15:29:51 +0100
Message-ID: <20251113142957.1069909-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ea4f354e8731671f9a2
X-MBO-RS-META: idj3esz7xqwdhg45qc6hxbkpyxopfze1
X-Rspamd-Queue-Id: 4d6jNL0gYTz9sbt
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

In case the 'fdt_high' environment variable is set to ~0 and DT is
at non-8-byte aligned offset, warn users about the dangers of the
fdt_high usage. This will hopefully lead to removal of most of the
fdt_high ~0 usage over time.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "João Paulo Gonçalves" <joao.goncalves@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/image-fdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 3f0ac54f76f..e88525a3846 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -189,6 +189,10 @@ int boot_relocate_fdt(char **of_flat_tree, ulong *of_size)
 			/* All ones means use fdt in place */
 			of_start = fdt_blob;
 			addr = map_to_sysmem(fdt_blob);
+			if (addr & 7) {
+				printf("WARNING: The 'fdt_high' environment variable is set to ~0 and DT is at non-8-byte aligned address.\nWARNING: This system will likely fail to boot. Unset 'fdt_high' environment variable and submit fix upstream.\n");
+			}
+
 			err = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
 					    of_len, LMB_NONE);
 			if (err) {
-- 
2.51.0

