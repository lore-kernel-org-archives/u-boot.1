Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5718EC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 12:56:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ADF84867;
	Sun,  5 Jul 2026 14:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ij5UCLj1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABA9846FD; Sun,  5 Jul 2026 12:08:48 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E15C846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shofiqtest@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5aebf9a50b8so2044842e87.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783246125; x=1783850925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=ij5UCLj1jtUDWL9LWNzEB1tW6LaFVIBPxkR2B6Jc0j+TbAT7PaX1RcAQtT84y/G9Fv
 iKI8IJFfP5aVYtOmTQoZ85ABTG+R6RlHjAm+YE47FDi9NEKyMNB1/LsqUjEikYYrFCi7
 zqvVBBkFlfINzjyMdTvPCQwaOHwg/dZ9v3NCgq0ZfAwT68wHTkaz+ERNx7tkcGiVEEVB
 vOJTzTYQ/tMoX62s0yOowiJukK8gcg6lPayJFEQGqOWATttfYq4faz8Y0TaQEXs0lRtK
 DW73ei6xDepEEdT/0Vl4+46LW7nHWX7sM3p66wlidFRQgQCrpWTDtaBl9VDkFGi5K9a+
 +1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783246125; x=1783850925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFj2L/otFA5Kiz/DkkZ0peWQbVlheawVZyyXg+ZRJGM=;
 b=B05wbgUqj3vvgGtfGYX4wYpCa2KSYeFZPazZBh1A+UsAfJEaxo9W6y4nTHgi0LxhYk
 58TjRsQHbLBmYB4OfkPzUga5iIXA8PF3P1w3FddSr/sEwXOZJFbpW3KIIyeJSyct8sJT
 k1EGq4jSUWSQA61+UymdFlXb1ZoF/4C0EFjjT9GvymMxbUZY3pzIEgVCFYnlLDSj8Z8R
 /sBf4xHYtcj8HAviNOhY58Nv0geSPUPyqK35cuJAyU2P69GI8KUElrwaeMzxfOhURmR0
 EAk9npEkOgZD0FL2JSI2Zr6/s8bSzauJ4bPE17BlwiaTMamniOhP0KVLeChHsNOq8C7c
 sIkg==
X-Gm-Message-State: AOJu0YyRrmRqdFCEg3Vm94+TdB9ax/OmMg/HhJvKHrRVeXjOHEl5bG5n
 CTGgAIEiHaSeWcmCdfAJMN6pvzDu4qjZaQkhc4ySpbbc50PFJXfIU9JVsUPA1NpQS6U=
X-Gm-Gg: AfdE7cmvs0uNxDY86M0famNb1vavADKWZy9MERs7pIr+tzR7J5Y0jjWwpk/I7c56Qeg
 vf0I+YrrmdpsE68ZFIB5/Qpam9LC26b2XuKBaqGwXBms8XTZHV6kAk0/jh8pb3NIORoqP0IR5W1
 RnEMvU2HPOzOewqQNOWQbEYSck/9fWCkaz/CfhcPu7YiRg0aM3qjX1Nm12uL1uBEXrtMb2FEmK/
 NvRNIIrEwi8Jg2Ppz7H/anG8HJa6V4NcyPztJ4wtvxh+bgiywnYLkahVYknyRE3NoLg+3pixQ+s
 ENB2oOyWrAKZMWSs304gQYHsQh1g1h7iIT3v+9cq9XI3dXeQrGyZ1y1Vww3oalIlB1GiUmP/kKI
 9ucHqeEfatJPL/JVhk0zDRJ5+ydjqfGNs9hOzJ/J00CnlNAvgt9MgufMyZ0WVT5xcIZ9CnQ5xq7
 /Pan/qjloy4cUPZhrJ+nF/VZ+k5VjVDZlgHwe6aUOf+rVRmtA+iUvwDJJI
X-Received: by 2002:a05:6512:1382:b0:5ae:b8c3:f951 with SMTP id
 2adb3069b0e04-5aed4f7dd22mr1144651e87.9.1783246125027; 
 Sun, 05 Jul 2026 03:08:45 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c0082sm1964903e87.63.2026.07.05.03.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 03:08:43 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Francois Berder <fberder@outlook.fr>,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] ge: common: vpd_reader: fix errloc array size in verify_bch()
Date: Sun,  5 Jul 2026 13:08:41 +0300
Message-ID: <20260705100841.1186360-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jul 2026 14:56:04 +0200
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

errloc stores bit positions of errors returned by decode_bch().
The maximum number of correctable errors is ecc_bits, so errloc
must have ecc_bits entries.  The array was allocated with data_length
entries instead, which is the number of EEPROM data bytes -- orders
of magnitude larger than needed and incorrect.

Fixes: b418dfe16e62 ("board: ge: make VPD code common")
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 board/ge/common/vpd_reader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/ge/common/vpd_reader.c b/board/ge/common/vpd_reader.c
index 2422db38013..b3f9e96615d 100644
--- a/board/ge/common/vpd_reader.c
+++ b/board/ge/common/vpd_reader.c
@@ -66,7 +66,7 @@ static int verify_bch(int ecc_bits, unsigned int prim_poly, u8 *data,
 		return -1;
 	}
 
-	unsigned int *errloc = (unsigned int *)calloc(data_length,
+	unsigned int *errloc = (unsigned int *)calloc(ecc_bits,
 						      sizeof(unsigned int));
 	int errors = decode_bch(bch, data, data_length, ecc, NULL, NULL,
 				errloc);
-- 
2.51.1

