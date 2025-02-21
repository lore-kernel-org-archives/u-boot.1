Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02131C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE27280FAA;
	Fri, 21 Feb 2025 13:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e2NF68ka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F57B80FAA; Fri, 21 Feb 2025 13:59:38 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4536380F5C
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 13:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa48404207so4234060a91.1
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740142774; x=1740747574; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69+7vScDuH4XEKIVR+olucS4kWbqYVnT6bIkVLIm5ko=;
 b=e2NF68kaj+h8YaIM36syIUP/X2BxAm4UsRY2JWfmWi2QXI99Ilk2IT3tZ+/h6L3ptN
 PXxJrBWKJ0OGL/q3677AjE+dInfRTrxpc7j8XjcgFqY9GJSyQAONG3mcgM3U8qGN/cMa
 OOYpz2mp8cXSQ2LCeuk68KWpaWf/diotGsU9HA6R90DTaTMw/dU55pD1xOklyvtp4sOr
 c3IQ9WjtRKZ8IvzqlAbL2tETfX4TKxQUtAYTLuUHTwB+DgGLAD7ZmY4u6PB+NH/5/C1a
 /T7M6pIDd9CnVjnxFOpCExaabKcTHLIIi7TH7UgQ9PbFlmZEq7Bo7++OE9BBjcM3U0BM
 yoxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740142774; x=1740747574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69+7vScDuH4XEKIVR+olucS4kWbqYVnT6bIkVLIm5ko=;
 b=BYzYQ7Re6mkG5FEpPvLMgmtOPadLPzdRAprJeJy37WCQt9xMPI6gg7ZpqLqrkJMGVu
 Ak9aZKsogI0fq1Nhcsml2MCfT1FYAxOiN8vYaMI6ShaJrLAqOj5hC8qOfE81bm3+xu/s
 yQAvuqiDZVrDZv/BEvSYH7p+s4+OV9Vl5bJQC6wyl2JiNdZ6hX8P9OE88VO4adWXm1VN
 gfis14eCd8rxYTi4GaRWkyfkJZOnNlaPLOmGdS3MZqMjuSMDNUs6GbsQlrjIO/VNvn2R
 GqCBSvfq9zFIx9X5TG091poEU2BE8tocMAhDr59xLqN1uKaDWD0dKETjUbYCsM/UVh9j
 YgmA==
X-Gm-Message-State: AOJu0YztpsAniQZfR4NPjhjkZxAjTnnG9phjWV9JzEEuFtUfrgBDesE5
 wQhfBHKNMUIlW+zaCyJEvXrHP0YbI8YmvuosGF/dg9Q7PNHL5cRc8b+bHt9DsF8/CMutM6nStP3
 H
X-Gm-Gg: ASbGncuC6fxKhQoIFy291WzyDziC4zdUPcdcKytKV68DYciaUCsg+bvAFN+vPOS1f0r
 F0jS8+3NEZzsZZ5ezF4i6zue34RAt3MdStgz9upSxiPlWthnTPbbB7mILTdR84bJbLtuwAR877E
 dpzOaR4eUulxB7dvA8ul1p49T72R13Co9ihfeAZp8TarrTUJULWtaVe0P/ojBVRmRuw+yZ36x7n
 6/G93Ng8Aw3YFSVyDkn6tz4YQPisLbYV/OOgCEqPHXkQGLdNew+Oh82apgkCfT81+zIftWuKa/n
 Ziz+PkqAEQ8eyn0pcyc/mE8=
X-Google-Smtp-Source: AGHT+IHGOrO/cVGifZIuhlg+SOqi3gFq3fi5vcQ4fF+G/acCrpSEMGa2askoHLLLUHdpFzHpKXxoHA==
X-Received: by 2002:a17:90b:2688:b0:2f9:9e64:37b1 with SMTP id
 98e67ed59e1d1-2fce7b0ad50mr5226920a91.28.1740142774606; 
 Fri, 21 Feb 2025 04:59:34 -0800 (PST)
Received: from vm.. ([106.195.8.203]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2fceb09f6basm1273971a91.42.2025.02.21.04.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:59:34 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 3/3] riscv: booti/bootm: Verify image arch type
Date: Fri, 21 Feb 2025 12:58:53 +0000
Message-ID: <20250221125855.300717-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250221125855.300717-1-mchitale@ventanamicro.com>
References: <20250221125855.300717-1-mchitale@ventanamicro.com>
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

For bootm, disallow booting an image that was built for an arch type
other than the current arch. For booti, set the arch type same as the
current arch.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/lib/bootm.c | 4 ++++
 cmd/booti.c            | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 76c610bcee0..90f71bee6a5 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -94,6 +94,10 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 	announce_and_cleanup(fake);
 
 	if (!fake) {
+		if (images->os.arch != IH_ARCH_DEFAULT) {
+			printf("Image arch not compatible with host arch.\n");
+			hang();
+		}
 		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 #ifdef CONFIG_SMP
 			ret = smp_call_function(images->ep,
diff --git a/cmd/booti.c b/cmd/booti.c
index 1a57fe91397..00921ec4a9d 100644
--- a/cmd/booti.c
+++ b/cmd/booti.c
@@ -131,7 +131,10 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	images.os.os = IH_OS_LINUX;
 	if (IS_ENABLED(CONFIG_RISCV_SMODE))
-		images.os.arch = IH_ARCH_RISCV;
+		if (IS_ENABLED(CONFIG_64BIT))
+			images.os.arch = IH_ARCH_RISCV64;
+		else
+			images.os.arch = IH_ARCH_RISCV;
 	else if (IS_ENABLED(CONFIG_ARM64))
 		images.os.arch = IH_ARCH_ARM64;
 
-- 
2.45.2

