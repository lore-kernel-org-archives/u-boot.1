Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CA0C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D28874CC;
	Thu, 18 Jan 2024 18:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jkQYXpuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8758C8753C; Thu, 18 Jan 2024 18:10:13 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3FE8718F
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6818aa07d81so4887416d6.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705597808; x=1706202608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=t6DNdtIUNtNtKkMr2G4bxRVqCF0LGZOBXC17xleXWUg=;
 b=jkQYXpuScJCMLI0cPY+MSbC/OeEA8VWAPe6ZUdTegHHwZisz1g2VRKG4TafuLC2fet
 ggumYt+Jfu9IPuEd20oiuN88KX1zvtjBaPBUsVFn9dxYeUxGwlCC5DK0gsIRn2bR8lTX
 5zoj86p27rC8TjoFK4aj20bjudUvpN392/t/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705597808; x=1706202608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t6DNdtIUNtNtKkMr2G4bxRVqCF0LGZOBXC17xleXWUg=;
 b=n4ghhS0e/NmXHMHGH8eZbed2ZFMUick/y9xAH+lMHXrK3nsHxE+M6DrnImBm0LWwXZ
 9sF0WgSgFEF3RPiYsJDhE4f9Pkwo4iK42jvbYPMAQtzcaMvB0Ppuw9BDl9FSPcnZIDzN
 ujwuczLcHqgPagwx+uf67Am7wCvNgQonkDDEupiKmxgd4/l6HxyPo8jnqGiF78jqkZNJ
 2IjOzWuf/0n3FIK4k+ZrnEZ0uolmtPeCYaNZ+xRMhba7pAHHLbn/RK7fGzrJPJTlQn1X
 lp7BE3FIhmGZvr+6Mu3zV2fPuTOd19i19ySXtJ1V0bFWnTWpv5iVi/f8WNkb6YNC/V6c
 5SMg==
X-Gm-Message-State: AOJu0Yw+CWwQx9UO0mpgVqofbUMz38wF0zjPjrKXuoBisH7XEH+H151I
 CcXkQ+2AeIVxi/EwTRGkwwAO89dgpHH+WIISUfHtL07R5IeAu27Cm1OZqJhJviB/fhi1d67rgT/
 b
X-Google-Smtp-Source: AGHT+IGAMIs62ABn1GHGCrusPBrbB5DLvd3cuCVnOC68bTt6L2PsfJwHbfJHgs3aDgu416jjPYzrXw==
X-Received: by 2002:a05:6214:2689:b0:680:d289:6f8f with SMTP id
 gm9-20020a056214268900b00680d2896f8fmr1187394qvb.70.1705597808516; 
 Thu, 18 Jan 2024 09:10:08 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 lu19-20020a0562145a1300b006819bb31533sm30747qvb.99.2024.01.18.09.10.07
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 09:10:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] docker: Add tools/buildman/requirements.txt to the cache
Date: Thu, 18 Jan 2024 12:10:07 -0500
Message-Id: <20240118171007.2595536-1-trini@konsulko.com>
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

As we have had this file for a while now, we should include installing
and populating our pip cache from here as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 0e2dd0a6a946..6122776bc64d 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -240,12 +240,14 @@ USER uboot:uboot
 # COPY / ADD directives don't work as we need them to.
 RUN wget -O /tmp/pytest-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/test/py/requirements.txt
 RUN wget -O /tmp/sphinx-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/doc/sphinx/requirements.txt
+RUN wget -O /tmp/buildman-requirements.txt https://source.denx.de/u-boot/u-boot/-/raw/master/tools/buildman/requirements.txt
 RUN virtualenv -p /usr/bin/python3 /tmp/venv && \
 	. /tmp/venv/bin/activate && \
 	pip install -r /tmp/pytest-requirements.txt \
-		-r /tmp/sphinx-requirements.txt && \
+		-r /tmp/sphinx-requirements.txt \
+		-r /tmp/buildman-requirements.txt && \
 	deactivate && \
-	rm -rf /tmp/venv /tmp/pytest-requirements.txt /tmp/sphinx-requirements.txt
+	rm -rf /tmp/venv /tmp/*-requirements.txt
 
 # Create the buildman config file
 RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
-- 
2.34.1

