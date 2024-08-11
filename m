Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E1C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F59188AE7;
	Sun, 11 Aug 2024 16:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T0yIQN9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AF688A95; Sun, 11 Aug 2024 16:52:50 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7956889E2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39b3cae5675so10098415ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387967; x=1723992767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6bSvxh5YsAo9K1KEny+ZEyBZdSO0dvTxg/3C1drF9A=;
 b=T0yIQN9OKwf0MDi9f/wtWWIds+i4eSZDJPLKzi7/McwD5f6+mMZGzfjjQUEHiTcToF
 LNdLXN5AG21pdBXjHykr46WrodnMLKWZBgiE8IE0Vn4pxCvlbfsxmmu+MDTiFbvkydFy
 YA05K4rp3nQCtbwnSjNv1L8y14vmRkPX1r6wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387967; x=1723992767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6bSvxh5YsAo9K1KEny+ZEyBZdSO0dvTxg/3C1drF9A=;
 b=KyY1qN2nY3adyq+8PNHeXwemzGQFAWNO4jHnfjnu/PEV+YmNyalox5dCITqGDU566V
 PVUAzA8x4sGovEMKEbG0B+U1oCGOhhuFopFfa4Jm6Lc8GrfslGROi50jRDjtkd5Nwg7P
 2cNbqtnmhMgymE9+mN7d3sQeX3Z1IiaYvxyAmxHInUAmvcRhWhVu+4deR67Si+5IiXk7
 cTp+2wrSPVHM/Hv+uoD5DxMt0u5/G4KvbUTKsgRmi9/Rg9J2vDQmW417plKKPlKNuZAl
 pn5FOcIrTOry4Nc5Zlv4e8XzndIw89eDyNQVKjj7Tb+pHog5/fibtVPYkCFKZC2WjR7I
 bLkw==
X-Gm-Message-State: AOJu0Yyg5p7wK7XzLXodIpltLOSckx2eeWQ5sVFdKMl8cYyQHwbmzjDG
 B03A1yjFPPfsLNu8PBjB6017h320Ddmv4G+0WbGySOXpIogHh+eEUPGtYwedJ5yxk1CvWMrd7fw
 =
X-Google-Smtp-Source: AGHT+IHMcyE2r4d2rchSHcIrIyCrYGKT8ONEZlmO3c8llIfPclfY+7T/MaOIJ4KhIunrtIIIa2YnBQ==
X-Received: by 2002:a05:6e02:216d:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39bd8c459a3mr75935825ab.11.1723387967619; 
 Sun, 11 Aug 2024 07:52:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 21/40] test: mbr: Unmap the buffers after use
Date: Sun, 11 Aug 2024 08:51:50 -0600
Message-Id: <20240811145209.4191404-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

This tests maps some local variables into sandbox's address space. Make
sure to unmap them afterwards.

Note that the normal approach with sandbox is to use a fixed memory
address in the RAM, to avoid needing to create a map for transient local
variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 04291ee0aba ("cmd: mbr: Allow 4 MBR partitions without need...")
---

Changes in v3:
- Add a Fixes tag

 test/cmd/mbr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 1a35ba3351c..8a4d61b2928 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -461,6 +461,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 			"5P EBR+0x%04X: expected %#02X, actual: %#02X\n",
 			ebr_cmp_start + i, ebr_parts_ref_p5[i], rbuf[ebr_cmp_start + i]);
 	}
+	unmap_sysmem(mbr_wbuf);
+	unmap_sysmem(ebr_wbuf);
+	unmap_sysmem(rbuf);
 
 	return 0;
 }
-- 
2.34.1

