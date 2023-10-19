Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9392CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217AC87073;
	Thu, 19 Oct 2023 15:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=48.io header.i=@48.io header.b="mXezH3BE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BAD78707C; Thu, 19 Oct 2023 15:04:39 +0200 (CEST)
Received: from pruto.48.io (48.io [IPv6:2a01:430:17:1::ffff:361])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4221887056
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=srk@48.io
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by pruto.48.io (Postfix) with ESMTPSA id 83E261A6BEE;
 Thu, 19 Oct 2023 15:04:36 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 83E261A6BEE
Authentication-Results: pruto.48.io;
 dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
 t=1697720676; bh=r/kp+DfeZUVfS6qc9oYJF8LnzT2W/w3OnxsfAYZdNNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mXezH3BEFBxWP+jmQnTTJcpT0zph6P+KCfPnf+p56/bBUnvYIXIPcCdIDxLOju8Zs
 Sw6lS5zU6w3STFB/YCeGRukLMtub5vqBWDvZb1FO3Ut0AslnMpDVPY/TDHWCQYK+U5
 471nVnio36oYUZL/ZgriDDT5YkJcQxj1vBPvp8Yc=
From: Richard Marko <srk@48.io>
To: u-boot@lists.denx.de
Cc: rasmus.villemoes@prevas.dk,
	Richard Marko <srk@48.io>
Subject: [PATCH v2] make: check if DTC variable is an absolute path
Date: Thu, 19 Oct 2023 15:04:12 +0200
Message-ID: <20231019130412.617507-1-srk@48.io>
In-Reply-To: <20231017104453.2121276-1-srk@48.io>
References: <20231017104453.2121276-1-srk@48.io>
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

If we try to build using external dtc using

> make DTC=dtc

we get a confusing error like

> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
> needed by 'dtbs'.  Stop.

Workaround is to use

> make DTC=$( which dtc )

which gives make a full path, so the dependency
is satisfied.

This was introduced by commit d50af66
kbuild: add dtc as dependency on .dtb file

This patch checks that DTC is an absolute path
and fails early if not.

We also replace `which` in `scripts/dtc-version.sh`
with POSIXy `command -v`.

Signed-off-by: Richard Marko <srk@48.io>
---
 Makefile               | 21 +++++++++++++--------
 scripts/dtc-version.sh |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index b204a50043..9649f88722 100644
--- a/Makefile
+++ b/Makefile
@@ -2014,18 +2014,23 @@ scripts_dtc: scripts_basic
 	$(Q)if test "$(DTC)" = "$(DTC_INTREE)"; then \
 		$(MAKE) $(build)=scripts/dtc; \
 	else \
-		if ! $(DTC) -v >/dev/null; then \
-			echo '*** Failed to check dtc version: $(DTC)'; \
+		if [ ! "$(DTC)" = "$(wildcard $(DTC))" ]; then \
+			echo "*** DTC is not an absolute path"; \
 			false; \
 		else \
-			if test "$(call dtc-version)" -lt $(DTC_MIN_VERSION); then \
-				echo '*** Your dtc is too old, please upgrade to dtc $(DTC_MIN_VERSION) or newer'; \
+			if ! $(DTC) -v >/dev/null; then \
+				echo '*** Failed to check dtc version: $(DTC)'; \
 				false; \
 			else \
-				if [ -n "$(CONFIG_PYLIBFDT)" ]; then \
-					if ! echo "import libfdt" | $(PYTHON3) 2>/dev/null; then \
-						echo '*** pylibfdt does not seem to be available with $(PYTHON3)'; \
-						false; \
+				if test "$(call dtc-version)" -lt $(DTC_MIN_VERSION); then \
+					echo '*** Your dtc is too old, please upgrade to dtc $(DTC_MIN_VERSION) or newer'; \
+					false; \
+				else \
+					if [ -n "$(CONFIG_PYLIBFDT)" ]; then \
+						if ! echo "import libfdt" | $(PYTHON3) 2>/dev/null; then \
+							echo '*** pylibfdt does not seem to be available with $(PYTHON3)'; \
+							false; \
+						fi; \
 					fi; \
 				fi; \
 			fi; \
diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
index 53ff868bcd..1e2f0c8a8b 100755
--- a/scripts/dtc-version.sh
+++ b/scripts/dtc-version.sh
@@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
 	exit 1
 fi
 
-if ! which $dtc >/dev/null ; then
+if ! command -v $dtc >/dev/null ; then
 	echo "Error: Cannot find dtc: $dtc"
 	exit 1
 fi
-- 
2.42.0

