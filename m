Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5698C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D1688B34;
	Thu, 18 Jul 2024 19:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N67kpaXO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9CE88B0F; Thu, 18 Jul 2024 19:36:55 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA0888B16
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eea7e2b073so19877841fa.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324206; x=1721929006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u3npMrvTYLly9s/nnMJV4fbdRuydcPSpwmE1Eu4kgQ=;
 b=N67kpaXORhmfT7u/67TtV/6Y/z/iDYJ60W0waugwhCc5u59pU3cYZY0ekM1Bgkh1Wi
 RDCeJH48vNc5rsuTFJaMi4Qn6/0QXJCuASEo4f8KDW1iuyc0vK7CH//mlWp9tI7M/JJT
 1qglSrWzo6w9lOpmR1QsuVzzLhL8Kp3GWzG1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324206; x=1721929006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+u3npMrvTYLly9s/nnMJV4fbdRuydcPSpwmE1Eu4kgQ=;
 b=YGxyuWpu1T3I43qifBz7V57QpQkviQ23MMaUhbOT7WoWtlVYsqIm3qwjNqavAyYRS/
 7Ib7d6LVvTDLyZUBWaTJPuETuqg7GEWCiEk8fNRBWzO5K8NY8pmLHZ8/GztJMKrCy5ze
 Y4VDYKtw2HI0Z6oCXd4VaEZweqhev9Y+dfg7Pz7hAzzwirbUUGIG2VcW87VNxPZ0rPue
 PsZfXgeJsRi+ZGh9Z6Yr9tyNfbpbDUaU6GWyy5B0jt0zfgz1tD9Y0/DMXTMIeqsUythb
 A3Hi1L8BNu1FqwggOMD2+bDn2tdauwfT3wRKmgf39QdMLSXKJ28+iuny6vA1l7sUidxz
 EDnA==
X-Gm-Message-State: AOJu0YzZ8DvJEeunxqAsHdFdf8/KRXMjrYU5WvcRE5MHsMbrVRFq27RT
 bmKyZB74fgHRqvsl0mufHCF6LcJ2cyIJGFZN5GCZtxVLGba8Ou6N1ngwb9RcIzyMn35sgMeycN0
 =
X-Google-Smtp-Source: AGHT+IEcQrw0BwPz9zGnZ0LlD2sA0ZAH/a560UN2tAO0vOkBey3Tp7+tFKjkCIRgavsicZqUuCRMSw==
X-Received: by 2002:a2e:bc0a:0:b0:2ee:dde7:899c with SMTP id
 38308e7fff4ca-2ef05c73644mr27764511fa.17.1721324206098; 
 Thu, 18 Jul 2024 10:36:46 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Aaron Williams <awilliams@marvell.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Subject: [PATCH 14/20] octeon: Drop OCTEON_I2C_FDT dead code
Date: Thu, 18 Jul 2024 18:36:05 +0100
Message-Id: <20240718173611.4014274-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

This option is not defined by any board, so drop the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/mips/mach-octeon/octeon_fdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/mach-octeon/octeon_fdt.c b/arch/mips/mach-octeon/octeon_fdt.c
index c74fe9d9fb8..15ce292be95 100644
--- a/arch/mips/mach-octeon/octeon_fdt.c
+++ b/arch/mips/mach-octeon/octeon_fdt.c
@@ -687,13 +687,6 @@ int octeon_fdt_i2c_get_bus(const void *fdt, int node_offset)
 	while (node_offset > 0 &&
 	       !(found = !fdt_node_check_compatible(fdt, node_offset, compat))) {
 		node_offset = fdt_parent_offset(fdt, node_offset);
-#ifdef CONFIG_OCTEON_I2C_FDT
-		bus = i2c_get_bus_num_fdt(node_offset);
-		if (bus >= 0) {
-			debug("%s: Found bus 0x%x\n", __func__, bus);
-			return bus;
-		}
-#endif
 	}
 	if (!found) {
 		printf("Error: node %d in device tree is not a child of the I2C bus\n",
-- 
2.34.1

