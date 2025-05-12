Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5626DC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 16:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D3480C83;
	Mon, 12 May 2025 18:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qjCBTGuG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bEFSIDId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F1C81DD6; Mon, 12 May 2025 18:11:04 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75646805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 18:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Zx4N61Bscz9t0P;
 Mon, 12 May 2025 18:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747066262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iIPsBBpMg26MAxLx+NmiJ0imwt2mANKMQ2eFV2BCB1w=;
 b=qjCBTGuGB4W8/05jjou8DVqHvE6VcYSPUqJPU6k5+qFjTPn91sNCuAjge9R4uyldxEiZjx
 hmGQcoIMySmkEHJf3kexDFq9XVRuVeLrvevmx98R7UncQ4BEVdtI5R8il7gVBtvckO32qV
 etKH0PIV1VHFaPRqVSQRTUUHPXHC+TDSFsHFCM83AigL1get2K/Ot9V3fB8ycq/+jmCa6p
 kWqfoajT1zHzu1wfJ9W3qV9/mg+5o9bslvmLaiAVFehaH2FjpEMRs1VH2uOy06pOloLQBh
 UOvZJF3iyhqrH14ivKhSrmGC/cF+Lq4Z0VieVyNR3AFG7Hb5eV+V8ojzLqmkXg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1747066259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iIPsBBpMg26MAxLx+NmiJ0imwt2mANKMQ2eFV2BCB1w=;
 b=bEFSIDIdBMRxiOZd3Xk0th49MxRuwYY45SL7EVyQKIO9IAcbI7JuNXDztLVmPRmG/if6+M
 J1Px7ZkkDROrzsdHuDOCPcTcap3iewjbffu7gz/zdOyGyY1xspQnLtuwNwFqZCz6Of2CL5
 +VVNY2vt3bIZZ3F+ZENiehO2tcOJQ98AaPa8WRnNjbeNv4gkMW396nyddphUqjBxdpN0Ji
 ugIyoPra+WnZwCQD6ejq5/bc8+ouDxgY4DKlfSu65hmCISzd08rOcuczZMBc8bDgawYAYh
 n55ymnDxXpJBgLk5IpBjvmHup073D4yy6rgwfABwgABw5/UXA0ab6QOH+VAZkw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: Align image end to 8 bytes to fit DT alignment
Date: Mon, 12 May 2025 18:10:28 +0200
Message-ID: <20250512161033.146396-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hhbc9buo7szhqr6m8b9zg44o9h6mhzhn
X-MBO-RS-ID: 8eab160bbc25a819b58
X-Rspamd-Queue-Id: 4Zx4N61Bscz9t0P
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

Align U-Boot image end to 8 bytes to make sure DT alignment requirement
is fulfilled. This fixes a possible failure in fdt_find_separate() in
case the U-Boot image is aligned to 4 Bytes and DT is appended at the
end at already 8 Byte aligned offset.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/cpu/u-boot.lds | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index 817e7a983ae..b2109e03ce3 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -153,14 +153,14 @@ SECTIONS
 		__efi_runtime_rel_stop = .;
 	}
 
-	. = ALIGN(4);
+	. = ALIGN(8);
 	__image_copy_end = .;
 
 	/*
 	 * if CONFIG_USE_ARCH_MEMSET is not selected __bss_end - __bss_start
 	 * needs to be a multiple of 4 and we overlay .bss with .rel.dyn
 	 */
-	.rel.dyn ALIGN(4) : {
+	.rel.dyn ALIGN(8) : {
 		__rel_dyn_start = .;
 		*(.rel*)
 		__rel_dyn_end = .;
-- 
2.47.2

