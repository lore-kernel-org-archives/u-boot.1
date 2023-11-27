Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2260C46CA0
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB90987799;
	Mon, 27 Nov 2023 14:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="laybwzbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DC787792; Mon, 27 Nov 2023 14:01:39 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D3F87788
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6352200e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090097; x=1701694897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tIJHMwEyqDTiSGNyeHBGRMsLG250quYlouS06itanf0=;
 b=laybwzbHlby+4MLTUY3m3p4ngNyGZnJcKp56YrfJvtoDUstMKBU2dO9dfVfApr7fwU
 iq5iSNOue0j1YZQ1W8xDijza8AF0QI/CfnPCdk1RIOHRtRkfrqD9fz5uHxj/Cv/qT+lJ
 e1bP9mo0o9L7dh5tycIjPOvoFy3PyPQly+/q6ysrV8PuJwMlM8CoZgMEvuzwjgjUUsfe
 mQq9Ln7/BHJqepK4wuJdZXFOF4p9nHrsn8Z9PP2/wJGF1htHqxPmM6BE/+jMsWCEXvSE
 i4W79ghWEweW129iMHjx5PvMwSu1/Vkka/4kgxDrUoSM1psfIQnHqSjo4D+mTApeF6rp
 J6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090097; x=1701694897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIJHMwEyqDTiSGNyeHBGRMsLG250quYlouS06itanf0=;
 b=bqns3UUobggNxq6vFSe9q8eaaUm+JUJGrL9myIuP7x2oJekmIjhvrKQTyC5WDJ3MN7
 Qz/8bAgihDkakeNUpELSeu1Cj3ZCwfl9NRcc4ZpWsOZ4lDsZxVgLkogAFWMY+UHz05A2
 xPaZm3SBnAgaE0OYVXBui1prcutsm70O8ziEAjj8px2fMBsBuMpztEWGq/fTcap0EW4C
 n4YZ2CLrPRNWMUmaVqNdvktd4mxOgKff4kI1fgmzPOrQShiBnxRBz7ySXAaZww9jiPBk
 fQNkNbp5QW3gbTl3YJaCk3pkQLN9OzbxQl/e1OKrkP6fAXQ5xoIjaAyMH1f/mc9Qwzuo
 /+nQ==
X-Gm-Message-State: AOJu0YwY3OHVLoA7stHI24uOIsFBWfQqb/LQoND72yKjIYHiew845XSA
 48K3Gl+r5P9w25SPYqyJur0RFd20vWy9TwCHqSm3fQ==
X-Google-Smtp-Source: AGHT+IF8J4FsGHj4NHzB+FvP/PjAyPyY0o7eXR1nzIiIXNoX6vTO5JfoVywxaaA42WgBXD0UpIv6ww==
X-Received: by 2002:ac2:41d3:0:b0:509:1033:c53e with SMTP id
 d19-20020ac241d3000000b005091033c53emr7210783lfi.62.1701090096823; 
 Mon, 27 Nov 2023 05:01:36 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:36 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 38/43] configs/qemu-x86_64_defconfig: increase ROM size
Date: Mon, 27 Nov 2023 18:57:21 +0600
Message-Id: <20231127125726.3735-39-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When lwIP compiled with debug info enabled U-Boot size
overlaps with SPL. Make more room for it.
binman: Node '/binman/rom/u-boot-spl-with-ucode-ptr':
Offset 0xfffd8000 (4294803456) overlaps with previous
entry '/binman/rom/u-boot-dtb' ending at 0xfffd8a40 (4294806080)

ImagePos    Offset      Size  Name
<none>    00000000  00100000  rom
<none>     fff00000  000e0a58  u-boot →  0xfffe0a58
<none>      00000000  000dff10  u-boot-nodtb
<none>      000dff10  00000b48  u-boot-dtb
<none>     fffdb000  00016020  u-boot-spl-with-ucode-ptr CONFIG_X86_OFFSET_SPL

In general compilation issue can be solved with changing CONFIG_X86_OFFSET_SPL
to 0xfffe1000 from default 0xfffd8000 and all the code fits to 1MB rom
image. But with modified CONFIG_X86_OFFSET_SPL qemu process does not
boot. That is under investigation now.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/qemu-x86_64_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 2ff49fbd6a..88eeb6622a 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -6,18 +6,19 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_TEXT_BASE=0xfffd8000
+CONFIG_SPL_TEXT_BASE=0xfffdb000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_X86_RUN_64BIT=y
 CONFIG_TARGET_QEMU_X86_64=y
 CONFIG_DEBUG_UART=y
+CONFIG_UBOOT_ROMSIZE_KB_4096=y
 # CONFIG_HAVE_MICROCODE is not set
 CONFIG_SMP=y
 CONFIG_GENERATE_PIRQ_TABLE=y
 CONFIG_GENERATE_MP_TABLE=y
-CONFIG_X86_OFFSET_U_BOOT=0xfff00000
+CONFIG_X86_OFFSET_U_BOOT=0xffc00000
 CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.30.2

