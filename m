Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F47C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF16F86522;
	Tue, 29 Aug 2023 16:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LCPrnv/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 153B886523; Tue, 29 Aug 2023 16:37:16 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDBA864F0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so584160866b.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693319833; x=1693924633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kYnEf/h3U4VB8lH0V/dIIyj4kQ/QMVO5lWKDuOkqyv8=;
 b=LCPrnv/laqxrs2nP4ccE1lTDfBY0Ll/OeZscYbSd2UZf3pRwpusxOgfS8iyzj0PCcZ
 wqKQhgTiNNjp3PxHJbkzOby/jyjsVHUuYtS3Isca94NZy2eWnTz4TM9VoVUqXKCOPTj4
 eXeeYaJF9LChQjxXPU54qV/hWYNO9RhxwbSb6Z0APcCZZNn87/cBGaA1biLGrYMejB3b
 IFqwVo/Gi8EO+itQ3/c+/KwrVbi1zystga1mZyT4iVeM/zQBCqttPjvSbYz4OQiD1iPC
 evu4moHB63orXjScpZXit79nKGN7Pqf8vqyrJ49cOBQ0Se1q9RnBZs2nTwtq+MioY5kk
 q9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319833; x=1693924633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYnEf/h3U4VB8lH0V/dIIyj4kQ/QMVO5lWKDuOkqyv8=;
 b=ApKBGBViam0UmR71HaxjR7+vtWZvw3cYBTkpF9iiVSnx7LKuTmvlsmxweuuUnn7mSj
 vb4BfPMXMNK5ePPesMXPwvk9WvnuC3rUk5pdYM1ncqbF6aZpcq4I2yIu+RPJxQ36nv3+
 7Pb7uv+Kq0pzcJ2O84mC0Yk/ibEbu7N/6NqAyKiK/19IUk60c43vwkU88MhYUSygozRv
 t/lT2ws6oc5nMNhIGKfbxMFSVnPqtfinin+GrSb2EItQ6VKIQnxWUfgn1q09UE98Rc7E
 CVFMO7BSdQZqLMSpPfkAIUTwVq883GSC1lnzmmAYNyF7sNBPssB9wsn49Fd1uzMZRoM1
 yM9Q==
X-Gm-Message-State: AOJu0YwzkBgP4CdPgZTSOwEKuYc04nJuYds82/eIq++bk894ROOAjF0L
 aIq7RkDYXKGFALMSvkMGyNqIvKNEgIOFuA==
X-Google-Smtp-Source: AGHT+IGDki8ZHhvi2JRHb0eq/F/8221CevL/tCc4j8RsLZxlBOnHhhl3z/NhP2lFvRJLRsUb8UibVg==
X-Received: by 2002:a17:907:75f6:b0:9a1:bf00:ae52 with SMTP id
 jz22-20020a17090775f600b009a1bf00ae52mr14360010ejc.62.1693319832496; 
 Tue, 29 Aug 2023 07:37:12 -0700 (PDT)
Received: from andrejs-nb.int.toradex.com (77-59-154-235.dclient.hispeed.ch.
 [77.59.154.235]) by smtp.gmail.com with ESMTPSA id
 lx16-20020a170906af1000b0098de7d28c34sm6055877ejb.193.2023.08.29.07.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:37:12 -0700 (PDT)
From: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
X-Google-Original-From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Subject: [PATCH v1] CI: Add jsonschema python module
Date: Tue, 29 Aug 2023 16:37:10 +0200
Message-Id: <20230829143710.204875-1-andrejs.cainikovs@toradex.com>
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

Some TI boards utilizes `ti-board-config` via binman device
tree node, which when built via binman, triggers schema validation
for board specific yaml configuration files.

This change adds jsonschema python module to CI Docker image, which
allows these targets to be built by CI without errors.

Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
---
 tools/docker/Dockerfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3d2b64a355f..2f3121ffcf6 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -98,6 +98,7 @@ RUN apt-get update && apt-get install -y \
 	python2.7 \
 	python3 \
 	python3-dev \
+	python3-jsonschema \
 	python3-pip \
 	python3-pyelftools \
 	python3-sphinx \
-- 
2.34.1

