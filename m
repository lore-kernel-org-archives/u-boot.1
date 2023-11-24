Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AB0C61DF4
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 14:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93310875EE;
	Fri, 24 Nov 2023 15:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700834695;
	bh=5XtfQnX27as1C0+Yke6fWGh7Zvl9z2MTuVoZXGQkxAY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dQTjxptb2AU3j2o8pm9pl6Q/tGtkQMXKZEwNUslI8NMbJuQ9Sm50meHgErU83UMEs
	 zxksOnjbP21E25/O7GtjgQ1iM+EhlXjyLdsTPVNsZTw6zpo2UJ0oC2KUNKnE0PcKpD
	 0F/bCe+GN/GwcHxqNt/94ZjMRipJH8IJue+J3BS78r/RGkW4TDkzdMQylHeRKiHzrt
	 Vu2UQFe4aL7KRTwywq9uKJ8o0heXhO/CyrUETnsB+fI8qCgGqkiXGEfbpMxXQDvo4G
	 3GlrmN+nxHyPXRML5BJPcsUB8s6r67K+XkfQe+p+MVqbO5+Hf5lky3L/9cMkkLnw8N
	 kUraW6OvmwZIQ==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:90fa:3f82:fe6a:48f9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 731368711E;
 Fri, 24 Nov 2023 15:04:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700834693;
 bh=5XtfQnX27as1C0+Yke6fWGh7Zvl9z2MTuVoZXGQkxAY=;
 h=From:To:Cc:Subject:Date:From;
 b=BU30aKP+Yu9w8lUKodFicpVAI+jG/hgIsZDB5ibVSxz7pakEGEUgyfZhBbOTDVXyt
 ZMTyS8nhksKFQtjcOLkSb4tk5ZKhHKHK33l3dJkEqbXZoLYWliSJPVI6DNXDK6Lqyz
 rtmmntPtoYTRs1RcXM2WTNIZzZPRlTAPvRZicx+9EKjqRoQRPd20fzLyH/rqqFp0SZ
 s7fzIFR0pW1KnWjIPakErSvVqZNx83kbUMv6DUmQYehzlrk/S/lil7HmdNTzryqOQz
 LMCljcXdELSuqfmVFfZnclXxGPmIKqCz72FZyz6zfmiF/rPYcDF9lQ76Y4yOi9A3Ce
 fLgJLKjZ6NToQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 1/1] i2c: Bugfix in i2c_get_chip_by_phandle()
Date: Fri, 24 Nov 2023 15:04:01 +0100
Message-Id: <20231124140400.32027-1-pro@denx.de>
X-Mailer: git-send-email 2.39.2
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

The "i2cbcdev" sneaked in when implementing this function for the
bootcounter use case. Obviously the intention was to use prop_name
instead.

Fixes: b483552773 (i2c: Implement i2c_get_chip_by_phandle())

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---
 drivers/i2c/i2c-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
index d0db25dcc0..3cbd4a81a5 100644
--- a/drivers/i2c/i2c-uclass.c
+++ b/drivers/i2c/i2c-uclass.c
@@ -428,7 +428,7 @@ int i2c_get_chip_by_phandle(const struct udevice *parent, const char *prop_name,
 		goto err_exit;
 	}
 
-	ret = dev_read_u32(parent, "i2cbcdev", &phandle);
+	ret = dev_read_u32(parent, prop_name, &phandle);
 	if (ret)
 		goto err_exit;
 
-- 
2.39.2

