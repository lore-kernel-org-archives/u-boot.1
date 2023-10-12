Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA75CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A073E86D41;
	Thu, 12 Oct 2023 03:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b6w2pnBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1972186E04; Thu, 12 Oct 2023 03:56:52 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC9686DC7
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41983b83e53so3163221cf.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075790; x=1697680590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=moVLIGzXOPbIp4sST+cIh4hm5MWF6ijM99/5TMpmj/M=;
 b=b6w2pnBal7UETLeZdga89WNvN+BfNDL5isAPgaK4oqB1oI4NHx5L+J4JwR+VcRDzFP
 JVvd8yEQ4ixC1q66PSmTGkKVIMvqJI92zTO4jgJuIYkAECXyJtWk0czRt8cYZ4fkgQJS
 ajDIWaG/sj6wiQBZdNB9B7GjVmdr2GLGhtX4yBfOYFgzEP0j/Ao/wpuadFXTGP0M0PqA
 o1mh0wLm5DGY+ChkVjNsuVoxaJx0Cko1bhXUVd84QhE5mZJGIXN/SUQ5jMM0pq7rvLNk
 /olSkEdxtVJjbApGhWsIyHll1+dKVz5EbI/pavKCorOUBFw16j7PRLRCtS+4mPsnbeN8
 Qtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075790; x=1697680590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=moVLIGzXOPbIp4sST+cIh4hm5MWF6ijM99/5TMpmj/M=;
 b=AeptV6IYJfM9xrhxFeV8kJASP5jBQdXEKyBLIgPO3/NTKCQzi/JzAr2m7/IKrbrtul
 HBdvhDl/atrCRhAwTwbdvQIu9u9gWkjHQE4nbaCJRS9Zd0oGsUFSrTyfXssVrZmFHrNT
 TcRY0s01iQmjBVG0rkaQIZ6D6NoN4PDDtnCLRimJsWdV4Nrae/DjKpOcRBMNI62ntZmp
 Uy8DnGdZa1WMmxtgNs3jdW7OQsHNaJgvV/3kLQWpWzjC+owZ/iC7q6lYG8YBMrIrL7/I
 rc/Voqs7NOjkOr2l7AJKD1YLNrMTbpCsuFPURNL/PngST+w2osQ7IU9Mj2SO6wzuiElp
 ggTQ==
X-Gm-Message-State: AOJu0Yzbn4SrfGYZ8u+TiywAlh5BqNDLD6bThxQ4MpFS+ZtCRMrI7BOh
 pNnk3jO92qh4gnI0LpSdsD7Bnf7bSnV0Xg==
X-Google-Smtp-Source: AGHT+IE2E4nJbp7jF6+FnjtgbgrNd10n3ubaVHmzLfO8r5Y81sY2kI3c5M2+OJnPKeAlauKMSfyUxQ==
X-Received: by 2002:ac8:5c4b:0:b0:418:f4c:937b with SMTP id
 j11-20020ac85c4b000000b004180f4c937bmr28799695qtj.44.1697075790006; 
 Wed, 11 Oct 2023 18:56:30 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 e6-20020ac845c6000000b004181234dd1dsm5741763qto.96.2023.10.11.18.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:29 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 01/26] spl: legacy: Fix referencing _image_binary_end
Date: Wed, 11 Oct 2023 21:56:01 -0400
Message-Id: <20231012015626.3487451-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On non-arm architectures, _image_binary_end is defined as a ulong and not a
char[]. Dereference it when accessing it, which is correct for both.

Fixes: 1b8a1be1a1f ("spl: spl_legacy: Fix spl_end address")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 common/spl/spl_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 095443c63d8..e9564e5c2a5 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -19,7 +19,7 @@
 static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
 {
 	uintptr_t spl_start = (uintptr_t)_start;
-	uintptr_t spl_end = (uintptr_t)_image_binary_end;
+	uintptr_t spl_end = (uintptr_t)&_image_binary_end;
 	uintptr_t end = start + size;
 
 	if ((start >= spl_start && start < spl_end) ||
-- 
2.37.1

