Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3234DC79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 15:30:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 656CB6061A;
	Sun,  6 Sep 2026 15:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xVanAFq6xuLg; Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9CBE660604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788708632;
	b=cJSXSHJ1QI68v+/uYw2QAZeQxY7ZhA5w2SGEZNRHysE/G+Z4IN6anbCmcLt1g1ik5+Bp
	 /RJ+xA0sIEV2VizBRBFABm5NTxugTwLU2uJg9bibyob+cGB6f8aVMZrO9ilHblH7UuS3H
	 d/sZPB7MGK58cSZdJWvKjfTHm9O3C/h0ci8gvFTy6DEn4oF4XmXuzOV6VXWCoGBxH+RHT
	 nERxXvL3Ngz+N/aSTXbehEtKntI7YbpaUXMa9NKVNi7KmqsKkUHgbf3QtNealsAoeU8XP
	 rP1SFahRaFPN0tAZFxBdSm4StsDVKNFJfuP0mtMlnB+DPONW4qCY98Pq3bnGaBIs/yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788708632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DHZD94Hwjfy+mSyZotVqbY+ZuQuufpIeWO4e6r3q6K4=;
	b=mUPKemk7/ONNOhGoUgUHHo04+Huv2qkaxydYuDbIPOGtPhR305Ev9xNR1HLdVmuC3FiF
	 XBYN3fsvboHRbQ8emZYwslIMKkettrxjcn9l1/yz5mSRG9vVqankZr1J+cbUwnJxSDHuy
	 OXXnjKVVs3fyTeS2cB5Rw7BmOjIF0ozRjO/w07IkJa16QNwQRH2OYOfHPtJk6Mj8uC+Fs
	 lcw6iJaSHQqOXbX92nFFue/ZojjLcq6MHhPdFpji8L3J76KX8XOQUJzRoxSRgLe3C06Sn
	 SGM5uisNMTh09ACm9dRsLA+rVOM2IvRL6L6DsfAnLKrkgasbAfqOeTvSP2g3ggpR10A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788708632;
	bh=DHZD94Hwjfy+mSyZotVqbY+ZuQuufpIeWO4e6r3q6K4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/ov1EQOuKHQkvdYcoUv3SbJu06jbQjMWIiO6LA7XiQEdXzIkhKHduXW5M1jX+YeJ
	 kD10TmWfsvfir7sudcKbigXsJVUJadJ76deUNXEQJpkYzlDoVJDeItbfclhoIahdV1
	 muQvJwEBmU5H2ub4M1N5BwCwhc4q8mI4R7hCjmAp2mJiHhGRTz8FNakxwTdbwk7Ks/
	 EBC6TJvZY3KIYJucSwA8Mdt0c1XOe1OdJHJMu3Th2ZWo6OUn13zbPbhLzyeKHqv47c
	 w+43gL4CyXhmMWx6fOFyi4gOGz94K/UGYxcD1PNA1UuPyAYO4gCFHwKVY49EcXhuT6
	 3cglEIldQQF2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CBE660604;
	Sun,  6 Sep 2026 15:30:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A61779CF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B97140067
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFNYAiZ2aI4j for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 15:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4E2F64000B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788708629;
 b=UAp1qR8ovTxkqBs2V0V0EprjPS+pLelTzVGJkbVykWnGoF7VxAsaI1tfDRGXPajMIlpz
 53tu44hWaitIgymhQxC6BxhmNVIIMi0LUS6qk2ns/3nS0Imv9vaqhNkTuuRYjeNVyIqzJ
 /QEiQMgUxFmMh/ABGKYnozE7V33K9ZUcdtoj9h+jZdgD4knv7eTFydqe1iRNcUPzkobmb
 EvDSOFrlP6QBneT675gzu3MSMF2TjWbI0/Nx0c39XHomL+oz9ejd+1tpOaR0S9PdfUWP6
 TymSFVaRHqd7bA/P4x03RdkzxF8zntmgmy8EeJeN0ZchcMCNXNwnLhoZBUJ3/w27fng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788708629;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=DHZD94Hwjfy+mSyZotVqbY+ZuQuufpIeWO4e6r3q6K4=;
 b=h84FIP0tiwBTxkELC3IplL/xGdoUbPOhcJB3+tQyX7uVLgjap1QKzjjPPa55hRSCzwf6
 6WxKnMh3bVWR8CzI56zJaPhas1fNAyewzgDsLlKrrAhaXZ0nxrrysPGJ1m1eH5ZiOzvOO
 tQ+kJSKzyRph20UqOB/Pfxhjja7QVOhKyKhVu5NMsMRGtkLoW8bZi8YWrnWg1DclHrizG
 ugo1LW6jnydIVPjelwgp7rE3rS3UrBCMp4uu1JhTohPmgmZp0U4fKkYMWBI5gfq9DQ4fk
 mZ9f6Gt+cytpLZfjONzWFSliRIltSkNQRW5Lgg1NTIe9WXzN6QEhK26t2xP12/IIy2g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Fcs+I3vF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Fcs+I3vF
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E2F64000B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 15:30:27 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so3078456f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 08:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788708626; x=1789313426;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DHZD94Hwjfy+mSyZotVqbY+ZuQuufpIeWO4e6r3q6K4=;
 b=Fcs+I3vFqCbS93Zq6cpfnmRtXw8NCel9/0xVx6p11fLWcRW3QTbxkx0FbxEbfLPtKS
 61ituJazKmY1+eitNPS86SY0yVNl8E7THMPfz8g5M9q40z8uLiDTtxQurHH0nSWuZ+WK
 4RXjISI6CHndpq5JV752QaHIUJMS34gw06tDqwZDnMZGOQgBo/cyzPLTg3FUx5QbzDbv
 fcaciQLU2shcT/I1voDHkTvh+PXVYDH2PNzLZLhA4KDx1mBs43GyzLcbOciichctTzEI
 D45QDxjcXNEs8LGMOA16d7H9LVfbgQ9NxtS1wQ8KXofNkARLe11zbhpoAZISovnmkwQi
 cvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788708626; x=1789313426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DHZD94Hwjfy+mSyZotVqbY+ZuQuufpIeWO4e6r3q6K4=;
 b=kEnm6OHUvqJ7IqZFvXNjM/i+P7jlPAm0gKq8RuMibS308HpIJahmNcKCIGT1UQe3bf
 1q9n8/Fegk/Jyh3wPHAHv+gKNNU2EIoNo1GQ1BNlnHQT+OWBoZE4pPIhhOcEioHVOsFB
 bj+wQr4zfii8cOTzwOvXCJkln/imoEfjbzvHISgV9O8HtUdGSm6P1qVuqNCrpe04it8r
 zrKzEN4kcz/YgmXO7pw5ey1WXG74wBNnBcfrvFGOQ9QmDdNQG3cmgovqJL/fTZj6Q58Q
 lFEcZDSDMK6PtJMvTy679cVxd7VPI7704zmWYXv7KXADnJEvpVjx8EGih3JRBwL6U62R
 HpsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAFolF8Q4qMYJGUYgwWmEE5tH5OpOLmyUyLA0LZJm+VCzWKM6JBmXPI0BdTKIsGMFzktiWdzQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nHuezVG+07KRkof5DbHnCT7jMRpHul3TbL8uyTrgbmJ4JKJ2ZY
 /q5yS4Gj1VbFh4fYsTsc6aU4I2POEP3bGcUg1GHxfxxCfHuxoPqoFA233Gs1TS1yED4=
X-Gm-Gg: AYBFou2mRlX4GWP01qYI6ssc5cZNJSRJvX4n6aUGpUtD2BNa67eiOzE34Cjmb/vq5JE
 Q626/U8xz2JGZY5mzxaPMnQtYRrPhZH0Ej+6glrZrXS9vDczttAPxz9PR/QYXQ4G7dd3lXI9nK+
 MMX+ULbVzNec80nWDdliGyCfVvESCjEazvR0z9tBdqfUQWO+/kFJprXopeZJO4SDawJ+k2tBsQu
 Rh0PItWCBJX7IzWJF4StRSJVK5Tm/Si7fD7yuLz2G+S9x1DSisLduQonqq6nxoPilCrbld5BIab
 3MamX1pYtUlVua+6+1MMALoH0fglClag6kctvlmv49x7+VC1pjjpEsgExAx/TDq94bUDAsRMSil
 3q9LegK8bEup8CyiUE687Xgw48/VudQRKkeJRQY8TQFMg9iV1UqNGNn2GNopCk+VY4u7KbkqzfV
 nE9AwNRTPHThRcv2xHq8D50js1X1pre9nze3/mJXgGTUslQHb0yzVahJ6Un9GeiJK3MiWgcC7bC
 Hb1rPms8oVHNhMWaxZoLjXNePyrd13zEaKQUuxL66nFdM6Cf6QMNOlD6f0iPVU=
X-Received: by 2002:a05:600c:8b8c:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49cf893b58bmr165447115e9.15.1788708625728; 
 Sun, 06 Sep 2026 08:30:25 -0700 (PDT)
Received: from [127.0.0.1] (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf770fcf5sm238069605e9.6.2026.09.06.08.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 08:30:25 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Sun, 06 Sep 2026 17:30:19 +0200
Subject: [PATCH v6 2/6] configs: mt8188: enable eMMC FIT boot from SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ccaione-upstream-mt8390-spl-v6-2-4d4a11d5741d@baylibre.com>
References: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
In-Reply-To: <20260906-ccaione-upstream-mt8390-spl-v6-0-4d4a11d5741d@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Julien Masson <jmasson@baylibre.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>
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

Enable the shared Genio 510/700 SPL path entered by the external DDR
loader. Keep BSS after the downstream SPL reservation, leaving a 0xc800
guard after the copy window and space for the initial stack and early
allocations. Use an 8 MiB heap for loading the firmware FIT.

Load BL31, OP-TEE and U-Boot from eMMC partition 1 using generic SPL
support. The MediaTek BL31 stalls when given a runtime devicetree as its
platform parameter, so pass NULL there while retaining the standard
firmware entry-point parameters.

Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 29e2b3db878..a7a59940646 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -28,3 +28,36 @@ CONFIG_MTK_SERIAL=y
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set
+CONFIG_SPL=y
+# Fixed destination and copy window of the external DDR loader.
+CONFIG_SPL_TEXT_BASE=0x40000000
+CONFIG_SPL_MAX_SIZE=0xaf000
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+# Preserve the downstream reservation, with a 0xc800-byte guard after SPL.
+CONFIG_SPL_BSS_START_ADDR=0x400bb800
+CONFIG_SPL_BSS_LIMIT=y
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+# Leave 448 KiB above the BSS limit for the stack, global data and early heap.
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x80000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+# Keep the heap separate from the loaded firmware and its reserved memory.
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_SERIAL=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_EFI_PARTITION=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y

-- 
2.55.0

