Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6043CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC2C80780;
	Wed,  5 Feb 2025 17:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BmBnkkDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81EDB80562; Wed,  5 Feb 2025 17:00:35 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BB380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-543cc81ddebso7934532e87.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 08:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738771232; x=1739376032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wTvJw703K0zRW6c4OSGF6oiTADCdISGSiCLW6FmwmO4=;
 b=BmBnkkDYFaHmnipD/OSY6/h+VmiU+v1R8R0QGsdxrVy0ff2AkHn/7Z9eouruvO7eWR
 mb8By7P3zVK/SYogQTnx6+lIPvyEixfZLQIRdk3Yb0ClkDgjd0i2ihbfOBdOKf1+utUJ
 6zl2yIuyQMXLytGepFhnBPjCE348Ej0p9KR7owpfK34uWZ5qpZXW+H8NBrYWMtpHFVPi
 se86UhrQXblqlTeYmBm+3gAM5ac6KC8eouUtmBAAjk4prCDSlqRMk7uzRGmSfPKAG9eE
 6O9oObTeEqnA3iCpeiMUQhG3w2IbOOXWsVkNBtWXu4Sh8VFJqWsk/c6rKE8PhDrc9cKZ
 t72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738771232; x=1739376032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTvJw703K0zRW6c4OSGF6oiTADCdISGSiCLW6FmwmO4=;
 b=Ppv7JRy6H2Klbg5+7SJZkEOQrt8FvWADEOGNqF6Dkr3DoavASMc/A+zrAcRwF3BHFC
 QhAqX21G0aexjWMuWl0rrCIfsXU3VByYLVnrXDIpwphvhOtJX0pK8sLlWLIH3P8hk7GL
 ArqAwS1wnoblJWNYTg7e/GAZe0BZppneXkmajJwDYBekw13nmQeMP88dp2ufLZUNTCi6
 8V4io10x2clVCjGQ8BtDAo3n89zKJOtufeA/HrQ6cE+S+Z+wkcVxRF9wicDboU4WleeW
 Fy56duNgMhOX35vChMgOnR6soJOmHYRGQRnNDtpwsuqu+5cEGtyQsojKCLPdv0krRK7C
 zItw==
X-Gm-Message-State: AOJu0Yx2Uw8MteONGoEk8dlS2Bc0WXx9jmBgiWLbo7wHQ8yYtBBQKEey
 e/tmGh8N3iMDY8ygCDbKzp8wyitQniXDZWjirsxHR7opT9lxStmFd1Erk4sl
X-Gm-Gg: ASbGnctdZqUbcxsaytvBUQPNRq8F7w3yLzJJyGzIbHTS0paIRZs9T6AvIqcUIcLBcE6
 cias0e4MLmLWQeHE74f0gZ75qidQbW8dZMGJQlC5r/GxZctJ2CB4WlKuAQDkTd98nZ1ZhDkJQC+
 /QDnwShG+2Enq2xm+rbIMmDwNIovJtusgBWhY8vZ04hw8R5hkLV2BmwnkKtOnp5JJ5RNL727eqZ
 nDMTp1lAns/4nLAhmQc2nSaxZuXyeRFPCLWEYKNeqy/lkma0irjY0JuPKNxPy75DGLXu0hHAM8I
 dXKeasoz062ngIHUSyECKms=
X-Google-Smtp-Source: AGHT+IG6qwOYBDVepeJmXaKtCBEAPPN62+4lIKmngivbIwIsDQWzs0+6UpL4pb+VRQkqfmdpVCclLQ==
X-Received: by 2002:a05:6512:3ba0:b0:542:2e04:eb6f with SMTP id
 2adb3069b0e04-54405a34d4amr1086059e87.14.1738771231920; 
 Wed, 05 Feb 2025 08:00:31 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543ebeb7e1csm1912697e87.197.2025.02.05.08.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 08:00:29 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] cmd: Fix potential memory leaks
Date: Wed,  5 Feb 2025 19:00:25 +0300
Message-Id: <20250205160026.2432851-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 17:17:50 +0100
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

Dynamic memories, referenced by 'ptr' and 'res' is allocated 
by calling function 'hexport_r' and lost when the function success returns.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 cmd/nvedit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 1f25980129..628f0a2935 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -698,6 +698,7 @@ NXTARG:		;
 		}
 		sprintf(buf, "%zX", (size_t)len);
 		env_set("filesize", buf);
+		free(ptr);
 
 		return 0;
 	}
@@ -726,6 +727,7 @@ NXTARG:		;
 #endif
 	}
 	env_set_hex("filesize", len + offsetof(env_t, data));
+	free(res);
 
 	return 0;
 
-- 
2.34.1

