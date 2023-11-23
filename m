Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C65C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DC08768F;
	Thu, 23 Nov 2023 16:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE608768C; Thu, 23 Nov 2023 16:10:33 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C31587680
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA1BCE0008;
 Thu, 23 Nov 2023 15:10:29 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH next v2 5/6] env: migrate env_get_default to call
 env_get_default_into
Date: Thu, 23 Nov 2023 16:10:09 +0100
Message-ID: <20231123-env_default_theobroma-v2-5-a80914c2c114@theobroma-systems.com>
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

Since both functions share a similar goal and env_get_default_into can
do what env_get_default wants to do with specific arguments, let's make
env_get_default call env_get_default_into so as to avoid code
duplication.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 env/common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/env/common.c b/env/common.c
index 307003099dd..930bdef2f58 100644
--- a/env/common.c
+++ b/env/common.c
@@ -246,9 +246,11 @@ bool env_get_autostart(void)
  */
 char *env_get_default(const char *name)
 {
-	if (env_get_from_linear(default_environment, name,
-				(char *)(gd->env_buf),
-				sizeof(gd->env_buf)) >= 0)
+	int ret;
+
+	ret = env_get_default_into(name, (char *)(gd->env_buf),
+				   sizeof(gd->env_buf));
+	if (ret >= 0)
 		return (char *)(gd->env_buf);
 
 	return NULL;

-- 
2.42.0

