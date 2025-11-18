Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66061CEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4454B83F80;
	Tue, 18 Nov 2025 19:04:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KY7WGlXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5AC83FAF; Tue, 18 Nov 2025 19:04:32 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CAE83F80
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e12fd71984so3106393fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489069; x=1764093869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E3SB1JfNjQ21gfIwEhCUIOgiNgJqfaIdjo69VA3X9u8=;
 b=KY7WGlXPMjhghGwjLtR6nuuQ3f/NEncZBgg1C9Tbk1st4tc2Uh8FDnC9uZLzTsHcw4
 WF8AkFN13jA0rmzGl9LsN7GMY3/Go2hwynX0Os87pxCeF+QHaE8GVPv91jH9PxemOjhD
 BDO5i3PTYhjwbHbfVnv0t3om/zj9u4jl0vqvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489069; x=1764093869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3SB1JfNjQ21gfIwEhCUIOgiNgJqfaIdjo69VA3X9u8=;
 b=uIBVmKfnO/eSgESM2kCnCV1N3lMn9bmbWhnEOiX0TH9yH7u2Kii5kdNik7GAVmtGlv
 Hsdb9EhHfm5N3c2gDimEd4+lJ2xzT2nmzY50YECRy+ql8LVuav0/Qg3RWRGVirxQeeEw
 K52Jln5pFQPnpF2HP46KdQ/MrjL7+FSNxXelwvWHUl/+l7jOi8O5Xd7vtm97hPG6pf+h
 LHLrj6vLB+NGh2csuu72uEx1wCkdoLfUcCaigZirV35PUrf49f95a1eW5DcjdnM83mmv
 8dQk+DCjGtOjz8lY3HbfUp0P+0CYSscFvIrcb95dIouWn+bw2jotT3TUdonw+qbppy/U
 9knQ==
X-Gm-Message-State: AOJu0YyxE89pT1LX1eTpyxbZVvAgtigdTKTkW/z9e/gw+Ajku3owGJI9
 iwuLj9kmRS9WlnXnStpUtq5yh0JW9L4y0xgANjEz5DMPHJakuvUcmw/hnzgwxhuqOjYjKtsdbni
 k7/QGy+dOgA==
X-Gm-Gg: ASbGncslB4P1G0ikVR2ocW1ckVn9c7Fpj//MjI3Veucu4J78i7iqJKdSnMUxSBkXv8q
 vQ3FrEhp/V1kMC2oFYr9MrpqySeOlEGByvClIdQaBkdDjTm2mph2i9aDu1M3AhT7407/cQvRTOl
 JXwxrFBDy7yPxCdi3wVK+bJfG0JrmoFjSMvTlO0BfqUidoazUhjLSlKYz7BS0DFOK1YvyOGDBrW
 Pjr90PrWQ0fr1vJbnnmCGMF1m3KbU7aJVFRh6eW4wmGG8a/8JjAkdc6WpGMqIazWJC2f1Vd1BqX
 SfCM7bL5+hxpCogu+magQaRFZYo2sHtl9jURrHvI+1FghfgVjMAM6YoRAf/tlneWWN4WPODASjW
 WaQLX2BPt/xQwnVDvgLQ2G5fZGB0avwT/A5iYFMuvrVZvW+4PCIz6Tx8rIpiXSiKzEwrsUbmjdX
 WQFBZhJThhdHbSQpWstX6GmKvmpEdpgPPidB8lphksuJYAZ7PJLRBsFlUKUImkO2Y=
X-Google-Smtp-Source: AGHT+IFV5VWSZEoQzADm1TKD12ZvpYrfwM8HTtH8oCobhT4AMKJriFaCqT3jyCqi3euNVeJlNBCAHA==
X-Received: by 2002:a05:6870:9724:b0:3e8:8e56:671a with SMTP id
 586e51a60fabf-3e88e56b1bamr5734839fac.54.1763489068811; 
 Tue, 18 Nov 2025 10:04:28 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ffcdd8sm7373766fac.3.2025.11.18.10.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] novena: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:27 -0600
Message-ID: <20251118180427.591409-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Marek Vasut <marek.vasut@mailbox.org>
---
 include/configs/novena.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/novena.h b/include/configs/novena.h
index 059b8104e4b4..12fb759afe20 100644
--- a/include/configs/novena.h
+++ b/include/configs/novena.h
@@ -53,7 +53,6 @@
 
 /* Extra U-Boot environment. */
 #define CFG_EXTRA_ENV_SETTINGS					\
-	"fdt_high=0xffffffff\0"						\
 	"initrd_high=0xffffffff\0"					\
 	"consdev=ttymxc1\0"						\
 	"baudrate=115200\0"						\
-- 
2.43.0

