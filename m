Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C98C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4896A88C26;
	Fri,  2 Aug 2024 18:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pkgxHGz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB6F88BD6; Fri,  2 Aug 2024 18:28:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089A088BCE
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so55985905e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616116; x=1723220916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMkb7SL/DDbfLtLW+75LZ/1DcEyKuyLVqRNT5lzZ7kw=;
 b=pkgxHGz5uAPALtdgZNh+4nkcnguSgQB1oe/yGTLkHUsOu6x2m+8WeQxjEsPuxLfsY4
 f5mmVt4LU2UdK78SWuYJdB+Y3JNVy5ymyMqDEDcsNeiDvyzY8gNnB2849Sk1nn5L97Pv
 sKH5TsUFGmPT4HNRw8Es2UpxuHtejCCbw+TcM0dBb/1wKwCk7thkscn71K1VHrJgRjdg
 T2yOdoqERirmbrUNNJH+893yjk+K7lmQ0r8oO0E2cglMe/y9njTKuMI53mQfKcinmzeH
 39UiT7pBxqrBP3EICulygAzrZsqPn6N9uuxFl2i/whNgG7JUQBwJNLf/yZWmgejVZFMf
 CmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616116; x=1723220916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMkb7SL/DDbfLtLW+75LZ/1DcEyKuyLVqRNT5lzZ7kw=;
 b=FZOI7GCeCmI+mIe8lyfZf1XzkEQ1gA/lTxT1RwBfsJNY8UaVJXCBDqWWTdkWb20dvV
 leMEcXjNDZ2rJ/Cm750wrEfUqPfjsQf8ibA9uoAaaFzn5/qJj85++hz9wW80Tx+B1kif
 RlpVlL0BtJjENiM0aQ6ghEfnhWb9QkV79HfHL4PBl51ggydADoMC73fNi7ypDmkUub69
 4zDOXAQtYfgGFQaRPtYjxnI8v14PE2ZfWruY0RpuFoo4ldH01rOEYEaOFgjkfnMMk85G
 Wzkiv0Hx1FUXoZXXe++WD+LSWpVnlui4yt4q4qNtOHEFtODnSM3GTJ4148Zq4e/hOgdH
 WBnA==
X-Gm-Message-State: AOJu0YxVckXkwQiWCoWpuU18awtspLAF2L38XoH5D3heZ7VtmggElkdi
 B2mU5XtQMdexx2ljWGKYyO+lRsumdnU1bgZocLDhd1Jgh6jP0iPnuydgqsQOWxk4c0ahzW2ThVB
 q73+VrctR
X-Google-Smtp-Source: AGHT+IGB3HIjIl9dJiHbGwWrl/PUR6sS1cByTY1L2OZXW0cBOXq8J3CEVzzivETcqkbXHuP2bUVScg==
X-Received: by 2002:a05:600c:3ba9:b0:426:554a:e0bf with SMTP id
 5b1f17b1804b1-428e6b037fcmr25615305e9.16.1722616116165; 
 Fri, 02 Aug 2024 09:28:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v7 20/20] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Fri,  2 Aug 2024 18:26:47 +0200
Message-Id: <9f7967bf6342f056fc6976a69b0329603316d299.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

Add myself as a maintainer for the lwIP network stack integration code
and network commands. The library code itself (i.e., most files under
lib/lwip/ except README, Makefile and integration files in u-boot) is
unmodified from upstream and therefore does not need a maintainer.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2832345ab1..6c237c37feb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1343,6 +1343,17 @@ F:	drivers/net/
 F:	include/net.h
 F:	net/
 
+NETWORK (LWIP)
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/net-lwip.c
+F:	configs/qemu_arm64_lwip_defconfig
+F:	include/net-lwip.h
+F:	lib/lwip/Makefile
+F:	lib/lwip/README
+F:	lib/lwip/u-boot/
+F:	net-lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

