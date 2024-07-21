Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347ECC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9C288210;
	Sun, 21 Jul 2024 12:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cxLi9E7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36481885E4; Sun, 21 Jul 2024 12:10:15 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A08874AC
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso1490243f8f.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556611; x=1722161411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ53w76g8vm8KtCrJcm0FKHCszg8ATv4ogMFP9nGoVg=;
 b=cxLi9E7TybGcGm+mcYvkCcPuGgUkIZbddUrUWUZFFa8JQLbbTNUhiT5rc8J7kJbfLP
 N1N0ZFR1Ouih0d53LrH8G1naEnG4qM1ZCQSPiT2ApDBu5d5sanZ/oOhAsp/9/Xm+ykut
 nYHe8kyZ/mfAqd6hQvEQnE2GBNMRawlfnFfYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556611; x=1722161411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZ53w76g8vm8KtCrJcm0FKHCszg8ATv4ogMFP9nGoVg=;
 b=lfeplaUzxIQALjlYgIdBqJdx6QL+MXGx0PNM1/h0b4MdbaazFNX1n3q5JYGr6Xl0Kp
 ZYMaazyAX1jw1IyDWgs9XJvv/XhlVZcbxZ8vtKNOavPCNOMzE3Y1pBorlcdoJbWL2CkI
 K8YNyvbx7FKLS8jVDw4EwnFP9QIeKVFz7r7VtXkCfVNcYsSUCawU+u0Vk+csMROGxFbD
 pLePB6mlDLKDjUh2L1A9FzKIeAESJ5i+rl0EiKE9G+x6lgKd19FjXAuVldPUGfTLiC0M
 /bO8dEb2L2rUygqi2MYeHY/sn7rWBJaZdwi1FsFuD2EfmGEQfWdrBStmFXfWn2la7Orv
 vj+g==
X-Gm-Message-State: AOJu0YzzS878F8Y00/4eaPIT+0JeLZwYtW/hgMRHEBXXRffgozo6K/1z
 03IAmPLvTwu3EfPbiMtyYXRNaKTA0JW2uYDiSL/0lEx7cfjuOpRgENjTsNyxNXXLFaQwqT/brMo
 =
X-Google-Smtp-Source: AGHT+IHGq+DHTn1dQGvmA2AQi2Ft4wj2RHAlGfC7bKsJ94xoal9aBeXe721s8gK6PKDfiKUPZel1Uw==
X-Received: by 2002:a5d:6651:0:b0:367:2945:2bfa with SMTP id
 ffacd0b85a97d-369bae703c4mr2161800f8f.52.1721556611195; 
 Sun, 21 Jul 2024 03:10:11 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 18/21] upl: Add initial documentation
Date: Sun, 21 Jul 2024 11:09:36 +0100
Message-Id: <20240721110937.v3.18.I7abd8fe6045ce8ed9eeb7b94c8441a451a72cd97@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Add some documentation to explain the basic concept along with a link
to the full spec.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add a link to the spec
- Add a link to the command

 MAINTAINERS           |  1 +
 doc/usage/cmd/upl.rst |  4 ++--
 doc/usage/index.rst   |  1 +
 doc/usage/upl.rst     | 46 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 doc/usage/upl.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index efb557b2524..8842ff8ad91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1708,6 +1708,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
 F:	common/spl/spl_upl.c
+F:	doc/usage/upl.rst
 F:	doc/usage/cmd/upl.rst
 F:	include/upl.h
 F:	test/boot/upl.c
diff --git a/doc/usage/cmd/upl.rst b/doc/usage/cmd/upl.rst
index a64063d42d5..8d6ea5daa37 100644
--- a/doc/usage/cmd/upl.rst
+++ b/doc/usage/cmd/upl.rst
@@ -16,8 +16,8 @@ Description
 -----------
 
 The *upl* command is used to test U-Boot's support for the Universal Payload
-Specification (UPL) firmware standard. It allows creation of a fake handoff for
-use in testing.
+Specification (UPL) firmware standard (see :doc:`../upl`). It allows creation of
+a fake handoff for use in testing.
 
 
 upl write
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index b34e388bfd1..d67fe355446 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -15,6 +15,7 @@ Use U-Boot
    cmdline
    semihosting
    measured_boot
+   upl
 
 Shell commands
 --------------
diff --git a/doc/usage/upl.rst b/doc/usage/upl.rst
new file mode 100644
index 00000000000..3c4a10c862c
--- /dev/null
+++ b/doc/usage/upl.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Universal Payload
+-----------------
+
+`Universal Payload (UPL) <https://universalpayload.github.io/spec/index.html>`_
+is an Industry Standard for firmware components. UPL
+is designed to improve interoperability within the firmware industry, allowing
+mixing and matching of projects with less friction and fewer project-specific
+implementations. UPL is cross-platform, supporting ARM, x86 and RISC-V
+initially.
+
+UPL is defined in termns of two firmware components:
+
+`Platform Init`
+	Perhaps initial setup of the hardware and jumps to the payload.
+
+`Payload`
+	Selects the OS to boot
+
+In practice UPL can be used to handle any number of handoffs through the
+firmware startup process, with one program acting as platform init and another
+acting as the payload.
+
+UPL provides a standard for three main pieces:
+
+- file format for the payload, which may comprise multiple images to load
+- handoff format for the information the payload needs, such as serial port,
+  memory layout, etc.
+- machine state and register settings at the point of handoff
+
+See also the :doc:`cmd/upl`.
+
+UPL in U-Boot
+~~~~~~~~~~~~~
+
+U-Boot supports:
+
+- writing a UPL handoff (devicetree) in SPL
+- reading a UPL handoff in U-Boot proper
+- creating a FIT
+
+There are some new FIT features in UPL which are not yet supported in U-Boot.
+
+.. sectionauthor:: Simon Glass <sjg@chromium.org>
+.. July 2024
-- 
2.34.1

