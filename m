Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F177C02192
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC07A80AE4;
	Wed, 29 Jan 2025 17:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mcVQXuQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F32807E5; Wed, 29 Jan 2025 17:28:22 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 205FC8082A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so17699731cf.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738168098; x=1738772898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SvkOIQlYyZ0LahJQcCer7ST/2cKbLzdDni+6h7kklAw=;
 b=mcVQXuQ2wL3BdVEXCpHJK8JyiFHb/nsF/MizQz28Twc/7MzlD8IIj28/XObnSDWmMQ
 QgxKMCI2AYY9OByQNV+rJikYMSeksGB0NgtdAiotssjiX7yuUYOxpXw5CcpGoVIO6LNn
 /i45nEc4bQz/8/hUCp1/Fr8/8+7Z0EyAWqxrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738168098; x=1738772898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SvkOIQlYyZ0LahJQcCer7ST/2cKbLzdDni+6h7kklAw=;
 b=Zoo4JgBWqbPma9+M50GibMFCFOwYlKHexHCGAie2hmE0rt6NA6S7klg8vAzBdl6gBY
 BPdOY4fBMjZcv4VM6KTP2gZ49NlV77uG9iATHEKKihQIrUpu+wlxNE9s7QOiVHEsTuXb
 PyauBzsgzhE55eiS/eKtXOraHRfGlBA9YgqoJnm6cxNVCFF2YjdYIUXFoedfBbvBcdNR
 ts+RQUkcB23ymUcfvkSiJxUhcIv+N4dEDzZMirQKL1FxvZfbyQrQU0NEMVdaaW89J6YK
 itqsKfHAn4wK09aCF8ZbAMMqnipZjSRSzGo5Niw513VeovgDZA5iXTwaWfKN1px5IuCa
 h5iw==
X-Gm-Message-State: AOJu0YylFHBHs0+TC5qQ4h9AhDWUxuVBJkLcx4tT3OQOt0M4OrgoaY+W
 5ayLYIw0dLsgB6oBka0ag89+gXJ+GxDYZwJfjDG7JuDinXL+frjEAoXnPDKqbi1KKcTYozuO52C
 h
X-Gm-Gg: ASbGncszlsAeWzsGpzptgMJEAS0QMtGG4QJbxAbhGR6WXNOmwHSZG0isunAwXbrSMhU
 yHAk0RewkO5JUgH4yKuHSXj5/xd0Fl/oqnUMaqgVrHcJAS1T5AVXLu00x+Ky1s1A/waW24vzmFJ
 lXokJL8VV/zsrtBsO6uSsp80/LDjGgudDdHzAIC490n/pnOSSQ+dcojWDGpdSqAoQ7e2g/RKuhN
 rGhu9J4QbpTxWInPWo76FBRhxNJglZdQS9gr5OcSMRElKDAijKDjG81BrW7L1aWw6YQWYbGw17+
 mCUXPeqinPOePh/a7x0oaGQt4y09
X-Google-Smtp-Source: AGHT+IFpbT1BWtffD0qMEdzKI5XOmZIRLB8DEVpX9DQ33acyufoq2T2+2p/TCnCZfX3DhlJu8a2Tyg==
X-Received: by 2002:a05:622a:6a82:b0:46f:d6c3:2dde with SMTP id
 d75a77b69052e-46fd6c3300bmr21094731cf.46.1738168097923; 
 Wed, 29 Jan 2025 08:28:17 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6687efdcsm64414821cf.23.2025.01.29.08.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 08:28:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] buildman: Add pyelftools to requirements.txt
Date: Wed, 29 Jan 2025 10:28:14 -0600
Message-ID: <20250129162814.2140325-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129162814.2140325-1-trini@konsulko.com>
References: <20250129162814.2140325-1-trini@konsulko.com>
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

There are a number of cases in binman which require having pyelftools
installed but it was not listed in requirements.txt. Add it there.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 tools/buildman/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index 052d0ed5c6f7..85ec8e36f14c 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,5 +1,6 @@
 coverage==6.2
 jsonschema==4.17.3
 pycryptodome==3.20
+pyelftools==0.31
 pyyaml==6.0
 yamllint==1.26.3
-- 
2.43.0

