Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD455C54ED1
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D520B8304C;
	Thu, 22 May 2025 01:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C5nElWan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7241282FC7; Thu, 22 May 2025 01:01:46 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B703282FBE
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3feaedb4d2cso4978517b6e.1
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868501; x=1748473301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KugI/gLLbU/hstpuSUipMi9VzJvDH6ly7TVttHiwfs=;
 b=C5nElWanC++cVtrJCsMFAPuX2HUPMNbesxZVzWk0yAsNvh46oQelO6NPq5lVwVK50b
 biA8dbnP5fOYzLmVg9q5fGsWs8hygU3G5O0Lrf339MhC1h5LiptUpInRZZ/AWFYe3yiI
 j8ovThbkBduFgNbnvhqHLgskHXROwyNyo7XXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868501; x=1748473301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KugI/gLLbU/hstpuSUipMi9VzJvDH6ly7TVttHiwfs=;
 b=mFqmTN10n9VvcaU+1EMsMZVIh64j5wV0qx/Cg5Gx0QKvCDZ5zqJmM3lpAP1+v0EISP
 UN0XKPdibx+4jynF1Hn52jUWPcLDnRhs+BPa5PFaTeR19KFzXSu6e78hUUrFRZKiGT1z
 zd6yW/AMFe0//vdm4F4UpJv4+4eYGfeY2p9hzjxksmbXprQB7FrNZnDDXj1pBABWoGzY
 mUmFs6ir6ub41lDwMdWODRtbfdJwhPamKokqNAaUhEscu41Rn9LUXCfC/4G3+1YtpmU5
 GZjJ06qseQs4/ALYMWJ4bC3iHa+bIANQzp628NxA/oXy3d1gGeWEpnpYiSyrSKA/bko5
 yzEQ==
X-Gm-Message-State: AOJu0Yw7rlwnwbk9mBzvF0vbd0ghRwikFpdhApUVH3WcwffvivACdJkg
 ctVhORnqzWnoi6zC93n/7nFhShsRGk/8CsCjUkQAjxCmm1/SigS6pBJ1Kc4n4fzmbr5RrCiS7fB
 JVhtBUUw=
X-Gm-Gg: ASbGnctAbAlWamFsw23OaieTHj3X8g8GshsPdNHOiA+FNb1ITe4jfPwda6Jzz3CoJxU
 6Kv5Xwp4aAwVmBaRoa/cDa+KoUGsSk3L0K9HNqyc8Bcrtsjt6UMNBu88FgdpPoOYzc4vr1R7soN
 KUgueGWLChI/Iuvv5w5OOK6BsjfKFtJLph8/KNa2GlNTuiAh2kEZop9kJhj5UkneI85RQwmcoDx
 t2I5iUB6QjFaEIPvcrb07lSp12nJ8Et0k7XLxrWZV0LUXd1ulP31LRRw5WC55x9wC4pQy5jWEjE
 yu3tlN72JkHS9SMRJADTW8mOX/fnVk4Ck0E+0P57Z4Vfhux/sbI0QzxrC25/igGnf0SH+M0f4aR
 3XAuPt+1cu2evp+s=
X-Google-Smtp-Source: AGHT+IGMX659BQYiC2VmK/HYQf+Mmuq8qTEddSvuyhuyG739bTsKaPOugRoUQzryrWBwPOQVfgEhfw==
X-Received: by 2002:a05:6808:1b8b:b0:3f8:2c35:eeca with SMTP id
 5614622812f47-404da631c9emr14297803b6e.0.1747868501447; 
 Wed, 21 May 2025 16:01:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 12/17] include/efi_loader.h,
 include/efi_tcg2.h: Audit include list
Date: Wed, 21 May 2025 16:51:17 -0600
Message-ID: <20250521230119.2084088-13-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

In include/efi_loader.h we do not directly need <log.h>, <part_efi.h>,
<pe.h> nor <linux/oid_registry.h> so remove them. In include/efi_tcg2.h
we make use of <part_efi.h> but did not include it, so add it directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_loader.h | 4 ----
 include/efi_tcg2.h   | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 84e8cfe320e2..f3c85ae8d663 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -10,15 +10,11 @@
 
 #include <blk.h>
 #include <event.h>
-#include <log.h>
-#include <part_efi.h>
 #include <efi_api.h>
 #include <image.h>
-#include <pe.h>
 #include <setjmp.h>
 #include <linux/list.h>
 #include <linux/sizes.h>
-#include <linux/oid_registry.h>
 
 struct blk_desc;
 struct bootflow;
diff --git a/include/efi_tcg2.h b/include/efi_tcg2.h
index 7ed88809913b..34a3d4a04346 100644
--- a/include/efi_tcg2.h
+++ b/include/efi_tcg2.h
@@ -17,6 +17,7 @@
 #define _EFI_TCG2_PROTOCOL_H_
 
 #include <efi_api.h>
+#include <part_efi.h>
 #include <tpm-v2.h>
 #include <tpm_tcg2.h>
 
-- 
2.43.0

