Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C85C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43EE86579;
	Thu, 31 Aug 2023 01:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ly6WUVd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666DD86545; Thu, 31 Aug 2023 01:30:14 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A084C86555
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-792409bc1cdso5842039f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438208; x=1694043008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgFH/iQ5X+qf/IZrs3ZfZXaSzhlZWmExzaQFH0wb13w=;
 b=Ly6WUVd39uEzmKhs0nGX+6wg75FRy6f9odhoEVtdRMcxbpapfRfsWqMu0CWbmfZXnv
 MMVrRWn22yXmmp66zIgfKNDL5no8rA0nh5uznIrLpuc0TY4XHwljLg82yO7ZG3p42MOi
 9+CC3f9FRtH8NTM+dWMZhjkJuzH0hryL2qe5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438208; x=1694043008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RgFH/iQ5X+qf/IZrs3ZfZXaSzhlZWmExzaQFH0wb13w=;
 b=dyIDsGwOqcJ44L7xBSSiaYSXE5LTcZL4aCjJbPyy7gNhxjHIhRj0Jp3OjFgcGpSLQc
 Bj49B0kTvHIhdACmIoCkNYKOGR6tYzGdfVaPMwvPN6LlojuDAizKi+yvCN6EBGE81wgf
 v1qYEKtq2YgP9YID/Ll3JLnsjOZwNChHpUnf5HT6325htiOHIBgABDDQ25gmOQdDyn4n
 9tfIXQRoITgXU7GTZu61PlKi4RebIxjVgPxk9O+IjuSXENr7Iz42lDln+5903lhIIo/4
 P4V6/Vy/v577wUrdXGK2Ly8O46q2Kyr2Fv+qS9ArZ7UnU9mRaR5erNUlIG7QczyIk1Ek
 9e+A==
X-Gm-Message-State: AOJu0YwuuhFGK/3LvUanS4xjmNx0FVluc5ebGP8LJjogA3ZgxVYwUUlz
 jTExSscQWDacCz4NWDzOchUoFQhvcU+73yXtYQw=
X-Google-Smtp-Source: AGHT+IFusTmkXfXarI+nY253Pa9V9E9j4zFAExPjrc38HP6/rmdP+v3HVZ2d7lTFPOLrenSZU3QxXQ==
X-Received: by 2002:a5e:dd45:0:b0:790:b44f:b9ee with SMTP id
 u5-20020a5edd45000000b00790b44fb9eemr761916iop.10.1693438208276; 
 Wed, 30 Aug 2023 16:30:08 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 9/9] upl: Add initial documentation
Date: Wed, 30 Aug 2023 17:29:23 -0600
Message-ID: <20230830172917.RFC.9.I010f4a9bf3e17c8e8ea0c41a053c745d56ca9559@changeid>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

Add some placeholder documentation to explain the basic concept. Once the
spec is published, more can be added and this series applied.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/usage/index.rst |  1 +
 doc/usage/upl.rst   | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 doc/usage/upl.rst

diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index ed896dfb3a0..78665fd5759 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -13,6 +13,7 @@ Use U-Boot
    partitions
    cmdline
    semihosting
+   upl
 
 Shell commands
 --------------
diff --git a/doc/usage/upl.rst b/doc/usage/upl.rst
new file mode 100644
index 00000000000..2ae4d4a1178
--- /dev/null
+++ b/doc/usage/upl.rst
@@ -0,0 +1,27 @@
+Universal Payload
+~~~~~~~~~~~~~~~~~
+
+Universal Payload (UPL) is an upcoming Industry Standard for firmware
+components. UPL is designed to improve interoperability within the firmware
+industry, allowing mixing and matching of projects with less friction and fewer
+project-specific implementations. UPL is cross-platform, supporting ARM, x86 and
+RISC-V initially.
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
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

