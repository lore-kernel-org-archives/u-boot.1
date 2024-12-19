Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134F5E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D108039B;
	Thu, 19 Dec 2024 19:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QrWVrJvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5559D8021A; Thu, 19 Dec 2024 19:29:34 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2958B80351
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844dac0a8f4so78417639f.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632970; x=1735237770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j74QLmzUVfx1nYppzT1UpJ4hWHCPdMUetn6Cp+dtlo=;
 b=QrWVrJvJlTCdSPASXR/bPSO1ioujspvOyoaeWheeKp6uY4StgXr+3gsgDDSjYWPCRd
 TlWKXXdVqe5oAplDPRMhN3SqdbuMgBw2NvIDz7s+Oew4KfO1/jIwrlbCZjUePBYCxK3L
 X2zvrnmsQ7JBjCuu5LLiw13tmVovgTJWFsegs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632970; x=1735237770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6j74QLmzUVfx1nYppzT1UpJ4hWHCPdMUetn6Cp+dtlo=;
 b=H6z+RbYXpwTa8l5DqWDCtEm98PdoHwe0A91UafuyPygG1VR63qITUPQWO6Zay35SIA
 zNUojOy/xmVhd4T5T8HFUVCiNHRRQZySInf37pixyiJeGKO/BhLpv4hJmebs5I7YFbwe
 tigsN484VTwL6kG4+XOH7wS5KyIv7qilIh5LHmomnozTDiXfIn5GhTkppathGYA+5cyI
 qfWIto9JShnZbnfhi3LVAe9AkXhdW2gyRgV84PAQZCzZXw1QErM6qAHfPNrNzMI4jH6a
 yx3Lj0o3wxq1WrxyFqBBzQtET2kWIfvuCT5rTeTyTCi24fb1QsvJc02zobk9IBF+xwx8
 MT/g==
X-Gm-Message-State: AOJu0YxWp63Vt8qOQXE/SdScqAx21JEOB0590IJKYpp6KWdQMvQG6i8Z
 F59JP7+vLOEBIqXrltxBneO4KS+/gT4G1zFpJAia5eVMzkOwBa6o2nDvjbTDo5aQ/z206i4b+KY
 =
X-Gm-Gg: ASbGncvBOqJgW/NRl70Zec5guFqqUKHdF/tpsHP/bacKxk7kdSa4vM6TSb84at8LwyK
 bcTYX+ATQge2SGriEYZmZ/N2vk1nZNfm2yVgRl1dyaeYYVpsNsbCm2BLGSTd35Nctdr7TOsDpSZ
 fNDwtrxu9H9TBVFqmrHIp5oncLtrb1DzeNNis6kbNTEBkFGIwqE9VfPdjl6zzAAvTr9YBO3QZUJ
 7U8Iwx1q1RW1xfeFpVAiQTpuwYeJDZ6dRwccbClvlQ7hAV9kKP1UeccpmwGwgTv7WE6GT1f3DCw
 ctyI8qq+E4s85Ss0Mg==
X-Google-Smtp-Source: AGHT+IFF7OXubuBNlak4oP5FnPpn/skyPkiAF9GPj3r6cB4ILJXypEop1/0pM3DJtwyC5Ow4E6a2bw==
X-Received: by 2002:a05:6e02:3dc9:b0:3a7:c5ff:e5e2 with SMTP id
 e9e14a558f8ab-3c2cca3e450mr1703445ab.0.1734632970393; 
 Thu, 19 Dec 2024 10:29:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 07/19] malloc: Provide a simple malloc for VPL
Date: Thu, 19 Dec 2024 11:28:55 -0700
Message-Id: <20241219182907.2609704-8-sjg@chromium.org>
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

The VPL phase may want to use the smaller malloc() implementation, so
add an option for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index d06f36d4ee4..3dc0e95e09f 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -222,6 +222,15 @@ config VPL_SPI_FLASH_SUPPORT
 	  lines). This enables the drivers in drivers/mtd/spi as part of a
 	  VPL build. This normally requires VPL_SPI_SUPPORT.
 
+config VPL_SYS_MALLOC_SIMPLE
+	bool "Only use malloc_simple functions in the VPL"
+	default y
+	help
+	  Say Y here to only use the *_simple malloc functions from
+	  malloc_simple.c, rather then using the versions from dlmalloc.c;
+	  this will make the VPL binary smaller at the cost of more heap
+	  usage as the *_simple malloc functions do not re-use free-ed mem.
+
 config VPL_TEXT_BASE
 	hex "VPL Text Base"
 	default 0x0
-- 
2.34.1

