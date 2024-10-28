Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A36D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AE7890D0;
	Mon, 28 Oct 2024 13:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jvMsaI8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226DA890A7; Mon, 28 Oct 2024 13:41:45 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1736A890BB
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso6985368e87.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119302; x=1730724102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0deI9Q+O/aTaU0UL5XrpvvCu2Kr0SPLOggXowSkeLSE=;
 b=jvMsaI8jJ1tzClvD4Pz1ZxbAuxsHI2DtYpfUhN3arPTAeSN//Fq6aRCCniDG4Son0w
 KLa/LhatObwS2bkd5hBxwjdqSf6+ZYvMJMwYJ4QyOEbBpA7CQlU+oqUy3if32CbDJkcg
 no43UoorCzYUUedHx6EUGfMw4JymKiRHMJjQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119302; x=1730724102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0deI9Q+O/aTaU0UL5XrpvvCu2Kr0SPLOggXowSkeLSE=;
 b=DEkq32uiTr7oZlSbX3h/JEtz7W23or2gBaAvRqcdEyymkKWbhBUagDlDLmwAIvlcbv
 +q4IDAz1RgDztAA8ckxcIdku+43TRPfjYa+0fcpDKu7IKj4mxXMJ0TmZX5a7h3CFhzPe
 lqJYUAL5pmX1lEfT8Vle4ABNWTw3vivnQyDEskbEtMxC1LY8toFz3LtkGhBRBMlZLJxZ
 kn5KaIxxd1XZiMkMJwFMGbGYBxALaTj2NJxsVseLzC4apRXneBDW/QT2kys8IIdRn3u7
 ph/UWoD/j4PI6zhsNFtonLswchsYYKdVTrBNKviLgoM61zJI8hTexGAiat6QzYqTC/NH
 /LDQ==
X-Gm-Message-State: AOJu0YymZn4zabYgbWqqhczY1RdpUZVNgDinOKg1B2TW+g6Asn8fWf7M
 zHfKoP19+1XqFNmPWHW2OjzC9fd8+Q4Y81ev0x/xDGKGOHMoKu7SqwgoRlVM2Qczs/tNcsxIINx
 jGQ==
X-Google-Smtp-Source: AGHT+IH+t0iW8cpxyjPsWMjoYfPYihk0yfa5Ij3c5H6PeTYabnUERcGS98IEzdLgfCsnsOFfZR1AXQ==
X-Received: by 2002:a05:6512:b82:b0:53b:154c:f75d with SMTP id
 2adb3069b0e04-53b348dc826mr6124733e87.31.1730119301829; 
 Mon, 28 Oct 2024 05:41:41 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/21] test: Drop test-trace.sh and common.sh
Date: Mon, 28 Oct 2024 13:41:09 +0100
Message-ID: <20241028124130.32072-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

