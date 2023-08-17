Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4912C3DA62
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D355986BB2;
	Thu, 17 Aug 2023 19:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Euf/csTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED9786BAA; Thu, 17 Aug 2023 19:41:33 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3DD86B9E
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d3d729a08e4so118188276.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692294088; x=1692898888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SvcEld4rkbpuE/vs+27PFDMS5rK13f0HtwTUqQkGx0=;
 b=Euf/csTfbEks3EQAPirve+2B8Bgog549Hq2uARmuRin2lUNRfn74jSaesi+XCdV12b
 NKKVTIP2WQXNPiLO3Y3VfoEEyt+bGhvuf+PHDZhDLNTDITzsTj98nCxmyE3/uOi9RANh
 YY8v4IwL9xXOzlAj4SK+BqJQYKwvaiCCw/SQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692294088; x=1692898888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SvcEld4rkbpuE/vs+27PFDMS5rK13f0HtwTUqQkGx0=;
 b=guuqMhiTrG1U6a3cim7dUNBKAn2cDgQNQpbIGopN5xst2k0Dv7PIjCqPXkZsiXSJfD
 fuFB4479Yaw0q9JG5VCbIaruHKzVTq7t2KaZKSMXsAuHGG321BeAqIu2fy4AOPqoiNhb
 lmE5BpMPv8t4Vg/PgJm5HrgN+2GN0lBtT408z//ZbD92MRS3/Q8r5UygBIHbBnmN1CBt
 so0e+K5BVf0u8Hp3PazcfYn8EILiRH5MoAybJ2cTOezAob7msBmeWTQFyA4PtnvDEGDO
 9KrK1BenjwH9WINIfUCwz9V/jTkWhvcS3zjo3a0KduF2UVw4kQoTTi3N7W2IhBX/ETzh
 GhwA==
X-Gm-Message-State: AOJu0Yyyom3jU09HDwr+g9nSatTkg5yc6210chMJE+ujRPTyhCB/i5IO
 /leiM7t5dVipzaE+4M8c3VPZsuutTL2+wUVVeRfLeA==
X-Google-Smtp-Source: AGHT+IGgb32SpxcF9xt3hDeNe7LfxY2fOKWcMG/6u9xUF9NxCs5kZPEIaMl4n2I1hBHJYVKa7naNaQ==
X-Received: by 2002:a25:37d5:0:b0:d11:97d5:e8a8 with SMTP id
 e204-20020a2537d5000000b00d1197d5e8a8mr199663yba.49.1692294088332; 
 Thu, 17 Aug 2023 10:41:28 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 78-20020a250d51000000b00d1b86efc0ffsm4099005ybn.6.2023.08.17.10.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 10:41:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 3/4] xilinx: zynqmp: Move dfu.h include to be with the code
Date: Thu, 17 Aug 2023 13:41:24 -0400
Message-Id: <20230817174125.369849-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817174125.369849-1-trini@konsulko.com>
References: <20230817174125.369849-1-trini@konsulko.com>
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

Move where we include <dfu.h> to be guarded by a DFU-related Kconfig
option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This becomes an issue with
https://patchwork.ozlabs.org/project/uboot/patch/20220620111354.448512-1-jh80.chung@samsung.com/
applied as now we can't include <dfu.h> without CONFIG_DFU_NAME_MAX_SIZE
set (or we have a dummy value for ifndef).  Another option would be to
restructure the code to move the dfu code to another file, but I don't
know if that will make the rest of the real use cases here easier or
harder.

Cc: Michal Simek <michal.simek@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 309f24a5f43d..367c3c65a9dc 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -8,7 +8,6 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
-#include <dfu.h>
 #include <env.h>
 #include <env_internal.h>
 #include <init.h>
@@ -606,6 +605,7 @@ enum env_location env_get_location(enum env_operation op, int prio)
 }
 
 #if defined(CONFIG_SET_DFU_ALT_INFO)
+#include <dfu.h>
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
-- 
2.34.1

