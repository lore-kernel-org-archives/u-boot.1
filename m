Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C926FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 20:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF9D870BB;
	Tue,  7 Nov 2023 21:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bBSGCcsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBE88754A; Tue,  7 Nov 2023 21:45:08 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A7E803AC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 21:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5842a7fdc61so3094693eaf.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699389905; x=1699994705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BI7kd0PCGYzP/0taZgMoaKLAxTp4pO3ii8hNIjgQ6og=;
 b=bBSGCcsuqys+09StP9F1fJMJqHGM7AKx4QFkCKTyzekHY1GI1f5c4bR8hnfUCRNCIa
 +U18dKhZtsn84TAtHuUkvpXtGUMNavcwBpATNJpfPha3YWND60ayJYnhW0NWQNkh7gfR
 2h0UmctuJqemwmtykalRUntFHWM4MFqC7UdnGfad71mauSaYaJsihm7X530IZjhy5sve
 8JjYbvms2FKSApRQzdPSG8th6Iezno5ZqAJAOaziI4bUQZSupBjOOknC1q8Tf2YZQbUZ
 P+BdJ6G9948rNvbN06T4wSJE+1nUOuAL32XdIKFcH1f5fP2OhpiLA4y8t9tcx53TjqDQ
 AJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699389905; x=1699994705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BI7kd0PCGYzP/0taZgMoaKLAxTp4pO3ii8hNIjgQ6og=;
 b=HwrpdgLh8r7aV3yQmANgfUzyH0ikpofrwFoVLYS7AwaFgoQktgx7e0NGjDXVDhcNtp
 /qOJ14iFFt43UNaOCXi5xbCYiQq0hEtmxLLO94yn5Vfe2qgIXIzGuoyGf6H8TOTmNYq5
 sSy5DycdcGGVUWu9ua19MJN6cdmwj5ke2/2NT+Ia3cfxdVFQwA3d8qRmiQPMlD8nWS2A
 1iDi/MKdllAr2UjLAAXmMokRuvVhUEDHtTKoez3ZbbRVonzsUCeUKNZaaGJtCC/e9buo
 cTEX0Zyx/e1cdhtry16qYVlw6SQrwE0ubzbwauXuWpjFDiH7ELorXNVddMXj69TyYY/5
 nMbg==
X-Gm-Message-State: AOJu0YwDrg3BBhvD1V1gfDd+PszXohY6M0OExFVbF0pWBIRhq96rgget
 NOk3sXxddpP5goRVQH2/CJtNkhOHcj8q0o0KAMpW6g==
X-Google-Smtp-Source: AGHT+IFJed0Xj6naGwkUrcww+aQ/7oW10gPQUyekrELzeTYyTp9YWL1MtMPpNTzEK7mUCJCFO+9ENA==
X-Received: by 2002:a4a:a50c:0:b0:57b:7e41:9f11 with SMTP id
 v12-20020a4aa50c000000b0057b7e419f11mr681184ook.2.1699389905019; 
 Tue, 07 Nov 2023 12:45:05 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 g15-20020a4ab04f000000b0054f85f67f31sm2087452oon.46.2023.11.07.12.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 12:45:04 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] MAINTAINERS: Fix Sam Protsenko mail
Date: Tue,  7 Nov 2023 14:45:04 -0600
Message-Id: <20231107204504.7063-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

Sam works for Linaro again. Use his work e-mail address for ANDROID AB
subsystem.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cde778bc4d3d..d21f66b0b67b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -58,7 +58,7 @@ F:	lib/acpi/
 
 ANDROID AB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
-R:	Sam Protsenko <joe.skb7@gmail.com>
+R:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
 F:	cmd/ab_select.c
 F:	common/android_ab.c
-- 
2.39.2

