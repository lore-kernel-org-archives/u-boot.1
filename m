Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E2D0C604
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D5F88C53;
	Sun, 27 Oct 2024 03:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Mryb++dW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mK1PtxZe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D6588C10; Sun, 27 Oct 2024 03:11:10 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF6B88EE4
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Xbg3n1vPlz9srJ;
 Sun, 27 Oct 2024 03:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+0gZirAb/iB9YcvOtVHmROl04POvhf7CJCcSwK9RU8=;
 b=Mryb++dW8Ann9QXT0LyHvco8guFUHHrvCeOwjGi4+2PLkftVQ5HXneGAmzPCT1+stsgBk8
 IryHTt0snyYXk0f9Tt0RWRaLxE5NLsPZrcnJkPpNCUqlbJkkHPhQp5XaMjLnE5AV3feTTj
 K/kkgGN6O4eTDAFyZURCVo/o6BOcUd+dcxpMbzGI+I/6t3br1jrhty4TPM8IyPpkKtD778
 FCv8YJde+5Zl4Mn9xk0gJzvjZPWAkxnbQLnX0n6R2GQoe6QcbGO7cRZB91LKdEqSoJrj0J
 kS7sU6HeOOVBTNRUsZ8QL1asL95TP1+hBGSAclpEsrm7RDGWrRtkxo0WwX9WjQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729995059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+0gZirAb/iB9YcvOtVHmROl04POvhf7CJCcSwK9RU8=;
 b=mK1PtxZe3e36lPLBQOF6PZreTbLEWcJFGBKgJVWS0OJFgG6ikX+Ut8zi7b1NY4f9aOQDO7
 xcwVusJ0x5P9D67lUCwp41HkxKk7Rsbe53CgEzRMtaea5LmqIPIAXarNtYrNc6eclwNOCB
 D2OlqGda7REcbPNGDmPfWI8abRGidglrq6jo27nqxteiZQAWVZ521R2AxSVtJsWTAsPCWg
 1dmJszeFvnFx6u4bSpbLPt12VJxjgdWHiAwTWxpD5utonXjjVQ2QYA4YN9EuZT7yZxSrS1
 XeTJf/EsCaFeMAHeA3pw2CpG7H8KIFm39NHr1elWqIo4EL9ZYvyPc5KfLdV4Rg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] ARM: renesas: Add top level board/renesas/ MAINTAINERS file
Date: Sun, 27 Oct 2024 03:10:32 +0100
Message-ID: <20241027021045.355625-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f71punhy47upef9yydnyp5mq5mwbgpas
X-MBO-RS-ID: aa88cedf1edf4264041
X-Rspamd-Queue-Id: 4Xbg3n1vPlz9srJ
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

Add top level board/renesas/ MAINTAINERS file to catch all the common
Renesas file patterns and put people on CC via get_maintainer.pl script.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Replace boards with board in commit message
    - Add rzg2l and r9a0
---
 board/renesas/MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 board/renesas/MAINTAINERS

diff --git a/board/renesas/MAINTAINERS b/board/renesas/MAINTAINERS
new file mode 100644
index 00000000000..13551cdd2b4
--- /dev/null
+++ b/board/renesas/MAINTAINERS
@@ -0,0 +1,17 @@
+RENESAS BOARDS
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
+M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+S:	Maintained
+N:	grpeach
+N:	r2dplus
+N:	r7s72100
+N:	r8a66597
+N:	r8a77
+N:	r9a0[0-9]g
+N:	rcar
+N:	renesas
+N:	rza1
+N:	rzg2l
+N:	serial_sh
+N:	sh77
+N:	sh_eth
-- 
2.45.2

