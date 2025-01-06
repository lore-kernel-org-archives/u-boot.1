Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28694E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C8280601;
	Mon,  6 Jan 2025 15:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nG1nbCHf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C4A98060C; Mon,  6 Jan 2025 15:33:11 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86591805FE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so490887339f.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173986; x=1736778786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0hergGCEE5V6dzTIbnTYSxZdoGl8Nt+tzXPRT8ckhw=;
 b=nG1nbCHfFVdEA3mL0jOml03Nw+B4252rdSLa3eZo/vPXB273KqvsUX2YidICONHk7m
 W5f+cKUzd8N3kkRD05Ic4hNJjVse7TgFHwVcm50cOhnpqJwaph9boRahmPIMLp7rEeyY
 cImT43eEB4Wt4naRpIsCSuY6HjhxIUTNpzrhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173986; x=1736778786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p0hergGCEE5V6dzTIbnTYSxZdoGl8Nt+tzXPRT8ckhw=;
 b=v/ksLNSlMDTCLt640XdfQQJr2viGISNYKJwMvWFs6CCIuv6hxoqiGYW4zZipW78eOI
 o0Ft3koQEYc9l7Xgp4MIW+wy8Tr+668m+XNOsLCoaSqdpPC9VmTkHgrNHS2BxV0ljZDP
 XN9csfNsPjyAN8wKmEWnA+TyHwdygXsmUdWlReFZ/VyG3shk4pNnUKfKhN7lkjNXkyn7
 vIhEZbsdUyG5jTXXq0p55DcPNfShiP30KCx+cemr+a06mSdxI571Jhm/k+cobPFvIx6x
 4wozQJ+NfcRB9y/LzxswFfxBLs174lX3ZIyPfxrARY1lhU4iRK1g4bzudKSvj57BicCT
 Gwlw==
X-Gm-Message-State: AOJu0YxcNlcVoFvATFXVXau29b33w9Yu9rIXkOBkDT4kyTpFjkpzMtKz
 e0W2KxjgFvlR+WrOsLqg+Q3gcbUaZOgMxq3f7wLgHrDsXjsdk8fKZpXyUHuM3rRHtdoLFMHi9AM
 =
X-Gm-Gg: ASbGncs4K5Ds5Od/ojOij3rtBLyNc6HXvp1G+S0N8RmNREqgqrh2Mzf/DsEJsDnFlUx
 FI0qLXoFT1coWHwk3oNAoJ+foacmHOaHjXYepR2DkbXP9wrCoWy8DNWDu2j3HqQgIKD/gJmzJys
 TCqvuFeWpNy0aQcyi1dkI2DoBHSDv1VdANP6eNYdgqgvfsM2YS6+V/iF3Zdb0W8+1eu7BkJRIaR
 vMY2IGHEUcgEibNKZNj2Q5WjwBsinKUgqnpHJtBEuVG3Mg8498y2zTa0Y/JT1BSfAKmDruxm07G
 sFrUS7x+IG+8iehbjQ==
X-Google-Smtp-Source: AGHT+IG7LoAsoaAxEtjwrycA/8gThC1HHB5BQGUDST1NFL3KVxqLB3oFM+DrnuBcGtjAx3OI4g67Sg==
X-Received: by 2002:a05:6e02:3b87:b0:3a7:e86a:e812 with SMTP id
 e9e14a558f8ab-3c2d48a2f66mr420667625ab.17.1736173985393; 
 Mon, 06 Jan 2025 06:33:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 10/33] x86: Enable meminfo command
Date: Mon,  6 Jan 2025 07:32:06 -0700
Message-Id: <20250106143229.3023771-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Enable this command for x86 boards as it is quite useful for seeing
where memory is.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix 'Emable' typo
- Enable the command in cmd/Kconfig instead

 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8fc76778d87..64c6e980a09 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -905,14 +905,14 @@ config MD5SUM_VERIFY
 
 config CMD_MEMINFO
 	bool "meminfo"
-	default y if SANDBOX
+	default y if SANDBOX || X86
 	help
 	  Display memory information.
 
 config CMD_MEMINFO_MAP
 	bool "- with memory map"
 	depends on CMD_MEMINFO
-	default y if SANDBOX
+	default y if SANDBOX || X86
 	help
 	  Shows a memory map, in addition to just the DRAM size. This allows
 	  seeing where U-Boot's memory area is, at the top of DRAM, as well as
-- 
2.34.1

