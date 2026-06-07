Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87218CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A26B0846E6;
	Mon,  8 Jun 2026 01:05:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GB1Nu6ym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AAB8484F; Mon,  8 Jun 2026 01:05:42 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D14846E6
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4866834f8deso1408699b6e.2
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873539; x=1781478339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1QxUAw3KfnVQjAUQzTgMRAbhUgxddnyje/lW3h5xtA=;
 b=GB1Nu6ymgiTBt3FWjdQQQxfBdyof3F7q7idJ2bWhlwXCcLSdkzAQhPUs7hC5dwfyct
 vlvgMwXPVT5eqOC2qWsXLCuhW+HaoDRsoFDCpgce71R/a1XRf1A7+5sFWtrBT6T7uwCE
 iS7duW15wUXUvGYIH14mLi1nGNImg4nzsuLv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873539; x=1781478339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K1QxUAw3KfnVQjAUQzTgMRAbhUgxddnyje/lW3h5xtA=;
 b=DynX62G6xXUgjXpcm5kqqJjE4oE6N2X03FOxkT3/l7i3+meoy43DY/qye6o/TKIvg6
 6a8hW5oKRERZ8zGBV5HBbvWlXNwPKe+GnFgf6izXk63xABWyPOuspDpchWOlcotAHmx3
 WMAbBNnrCi4TdqmBLxO8YT6fnzzKn2Xoq94f6vpZDH+pOZ2oJlq8rYqw0K8G7tLK9vFK
 tKBKqqaLiY3AOwMe9AAm9wTgPvk2lQUSpyweMaox9/sz3k0UicjXurxVBuyeNMTmO4bI
 lA0ZUfQH5SA0OBbF4uq0RjWndGNqZTw4gzLdHVg1GBE0pD5HzOMJciRGP8p8cuP1SrIz
 T1LA==
X-Gm-Message-State: AOJu0Yxx41XVNKQmXsekUx2gPMIpHBfiL4Jylck0qD22XLRYSHCp9T4u
 S/ONzEN2uOVInFwvvDzJeLRRuZlyoFEvfFHHJN+Pz36fpL5mrFB9WEf3BaroPzQxBfefa+wmja1
 /wGtjZw==
X-Gm-Gg: Acq92OElvu3JrrXeGGtu46H1oUd1i+rvUjCXJlFqljX2EHBXuL+/m61SXuffb5hwW9W
 mAfCAihMr0+g6w5THJUmlINHrxZIaGBXouTv00WpNjy5a2YnbpcTjnEla9OACuReE7XBFC8NDm0
 ey/PFEFVBueDGmSQJUnXZgFE6/iatYU+rCRB7UauSQAwW7tfmwhFaujmpePRJ+n/4biMMSbGvoV
 xqj+KgnAsTtIqEqGqzXY7g7hRVr4brDQez94vNFMyCvQD+WJ13msVetpMa4hXt723hxCgulS/js
 nwIaNf2FVL7wPlcNUU0QIvcooppPCUuR36lMphVI/I5CAX2eYRzdKD6c7o9PKDJ1+Pm1XVXdtAw
 e82YJjXJRUfsudLmWQf2JIk2m+DXGA4bi2KOcaXmyf++ccW1pJnkYzRII9BQ8+PcguDun1RRX49
 3SRw6KDTDQT+eki57UlTocR0IZaTav
X-Received: by 2002:a05:6808:1793:b0:47a:8c2:a573 with SMTP id
 5614622812f47-4868dc5746bmr7539760b6e.20.1780873538984; 
 Sun, 07 Jun 2026 16:05:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] CI: Add an sjg-lab job for the Intel Edison
Date: Sun,  7 Jun 2026 17:05:13 -0600
Message-ID: <20260607230519.3022520-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
References: <20260607230519.3022520-1-sjg@chromium.org>
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

Add the Intel Edison (Merrifield/Tangier) to the sjg-lab CI matrix.
U-Boot is sent over DFU into the board's eMMC u-boot0 partition during
U-Boot's brief do_probe_dfu window, and a reset then boots it from
there. The lab environment handles the build and the DFU send, so the
job only has to name the role.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..b207a113383 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -797,3 +797,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+# Intel Edison (Merrifield/Tangier); U-Boot sent over DFU into eMMC u-boot0
+edison:
+  variables:
+    ROLE: edison
+  <<: *sjg_lab_dfn
-- 
2.43.0

