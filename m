Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C308CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 00:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1BD8489D;
	Wed,  3 Jun 2026 02:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="ZIiym7jc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C8384868; Tue,  2 Jun 2026 20:31:36 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71BF84852
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 20:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-69d8ff0ca12so7220527eaf.2
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1780425093; x=1781029893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jV7ACQE8IqxwjRlJfNib0aBjkHQK9cDce3Ei51qvG3w=;
 b=ZIiym7jcyf7szkQWiRvNdwmdCrDelluMqtyT329ykWNxPfezGyL1KGF2gFmmwOEYV1
 PIcaiPKuyP7khoevU8XtvWJxdRUWPk+N1RpgeT9aoMH7maHTOW0WUNe60k0g8murkiQl
 kJk1T/KYnUXwq+pFBJsRfhskU0MldFNCtEmShGSR4/Z9yjZRkaArvkXsYsqv6UFB3NO1
 7Z1yFImKWja1K/mwOZCOJiXR2LvrSe+7QNvA7GHl7ukaSrGtZMW8y7TZVZ8PJ6e8MYSs
 /Vj+JivOAKKfbylEDv8p5H+txOH/QSe9MIFMQdmyRFT0YXddkbP3mopqXkYger+AC0ol
 ujbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780425093; x=1781029893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jV7ACQE8IqxwjRlJfNib0aBjkHQK9cDce3Ei51qvG3w=;
 b=acuajKijME/B46ygi/8PCtBSZUZLgz1PTydG2VCQO7HjwzndeVZrjZfhLkw8835uU6
 bSM9g1K7hRcXDAkKsx2Ta3X6SrRDirRqE8rXat+Lv7jUmENOHyrZoVrk4bu9rhcljr0e
 upkDFu31kxEmFXWB3SArbNB8PSDZA+KQu4q9vFnIUFLVV8j+9jgkMYrdxVQYg1dTjX3I
 t/wFN33vw6X6AvKoHxSiW6r3nGDzTwgKHZ0PUtJKBrr89EFE9lt9fZPCbQkTDMw4hX+8
 Lz36C9JNKgdcSv9UMUBIDgPOJKETEzeKcAz18V80r0cY/Jho5SS5bCiQS8/FMDmFTea0
 PSJQ==
X-Gm-Message-State: AOJu0YwntyAWNWCuRJnZqPeVSjX1mvh+IRA715b6STLRuZNO/f/jLVyQ
 +Ls0cZfmI3HSwCT+fXUIPPuGnyCx4PVak+4jHrwE8rXfDFdOQ1eAis4CjT83AQWWkSZ9DstmCQ5
 dWceNtzrjyQ==
X-Gm-Gg: Acq92OEmY4icyc7jw0ksTIMu3KUGxkkM+n54DjqvNIhciQ1qYF0d47nCRjIeI1RfuXD
 TjuOddpo2VTUdt90DUKHg5wCJ6JezPrZpxJW3K8isukvA7A97ZAjHpMY+bJ9UP4p+Tt6Bw2Sino
 29ouEDmm5dy43zhFhCp+U3lPitW57q/IMieE7hpx5eUIlKGYu5iVQq11IpqjxapBfv1KxwqyX3A
 4lhoJzQTq/hSFnuFD0SkHxy/G/ATi/LBWW1tUVFdP8/wgTTRtuhEMmfS0yLRtI+zZee5j8HIFH0
 h7wQUdIffS8Xw2f+av64J7ILuLRkAUmOyqdWEkfX9EcE01EGLTgDf4AWwMEzH3lEhfRysFmZzHV
 Gna5T27C2HcDxiJy+IqmzoMdCUMNOg4ANGDUZP+cH1Vh17beQGcboRdgnASxWK/MftUy5eSOmL7
 Ckbxxeu3+m8NlMqq6UzjARntflfE7AY4tdjpLcfK5dXoHRvZyyNEBzHots
X-Received: by 2002:a05:6820:1ca3:b0:694:9a8a:2ce with SMTP id
 006d021491bc7-69e47e82e0cmr158894eaf.8.1780425093431; 
 Tue, 02 Jun 2026 11:31:33 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559f35c2sm24340966b.61.2026.06.02.11.31.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jun 2026 11:31:32 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v4] image-fit: Limit recursion depth in fdt_check_no_at()
Date: Tue,  2 Jun 2026 19:31:30 +0100
Message-ID: <20260602183130.66591-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260527112602.18818-1-anton@binarly.io>
References: <20260527112602.18818-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 02:23:44 +0200
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

fdt_check_no_at() recurses into every subnode without a depth
limit. A deeply nested FIT image can exhaust the stack and crash
U-Boot during signature verification of an untrusted FIT.

Add a depth check using FDT_MAX_DEPTH to bound the recursion.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v4:
- Clarify vulnerability reachability in the commit message

Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback

 boot/image-fit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..0e225ecd0c2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -41,6 +41,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <fdt_region.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -1643,20 +1644,24 @@ int fit_image_check_comp(const void *fit, int noffset, uint8_t comp)
  *
  * @fit: FIT to check
  * @parent: Parent node to check
- * Return: 0 if OK, -EADDRNOTAVAIL is a node has a name containing '@'
+ * @depth: Current recursion depth
+ * Return: 0 if OK, or error value
  */
-static int fdt_check_no_at(const void *fit, int parent)
+static int fdt_check_no_at(const void *fit, int parent, int depth)
 {
 	const char *name;
 	int node;
 	int ret;
 
+	if (depth >= FDT_MAX_DEPTH)
+		return -FDT_ERR_BADSTRUCTURE;
+
 	name = fdt_get_name(fit, parent, NULL);
 	if (!name || strchr(name, '@'))
 		return -EADDRNOTAVAIL;
 
 	fdt_for_each_subnode(node, fit, parent) {
-		ret = fdt_check_no_at(fit, node);
+		ret = fdt_check_no_at(fit, node, depth + 1);
 		if (ret)
 			return ret;
 	}
@@ -1696,7 +1701,7 @@ int fit_check_format(const void *fit, ulong size)
 		 * attached. Protect against this by disallowing unit addresses.
 		 */
 		if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
-			ret = fdt_check_no_at(fit, 0);
+			ret = fdt_check_no_at(fit, 0, 0);
 
 			if (ret) {
 				log_debug("FIT check error %d\n", ret);
-- 
2.53.0

