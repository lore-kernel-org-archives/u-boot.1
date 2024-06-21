Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26CAC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:48:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9233388590;
	Fri, 21 Jun 2024 22:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nyo9+FLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD84D88405; Fri, 21 Jun 2024 22:46:51 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A798B88591
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7eb9e7f3da2so101198339f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002807; x=1719607607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSHg7qWjXsARtjBpbR4RtDAK6qA5RpzZmG7C39EaVxs=;
 b=nyo9+FLA2JUpYK74UYhOBHjxOr1szRneU0USz3PmlVOfLHOipROpkt77tCODSBfiNW
 5mqB0zRZWwc0Pjq3mLthMT1kFKwG0DUcgA0/7xYPxT2Eak8YbbSZXaYPve6nIfdmVfx8
 rpcrhqDvjwAla59nRWrVnUWRKIaZ1dJkeeAV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002807; x=1719607607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSHg7qWjXsARtjBpbR4RtDAK6qA5RpzZmG7C39EaVxs=;
 b=QkYbFEsG6hYd0UPEI2DrY0GMhXpf3lsrTE49UJqK975YLBUyXYKUjg7puMa/Ni/J1k
 zZF6WrML4goF/6M0A1z6Odr4L5h9CL668BX3xW1NiuwZFQcB81X8zRM3aNwN7ENqVxFL
 7IQIJGijEE13R/AdQ5W4JcKSRlkZenBXFP2x9zSt1ESk6GM3CpEXTiQgOSaI/QrS1ztm
 AXlXctZDWebadgARNYVtEam0e9vVsPcrTzR5sGWmk5bZgkc6gQ1M+Vh90Tt+8183UqA1
 1s9PhOADV1HIQpScCrUOt2T6a3RDWn9lbCjso0+anBbyd73Qh3MpjcwaRHvYPgMpyTNn
 gG1A==
X-Gm-Message-State: AOJu0Yzts0YQW4VYdKI52PPEHOoHT46fhTZW/jAJQo5h7rB8LUi81kVv
 8fJG8PvqQh+Ck9fZIK3uNNr+94rlnvj0cemkBVEFkT2CW91xa6+rmxjuf/K6/cahMzNn/zE898p
 ywA==
X-Google-Smtp-Source: AGHT+IH8OIk9k8tiIOJMDw25TvWig3b+CYu0Y9Uoomge8qjUNhOr/5ydeUk3IdWL/FYnjuH1GwP/MA==
X-Received: by 2002:a05:6602:6b0a:b0:7eb:832e:eecf with SMTP id
 ca18e2360f4ac-7f13ee7a8bemr1084427639f.17.1719002807337; 
 Fri, 21 Jun 2024 13:46:47 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 10/11] buildman: Retry the build for current source
Date: Fri, 21 Jun 2024 14:46:31 -0600
Message-Id: <20240621204632.2706813-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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

Buildman retries a failed build when processing a branch, but does not
do this when building current source. It is useful to do this retry in
both cases, so add the logic for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builderthread.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index bbe2f6f0d24..55658487abf 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -755,6 +755,14 @@ class BuilderThread(threading.Thread):
                         self.mrproper, self.builder.config_only, True,
                         self.builder.force_build_failures, job.work_in_output,
                         job.adjust_cfg)
+            failed = result.return_code or result.stderr
+            if failed and not self.mrproper:
+                result, request_config = self.run_commit(None, brd, work_dir,
+                            True, self.builder.fallback_mrproper,
+                            self.builder.config_only, True,
+                            self.builder.force_build_failures,
+                            job.work_in_output, job.adjust_cfg)
+
             result.commit_upto = 0
             self._write_result(result, job.keep_outputs, job.work_in_output)
             self._send_result(result)
-- 
2.34.1

