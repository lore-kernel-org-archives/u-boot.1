Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F408BC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 512C18884F;
	Sat, 13 Jul 2024 09:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1XN7GIq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017D688846; Sat, 13 Jul 2024 09:04:02 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A0588805
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52eafec1e84so3817774e87.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854237; x=1721459037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wdxjgYzJA/UA1K9CdPW8SRIyMk2ngfmq96F/t9Oxdc=;
 b=g1XN7GIqmgQ65l0x+y26e7R8zBgMmb1xLiPqDLwPAd17cBW+SIWmehbNpsvHHS63fi
 dpfrGBfZPElsKe4MXDxM/mTsVBqULtl/GalRkxVx6Uk7GOrSg6UARVJFRPsB20saSyQP
 2guNZyOe0sp3s7BD2ekptyZAtgph15Wk4Ok34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854237; x=1721459037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wdxjgYzJA/UA1K9CdPW8SRIyMk2ngfmq96F/t9Oxdc=;
 b=cxUBvZtleSLEOXhI7afCQWhyIp8SZwxRKZ/IYkZRGG/J1xjfDqhbpBV7oefwTusMEC
 XDv0799l580/JiChUCI/m5Xk9vPA5eahLzIQnPJ9IT615z11qv45QFcjpFfhOn4Bp43v
 LNtYSVx3jyL+yIiMMXnFw8DU/31ZkM6NaR501nr3VBYJwR7rGXgCeGi3/dLiNFtcmLZ0
 2zcMa/4lohZ9ijD/FWFwfIsx67q1PpaeTSoJvgKa9nVXVtGbC6yE29wiJ4xnZX75HcfX
 Hmd5MnodQuKcK5oWbLiMcY39h1cRrBi4cDh0d79iLBBT1xf0UiwYvPl80bZnPB4MuCVl
 k4QQ==
X-Gm-Message-State: AOJu0YwOY50emCvQ2zR6LOIjdsdQoZj4L+1nJrwn5Ix8IdEnR5qT516R
 Cw9h0LbYpt1qTGgu2NgAU2jlQabH+fkVZ2BcqumhjGp+7EEpM0MhZzBCsDt7/SUVvSe9B+hyV08
 =
X-Google-Smtp-Source: AGHT+IG0RuWW1iw4Dylyaoa3sEBMwVEUc/4311bMUIUJcCC1ldgagVuiXYz3V6zy7sKmy/tYXkpFaw==
X-Received: by 2002:a05:6512:3b87:b0:52e:9d2c:1c81 with SMTP id
 2adb3069b0e04-52eb9990ccamr10209795e87.13.1720854237249; 
 Sat, 13 Jul 2024 00:03:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/21] upl: Add initial documentation
Date: Sat, 13 Jul 2024 08:00:52 +0100
Message-Id: <20240713080049.v2.18.I7abd8fe6045ce8ed9eeb7b94c8441a451a72cd97@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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
index 5078e8c30f0..96faa9e1acc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1701,6 +1701,7 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
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
index 43f8588e695..28d5dcd3e30 100644
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

