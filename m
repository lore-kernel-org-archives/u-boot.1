Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01BCC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 309AE80BAA;
	Wed, 12 Feb 2025 23:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eMDrm3DW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4FD80C69; Wed, 12 Feb 2025 23:23:23 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8FA801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6dd15d03eacso2593186d6.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399000; x=1740003800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cS4nyqPLO112rPsNL0K1jkhntfThA0YIb4UgmY5m1rI=;
 b=eMDrm3DWijyWYkGUZWVY6KLh2b/k2bEmsGQoxllYGgPBMGqbz/+3FDRtS3oo2bUoPq
 EOoOstw/3JVohbM8luXO7+c+yrkUVH1KAySmiwvQ9HFtzcfn2sS48FfYBe1D0PUmPBZt
 VtCFHkdQPDdNh/2zuHN++SKRA5mz/gqrbQ1W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399000; x=1740003800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cS4nyqPLO112rPsNL0K1jkhntfThA0YIb4UgmY5m1rI=;
 b=mGx+XEIyoRZ6geVeTnhOpP+OzukLAEP4aQMtPAnWHxOuDijYgANEh5JtkkKcqCZJoY
 5vP/2nHA7jjB720yREaWuVykx5ZPyWxE5tog9/Dmqeg55ksbj+U+7U1DX1h7XlE3m2m/
 nN5sRuC/e7Y+jQLBVIT/bdtuuJaIBvKSAvXPscz9D+4ulAIUkqFCjsQhpzt0lsUQQhKG
 FWEejpYaeVm862xsUrxYE9xxH05pniMskj0Ld9i3XUxn6CkyhOqvJjtpEOi+it57oEyS
 UUf2YUWq6O7QjcSriTlrsttKtG6uqfEu9V5SbMUFxoJi5439P5K+F3FrrAsWg1IA4J17
 iQSQ==
X-Gm-Message-State: AOJu0Yw5Df+7QaLKMG4T8WGPVKJdwiQpOc4DjENV3iXkJf9QmU/rFmTl
 q1ZktAHehR//17JzK+sBD+CPAIZYCBZI2AT+KTauvdnFcD8SuQYPkQkCG7JWAOUAa/tzqD9szx7
 W
X-Gm-Gg: ASbGncs02i0u5ryxGenjxGZ/3vLKwOE8UCttGgogzgn1kzDK9O51PLa7qdBkydVcELf
 BcDGt8QCGZfRjNM8n2mJ1Uo/XWcw4seVQ4YGFkbyIbM9wod/bnBy5admIBs7Bapl7BVj7Oes2Rn
 uB19vm5AJDcW4oDimq9Ak/k8wV/+ndMDf4dkNfBwbbKDX7mEdZ4c3N2s15sdWNzxgML6SRKTzsI
 x3dTlucygDjZSN0dmQo1OjTqi1X7UCk/KoHU3eGFSvX3IceVksoynHrCob0FYY8D+IBFQW1szaS
 jx1Do+7IPE9OKIgYEg==
X-Google-Smtp-Source: AGHT+IGQOayoGUcvg+WMWYBOml9rmvn7ZPpwNbKQBmHtqtXa9Mt8hdAFjQ4OoQv3+szt6UtSQNUPaA==
X-Received: by 2002:a05:6214:5297:b0:6d8:b733:47c with SMTP id
 6a1803df08f44-6e65c9e3b7fmr11194556d6.22.1739398999697; 
 Wed, 12 Feb 2025 14:23:19 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e659304a34sm8434256d6.53.2025.02.12.14.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:23:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] tools/patman: Don't call a non-existent suite
Date: Wed, 12 Feb 2025 16:23:17 -0600
Message-ID: <20250212222317.684370-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With a newer pylint we get a warning that gitutil.RunTests does not
exist, so remove the line.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/patman/test_checkpatch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/patman/test_checkpatch.py b/tools/patman/test_checkpatch.py
index db7860f551d0..25caca0b91aa 100644
--- a/tools/patman/test_checkpatch.py
+++ b/tools/patman/test_checkpatch.py
@@ -530,4 +530,3 @@ index 0000000..2234c87
 
 if __name__ == "__main__":
     unittest.main()
-    gitutil.RunTests()
-- 
2.43.0

