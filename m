Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2E7EE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A011488E97;
	Thu, 12 Sep 2024 09:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="deHLcoT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245EB88E9E; Thu, 12 Sep 2024 09:30:18 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8A288E98
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso4788035e9.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726126214; x=1726731014;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cZlGVGGm+H4X1C2NZFfTjYRXZPRA7EEe0migMMEmX5U=;
 b=deHLcoT4BRl5ylKH4UXHYJ0OJ/JPLUMFydIyquDYE4FJpzRi6HtsbNQJHg6QqfiZ2R
 qCyfbrM+e0TrYcOkxORIXA8iPIAnM2UfQ3oBATWFG/tRDoy/UVHgVp70akxpyNp7S+Vn
 jftftPSBsNPhwNdgqfa17EErSMT/Fk+h1hbSqU6/Xabhy0Hg+WZJA2m6I3QnneQLDWrh
 4/BMIvHzmqX6dDe8OmF762lULEDzv/yZha4pY9vHpF4zfC96r6YOuh0YZIwewOgs/+ix
 6jOc0PPIthLVsiPiL9Owon0H46zKcUm2Vw5F2kiEflphTID/pmibA1UKVnm627udS52w
 WWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126214; x=1726731014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZlGVGGm+H4X1C2NZFfTjYRXZPRA7EEe0migMMEmX5U=;
 b=MGJ/saGN2ddZ+mi4ANkSs8TwXOqC8RYLFY/sT+oWaF2LWWKN/DaWy6JGdCh685INuW
 daawti9LU8eoDPxAvUf6B0XIL++yqm/Pj+1MU7BKZa4bl3kepG7bAP3wwR+tjJ0NicD7
 2qpbCinrVVAQLqy9L8G9Ot1Vcu7X2VVKrlA9rcVa4p/+mIzgny5i7DOBJ7DMfceO8efB
 XhpMLfcTqXBxn6zZrhVr/DBLR/DhgCv6LOK50y4azhaBkCb1HNhGG3eZ/UPjCg8CAgSU
 M5bbLrZbXGtQEKT2C/R591dJEATaGqNrYpKCB4c72IZM1zUpSa8Oal3HoPkzjYk8R6Wa
 B65Q==
X-Gm-Message-State: AOJu0YzXEoSWQ1hG62N6JjMtk5pcjOYxx0afV0miCJzbn2id1oHdIEex
 GS4Jjpg2XWVxuAvyoman0X8e+ABNZHg4OY1dvCb6z0fX+7vdbpLr2S6zcmzDDy8=
X-Google-Smtp-Source: AGHT+IFev28kC691MeUaOOy6GJui3WMiGmvyvL4F2crLthSWFW+XXBtRdkyUoP0YGaSWr8MnVQlSRg==
X-Received: by 2002:a05:600c:3581:b0:42c:ba0d:c766 with SMTP id
 5b1f17b1804b1-42cdb531ce0mr12135435e9.6.1726126214324; 
 Thu, 12 Sep 2024 00:30:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:ce21:4d2b:8554:e76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a5csm164330065e9.6.2024.09.12.00.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:30:14 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 12 Sep 2024 09:29:59 +0200
Subject: [PATCH v2 3/3] board: ti: am62px: Add android bootflow support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sitaraupstream-v2-3-2101323d3fa5@baylibre.com>
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
In-Reply-To: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

When CONFIG_BOOTMETH_ANDROID is set, enable Android boot flow support.

To build for AM62Px for Android, we can re-use
the am62x_a53_android.config fragment when building A53 bootloaders:

  $ make am62px_evm_a53_defconfig
  $ make am62x_a53_android.config
  $ make

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/ti/am62px/am62px.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
index f8b6aff2c2fd..7ef54079aa8d 100644
--- a/board/ti/am62px/am62px.env
+++ b/board/ti/am62px/am62px.env
@@ -13,3 +13,8 @@ mmcdev=1
 bootpart=1:2
 bootdir=/boot
 rd_spec=-
+
+#if CONFIG_BOOTMETH_ANDROID
+#include <env/ti/android.env>
+adtb_idx=3
+#endif
\ No newline at end of file

-- 
2.34.1

