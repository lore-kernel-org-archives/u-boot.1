Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B90E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA4389065;
	Sat,  2 Nov 2024 20:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oa1gsNU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C442489117; Sat,  2 Nov 2024 20:37:33 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA94A89103
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso17444946d6.1
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576249; x=1731181049; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM8CSWUEiteeprXfk5eeM9hGBXh3nQTM4DRGnx2hRY4=;
 b=oa1gsNU2q/mnz7DV9m+yw/QeDlWguMKlcqUNcdayCqJR8xKV/oW8ezWG+eYOZsIYSN
 A7+um/esKWPGke2puetAheQfGoaB2DIiEs35GWTjg5TfYkYmG8Bqu9oB/0hHceOF2LCw
 VRgULCLyWOQZdO0jOclq+1yltSqsvgwVCqHUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576249; x=1731181049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xM8CSWUEiteeprXfk5eeM9hGBXh3nQTM4DRGnx2hRY4=;
 b=qe2VaJqc/bf8YZJqgvAzNWTpngPBhiaTF9+T1giooHsBQzegDZ6MAghO0zYyfviSDE
 3eNOFtMicKttoc2+4mNVJRbjmzrKjv1NFQIPYoM4snMJ9ywMIOH0bu0wrFjm/iYR0Ms1
 bzhkEq474uKXaDpqT0Cqn/ffejAxU7yoRL6TiBovMNJvis22lFEOaI47zl4ZvVaaJTnH
 xDL7thbka7DoY1raBBbaBAnFMacj6qT/TX8Hup4h/pVHuH9HV595F+Al6hUz99QEVjdt
 tfAjQX5TyB4S2JaS0Xhz4ycYoPkH1MtrySIkVLRP07jicuYuvhj9nCbzNN9vqEKnkKBU
 u8jg==
X-Gm-Message-State: AOJu0Yxsurp/qyOd09jka75LyI/XxL9CvwYJS2kUl6U28q9ZsVR7mW9+
 RP8eD9+58T5mRFuC6kD6+ECV52pdKeL1lxIP94FLJmzHb74H0aSbjPpH+S0KlbBy7YtFhe4L5p8
 iLXpY
X-Google-Smtp-Source: AGHT+IHGySZ1YF/M4e1dBKrz3WWsNPzv6IQz95sfcfAKTyVUdreNG3GqihQTwXkPXwnaVMf/C086ew==
X-Received: by 2002:a05:6214:2dca:b0:6cb:ef34:9c00 with SMTP id
 6a1803df08f44-6d18568f24fmr413541936d6.12.1730576249154; 
 Sat, 02 Nov 2024 12:37:29 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/20] test: Drop test-trace.sh and common.sh
Date: Sat,  2 Nov 2024 13:36:48 -0600
Message-ID: <20241102193715.432529-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

The trace feature is now tested in CI so there is no need for these old
script. Also they don't work. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/common.sh           | 20 -------------
 test/trace/test-trace.sh | 64 ----------------------------------------
 2 files changed, 84 deletions(-)
 delete mode 100644 test/common.sh
 delete mode 100755 test/trace/test-trace.sh

diff --git a/test/common.sh b/test/common.sh
deleted file mode 100644
index 904d579b7bf..00000000000
--- a/test/common.sh
+++ /dev/null
@@ -1,20 +0,0 @@
-#!/bin/sh
-
-OUTPUT_DIR=sandbox
-
-fail() {
-	echo "Test failed: $1"
-	if [ -n ${tmp} ]; then
-		rm ${tmp}
-	fi
-	exit 1
-}
-
-build_uboot() {
-	echo "Build sandbox"
-	OPTS="O=${OUTPUT_DIR} $1"
-	NUM_CPUS=$(nproc)
-	echo ${OPTS}
-	make ${OPTS} sandbox_config
-	make ${OPTS} -s -j${NUM_CPUS}
-}
diff --git a/test/trace/test-trace.sh b/test/trace/test-trace.sh
deleted file mode 100755
index 5130b2bf017..00000000000
--- a/test/trace/test-trace.sh
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-# Copyright (c) 2013 The Chromium OS Authors.
-#
-
-# Simple test script for tracing with sandbox
-
-TRACE_OPT="FTRACE=1"
-
-BASE="$(dirname $0)/.."
-. $BASE/common.sh
-
-run_trace() {
-	echo "Run trace"
-	./${OUTPUT_DIR}/u-boot <<END
-trace stats
-hash sha256 0 10000
-trace pause
-trace stats
-hash sha256 0 10000
-trace stats
-trace resume
-hash sha256 0 10000
-trace pause
-trace stats
-reset
-END
-}
-
-check_results() {
-	echo "Check results"
-
-	# Expect sha256 to run 3 times, so we see the string 6 times
-	if [ $(grep -c sha256 ${tmp}) -ne 6 ]; then
-		fail "sha256 error"
-	fi
-
-	# 4 sets of results (output of 'trace stats')
-	if [ $(grep -c "traced function calls" ${tmp}) -ne 4 ]; then
-		fail "trace output error"
-	fi
-
-	# Check trace counts. We expect to see an increase in the number of
-	# traced function calls between each 'trace stats' command, except
-	# between calls 2 and 3, where tracing is paused.
-	# This code gets the sign of the difference between each number and
-	# its predecessor.
-	counts="$(tr -d ',\r' <${tmp} | awk \
-		'/traced function calls/ { diff = $1 - upto; upto = $1; \
-		printf "%d ", diff < 0 ? -1 : (diff > 0 ? 1 : 0)}')"
-
-	if [ "${counts}" != "1 1 0 1 " ]; then
-		fail "trace collection error: ${counts}"
-	fi
-}
-
-echo "Simple trace test / sanity check using sandbox"
-echo
-tmp="$(tempfile)"
-build_uboot "${TRACE_OPT}"
-run_trace >${tmp}
-check_results ${tmp}
-rm ${tmp}
-echo "Test passed"
-- 
2.43.0

