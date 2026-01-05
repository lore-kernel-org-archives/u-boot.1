Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCF1C79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965E383EF4;
	Mon,  5 Jan 2026 19:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l8UclsuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551F483E48; Mon,  5 Jan 2026 17:53:08 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8AF283DEE
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso1216105ad.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767631984; x=1768236784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7oJ7n/ZmvelQH2b181pmp6OcXsVxjKeb5K7k3HAiMo=;
 b=l8UclsuUbvIbQZUI15rOjcz8vqoZl6c/jDR5/j6c4IPztGzg1QNdrMx5uGDMxD89OZ
 JQzU2QJMCHB/SD7oBB/hy7ngUbQTyYQMSsqC2N4sR/tOgI8QNQClzpGqBGBPyLNdRqpc
 1kJqECBW/rVtKtSC1NDmzAk0ZFqqcODrnX9NmM+3oodwYoXPnZyX8qbzyqsjowhCjwWl
 geDlb2+kjkbLXjtUwhScnhM9K/ohqZ1M1ISqP4ZhEbo5jG2XLJ2DPEckHqQcub+w3smJ
 L/IgpSoSD6171jNvoTyLZnfq8fk4Yez+ChZErGx5Pw8DgWfP1s6n8BxzqMBmhmBO8xvc
 jmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631984; x=1768236784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7oJ7n/ZmvelQH2b181pmp6OcXsVxjKeb5K7k3HAiMo=;
 b=GqG89LrUh1OeQcy7L/kWbcvkg7J+ydXP7oA75DzkimSJgWG5BbkKZV+L/oLRB1BnFZ
 cAOKdhyeP0LTm6COmgcg8ljmSMwTP051TLgmudktg1v6HW4ZkLrEFzOr4OBAY0FXVOGF
 NeiA3Sndoy4BzCnBSDgCF8Pu6ZRlonG7ahpLeiOMDmeR88+6xWf9FqWZEzJTdV47AlP2
 QfC3BMWldUKeB4pgCGxTSC+mVMeES81utWMmZaI6oB9sBS+v+X3cerepbCWejMS35pXJ
 0+onQlJLqnspvDHCteIocL3vbpIIudD2aNg8p+cL9SgTxtYpP3w44YuVuMOcGSSwVRV6
 yXQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSdztn9cpP68LOZjKO6tdJ329IVVuFw3oiCwf12b8XnSr/goI34SM0ER3s742/O+XsMNoIRC4=@lists.denx.de
X-Gm-Message-State: AOJu0YxAcOpztQMSpU1LZHQHdhCL2t4CB097mgvMmIpSYSLv1VLzlM6j
 Lwoq28HfZmxhXoXpSRK6xcB2t0mbnt0Mh3W5hchzf2x/+m34CwOAkECa
X-Gm-Gg: AY/fxX49WdGY38h/dmVQA96gtJjUNAf0AzykEzy6lENq9sdGw1TkCbTa1cjaHWKsBiR
 FnzCyUnIvjJVriY2+HOmwWbno58FUAnOVsQB2kXtitFsX1mAvh1Ego9HtURChClw3V46PkLKwyd
 QF4BIW51Tk1ivlbfqVoX2ATqoClCzzUOBB81XzQ+n4VJmaYlY8ptdPspjBh8e7Kwsk+veIBFarm
 t0hkc73/lg6vfCKWMKce9yX9+cPH8qGtDxbrdXkHx8gXWh5KBMy9xCnVpnMQXilICJrhGAE21tQ
 8H8pu3lv90zqK9BfdMMkOfP7stqaYXXeJRrO0Jf5cPPrN+SmAsO+uyP1yjfcOcxDdZyDZDX2owR
 G7FhFh5ZAZSrc+t7Tg+Dzt223oR68LwNwzIlBJw5Tqt4CJXzFsom107dBX+x0FXHC1ZCpk578qf
 W6FTPW158SNR8fho9eCEo7P9hcWPl0xJAOyp/x7tBDfgzQ9M46rJ/UkPGJ+EgbwVzzoOGfi2zXU
 zsQac24uKiMc89yzNirpw==
X-Google-Smtp-Source: AGHT+IGLXJSRv84tExnpUlrrQwnkPBR/wxZXQyTwMXKsk1ObtuK71GEarpvSdIbgw3y+AjGmnrLwHQ==
X-Received: by 2002:a17:902:f711:b0:2a0:dd66:d813 with SMTP id
 d9443c01a7336-2a3e2e2532fmr2688925ad.55.1767631984200; 
 Mon, 05 Jan 2026 08:53:04 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e2ba8748sm2707435ad.101.2026.01.05.08.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:53:03 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: alison.wang@nxp.com,
	angelo@kernel-space.org,
	trini@konsulko.com
Cc: me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 7/7] MAINTAINERS: Update m68k entry
Date: Mon,  5 Jan 2026 16:52:21 +0000
Message-ID: <20260105165221.1816070-8-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20260105165221.1816070-1-visitorckw@gmail.com>
References: <20260105165221.1816070-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:16 +0100
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

Rename the "COLDFIRE" entry to "M68K" to reflect that the architecture
support now encompasses traditional m680x0 CPUs (e.g., M68040) in
addition to ColdFire platforms.

Add myself as a co-maintainer to assist with reviewing and testing
m68k-related patches.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v5:
- New patch.

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf85f642a8d..57e8fd5bd8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1045,9 +1045,10 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-clk.git
 F:	drivers/clk/
 F:	drivers/clk/imx/
 
-COLDFIRE
+M68K
 M:	Huan Wang <alison.wang@nxp.com>
 M:	Angelo Dureghello <angelo@kernel-space.org>
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-coldfire.git
 F:	arch/m68k/
-- 
2.52.0.358.g0dd7633a29-goog

