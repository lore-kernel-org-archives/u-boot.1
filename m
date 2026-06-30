Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D82C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B784884ACF;
	Tue, 30 Jun 2026 03:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="wB13a4IA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98F18843B6; Tue, 30 Jun 2026 03:19:38 +0200 (CEST)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com
 [IPv6:2607:f8b0:4864:20::1234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E11384AD0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:19:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-139aff562e1so5762144c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782374; x=1783387174;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FX/t+/Tz1m5bgYxCfvkFudd7YChlu5BvLNQDcv3W8aQ=;
 b=wB13a4IAvinTpgijn1z8zlaYl2uaIrpB86aT3icPRlocxG+sj0cPlPM/LaN9GKpBHx
 /fUugaQmwZVFFAxQcdoW6wJE2PWsHhlB4WyJlwUgMu+vdq17/S4Jxfk0uqbe9AxYhKUF
 bNK2nrlXu6eFvOzN2zTUWBVTAVgMcIa8ll4F/SqOdOFlO50WHB8qxjpa0FbP/67mSgRR
 bdXf0Rta3JlppgQtySuilGablWl1dnPQ/aRY8ndj1t5+A94SJLTgsmPu6hjtQ46arGNJ
 PDYBoMwHShWgw4L9xGL8HIzKRNgczUaOFP0WnBaTXdQl0GGE3+llAVqhI4ZQubwGg2hN
 2XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782374; x=1783387174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FX/t+/Tz1m5bgYxCfvkFudd7YChlu5BvLNQDcv3W8aQ=;
 b=ND/faqKv8CzDwDtpuLJWO+3RibltxeBGVqUOCKViAiaPkdVriDFewmphRG2cIe4whU
 f8GaHdm9xyxf7nb9815A+ClKOIQqWwa+IiF+Pea8ZkfIQZWsFrnZz7NhV5aVk6aKzQzv
 BDlDxyoMBwOXEd/Cgv4P13UDVbbOs7hz/gawi6Ba2HFuP7tRf+beldW8eNafyFHaIpnA
 vis3uuftqDsMWt3jalawOD+Tcomg51KlvrsYg8wnKgtai/6rgjkDilIcZbCfqEiFPcuJ
 ba84CEwkg3FXjmUvRIPXRLk8xjEeHqWGIyRw17kR+8cIKgZFA8jzsE0OnkkH8RYTQ1sz
 4/ZA==
X-Gm-Message-State: AOJu0Ywko00Y7xEkviVxZfWanQS8bVQFaubm5yj/DQJcYxS/xU8ruc0X
 2yz98cnFodff6Ts/Br/Kz1GIugSyC1/CsplryfUfD0khczffX0bKsIQ5P2n17TkjZSk=
X-Gm-Gg: AfdE7cm/fWm4ymWqeNPGaSOM/cFWQOu7S0p4z9KqugacwrmNepsKYCxjidcAwTyp2rU
 LcJRyxriYTyl/CHuCRItx9VlTsGWOguzGwTcJ6YIH/7yReHezfoGPAxKmb/my3Qxk252GQ+fZRP
 OrYnrqluy3UaTxnuqGI5eDwWYslHiZMsSQN1Xauz2mEN+3RpO2CLMbho9nLLElnfM13vNDjkTNR
 qggtORt5j+FQvOMtevvbDUVHuABU/WGuds7YQTXbgrNUnQMY5li6DdcIMcf9anKwEMB7YhwouJY
 CljMa4yGCGV/SM/pnUSMVmgGqa0OSUvyiAdV9ZEvPvvmDq9zp2Dc5fn22S3eptiGYVrUrfN9QDL
 e0uIKcLx/F6xwa+Ypout4woEoa99h7D75dfxoJJSJ6VE0OwsSIc5Hb4LW8iOD5zb6I3rojNHqnm
 h2w6UIs6ufN3H8bGMsLcn0ehv+O0DgfZAu+CiZUPQ5Ou6w+lzJjN6howu19SecTPhlVq+AnMBSu
 nHJ4pmj9tzTS2GYO/tfS+0HZbtYvk+QhYo9XHQfq7n8PpcU4cVq2gW/aObXNLPX
X-Received: by 2002:a05:7022:ef11:b0:139:c1a4:cb87 with SMTP id
 a92af1059eb24-13b2a16120cmr1083087c88.11.1782782374350; 
 Mon, 29 Jun 2026 18:19:34 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:19:33 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:04 +0800
Subject: [PATCH v5 03/14] configs: k1: enable early timer support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-3-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

From: Raymond Mao <raymond.mao@riscstar.com>

Enable CONFIG_TIMER_EARLY to allow udelay() calls during
early initialization phases. This is required for proper
timing operations before the full timer driver is available.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 configs/spacemit_k1_defconfig | 6 +++++-
 include/configs/k1.h          | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 29050ece278..fd0d228992a 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -17,9 +17,10 @@ CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_SPL_RISCV_MMODE=y
+# CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
-CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
@@ -31,6 +32,8 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
@@ -40,3 +43,4 @@ CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_TIMER_EARLY=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 15a40f2128f..e09c3594905 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -12,4 +12,9 @@
 #define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
 #define CFG_SYS_SDRAM_BASE	    0x0
 
+#define RISCV_MMODE_TIMERBASE	    0xe4000000
+#define RISCV_MMODE_TIMEROFF	    0xbff8
+#define RISCV_MMODE_TIMER_FREQ	    24000000
+#define RISCV_SMODE_TIMER_FREQ	    24000000
+
 #endif /* __CONFIG_H */

-- 
2.51.0

