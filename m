Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DD3CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 19:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D95584866;
	Thu, 21 May 2026 21:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izAFXn/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6802684825; Thu, 21 May 2026 21:14:14 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819BF84852
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-393d07e8938so55650361fa.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779390852; x=1779995652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFKufg/zwZrY1KrVLhamyEcTA8YAfvDnXM1tiPXPKJI=;
 b=izAFXn/ILn4IDXd4dznJ3lV2Mvj4CUcs5Icbh41/GXskLBA57JaWpdduz5cr1JDIUq
 mlRgv68enGYLHEiit2bJnUDC8bGHFW5yS/drQg+8jB608RJMlOjIy50qQsyER3AP1VUU
 4Yrg6Y3FVkP24lB1zxatonZjqgnVzb7rpDuoChhTyNHKe0//Wc2ytjylaGXp+nXVxzXM
 RqPx28vShaVpQJ/i/IrESKGjDzUZueBVUeRPDW4fhJpwo9v3TTkvcKpqTY2S013YaogN
 5NDRDVlNv+kY7MISOQG9sksAflJDX2SMeeN0KQa4j9TDQ1XSGLruJj6/kwTKs1F49jvF
 vsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779390852; x=1779995652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFKufg/zwZrY1KrVLhamyEcTA8YAfvDnXM1tiPXPKJI=;
 b=O5U1LrCVoQIgujPTogn3syHd5aFukOU7RXxcZe3I185EWlbjzUDFlm7lEE7s9S31Gm
 tluCTnjXCCjyBBw2J3vIPUXdUV22k7WNeWzRVcqPtF/W7iCcYkyc3i0Ot4wKQYhPPW02
 hOZ/fqNpz2qfvfD15n0gZpGNyj1e2+e1Cm1edbNGLBWlXLMgVYE4gV1t3NNNE8a5ymf7
 IRCMepphMhR2rk4/NOhtwubOyiAgLahDVQaeLlt61R2YGrN0qjk+SBcVUo2PPmktChJ0
 DlO/0D8+wj+aim3N7Dvlyc7+w2ma5rrK0c9up/R4aHVTsgOeHvEU54Pf2G4rX/TEBBsm
 MXzg==
X-Gm-Message-State: AOJu0YwhPAPAGZcobev66Lr/+HF4kY/pF8FF6pla27Bk5cnslqBgO1MF
 6M77Sfrw/akkw9vnFc5kxti3Vzi2XLrjQyvCd8OW8fTyspP4/cuLYuZshdf7sJRm2oSAqQ==
X-Gm-Gg: Acq92OE2TxD6WX74mvGuU9gUFHDTRpuAvNY8U0Aen2ODoMUwUwetCQ/F6ur175vWu30
 mwZ+OfXc873kYw/K9esftRegUTvee5NNmVfxnPDOg3FLkZkPZaQFeo8SxFN3XgJlgpLzNPo+K/h
 Z8Kyk9G5goHa5ho9mO3+Z6o3oa5faHadNY3vpSn4/Hm5So8FCnjC79m1Q+IURoYDhVRyDfRCTIB
 fEVr+Zq+atOitr+YS4m5gIo/0sUsoeKkQgQ5L8HBCxqNQP1QP3F16ZUJfVXsagInaZwyBQ46u/y
 UZp6o3aauD2o+scUbf71r5CvNAbDP5Wc6JNqQqKC7qwAXwc6nDI+AyJ20NfTXEJq1A2i7T/RbQE
 GkyyS6VM8nfsi12Fy0loCIRGzkAi9zLsKdZhMyFmrEOdYRzJIxSjQf597JDOSCEq4QpcG1/3PRL
 VKFJNaFSVGW7plzFeJPoedrMGoKMtQM5GMM52wEJYT+ZkoADLLNSD9x2L4g3JifkyIJc3ElIeTJ
 b8S2iMgP9ddglWTCixzjhR7wav51cFYK0Y=
X-Received: by 2002:a05:651c:882:b0:393:9579:2683 with SMTP id
 38308e7fff4ca-395d8c35d81mr854031fa.5.1779390851557; 
 Thu, 21 May 2026 12:14:11 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-125-213.nat.spd-mgts.ru.
 [109.252.125.213]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395d9442ee3sm38701fa.6.2026.05.21.12.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 12:14:10 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: ifwitool: fix memory leak in ibbp_dir_add()
Date: Thu, 21 May 2026 22:13:59 +0300
Message-Id: <20260521191401.29310-2-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
References: <20260521191401.29310-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 21:28:08 +0200
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

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 tools/ifwitool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/ifwitool.c b/tools/ifwitool.c
index c1defe57737..77d7207eb80 100644
--- a/tools/ifwitool.c
+++ b/tools/ifwitool.c
@@ -1741,8 +1741,10 @@ static enum ifwi_ret ibbp_dir_add(int type)
 	init_signed_pkg_info_ext(ext, 0, subparts[type].name);
 
 	/* Entry # 2 - IBBL */
-	if (buffer_from_file(&ibbl, param.file_name))
+	if (buffer_from_file(&ibbl, param.file_name)) {
+		buffer_delete(&manifest);
 		return COMMAND_ERR;
+	}
 
 	/* Entry # 3 - IBB */
 	alloc_buffer(&ibb, DUMMY_IBB_SIZE, "IBB");
@@ -1755,6 +1757,11 @@ static enum ifwi_ret ibbp_dir_add(int type)
 	create_subpart(&ifwi_image.subpart_buf[type], &info[0],
 		       ARRAY_SIZE(info), subparts[type].name);
 
+	/* Clean up temporary buffers */
+	buffer_delete(&manifest);
+	buffer_delete(&ibbl);
+	buffer_delete(&ibb);
+
 	return REPACK_REQUIRED;
 }
 
-- 
2.39.2

