Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99506C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AF2887D0A;
	Thu,  1 Feb 2024 13:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="b8a8lceR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A6087D0A; Thu,  1 Feb 2024 13:41:08 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B02287CF6
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3122b70439so116514266b.3
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 04:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706791264; x=1707396064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zi3HmcqbKJocj9UGtb9QJSrxfHmwaIFzdE3igDwaFCw=;
 b=b8a8lceRhAOxDiHG9QEF1Qxd+wIau3YlGW7hTW006E1MGCuGsxAh56569s3QodGdnl
 h8vw/pdQHMI0fl8bB7c/RCeSydhcgGQdOPcMQhLg0KR1BuG35rEuxhfSyNTR9qTFHbJc
 DQ0U2S0K321xpTYV7ElYN0DueY6Ctxa3w5tywGHk21e51xHFhf1fU2qpH5JCcnqW2KuX
 szeuPNiJbkkCbjbLOcfFACAMeuzAImp73uYNc42gquTbq76GxVU/UZFvj6vbo61EQ4Oa
 fWb5+Sb84GCENsBoL07jevePBJO0UYUkbGo7PGg0HpkzPzHNa83GDSqUU8J50WoBJp75
 1VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706791264; x=1707396064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zi3HmcqbKJocj9UGtb9QJSrxfHmwaIFzdE3igDwaFCw=;
 b=JYRrFndiMYytZEkaICiY+4K9I7pajzrbu1CY2YA2xx7W+UHWlFCEttPVh7NlKrCkCC
 B7SIEwmGNTIZT/Pw+WR3LdZn6d2wgREo7v2GOcVuuaXFuJmY8Z8/cCJeln/dy7wAh7oP
 BurOToLlXJVUQMgvhQG4CTqE5yUmbtYFGroFwWYg3rwetVcXOlgI+hC9Kb2vTxFPuD9y
 qB/t0ljl+IolTouWAwjpDn4rVnC0GXZKP4GPX5hzAS9rmP9A/xC3KNrkJqyNtKScl/ek
 fp3TPLNWt47499JsOg6Czo9Dms7xjxlCvUlopRzBfdXfnvkahWdXqqnzutmIqj6hnigZ
 CF6A==
X-Gm-Message-State: AOJu0YwxCdpn2ntesvMV4/EfA8MIKcqjUM/qwV1GdTcS9k7FwuHfuGYd
 /OrD3/fAr7qewFkK/5CI02nnOjisKDTZnW1xX7XWZpxc2mkY4zSiV9Upk4kOvTPpWEH7KR96vbD
 v+Oo=
X-Google-Smtp-Source: AGHT+IHDB1IlXWbFxQwMdrokfxPxpMaBXiU7v8duGyqUClVeyRM4xjEVPDYupII3uBwRFxZNIuT/bw==
X-Received: by 2002:a17:906:2dd2:b0:a36:e12a:1019 with SMTP id
 h18-20020a1709062dd200b00a36e12a1019mr277647eji.47.1706791264389; 
 Thu, 01 Feb 2024 04:41:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVuY1etzgs5XtHLriBUxdoDg+BvEFqOZo+aycbg3mO/2oqy34diQbj3woQn6MrFikoFCjL9ZKnSck4XmBkTGYRtwgfoiewn5fvQdqA0a1OgiRTUcSS0iq88RvShfSZDX5TzwNORePYWPCVZCNjccElL5LaTTwPTgMLSI9fvgThPB4q6GLPAz+8Zeg5iBpTKEl2dQrwxthrWeYutmls49lkEQHd4dFIXRulz8IqDaqjJcmWflO9NmnLsmvyJfqDnsva2UQ7Z27enxpNk10mgZKGeMwxD9zOzy2arpCj6LhsrupNB8rmSx16cEKsJtL2yewC7qjz/e8yZbaqh8A2rtgkXCgUP+k/Hk3xwh/CwW2Ey4o+6rVikT2+aBwf6EvM6cLUoPpz/50xD34pRE3k0cTxd8RF/4KA=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 vb1-20020a170907d04100b00a34c07816e3sm7134918ejc.73.2024.02.01.04.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:41:03 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: ardb@kernel.org, jens.wiklander@linaro.org,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v2] qemu-arm: round down memory to multiple of 2MB for LPAE
Date: Thu,  1 Feb 2024 13:40:54 +0100
Message-Id: <20240201124054.2094572-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

QEMU's -m option can take fractional megabyte values,
and lowest granularity seems to be 0x2000.
For example, run qemu with amount of memory set to 100005k (0x61A9400):

$ qemu-system-arm -machine virt -cpu cortex-a15 -m 100005k \
-bios denx/u-boot.bin -nographic

=> fdt addr $fdt_addr
=> fdt print /memory@40000000
memory@40000000 {
        reg = <0x00000000 0x40000000 0x00000000 0x061aa000>;
        device_type = "memory";
};

When LPAE is enabled, 1:1 mapping is created using 2 MB blocks.
In case amount of memory provided to QEMU is not multiple
of 2 MB, hang occurs during MMU initialization.

How to reproduce:
qemu-system-arm -machine virt -m 1058 -nographic -bios u-boot.bin - boots
qemu-system-arm -machine virt -m 1057 -nographic -bios u-boot.bin - hangs

DRAM:  1 GiB
initcall: 60011df8
initcall: 60011904
New Stack Pointer is: 80fffe90
initcall: 60011a20
initcall: 60011bcc
initcall: 60011bd4
initcall: 600119b4
Relocation Offset is: 22042000
Relocating to 82042000, new gd at 81001ed0, sp at 80fffe90
initcall: 60011b8c
initcall: 82053ea0
initcall: 82053ea8
initcall: 60012040 (relocated to 82054040)
dram_bank_mmu_setup: bank: 0
- hang here during mmu init -

This patches rounds down to the nearest multiple of 2MB when
CONFIG_ARMV7_LPAE=y.

Fixes: 3fa914af82("arm: qemu: implement enable_caches()")
Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

Changes in v2:
- Adjust commit message, add more details

 board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 942f1fff571..ecfd19f1a7e 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -127,6 +127,18 @@ int dram_init(void)
 	if (fdtdec_setup_mem_size_base() != 0)
 		return -EINVAL;
 
+	/*
+	 * When LPAE is enabled (ARMv7),
+	 * 1:1 mapping is created using 2 MB blocks.
+	 *
+	 * In case amount of memory provided to QEMU
+	 * is not multiple of 2 MB, round down the amount
+	 * of available memory to avoid hang during MMU
+	 * initialization.
+	 */
+	if (CONFIG_IS_ENABLED(ARMV7_LPAE))
+		gd->ram_size -= (gd->ram_size % 0x200000);
+
 	return 0;
 }
 
-- 
2.34.1

