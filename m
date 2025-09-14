Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C89CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83F38353A;
	Sun, 14 Sep 2025 15:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPowcWDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A032782A9E; Sun, 14 Sep 2025 13:00:59 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956D480B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 13:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-32bd4f1b671so2604877fac.0
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 04:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757847656; x=1758452456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnB6Vg+O2u/tqKM+3LWQxNhUSwyAcoWLCeb2eDDGJBs=;
 b=bPowcWDOse7PA8FBobVPz5fG2cyd0x85NxNwFlsaKkSJOwLZHWgFmwSZuD/Kv3HBh2
 nHSjI3F1jSCWZf22jdY4tb5eXf8Toojlomkd/VVO2jlxOOyw5L3bOiedOGShphpfO8Jq
 YJ1fM5Bm0X57aAuf7jxt9J1KSyefeQ++EvzJ+TbbB8P+aKBJSe/tC8yjrlh2IC9MBRvZ
 e+ZYN1ZNOklXKrCbQH9MIwTawadpd74caq11Y1IgeWxzwfCi4ibt26Zi1J2mhkA5ILmB
 8PlDXJ3W8hFY/G+J8zGyjkoaECM6VtQkanlloNUI+J4RmFDUUBmjPGtGmqt753U7+fRb
 GnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757847656; x=1758452456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnB6Vg+O2u/tqKM+3LWQxNhUSwyAcoWLCeb2eDDGJBs=;
 b=D2NE2nyzbWp6xFXa++uFKkpxpCU9WEWve4uX05wo4vktCTAWqHJmosL3lgJQVuIN8V
 K6WLVLQ2pfSFpG5fcRCCVrpsUp2fIzCiMDi9LmjUP81uO2Uf0uiIO05Ua9JbRlRw7616
 0dpZ6QVxFaHDKWW9jRg19o2Rc5p/5r5PfiaaGPnlZRGRoINlOSJ9pI2Vol1lnPKrCGsW
 W7p2D6NcOE/5pG+pSmFBD3FzN4kkZb4aCTrPASX2VqnW28OQ8nuh7C17/h9PXIq8xBw9
 DxceU2L37D9YYvHAIjGmlRyq3bBKEA1PpQALM90+e5BEb8u3vDSkVoCKYNRoz8RTm4G7
 bXNw==
X-Gm-Message-State: AOJu0YxuuV/3UGSbI7q9OlZGySaM1zA+cXCB46jqFMJ/0pC95sR/vz1X
 roL0/Xbbfrpl8j6m3JKd1FJ73vx9j2GRj9EZ+6e2xkBoO7bQSsdedbZAEcg93uLr
X-Gm-Gg: ASbGncvrn3v8lTuFjNWNxgTN+kWmqOlrXomW5sa0Mn6I7yWaR1JGMgmrU6cNDEoZAIC
 vpfSFpVjECXWejNqCaRd76HNhJZ0PCfb/1mffzQXXWr5fopbvmUl6IIfPzB/RZPuUqUo/UyLpt/
 KnrsPRXraqFnNm6IbIW1oYDfWGX2totMALAQTmkVs7+RfFwFZJlWchWoVY3Zi7WB71Q73QmzvL7
 TWmpfFZvqq349FIxlTzGG6oaE+IiuGQhgJKUaCHmRxRNAL5pwxr4r2IMGtg8L4Zoj88n9qBytSP
 N8eshc4cTFUsDm3HeIGYAdl6zmCyukwjAiS1nmEZiEUcsCfo4tB/Vq0xG+QCihXpEmWGXUD5tla
 4xztYwCV+TWFlACdAz13QFsvu1o/5UXYoSy3ce19ibsF2QaTAU9ghpboX5we1MPXqiJhQnpg=
X-Google-Smtp-Source: AGHT+IFOpg/reXt6pSZ+2Jw8DIRNwoWKmPgiXI2MN+Fnm4tUNkViE6pmZ/YWyEkgBnDQZg15c7Ih0A==
X-Received: by 2002:a05:6870:8a0d:b0:2d5:2dfd:e11c with SMTP id
 586e51a60fabf-32e4adb7732mr4614053fac.7.1757847656123; 
 Sun, 14 Sep 2025 04:00:56 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d32d56557sm2612720fac.1.2025.09.14.04.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 04:00:55 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 al.kochet@gmail.com, paul.henrys_ext@softathome.com, bb@ti.com,
 y.moog@phytec.de, w.egorov@phytec.de, francesco.dolcini@toradex.com,
 ggiordano@phytec.com, n-francis@ti.com, afd@ti.com, d.schultz@phytec.de,
 d-gole@ti.com, ravi@prevas.dk, carlos.lopezr4096@gmail.com,
 quentin.schulz@cherry.de, alice.guo@nxp.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/7] binman: Fix typo for the test case name
Date: Sun, 14 Sep 2025 10:59:26 +0000
Message-ID: <20250914110021.4103-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914110021.4103-1-aristo.chen@canonical.com>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

Fix typo from `Singature` to `Signature`

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a90db3c9351..6ed8b8637cd 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7986,7 +7986,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'Node \'/binman/fit\': multiple key paths found',
             str(e.exception))
 
-    def testFitSignNoSingatureNodes(self):
+    def testFitSignNoSignatureNodes(self):
         """Test that fit,sign doens't raise error if no signature nodes found"""
         if not elf.ELF_TOOLS:
             self.skipTest('Python elftools not available')
-- 
2.43.0

