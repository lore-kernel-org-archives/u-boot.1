Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A00C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 115838006D;
	Fri, 16 May 2025 17:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cTt2d+kV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CB780107; Fri, 16 May 2025 17:44:36 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9CD80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-550d09d4daaso2222679e87.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747410273; x=1748015073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mypew54AFmq0g/yzNtOBzICYNbkTyPOR3Gx1/hGUUY4=;
 b=cTt2d+kVlVHaUXy97vRJy+TcxRuF8NSVCXU/Vb6GEICsbmb82UGVEjuFu4C3F4HCDF
 /itv8kCs+uRJ7TRir9+FPEGA3L6pBdfDaepqr/LiZqCyWVfsFtcLMzJwGrN3b1idVKc/
 Kk+uGhryaGMjkJXoeHY9ndsbd8S6jArqQ/DgHQOqp6xp1EA/8pOh9rtZk8hj4jbr4FJ4
 zHHEMPj7SdiZNnTq/XwUfpc516D/49XcIhK0sr7+2mj17WTm0AZKpiIVL2EF4QRruGiG
 VYFTplggV7ri/Ztq8Mru69/3ikWkc1DYh1ZE91xmA/ptkrgYIhY86jiyc6uQ1hpSibk8
 Uu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747410273; x=1748015073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mypew54AFmq0g/yzNtOBzICYNbkTyPOR3Gx1/hGUUY4=;
 b=pa5M2k9PKltr39lzxuZJaCV0AWmUWicYOWuz7n1RMWVXdIgf3gQEfKAw2Bazz7/hCy
 cVd8/MnqxshRB04DlEE3+UUcTMyIWTbFtVjdyVr/t1E1/aG70mHd8B+i4DbYmBo/Z8G0
 imyHvq5/CvCKfbVcyboPfuGIK5TyujafRKD9vXYXplKfFz1/F3f1nOUI3LUduOYSrDXF
 QHvHk87n8oQAKeqyZmafyGDf8el7aBggFaHT3WDBg5gzhS1CT9iKC91rwJYGo0J1b5a4
 5Dsol/gy1vZxLm2gM1cY/Es01Ug2o7IkjGDMAsy9gArQAZilGNBubwbAFKoHTIEXYU+r
 CeZg==
X-Gm-Message-State: AOJu0YyiKqPGXBnzrNpdKkG4vpaF96LQ6T7dgP7T5XZGJXpwQYVxcpuv
 Spxe0HTJMfuRz+FXqSk3Dnq11FVyuRj/KRIFDhFifkI+Q9Ajhq6KmyvNU1SWHcuz
X-Gm-Gg: ASbGnctt26pCn80J1/0wgSx1QF8rYAOHsXn1zYaGNp5BTkhInqV378L7bhPavJmsN0N
 +HnoiNi86bDany/D5/0Ow3HED5dSfeLjXta2/9M2G7dS4TH4rw5GvV6N27CnpstbV8zbPR9lmeD
 lKx4+Wfqh+jxwYbYaO4qxYHWRSvIl9sdZKTxfEePtac5oya4Pu+QoIQjVG+hHQW/1zfVMlpxgC2
 8qE4BiNPc3uPnKXWvsFSsD6j69sjI5z9wzPZ5rTIPNucVAYPnznJHJvIRiIs1nKGXDDwo5s9P5e
 kQWQyIrnRSFuHVhJtTBdCVBnKPk0SFlZU6YZdmWLYcWUFlyfWw1Mrq4T39vKhru9oV2+EJniLVp
 QjF7uyI4WKLLaGbKpGQ==
X-Google-Smtp-Source: AGHT+IFUlq+VOghB8EBQcbGe2u2dUBVDPcl7cAaEnu6IbaVA9Dtf6g40bxWYVonBuakeB6B8Q+cBbg==
X-Received: by 2002:a05:6512:660e:b0:54e:a273:d339 with SMTP id
 2adb3069b0e04-550e71951damr1224026e87.8.1747410272646; 
 Fri, 16 May 2025 08:44:32 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-550e703c31bsm489784e87.212.2025.05.16.08.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 08:44:32 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] tools: fix memory leak in ibbp_dir_add() on
 buffer_from_file() failure
Date: Fri, 16 May 2025 18:44:30 +0300
Message-Id: <20250516154430.80735-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

- Added buffer_delete(&manifest) before returning COMMAND_ERR.
- Prevents memory leak when file loading fails.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 tools/ifwitool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/ifwitool.c b/tools/ifwitool.c
index 762161d769e..c17087963cd 100644
--- a/tools/ifwitool.c
+++ b/tools/ifwitool.c
@@ -1741,8 +1741,10 @@ static enum ifwi_ret ibbp_dir_add(int type)
 	init_signed_pkg_info_ext(ext, 0, subparts[type].name);
 
 	/* Entry # 2 - IBBL */
-	if (buffer_from_file(&ibbl, param.file_name))
+	if (buffer_from_file(&ibbl, param.file_name)) {
+		buffer_delete(&manifest);
 		return COMMAND_ERR;
+	}
 
 	/* Entry # 3 - IBB */
 	alloc_buffer(&ibb, DUMMY_IBB_SIZE, "IBB");
-- 
2.30.2

