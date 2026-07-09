Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA2C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 23:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8025884BFC;
	Fri, 10 Jul 2026 01:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sbrwpgqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA50D84C1D; Fri, 10 Jul 2026 01:17:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A449D84BF4
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 01:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783639027;
 bh=7gt9o+kMV48P6fjLe7y3l2QQNKA1ghRY46NuCDMisrg=;
 b=sbrwpgqVyINpMRsM3hoFKJRwEkD7ZlhPBzUmcWQsx5gY1TGPLj7TlnGk3kkD00CV0uKmH96+1
 1ZY7lzGeoukrNWKG3ks3C4FwyMBMj9I4TnSTvvpXFtzvHNS3S8V3RXOlVHY8ofj5qwzTTOtq8C2
 mLqC8rLINQuP8IeIxwcHG9Tfq1qDknamgQHUJ/ON3c2LFSoWemSlO/KkzkpLex+9K8FZau0ByPW
 3OxYZMEEm3EM4Ck1FBZattTzm0ByVIZiX0vx9SNb5bj58oA6DUZwBrtQHhvQf+1ejMGziZP4VXO
 qCpuCOmEaJZtRSND+eEA3E12xe6sUAo59kaBIWqyPSkg==
X-Forward-Email-ID: 6a502bef4bb7c705dd8c4c4e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] power: regulator: Fix regulator_enable/disable() macros
Date: Thu,  9 Jul 2026 23:16:58 +0000
Message-ID: <20260709231658.3517139-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

The commit 076265b75e61 ("compat: regulator: add enable/disable macros")
added regulator_enable/disable() macros to provide a closer analogue to
the Linux API.

These new macros wrap regulator_set_enable() that may return detailed
error codes and should typically not directly be called by drivers.

Change the macros to wrap regulator_set_enable_if_allowed() that masks
error codes consumers typically do not expect to closer match the
behavior of the Linux API.

Fixes: 076265b75e61 ("compat: regulator: add enable/disable macros")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 include/power/regulator.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/power/regulator.h b/include/power/regulator.h
index b8023721a165..ea79e0240b2b 100644
--- a/include/power/regulator.h
+++ b/include/power/regulator.h
@@ -371,9 +371,6 @@ int regulator_get_enable(struct udevice *dev);
  */
 int regulator_set_enable(struct udevice *dev, bool enable);
 
-#define regulator_enable(dev) regulator_set_enable(dev, true)
-#define regulator_disable(dev) regulator_set_enable(dev, false)
-
 /**
  * regulator_set_enable_if_allowed: set regulator enable state if allowed by
  *					regulator
@@ -385,6 +382,9 @@ int regulator_set_enable(struct udevice *dev, bool enable);
  */
 int regulator_set_enable_if_allowed(struct udevice *dev, bool enable);
 
+#define regulator_enable(dev) regulator_set_enable_if_allowed(dev, true)
+#define regulator_disable(dev) regulator_set_enable_if_allowed(dev, false)
+
 /**
  * regulator_set_suspend_enable: set regulator suspend enable state
  *
-- 
2.54.0

