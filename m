Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DAC61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C35887657;
	Thu, 23 Nov 2023 16:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F5787686; Thu, 23 Nov 2023 16:10:33 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07B28760A
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF54FE0005;
 Thu, 23 Nov 2023 15:10:28 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH next v2 4/6] env: allow to copy value from default environment
 into a buffer
Date: Thu, 23 Nov 2023 16:10:08 +0100
Message-ID: <20231123-env_default_theobroma-v2-4-a80914c2c114@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
References: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

env_get_default suffers from a particular issue int that it can only
return a value truncated to gd->env_buf (32) characters. This may be
enough for most variables but it isn't for others, so let's allow users
to provide a preallocated buffer to copy the value into instead,
allowing for more control, though it'll still be truncated if the value
size is bigger than the preallocated buffer.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 env/common.c  |  8 ++++++++
 include/env.h | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/env/common.c b/env/common.c
index eb1a9137953..307003099dd 100644
--- a/env/common.c
+++ b/env/common.c
@@ -254,6 +254,14 @@ char *env_get_default(const char *name)
 	return NULL;
 }
 
+/*
+ * Look up the variable from the default environment and store its value in buf
+ */
+int env_get_default_into(const char *name, char *buf, unsigned int len)
+{
+	return env_get_from_linear(default_environment, name, buf, len);
+}
+
 void env_set_default(const char *s, int flags)
 {
 	if (s) {
diff --git a/include/env.h b/include/env.h
index 430c4fa94a4..9a406de3781 100644
--- a/include/env.h
+++ b/include/env.h
@@ -348,6 +348,16 @@ int env_import_redund(const char *buf1, int buf1_read_fail,
  */
 char *env_get_default(const char *name);
 
+/**
+ * env_get_default_into() - Look up a variable from the default environment and
+ * copy its value in buf.
+ *
+ * @name: Variable to look up
+ * Return: actual length of the variable value excluding the terminating
+ *	NULL-byte, or -1 if the variable is not found
+ */
+int env_get_default_into(const char *name, char *buf, unsigned int len);
+
 /* [re]set to the default environment */
 void env_set_default(const char *s, int flags);
 

-- 
2.42.0

