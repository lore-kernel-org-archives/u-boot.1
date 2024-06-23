Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659C2C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59074885FD;
	Sun, 23 Jun 2024 19:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sp8aWjbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 168678843A; Sun, 23 Jun 2024 19:55:33 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD438850A
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7eb7c8f114eso147914339f.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165329; x=1719770129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qk/LjuhGcEBLV525OvjxB9qqA75bigTVPm2AbxzlWq4=;
 b=Sp8aWjbDhfE2w61u8lEBfV+YVlQ1ciht4wWgyBnxTXDmkeKaQ0n/UGk+LVKx0QN5DY
 aOB7Z3hHB0J9W5V3Oqzp40hJjPJSpYqgrm56CgAF1F9fNb4w3Y2Uy6ftgFwtHJ2ICqYy
 DhD8jPjigWnlkEWeuqwcwTpcrsedu5Hapyn6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165329; x=1719770129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qk/LjuhGcEBLV525OvjxB9qqA75bigTVPm2AbxzlWq4=;
 b=rspgQ9MYHDsVEq5Hc7Th80WB65fpNeTWfpyNOnmMxudJnK9mhabBjskZ/TuJQaUT6A
 Ci6JgH9uQW/sqS1caj17jxZjNItSPEPjOKXUsALHkwROgeNYFY2A6JrgLGJMWEFnMmAx
 I3T1RbD/M/Fjqy+SMRkd32TsWcEubaWg22dNf8EvHAAj1bHcI746MoVLwNWpjC9nya1r
 lzrc4N52d4+5ao19VzvxDjTYMrTRYf7NTHBcVlYxRv8/NQzDJVgiJwQcZUV7tMv9DX6o
 RMLDUvSQrgEVPhMs7rpAMhL1ghGWNKLmJQrG5B46uVjqWPADjPhoEmfPtoed5yezCzE+
 KEDg==
X-Gm-Message-State: AOJu0YzLmZ0ZcgwY0au50dOpymn3v5uBuoHQkDNWOas10rlI96WpWYaZ
 vT7uqJRz/HAsBLjU1yeP07P0Pj508SvQk91VozEqqDHnXZ7PHyLhJc8l7kwuD50T2/+oeFYHEjT
 h6g==
X-Google-Smtp-Source: AGHT+IFW/X8yBbt2O9oZVLdhkzLwGGF4oADeGWEmXdehjII8V9QU76B0WVDb2h05M/nimhm3WY2lEQ==
X-Received: by 2002:a05:6602:14c2:b0:7eb:80dd:83c9 with SMTP id
 ca18e2360f4ac-7f3a13eb9f6mr452319739f.9.1719165329097; 
 Sun, 23 Jun 2024 10:55:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/14] buildman: Retry the build for current source
Date: Sun, 23 Jun 2024 11:55:14 -0600
Message-Id: <20240623175515.1466908-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

