Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0618CC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2D682C4D;
	Fri,  2 May 2025 16:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="klnF++co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC8A82C15; Fri,  2 May 2025 16:49:07 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C270581F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-86135d11760so182983539f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197344; x=1746802144; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YxZ9XUQelNIOSJkECh2l9Qqbb29IYxIAYnS4ZS0P9I=;
 b=klnF++co47rksuyDYZBF6xgJnQ415IyCx5E+1bX6DR39arFwY6aB4zpzjrOPYovE80
 A7sfRtHzNxAnNeTn6cywbzbsNb0XEh3MftmfAE1EHOBNJA5Qcf6wofRTIfZ8j2qo0SEZ
 e2CWppgiwvCrUN3y+MOokn5kiZhHPbNfmwacs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197344; x=1746802144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7YxZ9XUQelNIOSJkECh2l9Qqbb29IYxIAYnS4ZS0P9I=;
 b=pDmgxj/zcyAYb6FvyEwiNHipakNQoMvjNzOYV2OTNMgoCZEY0lmxiI+R34qNLRd8hW
 LhkdmzWS9GRq7rUul9yOgH97wDarfqgBRJCzJ+qCuLRlsBW8HeGMClwh+faygzmucGYA
 4P9PHWQTdCzPwF3GW7XtFqbiivSd5cXyaUjJiB4PSa8crZaDGFGKDiuZCCtSc9FmZXIW
 +qwbPBknnG4VFdTL52PtmpkWLwiksjJj32Ku1CKc2AMpJxZF5Xa/h4+ZdtBGoWTdEe4r
 8maavD0mO2Vdz6VNqu+cwTAGkD0w6Wp0ioRDyBdN8ZzUHwa7GlNUCz2jWVnIJZ5ptwLV
 NBQA==
X-Gm-Message-State: AOJu0YzZR5UKpl/JABBe+s8QITCCZTcNmVr9qeGAWCzNTGx5Pkf8boBk
 q/ipGFTQPBpBSpqBE8DJz/NcGduVOfpZNnANG6ctjiriB4e97Oiu1zmMVmnz042jI3j6jwPPFrI
 =
X-Gm-Gg: ASbGncvyMoP26pr1zibx1itHGHhG2JIwJXK18g/YOoGDR/H+C6zr+P4cOQz55nKtqt1
 KaQ2fB7e4qQkCDZOPUapE+YGnIvkxK/7bKS2gOiZzbYhDt4j333uDEwCHvDk4+3UT3GVppctaM1
 +5qRj0Ma4uJm7MD0/jLG05gY3FDcHhDmtnvDeUL5TLAp2GZItk5COusmAAKqSjVh3LWocMimTLc
 cPt3udp4b2QWtcG+eSxKmo4gWjMRX5rkNGwJsoi/qRWz3CPp10z7l3dNf5wbFwgCAINInwr0XRs
 5LaL2lZxEo+2CW8/hZYc9QJ88xCk+nYnxS/eX8nvC2EdAelBH3roWZh2S+Nf4SsF5DhOcxF8jF4
 m2g==
X-Google-Smtp-Source: AGHT+IE6BOdiS25uKBZaiLFIeiYA6ceJAfr8Y9VXfKPlrFB+4mmEf227mk/+QC8qQ4t6yEHjsVA4wA==
X-Received: by 2002:a05:6602:6cc1:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-8669f9bb649mr523615839f.4.1746197343943; 
 Fri, 02 May 2025 07:49:03 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 51/60] expo: Add forward declarations to scene_internal.h
Date: Fri,  2 May 2025 08:46:49 -0600
Message-ID: <20250502144718.313633-52-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

Provide some forward declarations for types used in this file, to keep
the LSP happy and avoid errors if the caller happens not to include the
required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene_internal.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 760cc629b86..95927472875 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -9,8 +9,21 @@
 #ifndef __SCENE_INTERNAL_H
 #define __SCENE_INTERNAL_H
 
+#include <linux/types.h>
+
+struct expo;
+struct expo_action;
+struct expo_arrange_info;
+struct expo_theme;
+struct scene_obj;
+struct scene_obj_menu;
+struct scene_obj_textline;
+struct scene_obj_txtedit;
+struct scene_txt_generic;
 struct vidconsole_bbox;
 
+enum scene_obj_t;
+
 typedef int (*expo_scene_obj_iterator)(struct scene_obj *obj, void *priv);
 
 /**
-- 
2.43.0

