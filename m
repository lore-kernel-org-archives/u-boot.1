Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CE6C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 12:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC55081111;
	Fri, 28 Feb 2025 13:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kB31384o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA588110C; Fri, 28 Feb 2025 13:21:10 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C7F809D4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 13:21:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-855a7e3be0eso58969339f.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 04:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740745266; x=1741350066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2ide9IvufYYl+3KQo2HAOeafKOGiXYHX4eLos0e4nU=;
 b=kB31384oCly2Sw+vFAood5Uvdal0q0lOtEmcS6Tuh5RshrOe33nZ9OomwUpf2SUyA9
 bWF+Se1WIRdok4CGisgqaAMsuQHOU+7l3vpYsuLoZiMMcjPvcpDTFu37LwvLvOKp3+yZ
 hUcfp47vgEusiKLqpmhLfYdkoa81Ck6DlpUGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740745266; x=1741350066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2ide9IvufYYl+3KQo2HAOeafKOGiXYHX4eLos0e4nU=;
 b=HRRqUsJyWOy1EDzcRrK69anR8UgcfRWJtestVh1MelKJLN/KKzYX7axxw1dPxnejM8
 jWWOltr13yKPd+EtlccqcR9HR1x68HVS3w67c+srRfAV+aGOHtVtOjR/G/kXfOeb7Kop
 Jq2OZie7GMpQ8vD0m127tmNRDUwUATyskMPydNmpsj6Js+6Ql9iB8kubYrxBEqiMwDp4
 1FiJZTPQITGg8U+3Hy6xOa7rA+Oary/27FcRH8K8cYRnom0+1m2dM4K+V9UKD3OucCGG
 HVjtlkK5FdW6fJNX17ETcTblU4XaAqtxDPEGhcpMXHk5SRY3iHZwKbUJGqUOVPnZwjvQ
 +Eyg==
X-Gm-Message-State: AOJu0Yw926rBWU8nFzbjeSwAwkKNGHbe2sBpxlzHzox2q+xHLbv3k5BU
 EaxMKkyQX44DGhzIj2po/uBUrS0/9uRaOD3tYE4dGGN0ZUcI87GQ8R/+tF/3UqWSVA5h8txlogA
 =
X-Gm-Gg: ASbGncsM3wkS9ZZGeDMlNI25Uy1vq+UD9G7MmTSzCtjc843lwS168YgSRx6C7pm82tC
 yOqXjMbpNdQHvdgS3i5TEETeJDW/bawPWudiY8htYLkvCvIDAukOjoauHy9jxuBFeYhIqGUOwBj
 BNoUZZdqeqi69e7cwpm11vm908ssky9LOpvCCzgAZliE6FLx5oUrkGPYnAdiq0J9O8Vbto5XdHl
 uoJBSuMOBSMzD/eUEIj3QNaH4HfNa+WEzjhkRrexcuy+a/oAi7x44sXu9Cp6zoQn3CwB2ylQDkl
 cdDMFLEkUrJtL0uoC32in3YsoInTUNu76w0T8vmoNKy8dS7EHzw1M4PEwuTq/X4=
X-Google-Smtp-Source: AGHT+IGDXkk8aMMfHmjPnOsRw2lkIUMYYKUAyipxFn8oTWuFTGDYpF1Qqgyd5PaxynrZnyzMEWZRdA==
X-Received: by 2002:a05:6602:2b8e:b0:855:b5fe:3fb7 with SMTP id
 ca18e2360f4ac-85881f25aa0mr250426439f.7.1740745266248; 
 Fri, 28 Feb 2025 04:21:06 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f061fa91e3sm863801173.138.2025.02.28.04.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 04:21:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/4] arm: Support a separate stack for VPL
Date: Fri, 28 Feb 2025 05:20:26 -0700
Message-ID: <20250228122042.1277079-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228122042.1277079-1-sjg@chromium.org>
References: <20250228122042.1277079-1-sjg@chromium.org>
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

VPL has the same needs as TPL in situations where the stack is at the
top of SRAM. Add an option for this and implement it for arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Rebase to -next

Changes in v3:
- Use 'phase' instead of 'stage' in VPL_STACK
- Split off into its own 'vbh' series

Changes in v2:
- Reply on existing CONFIG_VAL() to select the VPL stack
- Correct reference to TPL when VPL was intended

 common/spl/Kconfig.vpl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index cf6b36c8e38..434562443ac 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -266,6 +266,20 @@ config VPL_MAX_SIZE
 	  The maximum size (in bytes) of the TPL stage. This size is determined
 	  by the amount of internal SRAM memory.
 
+config VPL_HAVE_INIT_STACK
+	bool "VPL requires a initial, fixed, stack-pointer location"
+	help
+	  Enable if the VPL phase should not use inherit its initial
+	  stack-pointer from the settings for U-Boot proper, but should set
+	  its own value.
+
+config VPL_STACK
+	hex "Address of the initial stack-pointer for the VPL phase"
+	depends on VPL_HAVE_INIT_STACK
+	help
+	  The address of the initial stack-pointer for the VPL phase
+	  Usually this will be the (aligned) top-of-stack.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.43.0

