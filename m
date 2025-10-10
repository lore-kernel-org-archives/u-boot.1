Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C888CCD187
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 22:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32AF83F8E;
	Sat, 11 Oct 2025 00:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LR+P5yp+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1C483F91; Sat, 11 Oct 2025 00:09:07 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA57583F70
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 00:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7af40016ab3so1894523a34.2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760134143; x=1760738943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zbjPMIVMCrZ6qn+7fuUcCjusNoQTLhr1YEBoV6woJa8=;
 b=LR+P5yp+Va24eK2W+5w++JdKF5k7sOSmX0sV5Wa6nmff/auf8NosWNQjtn6s/nFAlV
 3GdF1SmDXUVlagmwiEdhrJLW4mcvd6aechr3lgYkyNEaoA+LTbj8qw8QALSftZe9FDpT
 aD0k4t8AbZqDfGCBvIR7ODENvaI44XQAkldgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760134143; x=1760738943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbjPMIVMCrZ6qn+7fuUcCjusNoQTLhr1YEBoV6woJa8=;
 b=OGtN8uw0g9Mcv4lrRzjOwhXx6ZJLclFZzOQtqtHRqgYDB8JZiz4ZLJRhV59uEHlYce
 xV9O0ZSahz3iUAugernc75d//IYjU4qcqgzh/+q0G/Nw76puMMml8dMitcak/ss+QpAo
 ecXNY11eAOq1OVek5qoQpCJUXW8tjc8O+GPXMbkHttKdkqrO7jvudrbqqhgbKm1kLDDZ
 1NZuKeebhSqAV4q6oGSW0lalsjlT7xYQBRo7FP6YXOjTfN7AZV4/uegPGC9WYFo3jEFz
 +L1VLtRGOHTAUEz/fu6vWTGRlmUYS0tog2RLKoZaMDPOtII3TIAcLdfM1q53Y6XocwO5
 GXrg==
X-Gm-Message-State: AOJu0YxHNUpTeV2NdR1SY7ANBTcGfEQbpA6c4leF/9VZjRKiZhyKFpHY
 1KZmLjQqiAXwQLIWGAodj8VOP78RdIqoJOG3HI4jhM7HK9PhL4wKnJ8fqh7lP5svCtjnQsrJE7w
 LU2ziQVI=
X-Gm-Gg: ASbGnctc0xES2qZkPnua2vrEKlzdLMF/ShMKdVXZ5WVcJReFMML16co87itDH1Th4wI
 Vscy7iKJh+IVsZl9DZ5IrtrrRd0tbZhYt/SRSC6js/tLI7Ou6zjqbPWQxoA7oVY/tqO0AcHunzX
 ntkN3/1vlDTTzOCaRP4YQ+IsrfiWcZomjrbv+z0t+fU9FEth+E+Ag0E/ZcFCFGVc7lQrrIydAY4
 14RmmGuRQWneJO8J1z0TctGtpq7Z2jF3Ojty9PGjrgnmv3CCbjl9lvB+wkPGqDSk+cc41qp9D+I
 QPwIfqPikNWC/20Jz+X5xgvxntnMuCSQVQozt+JUstSyKbTdDpDUSjCe7Gri8YoAohQDggBkoX3
 I72QSsJIyi0RiMq1oTven9nJwFaI9ShSS/PJMYRUIHawNwIih4aNlo+35USqOMuJKVcXIaAMVNL
 yOM1hEpdM=
X-Google-Smtp-Source: AGHT+IG0wU2asL6Gp3uAlUHKngA/GVsCqfyNPyhCknviBD49mB0Iwna7FzcD/qyayYaGbIDBR4z2Gw==
X-Received: by 2002:a05:6830:6609:b0:758:6e05:572b with SMTP id
 46e09a7af769-7c0df6c6842mr8591634a34.1.1760134142852; 
 Fri, 10 Oct 2025 15:09:02 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f9067d75sm1219238a34.12.2025.10.10.15.09.02
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 15:09:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2] test/py: Update to a newer pytest release
Date: Fri, 10 Oct 2025 16:09:00 -0600
Message-ID: <20251010220900.1197565-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010134330.1094378-1-trini@konsulko.com>
References: <20251010134330.1094378-1-trini@konsulko.com>
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

Our pytest package was pinned to a release from 2021. The minimum
compatible with labgrid v25.0.x is pytest 7.0.0. Update to the current
relase which is currently 8.4.2

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Depends on this patch from Heinrich that solves a problem 8.x.x
  exposed:
https://patchwork.ozlabs.org/project/uboot/patch/20251010202926.2603488-1-heinrich.schuchardt@canonical.com/
- Update to 8.4.2 instead of 7.4.4 now
---
 test/py/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index 804a427b3514..f9eac7901fbf 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,5 +1,5 @@
 filelock==3.0.12
 pycryptodomex==3.21.0
-pytest==6.2.5
+pytest==8.4.2
 pytest-xdist==2.5.0
 FATtools==1.0.42
-- 
2.43.0

