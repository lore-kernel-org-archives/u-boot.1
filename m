Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33A6CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 23:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F13583C40;
	Fri,  7 Nov 2025 00:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QYlbo2Aa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F6C83C40; Fri,  7 Nov 2025 00:28:38 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2C883968
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 00:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c6ddd07c5dso50891a34.2
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762471715; x=1763076515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uM0CClo4Vq1ZzjSCaON5XlJ94VbrEeVbq/tP4aH1Y/I=;
 b=QYlbo2Aax0XlpBtxs1J9FA+yFRxNbSjdJvkSJfaiviPUUpuMa6l9hxqLZeGM+KWeF3
 jCQgcFeHx3IjkY0ZHMW2AXuFTU2PR78ctYHIRFxUTlQHZd/s0t0Fl4xFfr4WNlPfuEuY
 ONoMl1zCMHy8auHJQ5t2K9L+y8qGdD/BF3mUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762471715; x=1763076515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uM0CClo4Vq1ZzjSCaON5XlJ94VbrEeVbq/tP4aH1Y/I=;
 b=L33+q9J21lX+oRi9WeK6HQSfEt3wNfhmcRaL8rCZXLJW55+yX6cjfsuyWNJBWihG9c
 HtVffowxNI6SUe37w2fkJl6WChPJjfdBk/x0mHHzYT2PTM4IZCtNStJGGPzuFqLDXzo2
 MtgiL4yW+Tv2MxdQtdA1DLdTV7VuY3aUmSgkJMxwGJTZPSF23cF6A2ocQ5lr3hPQREus
 MGCfqaoMYBHvERURMv2rls6Y0uVgCD9o8uqnCSnjGK3FxtW6jamKhzHHlKiLTQ95d1v+
 M3Gg16MiF8ibkDpMqYtQkMXQamUFNhZsQ5uqZhpSTX3di+yzg3OoCjwQmreaHgqmVoSs
 7Www==
X-Gm-Message-State: AOJu0Ywwua1AorYwU2yxi5UCUHZxX5j7B8YDzFhVinN+EYU3mnpPytC5
 IR3+gRHW3Q+L/kmkPoWPwt8SjIQcKFJHWlNr6ayx/HFy1hQieOFjD6fvzF7AfU+EEMz3kZEj3Xo
 0vht0QZBKRA==
X-Gm-Gg: ASbGnctzbVkDIHb3cTqCzE7sEvecF4nEfJv+lwHYLxBEt8d1b/WactEXgSa19+uuhFk
 xafJEXNZ0h56dJ/XEKJplej0vsalAKadoVI+16Os8tieaCVzWE/gE5DeMIJCLPhuTOpGAXRD5Q9
 A0xPX3DxR9iWz3KjY/IKt2w5GDkamvfyyUTsSyLe4rI/eryLomKYIQ5fTFBzBDXTE2j+0q8NHra
 FczezCQ6chMwkrVdHIu3jgMxCQrd/wMz6LmQaNVMrn585eW9rtUF6JhjnWQJdZAzXgFIEViQ783
 txphoweRhQLZClaqC0ZLkn2qYfpcC9Y9LPQqEEz+u4jLW3iJdZI4Zzy1w8LM9GFG4SkZOqtzicz
 pu0q/Mm+fGMKE95xoAu+fdh2sfFe3kKaFSYtEGYZwPqpljkRF3e37eFJpKRfwnRG7HQcmSpMHhK
 FP+81GxYE971EvN0t7ANJbvFC9j0g0FNNuyMDQqNn/2A==
X-Google-Smtp-Source: AGHT+IEkN4vSRvpAJeN4wY89m5OnfoCt+ozaJzQeDf0LvcuJslu/o52Q406J5DfH3sRC4Am2K6qV+w==
X-Received: by 2002:a05:6808:1592:b0:44d:badf:f41a with SMTP id
 5614622812f47-45015ec20admr618856b6e.32.1762471714807; 
 Thu, 06 Nov 2025 15:28:34 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c56f9f78sm1398218eaf.2.2025.11.06.15.28.33
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 15:28:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Prefix more of the sjg lab with "sjg"
Date: Thu,  6 Nov 2025 17:28:32 -0600
Message-ID: <20251106232833.3243530-1-trini@konsulko.com>
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

In preparation for adding more labs to CI, prefix more of the sjg lab
components with "sjg".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 54 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0337380f98ec..78cab64ca82c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -596,7 +596,7 @@ coreboot test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-.lab_template: &lab_dfn
+.sjg_lab_template: &sjg_lab_dfn
   stage: sjg-lab
   rules:
     - if: $SJG_LAB == "1"
@@ -642,131 +642,131 @@ coreboot test.py:
 rpi3:
   variables:
     ROLE: rpi3
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 opi_pc:
   variables:
     ROLE: opi_pc
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 pcduino3_nano:
   variables:
     ROLE: pcduino3_nano
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 samus:
   variables:
     ROLE: samus
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 link:
   variables:
     ROLE: link
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 jerry:
   variables:
     ROLE: jerry
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 minnowmax:
   variables:
     ROLE: minnowmax
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 opi_pc2:
   variables:
     ROLE: opi_pc2
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 bpi:
   variables:
     ROLE: bpi
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 rpi2:
   variables:
     ROLE: rpi2
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 bob:
   variables:
     ROLE: bob
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 ff3399:
   variables:
     ROLE: ff3399
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 coral:
   variables:
     ROLE: coral
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 rpi3z:
   variables:
     ROLE: rpi3z
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 bbb:
   variables:
     ROLE: bbb
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 kevin:
   variables:
     ROLE: kevin
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 pine64:
   variables:
     ROLE: pine64
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 c4:
   variables:
     ROLE: c4
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 rpi4:
   variables:
     ROLE: rpi4
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 rpi0:
   variables:
     ROLE: rpi0
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 snow:
   variables:
     ROLE: snow
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 pcduino3:
   variables:
     ROLE: pcduino3
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 nyan-big:
   variables:
     ROLE: nyan-big
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 rpi:
   variables:
     ROLE: rpi
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 # StarFive VisionFive 2
 vf2:
   variables:
     ROLE: vf2
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
 
 qemu-x86_64:
   variables:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "and not sleep"
-  <<: *lab_dfn
+  <<: *sjg_lab_dfn
-- 
2.43.0

