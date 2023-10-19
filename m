Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D598CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45FA874A0;
	Thu, 19 Oct 2023 17:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AbD8HHNi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16AAA87469; Thu, 19 Oct 2023 17:01:38 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAA887448
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7d9d357faso100896057b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727694; x=1698332494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xILpf6KPxsL3IgN6tZhzvuTRItvF6seW2sbxi9L5UqE=;
 b=AbD8HHNi74m8klqUbZRs/2MJNzo9w/DKAs1+wY7APw0SWecCsxK5sMJANJwoEpWVXd
 u3+EUtLT5w8X7bbXKQ4EdXVMFVpodmeoi1OhUqsKQ/CN0+x1cjS6WuuvnzLXE96m/ISu
 PVfgR8PI9/Ido2CyGc/3hG4Py9pdKgSxUwfNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727694; x=1698332494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xILpf6KPxsL3IgN6tZhzvuTRItvF6seW2sbxi9L5UqE=;
 b=wzuAEBICm9Faf2ERg+IGujW0poiOaEGcEWTWfJGrkaq4KcTJrDOouEVAR2LBdcqUVO
 VPqJurdBv8Bcchq1sxLrozYYlEJzGseAP/Faq9Hwgr4S2hgrvdsTraV8gESyo61YSg56
 LrTZNYmhpwQ28uaPJh6knawMz0EIqHUdfUQ+hBWUOauyEt2xqx/HDIizvnXzX9imn0fz
 ICCoebixQE9amopMeR8xV7q0ppTkhgYFaD75RUqzQHxrr57PU4mw6cuMR4p6joOiHmTK
 m9u5lsCGiOEAyghHqzQphv+oBVdDJiDdDgDoh0TrkCgN6ImigV9L2p4ipTB6/q7PtKL2
 zVxw==
X-Gm-Message-State: AOJu0Yy43nAF3QAEfA/LDx6vDd3SOOJoJazZHRCX7nPANhMMkS4+ch2y
 zlpSt5Flxl8NVlDP5HkxQvCENkBz3D0c/8HiC4/uag==
X-Google-Smtp-Source: AGHT+IHqj0lAVxmbHnGFyPuzYbtFI3z/pJhaUaSLf886N0vujvkxW2N/ABINrMYIeTFSvJZhbRTjSA==
X-Received: by 2002:a81:4708:0:b0:571:11ea:b2dd with SMTP id
 u8-20020a814708000000b0057111eab2ddmr2766977ywa.32.1697727693756; 
 Thu, 19 Oct 2023 08:01:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 23/24] sandbox: Add <asm/barrier.h>
Date: Thu, 19 Oct 2023 11:01:04 -0400
Message-Id: <20231019150105.714407-23-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

Add a mostly empty asm/barrier.h file for sandbox where we define nop() to
be an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/sandbox/include/asm/barrier.h | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 arch/sandbox/include/asm/barrier.h

diff --git a/arch/sandbox/include/asm/barrier.h b/arch/sandbox/include/asm/barrier.h
new file mode 100644
index 000000000000..0928a78cbf8b
--- /dev/null
+++ b/arch/sandbox/include/asm/barrier.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#define nop()
-- 
2.34.1

