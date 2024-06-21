Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88D2C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F6188574;
	Fri, 21 Jun 2024 21:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BSkejgE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6A28853F; Fri, 21 Jun 2024 21:52:23 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57A6188582
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7ebe019b9cdso88726239f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999539; x=1719604339; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qk/LjuhGcEBLV525OvjxB9qqA75bigTVPm2AbxzlWq4=;
 b=BSkejgE+BVAUWJ0kauVNqHXmEzY4OVXhOy/DVHKK5WcpHBDttRmy9cN/ZpehsPNXbr
 Q33woYImnvLowY0YFOJD9qVkaCQU1q0NSdLM6O+gbF+v/haGjFssFjOAJEt6VOXP0YVZ
 9RDZmheNNszIcuRrG2WldWmlHyHISlhi9Bae0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999539; x=1719604339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qk/LjuhGcEBLV525OvjxB9qqA75bigTVPm2AbxzlWq4=;
 b=izxnBE7kG7UBm8rb5uJdIpPBzXc/l/rZQQmhEWp7f4r69pYGie3kAmokdSL3W4nNc2
 FxS57CNscVpm4+OQEc8O+a780jSnRcOA8b3ZIurAT2Ym8qkuativ3MgQ/etgqrttkSo9
 UgNuP3wkUZrXJ0jUuFVeuXhi2RD1Tpp8cSx2WbuKJzDXGO83DY7fKg7P/2QsYoEMOwgM
 qSg4u3JwAA9yHKhK/rGrtrrGVfeYdXBx+lu6oUdGNsEa1QnlIKf3g1wX2SkxPWjTtTwB
 HBVZhZo2WCDrrh8oWNKMdynmvCsfp7Q5cd4EukSmP6bopNwRxGloqAw7aL/YFzDdNI7k
 drHg==
X-Gm-Message-State: AOJu0Yx9I6noUpH3hm3QwuhlJLpclWd3b9L2mfv71CUxM9jXP+W/BDd9
 shnunjCGyfogsQOIr3tdDkBPBreCyvH7q5QxuFvllaj0bbqih2v8ODV7Ph27cw05ypRevXTtPvw
 KwQ==
X-Google-Smtp-Source: AGHT+IGPCsT3tUj3jdUpfeYPEYjffzpTv5PjkTyXr9Bo50lTUoIho3pV4IJaKiIWdSgXc7krLzfZyg==
X-Received: by 2002:a05:6602:6b0d:b0:7eb:7e0c:d187 with SMTP id
 ca18e2360f4ac-7f13ee684famr1034563839f.13.1718999538985; 
 Fri, 21 Jun 2024 12:52:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/43] buildman: Retry the build for current source
Date: Fri, 21 Jun 2024 13:51:32 -0600
Message-Id: <20240621195204.2675252-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

(no changes since v1)

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

