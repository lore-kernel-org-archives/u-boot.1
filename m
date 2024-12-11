Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BAE77182
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0AF8021C;
	Wed, 11 Dec 2024 23:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EF75EJ6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9AA0801E7; Wed, 11 Dec 2024 23:25:55 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD118801EA
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0C88E5C67E2;
 Wed, 11 Dec 2024 22:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C6DFC4CEE2;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733955949;
 bh=S4KYjt1mAriaCxxt9OL8lVxgQx7CMHx2P2jUt4jvgBk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EF75EJ6uJ4mt3L/04BCZTArgRomIVZri+tWOKz0GxlRaaICOc/w+JYLwETQsFB/id
 MVQm2kY8qekSjSwSvyZH+kwjUnjLAAEL60jwC2ttL3C9j1DyBlJiSX7Ea7PwLw5fT2
 Jj9zQxsNxOHDbh4O3TTO3XS8uJevoV9FHErAM8EUaxarxCcK2oH/aBdBWqi4LneVJD
 lDSAiiwKAv7AhWL+Jcw/Gz+qcgK1wAUs/R1vGP/ID89F/MdLJNYWM6EeHNicudsLrx
 smq7JHRVfp0XBETg8E7pMdMupKNdVdvkpMnEFO+KreSuEmzQJgKsOzfPqEPILzYsJ0
 sm09C0WVKfttA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 42E9BE7717D;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Dec 2024 23:25:27 +0100
Subject: [PATCH v2 3/3] cmd: ufetch: Show CPU architecture under "CPU"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-ufetch-v2-3-2b5432ffaeb1@posteo.net>
References: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
In-Reply-To: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733955948; l=1029;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=/Cg0aGCHH9Ee1PEGTmvqDYJpZHTVfYwbSQst/nnF4mM=;
 b=hn1SVq0+J9nCc5W139NpXvfeteHxkh4G5mpVDUVABO1uQaW5071+MZQt/NiF4Smiu74Dmm5A+
 FNu64g1u3QVCGwWQj+7cYdHYjFFsFttvftNpZK7GvAxk3/f3C751Yi+
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

When looking at ufetch output it isn't immediately obvious which CPU
architecture the presented board has. This patch therefore adds the
CPU architecture string (for example "powerpc") to the "CPU:" line.
The new format is:

	CPU: powerpc (1 cores, 1 in use)

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- Reformat the CPU message for readability
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index 83cec0f6d5c875f150f7b948392a29803bdbc201..ed5a856c7abbe08949b81e0b2f634edd8b390be5 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -188,7 +188,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 				if (ofnode_name_eq(np, "cpu"))
 					n_cpus++;
 			}
-			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
+			printf("CPU: " RESET CONFIG_SYS_ARCH " (%d cores, 1 in use)\n", n_cpus);
 			break;
 		case MEMORY:
 			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)

-- 
2.45.2


