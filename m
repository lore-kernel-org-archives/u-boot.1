Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCA0CA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 22:21:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC9318100A;
	Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bxO-anlJ0TWt; Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A87C810AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790720484;
	b=UzHJtni7eG5hZKjCqCgPaA9CXyX1zThh3YNdcwDQXkYB+KL0sQF+JRiDP/RhcUu7Jm+8
	 L9bxVIkuiBA6OUL5ErgYvZS9K0j1twihTOhQcGJcegl2PQKnCQ9SUtW5p7rp0+tuUZoi6
	 OGUlTQktF3oh1J0mIaiLvsMUoqlxzuTNn+lSuWsDAFjG0RMmzk1D2QTvFoL5tl7vLZyOn
	 QbpW8HTsQGhUnUy14b2FMaY26ovipTZfmpd0EBAdp/Cg6pUDqAsBA7OedHD6gmamuaNuQ
	 3qtaV9eGC5UJiA74qWhUp6Qyxh9xqOob6qNeUM1R4310avcJEWg10uWc7rWLOlz9NfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790720484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qtG2uffV9RqCs2C+wVmXuMFmth0jNqAb/8vZc20fNyI=;
	b=sTZDNXTMIN6KN0S3hOxfcwAzdqKCfQMJl1r1GAdyxCw90n8H8oOyv7ExB4Z8XslSwQCX
	 j+jvZrlwtK8b8kXOyR6BM8+gnAJwGyq3znyekjQKVeglnQXGVDstMXU7r2CzK51YS29cH
	 WY8n1MN3OFja8Ago5QjflSsTeWcSrYwBmA6eBSq2L5Gtjp01VEwdWoJ8WF0klWkOqs94Q
	 nkSjKnpTRd6giCe31kwUa6CrM1r1xBq/AO/4brnG/1ejB8c099QxtX7rKVySKkla5Ni4l
	 8bbWWPzRXWTTeUxxVkUhnQaZOr5hCo6FqM4JesHKRMKKzN2UQFm+71HZyYgaDLW1jSQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=L8qeEZtI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790720484;
	bh=qtG2uffV9RqCs2C+wVmXuMFmth0jNqAb/8vZc20fNyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VC8BsKGmJSlqA+EnCPpdOKrvb21aJwFHiYSMcKwn735ztD5CAgR3Drm/SbYnSyjv1
	 O8qbnwhUi0y0djAXKpCzO1+cvNtrtclUUdPkmSX0dqYWaki3PjnLhxg9SMtQ5nzVM4
	 xgXDxTqrHj9XQHPYqbbHQr1JoOVwDLdOdbR5Q/FRr16DUXTmU9LRFAcflfPCEOoP/P
	 cF9I7EYM3PmsF/bOUQd7sFiesoVbBOLcmwircNXgiW3NQWc8qmlcc7JMvwZZiH1nM8
	 rLZ2fPwjLKdMKNnSFEQMmsH+Nk0ZcuuH0UAD2QtXMuJATcMZvu2meDZtPv9jSpFkUM
	 s9eMgi8AfSqDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A87C810AC;
	Tue, 29 Sep 2026 22:21:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F48433B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09EF08100A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jpRXY9KdVKPK for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 22:21:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E9580810A6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:3a::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790720481;
 b=lgikR/2vHyM6B+RCsx/TR+ahycsPXtmrHxAmG8NTYK51TsQngHQZoCu6A66Pqn7e5Po4
 dcGDtNpi+UdifzfX8b8xW/s5FrnxcgC7Sa9NpFbxWa4EQ5ABiN5fxDKHHuHeHjofPr25g
 gGAHdgBix1PX+K17MR1w55fF9aQANX2cM+8czUaJxuo12EXLDiRdWWhc12IN7iD0i3vSR
 UxxyiDd9eCtKRoduRcpyTUAVFnDlCBZmxXGvJnH0qf552PCFlCe9iGmeU/3GNljH5DIWf
 ygk7AHyLssYbB8uObXQj3hajz+R6ZLTk9MSq/tj/TnBMJ+iYmlPh9V5tburleAt3IdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790720481;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=qtG2uffV9RqCs2C+wVmXuMFmth0jNqAb/8vZc20fNyI=;
 b=MAZLiuvh9F3M7NN25oGOToR0e1JXYuTXxyMW9hT8rPWHWuC1rcRNosRjtRmCfm7ye2oa
 ZWFdsaWB3m1Q4VQCEXBOnSwX16pU/zh3DWMNRm+IBz+ik5QQmnUqnLPuCaWOY1Sd9YnXn
 nJt/qfvKLNPM51kku4fMP08VfLHzcfVQgf4uzlRP7t9tv3UQfM4ehVb7w0ygflH9gRon2
 mL/YieLWRG+VTWhvKytMk4l67+vu9Z5AO90AS2Nmn6oXRrxCmNKsgK5WPzbYJcBciKwjw
 s0d2N6E2tKpk0kxW7JtTiMAO6poReA2fLySNRb1vFf0T+fA4ZFslN/tKXdQyx/SX2kw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=L8qeEZtI; 
 arc=none smtp.remote-ip="2a00:1450:4864:3a::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:3a::f;
 helo=mail-vs2-x0f.google.com; envelope-from=hfranco@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L8qeEZtI
Received: from mail-vs2-x0f.google.com (mail-vs2-x0f.google.com
 [IPv6:2a00:1450:4864:3a::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9580810A6
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 22:21:20 +0000 (UTC)
Received: by mail-vs2-x0f.google.com with SMTP id
 ada2fe7eead31-7b3bab24103so1056827137.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790720479; x=1791325279;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtG2uffV9RqCs2C+wVmXuMFmth0jNqAb/8vZc20fNyI=;
 b=L8qeEZtI95F8gIbGYHSqFdDRBx4GYCC/GFg7j/vMgKiCuJCfS0iW/JWUCJYiUeWPco
 zNQvXiBlL5nZkW674I7ILfdohNywlkCQ51qUw0n5csGz6vVNO2TbTxEXlU92a9J+MlMn
 yh5e5fU5Rx3x7R2sO6koP0VtCcD1nM9uZ4s3S2dsOFlZmT9skaxvp96LdrHwHZko4v63
 jMrdUsnhS0GxFcg8tPTO/FULymCOYxEe4O2ne0T5W5PAvRhY8VaiRGyRA1Mlzr1cgSqM
 cahFABcWLlz2z6ojHNrA3pu9heJ+IUxeL7mSsGC2uMt2pJMyN2woYkfOr0P95r+B8/K2
 JQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720479; x=1791325279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qtG2uffV9RqCs2C+wVmXuMFmth0jNqAb/8vZc20fNyI=;
 b=fdMFkp0t4HsU0mbPAQbex3nG2zjW/NQ4vV5/aNUnPRq3D4ptLIno4Ajksu1dDjSlDR
 ktFUJ3OWMzF7HrEyiveU3rw1D4NQdtx6BrvSmpW0BFBiLkwk+dmIcwM4qoKzpHQw87DW
 n0lBR3P0ZrfCPUTQzQfM9/A43jVoFqqzoaZyhbeI0Ui+glPg3rTkBlIeiZNRnQrEQr/j
 fC7zbm2iwcxBN2e0xfgx3jNmS8+s1yHYRGZEZp+shQHRn8FjfYUp6sOe/sT1jwcpHNlF
 nOFgbo2QfPwUX16yAVSpnTOgCw2DNRso4PfUcwr+tpZQ+ccybEwZXs1w5bX7EmgZb1DO
 /Z8g==
X-Gm-Message-State: AFq9FYLAaXKpT9r9za8iWSzjzmKSVdoipSMCcbwhwg627ldkO+nEcOYq
 qJO06xpPd8EsOWwDK+xQmuPr6Q/K6Ls4y7FY5HGQHTIo2IVeWRPjPTIBORBf4EP7ejI=
X-Gm-Gg: AYBFou2B2SooiC4vcpxj+VBcWGhpogf0v/AW4mV/sEl+ohE/e/6ByJfYxTEu0CUVEzx
 y0xx0LY1l5Ro1VBWWZcYM1kCReS5JrhCVea/RO4jAK7970XlaX002xFgdrPLmrm4fZtgwOdXa0x
 zaFSmZ57xYpfYeWtB3i1Q+v1h5PYfCEw9XjtitG1NwUGcNZEjuvrQwWCPykrh750BF7hMSrpbzb
 eJZo39gyrZwPIiabwA/H9dxLytaTuM2mNlvAgc30cW24ZYmYP0KL5bGTZ3Bkg4dEZhlHa9IHr89
 iK+eCRdYr0l0Yph8yvb7VFnr+CyFUqdF7dr3mpVQGAe1s4WB0cDg9Cs+Fe02cvWFezOkSts63Bc
 WbOx2rBbuoKgWtwbQ48AYwqIea2dUo9suaZ0Xg5VvgH8EkunoSuvYYnBbnDIoOiQMTQPPaZTJJU
 lNxAa35/bfG1hxiO78br/dSi8eraQcg1LEBauZssFi1d4doPBIRTYt1AHsBa+VxauHdcZbsolf+
 UbRKBS4ZV3HaYBlzzW0VlBeQs8+hoM02zasQg==
X-Received: by 2002:a05:6102:2d02:b0:7aa:1b48:ca3f with SMTP id
 ada2fe7eead31-7bc39333beamr313255137.3.1790720479337; 
 Tue, 29 Sep 2026 15:21:19 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-988d2a051f8sm746472241.3.2026.09.29.15.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:21:19 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Tue, 29 Sep 2026 19:20:32 -0300
Subject: [PATCH 2/3] configs: milkv_duo: enable BOOTSTD_DEFAULTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-milkv-duo-bootstd-v1-2-1b75c9ad6483@baylibre.com>
References: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
In-Reply-To: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>
X-Mailer: b4 0.16.0
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

Enable CONFIG_BOOTSTD_DEFAULTS so the board can boot an extlinux.conf
with standard boot. This sets bootcmd to "bootflow scan" and enables
the script bootmeth, the ext4 commands and ping.

Disable CONFIG_BOOTMETH_EFI_BOOTMGR, as the Milk-V Duo 256M does. There
is no EFI system partition to store variables, and the EFI boot manager
fails on every boot before extlinux is tried.

The rest of the diff comes from savedefconfig.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 configs/milkv_duo_defconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index f1f3930564b..20e19fde712 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -11,18 +11,16 @@ CONFIG_TARGET_MILKV_DUO=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
-CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTSTD_DEFAULTS=y
+# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
 CONFIG_SYS_CBSIZE=512
 CONFIG_SYS_PBSIZE=544
-CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_DHCP=y
-CONFIG_CMD_PXE=y
-CONFIG_CMD_FAT=y
-CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_MII is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_CLK_SOPHGO_CV1800B=y

-- 
2.53.0

