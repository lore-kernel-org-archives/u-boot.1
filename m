Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F19C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 15:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 357DE40993;
	Wed, 22 Jul 2026 15:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0xLOzUwykvFS; Wed, 22 Jul 2026 15:08:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5CE524099B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784732897;
	bh=KYCv0TH+vLQGMgOItxHRcHZFOF7Do+YGFAISWa78WN0=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=UyJpzH8KoKeibJNgVb+Pf2i1BXYWLvTcXQN6SRy8kLGOpBtYwuePH89fqtsNE1Oqd
	 nheUcKuK/hK093r+g4wKviu9L3O8ByNND2mjvmwONR0TUOj9s2BnUpvWrRvj3sFcxY
	 /5N4DU82ktEgKE/s8f3lXGpgwr+ordEcjPBUPar/d6fwLin07EDF8Eo6c1YWfnIzrf
	 ZqOIpFbWv/BLHg1h93LRSTnpOQ5+Fgi7nFxk3/7nnh4OZtqFJl2LvfcS4OMs6pqYUT
	 dyvLxH2i1KhVbZz4iJkWLPzFTC/uNH+r2P5fWLXK0/ysoCQ4WZmsdyNO8C/A1bBJ64
	 8V7pfi7JW5tVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CE524099B;
	Wed, 22 Jul 2026 15:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40536313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 323C3400BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZFKFlMu2YXpB for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 15:08:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=eric.chung@riscstar.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CF20D400B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF20D400B8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF20D400B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 15:08:12 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2271D8494B; Wed, 22 Jul 2026 17:08:11 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8382848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 17:08:08 +0200 (CEST)
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so127887195ad.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784732887; x=1785337687;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KYCv0TH+vLQGMgOItxHRcHZFOF7Do+YGFAISWa78WN0=;
 b=BIhnyMft/lYyG1LnixtKIxQCjECi/WZ+OpZi7j71Kmw6dLUvEx26VBeIMmrQ2L+PWX
 E/4Ir2euBd11whZfgyc9RBiF6E7FLPCqRJhcowVDSG0uhsCqOgAWpBNtjragLQd+Tw04
 hNzz4yqcj+NwXio4ddfyC8y06nzgF1o2lnjmtT5QTiU3JnhG0v7QZxiA382GfXez1pVD
 aR9THG+hc2hgVYqQ3HeMz8WWmYDH16lmSGu5nxxavdQhRIlkM5+ZBSn8pK+zio/dpqIC
 juA4f8qYrhjMEZXATF+L6RhPYbRoce+OwebDawAyN97xGIzyoHdQh5ShJmGcaYZRa9fk
 xgPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgAUSvZW6nWY1IJdH50tSWsGpNk1oFRJinC7Ez9pxie0wgDB7DPyagQbF7uboF1wJFAIrWKyU=@lists.denx.de
X-Gm-Message-State: AOJu0YzGRK8yXqDRA7gLnc4XSuZP9XkA7HFcEH5sAEH0gdF5B3OSzoMc
 imiRMiIWMMPWTO28lSw1oedSNUpE3LhBxRPytyl6xW82jhSC1dmFPNtm4IBut9sV4Ts=
X-Gm-Gg: AR+sD12PGKYIhUKQySFizsaL6e73efvuPRMQPeQlwmkdxLgpVICeblyhXtmrH4qz3AR
 Of8N2b43yvg6Gg+kyrzsGTtPiguIQH7aQVHUnIILrdzMxQnJlXLseba+VRymrwhEwuhDfMtv7TY
 LVLrrcuAh5O56kgfKaJlpqqRrCUVcejxrKcuq8uieCT9Kkh5R7ROQvmg/fc9+K5CkRVza151e70
 JKjigwWGMNDZ2+H8JoU4YxyP6JdT0VZhG+jqyOJJ9+PlHX9rNl1VHy7cMxvDTk1h/MluklSOe6z
 yPQGxAJvU/7bEsnCTfNHlITxd8gVqXn+oYc04dmnYIFEhaMYl8OKpH75qTlYD3C1nyFSwdsi3Xy
 XyXWtrITrmtHBf4zSU1ZsOoU3HBFIaYH+M3XhaRMU1iHec93sMtWW55qgsxAIRK5nF0mAvBjlVK
 atyUkhXXDQLW3Ck5ShucXgZU6FeQdRVr0AtqScTDy0GRMTHkTDStAgXNDgUIIf8kI1AHvX/FA59
 Si0xtcMCO5o5+0IOs4HkLcRxfabtJXsMHWWFavHBeg=
X-Received: by 2002:a17:902:ef01:b0:2cc:f5b8:4c2e with SMTP id
 d9443c01a7336-2cf348953c3mr268291845ad.9.1784732887279; 
 Wed, 22 Jul 2026 08:08:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e088d3fsm10622267eec.25.2026.07.22.08.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:08:06 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:07:04 +0800
Subject: [PATCH v5 8/9] config: k1: enable ENV support for eMMC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-m4-v5-8-c41a951e5157@riscstar.com>
References: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
In-Reply-To: <20260722-m4-v5-0-c41a951e5157@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
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
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784732887; x=1785337687;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KYCv0TH+vLQGMgOItxHRcHZFOF7Do+YGFAISWa78WN0=;
 b=ujJ3mTHn13G3cT7H/+YOa39QYNAdEmACVrRBIYPgc4o39Kp3ndVqZ/z64bnApDgPia
 XsejBMYspYbn9l94/RLxa/DTKIfQD1I6W54wdzH5ZkCA5kxvE8wIvspa2hEGPB6g49ph
 8p4XYDYuKk3hWIbltYApOEQ0gNq+jsxjHLaETm2Y4gjIRuPOb8Lmyg7DKnKBfuhm9/7d
 56VPhH7ufEd4ziunYTARuWgp7nJ9l8vTxOPfZIjtOyte13yLT1KUU2re7J67J+UhZ1HP
 ocFAM+Tkjgm/vzqW9omGxffbH88oICFPAFg4M864j8daE9cFe+bq1dg18M5wtvv9Ansc
 gYfg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ujJ3mTHn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=eric.chung@riscstar.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.b="ujJ3mTHn"; 
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
From: Eric Chung via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Eric Chung <eric.chung@riscstar.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable environment variable support on the eMMC storage device for
both SPL and U-Boot stages.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 configs/spacemit_k1_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 33cc881bab0..6cf322cc194 100644
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

