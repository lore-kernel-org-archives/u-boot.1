Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D990FE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:08:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77B0895C8;
	Sun,  8 Dec 2024 20:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U810cpN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACFF895A4; Sun,  8 Dec 2024 20:07:58 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861AE894C6
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 20:07:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8f916b40bso19348036d6.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 11:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733684875; x=1734289675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ij3EjV9iBC8Ud9fSv5JKryfIr4RiPnI7BAhm7MBdREY=;
 b=U810cpN4+yDsG7u8SOJda2xQKaUgSCaRjDhD1jDIqXVzHu++yaXBZGCImuRAD++MMy
 yIgGkEpUAhAJ6Q8fDcy2D4G3s9F3jdxdogfv4/FFrkglGfdbEoRc4FRBD+yVEHXxzXgT
 HvSmi54tFAQb3/hb5C4cWuay32Copslxx6hhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733684875; x=1734289675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ij3EjV9iBC8Ud9fSv5JKryfIr4RiPnI7BAhm7MBdREY=;
 b=EKgXrL8ngKK9heosVl6cIRNkMlFRuvwIUHywmI12ZZn2OtJFTH8aP47Xffd6qCCoN9
 r/VySHjb6o0LKWwHeB92bXAME4Qt0rmiBWECTUPiWxkMhXBGGVRVbmJ1dyz+ofo/yDna
 oJ++YaLF+84Fq7uYKA+a19IqkLy82szwTZhxBPthx/R5QtJI8/PvSGTCvARkMtrXKDjk
 0T8svsrg5ZK75zbPG56FLwsFnJ1S55Udj5CCceJZMSMhZnU1wT/z+AZmiiVqKkHPgAcS
 ufL9slv+xDIVEx8uSb8jCgKUsXAWJ15buwPbiPVVTUn/Ab7AkiLcRIw2aVE6c0L7Cz8r
 fLbA==
X-Gm-Message-State: AOJu0YwutueyufJiAPqKUqFyQayrggm2VJgKO+LocnXCWhW07WqECTk+
 98jBN8wq17M9isL9RwCgRXRE6WlD8msQLosRS+f0gsOqViWRugOngQg0TJQn+v5SJ4BzmRnEo5S
 1Slk=
X-Gm-Gg: ASbGnct/p8WGs/1wUXMq6OiNFBkk+E6h0sIP0XqyJECqCCud+dFGhsBrMpX8rH+W6qN
 0UsKKa/Caz9SAQq/jXWMP+yusce9nQOstWSL2t154wUaTbfbujsH/Nf6LPVluLYEGgz76chrtjl
 xviW0V8GdoYsb/SwLcqFiRlGFhj+ezb8Z4HFju+AZj8Zh5Vae/8RkK2VtTPbW35Uvx6v9jxVfQ1
 o+BO2964XltzGPIJJcpGoNfxKAzJzlpRxuJFD9XF26h/a/M9/yAckBCdLOouzPVL0VxSc45bQ==
X-Google-Smtp-Source: AGHT+IF1+w714Oc0qYDGwlSD3osCn9vKOtUvCgCyDFDOVcD/eWQ1WqRRh+PAcHpmQvs2ONLIwZl40A==
X-Received: by 2002:a05:6214:ca1:b0:6d4:1ea3:981d with SMTP id
 6a1803df08f44-6d8e71bb192mr175488646d6.43.1733684875488; 
 Sun, 08 Dec 2024 11:07:55 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66ddeasm41154076d6.25.2024.12.08.11.07.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 11:07:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 4/9] GitLab: Add a default workflow stanza
Date: Sun,  8 Dec 2024 11:07:27 -0600
Message-ID: <20241208190741.4192601-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
References: <20241208190741.4192601-1-trini@konsulko.com>
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

When validating our current pipeline, a warning is produced about a lack
of a default workflow. For how we use it, we can add a simple default of
"always".

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7912eeee4401..ae9120655b0c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,6 +13,10 @@ default:
   tags:
     - ${DEFAULT_ALL_TAG}
 
+workflow:
+  rules:
+    - when: always
+
 # Grab our configured image.  The source for this is found
 # in the u-boot tree at tools/docker/Dockerfile
 image: ${MIRROR_DOCKER}/trini/u-boot-gitlab-ci-runner:jammy-20240808-03Dec2024
-- 
2.43.0

