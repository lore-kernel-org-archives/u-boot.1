Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EBACEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAA683F37;
	Tue, 18 Nov 2025 19:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gapy0wc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E7983F37; Tue, 18 Nov 2025 19:04:07 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B1E83E96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c730af8d69so3396474a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489044; x=1764093844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ITfEYwrNmnLLAAvzyVK2uxCDgfLmjR4KyuvOd3b+VxU=;
 b=Gapy0wc14Ltvq4Gw7k+sqyTmfzhmUvPm5r4p/l7M+g+HC3sPIV+uGNqEDBfXWBNyYS
 8NvetNMzYIQxWmeoJEHQuG2lmPdgc1dHKPzM1U3tU20dapeVoJthv2USuDcPcE+TP4zm
 oxTQJXp6OjCzWZFXryUvEhRMjfgwSpPob1/gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489044; x=1764093844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITfEYwrNmnLLAAvzyVK2uxCDgfLmjR4KyuvOd3b+VxU=;
 b=FQM2TkvnI6exVnHiXDAJzHfwENJsYy7gMox6bZDJnplhzt/GuIaiEh0wEz+0I0grNH
 9iV223oLJeAXce8CEJ72cjxgDH1D/X8UoHY+jjvDG6PAR3uBVJU1C6tX7MwNCsvk+5XQ
 4PIHjpwc/wSylQ65c742wYyi5DmjC7O4FImJ57zLrolJOx4IRo/DHbXpdyQF2/U9ggGF
 Rep+6rm4W42zSt9zald7Yjc5axY4aRlkctRY/KcaP1dl2WdbCy72DqdxLWiLtu6qA7dY
 m8Wzwlwm/y5g8QxoKHADTCO+AnYEhojrtA/nWKAxtP9dtKE9uhbfeIppn6XCQuTWBS4G
 tlhQ==
X-Gm-Message-State: AOJu0YxM7A7903WKW/6/IOOCeyiDLyj53cCHare7QZcvjeqnvsHMHsNy
 7m4+79R5VPpkYwG6LyYOEf8EbcL2+oWtNxPDTVxqkM76nnSQ3yahgsd+SouS8lcmA3UDKTBkx+m
 tCkO/rF6+1A==
X-Gm-Gg: ASbGncvWDV68jYH/qfaL6PDg3o0nrdt0ZbRsE2VQ9C5CZS0skUP1DGHZ9KypNCY5F5Y
 TKEQhP+wlxSrqQV6ZNSBbwiizDLpCewCdYLF/8IIjw9CSRo1MlTD7ZOkfptKNAIOUFiZ6hj9gzP
 Xwxo6PZV9AryU847lexMlIXRLg/qor8IwgqAvTVS1wU8ppMfmiHPrs4gtLQ2wVxM/6d5NZzDpoa
 qkMB6hxj2ZH3Pgb8Yg0YX71DuwVRsQw0ITPnVJAW5usMPGsVuQXP9UmBk8JwsiryoKl1Pp1IDVr
 dqqluyWhQBQdy3UyjJkkenu+z6eSyUxNARy+1vFrv8bNvHhCf4r4j70siBQpOBdV9wDreATRxe7
 rKm8QFjaFCvPsoM4gNKfdbHzl4m955nfNEPKckSuxShWZukNHZzg4eia0fs0Z6tMMlHfmM2fZzB
 NX0B71Hp/iJ7bcN+Shv9OLhaYybYBePXTlQ0i6WYxT3Q242FZN4qoi
X-Google-Smtp-Source: AGHT+IHzC1tRqpJrBmFnJgguOYQ9vEMMiVOF3vEcBt211FaGOa2iXsMfMnTYnKLK2uBP/tMy0DKCfA==
X-Received: by 2002:a05:6830:d88:b0:7c6:ca1f:1779 with SMTP id
 46e09a7af769-7c7445b7ffbmr10234217a34.30.1763489044559; 
 Tue, 18 Nov 2025 10:04:04 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c75974466fsm3241760a34.26.2025.11.18.10.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] kp_imx6q_tpc: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:02 -0600
Message-ID: <20251118180402.591115-1-trini@konsulko.com>
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

Cc: Lukasz Majewski <lukma@nabladev.com>
---
 include/configs/kp_imx6q_tpc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/kp_imx6q_tpc.h b/include/configs/kp_imx6q_tpc.h
index c0cb3db23e7a..e89e9601ae82 100644
--- a/include/configs/kp_imx6q_tpc.h
+++ b/include/configs/kp_imx6q_tpc.h
@@ -19,7 +19,6 @@
 #define CFG_EXTRA_ENV_SETTINGS	\
 	"console=ttymxc0,115200\0"	\
 	"fdt_addr=0x18000000\0"		\
-	"fdt_high=0xffffffff\0"		\
 	"initrd_high=0xffffffff\0"	\
 	"kernel_addr_r=0x10008000\0"	\
 	"fdt_addr_r=0x13000000\0"	\
-- 
2.43.0

