Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BBEC87FCB
	for <u-boot@archiver.kernel.org>; Sat,  2 Aug 2025 00:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E43383BCE;
	Sat,  2 Aug 2025 02:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=ixit.cz header.i=@ixit.cz header.b="RygF6B6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E89683C02; Sat,  2 Aug 2025 02:14:06 +0200 (CEST)
Received: from ixit.cz (ip-94-112-25-9.bb.vodafone.cz [94.112.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F93383B86
 for <u-boot@lists.denx.de>; Sat,  2 Aug 2025 02:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=david@ixit.cz
Received: from newone.lan (unknown [10.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id 11CAF160F0D;
 Sat,  2 Aug 2025 02:14:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1754093644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t8v2dOum9cQNMX42Vy39ml8VT3mW5jFIpmw7cXlv9U=;
 b=RygF6B6xUXqVhgfrv8xl3YXLQIB5JOaKZrxrOeLEGglcmsyFGzU+Plyif7t7+C/P36bfzm
 K2mWDpwIgvz+8DhToTMYiU0Gt3alNse2TauBSt2BABgj1wepWoB3M++ZZyJvtYdpcXV7Qg
 R8CYz9xY/ZonvlFkroQz5dDE5skvM7Q=
From: David Heidelberg <david@ixit.cz>
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 David Heidelberg <david@ixit.cz>
Cc: u-boot-qcom@groups.io,
	u-boot@lists.denx.de
Subject: [RFC PATCH v2 2/2] configs: Add google-pixel3 fragment config for
 Pixel 3 / 3 XL
Date: Sat,  2 Aug 2025 02:13:57 +0200
Message-ID: <20250802001359.2122103-2-david@ixit.cz>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250802001359.2122103-1-david@ixit.cz>
References: <20250802001359.2122103-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Introduce a fragment config for the Pixel 3 and Pixel 3 XL.

On these devices, U-Boot must be chainloaded via Fastboot. However, due to
a Fastboot bug, U-Boot won’t start unless a specific condition is met.

To work around this, U-Boot must provide a TEXT_OFFSET of 0x00080000,
which allows Fastboot to successfully launch U-Boot.

Instead of:
$ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig qcom-phone.config
do
$ make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig google-pixel3.config qcom-phone.config

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 board/qualcomm/google-pixel3.config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 board/qualcomm/google-pixel3.config

diff --git a/board/qualcomm/google-pixel3.config b/board/qualcomm/google-pixel3.config
new file mode 100644
index 00000000000..2dc71c65d23
--- /dev/null
+++ b/board/qualcomm/google-pixel3.config
@@ -0,0 +1,3 @@
+# Pixel 3 (blueline) and Pixel 3 XL (crosshatch) will fail to
+# chainload u-boot on the Q or R bootloader if TEXT_BASE offset is missing.
+CONFIG_TEXT_BASE=0x80080000
-- 
2.50.1

