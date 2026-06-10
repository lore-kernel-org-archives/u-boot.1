Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087C6CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BA328499C;
	Wed, 10 Jun 2026 16:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVCBpFFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC69E8499A; Wed, 10 Jun 2026 16:38:52 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3479849A3
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68f0fc103easo829418a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102330; x=1781707130; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iSCtikH2c+5YGd/aOeiGMSkWkGlUXWQXip3seeDvDqs=;
 b=bVCBpFFinFMXE+bCmucZroG5oaUdrq/ZrjO1ACN9czgKpiR6R7s+WDe3xg8zyea6V6
 gBgIBeYYvVQuBT2bT9d8ngKnAQmg4mZ01TXJDtM46Z0BHg0X/C+9Gq76s1H5HoChaT8r
 eK4SZTt8eAQusxYnGNVlFhx3bEx7z4AZO9qHQfWG33QyA5Z65udOFR3PNqFmyRnbdC1g
 aoQt1cO49VO41/+YoRv+ej9msBcknOBOXS56a2i3vmshywgNOw3Cy2W+cHV3GQtxXSJZ
 dgkQPbaqVZTzB8f00H7l8lWsPEs7UnRW3egFm0rN1Phz3P1e3kTtUG07DG905IPqIQxv
 bcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102330; x=1781707130;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iSCtikH2c+5YGd/aOeiGMSkWkGlUXWQXip3seeDvDqs=;
 b=bqosGOQjP8ZAj+qIQl1PMviOr6MTVlWYDvFYxn7w6rYhfPioY6OgOTxyRT0kWQr+2b
 GE+LteSXcsNpJwF0mOiW3rlRPdEa1lzqngATb+7KGDLoAhA3CySYbp+IA1nTRTg42flu
 E2ZBYeKyTS0voU6mtTS0N0ZDeCg18O9bMqTYBCIzzFattWFwix5pqq+J7HLGhsaEelrD
 TiOjmjBzfdCMKp6eBS/3KfKvQ9eHDtYpetpM4jWYwsBLpWkKNvVqtW3/7uY8c2CXWoB3
 hSS1GJx7sd/Mcgp1tgrA2lyCWXPKj+SqX/DjCqtTkzlA6EXQTN4UWV2W96hMWhfNGKwZ
 N0OA==
X-Gm-Message-State: AOJu0YzXCd5uG0An7Sscbyf69NxQHUHeVBcAVsP7uo2s4+E4x39FVH/v
 A0bYSJaF3R9jMh2gl5caEV1eJv+KQo7RjWO66GTc9nfOZ3tR+aBhkJOdhE+GEw==
X-Gm-Gg: Acq92OF0RTbN2hSWCV2OgvUllE9hRvvSjzO9lOHxd7o+5I2R/TWQ+jn3pdlvFMtRDK+
 cqpScAuHmVph/DgkOH4EU2vBqY18cCHcxaq4Lsa/Ospf4oPHJpqOCa2NlRfxJxUEJqoxUr719xf
 kmBPtm8j/n522J2VtPlVDVsT4U/eqJEhfzbS13OheN6D8+araMfg3LQiKSg1yVhVtwUJirMhPv7
 lNLnJxdXcmjZ2UlUGmxv9sa3Y4KkOm4XW9HCSjzqtEPQY4V8Oi3rcl/PFGtSTuYV8ArBGOrrxYB
 OXKpaE+NQGSGhmcP/1Sk7VjvaT//U248X7iROPGumIggft6a4x4Jx0LPtrcZfZ1f5EgJ3djkjAy
 PuP+08r0gvL3GCeTAaPumy3yzYEqYPcEZDLbsePcAPXFb+ygTA7Ue8Ftuv8wFc8Cuyv495KJGDh
 uHYbXhavcRp00YulfRfZvPxSY1mdPuDBhy+j6U/y09+I2Qae3btTMJSNSE2m7sAXSr0NkPBjzk0
 inl1WsH4/c=
X-Received: by 2002:a05:6402:4303:b0:67b:f6b1:f8d6 with SMTP id
 4fb4d7f45d1cf-69237cb3825mr1924590a12.5.1781102329995; 
 Wed, 10 Jun 2026 07:38:49 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65867e7dsm10075346a12.20.2026.06.10.07.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:38:49 -0700 (PDT)
Message-ID: <f0c27417-75ab-4ed8-b2a6-de6ded740a0e@gmail.com>
Date: Wed, 10 Jun 2026 16:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 08/18] Kconfig: net: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "net":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 net/Kconfig      | 20 ++++++++++----------
 net/lwip/Kconfig |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index e712a0dd2ace..55e7ffe761f5 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -114,15 +114,15 @@ config SERVERIP_FROM_PROXYDHCP
 	bool "Get serverip value from Proxy DHCP response"
 	help
 	  Allows bootfile config to be fetched from Proxy DHCP server
-		while IP is obtained from main DHCP server.
+	  while IP is obtained from main DHCP server.

 config SERVERIP_FROM_PROXYDHCP_DELAY_MS
 	int "# of additional milliseconds to wait for ProxyDHCP response"
 	default 100
 	help
 	  Amount of additional time to wait for ProxyDHCP response after
-		receiving response from main DHCP server. Has no effect if
-		SERVERIP_FROM_PROXYDHCP is false.
+	  receiving response from main DHCP server. Has no effect if
+	  SERVERIP_FROM_PROXYDHCP is false.

 config KEEP_SERVERADDR
 	bool "Write the server's MAC address to 'serveraddr'"
@@ -282,10 +282,10 @@ config TFTP_BLOCKSIZE
 endif   # if NET

 config SYS_RX_ETH_BUFFER
-        int "Number of receive packet buffers"
-        default 4
-        help
-          Defines the number of Ethernet receive buffers. On some Ethernet
-          controllers it is recommended to set this value to 8 or even higher,
-          since all buffers can be full shortly after enabling the interface on
-          high Ethernet traffic.
+	int "Number of receive packet buffers"
+	default 4
+	help
+	  Defines the number of Ethernet receive buffers. On some Ethernet
+	  controllers it is recommended to set this value to 8 or even higher,
+	  since all buffers can be full shortly after enabling the interface on
+	  high Ethernet traffic.
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 0cfd3eb2684f..3beaf48ff2a0 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -18,7 +18,7 @@ config LWIP_DEBUG
 	bool "Enable debug traces in the lwIP library"
 	help
 	  Prints messages to the console regarding network packets that go in
-          and out of the lwIP library.
+	  and out of the lwIP library.

 config LWIP_DEBUG_RXTX
 	bool "Dump packets sent and received by lwIP"
--
2.39.5

