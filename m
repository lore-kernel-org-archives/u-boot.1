Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECDFCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 09:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5237846E1;
	Wed, 20 May 2026 11:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4o68ZlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DAA846EC; Wed, 20 May 2026 11:14:35 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A14846DD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 11:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b150559bso35300775e9.1
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779268473; x=1779873273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIC1rMnfycjd/QXyJOz1PIACtqAIsB+eoAUfpcuEmtk=;
 b=D4o68ZlNx5xq6aNnVe5tEHyjOas4v1NVPfSvdW1klwHD1kzOutqYb8EOelu+Ub4Hvg
 O42PT9vbacUwRjS5IfLcJp0OYfPuIJf3PlGPWVm+NDyv0vF6mGHKwJNMr2ziOz12M+j3
 /eEZ3L8m3Nx+4Mxh6QhfNwyZXWXN+mDpgTbYeZq8UXfspLUwdnQll/Lgz+CDhfhRxT4H
 nmQROtO9U/g7jgsVxmNRg/Af2GJIXrkbqX7u39P6MJ+QanqKMiQ6OuNFvqItZQrxzGh5
 9P5l+2XI8QVziJuhD6QxKjQ1v8bON0eBrZccd60g+tgfqovdvqxHiPWIQKGKGv/324kd
 wsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779268473; x=1779873273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gIC1rMnfycjd/QXyJOz1PIACtqAIsB+eoAUfpcuEmtk=;
 b=jwDt5zs4dCLN7ES24g2xiGCFUc53UYschYX2tlwgyK6Wj5YY67cMHq+Qb7iN1q+nMX
 ElkxyQbbDQB/AmnM9VEFQaia0CcUYs5iukCvIIfbNx0Ee4V0jpOfyF1fO4SEyBXEg6m9
 e9QikMhByzNVit/8mwFvopddm4utexE+FB8SbLoyRbdCByMkxtZxJe2I/0HNTRuPaptL
 xLwk9qcqHycz03SPOiwvdW+E0OlRaGS4i5rWGFmlHX25li7xlQtD03KyqG3qb13dR3OY
 eP3msAPj5HwjAJdpNpwFkm9Npp4f+uuu4BhuwniRqlG+s48ebZlMfLe718N/CIR3JQJM
 7Qiw==
X-Gm-Message-State: AOJu0YxYCO+edcWwaFjX16SD/cwIX/ye2cQM92zc1vlvUIuYq4az9pWs
 MvUCYzkN9Wx7pQ3zhGv3JEVke2Y7DyRX+v+9cwaLpfydvaA2Wx1rjaCe
X-Gm-Gg: Acq92OEyJKOcyaOZjWbqZZe0mij6sresUyYihwcSZ0gWC4I33bEbx56Clotg72ShlPe
 MDo8UGQ3ntvzeopbgzYFcvd9eAuHnW/7SAwlQWDVr59cXlaFO2YszSkxzUrDDqK0zeT48foTjbF
 MvhUHYxVDOdNqbsbhIFg29X+W9lCPJENVkX4u3uUXN/amoWsAZeQCtiwgMwLLznaTqt2XT2pJLl
 wtWs5dv1xZV5am0GBIrWGl2ybHjjdmWsN2hwIXyxzQZBXac1HqGeSLKuJWUiqEO/Q6SleMLscSn
 pMyWcbpRTLNq9Mau6uz2+gqzpcvCJ7Q/N1g7E4+6PQeqDFhCcYi9B3WVKof5tHXgbejP6E6gtyY
 6G1m4v0/cU1f275VvUgIf5fjGGdbRsMK6W9jy0U2NFRZKpIEmf8J4PsvP2sGzyrG0HQVE1RKiLK
 ZCHkNIFrO9A0u5
X-Received: by 2002:a05:600c:4e46:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48fe632243cmr375236485e9.22.1779268473194; 
 Wed, 20 May 2026 02:14:33 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767ee0sm49115745f8f.1.2026.05.20.02.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:14:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] video: bridge: tc358768: Add delay after PLL init
Date: Wed, 20 May 2026 12:14:23 +0300
Message-ID: <20260520091423.45001-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520091423.45001-1-clamor95@gmail.com>
References: <20260520091423.45001-1-clamor95@gmail.com>
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

After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
up, the downstream DSI register sequence runs immediately. On TF700T this
results in the bridge claiming PLL lock but producing no DSI video output:
the panel powers up, the backlight comes on, but the framebuffer is never
scanned out.

Insert a small settling delay between PLL setup and the rest of the attach.

Suggested-by: Michele Brocco <brocco@perceptos.de>
Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/tc358768.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/bridge/tc358768.c b/drivers/video/bridge/tc358768.c
index 358004f30f2..9fa9631fdcc 100644
--- a/drivers/video/bridge/tc358768.c
+++ b/drivers/video/bridge/tc358768.c
@@ -488,6 +488,9 @@ static int tc358768_attach(struct udevice *dev)
 
 	tc358768_setup_pll(dev);
 
+	/* Allow the PLL to settle */
+	mdelay(20);
+
 	dsiclk = priv->dsiclk;
 	hsbyteclk = dsiclk / 4;
 
-- 
2.51.0

