Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117AEC5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB2A782BA7;
	Fri,  6 Jun 2025 08:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wfTz6T5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33A182B0F; Fri,  6 Jun 2025 08:42:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0585803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so13957895e9.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192151; x=1749796951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=crS4ydRIxBSYB0S261pOHW7PXeJ7AFsXNow4Gw/EOeI=;
 b=wfTz6T5VzknLWuHEZlozcdxZ8WYPdgK5UNzUfyoA/AamgaaL16ps+iaysG8MlzCFav
 /fdP2NjRDN1p4hpemIGfhZ0rrjINZnWjMreDE3yByDAlfuFF6GGVlp1dNd/M8JFtPhB1
 uKAZJPDRMMEcp7fjTS5e290Bs90yiZTaxZv+zCLvyZCSdgX2leTTRPKslLurspB+kBwC
 HXh4ind61OjjuQoRdY8wYxVaNC5w82xFEXovgI54480eAqPNTSfbssKYCsvyc1Kj7qRU
 yMYykwdFU1vT/kojBRlsdEZmhaL8E+SzrJdocW7rTd8XsTZaPsqxqDA0tvU/2fIj84g2
 JjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192151; x=1749796951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crS4ydRIxBSYB0S261pOHW7PXeJ7AFsXNow4Gw/EOeI=;
 b=il+dwrotszqwclTPpgF3wKmY19R0VGxthuafNOOIwPVt16wubRziJMDe6IY3mwPU9m
 WQiHSBSMPPhCdW+tTcjJuOpXuP8Z+W0E3TtfKMiH3Wd6TlM7h2SlgpQix6cSDXamX6jp
 gx1h0q71SD+yomPFxNBTikJEXnIz2QN7fVfJj1CLqgghu0MJLCcqEwLKPf31ltwI/WcO
 LIq6W9feorVfALXoWzyqJ/c1j0ylm1y9FeHWbJsF+4CiqBHMkBEn4mh4+hdfJsjIqhGC
 uhaun3G6HI6tuzIycbzyuhqaS+UgBfyqwSGPm3pEiLuGmsvnI/ZADCzY/Mw4/XSxILfj
 SsGg==
X-Gm-Message-State: AOJu0YxK3/mTL5oPzDDX84ZsYKVpU52oVY4aTF36J5t9vy82HMbwE4Q8
 ka89FDmEsrusfNj0RDoyheR3qjLGraaI1HMsQ0pgPGEeje9hCjdvFZxRMaf3aOk1ivo4vtlOAC2
 Xol80
X-Gm-Gg: ASbGncuash+f0SCD1HpFfpeTJc8NwNhypAOjYg1P0bhkaEjd44/ENbrie0Zw7UUCTtY
 7ZHF1IhJVMx8wflh590150wPpI97OZ2dGiM8CgWvITTJXQmhZ+dT4TZUUbgZBE4qD/T0Xw+gvMl
 Wh6dNTI6g42+Giisrnw0asj0EBTUanPB9R0/f/bsXLX99sH4Br0W/NAoT3/4HEErdrMiz81kjip
 nA+VfsbBoscJtp4v7TBlE2sKStaqUgboU3rQ3mFZoHet5jF1NsWmKmtNhW/e7mlQde+WOPf8YEL
 /Lxah/0EjiFLKS9Srri3uchO2eZhZVeJipY5PgrFxvis5mPyjNChtc5ubPv3fzjxBTF4gcQ=
X-Google-Smtp-Source: AGHT+IEF+7d8SkwD1U2IOvK3WTanYReux5Pwu0tERQdYvfSs1dt3Xwb+UQK70Y7Ol6jEjIxJgoenmw==
X-Received: by 2002:a05:6000:2482:b0:3a5:2848:2e78 with SMTP id
 ffacd0b85a97d-3a53188e2f2mr1626235f8f.28.1749192151229; 
 Thu, 05 Jun 2025 23:42:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/13] lwip: ping: accept host name when CONFIG_CMD_DNS=y
Date: Fri,  6 Jun 2025 08:41:45 +0200
Message-ID: <20250606064211.3091237-10-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Update the ping command so that a host name is accepted in addition to
an IP address, provided DNS support is enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v2:
- New patch

 cmd/lwip/ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 21931821521..9fe02a21a78 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -14,7 +14,7 @@
 #include <time.h>
 
 U_BOOT_CMD(ping, 2, 1, do_ping, "send ICMP ECHO_REQUEST to network host",
-	   "pingAddress");
+	   "pingAddressOrHostName");
 
 #define PING_DELAY_MS 1000
 #define PING_COUNT 5
@@ -168,7 +168,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	if (!ipaddr_aton(argv[1], &addr))
+	if (net_lwip_dns_resolve(argv[1], &addr))
 		return CMD_RET_USAGE;
 
 restart:
-- 
2.43.0

