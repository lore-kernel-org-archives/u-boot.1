Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540D5CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 23:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C05583C5A;
	Fri,  7 Nov 2025 00:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oiv19Gzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B0D83C51; Fri,  7 Nov 2025 00:28:39 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A713C83C08
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 00:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c52ce8cbe7so139877a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 15:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762471716; x=1763076516; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pc3wa9jRyOaAcKLvP62F/fDic39fAv8UVgc6dB8oKkk=;
 b=Oiv19Gzqertz6q/s9f8aLe5EUNm1grutudOz1VcCmajVzVhqTPx580Sh6JBZeZar8c
 N7i+D3p8uQdYM77i/j2zVSxmlF7mO3pkAQRCwKzzbFta39EL4WmU2evFt0ZpeM5oT7sl
 6gQ19vpxN91zyByvbs7mZRKVg9Vu4wlQIe7vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762471716; x=1763076516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pc3wa9jRyOaAcKLvP62F/fDic39fAv8UVgc6dB8oKkk=;
 b=EBme4K5tuYvd+pjE7hz23/Wd+dCVdiWtrFUAPeH6PlTKH0wopkkC6E+37q1UMKrrWo
 ddNPqPKH+/phYQ0/6VvX4COtGo3By0aeIH0rXc6WqQpkJfUdmrtjjLOEnQteVFjAuh6+
 pgpPmu+WPXDaMJhLtoVB4g2vgELbwXlolv1Ihl1zxPTyNMuKy48nmYYRK+oQC5vf30r6
 KHNn+KXuiGDF13yfyetAQ/2p85dFz6/jP4J5z9iEgy3JMY7IsqxJC8vQkeWcLFRx52LR
 o1k3X6A+xOf/SiquGguQt+L6leE4z9hlVTSFh5kKYWzSc8xhWwj/zgXIcUL+lE/rIz7g
 7ABA==
X-Gm-Message-State: AOJu0YwEiuPoIhfwgn8/AhancLUrAT7t2Gh1O8WP7/LdmSmfUhRHd7L3
 7TMSp40+XGKZy6zrW6x1tz9e9AumjzV6Zu8B0lcadSdraT56Nl+NVmToht6H1McC7Ri3mfvwdtb
 V2HsrWASFZA==
X-Gm-Gg: ASbGnctogY8rM9lxp9JeyTfVKyv3qjzpKX5l0u9ZXhQ8hN6srEQE0pMnUI5enoTGhZD
 hpqRuwj4R5YWoIHASygHdg0DvBJZIXCH0yJLvuIbz8mC2NxIft1JlwU0SpC+VkwnU8Dt3Mrdcqe
 NYB4/AqWoxVN/wJlUaPh8sKTIBvCIbWCYdj7HuU/7ZONYDe+tTRBk5g67AFWKq7/1LQOo41GjMR
 3gzg0vlJc6tRlYh2r3uJCWvv71emldOasc1PlNBrpTXau4XjIvCUUyaZnwlEJcP+YuEBSR5HNld
 DtISMU2htIFfQ1WmVSm81Hn47WUuYrT79JeYp/RQpQaLhZks8xM19tk9PNuc/+NtRu1RhxVDY4j
 YB5sAlI8CwiXc6MZAz3fGLECH2Mv7MkRsNmndFBAgQwyJBaicug6xASaoAyB/4A28vCYMPZbDgp
 KX8uqxJ+eP2dWWIxcn2fQazaEJwlGoKs4Ty2PUxcPur2De59umxNDP
X-Google-Smtp-Source: AGHT+IHQPCqVvW6WAGxIldY68P6CwbjjtAk7W/j7z/BPnaak63ZcMxUm6ygI/kecXrVm8BLp7nk5cQ==
X-Received: by 2002:a05:6830:410f:b0:78d:a443:8c93 with SMTP id
 46e09a7af769-7c6efc85992mr1089253a34.6.1762471716455; 
 Thu, 06 Nov 2025 15:28:36 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f112fdd6sm468545a34.25.2025.11.06.15.28.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 15:28:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Optimize the job dependency list more
Date: Thu,  6 Nov 2025 17:28:35 -0600
Message-ID: <20251106232835.3243576-1-trini@konsulko.com>
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

In general, we want to fail the whole pipeline as soon as we can if we
spot an error while also letting bigger jobs get started as soon as
possible. Currently we use the "Run binman, buildman, dtoc, Kconfig and
patman testsuites" job from the testsuite stage to unblock the next
stage as this test is complex enough that if it passes, likely the whole
stager will pass. Using this same logic, unblock the world build (and
sjg-lab) stages if "sandbox test.py" has completed as if there's no
failures here, there's likely not failures in the rest of the test.py
stages.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 78cab64ca82c..6a36513c3b75 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -142,6 +142,7 @@ stages:
 build all platforms in a single job:
   stage: world build
   dependencies: []
+  needs: [ "sandbox test.py" ]
   tags:
     - ${DEFAULT_FAST_TAG}
   script:
@@ -605,6 +606,7 @@ coreboot test.py:
       when: manual
       allow_failure: true
   dependencies: []
+  needs: [ "sandbox test.py" ]
   tags: [ 'lab' ]
   script:
     # Environment:
-- 
2.43.0

