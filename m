Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138FCD5C0EF
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BB889287;
	Fri,  8 Nov 2024 16:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gf/56Qkt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F26C8926A; Fri,  8 Nov 2024 16:24:12 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F409D8923D
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 16:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83ab21c26f1so82743639f.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 07:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731079448; x=1731684248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwwrQMSsLncuz30s5NrxhDvJwySfk4Vx1Zo2WkZ6J5Y=;
 b=Gf/56QktMJif6LGlRC280AN71qBd+ScyzjhXvYGFBqpMAuKGIQ0vGGfOLrLVTX342Q
 0dN7SEZA2j8IEgpws158fULZp7HNPgvVv6q8EvLV7WSzxmz9lO3Q11yGEfXofPpuDXWA
 MEUpcHKuhD+zyxlNZghce8cJ/6eLEARF2/p84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731079448; x=1731684248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwwrQMSsLncuz30s5NrxhDvJwySfk4Vx1Zo2WkZ6J5Y=;
 b=gann9rrBzfIPJnd4MTj64BF1vZ8feJfA6SL9mnm/i+1ayR9qF3sQXZOHJErk3D5hR1
 nwvmEgZIeBZ5wMDELGSzawQOGi8p0jvjWe0QoikettDHpyh4ukpk9oU3s6jrWalFqxo8
 jDW4AcdvanFFIkRJSU/J0ZGSOOpIaV3AOfMIe05cGqiaieytzruYMMgRNSobabb/nPyp
 Hp5awTRgmAmTtWqBvOpjJ9H58sY1g57oGorluxD9g1MVon4gJzNn7CEjawHFCPcIdgZl
 XS5gmBH7h6gsgBb1jrtrdH6kuM9oLE71IHIE7f8N6ZyocxvDVtviSoro8dPc+4cnCkG0
 QANw==
X-Gm-Message-State: AOJu0YwYY51PtxVND8BT6LlefJq7teNunTI/WsOUi/IXO4QNB+tDMB1A
 bCRH+SSsYhXFgXUCit1wjEUy3nP6Vyci0hzVzMcPxbdW2RPdZ/LV+ZKX3dATy5JPPq4hmzdXSCU
 =
X-Google-Smtp-Source: AGHT+IHfanO+YlOB7MsO8F2Ja3WfeYbCGCCsEYRWS/Gss627C5FZz11WO1eqoNE/3u21TV7J/Cy4xw==
X-Received: by 2002:a05:6602:6b08:b0:83a:a25a:cfaf with SMTP id
 ca18e2360f4ac-83e032a16d9mr306577239f.3.1731079448059; 
 Fri, 08 Nov 2024 07:24:08 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de5f7e3283sm864420173.6.2024.11.08.07.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:24:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 8/9] buildman: Propose a format for extra boards
Date: Fri,  8 Nov 2024 08:23:49 -0700
Message-Id: <20241108152350.3686274-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108152350.3686274-1-sjg@chromium.org>
References: <20241108152350.3686274-1-sjg@chromium.org>
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

It has become more common to use config fragments to extend or adjust
the functionality of boards in U-Boot.

Propose a format for how to deal with this. It is not implemented as
yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/buildman.rst | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 924564b5700..48705d0e49e 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1148,6 +1148,45 @@ like::
 This is partly because there is no way for Buildman to know which fragments are
 valid on which boards.
 
+Specifying the build matrix with fragments
+------------------------------------------
+
+In order to build boards which can use fragments, Buildman needs to know which
+fragments are valid with which boards. The following scheme is proposed, but not
+currently implemented.
+
+In ``defconfig/``, files with a '.buildman' suffix are used to effectively
+create new boards for Buildman to build. All such files are processed, but it
+might be best to put all the information in a single file for now, e.g.
+``extended.buildman``.
+
+The syntax consists of a number of sections, each introduced by a name. For each
+section the fragment file is named (without the implied ``.config`` suffix),
+then the targets which can accept that fragment are specified, either by their
+board name, with wildcards, or a set of ``CONFIG`` options to check. All
+``CONFIG`` options must match for a board to be included in the set. To specify
+multiple fragments to be included, add them in the order which they should be
+applied, one per line.
+
+For example::
+
+   # Build RISC-V QEMU builds with ACPI
+   name: ACPI with supporting boards
+   fragment: acpi
+   targets:
+     qemu_riscv*
+
+   # Build Android variant of 'k3' boards, with DFU
+   name USB DFU for am62x boards
+   fragment: am62x_r5_usbdfu
+   fragment: am62x_a53_android
+   targets:
+     CONFIG_SYS_SOC="k3"
+
+Buildman normally ignores these files. To request that Buildman process these
+extended new 'boards', use the ``-X / --extend`` option. Note that this may
+significantly increase the number of boards which Buildman builds.
+
 Building with clang
 -------------------
 
-- 
2.34.1

