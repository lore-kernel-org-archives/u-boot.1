Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D437C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFD580C96;
	Wed, 12 Feb 2025 23:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kz/Nj/OG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C307080C96; Wed, 12 Feb 2025 23:24:20 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA90801DE
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-471a25753a4so1785191cf.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399057; x=1740003857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f2tlDHt8KY2076Ob/xNWsyie1o3Py/0A+zipw2TD5VQ=;
 b=Kz/Nj/OGoXdlPeTgGs1unDRdgANdol1TbIfFGeqDccbQ+gDfUUyizupwOQCWNou11o
 467mebf1FwYIP3OCYR0Q9W6JLNsAZ2y1Fhz5XGm9LTj4dGTIBQVdhIG3P9rnsLLm2MmL
 Br1WhguOnZfk+GR5aMn/eOsxhfBPzOk5J4Njo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399057; x=1740003857;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2tlDHt8KY2076Ob/xNWsyie1o3Py/0A+zipw2TD5VQ=;
 b=Kwr7tMAQ2bvwYdIF0cUdzr6XFdi2v9Wlpka68AAlljJFc6Ec3ZwZi8+tJ5JnkDkp5A
 3wBOhJLf1T1W11PwkyfJqLsmhw+sOfitzi33QCKiV7Zj6tYZ7xxRH8CuqjogO+pDsJVk
 eGhZ5UWYVJ1SIlQrjXuS7GKgxFkYtMoipJZ3ATsbx/NNqRvj8JA2B0qgQ/t/7fbd2NS3
 wD+Are67tMQ/9zEZQhtIDUmd83OJQd68yLJUq1g210n0AQfAekxdYA0WJBHogXOOaykB
 lkAlcZYr7dgDTiQrmE3zW16DA1+7hNnDAdaP3EUfLvIhOyPAbeVE3roXjrKzJKqzv2f0
 lY2Q==
X-Gm-Message-State: AOJu0Yx1Rq2v1GMZk995w6pdE5E/kJ2R+ImNum56KjmPoBUjIRJh3oZV
 9XmsAjjdiEyETEERsW7PjVwXzvrugePkYDJ6p8wi5MJ+khZ3kt+OTHU9QaUJqqOdwxQevDNI3iH
 0
X-Gm-Gg: ASbGncsW22iEQpGnqtPu6/3utVFdmOWs8P9x4PP6X24I8AgAZ1d2i3sKFRcqFUmNvWY
 iP1VJGbaQvlBbghcI7TIqzMnddvl6I9wwLkNCrfxAavhItNzAXrh2+eZrJQy+OnD/0XOUvwyQ1w
 ha9tf8F8rFJdAR3xjG6igMBx+n+w6MDygOCAkjnLevTPPT1C4VeQJsxKfXEYcRVjQjdU7hBRDam
 X2PtvkyzSBtFA8EJk8eZMRhyVGyhr2Y5cPUwbuNRCps/FvQfTHdhnNf/3PNXZTwk/5c8kT2IDVI
 j45fZAEDtAuJQAdsBA==
X-Google-Smtp-Source: AGHT+IE3XK4VAdU9j8xCfeqJEHLRcVMBnEwF6FueNG++4o5h1/2fIvNHsS7GXTPMP8OlGgDwfxhlqw==
X-Received: by 2002:a05:622a:1356:b0:471:89dc:2cf with SMTP id
 d75a77b69052e-471b06086e1mr73986251cf.1.1739399057306; 
 Wed, 12 Feb 2025 14:24:17 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4717808731esm58750031cf.11.2025.02.12.14.24.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:24:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Dockerfile: Add missing 'rm -rf /tmp/coreboot-24.08'
Date: Wed, 12 Feb 2025 16:24:15 -0600
Message-ID: <20250212222415.684601-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

We had missed removing the coreboot directory once done, fix this.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2848ab85f35..c080c735af65 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -297,7 +297,8 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     make olddefconfig && \
     make -j $(nproc) && \
     sudo mkdir /opt/coreboot && \
-    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/
+    sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
+    rm -rf /tmp/coreboot-24.08
 
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
-- 
2.43.0

