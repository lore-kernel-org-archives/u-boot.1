Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE5C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EE1B60848;
	Wed, 29 Jul 2026 14:49:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RdDk0rsHf4vB; Wed, 29 Jul 2026 14:49:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 592D0606E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336587;
	bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uh7TwKuaVDlhRtlV0MWlASk4OW39c9uugySiqJO0sdJuC5J7nNwa72VbO7bfxcAQd
	 NIy2CG0B90hzqVv2klvsHCe1IKP6ExeGp11IIiTRHcBZhhgvJxP22oLpMsSPPEVKxL
	 hxsbgsIdVW07z04+Z8yKCue6tqFOMkkcX0o1YbXP0iI9MG2dISrMBybu1Ku+yDVPh6
	 9ZAp9cSILhEZ+yeQU/fIqf2NJl9VKl2hO1wWRVcZXxNbTFIPH5B/zUJs0iLCHoElwB
	 MAbj0ti6IjC2wMfLNwzNtMIp+0cCLPeMAyJc5tpCv5o2+TP7j6cqk2ALcwnvgTMAQw
	 IQ6ZI0/yU2bxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 592D0606E7;
	Wed, 29 Jul 2026 14:49:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ADD683B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F8C180889
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V8EucK_Y3F3p for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B516680880
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B516680880
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B516680880
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:45 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso624859a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336585; x=1785941385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
 b=RQvW7YP9ParXS+n0NhuW4kqqo57Tpo2a3PWxyaTySY0xozxfkZSBjXBfgme15Xajtf
 w4oFD6AsWxrLX7pQmJ8qA92o9hkYwghTS2RGvJG1eQeB2/3FMMiA9zWGXzsxAL8fWN6/
 nUSwIMUfy7VlBMiGa3Xr8lL1rQLnzm7J7rIeMwX169h5s2OpoZ6Ff058jvbsQc6FiEfS
 Ai/AqDyE1Gejm9aLGoxEp1Z7LweqbH/4NXUNi1TRiFVBT1rqxE0rmywMPfD1mOKEoknq
 43Dqh2r3OjJ3MqYVINyANYeYibtqgktFeoYLClok8/IlwNKBAQ+3cMIjZZLeJ5v3VZb0
 hu9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK5Rdu+UzSkVLaXmsUtzWhrdJU3B1ktyvlLcb4KoI6HXTWfujg2gHUk7Dr7ZNZdjDBCLaw/TQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywesh5S8p4MJNp6ASEC/U0V983C2O7a1wNWEUKcPc5GNaWrquCE
 dDAeHAkBWFeJCQAqxzslVY6MeV698nR/rYqJyTyzVnLWYg+59WC+UquXYQoE8pBBQwY=
X-Gm-Gg: AR+sD120LFhu+EZhM6dtwK5PFjhQzKAhphhBcyp0JpYdPt/hhpQ31XzSuNiAGWPw+0F
 Rlubxes4hW+GjzYo2XWxmv2newIgb45R96y/bAljq6q9CKkX+O4okpcaPjGbu2XVlgqN4e/sq6H
 B8eZ+FvggCxBgtD1WpnaeYrskF2tKF9x8kfCvn7q3o1uiR/vWelrCJWbQNFHS35mOFDVEsSBLhk
 RYx0CFrqxyOYPLO6G63NpE7wU0Ttb3GQC7J0ApJEofGJCVhr1jfWUQhmJQIoMJdqT2csz0dXLwE
 BQnrd7TrKTmJPMK+wsqt9YLCPb4cQe4HhjozGeNgY3SBct7Xy1TSod6AKHGSI9Y060/5I2PCVbL
 WgRD178IMptCKXOXtBWXZTigDCvTf5Jcwk7fXnkxXXk08p//zZku3gEBbW5BxAFvJBC4kF8N5nK
 MiSKM1pLRB3q6czSjDwHJ83mTmOBf+7jwaW/IBiKnCax7GwuwabVDx1QTF4/O3VUzCp20mVH/Gf
 9PuD5gl/nA3WX5G/dj7qlqVa7sjRH15Uw2XASCr8QOuH5xmedwg3Ac/NWjMgBUq7eiQRQoQEpsy
 ZnDTMd5MHHVVvEZHqZhEYcDx034qprxA8PW2
X-Received: by 2002:a05:6a20:549d:b0:3c4:4297:d5a0 with SMTP id
 adf61e73a8af0-3c8ba5ce034mr9436692637.40.1785336584891; 
 Wed, 29 Jul 2026 07:49:44 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:44 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:28 +0800
Subject: [PATCH v7 10/11] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-10-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336585; x=1785941385;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UEIHXcs3ARcHiHzzTcjbQDDpfXlJI63ynkWCxes11dY=;
 b=sKt0C4oWRwlORBI9xnRHQFllgjSTmhWIEk74FyzIbQh4y6GSsQoTYq3NECFtQ/WNF3
 w2pntwVe4Ve2yGbe/dn8tRDlbQ+tuW+SJNzTAaJDhgkPSGCuYXbdBSFWFGJnspi7PB++
 Okak4UUK12S3h9M4LcEoOBuF1+k658UiVXJLGOAmcleprIjBpVq8fkeEt7UytOQ+nLAT
 7HzvctdaM+IBz8WVA1KPsrKV+jCX6nXb2m6o7MDOgXowfdroQKwzJ9zm/qCEVMtdYo6U
 SyT9rCHX0ZrjmCpJovV5N6K8dwX9YgE09E0QzBlgh241x1NWgYyOrCv1GH2SYtpLoC1u
 andw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=sKt0C4oW
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

