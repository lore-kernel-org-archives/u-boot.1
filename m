Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0140E677E8
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F175C892F4;
	Sat,  2 Nov 2024 20:37:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qt+REAZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355EF892E1; Sat,  2 Nov 2024 20:37:49 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AE589110
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso19591736d6.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576265; x=1731181065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0GwtbLdi7GHtoeYxv2wTBxahNtVQ4Fu2MNEv8JUNPA=;
 b=Qt+REAZOayvXDt923txTf6XbPVV0NjxQG2Rd3P48UYOcRC4Bexi//Uy8+htfqp3fJU
 GXE2yirvE5kbPFcoVdJ6aRQpPL6dmnPi7Aoli0IpEJUDHfY6K0eD6v8J5OoeblYgrK2t
 5x15a4ozTJ2HlCIGFFRgGYoyNCQ3X6yCRBfEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576265; x=1731181065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0GwtbLdi7GHtoeYxv2wTBxahNtVQ4Fu2MNEv8JUNPA=;
 b=c/H5KxvpcMGMouveGYnBwpj3AVPQ3oqY4HK15uWCSQUfzgs/pPDaXLk7pVyf3xRA1C
 QRrYaUHMA0bXnLKV7OpnBBtqXpiy9JrAbl6ATRyIXtruYXB7ZpCH5dQYTXf6GCe/yxNr
 Cg2+SnayHjXeCD7zJtHJVIQ65IrYRPRvJD7Bz2ncvtjUnMR6wAwl6n8zjXFBgYib9G0Z
 JNK6EJ/Gy+5U9BixiVYwlTHLbXfRZBDn49gCW7Tf3V4I6H9wARf27qg3G19ujEpFblt7
 Cl3HPm1M4JCbpK2x/uCRsj6qV2GT1erKHbPZSpuoaYGXC+uMi7S4/PwboWRT5BEAt2/C
 5nxw==
X-Gm-Message-State: AOJu0YzgNTZJ+vS4oeeuH5pYw994/SbNvt84DUSfACjQ1nZrpoosNk3S
 ockXrP/1/Qcj7zUXbzND1kmxQBFtuhJyl+Wyi3zWYJzalzBsjIdsTPRlkw3Bb9LtPokG+K855JF
 5ynaC
X-Google-Smtp-Source: AGHT+IEXvyDE4V/AGsfmOfQn77he5fXMOMDMVhTq3cE2h9nKxJfjfDsFStUyDj5Sbt6iHUVm7e+WNA==
X-Received: by 2002:a05:6214:4281:b0:6ce:2f4e:40f1 with SMTP id
 6a1803df08f44-6d351acdbaamr183177746d6.26.1730576265104; 
 Sat, 02 Nov 2024 12:37:45 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:37:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/20] test: Move print_ut test into common
Date: Sat,  2 Nov 2024 13:36:55 -0600
Message-ID: <20241102193715.432529-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the common/
directory, to match its implementation. Rename it to drop the
unnecessary _ut suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/Makefile                       | 1 -
 test/common/Makefile                | 1 +
 test/{print_ut.c => common/print.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{print_ut.c => common/print.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index 4366e495a15..9f19bfa472b 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -14,7 +14,6 @@ endif
 ifneq ($(CONFIG_HUSH_PARSER),)
 obj-$(CONFIG_$(XPL_)CMDLINE) += hush/
 endif
-obj-$(CONFIG_$(XPL_)CMDLINE) += print_ut.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
diff --git a/test/common/Makefile b/test/common/Makefile
index b6bff9201ec..53c4f16164d 100644
--- a/test/common/Makefile
+++ b/test/common/Makefile
@@ -7,3 +7,4 @@ endif
 obj-$(CONFIG_CYCLIC) += cyclic.o
 obj-$(CONFIG_EVENT_DYNAMIC) += event.o
 obj-y += cread.o
+obj-$(CONFIG_$(XPL_)CMDLINE) += print.o
diff --git a/test/print_ut.c b/test/common/print.c
similarity index 100%
rename from test/print_ut.c
rename to test/common/print.c
-- 
2.43.0

