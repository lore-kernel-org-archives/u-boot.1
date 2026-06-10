Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D96BCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86A384974;
	Wed, 10 Jun 2026 16:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rKjFskb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5162E84975; Wed, 10 Jun 2026 16:38:13 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674A584971
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-beb19bce272so83440766b.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102291; x=1781707091; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hg8jFM+P1ne9PNkr0MWb49/wnCWOgFOl8e1ab8+BMdM=;
 b=rKjFskb31hgpmB0f7DkK9IIFHK8s0SpKDZh1Fv7e7ZZtK4+XJ1e/UUFT0Ph2Q3v98v
 J96GjIjDpHyqUBogE3krCaolnFGrowDdPtqo0bSYRP/01K3CeY1x6dPR+imApsQByjb0
 tqYDPwJ1a2yjoBElCqg5Lr/Vp4fC7lXbbuWJeo+ycWcA2xLZEviRpYceYVD4cOWfh+k1
 r+EzhanBP08ytVKPcY3xPfDpZbDKOYL2CT8z4x7LM+T7xoYKOS1H0v0NRX34ftyL2Af8
 h35TyRQ2IgNtUaHxcM17Av57ehKgBXA3mx+dpPQk+kqdvpSWsiv43nGE1M/+fMlyYfVj
 mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102291; x=1781707091;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hg8jFM+P1ne9PNkr0MWb49/wnCWOgFOl8e1ab8+BMdM=;
 b=cv4XrLBfj9OkqTn1U7+2EbsCr4skBpdkKhVLvlyLeEKyG4wtoErjh0foJdb5eC3R4t
 gY8cDhbMV9CKJ6+S+tP+0j3G5FF2ugMx0vMX17SufjaPINvruJ3iLim8zqDktPhip+LP
 BGPrLUAxWXIQbw6NVOcAc9sM7ZfcMSgiXybuvqtRFjsOQkQYMGb/woZ7PhGtz6N5D6dl
 R4zTsCYt39VsNLq2OUoGgnvbNLM00JbjXxNX7e2lAiN/K8hhSQB18T0OLzLiXzNfouZm
 16460//d3vpKQUttmbNAwV0hPMCsMLlMWC5QTud7KI3NzFVEdEVKMPFlY9LNg2BVdzdO
 0IEg==
X-Gm-Message-State: AOJu0Yx/JdulEU4kR247CqdQOooMa2yHNx7a+ziKMbHsfqW3UvMdcWQM
 aoaOIThLMGcgOFSvcCUokUZmGTYkHIOjeoCEpiYLIhYnR4e8s2C93yhg
X-Gm-Gg: Acq92OF8fZnGSuBPQJTDcGCGwhcPU3+l/BoCWFo7xi0BD8igwu1FA3/bY3ZiD7LqfdO
 SDvXetUX+wZcamI0da1Ho2tr6RHbum1b2sCRRxuTq+A3PPWM8ki2geOcYLhy9CbjO95qm+fv4px
 ERf9j93RaDb2RKBa2WbjEgbMLRqdHmvEN55HiPepQ+zU2JAPzW7QHAIG15cKaXfXjw0+lVBQMe9
 zgfR/znEGx+0k5Y1rm14IS0B0QY9ewHiEQ+JQvDO6MOQb3+SOJ5apK4ki2ZjDE4OAsWJ3qdTFYD
 LXFsIFeINMOVJ0g46/4M/XLis0WcqstE8Spz8eqab/lidHHn4F0pTJhK1zB/b70udzym8rLe+0M
 XY6q3CfAbKhnhXWBrojRMCc2aZUyFhMUP7sW8sMYc/SVwNfVBpNe3UkQ/UDamQepGhjPLdtNVHs
 NEVk1xb1DQkTzAcMKE/FKxuvI7Yh/KoL4sKIFmOXl9tjuKFqqVMAsbcvyW/JRs9QP+OyGu/Uyy
X-Received: by 2002:a17:906:f58d:b0:bed:9664:4a28 with SMTP id
 a640c23a62f3a-bf373901cb8mr597675066b.8.1781102290631; 
 Wed, 10 Jun 2026 07:38:10 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05228a16csm1198102366b.28.2026.06.10.07.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:38:10 -0700 (PDT)
Message-ID: <5759a07e-fdf5-42be-b2ff-196c4ae855b3@gmail.com>
Date: Wed, 10 Jun 2026 16:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 05/18] Kconfig: dts: restyle
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

Restyle all Kconfigs for "dts":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 dts/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 6b501c2239ed..a1cc18227aa7 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -224,7 +224,7 @@ config DEFAULT_DEVICE_TREE
 	  $ make DEVICE_TREE=<device-tree-name>

 config DEVICE_TREE_INCLUDES
-       string "Extra .dtsi files to include when building DT control"
+	string "Extra .dtsi files to include when building DT control"
 	depends on OF_CONTROL
 	help
 	  U-Boot's control .dtb is usually built from an in-tree .dts
@@ -297,17 +297,17 @@ config MULTI_DTB_FIT_UNCOMPRESS_SZ
 	hex "Size of memory reserved to uncompress the DTBs"
 	default 0x8000
 	help
-	   This is the size of this area where the DTBs are uncompressed.
-	   If this area is dynamically allocated, make sure that
-	   SYS_MALLOC_F_LEN is big enough to contain it.
+	  This is the size of this area where the DTBs are uncompressed.
+	  If this area is dynamically allocated, make sure that
+	  SYS_MALLOC_F_LEN is big enough to contain it.

 config MULTI_DTB_FIT_USER_DEF_ADDR
 	hex "Address of memory where dtbs are uncompressed"
 	depends on MULTI_DTB_FIT_USER_DEFINED_AREA
 	help
-	   the FIT image containing the DTBs is uncompressed in an area defined
-	   at compilation time. This is the address of this area. It must be
-	   aligned on 2-byte boundary.
+	  the FIT image containing the DTBs is uncompressed in an area defined
+	  at compilation time. This is the address of this area. It must be
+	  aligned on 2-byte boundary.

 config DTB_RESELECT
 	bool "Support swapping dtbs at a later point in boot"
@@ -398,17 +398,17 @@ config SPL_MULTI_DTB_FIT_UNCOMPRESS_SZ
 	depends on (SPL_MULTI_DTB_FIT_GZIP || SPL_MULTI_DTB_FIT_LZO)
 	default 0x8000
 	help
-	   This is the size of this area where the DTBs are uncompressed.
-	   If this area is dynamically allocated, make sure that
-	   SPL_SYS_MALLOC_F_LEN is big enough to contain it.
+	  This is the size of this area where the DTBs are uncompressed.
+	  If this area is dynamically allocated, make sure that
+	  SPL_SYS_MALLOC_F_LEN is big enough to contain it.

 config SPL_MULTI_DTB_FIT_USER_DEF_ADDR
 	hex "Address of memory where dtbs are uncompressed"
 	depends on SPL_MULTI_DTB_FIT_USER_DEFINED_AREA
 	help
-	   the FIT image containing the DTBs is uncompressed in an area defined
-	   at compilation time. This is the address of this area. It must be
-	   aligned on 2-byte boundary.
+	  the FIT image containing the DTBs is uncompressed in an area defined
+	  at compilation time. This is the address of this area. It must be
+	  aligned on 2-byte boundary.

 config OF_SPL_REMOVE_PROPS
 	string "List of device tree properties to drop for SPL"
--
2.39.5

