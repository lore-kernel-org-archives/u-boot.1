Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE9E66882
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 20:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1108A833C6;
	Fri, 19 Dec 2025 21:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jk8eJK0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B82808AF; Fri, 19 Dec 2025 21:21:31 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5370380FA1
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 21:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c701097a75so1139871a34.3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766175688; x=1766780488; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmctBvsAfXnIUI88jZihkle7vsPVDxre4g+QDtkVIYA=;
 b=jk8eJK0J1AhKu8ICiK7jyhHVPIS5iE3GNaWahLvXB2JDE+HJgqE+vVrDMDU8fh96kj
 K5xUucHma2hVxRNAxtM/bxFpFywep80pj1VTiOJ2dJjYqjCW6TmVMT4biIfUhhWMTHfa
 08eDX0YUliqF5YV7trAHHRzkJoPSz0mEV4n54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766175688; x=1766780488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CmctBvsAfXnIUI88jZihkle7vsPVDxre4g+QDtkVIYA=;
 b=T8eXa92JMGA2N8HcT8IfGALPQ2z12xaeOHhs89xIDykaCHrxm9SweessEoJ1P4cX/m
 WJ5ZWVj0r09wmoTxPuqYB63U6ygE9VmaPamLuECbQWtAMDu/FhkQ/dqFkUlYKhWqIQJi
 JFsCFxCbtQ/othp4QbXwZxanaHpJ2S1gyILOCTzSbjU6txv8Cyn565go0jwS+DLuowyi
 c8nSe7yI9gWCiI4HMjxHGvHBZb4lsp8PQCXFMtNCcLk8eb9i6d7LJUu66n5dDP729ckn
 ywT/D8zBSLscXiLOMfqyJdkliJ9JcANt6ok00Xms9FhkTziA/PVPGvI8SEOGQkqaaA7/
 MRzw==
X-Gm-Message-State: AOJu0Yzi6jUWXxnvTbs/JOIptIdMYFdOwe5/ePMt6DOUSa1XU+V34LI1
 56VfF1hC90sZ+SlIdEuzDj24pc31P9cKPfIFDH7MJ2g/hoo3jPQIm2koOH9oSuB9Bjmf1q8C4K6
 q6zPdkFc=
X-Gm-Gg: AY/fxX73OlrQfWZ5wkx2v9pAzvh7lNygUvWYjSPb1dttDNocJg79VeZW/tmbVc9yPyC
 /1h3kN2sb+sVzj/pqRCKzfcWIjTzp43p6p+O5swZKFBf87GVusVteUIR5BtHXxiaVlLa75NJY5E
 hPxKHwf15QxKMziYGAu/WCGqejEXTiiyu3j+37lNMGaLmDLsmxugTuVhcy534HCEd00FDR8og3K
 DUZxlugTvvlfvrt0FzIdHVuPC7n3F/hfFf7/iK6SPCgW4TVSDMq1I5kdFCVcIX1ywfPSJ6Deoj+
 CH0QIXIHBqw1T8a9xAUNOJTMgUPzvLj4zVy8wH+/swpcSCevbR8QIanwi2V7GDyS05K4mnXU19E
 nVdGBEs7oMjoUrN6Gzd9QOyB42IZGI6RR6D3R3qe0M7h8VTR5Z+X51v0GDsjN67XK8r6c/DkNp9
 j/nd/7vgqEXPgLOMbeWMjzvjit6hV2/a9iH08lZoflUv4mFBF7NAQS
X-Google-Smtp-Source: AGHT+IFVcrqx6WnS+6NefCPJn1i0kF0fbWwLurKYsCOqTKtPMpWlDZfYE0tNSpy/ABYQCV/m71nvPg==
X-Received: by 2002:a05:6830:4c08:b0:7c7:18e:914b with SMTP id
 46e09a7af769-7cc66a0ee2amr2814402a34.17.1766175687910; 
 Fri, 19 Dec 2025 12:21:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc6673c32esm2359189a34.9.2025.12.19.12.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 12:21:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stefan Roese <stefan.roese@mailbox.org>
Subject: [PATCH 1/3] mips: Reduce size in gardena-smart-gateway-mt7688
Date: Fri, 19 Dec 2025 14:13:41 -0600
Message-ID: <20251219202121.4180810-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219202121.4180810-1-trini@konsulko.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
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

This platform is near the binary size limit for U-Boot. Disable booting
some unlikely OS options in order to reclaim some space.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <stefan.roese@mailbox.org>
---
 configs/gardena-smart-gateway-mt7688_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index 3c2bcc6a3c44..3bfb004cf2b3 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -48,6 +48,10 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_LICENSE=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_MEMINFO=y
-- 
2.43.0

