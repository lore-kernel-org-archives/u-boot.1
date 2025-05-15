Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA52C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3DAD82AD2;
	Fri, 16 May 2025 01:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S57i682b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8CCA82B12; Fri, 16 May 2025 01:42:13 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32B680107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c14138668so688488a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352530; x=1747957330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqSnf4jMhMwUqLjt+j8xLWtNwDFkuS+cf1yUlcFwfjs=;
 b=S57i682b9jP0qzkYdneuTw1eO+Yjfa6a3D5BzzZOZrocjtG5b80pEx68XgmWbKHlQH
 XLnL2mB98EXcsc6NHnnWLIRxMSUSx6U155S0/e3jQeOhOF/64ebRwzC9BPFYZly+fIGm
 oDo66S9FjocWQ4Tqbg/UvuT7szLFdmXRo3G9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352530; x=1747957330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqSnf4jMhMwUqLjt+j8xLWtNwDFkuS+cf1yUlcFwfjs=;
 b=BqGfCEh1G6BENwXtwmBwf027bxHEzznhQb7svWBT6PitGYvC/YU0Ms+AqP+mvad1KN
 I+qxM3vdHD6VYt7zn+Nx3rWCrBCfplcjk51AeubI+GXsYgOq84nbea4E5QD5hoiWBo7J
 +PxXKp3x70YX70T6cHrVDMgBb7fA+9bnG4hMljKXXwLHcwee434W5CLS7MYP3y+e2hJa
 CuolWtttXx+pFNQJW6Qq7v8ZrowAhuofDAp9nKdDY0iNVA5Km2g8Rdk+novtuMxIuU2M
 n3LOyTwEospnffMzBd0R/kE41UGUPvDP3VrZythtMvsFtqP6eGKYTa1nipMAySKqwcNA
 tJVA==
X-Gm-Message-State: AOJu0YyUWW40CWH9OByQYtwtRMsC5IGdpxsNU9W8eJAsVh4cIp1O92+5
 ZdBOGxJixF1XE9pIvqUN3JjdHI+jlB/MniB1RyTkbARtSNCPnOh+BWGKZ8OalR4BFGaa8qopTSi
 gYDmhcVY=
X-Gm-Gg: ASbGnctmTCLHbfpxHYjbeF7sPk0/gSUf08Mvi5/tiMrYqAmZj++5kUI2fJDfz+SZiuD
 1zBmzTvWuQJV30Z4fVmh6pq7+zsNWMzMHG3EiNkM3p3SBgBpSyMzdqEl95ul9Rx5NwzJwbwe4kN
 WQqzJYeSIy2qyt9GZIwFzCaP95qsPQb2KbJ2lUtkVOgSEurgbRSWkSVDHEpCHObw5kApRACT51V
 /F4znf9cMbz/2MWpLN71pzbPpn/EwKqv9zbEccaXk9ZdFrTOWxvsPzDEalczUwPCcxL+sw/4PH4
 R6b6aAqMeys9X+VZDzjFrTwOK1Z1ew5zQ991XDKEYi+TItx7fwkxf39g3flGjN+6EqJEBBKBGE9
 gugQmHBJp5HECSOE=
X-Google-Smtp-Source: AGHT+IFDpdFhSYjG5l9Mz0q1moMPBa5T+R0yIko25ZEUF2qphQpFXPBd7opNvrD5PQQkSTDZ/5itZw==
X-Received: by 2002:a05:6830:3c0e:b0:727:345d:3b72 with SMTP id
 46e09a7af769-734f98adeeemr422615a34.16.1747352530434; 
 Thu, 15 May 2025 16:42:10 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Oliver Graute <oliver.graute@kococonnector.com>
Subject: [PATCH v3 10/22] advantech: Include env.h in imx8qm_dmsse20_a1
Date: Thu, 15 May 2025 17:31:39 -0600
Message-ID: <20250515234154.1859366-11-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

This file uses the environment but does not include the header file.
Update it.

Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
index 50b35db5f6cf..accd300df04d 100644
--- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
+++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
@@ -4,6 +4,7 @@
  * Copyright 2019-2023 Kococonnector GmbH
  */
 
+#include <env.h>
 #include <errno.h>
 #include <linux/libfdt.h>
 #include <asm/io.h>
-- 
2.43.0

