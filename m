Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B42F513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04CA284010;
	Fri,  6 Mar 2026 03:37:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iB3SSg5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8387D83FEC; Fri,  6 Mar 2026 03:37:26 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E0383FF8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-506c02ec1b3so96735701cf.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764642; x=1773369442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTeRQxvHJPHk4ioHAjThjn31LwGd1K9swZHP2/Mbk+E=;
 b=iB3SSg5e2phI+WT8f/bXom0+PShXxj1BhK8vhrzvd6XW1bnXMI7fMtAEx+waWXiuAq
 FRYYBaAABIklh/acuWSqMphqLtrA3WC8rrDIUjUrkD7H5UR355+2kBml2vvnxoPdwKp1
 qNjw0sBGnq8Z/52NsRbIk2EpWRuBKXJNK/g3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764642; x=1773369442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PTeRQxvHJPHk4ioHAjThjn31LwGd1K9swZHP2/Mbk+E=;
 b=M2seNl6/L6RC2MkVbgBf7l93RXle9/xJz8J8tkGK3PmD1JlwVaE8cqv3SLVEVEumfm
 QtG1ghQ7FJsOVhtBy11lzrPsRLroQH2rTJBQ+jeoA3RHChfFWp+XLjAuU2GYV6yez38K
 mj3SlJLKzM9O8+XDRATY//n13fa+aWcsqp368SKkWt6GeVLL/PD7HOCKU0N5+gXnWdiU
 EfnUhDa/Enoor62vmJ+qa9h0ohVB8bFHh4oOKVcka3cg0h0yqAXMLcw9J6tmhAinD5OH
 B6tNq/yaa9a3D6h8oU+fWYH1eDGO+gFhW4rKeTDKWrEtow7f3gHgrjm8V/d9qGhBPaXh
 ff8Q==
X-Gm-Message-State: AOJu0YzeSFpRs/xw6WOK7E5I/L3pSifvs13cieE99ezy9YAKna3fv+Z4
 U645x28VrumxrELsKu2z/dGaiqTRXm26DJ1lN+NUPT5/s01fwG8rpeBj4CiSN8FLMqbnNX9IHyr
 XPGU=
X-Gm-Gg: ATEYQzxbdyXXA/XSlu5KgQBqVmxVu71/OaMeKLcPwoC8YSHQg+eh9LDWs6Xdu5WrNv1
 CFGUnxDFmnmyYl+Pb5lUsXrRzxuQML55cJZUryQapd9u/l/vCLEiHVL2jPTtyZyPle8RnkE+Sd4
 C28UhB0PGgwo1Cr34/iHcncHNfU/fm5K/pRBgIhoJJfr/8LqwPrIrHjdqEh/njr0xRZtYcn3AgP
 wjDR/+M/xSRuRtRlGV8IK7emsY7V5DTqfgr6KDVBBh8cLrmJqDhpWkX/R51ni7i7+d3d1fSVdHM
 e/0Zzdciq29ogiXy81lf8IvIECGkX+wI4a/vgVJXHZC8NbCpDwhhe9ps2DieEURWktLwWnYHK9n
 ojnIA7btnzAFvwRZR5Rmai8VPsrnALGjQBmI9pi4qQksMpDV4NQIH77Srg4JadF0rZMBwf1WU4E
 02s0Je1U9T49ZudOm7Rg==
X-Received: by 2002:ac8:7d06:0:b0:501:4b9d:ad19 with SMTP id
 d75a77b69052e-508e6947452mr61120541cf.22.1772764642163; 
 Thu, 05 Mar 2026 18:37:22 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH v4 12/17] powerpc: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:21 -0700
Message-ID: <20260306023638.2678886-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Replace the open-coded bootstage_fdt_add_report() and
bootstage_report() with a call to bootm_final(). This also adds the
"Starting kernel" message, board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on
PowerPC.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add new patch for PowerPC conversion

 arch/powerpc/lib/bootm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index dc44bf3ab3a..f9351a17a48 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -54,12 +54,7 @@ static void boot_jump_linux(struct bootm_headers *images)
 
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-#ifdef CONFIG_BOOTSTAGE_FDT
-	bootstage_fdt_add_report();
-#endif
-#ifdef CONFIG_BOOTSTAGE_REPORT
-	bootstage_report();
-#endif
+	bootm_final(0);
 
 #if defined(CONFIG_SYS_INIT_RAM_LOCK) && !defined(CONFIG_E500)
 	unlock_ram_in_cache();
-- 
2.43.0

