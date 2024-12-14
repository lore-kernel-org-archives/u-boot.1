Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C10AE77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9E480098;
	Sat, 14 Dec 2024 19:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DFF0dbZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24E880092; Sat, 14 Dec 2024 19:20:39 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1816D80073
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so58470439f.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200435; x=1734805235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mt6MvUoTNh5XS0XqbNHZGu53sz4gUtplVWjWUwlPrGw=;
 b=DFF0dbZK7EUoYrlujC5KpuiY9MNFyuLITwLtC6vHlEl/Ipjj70Gvkc6bOLhBq253gh
 xo5DjJWXh0DBRxCe8BJ4HWNUb6v7LYox/6qTCAwaQ4wBhukLZZ8iKbcVDJpwS9EsRggp
 ML6Xx8880EPdfAL54kVRqEanuTSHpIlD05FVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200435; x=1734805235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mt6MvUoTNh5XS0XqbNHZGu53sz4gUtplVWjWUwlPrGw=;
 b=AbOLEshsR+OpJXZqDR/LEeSEem0MIbfUyFqatMfCPpNwJaP/CFWZPWTfa+ivOlwtBq
 r8QNeaN0C41yuYNPGcL10tDzQ+/OMvJfkaw+U71prCHKBdp75BRABb4zyUyXqvp2e7R0
 D7vlTm7XXHGAVzedxGGCTEZ0CQc8tJA9+r9u/0/pa1HkVjpnNyGvtP2z7nv4Lg2YPdgS
 zHSO13r4tVNfO3z0gGkewuNdDe6OtI3J8nBsRaEjHmGTh695eRg/tR1SkMdBtaF867lM
 zzsos12gp4dUdc7UwpLONckWsTWnMQ2utPmszr8qNel299JD2FRUeX136tZsN7vwPWRb
 7DNA==
X-Gm-Message-State: AOJu0YwoczhWSLoDaGPNNdq2cD0ofY+iBrVps5wceI+vIptnJ+mjdczs
 0TRdydmIYz4DHT3kTOKkIFCfsG+adVu0DAXZ97nFf0DN+OygiFfM9s/EeBZ7Y53Sy/VwlWd2pbg
 =
X-Gm-Gg: ASbGncv75OymhEYXChwPgFNw8B0hd1X8uhGK2P+/aKhT/tsbs+ThJH+4P9PMlWtBqrX
 N5QJ8/fKXtnVXqT5JhH3+0492azyMb99s1NCoJZSsZ/bd4Mc5MsLBOUHjMRDygiFgNU0wtS+9Gc
 7SFn22BdmkXJ/HVIbT/b2yJ3dTHcKX1vasUsB7kty/aKdnFA2srxYF6fgR6DlSEEpUhtC5J9Iy0
 APC8g/dGAR+RtInz4yZqM/jLzPCZ0lNjjGxpVFbKvXogj2lWemWlJlosUlxJLaKK/OBa0BkrkZ3
 yNZvjaoDTfk3RXZLiQ==
X-Google-Smtp-Source: AGHT+IEmp2FIPSd6Lv1z6aspHb4GuzDsN5EIV42aQRz+R5sk9P7SrbWj15oxo5nz0xcfSgAezGOs0w==
X-Received: by 2002:a05:6602:214f:b0:841:9225:1f56 with SMTP id
 ca18e2360f4ac-844e5b3af44mr733621639f.3.1734200434807; 
 Sat, 14 Dec 2024 10:20:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/5] test/py: Provide the correct U_BOOT_SOURCE_DIR to getrole
Date: Sat, 14 Dec 2024 11:20:20 -0700
Message-Id: <20241214182024.1954974-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
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

The u-boot-test-getrole script runs before the normal environment
variables have been set up. This is unavoidable since the script is
providing necessary information to test.py

This means that U_BOOT_SOURCE_DIR is not set in the environment.

As a result, Labgrid uses its default source path, configured in its
environment variable. While this may happen to work, it is not correct.
Also, it causes problems when running from Gitlab, where the runner may
not have access to that source path.

Provide the required source path in U_BOOT_SOURCE_DIR so that Labgrid
does the right thing.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: bf89a8f1fc2 ("test: Introduce the concept of a role")

[1] https://patchwork.ozlabs.org/project/uboot/patch/20241211131858.520639-1-sjg@chromium.org/

---
This patch is intended to be applied on top of [1], which fixes a
similar issue, but only within pytest itself. It should be possible to
drop that patch and just use this one, but it is a bit nonsensical to
ask Labgrid for something which test.py already knows, so both patches
are valuable.

 test/py/conftest.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 509d19b449d..acc7e5e090c 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -158,6 +158,10 @@ def get_details(config):
             env['U_BOOT_BUILD_DIR'] = build_dir
         if build_dir_extra:
             env['U_BOOT_BUILD_DIR_EXTRA'] = build_dir_extra
+
+	# Make sure the script sees that it is being run from pytest
+        env['U_BOOT_SOURCE_DIR'] = source_dir
+
         proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
                               env=env)
         if proc.returncode:
-- 
2.34.1

