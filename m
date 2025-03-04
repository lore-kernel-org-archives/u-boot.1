Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66121C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 20:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3993807D9;
	Tue,  4 Mar 2025 21:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b5cdakzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D4FE80805; Tue,  4 Mar 2025 21:24:58 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A0D805C3
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 21:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e60a35eb84fso4286748276.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741119879; x=1741724679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=03HyXB/n/rqYwBgugI1QU3ZxBphSeBGy7YzI9RVWEp0=;
 b=b5cdakzA2yI5hURkTEiT3+4zd5vyBHUv3qawwD6nOFouut1EDXe+ccd+Dg99hsv8+P
 DFgbGIiRjdTrdCmiwoNAFd3ze8cEcW7mPzx50KeWwNo1tDY1AIVkE5xqrPwAndYzaIvP
 3qYTdqXEVD+eZMSw5E/ZBTqmdT1WeTYlRi0RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741119879; x=1741724679;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=03HyXB/n/rqYwBgugI1QU3ZxBphSeBGy7YzI9RVWEp0=;
 b=HCo9QEbgBDHVI/UsY5z+oXo36m/FKAL698GWUWA1ASKBMbk3MRfdbcItaUPRSBKRiv
 Yq9u15orUGt4whWewA/2SVs5sdL8XY7cpSUzpEA6ZWxrZoVUt0vfChpWMvUHG4KlcgRZ
 rHWWMEefX0g4J6wKYIPA6HvqyavRe6NFfE3Yks/d5NtHJMFp3i2gb+OfXRaWRE/gCFje
 Xxt5N1P6yqTLw+XI9GGHL+Iu+6VSlt68KSdhOkfkoNsY1Wzv32SBwzlhTrOkEqHqkHyA
 8iCWiWle3qiXKJ3BiMqYE3qcYM4MKFbi9J9zZGbY6jlV5u6DlLIb6ctDXzG0VXkxNd2M
 fQwQ==
X-Gm-Message-State: AOJu0YyyIKIT734+4vZTT0FOKpEsQtvi6o9Fn9dG6npInBdG+HFBs/Zh
 DXSsNtlEn8YLSnwkUkmbo1PhzxrAwgTGCX0XAtRGr67I/rLxKQXTkC41NUy9v67Ke1yHVxTs/N2
 i
X-Gm-Gg: ASbGncsYS7RCalMQa+bs/5vnDAgk2EQCKJDnwN/9730yL8F+ahAjwJFvYyHmxWjAcTM
 SW7SSpZjjRhR3boIJkZYu/wjS33RQwfpXJE9m1HpIg4UnkrbhZJNilYZx/fRrGUgZzR5vxB2AjN
 COYvClVy7TVaFdlMde9NdT/QE2XIPlbFRgqGYhtkdTSU1/kw0DhkDV8pLH1zNsOI1u0O4+mbigB
 2JI5BG7edJN3sNr2RLcD11j+gMBNNCU4slqTambUcjPpeP4lS5jtk6UWMo6g7sRhdH4k75WCNbu
 fY2GvB8lldXnPh2ytSXzdDKKDuCoK733fqj8NYKbN421GQ==
X-Google-Smtp-Source: AGHT+IE0jU7Vv09cArCgF+DC9Q+6rbnfJ927AlK5gfSSqKhJzc0LM06GIbqkfg4voj3+Gyr+1sEBcw==
X-Received: by 2002:a05:6902:1029:b0:e60:9fd4:bdb9 with SMTP id
 3f1490d57ef6-e611e333006mr651863276.44.1741119879188; 
 Tue, 04 Mar 2025 12:24:39 -0800 (PST)
Received: from bill-the-cat.. ([189.177.125.6])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e6119a83de8sm268524276.16.2025.03.04.12.24.38
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 12:24:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] serial: Add missing TPL_SYS_NS16550_SERIAL symbol
Date: Tue,  4 Mar 2025 14:24:36 -0600
Message-ID: <20250304202436.2783784-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

On PowerPC platforms with TPL enabled and SPL_SYS_NS16550_SERIAL
enabled, today this builds under TPL as well due to how $(XPL_) is
defined. Add the TPL_SYS_NS16550_SERIAL itself for consistency and
clarity.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/serial/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index c4f4a8d78df1..84130524c2de 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -789,6 +789,12 @@ config SPL_SYS_NS16550_SERIAL
 	default y if SYS_NS16550_SERIAL || ARCH_SUNXI || ARCH_OMAP2PLUS
 	select SYS_NS16550
 
+config TPL_SYS_NS16550_SERIAL
+	bool "NS16550 UART or compatible legacy driver in TPL"
+	depends on TPL && !TPL_DM_SERIAL
+	default y if SPL_SYS_NS16550_SERIAL
+	select SYS_NS16550
+
 config SYS_NS16550
 	bool "NS16550 UART or compatible"
 	help
-- 
2.43.0

