Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FB4C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 21:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359C188488;
	Thu, 16 May 2024 23:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nuDmAqX8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC9288490; Thu, 16 May 2024 23:12:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012C188486
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 23:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59b81d087aso343904066b.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715893939; x=1716498739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M9/M4NQ4sJT2Ey+CGPaC9WJfX7bubF8lZzmPc0HNXg=;
 b=nuDmAqX80y7N2J9dO5z5NPwcM+P/mLC1XPpVOMIHMXb0K4aqIvh7/lTAERwrVlo0B0
 CCqUwU1f5cTjbeJ7swZO4zqhV/hPT7OGwYM44gWcODHrD1NNiEoMEqGyDgPykLXAgFIq
 OJjwTxXd/sMvvU4dnPYgYKagCeVRagZsaRySU3J9o1Ctwqeq2ohBNExsc4wdsf9detuu
 5Pn7KhrDl6d/sq0EOKpzRAZQVBO+Rr+ZdlgrTrkcUVr2tXu1Rxmtl7ts4aYksqxVtz+o
 FKwE6bFOS8QUWqsKhnYsV3A6RAX+T3Pt7sMIf7sDWp9QvlsN3gANZ3tpVZ4ZpJ3FR0WI
 RnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715893939; x=1716498739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4M9/M4NQ4sJT2Ey+CGPaC9WJfX7bubF8lZzmPc0HNXg=;
 b=izUnCbT0zXzSwF7Ekwh6y3JW6Ie0zPHv1sA2XdHKG2yaNXVIWsDNghzPWScKVeQVcF
 Zqjl8YOV9kblMZj76PQhiNlU4n4/NbyDRixcj6fCnROgF2A6FJGlfab/Zf5R8BdJzaEF
 lNrsYT7Br9nWwf/Haee1hUmSUERDTA3KCyunpd+8VC/TDU0GAACZtuv877nIQd5tYDsg
 0Qayvg0LYWzqzlZFM4hOR9CovDqRDrN2TWlXcfqv4xamQHJPQAqO4fLEC2TuyhkFEbem
 u1lZh5p57qtghfXcwhgAE9w7NgbXKpqIsEWEwzCx21Qpzba3H81/x4JFjs15rAO815Bx
 3Elw==
X-Gm-Message-State: AOJu0YyZ0IG1PLcRCxK+eaQ6pQBzGP6Wf8gEvZ/6wpujCkOFy1BvyOY3
 vvj8S5kJIU8kZuG58fhTec90xEEecdpejWQuIuSdUXktYCwdK5PP9cUzuQ/NcDB1vl8aqE29mpV
 1
X-Google-Smtp-Source: AGHT+IGqT73hIvx0bC0xXBD90/216X4Fh/wcOOACUgxw9oeAnENdLqgg26uAF1PxQU1hftlBzAWmZA==
X-Received: by 2002:a17:906:4a95:b0:a5a:1562:5184 with SMTP id
 a640c23a62f3a-a5a2d53af6amr2015883666b.3.1715893938880; 
 Thu, 16 May 2024 14:12:18 -0700 (PDT)
Received: from ubuntu.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d09sm1021582266b.107.2024.05.16.14.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 14:12:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Walter Schweizer <swwa@users.sourceforge.net>, Phil Sutter <phil@nwl.cc>,
 Tony Dinh <mibodhi@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 2/4] efi_loader: remove redundant hash includes
Date: Thu, 16 May 2024 14:11:50 -0700
Message-Id: <20240516211156.1819939-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240516211156.1819939-1-raymond.mao@linaro.org>
References: <20240516211156.1819939-1-raymond.mao@linaro.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2
- None.
Changes in v3
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

