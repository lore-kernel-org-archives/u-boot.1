Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF64CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44AD9846E9;
	Tue, 19 May 2026 00:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="u4XMPoeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7DB846A4; Tue, 19 May 2026 00:29:35 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E6738465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso17344725ad.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143372; x=1779748172;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zlkJRKXFBvHf2o3qlKagnigVOclJ0sNYcc9facFglNU=;
 b=u4XMPoeBcuQLujITT3IcI5VQPDxzeg/xZMb97dguEcvth2GvWCIK7GYRW3hS+6x7sT
 D1vVLfWMY9l/v5jdRpug/bKPvGvvQgUQXBrTTSnOpGAh3fNLerbzPOlhaLmWJMwaNi2h
 Bg0lTxWYgEaMFLj6i1oN4wxhFTksrvqmotTf89CSpzjuUD/dbd6UhMVgjqKM7F+uiEy/
 nfpb0UudBqCZyqysSYjXse/pERRKxYfPxy8KSSxJs0owvXiFpvskXvU1LFnouMmeWRpx
 w7zwKRRpkspXZlOWsmWWtTtmB5vao9A3AKx5d3S9z0OI6JlRWDAwNYh+ucAmlU9Gw8Sb
 b3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143372; x=1779748172;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zlkJRKXFBvHf2o3qlKagnigVOclJ0sNYcc9facFglNU=;
 b=ExranE8POKbZunWahbSRaYB4aIGcgcqSgVsHG4Rqatk26eS/K91oS18Pn5jSb4uC3b
 9Lrb9ivyFNM8eNnJw5zhX4B0PieUOc2AG15xY5Rak7sUXmzkbWBZHc1sVydEjJpkaUiV
 N3Zlsle7tHgJIW0Qu31MKuEAhbjqu6dnSbYcaqKWsFIR1RxDARUCTAgxSOpwbJWh0CEa
 BLeEyJQH7PwjO3SWwfBZpFM7zdJXsSkcci+awp88xsTZ2a2h4ZjkO6cyF5JXGUbPbX0Q
 DKPkYexyb9Wtgj1PkhPZpyQJHNqT8+rmX5bOB6aY/a1AeKiD7p6g+rEp1B+tlWXNwlb4
 yyZQ==
X-Gm-Message-State: AOJu0Yy+VGxF0IfhXFliWxYv8uTVJHqUrFpr7lWQlyG4ceAM6QLfClIE
 Lt0bE2Hq1dwVnv+0hla2ktRd+lhGxYBgQf66AxlLzzxx0CjzkCgSoRRRKvWfqv1pJsY=
X-Gm-Gg: Acq92OFPZ0ZpPaOvzlx2njajryxngfEVDa2tc5pnd88eAkeEIu9VLkFBKy+zJW7IV/A
 lUhskIeiAc8itxHeqdg4njpaXZzKxX3L50brtyRz+GYdXCZoX19fmo+hI/o3yjIC2TFz3A2/X8a
 1oRp7/cGysV9nFZSY4nhBNXMfnGHfYx3imwGaUK1wWa/vXuRohT7jNJPtRcr0igpoSqnR7ZmeEQ
 d70utc89SL5ODcQQkm5Mu6CB4l1VIaXKeS8bS02RuIkOkNvnrRwdSTrg2w+YKqFfZ9Czfl8LeAi
 Pss9TceQijTil8RUssWEaJZvIFlPUj77azF6OkDyx3u6RR26rYhxPJSv9eGJtBrMbugKMQ57atz
 QkRBzNFLRQ8gQVGliVvkOQ8hWkN0p4vUjWr0B3CuHiv/cmuW4CkWGmKRxD7QFz2x2wXhbpnN2dq
 /mIlXPAyHDWU3xXNuZ49nVaYHRUUGkT2uAtGGlS3+xqF0=
X-Received: by 2002:a17:902:f788:b0:2bc:f1ef:2e64 with SMTP id
 d9443c01a7336-2bd7e7d683amr192736605ad.12.1779143371824; 
 Mon, 18 May 2026 15:29:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:29:31 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:23 -0400
Subject: [PATCH v4 05/14] configs: k1: add default option for clock driver
 in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-5-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

Add default option for enabling clock driver in SPL.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
v4:
- SPL_SYS_MALLOC_F_LEN=0x4000.
---
 configs/spacemit_k1_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index fd0d228992a..23019266103 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -1,9 +1,11 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x5000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_STACK=0xc083fb00
 CONFIG_SPL_TEXT_BASE=0xc0801000
 CONFIG_SPL_BSS_START_ADDR=0xc083fc00
@@ -29,11 +31,14 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_SPL_MAX_SIZE=0x33000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_DM_RESET=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
 CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
@@ -44,3 +49,4 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_TIMER_EARLY=y
+CONFIG_SPL_LIB_RATIONAL=y

-- 
2.43.0

