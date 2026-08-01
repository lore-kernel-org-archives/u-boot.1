Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247AEC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E402280EEB;
	Sat,  1 Aug 2026 16:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7XC8LV2_vKRK; Sat,  1 Aug 2026 16:42:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A13280E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602524;
	bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y2B0n5RZN0WPm7jnFfI8RNZasSrPNSpu7o7VBhDVC/FKy3/b09dCpkd3qp3uWRiC3
	 c/W0JN1gMYGRwBpJhDxVxID9NWxW5mmcLqQLR4XO7yu3MrCdJ2Ppyn7pAQJr9VE86E
	 yrzYat6I9N8D6eUiBhVkLJtRI5aJ/O0CH5wtO1eoQjrSc60I9ju8mWhl1+e2+nZVUc
	 jdmzIkQurCGKfa6AUXSaRdRwg7OemnssmKHnyZs4NKMFoegkm3MwrUSlxLJm8XfZA/
	 JqJMK5ivfevtk6+rOhU8cabMc5NS84EOncmel3PXItnctOwcyyE7ihNYr+f/oJKypY
	 qvTuyBudPRp3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A13280E42;
	Sat,  1 Aug 2026 16:42:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 35FC826C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27FD86070F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTfbzwU7sREO for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:42:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8ABD56070C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ABD56070C
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ABD56070C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:42:01 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c981c2c37cbso1496742a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602521; x=1786207321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
 b=AMCys09BDsVjNnaHQq9QzV/ZXGRPr6CAl8MYVGpY5tBA8EsWRLolR6xZj/s9fWCDEr
 cvaA3t5uL1aJzo7TJpBFCY0K3SFywN3Kayt97Q1uGvWfPx4RDmOSw9QUx8TLUELE7+Gm
 zite7AxsFsfBpv1y3ROG5wEgGocrGgYY9HmOob855E3biGHjsMXSuesllhSNF9YqgJ2R
 RvUlowskhU3dwCNNpSlSGsAM3i2DEe9fN3ZxdN0VFzAAYceZKVHR5gZaRe6OSRyWFu3V
 znW8xj3SCjgFVWADuyuOEwvFhcdJtMCqu8Q53e80yTMHey6EItVPkc3Iqd4DeOYvidBE
 SP0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIPfGhHq1r2b49OBQeJZrveRIbxQc8KVfIAUs+f2kzIZgLDnxddp1Lkga0LfNpRaNd2Igf7HE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyKKCkWnpQeRHtnwYsZLIs+kag/54kmsBh/YuXN/uRS429jtyD0
 ymQ347IXRKk9MFStcxvNaA40TC1Cc13RtWqEUF3TEGSnlywb3fQNldkXHcOUMWInTS8=
X-Gm-Gg: AR+sD12R3OIdHy1K1wZaa2Eeo0G95kWcfVZ8PaZcqXcxh5ivGjDKj5nDXp3Vf2Ejhak
 U5jXI0Hy1Htu2DwH831BPi2T+WFAYLmcZm4KwIvcji6aQZnp/rwWFzkVuLwVX8g4h4jmZ03+EBW
 NCItprpDQplvPiOg+9dPcoma4gcBoeEBm8T/D/fWOsJvfpjKwlpg8AJDJcPlGVitrThxHPA9UCu
 w2Qh5OwS9FryPDVx42kREVpk2JMAnn2Et0anRtv/5AlUjwvYLfg7RaSnyT7/aOtDateOegXwQs8
 SXVJLw1zCbZmX/RGYroh0OUantLAty9zyo2iN1uMSjSO6XKLhU14OqB7bktyU1+jzVAeRTptYAh
 4L/ruM8gv9h3ReOHM7+TOOjXNgAkpOsFgQYvvC85sdhnAJsWfVXUy1p+alips9+nDkhW4jVtQOv
 3it9fQeWpzQyYktviUovtZn28Zr5zeHz+i61doIGrF635G8av/cugfKqbAYJPGjm4Qpwa7Gz1mb
 2icHSfmhLy6MJJeB0p+H6QjgGGCsGrST7zDk8NVy/OAL7++BKZjNckQafXQPL3mlxRD9KkiEXKa
 NsRxvAHAKRXndFnEk8ikz27Q3/A3oE2eaEBm
X-Received: by 2002:a05:6a20:6a05:b0:3b4:7eb0:47a1 with SMTP id
 adf61e73a8af0-3c92a53b04cmr3915699637.19.1785602520759; 
 Sat, 01 Aug 2026 09:42:00 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:42:00 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:51 +0800
Subject: [PATCH v8 10/11] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-10-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602521; x=1786207321;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
 b=qZDAXfF+TNpYdGvSYA0ZpeBffiy1lgvvb5ijS+s1EbnOxS1g1POQ3OonKEm/gWhYHG
 wDVWzJ0lNVjygdaOHYLJpxcBM5ySD0gdJ+IqnMyVag88j+vsfQ/satSnlYjB6pURHJSh
 aCiJgreOMOvRia98Hb66rLx2HRifr3DcoXbqngZxfc5Fc7tYo5oC7hemTx2RcSZJ3CJO
 WEKeLNwtLVpqCqwcbe/EICGncHrNv1pOOM1f/u60SbOOSgjIS0RXVOmAN8Yb78807f92
 /bUZfHaDcpqU2lBYRyJLX87mH31AeCjXtKbRwrIL+kk900Z2Z6ptbAEAH4WT6/YRGtu8
 1pQg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qZDAXfF+
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

Enable environment variable support on the eMMC storage device for
both SPL and U-Boot stages.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index c0ee3a29f233..7caba18ddcdf 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -14,7 +14,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_STACK_R_ADDR=0xc00000
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x400000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_SPL_SIZE_LIMIT=0x31000
@@ -48,6 +48,10 @@ CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x60000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
@@ -111,5 +115,6 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

