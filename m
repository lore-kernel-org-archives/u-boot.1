Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3CBCF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13CD684051;
	Wed,  7 Jan 2026 01:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AdwCzvyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4038404A; Wed,  7 Jan 2026 01:32:45 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F81284051
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65e9430489eso564191eaf.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745961; x=1768350761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUansCrHPhfRA9bFx7ZFVn61mhKY3JCkQm/w8FQHay8=;
 b=AdwCzvyuuesi5MVMOl27fg7VVgkCLIBUy22ebYUxqmXw0G2YaedE4E6Rs6YlmCejw3
 RHGf4AydyM9HzwB/9zJgydODnnHVnD8rReEEydGMeZxgNl36xjyi4AKoraivJYyCjTMH
 2vNQJHT0J3B3uBOLeCfXoHmw8I7+dhmg9XNmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745961; x=1768350761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LUansCrHPhfRA9bFx7ZFVn61mhKY3JCkQm/w8FQHay8=;
 b=TKWDBQWStYuqUXI0/RfelnY02u9wjnsGNazRHLFLEajNI7eDmAZdhiUpsDOTtV98n4
 T/pmxjeRe7ZPm+2K2zo1fmJNO1aKHP5HmLugLUnbobRSVdisSP3jnVRpfDWg3dTyJdQq
 40CwGNf/wXLEtyfbW4DoiXn+7QiVzM1Djzz4wXnI0yrSRFwc1tsLJx9YQqznwRTCgZaT
 xFX27LqkompocAoqSy2nZ3P8zV0y0ISiGorz0OGgCUaCaAAMuY8dJMTDBS1nQg+PxU/o
 jcPxzvLnqO/fwvKy6rISM4NuLR6vED2gIXzbmi0OPV1sn+n93TJqMYdEIGA77+bCeyp8
 iCjQ==
X-Gm-Message-State: AOJu0Yw5Awx4G4P9C/1P0QdIsmDRdhc//Cqkj9IrHyuykYmrUi7Miz7l
 P0lNaQKZGvNrzhXI34myJ3XK3/plVI2RA3eL+DcpaXMp/wz5aHQvQc/E29zd+pcPB1pcRv0E4xa
 aNhU=
X-Gm-Gg: AY/fxX7jUog8RQlqBvoPxQ3YSjdoONbjCUr7kfwY37t+mDHvYbQuvFlwUvBD8D4yclN
 ESS4YpNp5KojiheNilsIKVZIsZF3KWSlDWS6ntjhVPQF8M99j6gs0n84ZghoTGGTXuIEyb2ImQq
 vUPKfDzAnzG/o8hhNsSQ4dSWFQStv/ca5t4/5rkg53PeloXA+Ikzgxzu4VLkxeipnrVM8PS4+Jn
 yUxnt51AejuEB90WKgPHMGa8n3Pou8so69kzIst+7rR6/qx+c/VfSSz/l8niEXpM06OfH2fJGA3
 weO6hpQrXNaPI7Yda7j6ZRDtK1jjsC1QcQDKsSo+mqauIdRHWQX9uZZrsY+XYxc8ohhXlksvPDX
 8tcSAnqoKVJ84AVdbrlHCVlCtzIKaEaGZ0ATBlotiRh7xRoS1e2vJCwJaSSgn3o0IpwkzgeDMnS
 RJ4JqJzQ3HFvthw94m
X-Google-Smtp-Source: AGHT+IG4sKO/znYljd5PrzdlN6A+T1hqIN6xdR8doKvdhiQFcuQv6VAAwe3y0dzciivrun9cHIFt/Q==
X-Received: by 2002:a05:6820:8411:b0:659:9a49:908e with SMTP id
 006d021491bc7-65f54ef22bemr163158eaf.13.1767745960899; 
 Tue, 06 Jan 2026 16:32:40 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>
Subject: [PATCH 07/10] riscv: Drop board_quiesce_devices()
Date: Tue,  6 Jan 2026 17:31:24 -0700
Message-ID: <20260107003131.3064800-8-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

This is not used on RISC-V so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 arch/riscv/include/asm/u-boot-riscv.h | 1 -
 arch/riscv/lib/bootm.c                | 8 +++-----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/u-boot-riscv.h b/arch/riscv/include/asm/u-boot-riscv.h
index 543a1688db8..3a8fdb57136 100644
--- a/arch/riscv/include/asm/u-boot-riscv.h
+++ b/arch/riscv/include/asm/u-boot-riscv.h
@@ -16,7 +16,6 @@ int cleanup_before_linux(void);
 
 /* board/.../... */
 int board_init(void);
-void board_quiesce_devices(void);
 int riscv_board_reserved_mem_fixup(void *fdt);
 int riscv_fdt_copy_resv_mem_node(const void *src_fdt, void *dest_fdt);
 
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 9544907ab1e..35403e03ab0 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -25,10 +25,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-__weak void board_quiesce_devices(void)
-{
-}
-
 /**
  * announce_and_cleanup() - Print message and prepare for kernel boot
  *
@@ -46,7 +42,9 @@ static void announce_and_cleanup(int fake)
 	bootstage_report();
 #endif
 
-	board_quiesce_devices();
+#ifdef CONFIG_USB_DEVICE
+	udc_disconnect();
+#endif
 
 	/*
 	 * Call remove function of all devices with a removal flag set.
-- 
2.43.0

