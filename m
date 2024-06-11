Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142F9C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C901B88729;
	Tue, 11 Jun 2024 22:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IdeWGmHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA6E88715; Tue, 11 Jun 2024 22:02:27 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F83688744
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3758fa1cc8eso6234385ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136143; x=1718740943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kSHg7qWjXsARtjBpbR4RtDAK6qA5RpzZmG7C39EaVxs=;
 b=IdeWGmHuImLHJdfpcaTC5BzA1CDqH55PUA7xE5uPrj0LsUBs5fxDQwiMe+jCQz8HZ4
 KVWkH7un8+7B+Y+d3zz6dK0mmo3Qpoem5zsYpabDZW1oLq7mCX7TMb0qSbK7p/m23ZTF
 NMjyWeEEkp6h2gmPsjhmkL7SzkoYQ9RM4oNpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136143; x=1718740943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kSHg7qWjXsARtjBpbR4RtDAK6qA5RpzZmG7C39EaVxs=;
 b=B/0x+bg9kYV6AjrbX6OPkqZLFq+0OmELtuF9Y/M9RrQS7BB47taV5bV8wam8FFPChg
 5KIpd8OYDZ0znvR2jN/2g5jlQnT5R2MwAMnXUnxxyuSreD8voV2tngOzRUZvsbb2Vm6f
 qG7klgqR3W8rd/wtXRrNueBzdM8GD0rCHDRSHgmwtvmXuyL2tkkjUFQ31azejQu42b5X
 wjVCu/0yEo7qNzRpSo8bUrNwytGMo25/1DaDL1l3I5NEUgnA8S+hG8Soa10n6Yy27L7V
 8mSUdrAvDIyD8nCe1QjuN4uPmVRfwJHYtJn+LfwcK1vheUMttLjxmKTmifwmdmmR3e6M
 Kgww==
X-Gm-Message-State: AOJu0YxiigzHhQcEFbU6tTLIk5A/hDwNw0xLOrYu2V/9ikL06QoTR2pa
 1oGjRferjw45i6NLWFqYVof4ZSRvQa7N4srlm4p9kI66yzC6BjXkuJqwRRCuQDsQweMmbFODWEr
 VGA==
X-Google-Smtp-Source: AGHT+IEE6JwyAsLHB/0WuHPw8DUi75cSbjDSnfW1rR3rEHI3pqEKIx5I2KqCXkz5xuXesyeFiWal3w==
X-Received: by 2002:a05:6e02:174e:b0:375:9c7e:d09 with SMTP id
 e9e14a558f8ab-3759c7e1050mr121201275ab.7.1718136142938; 
 Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/42] buildman: Retry the build for current source
Date: Tue, 11 Jun 2024 14:01:25 -0600
Message-Id: <20240611200156.2245525-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

