Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902D8E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8624980384;
	Thu, 19 Dec 2024 19:29:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CaqrVpM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C991C8036B; Thu, 19 Dec 2024 19:29:39 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7E78035E
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844de072603so94862539f.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632974; x=1735237774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ke6QYg+xtnB5Mu9yRGp039weqmWxFSs/11iZzqpG0X8=;
 b=CaqrVpM7ItEsxPU+A0YX29pl6ycfsuZoRYB2dRUndiBmflDKbVbG2CucF30eRgdjap
 Ui/vbLBn17VpsXAPi1doto9jeL2F72fewgfTlqyYQOyw9CgGr0JuWRlRINMTxVX9cvjT
 53jMs/JR1Ex3lBdQMHWlrIDb5iONwhI+HmuHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632974; x=1735237774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ke6QYg+xtnB5Mu9yRGp039weqmWxFSs/11iZzqpG0X8=;
 b=eP6UJgvKL8RlTNUMc6A1pFB9wqg4P9awE2u6TnhYxXZ3PVUz70p4fPm0ru9Vl9RES6
 jY3GF2iW/sRUkOzmwi+It+eymOXKWMNElz4DbWDxdgyhjwZfj0GheGyT1vCYz/r/KKYt
 Y/zuqObduO37FVdoOD0VHmrq0D280dzVAMyIIlUmY8LHvJR0ylzd1xYQlVJ0e7X+zmYi
 /HXlgOTYo1JQ53ncZCQAnHw92S9euiEDFP4IH2m23K41jC25NKy/hsxADl3ZD4idiQZS
 iUfbMNJs005Rt+9TFg9EA6fLbH0DblpPaA8epCeiA0lWVZql7gr/Sura0vB0qxpMIs2E
 ZiBw==
X-Gm-Message-State: AOJu0YzUIx4MZxsFtoHcVXjGMwAyRaPFj8Ipm/uZ5CunnJc6vulYIpjp
 JJqTPqZrADw1rV+FxYT7Ti0xB2c4LxUgAXPpYekD/noKIu8JQ2N0GCuWDAazRnQzX2fGVtqRoLo
 =
X-Gm-Gg: ASbGncsZFuwwewRRBX0bsyqN6DjQ9TddlfbAhAEjOTkoMhw/fpmbzGghIiBrGk5/JxZ
 hIYGDeVgJ/4uf7n6w78n7Na15DB82Xfm9fh3IzyL4x7xW3N4VNSXwF78e1/N8RWQRczerStS9lV
 2ru3dTJYkWSIPoUjPRPr6uCu9nw6NdchifNtW2ArPddBadfVfX6FgTvssirDq2Li73TH4M6w6Gi
 Vd7dVOiDTJ94ljusecsn5dRVEGDCrMSqz8Qzgxoe4BJFQvFhtNDxVGs36XhCbzIvCmRwE2DzGm+
 LRua/p+LTuxg1Rrllw==
X-Google-Smtp-Source: AGHT+IGFtFegiqkIFXbsNYylNaOVg7osGsTghjj9Rb9J2LF9tR/3el37w2YM4nnJB0anfXjM/MF10w==
X-Received: by 2002:a05:6e02:1889:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3c2d2f3b65emr1157535ab.12.1734632972567; 
 Thu, 19 Dec 2024 10:29:32 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 08/19] Support setting a maximum size for the VPL image
Date: Thu, 19 Dec 2024 11:28:56 -0700
Message-Id: <20241219182907.2609704-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

Add a size limit for VPL, to match those for SPL and TPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 3dc0e95e09f..eb57dfabea5 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -237,6 +237,14 @@ config VPL_TEXT_BASE
 	help
 	  The address in memory that VPL will be running from.
 
+config VPL_MAX_SIZE
+	hex "Maximum size (in bytes) for the VPL stage"
+	default 0x2e000 if ROCKCHIP_RK3399
+	default 0x0
+	help
+	  The maximum size (in bytes) of the TPL stage. This size is determined
+	  by the amount of internal SRAM memory.
+
 config VPL_BINMAN_SYMBOLS
 	bool "Declare binman symbols in VPL"
 	depends on VPL_FRAMEWORK && BINMAN
-- 
2.34.1

