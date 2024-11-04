Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D2ED132C8
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A154789076;
	Mon,  4 Nov 2024 14:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EBfDEhOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB1B88F41; Mon,  4 Nov 2024 14:40:19 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 239B888D13
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f37so178470839f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730727615; x=1731332415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VKyyy749CEwE0Vln7HQ2ISAnIhx4/RXq0RG6k/UIKp4=;
 b=EBfDEhOne/hwqXte+ZpFjkl2wtMcL+jA+ufM5dDhQpA5Bmm9uBmhuDjmpedB6u2Kpr
 +IBwJJ4L0ottKsWLM2AVRgkP48Kf9K7MImW9pjZBtEzquXy99lYfvqJ7yP3HSwrl/Vo9
 PvhjnOnTuur7fpjbpUR31ecuoyRweJlsCIox0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727615; x=1731332415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VKyyy749CEwE0Vln7HQ2ISAnIhx4/RXq0RG6k/UIKp4=;
 b=qS+MRbbg+JnElMpWeD94r+eHNqGYsTf+ybMXIZ11fXYSWruV25n3do48NONdCvnC9g
 KkvNGOVAcYWzF/DzLiiS5FpFlYvRalCLOD0zLRz+y48f+Mcaega73HmFTh6dpMLY/Dvs
 BiTAxfzW06Oko9zPy/+ri5p1GYs5IKeWrBx1YXXfP49qY2hg2zYKhJlYxA4nt1ppnv5v
 0ADUXVDXJg8GtBDTynomIZ0SvkKTgsbNg/jic1iOU199aOkDDoaw/5BXHNDdIWbdslCr
 mv0TO2OB67QR/E2gECj4taVfm7bJs9hAxbq9OqWdIO4R0M5HSl9rpoAM2jJQiFy1Ru8R
 xPjQ==
X-Gm-Message-State: AOJu0YypW4nI/C7hV/OqQvU5RGu0x+Eq9vJcIhnt/bzU10wgdEKl5khF
 LLqXqzwkYpzzwO1JO6C1WHgkgvDldNspgUAIjhEy5200kb1+5Y0/jDgM/6CuWDfg5sSeAgjYLMw
 =
X-Google-Smtp-Source: AGHT+IFf7CqM1y7j4f1alNYvqs9iRBD/f4r4+klzbot1eV4WNjKmYeIay9CwMQ+95M4yXroiXcQPqw==
X-Received: by 2002:a05:6602:1589:b0:837:7d54:acf1 with SMTP id
 ca18e2360f4ac-83b1c3b7c50mr3398476039f.2.1730727614625; 
 Mon, 04 Nov 2024 05:40:14 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de048895f3sm1935128173.12.2024.11.04.05.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:40:13 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
Date: Mon,  4 Nov 2024 06:39:52 -0700
Message-Id: <20241104133954.840994-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104133954.840994-1-sjg@chromium.org>
References: <20241104133954.840994-1-sjg@chromium.org>
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

Fix a warning due to the syntax used for PYTHONPATH:

   LegacyKeyValueFormat: "ENV key=value" should be used instead of
      legacy "ENV key value" format (line 304)

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/docker/Dockerfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ae3d4685869..c42e0890897 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -301,4 +301,4 @@ RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
 
 # Add mkbootimg tool
 RUN git clone https://android.googlesource.com/platform/system/tools/mkbootimg /home/uboot/mkbootimg
-ENV PYTHONPATH "${PYTHONPATH}:/home/uboot/mkbootimg"
+ENV PYTHONPATH="${PYTHONPATH}:/home/uboot/mkbootimg"
-- 
2.34.1

