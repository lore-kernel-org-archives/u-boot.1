Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F831C624A4
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EAB80C23;
	Mon, 31 Aug 2026 15:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23W1se0hPVDK; Mon, 31 Aug 2026 15:57:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788191863;
	bh=XsEWYn2pS5ccCgwZMDbppFlQ0g/Ikj5ACGkIXGIEIH0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iHDzwco6zYkjxl8M7liAFRWeQckDHrtOdoH03ibKl7aqy0EMyLs0JTgXXXMFGpY6U
	 njv45YDx8gF8G3Hk80fCsngZ/QaKTJ0O5Ed/l4sIBR0RuRiviXhOMeBPAWbuPWenZQ
	 6hss7cOLwehi8GYDTgfiwBQXdaFwaYc5WH1Quu0M35Y8wTJuYqqADhkAzawGJekFXP
	 XlIc8eL+b+Fi/9OiKB23ADubUF6OuuitnJGK01OPoMMZDTxoxCaL3aV8EPgdP683Wi
	 dJofDcSPlahX9uWOHyunEoG/Uv64CCX+WGBxlc24+Z4zti+5G3qzmGxyymI9HO2vM5
	 K57G3P8+2HoWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F77E80BBD;
	Mon, 31 Aug 2026 15:57:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E83022AA
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE3BF80BAD
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpGjTSmvHrmD for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 14:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Epre6i3y
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B657E8086C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:31 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDFF13F60A
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788186508;
 bh=XsEWYn2pS5ccCgwZMDbppFlQ0g/Ikj5ACGkIXGIEIH0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Epre6i3ySunaQ4QejEIdsaZ0bJdY3VrwISPfkmhV0vtumyj+p6tITyQcv4eB8Z3QN
 +WGu7KfP5dGTV4hhTrekJopWMWxzsyiOu27jum/uy0Y/Gt9TKtRxQnuUnRf+6HZnot
 TM5+te0sZvfc3FP7lU12GoLLNL4n4bwJwgX4xJCscphgs58Cj4R6y1pdeMZwnn5q/F
 DytaCNrR/HDLgnSKZL5IryknVRlOPShvMMkw1okwO2BzccdEQP7bqZeAP13J3NIi+b
 dih4j5bRBbeW/BSeAkGKimu4uhgl8ONIeZWOW9ET9xXEVXjolkYR1PKFbk6D9eCTph
 /ClNp4UwwzswbmmfJufpPPmI/whiMp3yxDURErnsf1gL7Jj3cdOQIJpArG6SCg6NOq
 ufqsWuKDjJpP9jGH3MiXQQ8/eKiZ/OB2U/xIo6jiunXEE6sLhdHc9tgWRBMEqMivF1
 d9AXkrhilFypRmEQ+3D7AsKalZqP6Vnpw7w1wkTi+58ZL882dqAsqhJcHxgHrNEpt3
 oktHN2A9pyWjsiNSQYdJ2BDJB9j1CGL9U71pJQ3KOB8lDO2OrBByWP0xDApDJxcpJG
 ZSY3oNWPmKR6RGk5o5VAI8RwmGih0y3nmGYoQvNyZmuY/UbyLVD7ImgGunP7bYggEr
 XWDwFmcpRcbhs2DLezZa3aaE=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d9057fab9eso26782805ad.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186507; x=1788791307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XsEWYn2pS5ccCgwZMDbppFlQ0g/Ikj5ACGkIXGIEIH0=;
 b=MWyURKGaarQxsrEHlpSWJYcpcvdANQwvLoZAuaWGX5MlM9iagFbJWzKgoGwCuKqE4e
 pMVJ/TmwYmkPIUXlgJCVA3QnctiLrK1hVmSob41EXZ+if/u/fe/Bk9ek5kRR9mC80Sjz
 BWZSwddQ6fV6bCrKIF+9uMWi69SxXrZA6cB8YE2zX/7YAqUxaiXeTqBS5i5p7Ypyczfx
 i9pZPf+FaBznrvqfJ6KtcP2wonmmHAujbnaBBv+UX89EWYCtVkAOuQLWAZVrrjQ7uxxa
 5u+uL+0YTFKIdfqak0Qv+n6qpcuOvrB/CGjNBCTHfxcHZpPYzglh20AHUP4/pLL/QYgC
 5J0A==
X-Gm-Message-State: AFuF++l610XFVFJ837C7I6NOJaOeovNVyRp2+W9FXBYxYaLoDiZDEW1Z
 RTPAnjcADZMehrGwVsVeunLYw/cb8CmgB/AYCAHPm7/gxfRy26USomKq1sCzmjlLLpZpD5IIXxi
 vgqtmQ7BIKR43pkI7XHSFns9fSvLQDOj0f3g9tx0SX2fWF4EMTJx22dU+s1+oW1OQjdJXvOYU67
 vggyQf9qGxmKekcvyIeQ==
X-Gm-Gg: AYBFou3WkFcNIOkt6ZHW2yWU24taJuo5DyhnjMTdphUyJ3Bwl3tpFLPbSZLf2bIIZ26
 oTFKlmbUtxmoGk+b+ywSFLHozPsTEYS4MPGe2CvjNXC6eSNYSldwqU/W48/I82LeNNBQosIeVAc
 ecUDOgas3X93D6IamDvL1LgvwxcBUS2gohQWXEVml6xQhi4Tb3qPoYqTm2qd/DrpjiYfkQTy47C
 AeSLeqpu68jl1qy5au41rihkaYceMNlWHj+Zie2zHeNjbefwAgjfnET3Ii5fQLN9RHKCP86PebZ
 9ebFQVmKxBwN2cM+Z+yBLPix32ac7WZ1hx++Ewc4pkqblRKLwe3AKdwMszz+Hovrlo7N5lQk3FK
 NzdWMbMnSqw24VvmBZcdgw9n21ttgFi2O52wso1Gl02vdSYI=
X-Received: by 2002:a17:902:e74c:b0:2d8:d4cc:5bb2 with SMTP id
 d9443c01a7336-2d8d4cc5dacmr256568895ad.18.1788186507180; 
 Mon, 31 Aug 2026 07:28:27 -0700 (PDT)
X-Received: by 2002:a17:902:e74c:b0:2d8:d4cc:5bb2 with SMTP id
 d9443c01a7336-2d8d4cc5dacmr256568295ad.18.1788186506837; 
 Mon, 31 Aug 2026 07:28:26 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d8ffb0d341sm22798805ad.47.2026.08.31.07.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:28:26 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Denis Mukhin <dmukhin@ford.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH 0/2] bootstd: rauc: Fix stack overflow with over-long slot
 names
Date: Mon, 31 Aug 2026 14:25:38 +0000
Message-ID: <20260831142800.25966-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 15:57:41 +0000
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

This series fixes a stack buffer overflow in the RAUC bootmeth. The
"BOOT_<slot>_LEFT" environment variable names are built with sprintf()
into fixed 42-byte stack buffers, so a slot name longer than 32
characters from BOOT_ORDER or CONFIG_BOOTMETH_RAUC_BOOT_ORDER writes
past the end of the buffer, and even a 32-character name overflows it by
the NUL terminator.

Patch 1 builds the names through a helper that rejects slot names which
do not fit. Patch 2 adds a regression test covering both sides of the
new length limit.

This series is based on next, since it builds on the recently merged
"bootstd: Fix crashes and memory leaks on scan/boot error paths" series
and its bootflow_rauc test.

Aristo Chen (2):
  bootstd: rauc: Reject slot names that do not fit the env-var name
    buffer
  test: boot: Check that rauc rejects over-long slot names

 boot/bootmeth_rauc.c | 42 +++++++++++++++++++++++++++++++++++-------
 test/boot/bootflow.c | 23 +++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)


base-commit: 856a00aeb61c1d4e7825257e54219599f8e34a6c
-- 
2.43.0

