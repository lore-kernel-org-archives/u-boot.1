Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76886C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEF284197;
	Fri, 11 Apr 2025 17:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="actg2gtP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 679B384003; Fri, 11 Apr 2025 17:30:58 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 612DA840D5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a823036so21651255e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385456; x=1744990256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWUkHyYtXKAVxk5o1dsv/C0f7Tt7qzeAo8bJPCjh5jU=;
 b=actg2gtPhn4mNarWET+3MAu4krBXHCHKegJzRLQo9ihTqi1F5XUFzs9anykxUxJzJg
 SZNyDp4zdbDD581MdWbv3pXcwwPkgvBFLHbbLCt/aM0JPn49wC+xLJqPRDv7LJjTxme7
 dSLa7rwOpiuiKu5yV7eu8BWrA2H4MQ7/XUm+/xiByPyeREkvKsRSZv+D6zRl9jYevm5m
 e/6VGahdXTwHpWfiidAItTr/k46FI4tygcmGqEqk/KBbSH7sVFShRsX3HKXhmj4BdBLu
 QEkhs4sHPY/V9/7rmNb7QfoyJJrf7edwd+om5QTGHpbz/F7mEgCnY0bKrG7yXiBDeTOK
 0qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385456; x=1744990256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWUkHyYtXKAVxk5o1dsv/C0f7Tt7qzeAo8bJPCjh5jU=;
 b=p1TIxQdsXF57Qf2nkg9j4SvGV4SE0N8FLpoQOzkqLcZba4+cs6XiDLTXD/G74MEtmV
 30qBMtjuEslXxlUGrzSmFPcvzp6kEjCKZ1rX890M99z3cVvQR3UsOi+UMd1HvtrAoitl
 jGgORaW15aZ++pyW7GoNyHhh6SPqnKFCkL41JU1n5/fWIERpUPlmKbNMhhtq3zcy1Day
 AjuY63sJOJcxO3mv+v8DnMNfv2tqK/JOLTEFKWRUcaXITt9SQOx9HnWs3NpiqpQChOZP
 FgbqDw7rRtPkv3UjzDRFcTOND9GOHnnk6l3GZCWI524wgbRwHKaBCH6WLth5Cwo35Auu
 b2Sw==
X-Gm-Message-State: AOJu0Yzl7ZSyKX7vIy78U93EhyHhGaREI4DaZt2Un590JJtifZBNbyAU
 QDyAlF95qmGD9ZUpOutO2QBxLI5AlBALNLhNlliBPn4qdbiXVJ5+BxSEWdEmSl/VCHdQItb6N/d
 NpSg=
X-Gm-Gg: ASbGnctiNHoJvJ4/3MVXWYB8DEXNFA0nmeEI8RmPzt3BgECcwGAtPu4bcPxszCYfeaH
 dqaHh5oIRuZJ+aL9og6U+69N6lxn/1GvlMve7Pvno5+sGe6/MV+1ZJtDZJYo1mZz6ZWdCPa8zd+
 8Aq1H07V2ZKjXz5xHH3fag/oT2JdZftnKetfjbxFufmuog3kuf7zmla3Sus7dymjqRje07ysaxu
 hW9NPyhGabUTOLI2T/p1kIoKPot9fUzAf9mrnFpkEYfXtMEk7RkU9NHquzwSGDPVV2DYyGm7ujJ
 /xuHKpnhPm3TvIuZXd764DWyAdpdKq4aktCrdKimg0Vxj2oiJQ==
X-Google-Smtp-Source: AGHT+IHXs7aNj3bUNJ4LMIkBnhng58oYk8R10OZ4Rnt+cI6FPIyKENXkXWqZnJJjEDFjxpjmlOYDIw==
X-Received: by 2002:a05:600c:3b19:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43f3a92568amr33933585e9.2.1744385455671; 
 Fri, 11 Apr 2025 08:30:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>
Subject: [RFC PATCH v1 1/7] efi_loader: make efi_exit_boot_services() call
 bootstage_report()
Date: Fri, 11 Apr 2025 17:29:27 +0200
Message-ID: <20250411153040.1772000-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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

CONFIG_BOOTSTAGE_REPORT is currently supported in the bootm command
only. Add support to the EFI boot.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/efi_loader/efi_boottime.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index c8d9a6037f7..96da279afd4 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <bootm.h>
+#include <bootstage.h>
 #include <div64.h>
 #include <dm/device.h>
 #include <dm/root.h>
@@ -2179,6 +2180,12 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 
 	EFI_ENTRY("%p, %zx", image_handle, map_key);
 
+#if !defined(USE_HOSTCC)
+#if CONFIG_IS_ENABLED(BOOTSTAGE)
+	bootstage_report();
+#endif
+#endif
+
 	/* Check that the caller has read the current memory map */
 	if (map_key != efi_memory_map_key) {
 		ret = EFI_INVALID_PARAMETER;
-- 
2.43.0

