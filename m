Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212C7CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177CE86DEB;
	Tue, 17 Oct 2023 00:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EKG7N1d/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170CB86E16; Tue, 17 Oct 2023 00:30:28 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B73786F02
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7740729ae12so349326685a.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495407; x=1698100207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOY4V3Z80m9z7hQszqNS0xqshtuC8mtv05jGjg/ew6o=;
 b=EKG7N1d/gMLfF2YOUHx4hh2PsHdgEeP2+K7NWV6YjvTnki5YGQMTc9ScOM5t5K175s
 t7PFu801xWtqmbZVuotqwONhVTdFHAi1FlC3dA9FRwBrgARak0vrvBPM1tWOCelRlLFG
 G+8JSy8C9XPN/x2sEVpdvVeW38PIUJ31Uv5wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495407; x=1698100207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOY4V3Z80m9z7hQszqNS0xqshtuC8mtv05jGjg/ew6o=;
 b=eBjPWPN3UnOlD1Giv7+208oxk2fzpxV475IIpn9M7oHAfdfTW3POi8jZ+kF69our5c
 S3HiJHKoNgIWfXw5EfZBJzgWqo/V3W+NRuQwBfAsL+WdAhLHNjB81IwXK0wJ4QcQVW5P
 WIBitPTcDQOT9pV8XzO0KTYqfTbG6eQ1V+NhsZypWFqZIBFQUTwkk5w4LOth64FQLpX/
 q/1eULizRaNO+f2hNNcY91Qi/qWXnxKb7Q/z4SFp24hE70Mdjj5FoYMzFbW+3tdqyoAW
 dY0dDD69cD/+QQpB8RICpbv5PkLE0jDgCCm4y8CVwLM8zxJ7FX7tY3e8P4TKrvzFh/uP
 JIRA==
X-Gm-Message-State: AOJu0YwF0gMeMf20azzMMwsiBnmHSoOhqd1tblQSHpWLvGyhir1J9CF4
 oW1U2/bNUWw7/5AwnOeOlaU6bvQyw1dJ+y9piRGkPQ==
X-Google-Smtp-Source: AGHT+IGVrciZwr1pSd5CL/GbIszsUbXYFhSHF6lLhyWpE42AGubDaDWz1D6KdmkRnzAJE5Ovvdb4AQ==
X-Received: by 2002:a05:620a:408a:b0:777:5120:829a with SMTP id
 f10-20020a05620a408a00b007775120829amr603382qko.34.1697495406747; 
 Mon, 16 Oct 2023 15:30:06 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/32] cli: Always build cli_getch
Date: Mon, 16 Oct 2023 16:27:59 -0600
Message-ID: <20231016222835.596572-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

This module is used for user input with menus, not just with the command
line. Compile it always, so it is available even when CMDLINE is disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/Makefile b/common/Makefile
index cdeadf72026c..b21916f15340 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,6 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
+obj-y += cli_getch.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
@@ -37,7 +38,7 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
-obj-$(CONFIG_CMDLINE) += cli_getch.o cli_readline.o cli_simple.o
+obj-$(CONFIG_CMDLINE) += cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
 
-- 
2.42.0.655.g421f12c284-goog

