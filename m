Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A38E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AB1805CB;
	Wed,  1 Jan 2025 23:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d35PqulD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBFA8039B; Wed,  1 Jan 2025 23:12:47 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F2E803F5
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-216426b0865so142753495ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769563; x=1736374363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ho08s1vm62DHMsDNxQ++LCr9laAK560k0zsbgvLwfo=;
 b=d35PqulDSYTiDWin9JuC5pwOLsF7uQBmQhRVDKYcBjKF0wseqCnm8fyalVOsk1SQUH
 5JtpuHmx0kCBBgVhR4OHoqonMJNCJevwjaRAK4kZk5rWBTpkY7kJgiQKscg01F/YvFvk
 GyZ+7eF+EcQFBodXGUpFpNojwAqcgvcCX7RuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769563; x=1736374363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ho08s1vm62DHMsDNxQ++LCr9laAK560k0zsbgvLwfo=;
 b=S/v17SQ0/YkSgieMKLwm0esyLGAlNKnGQjaJMERO/x0oP1HrN1BXNcVo3sKtPOr//P
 tKpRiACKRcPTDA8+Jn6OL7UNOVplXXsE3OQI1F9RGWXj/7NsJnOtjnzV6UjAkBQcknkj
 /gMofdFCGi02orLGgFhVgKsu40hJB01sEcm3Hg//Lcll3Ji/wb/m0kTLTRyX2R5298Ph
 hUCen8cA3MoiY9DWYxw1S0BSl0SUTkmEgLCwBh4nOBt9BNsEPpEOK094SlLT9esVtqab
 cDupXJzgPiiLy9NylioFhzcnfmv/VWhxUeFJ32L4Q2Aw3top8cc7bjQ9C8fzFTGzOt++
 cIfw==
X-Gm-Message-State: AOJu0YzE0ePzK8Q7dvooO9TnbzIMJNT9amFaCTo0dzpjTJFZChbE0iz4
 Pi5fUKKtVNQ6g3Xe010NX651cLIZzVzuJ63GA34Ba2MIX0DMjv4rBPhFLbrM7dXFpce7xhs3Ulo
 =
X-Gm-Gg: ASbGncv4qQN54JBBp79Ar96KoXfdHliUGkyH0MW0Kxwceml8TQIBrxX/EFMlkG0BC97
 u+BRlEXW+Ru0oBFyFyZt0II3GnfDDFT2QZoYqWv/TGPvxue069fZATLn5CS0MLYmPfLLBi7i6E+
 yiAt8gb5M3JbEzT+bsBZT6mR7Zw7WQnCTea2chcg+nHkX0ydhqJ7MNed++8j2OKjHv23hxVlMII
 Pumk29P8DydXP+SqfqHEaDQnTV057l3GUGDhs52UTckDpC3cdc/hJM=
X-Google-Smtp-Source: AGHT+IHMtLnl/PZcALFdmYPsTumec702zViKncZ46a4DCyiDXoVnY/NhqQaoxzwa10X0PhfMXAAESw==
X-Received: by 2002:a05:6a00:600c:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72abde84e5cmr62716606b3a.19.1735769563339; 
 Wed, 01 Jan 2025 14:12:43 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/67] emulation: fdt: Relax condition for OF_HAS_PRIOR_STAGE
Date: Thu,  2 Jan 2025 11:09:05 +1300
Message-ID: <20250101221003.1944600-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

QEMU always gets its devicetree from the OF_BOARD mechanism so we should
not depend on !BLOBLIST here.

The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
only standard passage to receive things from the prior stage. QEMU
should implement standard passage to provide its devicetree to U-Boot
However Linaro has blocked my patch to provide devicetree additions[1],
so little breath should be held in respect of either change.

[1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
---

 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 41a758e83a6..fc25a854708 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -191,7 +191,7 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
-	depends on !BLOBLIST
+	depends on !BLOBLIST || ARCH_QEMU
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.43.0

