Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD10C8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACA4183106;
	Tue, 26 Aug 2025 00:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gbVOk7Z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEFDC80819; Tue, 26 Aug 2025 00:34:30 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA988311B
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b5c12dd87so18256655e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161268; x=1756766068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US+63CMGn4cUU2RpbHydsaf7YEtD0GbL9ziKtZYvkqg=;
 b=gbVOk7Z2FdFldDYN0owhB04FQI45qGHeBosaU+L4jN+0ei4j9qLNHLtBStQX0DOk01
 xYa0C4uVemNLzI0x2Etn0DmBDht9nM8O+CzZtcWEPnBUNULEwGLFyBg3pg0kXNqguYtQ
 R5rFPIx8TsiGV1+dqEICFvC47Kl+bIsjSi9tbm7+4pMM4fZsZeDj+jl6OmOQ2rjKad3k
 GOpLriQjXHEcXWFe5bGpXJcWZEBDWMqzpHBo5n5FD9dgTr2ov+uEpH3O/DGF1qeiUQdH
 n6soUjnAVUZV/PZQXNnjBLzbjNDXW+OInW4asL4sP39R/PG8+1cMGAmon/jt0mEzZt0E
 sGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161268; x=1756766068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=US+63CMGn4cUU2RpbHydsaf7YEtD0GbL9ziKtZYvkqg=;
 b=Y/MoXYhHZ62I7jQWZqaIQaEDv/BV6DTeekUQvcq3xc9FMIJMpqs/oSWrPHPKnuLgOe
 hrtPl32MU75BSnBAMi3hCwdVv3MMzRqy9JOoG7NWZHPtLgC7+L42E2rDp+bx5N4nPu7T
 vfz7toISux39yg1dYryplIovooT+YsW1c6modfhs/+k6xegrRWCAWVexjaiEblc62wcN
 AnT8wOAlv7/Y41TEr2AkmDadVHhf53vE1Pki4o822vcn7kVy22C9BNtCdtCZKt8RYmLX
 z2BxFMl9v4n6Yefd+EWeh4V8Aru+/K6jQ7ryGhGNSzPum0dDzaClGPpdwR3fsj3SIqRc
 6uwg==
X-Gm-Message-State: AOJu0Yyv8jp3awdXgtqctfCfaGpBvs8pyGG6Nvj7rmGo7rSR+E3OJgP/
 u8ys3ifJ4rIr5XcqpN4sPsaqNwNmfg9TmQuOBmEGUuMrTiG3cLRpAvr7BmYGymYq+qk=
X-Gm-Gg: ASbGnctzLlFfh/OgXmVcwUSNh4IqHhlJ/yAHk+kRjufEsxDz/aV5qsjkq77NsA6xlct
 6ztxGgAKpBh//JiUCrIK1iTjgYKNCn4aa1I1llqZt951KIj1E/QHjW6g3LWyrst3UgysVsrUFfI
 fCr07dXdVh2xcMdknorloliL241RjQJSS2nKw5xZs+0xRh0ISn3m2RQTeGWNyYFPmKFv3i4z0G/
 XnO9FEn9KJSAVNk0OCjqVGRE4TWTnI+XojjXfT9Vsfs0s3dA2MnJqNIXzA7DeyzPRxxs/d6FhpC
 uNwDr4lzagyR3g6xQSVR9JFC4vz9nyGcZ2gh9dbVREWolrj2W7GpviSg4WWupFO9HjufVg5gyG9
 wy5iI7J0kP/yQRf0oX1SFactSwIdWeMR5cCYm8Aw=
X-Google-Smtp-Source: AGHT+IHW3WFkEmYVOToEPlHfHidNlhS2ZNsd+u4piwVZRBprHbuNspjpDLIoDVlnPowc/KF6Kg/5pQ==
X-Received: by 2002:a05:600c:3149:b0:45b:47e1:ef73 with SMTP id
 5b1f17b1804b1-45b517df336mr94161885e9.34.1756161267840; 
 Mon, 25 Aug 2025 15:34:27 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b575928b0sm123733395e9.24.2025.08.25.15.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:34:27 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 05/10] doc: Rephrase in a simpler way
Date: Mon, 25 Aug 2025 23:32:32 +0100
Message-ID: <20250825223251.674591-6-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
References: <20250825223251.674591-2-adrianocarvalho.pt@gmail.com>
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

It reads a bit nicer.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 368ef5c6f19..a6ae9b0a9d1 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1188,7 +1188,7 @@ Use the -L (``--no-lto``) flag to disable LTO.
 Doing a simple build
 --------------------
 
-In some cases you just want to build a single board and get the full output, use
+In case you want to build a single board and get the full output, use
 the -w option, for example:
 
 .. code-block:: bash
-- 
2.48.1

