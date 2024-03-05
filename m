Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E09C54E49
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 02:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43FAF87FF7;
	Tue,  5 Mar 2024 03:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a90fZhEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367AD87FED; Tue,  5 Mar 2024 03:11:37 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9769C87E92
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 03:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=twoerner@gmail.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7db1a2c1f96so1756698241.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 18:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709604692; x=1710209492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W28/5Ls6kcQhHXm23yDl9dSc05riOo8L0UF41hp4DXw=;
 b=a90fZhEQ6yZ1Ft4fkPIOf2TMOJfjNpFne6qmGsbGLne3oNGhKCzocSSxwA5mec+aTc
 6a2ULukzNaEPaQR298kOrL1+yctmZxAg11bKb3n336Fr+bUUHM+o/ov06UPHVqVSu49I
 EJjTiuaRvJTKZBfqENVUIANdI9HrZLTBdEcK5mxJqyUbNYVwWUUUHp6tCYNRM8zA6UIC
 Fh8hPXttzLHo9bmBWEThaGZVnnVK4aXECqK6BXkbZMbXRV0LVb/7BMzBBjEwV/E1fq3m
 vxGSX5G8ul2UtcCzF3YH4/a2ykQIvW+GMkBzOMF7JI5uLW9M0/RbBdMXk4SSYdpAYybu
 /WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709604692; x=1710209492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W28/5Ls6kcQhHXm23yDl9dSc05riOo8L0UF41hp4DXw=;
 b=JGYrG0FwRcGi7ESAjjqp06pPooro59Ju4bZoy9XYbHum3vhf1Nd5QjzfqD1+n+mGN1
 SYgjd1u+h1xRJ8QDX2NTgsD/8uV+KcqH3DGxpJzVQ9j0CZaCXtBH4KmP4PlsCpH6v+fb
 ied6Or8SLZ865XlngFc9RAmZR5CiPpVsPNcxrPK+XufH0Z+ALwGI4u3RJCCASQDkEv05
 X7fo2a8oIJp6RIZLoZ5tFeP3CsSX7m261tE+QqTT9TBYv5xGxcWPVcUrwGhpmBusHMs/
 qaR900fi5MvNra6KDErN0BwnSuztwct+/jqLbS1bgDZk3cJfaTAbtLKtOn0PB133V61A
 AIEw==
X-Gm-Message-State: AOJu0YxhguuxayTnFzGD9U3DK2MzMj+c/kZirHPuBSaoDncBmaIwncxk
 Dx814RrtD5JZKfVzdK1uKk8D1b5YtsJc1dypA26V+SUQjTDF9vAhILurDuimKUA=
X-Google-Smtp-Source: AGHT+IGJURd4bniwJjmc5gtJbfqmRbLAk9llr14UthoVdUznNog7/US3tOwdJYAMN0Df6O2cYvcSxQ==
X-Received: by 2002:a05:6122:2a10:b0:4d1:3f5a:75f3 with SMTP id
 fw16-20020a0561222a1000b004d13f5a75f3mr515286vkb.15.1709604692121; 
 Mon, 04 Mar 2024 18:11:32 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254]) by smtp.gmail.com with ESMTPSA id
 i19-20020ac860d3000000b0042ef122e15asm1558534qtm.12.2024.03.04.18.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 18:11:31 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH] configs: rockchip: rock5a: enable environment
Date: Mon,  4 Mar 2024 21:10:45 -0500
Message-ID: <20240305021051.22405-3-twoerner@gmail.com>
X-Mailer: git-send-email 2.43.0.76.g1a87c842ece3
In-Reply-To: <20240305021051.22405-1-twoerner@gmail.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
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

Following the pattern of other Rockchip devices, enable the U-Boot
environment to be stored in MMC. This patch specifically assumes the
environment will be stored on the SDcard.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 configs/rock5a-rk3588s_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index a6471a519514..ac6411667d9a 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -8,6 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_ENV_SIZE=0x8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
 CONFIG_ROCKCHIP_RK3588=y
 CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
@@ -48,6 +49,8 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-- 
2.43.0.76.g1a87c842ece3

