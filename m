Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55204C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 17:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE459883DB;
	Tue,  7 May 2024 19:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xBEQI4Fu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD6B883DC; Tue,  7 May 2024 19:54:37 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FFB8836C
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 19:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6a073f10e8eso14541396d6.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715104473; x=1715709273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rBFxyHvoIsj+vZf/RfI3f3HY0VFCUCERlHUbpzhqCs=;
 b=xBEQI4FuuTVN6Pc1vzEQWbearc5VU0rIPkKMgmn78f0ht9WgLImbNLrWuZXz1oParR
 d3ZBhRNrTAkWQ9cs243quIzOUpB97GOkQ5AAcnBx6zqF10mqzxTYfzYVYeMNpS6oLVs/
 Fpu0DuHreNs1aAnuBVJBPhI2TXWKTn7foWrPvNMK5t/g1qzM7W5CkCCT7I+CbS3HgOQN
 VbHyE7YT1xxkfao4592o2oOIpFEx6Alno4brct1lRK+nO3nvUUUvL8JAxA+R8Ypu4RTt
 qiV8o3naRmv40kV3piBgjHpdPua0KKNIaZkI1i6UBNYPyF5kXxnbrfftrXEO+bmmPsiM
 wUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104473; x=1715709273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rBFxyHvoIsj+vZf/RfI3f3HY0VFCUCERlHUbpzhqCs=;
 b=UGxCHzrNT5ZQXWS+8Sil641RlTNFVnkHPGQW4FX8XWtgEtSHzFQkf9bQlRBU8kWDw7
 kFPPNkOlSy2zQ20OlX/88NHFGYoG75VPjjZ+L2QOTulULvJ9mzpDpSmtQSvkcWKt0YuY
 FGbJ5XsgFA2MI7HoIj8zlSgY35EXnTuyo0GkUktC4VxCRQoFRKR3JxLNzNMNYdTg51tm
 n8lA8lcu0szZDK3DXR9jCxrsc9k3lj/uU1+JRI98A+u7XWzw2W4uI4HGWZozUpTMxg2r
 JwlLl2y8nbaWlfASZCj+OqJYV1Kz7PRLjD8HPOPy+uaxVR8vGB3B1XWw3eGsq23kGGYm
 hDpw==
X-Gm-Message-State: AOJu0Yz/8e23+w7QgFTkxMfbU7bsz1db93I4PPhOXKS9Ryy75oN9tYdh
 d+l5k2EVl7uQid/j2M9QnnHk8jfCToPgqDgqijm24NjV0hcG76Bd9dRMMGNx54B2SA8lCqCZvph
 u
X-Google-Smtp-Source: AGHT+IE7AtyohgL8kR3qMbb6PEPo0ntEdzI8n4wsoKcbDSYGAd+CAEx6fHGR+Nv0WfWegjFnSfcfIw==
X-Received: by 2002:a05:6214:212f:b0:6a0:d291:a349 with SMTP id
 6a1803df08f44-6a1514e626fmr6468076d6.54.1715104473533; 
 Tue, 07 May 2024 10:54:33 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a0cecc1000000b006a0f126a033sm4801834qvq.28.2024.05.07.10.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:54:33 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andrew Davis <afd@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Ilya Lukin <4.shket@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v2 06/28] efi_loader: remove redundant hash includes
Date: Tue,  7 May 2024 10:50:48 -0700
Message-Id: <20240507175132.1456512-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507175132.1456512-1-raymond.mao@linaro.org>
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
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

Remove the redundant includes of u-boot/sha1.h, u-boot/sha256.h
and u-boot/sha512.h

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.

 lib/efi_loader/efi_signature.c | 1 -
 lib/efi_loader/efi_tcg2.c      | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_signature.c b/lib/efi_loader/efi_signature.c
index f338e732759..184eac8cddb 100644
--- a/lib/efi_loader/efi_signature.c
+++ b/lib/efi_loader/efi_signature.c
@@ -17,7 +17,6 @@
 #include <linux/oid_registry.h>
 #include <u-boot/hash-checksum.h>
 #include <u-boot/rsa.h>
-#include <u-boot/sha256.h>
 
 const efi_guid_t efi_guid_sha256 = EFI_CERT_SHA256_GUID;
 const efi_guid_t efi_guid_cert_rsa2048 = EFI_CERT_RSA2048_GUID;
diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index b07e0099c27..ac056dcfc55 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -19,9 +19,6 @@
 #include <tpm-v2.h>
 #include <tpm_api.h>
 #include <u-boot/hash-checksum.h>
-#include <u-boot/sha1.h>
-#include <u-boot/sha256.h>
-#include <u-boot/sha512.h>
 #include <linux/unaligned/be_byteshift.h>
 #include <linux/unaligned/le_byteshift.h>
 #include <linux/unaligned/generic.h>
-- 
2.25.1

