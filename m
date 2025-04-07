Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C58FC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CF882E38;
	Mon,  7 Apr 2025 14:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ohpFsjM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033CA82CA4; Mon,  7 Apr 2025 08:44:05 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4EED82C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+gchan9527.gmail.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E9AFC61129;
 Mon,  7 Apr 2025 06:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 156D9C4CEDD;
 Mon,  7 Apr 2025 06:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744008241;
 bh=dIEnWBb3/vJ80+VQYxjPTn/FNs2QxMf8vpt/0QKgMrU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ohpFsjM1D4mYcIBzKOPWz5RArfpWDoULqEPEmkfh1gz/3DqvrpRCRGHw/iqOLs1mQ
 rWEXOKtolhEmJRRpTJDczEmgRsoq1oaAhhA5Bl1iADXa/1H0LO6CpcYVDGmEGN/fqj
 58ibGd2nV8ojk7BYaDE/nnUv604VLRLAmJQfdi3RVvszYyRNoLE71VYzcfrXztKIoE
 Z4gFnS88m4svILilym1Rr/cKhVzpGyGC5FSZMRdJI/gB3a+fIpse1oi99ikZDxHl+v
 ziY0KypSvc6RjMYtEyxZCWft3OoqPaKuTt+6QQlxd/D+5ZYb/pdEMECDRII4CgZVaA
 hYkiDoDnCvOuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F1C35C36010;
 Mon,  7 Apr 2025 06:44:00 +0000 (UTC)
From: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>
Date: Mon, 07 Apr 2025 14:43:44 +0800
Subject: [PATCH RFC] fdt.c: fdt chosen cmd had off-by-one issue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-fdt-chosen-v1-1-3dda83c48c07@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB9082cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDEwNz3bSUEt3kjPzi1DzdZAtzAxPTNKNUw1RLJaCGgqLUtMwKsGHRsbW
 1AB149+5cAAAA
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, George Chan <gchan9527@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008239; l=1586;
 i=gchan9527@gmail.com; s=20241015; h=from:subject:message-id;
 bh=KXpDs9FaMUuw/TaF08xplmfD+9pguJkYrpcltFm/Q3U=;
 b=osa2720q9l0fvEKXeaUD32d5ZTJdZDmOSmCBCLhO1f3Xwl8tEHcRqspJjfzx2FBLa1FRmDnhK
 IP4mf1Z2qE5A184Epo8XgNBDx9En6YJHMn2LCB1RzHSbW8bdP5YKXR9
X-Developer-Key: i=gchan9527@gmail.com; a=ed25519;
 pk=dscYWhT+BiQOBMpPE19NFQAjBBmcpipc6zdf2MTze/U=
X-Endpoint-Received: by B4 Relay for gchan9527@gmail.com/20241015 with
 auth_id=248
X-Original-From: George Chan <gchan9527@gmail.com>
X-Mailman-Approved-At: Mon, 07 Apr 2025 14:38:56 +0200
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
Reply-To: gchan9527@gmail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: George Chan <gchan9527@gmail.com>

The kernel searching bootconfig will be off-by-1 and never match
thus always not found in this case.

Signed-off-by: George Chan <gchan9527@gmail.com>
---
The searching will shift-by-1 and never match the bootconfig thus
always not found bootconfig this case.

Kernel:
            data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
            for (i = 0; i < 4; i++) {
                    if (!memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
                            goto found;
                    data--;
            }
u-boot:
            initrd_end = initrd_start + hextoul(argv[3], NULL) - 1;

That would be off-by-one apprently and matching fail for bootconfig.
Both u-boot and kernel worth a fix.

An out-of-tree patch for kernel to relax the searching is available
but not ready for submit.
https://github.com/99degree/linux/commit/9d9ea454fe857a9f550d7e60957253e176e8e123
---
 cmd/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/fdt.c b/cmd/fdt.c
index d16b141ce32..13ffe929f8b 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -705,7 +705,7 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 		if (argc == 4) {
 			initrd_start = hextoul(argv[2], NULL);
-			initrd_end = initrd_start + hextoul(argv[3], NULL) - 1;
+			initrd_end = initrd_start + hextoul(argv[3], NULL);
 		}
 
 		fdt_chosen(working_fdt);

---
base-commit: 848f7ffc64aa7c4cc2229095812625c12343c8c1
change-id: 20250407-fdt-chosen-c87045f2e1e9

Best regards,
-- 
George Chan <gchan9527@gmail.com>


