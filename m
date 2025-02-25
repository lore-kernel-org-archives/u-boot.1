Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DAAC021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 13:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E373080F7B;
	Tue, 25 Feb 2025 14:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hrv/2nsP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419FB80F92; Tue, 25 Feb 2025 14:50:07 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BF49801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 14:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-30797730cbdso55760241fa.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740491403; x=1741096203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x9aykdNJ1b6b5SLjH7AlsiiL4EJdF1/NhteQY3VQhEg=;
 b=Hrv/2nsPzZUo1EFLq/P/i3DyWvw0n11uGaiprgbcDKxocy0bwVI+cKYevRPIHDDtzq
 AWbTNzt8BjE+fnrDmK7n5vnhGByGDNg2DXljLMqVvh8pPi1XltC131MaNUkY0P4PFCUv
 HsA9I4qq7Iz7EAdQA5rMFOAw7sVbe2muElRveWpB7TidCVMXSyRWBVNTOjRO9QSPS1aH
 hkmK5XDrcs0clUktWiNaITTM6d5fe1GpMANvU98oMOMCWNVBj93F7d+2pRlXWEUTJ8uC
 +MH56pj0FG8WpvTjYgaJpbOr7hWWiWESha1Hf/5pHRJEiaz8WSJ+2kQYpwAeqCJ1rJmP
 qhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740491403; x=1741096203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x9aykdNJ1b6b5SLjH7AlsiiL4EJdF1/NhteQY3VQhEg=;
 b=fODq2tzJjPubwcWdgKigXp44TquJnGO4U7mn+Pgocm22nrZDXIbMw7qWqKwwHSmPvX
 Fcu3EbqvY1t29DPz3qFa0aUPCkC/urYlgoZFXXEy6y63KB6wQIVD5C+oZZ+uXUHoPRYJ
 1CmcqPq763+ebMcxGNYuiGCR51EVp1sZgs4uXez5zbZuoVYOF/96t7oc8/I5eCgr698U
 AcJBnX71JhsMYi75coVYsV17/L+ZhdybltU5RO3qKltIJpwroBihdWQgsOyVEqNLw/Qc
 g4GKAgAg0TKweuT2ioM3KudGA5CjwRrDXe9HWJcPEVmcDjJZQ7ldg5JgFnfpZEzxwM9n
 vRaw==
X-Gm-Message-State: AOJu0YwTtcJ6IPF6xcoYEIBk8vB1TEXcNK4h5+hB1oARWbbi9vENQMKY
 YRSq6EPpczgQYv5xjIfvZ6GO7pCKus8Vp+bn8+HMr97BpSh2PON/T8UoKlcy
X-Gm-Gg: ASbGncvCppXolSoXzbzkI0GPeMpQzbiAuuh4pubmtMWYXCGK50fNwPQiKyZgPp18b89
 5YpYWBJjmXbyscP12CzbLj0CmiFjSDyZVHn1MBM5+opXMkqvCteYZ4vcKnBSmamGDeR+lYAMEIF
 L6K2bT2n44eAy3ZwVztbjqyqCndF0vEsLavzmK+Haxqdf0LAZz/99fOJlm640GnqWiKqNXJT1Au
 Dpu7JG0vpU4SOVZkjzymZ/qLGb7scij6X3vfzRjQi5K6KJ5DIoY/ZiVEB6iC2GAx6Nk1q6Q9J5t
 A3Oq8TSYjDVA3Rg47fpI4Q1ECPv2WHvJ9NckaMdjp/l3rPCGXcIvkpZojAT55r5E2T2/GAB/LRw
 kZYQTrVI=
X-Google-Smtp-Source: AGHT+IHykOx2lbEzzkPlJ1MAibZhNgN/qMbXSIa++nZSAfhnTVxE27gsPGXU6H7wkCrHC+Y2MCf2IQ==
X-Received: by 2002:a2e:b050:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30a598f4568mr59916601fa.18.1740491403058; 
 Tue, 25 Feb 2025 05:50:03 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru.
 [109.252.121.101]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a81ae80fcsm2291291fa.96.2025.02.25.05.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 05:50:02 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] lib: ecdsa: fix prevent memory leak in ecdsa_add_verify_data
Date: Tue, 25 Feb 2025 16:49:59 +0300
Message-Id: <20250225134959.33438-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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

- Ensure `free_ctx` is called in both error and success paths.
- Fix memory leak in `ctx.signature` when `do_add` fails."

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 lib/ecdsa/ecdsa-libcrypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index 1c5dde6069..f0095e9dbc 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -363,8 +363,10 @@ int ecdsa_add_verify_data(struct image_sign_info *info, void *fdt)
 	ret = prepare_ctx(&ctx, info);
 	if (ret >= 0) {
 		ret = do_add(&ctx, fdt, fdt_key_name, info);
-		if (ret < 0)
-			ret = ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
+		if (ret < 0) {
+			free_ctx(&ctx);
+			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EIO;
+		}
 	}
 
 	free_ctx(&ctx);
-- 
2.30.2

