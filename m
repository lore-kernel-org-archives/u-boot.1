Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289E9E77182
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2859D801EA;
	Wed, 11 Dec 2024 23:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ijiV9GUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D618021A; Wed, 11 Dec 2024 23:25:55 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF639801E7
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E81F55C67DC;
 Wed, 11 Dec 2024 22:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34815C4CEE0;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733955949;
 bh=HC0Im3K7AqfznJ2NDgvWcgaTVI42qXD19a2WCyP0wEY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ijiV9GUZLcUTugXHIVrQdNwZyCjq2P9H1AuJ3lf9ya4GStsoqDUQn1zAGnPYY1pQJ
 k6Tn72QM1lslz8mnysg4UVRNd27rPtQ4THCgVyfmXz1cAu7Rjhnu3vwRrijGZVkkT5
 aDrQjXQeq0Mjs9jdq7ofoAmruJhTZlcU1Z7oUydgg4sIjaKy0xPa/enXyJhAw44o57
 gcp5R+bfRn3qMf/aIPUt8A1+fYCDac6TsbAfeAyIlgM9uolzSFVvYrUks0W6DTaORW
 iwtAR0nW0oZpn+OjnPcwu8OIbVF8Vf03Nr4KY/q7xDv7iGH/H7hbiewD1UHfHFuxkS
 cgJZ/hFb15/qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACF0E77180;
 Wed, 11 Dec 2024 22:25:49 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Wed, 11 Dec 2024 23:25:26 +0100
Subject: [PATCH v2 2/3] cmd: Allow building ufetch without CONFIG_BLK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-ufetch-v2-2-2b5432ffaeb1@posteo.net>
References: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
In-Reply-To: <20241211-ufetch-v2-0-2b5432ffaeb1@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733955947; l=2239;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=w3CntfH1PcCaKILPhytp+dmkSVmns7MQdgbpBdMQ9NI=;
 b=XinjDKXsmpWD4IlWvVWwzkoNDRqRa8hYtQoSbWMvu9h1wTayhqulqSYm5FrKR7QtdkyHeQd+K
 gg0M4p5S94uCrH36kqK61tqyWWHRUSWDgUGSzs6L3YQ+B2KQ0xgqjza
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

The ufetch command is still quite useful on systems without block
device support; remove the CONFIG_BLK dependency and make sure the code
compiles/works with and without CONFIG_BLK.

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- Add parentheses to avoid having declarations after the "default" label.
- Add Caleb's R-b
---
 cmd/Kconfig  |  1 -
 cmd/ufetch.c | 13 +++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

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
index 5f3ef847b268dc384271fc6774720e5fd2337157..83cec0f6d5c875f150f7b948392a29803bdbc201 100644
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
@@ -199,7 +197,12 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			print_size(size, "\n");
 			break;
 		case STORAGE:
-		default:
+		default: {
+#ifdef CONFIG_BLK
+			struct udevice *dev;
+			struct blk_desc *desc;
+			int ret;
+
 			ret = uclass_find_device_by_seq(UCLASS_BLK, line - STORAGE, &dev);
 			if (!ret && dev) {
 				desc = dev_get_uclass_plat(dev);
@@ -213,8 +216,10 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 			} else if (ret == -ENODEV && (skip_ascii || line > ARRAY_SIZE(logo_lines))) {
 				break;
 			}
+#endif
 			printf("\n");
 		}
+		}
 	}
 
 	printf(RESET "\n\n");

-- 
2.45.2


