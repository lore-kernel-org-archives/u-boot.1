Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE6CC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1812860A6B;
	Wed, 29 Jul 2026 04:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QgYJx-tqhxEp; Wed, 29 Jul 2026 04:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C5D5607D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300929;
	bh=ag42QFn1QUhL2dUX5hQFSJeoKpiThHSFC9aoXPi2M40=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rvfRyHcpUshZqO/1GASMY6WkQcO51DQqHwcxVi8S4SaR92Eu1K+OIKplv/0MEyDZR
	 ZvctfgrPJ64dK9d/l8LoamlM7FCMRy5FZ11kOS8OrHuW2Vm2H7vdvZSWaimC/52yoJ
	 9LXyXPY2TcmQyW9jsJalRQKfoPX2hwQHR4GIoIoSIkemQycizHqc6e67kWgos/AmiY
	 1DmHaOX/4dAGzpOteYplwFjv23UnljC2bjWJ3U/brLxSLGUcpR0nb5s473SqLrD8Fo
	 vZWmgSqcx7QFPfefoOj5dwAGZOSgTjlrHZ/81ZPEd+6nWYL3Q25USkDrsimbW3b92L
	 D7QvfYRe63Zfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C5D5607D1;
	Wed, 29 Jul 2026 04:55:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2D0D788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4C4D812AB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rMCFWrzJKoE3 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 17:27:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=shofiqtest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 844DD810F9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 844DD810F9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 844DD810F9
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 17:27:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6C68494B; Tue, 28 Jul 2026 19:27:08 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E7918404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:27:05 +0200 (CEST)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b01cb18515so3727278e87.2
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 10:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785259624; x=1785864424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ag42QFn1QUhL2dUX5hQFSJeoKpiThHSFC9aoXPi2M40=;
 b=tWvec+Mo11NwQvgBvcr666UGcBKJhVao16yXfhU6SrjzsHdmwzrwPiTKPJ8FzYCDJJ
 CqIXS6ykwQLv2YpHdhYGrp3aUFuin3T1B7M5cfYkTr4BCcg14WlghotDSp00csxee03q
 3sMUVFLXqyB7Qevrvoju8oVWhM4lDcZUYi5aHEDftSYXI79yrU+UY0kKf083uoCKu3/R
 9Mb93XZTFW55Eoe7m+BWNxvuCcp3crcaO52s383gIY1Btre9PQlm6hckzB1XnMG+R11U
 YodZ2jCn5feIl3Q39wFzwCVZb1LWb0vBltT049640NLtw6VaLpnGg1HGQsJ5oLz3AiQk
 2RVw==
X-Gm-Message-State: AOJu0YypqFi5HiTC8jRdpwn3ggwM58xI8PZjHpkzpy7MaEveXatTJS38
 H77bIXWcvVctLk15xS30i7geusrU4kSEZoVtJU3M3Nhq13uAIc2ncmKwQWQiJiQcJhdR/A==
X-Gm-Gg: AR+sD11amCLJNYY9pIVGIMoHpR3sLFZz8aeCaz2J6lDt2BmmtdG6CmszdMB33nbYSui
 yMCaGW/Bk+9CbEDEfnifnAcm8lUU+g32+bRt46b5BTFftF0i6YdggQnSIW+1oazLxV5rkhX2ftE
 YywBtxN266o/oG7pZR5+U77Q/EmYVOZWQOMdCNnq8t2G/6fX1QAITjJi3Vwhb/jkufGCDOpu4j5
 b/gUrMuRZZOycrBhjiSdf7ARxVGVoTsqfzSI+4fMLHIHoyFshyl8jBIRkytdHDiwYN3kMmBGAcz
 uPNosJ4z5VyObofP2R58+ariElENL3Ok2+OUniPFiu7NeJ9mA/BoRLWDmGr4LFUl96IgbP1jC9C
 BZloM/g3vW11+OxaNOHQPMcl5c7rRvaxiiifOxqXSWrnHJP1hTyICkOvrp9Owy2HRrQ+G0hiZpV
 gkEyDy79gvv5rvR+EQQmISqnYnlkStY98lO7Y=
X-Received: by 2002:a05:6512:693:b0:5ae:bb4b:9357 with SMTP id
 2adb3069b0e04-5b2d0228e0fmr786763e87.27.1785259623996; 
 Tue, 28 Jul 2026 10:27:03 -0700 (PDT)
Received: from Shofiq.home (87-92-160-164.rev.dnainternet.fi. [87.92.160.164])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be1d863bsm2226842e87.53.2026.07.28.10.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 10:27:02 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Wang Huan <b18965@freescale.com>,
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Heiko Schocher <hs@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] board: imx6: guard LDB clock init with appropriate video
 config
Date: Tue, 28 Jul 2026 20:26:59 +0300
Message-ID: <20260728172659.387624-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785259624; x=1785864424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ag42QFn1QUhL2dUX5hQFSJeoKpiThHSFC9aoXPi2M40=;
 b=Vn1xM0TDI/vw1QLAg3sEFCtf4SW0zczzggMJtzUdNP0CPOjBdH3QeRsPaWfQZdvIqG
 CoaQ3jvAAkfdwEk6ju0BeFBIiLgC8i2fyeOnJVaaHsT5gKCxXC07pGsWS9iPCcIR+mEd
 NIJu4lFG2KjeMR+gJre+IaUO8BpUw+fCGyRNjwmAVCVFlv+e9ZmEcXPzWGzozuslr6K8
 BOXAoZCB+617QGznx+YJousJg6nBEnlSxKZTMXKnwNl0rrvWG0XAlu5f0ZONGmhNpcJH
 +06paAeTUWTO50YFfMlQAh/6hxO4+ZP4aIlCwqAwYTmjw/n8XEo3gvbhVIT5yU0CZ6Ad
 8WaQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Vn1xM0TD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=shofiqtest@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vn1xM0TD"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Guard select_ldb_di_clock_source() in board_early_init_f() with the
correct video Kconfig symbol instead of calling it unconditionally.

- board/ge/b1x5v2: guard with CONFIG_SPL_VIDEO -- LDB init is needed
  in SPL only when display support is enabled
- board/aristainetos: guard with CONFIG_VIDEO_IPUV3 -- this board does
  not use SPL so CONFIG_SPL_VIDEO is not the right guard here

drivers/clk/imx/clk-imx6q.c already guards imx6q_init_ldb_clks() with
CONFIG_IS_ENABLED(VIDEO), so no change is needed there.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
v3: Rebased per Fabio's request. Dropped the other two changes from v2:
    - "imx6: clock: fix clk0/clk1 swap in select_ldb_di_clock_source()"
      is no longer needed; the same fix already landed in next.
    - The drivers/clk/imx/clk-imx6q.c guard hunk from patch 1/2 is no
      longer needed either; that call site is now guarded there with
      CONFIG_IS_ENABLED(VIDEO). Only the board-file guard below was
      still missing, so v3 is a single patch instead of two.

 board/aristainetos/aristainetos.c | 2 ++
 board/ge/b1x5v2/b1x5v2.c          | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 4a2349e165b..c163b49209e 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -218,7 +218,9 @@ static void set_gpr_register(void)
 
 int board_early_init_f(void)
 {
+#if defined(CONFIG_VIDEO_IPUV3)
 	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
+#endif
 	set_gpr_register();
 
 	/*
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index f7751fd6fb1..da7cb880eeb 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -320,8 +320,9 @@ int overwrite_console(void)
 
 int board_early_init_f(void)
 {
+#if defined(CONFIG_SPL_VIDEO)
 	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
-
+#endif
 	return 0;
 }
 
-- 
2.51.1

