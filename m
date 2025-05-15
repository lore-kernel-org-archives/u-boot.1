Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA8AC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:43:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2C182AE1;
	Fri, 16 May 2025 01:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pMMR/g66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6C482A76; Fri, 16 May 2025 01:42:10 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F6680107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-72b82c8230aso767201a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352527; x=1747957327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rxfx4rgUNS9ZaxWZK3igTPMVfYJwzpP6Vjq08rkB31I=;
 b=pMMR/g66JEXADxU5C4kfHkt8Vf7/MJOxMe46KCADnnm1myvzavT1S0mLZBWBhLfewO
 v4f/1a1XO8ENIZ00b+CMhckog7BAuv6LnMlH9J6fo3PB5gJnGEJ6HH8pbNebxp6fKUwj
 ExgAoCbipT8IBRG4ma4PQv/2illxLei3nFrTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352527; x=1747957327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rxfx4rgUNS9ZaxWZK3igTPMVfYJwzpP6Vjq08rkB31I=;
 b=IdNgF+CpXhbL8ewSlNquKp3YYmAxvMFbSpB6pX7GC9GsWqWrS7t09t97jdm3Bhjt9t
 hawWKM71hA72jMzv760pl0zsXql+qerYTBGVHRpwvBSLcrbUo9NA2MkzK8GrVIqpL4F5
 OLzNbYITqP86IBnmbrCGRmPIo/axYRuU5d3CiinV7scsJELk1AcWPAbiWmElwEejRsIk
 EjAmPTQIRhqiLSE5bHPNKtVGLak0EVVdVVPxxrkmL0BxGKYkPOnncI2sxkq+nR8kbyTA
 5Yn/MJORfjpd+8Ouac91028umNmEu7pN+V3loNiA47HtCwRlmpHVTpqv0joMISG3a7+J
 jRyQ==
X-Gm-Message-State: AOJu0YxSGhP58QQagYTohEedR/Uj46mW7fOozQ8aOuYGTFCpPh5p97fO
 KFIW7+Beiwt74r4QlupmFNSqSG58bWT1j04okX5XN2UhmHyYmNvHWmWvPXrF80SCpM62C7bgqRx
 pvN0brjc=
X-Gm-Gg: ASbGnctjyewaOCsO2tKEMBSJ1s07aI5XeTu9+KOlOdPEugRHRP3Mj52B3BeB9dynx8G
 yA/7xQ2iw6ry7r0HhNF+HlEKLW/5MnZNKRmwpNfimfeMgo9wAUUQJviWvhB35IDKfDs6yXVbrQv
 RFjC9EBdnNKR9wsCpCcvN4Dm4wC5JUC/UFPihzkYnrPzZuhsPc5dqjpJE1+MOOaRnw2jwDs2qJk
 zA8EP9jpXBHLeWwUP9HRLFovifc/QWVGjCKm0KeTHQCvZjR4QUk6Q/7PyD8iufuaf0Fyhi8PNdd
 2kqpwT1Xyogq7k58d3XE7RQGnXeNCLrUD9JOQ7GqKHZRGGojm10P3Xiot9hTNnISh65mMSMBRc8
 oTahNVKD2Jq4OoLQ=
X-Google-Smtp-Source: AGHT+IGXsuCeb5SacSNC+byw2Xc7PodHIcyTTl0JFr3FBXpQ1aw5IrjqKx/o9mMW7HoV3oBbaFSmvA==
X-Received: by 2002:a05:6871:8989:b0:2da:462f:ead4 with SMTP id
 586e51a60fabf-2e3c1fabe6emr854488fac.38.1747352527442; 
 Thu, 15 May 2025 16:42:07 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:42:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/22] phytec: Include env.h to permit reading the
 environment
Date: Thu, 15 May 2025 17:31:36 -0600
Message-ID: <20250515234154.1859366-8-trini@konsulko.com>
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

This file reads from the environment but does not include the correct
header. Update it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Changes in v3:
- None
---
 board/phytec/common/phytec_som_detection_blocks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/common/phytec_som_detection_blocks.c b/board/phytec/common/phytec_som_detection_blocks.c
index 5f3c27ef0c22..b44ff85972f9 100644
--- a/board/phytec/common/phytec_som_detection_blocks.c
+++ b/board/phytec/common/phytec_som_detection_blocks.c
@@ -4,6 +4,7 @@
  * Author: Daniel Schultz <d.schultz@phytec.de>
  */
 
+#include <env.h>
 #include <malloc.h>
 #include <u-boot/crc.h>
 #include <net.h>
-- 
2.43.0

