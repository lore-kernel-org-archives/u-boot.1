Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF2DC55165
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21D4440A66;
	Thu, 30 Jul 2026 13:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zMZ74S_Nd4fx; Thu, 30 Jul 2026 13:35:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9987240A6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418535;
	bh=UcrocoYkqaNxwBsCKIK7bp39ZmxHbo5EQN0N5sqq0CA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ev8i6XuU8ZQL8tjEaWdaPrDulc+niw7OvFbyVnXLMGC69ls3GQJDm7AuicqTVMPtJ
	 nLR1kue/2e6qApLGdbUd9KVJCaQt6/DMjqhwk143ciW2yNPxagaDeFht7h/piE6IpE
	 ncs0U6VsoQXSXz6Nrw7W0FaVrxi7Ue12ishVMhqVhTJHgiV3+YHy8WjMX7zSYufHsf
	 bL7c+PubZqqBfRCrICbseltYqIt9p3l0cJYUBjBhi1vn2+zHlByEFpHYj8qwM7M7E0
	 wDcu+rTyyxewiSYp1ZknfQSz4vmX66PPKDpF1NoaKSf0QdoF1sAPyL/Q3gz5sxa3YS
	 prmjPLV8Gj8/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9987240A6C;
	Thu, 30 Jul 2026 13:35:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1964027B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3ED160895
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzLrkI2tRycY for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:35:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 10ED86085F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10ED86085F
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 10ED86085F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:35:32 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso20039766b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418530; x=1786023330;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UcrocoYkqaNxwBsCKIK7bp39ZmxHbo5EQN0N5sqq0CA=;
 b=K5EzldU87lgiagfrvr85hx5IB9gdnxUMOju8BEyJiQprVHSJABvWK9aQjb3gza4zFh
 BrEObNCmasUk4oALmLScYBMyyhKYJX2QBE11R4FTQdAaF85OeVJuxJ/3Zc/X8NYmrLrm
 Laxm1Z1Qb1c2bsSq+Od0Lr2M74D6WdwXMVQWj4+DnVEN9Dec+FoCx3m0ewc0O16OZP6C
 K+TsyhVqWU1cLC2OPcs38aTaeVt/cR7xy2Yf7GZo0p207+ES6+wTfIWV/h9bEyBjxV5g
 YluGxzBKhScXf1b1p/enPFIyiVMmGAW28HIbtivTo+2vPDQST/+n8k6HAHWCjWdXYshH
 BTDA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSePOumV681oiq5XOs0tDcBQ6KQpZiC5wWrm4Jq0LdSsgsRgzUq/fz4StJ84VwR/6X0u0ms5o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyyXyZ8+F9nnh5TSa9oDRfEbp5k/lewHM6j40gF4gHL/2lGoDES
 2pEvbkcCMDOkeSqvyZJLvau0+zWP6zC0CN9lYF8mOkVpeNu6C3OXdsuoY0/Zeg==
X-Gm-Gg: AR+sD1062DF3ymDWQw88UtjLHTjD/DbWs027uZ7KRCyVEmWsqXhrknYmILyVh9ibgA3
 bYYUScpbkcBitmOYXsy5B7nJq3dP/3AxsPQT6bLuuWwDHw+ulb/+2IArNTE6+PGH+ww3kiUx34J
 cQVTEjmTrqXCl34Qeurb0Spg8sKsFl8DHKq5AAZhgNj+GXaLuipVhfN+UPFrZRLSn8RkU2plbQZ
 yR+FfPgCf8agk6VhGI03L9GNvKiz5yQ8f0wEud54Ona+q37oCP2+wad6p5xrcau1Q6MUN3UEdXf
 uPkpx/sabktf851SvKfSbPCx9dIZG5fbqvcC10tt1G0cVVFz6PUPcG8bVSJlXPy4kVAgDNrEgYi
 3YRlHm9sMbGobTdlBQq7TsjkHck9ETL6gB9txjAS/9H7oQ0Pxz6uj8TGAY+Zwohd4IjMh4pUPYj
 CUe0xM+anshUGN5mPlfVOVZNbyzK+pLLhs7UbgCp6xiKjW5R6bRYQLUYgEj+gnm68UnBwJ1nB8Y
 EtthqnyAW99mTRX4wX66m1GQM4=
X-Received: by 2002:a17:907:3d4e:b0:c12:6db4:4bf4 with SMTP id
 a640c23a62f3a-c1fbc8cf2ebmr29756766b.0.1785418529965; 
 Thu, 30 Jul 2026 06:35:29 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa8bf2c99sm69227366b.62.2026.07.30.06.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:35:29 -0700 (PDT)
Message-ID: <1eac0a41-c3bc-47e3-9868-36ff49f9c84b@gmail.com>
Date: Thu, 30 Jul 2026 15:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 09/12] rockchip: tools: add comment section to rkspi.c
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5aed2a27-bd7d-4b71-a6c1-0b46b41f3462@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785418530; x=1786023330;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UcrocoYkqaNxwBsCKIK7bp39ZmxHbo5EQN0N5sqq0CA=;
 b=dxcEGF0v3zj4OzxcILWSU3YXMWEZjq3vwvmkjAIPorCAeoUubevjGeLN2rXzqKk5dF
 NWJhhXP6kfONC4cT+xBSXOA8UaYXLK8kRg3uLQQEXd+oF2nDzDx/Y0e+SDyBECzrR/BH
 thgvabEyFMhFOvLMiHOIw3lplMb6FFMNyk8Hi+vKah3DsKXky6JfbAHDm736vdxM6yXC
 YbTBKETM3Gz+MyqGVz1wJVCvgYB0rZHWCnbGYiz19UDwwSPR5M7tG8kAZcoNBfNtUpQL
 /ApF9qAcfnN22AeZm2zRRKfnUHoSkPauAdTh4fGg6b3bX79IgFbrgQIld29ypvJJu3oK
 U3Dg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dxcEGF0v
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

README.rockchip must be removed.
Move the rkspi comment section to rkspi.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 tools/rkspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/rkspi.c b/tools/rkspi.c
index f2530f7bde34..4f98a60a0692 100644
--- a/tools/rkspi.c
+++ b/tools/rkspi.c
@@ -3,7 +3,11 @@
  * (C) Copyright 2015 Google,  Inc
  * Written by Simon Glass <sjg@chromium.org>
  *
- * See README.rockchip for details of the rkspi format
+ * rkspi.c produces an image consisting of a header and u-boot-spl-dtb.bin.
+ * The resulting image is then spread out so that only the first 2KB of each 4KB
+ * sector is used. The header is the same as with rksd and the maximum size is
+ * also 32KB (before spreading). The image should be written to the start of
+ * SPI flash.
  */

 #include "imagetool.h"
--
2.39.5

