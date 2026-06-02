Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0E2CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1616848F0;
	Tue,  2 Jun 2026 10:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="RoLcBtTR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC9784895; Tue,  2 Jun 2026 09:42:23 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F0784881
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so2974315f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 00:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780386140; x=1780990940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFMMBsqDhYkXF8NyuCkbRBoBKi0uVpDdVY7j68DHWYo=;
 b=RoLcBtTRiI6I4n5boulbh2p8U5JEG9JHMrJ9tCZ9rF3KqoQkrQMJHw9xjjqZ7bNFqK
 Q9ljIhAO4Sw9T+aNUTEgOAzCgmRY5vzGEp1KF/hgIyD6QtUCtpMD++8k17w94BlNv0VI
 Mvuxa9/UPEJzNZj03BKYPpaq7qRQax2Sm2xTxgeqU28g+cgxUzlaD+wLsFov1abvE+8R
 l3GveiRI49E1MMxYPLH8RTm/BAwGSHV8A0NzjEUeWIiUENdnfH+Tr8Rt7YB07B3MrCTe
 vwr4MyxUL+8MpG6LqUv5c/ODw/OqE4XmiwlGplAsON4q2zlQtJFeCRSf1M9azxEJJwf2
 Z4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386140; x=1780990940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFMMBsqDhYkXF8NyuCkbRBoBKi0uVpDdVY7j68DHWYo=;
 b=UR99GT+byw18Dnp3/qn8VBSWoOQk2xYzrlofjTxMv1S+JTkMg3vAf+7P+yF57Jh/DI
 NCCq3CRQoKlaUcdZA3TmjKUahej0ITLs8C3NCo94hVoFqK28NiAiHcTBII6VsNs24Kly
 V4JQTDkhyllSX+3b8aj2YE2C9ALdpAtoedfiEdGidM3+gAmDZsgAz7r3grtjK1gyLDyh
 HtqZfsE3llixW4vtnrZpXWchDibeyE6OHym/tU0dLM7rVblaZgUQ3nBiE5PXwpWVdU5X
 G/dB+62LH8+czzxVK4vrhljvPzXhcD8mqW87r2FU10bhIfRlsthnsqLrQNjspcFryzAx
 KQ1Q==
X-Gm-Message-State: AOJu0YwbxUxrvkMptirTOcWPYlOYhK9VVLB0xzluHhIQGeD0l3eHukWL
 3/Z0wWU+OfP2ujFrrpHinSS3Fb90tH4Jfsr2V3xlsJoB4T4qAt+L2DxJTMCiH66mMxn1sU8qVlv
 nUR7t6Ut25w==
X-Gm-Gg: Acq92OGWfyDCYNZrm6dL/qq/VVzBJjGOQbxwo2aCxg23XkwU4/sBzfuTo37r5sUhGow
 tKhJWpBU5Lxm+dokf78m48UD7St73+DpxGFbpey5uTM0UxrRUJl77C6rz8FVxtewLmy52fux8UX
 dFvumTx3dNNAUEWcj/fsiy8xM7g0thGo7GR6sFHchNDITyDLlErmvGUuZWypBrZNAlscJYMLjX+
 abtTHZ6M2nVQB8Q57wYhpz/9nCgJfFvWt8c2YvBB+QIGGRHyg+klazlFe8TOWzAYgXidAGPAY81
 vKwE+8zeKOb/e6czCkawJu+GX0lKy8Jk1LuG/Lrg5o/HrQ99MHzbrWEoNZ2JXMEsiDLF8+xNEy4
 /oTn1CZwBSzzH3U09ZABu8wJmh1vcPAh7E35P64gGhkrEP6IDjg4faF/5rJqUDeoc06aOIwhMO8
 GP10nQ3qZd83Lvz/mC1sV8DVqUSUKdfJF6qkDITsmz208SIg==
X-Received: by 2002:a5d:5cd1:0:b0:454:35b9:803 with SMTP id
 ffacd0b85a97d-45ef6b78b50mr20673116f8f.30.1780386140463; 
 Tue, 02 Jun 2026 00:42:20 -0700 (PDT)
Received: from mimir.fritz.box ([2a04:9546:1c18:5b01:cab3:2478:20a6:2fb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm30239748f8f.21.2026.06.02.00.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:42:20 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 upstream+uboot@sigma-star.at, Bruce Monroe <bruce.monroe@intel.com>,
 Arie Haenel <arie.haenel@intel.com>,
 Julien Lenoir <julien.lenoir@intel.com>,
 Lorenz Kofler <lorenz@sigma-star.at>
Subject: [RFC PATCH 3/3] boot/fit: stop rejecting '@' during FIT format
 checking
Date: Tue,  2 Jun 2026 09:43:35 +0200
Message-ID: <20260602074335.3965312-4-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602074335.3965312-1-lorenz@sigma-star.at>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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

Partially revert commit 3f04db891a35 ("image: Check for unit addresses in
FITs").

FIT references are now resolved with an exact subnode-name match, so this
blanket rejection is no longer needed, so drop it to restore support for
FIT images that use unit addresses in their node names.

Only the '@'-rejection logic is reverted.

Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 boot/image-fit.c            | 49 +------------------------------------
 test/py/tests/test_vboot.py |  7 +++---
 2 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index d82603ae557..7f8c055326e 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1627,34 +1627,6 @@ int fit_image_check_comp(const void *fit, int noffset, uint8_t comp)
 	return (comp == image_comp);
 }
 
-/**
- * fdt_check_no_at() - Check for nodes whose names contain '@'
- *
- * This checks the parent node and all subnodes recursively
- *
- * @fit: FIT to check
- * @parent: Parent node to check
- * Return: 0 if OK, -EADDRNOTAVAIL is a node has a name containing '@'
- */
-static int fdt_check_no_at(const void *fit, int parent)
-{
-	const char *name;
-	int node;
-	int ret;
-
-	name = fdt_get_name(fit, parent, NULL);
-	if (!name || strchr(name, '@'))
-		return -EADDRNOTAVAIL;
-
-	fdt_for_each_subnode(node, fit, parent) {
-		ret = fdt_check_no_at(fit, node);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 int fit_check_format(const void *fit, ulong size)
 {
 	int ret;
@@ -1676,27 +1648,10 @@ int fit_check_format(const void *fit, ulong size)
 		if (size == IMAGE_SIZE_INVAL)
 			size = fdt_totalsize(fit);
 		ret = fdt_check_full(fit, size);
-		if (ret)
-			ret = -EINVAL;
 
-		/*
-		 * U-Boot stopped using unit addressed in 2017. Since libfdt
-		 * can match nodes ignoring any unit address, signature
-		 * verification can see the wrong node if one is inserted with
-		 * the same name as a valid node but with a unit address
-		 * attached. Protect against this by disallowing unit addresses.
-		 */
-		if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
-			ret = fdt_check_no_at(fit, 0);
-
-			if (ret) {
-				log_debug("FIT check error %d\n", ret);
-				return ret;
-			}
-		}
 		if (ret) {
 			log_debug("FIT check error %d\n", ret);
-			return ret;
+			return -EINVAL;
 		}
 	}
 
@@ -2092,8 +2047,6 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
 	if (ret) {
 		printf("Bad FIT %s image format! (err=%d)\n", prop_name, ret);
-		if (CONFIG_IS_ENABLED(FIT_SIGNATURE) && ret == -EADDRNOTAVAIL)
-			printf("Signature checking prevents use of unit addresses (@) in nodes\n");
 		bootstage_error(bootstage_id + BOOTSTAGE_SUB_FORMAT);
 		return ret;
 	}
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 55518bed07e..9fdb649755a 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -368,9 +368,10 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                 ubman, [fit_check_sign, '-f', efit, '-k', dtb],
                 1, 'Failed to verify required signature')
 
-            # bootm catches it earlier, at fit_check_format() time
-            msg = 'Signature checking prevents use of unit addresses (@) in nodes'
-            run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
+            # bootm catches it during verification: the exact-match lookup
+            # refuses to resolve the real image name to the inserted '@' node,
+            # so the data hash no longer matches and the kernel is rejected
+            run_bootm(sha_algo, 'evil kernel@', 'Bad Data Hash', False, efit)
 
             # Try doing a clone of the images
             efit = '%stest.evilclone.fit' % tmpdir
-- 
2.54.0

