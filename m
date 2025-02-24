Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CF8C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1605881112;
	Tue, 25 Feb 2025 00:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="js/XecSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC1081112; Tue, 25 Feb 2025 00:07:44 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A28280EC0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d191bfeafbso17001205ab.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438460; x=1741043260; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNE/nqT7GoSZZ0UFokmZJ7KYxPMfGEPqXCv2X80VOmg=;
 b=js/XecShNKZ0IhRUGGuKHNOUGkPD92/Lqt41uKMtgbyCmt3D/4pZzKyK8QwU2oNxO2
 YKlfcNOtbDu+tfk2ottuWscPWpUcIJKU0FpTI7PUoPn7Cs14eD4YDJvOCNSGT/WoYA6/
 WZTXSN2sPh+DvpAy8D7tyl3mwovHHRBDp8FB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438460; x=1741043260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hNE/nqT7GoSZZ0UFokmZJ7KYxPMfGEPqXCv2X80VOmg=;
 b=ogFDXvd655TVWJ7Jt4edIqolcFbuAbXXhKZyekqw54IHzMokUU5AnezAo5H4JUnz27
 9J4/XraslqNCD+pr6W6Ylk/CMBGCZMG+yOw7OnkSp+Ros2rkHEodWazxqUVA7wUPtVqD
 mg8bKzjLonNBrpcuvOmT8gQmabi6lKU0slfT0in8Nqa/ovJSn/BuQvt6ZVgWEJcxkqQt
 HefU9RwpuS7jgM/KL0OvXJphklzKAhkIww/+vWgHw7XTQX39s7IMjuB7SNDn+4PN29/O
 unfTDlueGIgw96BG09X9thX8A4vI+Zipd+Av6Eid4AgjY6x7vFUhIVPDYQcggwDJ0j7Q
 L35w==
X-Gm-Message-State: AOJu0YyJf70OtGgavRZLMf6ZYDtm91GWbzB1rbHPLrK3hFZxTpyF7RBs
 smx4JCwK2jzQI+Bb7uTg93xJslu/iSO7S1u6jUMowJVhg098iPaUafkJHAKlxv68kANsoRV9/Vo
 =
X-Gm-Gg: ASbGncu6Zh71uU+qR+m81IJ369cMMEXYDTIOkjTJ3HZxniWcuuPmg48lCMgCBrY01oJ
 epBtU12Q5a7TLCOYNFBY62DOF8BLgfeQpqJ/JcArUgIH/SYR0ucmkEUL3DjQHQ31CyWddopn6Lw
 0IpHbV1bpXerMILv2qPLKWM7+I7ZGhtT2rbqCHfBFXZ1cMIao7vsKzhJs1/5xRKkmoXI1AXRAB0
 bWMXe3MRILlfl/wEIUOJQLqqqM5h3dEvr+qLObNTWaCG0OcWeU042Qa8zdeZuA4t+LWABb8ur8f
 5x3n+AkWStGYwuHCYqLXbngZIBe7WdXGaz7HRSVoUFasUOFEYrPA0f2LlCZxYzE=
X-Google-Smtp-Source: AGHT+IE8yD+6JOXc1MtkZpclW7WMc9vojJl5kMJliiAZAeIic2yk3P9ZdJ2ElOD89glhYOqcl127lw==
X-Received: by 2002:a05:6e02:1689:b0:3cf:f8de:7662 with SMTP id
 e9e14a558f8ab-3d3048a66dcmr15058375ab.18.1740438460612; 
 Mon, 24 Feb 2025 15:07:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 21/44] x86: Update mtrr command to support 64-bit values
Date: Mon, 24 Feb 2025 16:06:10 -0700
Message-ID: <20250224230640.2665206-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

The MTRR registers have 64-bit values. Update the command to use 64-bit
values so that memory larger than 4GB can be handled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to update mtrr command to support 64-bit values

 cmd/x86/mtrr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/x86/mtrr.c b/cmd/x86/mtrr.c
index 93be84f74b8..289865515ef 100644
--- a/cmd/x86/mtrr.c
+++ b/cmd/x86/mtrr.c
@@ -13,7 +13,7 @@
 static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 {
 	const char *typename = argv[0];
-	uint32_t start, size;
+	u64 start, size;
 	u64 base, mask;
 	int type = -1;
 	bool valid;
@@ -26,8 +26,8 @@ static int do_mtrr_set(int cpu_select, uint reg, int argc, char *const argv[])
 		printf("Invalid type name %s\n", typename);
 		return CMD_RET_USAGE;
 	}
-	start = hextoul(argv[1], NULL);
-	size = hextoul(argv[2], NULL);
+	start = hextoull(argv[1], NULL);
+	size = hextoull(argv[2], NULL);
 
 	base = start | type;
 	valid = native_read_msr(MTRR_PHYS_MASK_MSR(reg)) & MTRR_PHYS_MASK_VALID;
-- 
2.43.0

