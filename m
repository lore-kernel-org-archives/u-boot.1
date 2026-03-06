Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97920F513E9
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B7F84057;
	Fri,  6 Mar 2026 03:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T6NrL3uS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3106083FEE; Fri,  6 Mar 2026 03:37:36 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F9484006
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506e287dd53so75187561cf.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764652; x=1773369452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmdQnnOLrN2xFK0qzqb8HrGH33ntVcfRjOD+B3kYlig=;
 b=T6NrL3uSrNYw5v8Hu679rb/0fAqhzcPvrBW7oBZfL4V9fjHg3R1KhO+NgdHbgOQpGH
 +3U6rNhoX6xzsRcd1+UaU5OqO0kr3s5HgHRZZd6rm4wjYQBG9gRBCvPLsc7hWRgJN9yn
 AIzj4W9RxiqCn6PpJlC/jF8HBR8ezQ3rII5x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764652; x=1773369452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mmdQnnOLrN2xFK0qzqb8HrGH33ntVcfRjOD+B3kYlig=;
 b=mtRxKD2+s390oCFDrOxP849f12sRHMQkK3grMlYln/39f0OqBbi/hOfhCgnfoZ/4Oc
 AEtKzdJI1Ltha5Zxp+Jlx8gm/b48Lk+6IdGaAT38zsmiiqymfzvcVGdZJs8mckyv3sSk
 MgGI7ec+YslhUXPmP26BhXyFlkA0GoNXbvjEc1WjwHqdG7IU/VCiMJcoZAE5snKmNu6Y
 soclmSyj2+AhEXiC4E27wC/HFt3ITII2Bn90psmyfxZMSDpNoSoEGJeXCMRPAUOHsCrZ
 9I73zbnCgPEihtyyPEnnlGIFidVUJbNAbuZQcqsk5tiB6lf8mvrStF80DN5/bc6F//rE
 VJGw==
X-Gm-Message-State: AOJu0YzDrTClpP1yWZBZbjD4bXmPxGqrvtS+VXSQjQ9a4TQraJSpFKFv
 h9CNta6/k+tKsVK13PiintYAjlr0Kz20MdFtOomNq+k2b9OOkEx68wkt2UKGaUiWIXl+sPX2/ZP
 5Css=
X-Gm-Gg: ATEYQzzJnb4X4me43dINVyocpqRRlA9ykFa1BItYLLlmR/R+fKYXSvkvt+KDhR8mBYO
 3x1fQKIfkZ3UtbPLdnS2yjj3/SSXTlEmtdrr2szhiQohsKLvZF9MO2zkl7bL5sDE5mInRSrUMnt
 XgnxE57VSpf50RwAUArV80Fhl6KszDaKhWVsQR5cNEHRvkILb/KuLBxC6rEvUE2XRblKSpHvBgt
 h3aJmN8tT0HowOyP8sFDERN24AHlQKl6v/w1gbgqsvUjSdelMZ8PQv1GRhPvTrKAkR1xubkuaNn
 vy3u/uZaFpr0ChxVs9X2vn/BPGbPCGopAAkijuYZLk11c9YlWXOw+sef5Usq11vulM6fHSm1r8P
 mX+nM8Ao8g6Gajj5NXSv7+VIR7U5pVLBHleMmVKUzq406AY+z1P5mbr/MV1MwdYkfJzn9M9xbVF
 tUEy5dZOi1797UQDfYJA==
X-Received: by 2002:a05:622a:2ce:b0:4eb:a192:de99 with SMTP id
 d75a77b69052e-508f497a09cmr7547231cf.76.1772764651894; 
 Thu, 05 Mar 2026 18:37:31 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 17/17] sandbox: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:26 -0700
Message-ID: <20260306023638.2678886-18-sjg@chromium.org>
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

Add a call to bootm_final() before the simulated kernel jump. This
adds the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on sandbox.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Pass flag directly instead of using BOOTM_FINAL_FAKE

Changes in v3:
- Add new patch for sandbox conversion

 arch/sandbox/lib/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/lib/bootm.c b/arch/sandbox/lib/bootm.c
index 44ba8b52e13..7a5f6f7d36e 100644
--- a/arch/sandbox/lib/bootm.c
+++ b/arch/sandbox/lib/bootm.c
@@ -73,6 +73,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
 		bootstage_mark(BOOTSTAGE_ID_RUN_OS);
+		bootm_final(flag);
 		printf("## Transferring control to Linux (at address %08lx)...\n",
 		       images->ep);
 		printf("sandbox: continuing, as we cannot run Linux\n");
-- 
2.43.0

