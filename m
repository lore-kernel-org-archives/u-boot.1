Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D81CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36F1783F85;
	Tue, 18 Nov 2025 19:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="maXCh5L4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3487D83F85; Tue, 18 Nov 2025 19:04:20 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0033783DA6
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-450c6f5ff81so32039b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489057; x=1764093857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gb76TJSAGAuCRpkBo8BxEewcxP1GQdqeDHzMxFk3yZ0=;
 b=maXCh5L4nQGUFbqyAt4dWsaAr/zke5FulXLf2lJ9kamvtIR+ibwX8Voyx73qeJJcOG
 OV+vbzDgv7adCGHIJCN+8uy/gBl8vvfhSSiTkbL4J48lXEuaoehgdjMogJ+6GWhqT0yw
 csDaJ1vKofqgu6Yyo8zFLsoZGtAkD8bT66cI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489057; x=1764093857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gb76TJSAGAuCRpkBo8BxEewcxP1GQdqeDHzMxFk3yZ0=;
 b=roqtbCNXIEMt7TR/OJbwy5IoWG1XWNvRKLz/tf19m7naNXT5ypdb3zPvpTuRAbHIBA
 PCEh6OzxyQ2/a3KwjsypXSuSShmszCZ9O0xCvvn10AD8c2vGjd39NqGAVFn/mtzFTR2h
 LUNrUi0K6lZe4oq2FyRPg/ghR2hzZjQwkhAEGA6yMGyZQrBBya4yerU8TRG5DSRRqg6C
 oK3Vny1v5Hdui3GmEUC8Dtx9QI7mQZ4lFGfFvUJkprsH4Ao8vKpFkMrN3tk/C7xq8Fje
 wJvgRRvs1WSpjPkeduB5XGJHJ8n4whMkSXCI2tZQ2BH6STMhZzcd36yFJaPzRWRUGui+
 wB9A==
X-Gm-Message-State: AOJu0YzJCb8dkpZMJB/JoWKBukDPfscecXdn5bQQHKiyh9VXvnLqKamL
 dUl2HxiI/iYe3lwuXXTwzLm1b/+eyFgBwJGvGG3k/2LPpROkYxmdEi37TchVR/niENGcGEDnY4H
 4ZE0+ZUn0Kg==
X-Gm-Gg: ASbGnctZNAz3o9eASP4NuSXesoOnvuQMq6uvSb+tiWs8Z1ttzbqUQffdOIEvzYMY6i+
 N5a6h5pXOCZ0w6GoIZmd6oZcsJh08wa4pkrYPQ+ZzomVg8BI8ywfucgSBwLzS2AFqi7V+IP1x2y
 VKjEkFdimgrdXa1LRUnlImxvcyncm1P31Ceywyg6La01LoKAW+4IiVtE3mlqhOtxk1ZQcyzGsU/
 Blnvn7ofXqiijh6MQTfoEhXAf3FGkImI6dQrQB51sNReEQhafkk280lfDfhUUwfQb1s1UtFPvvj
 aoQ+wMaeNhwgcG83jyZ16HdDCmlG9cLd400oEYN7rWNDGlyVSExUL768879j/sdNC7elDvqFjtm
 G4AAKmfGUGN6rzegqkO8Ec2/vEELV8Unl1tVuU918xmiMPVdMzknrp0L+UeSka5VElFFYkYrINY
 B55ooTM0sAIkqnWIf3qKsWj/OSxOK7gDEU0DRMVFTliLrrmbvOjKrsD5fJAf1nW/0=
X-Google-Smtp-Source: AGHT+IEGER9yZj6FjNW7rc07VR+HwTY3O/9dLKh2Fe4ZCE1eXk8nyxvREECxxgV+u6IvSOTWOeFgPw==
X-Received: by 2002:a05:6808:3092:b0:450:cd83:80d6 with SMTP id
 5614622812f47-450ee141d35mr250286b6e.16.1763489056421; 
 Tue, 18 Nov 2025 10:04:16 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a553decsm5372939b6e.6.2025.11.18.10.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mx6sxsabresd: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:15 -0600
Message-ID: <20251118180415.591240-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/mx6sxsabresd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx6sxsabresd.h b/include/configs/mx6sxsabresd.h
index 844becbfd2ce..bb04ca3a98ed 100644
--- a/include/configs/mx6sxsabresd.h
+++ b/include/configs/mx6sxsabresd.h
@@ -39,7 +39,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdt_file=imx6sx-sdb.dtb\0" \
 	"fdt_addr=0x88000000\0" \
-- 
2.43.0

