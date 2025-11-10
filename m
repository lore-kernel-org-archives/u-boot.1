Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46B8CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E9D183A24;
	Mon, 10 Nov 2025 14:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cno/JJqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95B1483A35; Mon, 10 Nov 2025 14:56:40 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CDA839D6
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 14:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b6cf07258e3so1567761a12.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762782997; x=1763387797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+NEXHE3qSvxDANR4IJlH67epL+J+CKCqt2/GPznW2Zg=;
 b=cno/JJqI/B7K+k9LvSlcp03nM7BvOQxyEh9wwrJb1TyILurGaXPmNkgkDRDpsbGjyo
 gjB9j7338B1COxAXxHn1synoIVxv3+q0B9Wywz/IwmjuulbIYfK/QPglOX0J5AuHKR7s
 kXWUcj7Nh3Mx8ahSXe8cAbtFSQGGO9Oh5YnhS4XUHts3isfwX/5+ygRYjE7fJFFMP1Rw
 n3XfpwoPJkXV2diep6CR78C5PaZN2OlndE/TAOymjTgg8fpxflcVyG+C0oX7tsT5dmYf
 XSU+MM3nW9XzcKVcYqKoWa7S8ZtRJocyg9LIc5Ltm4f8sOMn/gIIg5mr4W5eJaz9G67+
 EN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762782997; x=1763387797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+NEXHE3qSvxDANR4IJlH67epL+J+CKCqt2/GPznW2Zg=;
 b=ojPFScdA3mQ0ZZbNmEvi+5Q/T5KeH8/B5BX6QF430bk74FJZIIyumF+vCGnLsX7HYP
 H1gjTnw3WfhCoNH5YTF922Pi6XTka62dCrgPwaazgrwiVTg3viQKrCvsQPei9eUd/w7J
 BAjgLDR50DaDclpI6BPKlXSjS07EYPjzn7kXtqKjBkd+/bD83UUPaCurEKpHOT5GELLE
 dBAqjEjcQfBX88r+FzOprnh6TJVT+A7t8XtdPHsLg0BQt1ew4177wQbEeoy5FlSbn1Oc
 6uW3vYPQTZMOopAAUOe4hpGB40VF1Juqb970dTSg0e1YpWVOot4CrdhXRagBCUzLvXNW
 MhKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUICWTi9QMF+xzKHr2QG8WYYaqKyzpy/y4ieNI2YsQqLpg3gh6Mq36DvU1YgYCeSHQiy+shPSE=@lists.denx.de
X-Gm-Message-State: AOJu0YySOQg+t876JN7N1zPZD2uuGJuHowKtTJaUEyy0lXposyjVqNud
 VAp5htfj/dt1BQeyxuUsdjvTm/YT8tZlB5VxZoLk4LqKHdmtRNQ55HeH
X-Gm-Gg: ASbGncsH9nx8g+5sQYnh+3SjNwKtTjdj4OivwSSwtk3cdXnaOsmf7aHbtc8LlkKujoq
 J9nXDA0DkQHw6cSKBmzDsm1YCv2FsfHZJrkJAMUdqPCpJPy+YaNaDt+a3iUugnH1U8p5wJTcU8E
 MZK0WX5qZmbar7gnzh8cEEmKLx06GWL2Cws+T27KcSkCTQmvDNHOEsqGnIyjn/7C1oK4tq0jPGw
 O2F/E7sONUR0uIH5yYGstLmx4TEvYCp5pSf/9AXbJnuPINMEh32RVR58aleJaCaJBHHLdhSHf12
 qA8NN9mJy6CEoPTz7RX/9a7Jenbz5/AhnceHerBqTJ2z2kGmPrrg4hCKhH3OZgF25l+o22FL+ZV
 TQT/n97CY1vFOABkqewXmwGSxO4VRMcvWsz39GyGOtqX5J8/BpNc8ylvlZ7CTrvSgs46061Kgpn
 /S0N7B8w==
X-Google-Smtp-Source: AGHT+IFAV14027LfHMJGf6/3767Qvns+y5GDgINGHofQLgm2Dsp4SEJsJWlVAvZrrwmysSSgy2cHiw==
X-Received: by 2002:a17:902:f601:b0:290:dd1f:3d60 with SMTP id
 d9443c01a7336-297e56cf8e5mr101343165ad.51.1762782996768; 
 Mon, 10 Nov 2025 05:56:36 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29650968235sm147254695ad.16.2025.11.10.05.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 05:56:36 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] docker: Correct the linux/arm64 platform string
Date: Mon, 10 Nov 2025 21:56:32 +0800
Message-Id: <20251110135632.1645162-1-bmeng.cn@gmail.com>
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

The Dockerfile is using linux/arm64 without the /v8 suffix.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 doc/build/docker.rst    | 2 +-
 tools/docker/Dockerfile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 4974a98d4af..791eb215617 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -36,7 +36,7 @@ To build the image yourself:
 
 .. code-block:: bash
 
-    sudo docker buildx build --platform linux/arm64/v8,linux/amd64 -t your-namespace:your-tag .
+    sudo docker buildx build --platform linux/arm64,linux/amd64 -t your-namespace:your-tag .
 
 Or to use an existing container
 
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 201a1cdbac1..45181ce359a 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -6,7 +6,7 @@ FROM ubuntu:jammy-20251001
 LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
 LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
-# Used by docker to set the target platform: valid values are linux/arm64/v8
+# Used by docker to set the target platform: valid values are linux/arm64
 # and linux/amd64
 ARG TARGETPLATFORM
 
-- 
2.34.1

