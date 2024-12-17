Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FBFE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED1F480224;
	Tue, 17 Dec 2024 14:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MbyLXtjV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5BF8022E; Tue, 17 Dec 2024 14:44:27 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF2880107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844ee43460aso301131539f.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734443063; x=1735047863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b8MoodTNmQKCRKOap9aG9ePM/SYKEMozI+bgO0ZvTjY=;
 b=MbyLXtjVItGxdBWoNKel0n74/J5/0UvKlQPRDmfo8TyPWY6VuobyzQw3ps+65jOF7R
 tR32ERhy5RCxdcEUBWcRvafYhX9oGORZbI9usg2mmA6ZO3OOUj3inFSkspSscbK1+EH2
 w6cHDJJXSMH1fp/933RpDihCu8YMVyfRUqjRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734443063; x=1735047863;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8MoodTNmQKCRKOap9aG9ePM/SYKEMozI+bgO0ZvTjY=;
 b=dUlq5iOV84GyKI3iLtg2vhy9SlVEbsSg3nEFoL2DKzHjgcIPd7skFYADDlyXyAthGh
 cwECNGYWrItcJX7uIRnTq8GMh1Spio/bWtKZKxdPM1kQofetD9Zp01vkxYwZnqkxFiIP
 PE0bYq9I3f7LVIrgHoPoUucc1eE5fWAy2ivxyEg5Ha3w4N8GtmDoSNiB/t0XoOEacSIj
 d7OiwSxC6fPOSiFOwBqNR9ZjeXTr7avWuz01FzTqqGU/MML21BFu3mYP23twaLrIo9GW
 bShZmYYGpuoueeGXv1HX3VQJIH263T0kE0uBwooHPZR9yfxD9UXaemWCFF3QVdzZ/5HU
 r7dA==
X-Gm-Message-State: AOJu0YwpGiflfPi6RqZ+vpIHuGIUQs6YchMcTA5H+5Gwgk8rwnHnZnqc
 c114fSabM5C5A4kG8ayT4mAcdk8FhAyvcflDAuLuzD14qs5QMAX/relmxwo+5JtFGLDhmn+cWEU
 =
X-Gm-Gg: ASbGncvCifa/KF7vINsZCs1IpbWypmJ4OjiQyzhKszSpGvenFqBPXlbvDnAueymmsqd
 ll0ozxWYKDNzoosBLJ82VEAce1w06OPtJ2qvt4AlXgQE7TECKmn2qYYbDIBwNcpGBVEfV1MGF2W
 3NlCCLZAWSkd60mrgKV2qm4rQyBxZtJCb0Izx0eHhw/B2TaVT6xYI+XmVvb8K7OSju6TAYdx6mP
 orwew3eEqKX3pgG8+j6+dyUaXE+7rVQDGwm5L+Q0I19Yo1+CsgXtF/uk0+VcLdRTkFA2449wNXQ
 5Rb8VHMCbLf+iTrC6A==
X-Google-Smtp-Source: AGHT+IHho6qLUmGUbXaFXpAym8k5A3VKh+dn1MQWvXFJqUUP/DnRNh2xPB0wNx13hoMcfGAM2J4mJg==
X-Received: by 2002:a05:6e02:3dc2:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3bad3757b23mr35618745ab.13.1734443063095; 
 Tue, 17 Dec 2024 05:44:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3b2475af0desm21033415ab.5.2024.12.17.05.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 05:44:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] gitlab: Add a Colibri iMX8 board to the sjg lab
Date: Tue, 17 Dec 2024 06:44:17 -0700
Message-Id: <20241217134417.4064239-1-sjg@chromium.org>
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

I have one of these boards loaded with Linux 6.6.2 and a video demo. Add
an entry for it so that it can be used for testing.

Unfortunately quite a lot of work-arounds are needed to make this board
work, but I am working with the supplier on this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a17c1b0a366..1c15907fffa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -702,3 +702,8 @@ vf2:
   variables:
     ROLE: vf2
   <<: *lab_dfn
+
+colibrimx8:
+  variables:
+    ROLE: colibrimx8
+  <<: *lab_dfn
-- 
2.34.1

