Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E74FE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E96CA895A4;
	Fri,  6 Dec 2024 00:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EOU4OTIx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A05C8907B; Thu,  5 Dec 2024 19:35:40 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE86D8943C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 19:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 04CD0A43EAA;
 Thu,  5 Dec 2024 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAF6EC4CEDE;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733423735;
 bh=uXXO3JwOsdQDCXZ3tTNOx+fynJ6ihy9VKowjiR4kWF0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EOU4OTIxy8XOWFDP3oUBgOr1b1jktjAjavtim+ccI4tP1DERCNMz3DAS0oBJhaNen
 KMxTqTt1pNE73JWGZiitsVcwoi1wCdeOsbumNnxwbvpi4esVTMD6Domckm81N5oU87
 cSDEG/9jfkYo3wyFRE0smMoVuZmbs1tUTJ1DF7sZHmtyQqTbm2hpJIbnV+QlbwBERw
 2iZSe1e7mjOwYtOux8XFVwh4zZ4/tRexc6PoAmK+02T8iXdj/+mypyFCbzvZi40FwN
 7NqlTWruxjPyUsV2DvGB3x+sUrAdqCImoOPcqcVm6gkF6hQMddV+L0YIEXCoUAEmtk
 pIEpDj/FRfoIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9C451E77175;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 05 Dec 2024 19:35:34 +0100
Subject: [PATCH 2/3] cmd: Allow building ufetch without CONFIG_BLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-ufetch-v1-2-df861318bd49@posteo.net>
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
In-Reply-To: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733423734; l=1994;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=DnyP6oDnp1lVSkVKMsKyWltrCFz7Ez9t5/Fu2/ef8jA=;
 b=6QeTrJDma/AQq67RbdwT6oaXewi61yI0yAty7ufsbbIndopWiGWg6bMQxq/mShSK2LWsPeBQX
 /7tZ0oe4rjOBi2rjlVqSXq/pAhOWrJFjVVSNZHc9Iagp5NSOXUBsOUQ
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailman-Approved-At: Fri, 06 Dec 2024 00:38:21 +0100
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

The ufetch command is still quite useful on systems without block
device support; remove the CONFIG_BLK dependency and make sure the code
compiles/works with and without CONFIG_BLK.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 cmd/Kconfig  |  1 -
 cmd/ufetch.c | 10 +++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4936a70f3ef16ddb093ceafa12d011ca1b89e95c..547fd2a91f7883e2ae5982897ec93c4483d67852 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -178,7 +178,6 @@ config CMD_CPU
 
 config CMD_UFETCH
 	bool "U-Boot fetch"
-	depends on BLK
 	help
 	  Fetch utility for U-Boot (akin to neofetch). Prints information
 	  about U-Boot and the board it is running on in a pleasing format.
diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index 5f3ef847b268dc384271fc6774720e5fd2337157..7aed0b447bda104b837d37c6adcbb21b80237aba 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -92,11 +92,9 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 	int num_lines = max((size_t)LAST_LINE + 1, ARRAY_SIZE(logo_lines));
 	const char *model, *compatible;
 	char *ipaddr;
-	int n_cmds, n_cpus = 0, ret, compatlen;
+	int n_cmds, n_cpus = 0, compatlen;
 	size_t size;
 	ofnode np;
-	struct udevice *dev;
-	struct blk_desc *desc;
 	bool skip_ascii = false;
 
 	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
@@ -200,6 +198,11 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			break;
 		case STORAGE:
 		default:
+#ifdef CONFIG_BLK
+			struct udevice *dev;
+			struct blk_desc *desc;
+			int ret;
+
 			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
 			if (!ret && dev) {
 				desc = dev_get_uclass_plat(dev);
@@ -213,6 +216,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			} else if (ret == -ENODEV && (skip_ascii || line > ARRAY_SIZE(logo_lines))) {
 				break;
 			}
+#endif
 			printf("\n");
 		}
 	}

-- 
2.45.2


