Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF63DC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F27D180805;
	Wed, 26 Feb 2025 15:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DsYKgzpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C0680F12; Wed, 26 Feb 2025 15:20:09 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D443807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c0a1c4780bso666866785a.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740579606; x=1741184406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=14dr0QHehdxMuLaWc28S9J05THZPl0krnSK/eiE6n98=;
 b=DsYKgzpgxv0+oR4yHnuT3aCKqD1I/zs7PUqoV2VeDNF6aGDU44Xe6+hf1M19nUZvjD
 JlPT/8TMy9AZBkg6IMYuWVwUUxTaEiqTseYRWQ+RQz6WnERCBaGFa+WXNmkRETfLfqwD
 zxO9cJkRqEHVxCdkCEWxghf3dMk30ZJgPcKtUUzi2eoU4EFDXHBHLA0f97sqBw2jJRbv
 cvXSv9fWUvatibfHC3vXxFDv3gEsc2BdBrdtlXSlOg8VOPC/U8VaZAY9Lp3V+IgDMZwH
 NhKoaS8w42zhKWWvgDQ56OSvWOaxTVoipj2WTsW2KSHqUHuOZufwaVoAs4JsSdzKfH31
 W8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740579606; x=1741184406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14dr0QHehdxMuLaWc28S9J05THZPl0krnSK/eiE6n98=;
 b=YPA6l6/ug98yS20PiEF/WtKUoGAqWKltVzxE796dSrNgknBpBXTgXY44OJ35dTT9VH
 UTVzWo5F39CUsHUTT6Lgun/PDd1reGDkQ7NaadLkrd+6cunkirm27XwBvMh2A4cowI63
 kC/IWcQd+/+fIXvC0DgUvEE+IybQesdjEMrLRtsoce2MKrJnRB0SPatmsub/Fb15ZG8v
 3uL8lex/OXK4WBdzOoa+kI4IeXDWzYHHJMsrPL9lNdMylVkUgRn+X+2UqKTvh71obqvR
 dcL8YP6mKLcm2I9zJ9shkiThvZ9D90EEFvOShJKel0bSnefp27q8tvcR7XXBiXRU28rL
 O1JQ==
X-Gm-Message-State: AOJu0YzblsP127vJivTVOaGH0lbJdeCxM0a11ISF90dw143ntiZEe74/
 u96Fgp5iXZfuGtEsbT9RPAfXmtHe87YWT96v6pof8N7tu36WgzgfmOVTBc7TTOEsUrJKjcLwDrO
 6
X-Gm-Gg: ASbGncv/HzArDsRWrrpKmW5YzNXMdzGThabS4C5vtnm1h1ynj2pJ45CXkPmIj7UwGAg
 y7Pm8xjn7YHU99r2UkXaU2lfOqoUdMeT7BagNloKcpPrfJ7ipbS8Ta4z5mNTAzcAKkZ4x7an5yx
 V+Nm4QYmjOdIcHK9I3C9+oZU87ko5/UdzLdGw30osQGqKmyQZKdLt2IdmnleS8Y2daHq6w0jjjB
 Wr7JJpWuntnQ0RiDyav6e1yJZDw49+RDmlt6NoMQ8t+kKJW7ynp6Ic4IzVO2P7nwjDYernIwsGx
 d7O4x7ivMq0U5WG42aXq5VFjVgnSZ1nRwcfjGbkG34UnEWg++hw=
X-Google-Smtp-Source: AGHT+IGlNOBAQS3v32/IEIVBC7ri7xA3fHFY1nuXzOX0YVVusE+TH227sTk5SdoSdeo5RA2JhMmBRQ==
X-Received: by 2002:a05:620a:2a0a:b0:7c0:a64e:843b with SMTP id
 af79cd13be357-7c247fd0f2bmr496690385a.41.1740579606139; 
 Wed, 26 Feb 2025 06:20:06 -0800 (PST)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c23c2a7946sm246809485a.48.2025.02.26.06.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:20:05 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH] tools: add HOSTCFLAGS from openssl pkg-config
Date: Wed, 26 Feb 2025 06:19:51 -0800
Message-Id: <20250226141952.1195955-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

HOSTCFLAGS of some tools components (image-host, rsa-sign and
ecdsa-libcrypto) depend on the directory where openssl is installed.
Add them via pkg-config.
This fixes a potential build failure in tools when openssl in installed
in varied directories.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 tools/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/Makefile b/tools/Makefile
index 237fa900a24..aafca65eb46 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -75,6 +75,9 @@ FIT_OBJS-y := fit_common.o fit_image.o image-host.o generated/boot/image-fit.o
 FIT_SIG_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := image-sig-host.o generated/boot/image-fit-sig.o
 FIT_CIPHER_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := generated/boot/image-cipher.o
 
+HOSTCFLAGS_image-host.o += \
+	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
+
 # The following files are synced with upstream DTC.
 # Use synced versions from scripts/dtc/libfdt/.
 LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o \
@@ -83,8 +86,12 @@ LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o \
 RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
 					rsa-sign.o rsa-verify.o \
 					rsa-mod-exp.o)
+HOSTCFLAGS_rsa-sign.o += \
+	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
 
 ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/ecdsa/, ecdsa-libcrypto.o)
+HOSTCFLAGS_ecdsa-libcrypto.o += \
+	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")
 
 AES_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/aes/, \
 					aes-encrypt.o aes-decrypt.o)
-- 
2.25.1

