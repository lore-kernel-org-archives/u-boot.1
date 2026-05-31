Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58237CD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E109484851;
	Sun, 31 May 2026 23:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZ8JYNkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB99284852; Sun, 31 May 2026 23:04:20 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFB9840ED
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bec449d57bfso16203166b.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261458; x=1780866258; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QsJv0Wn52j8BLMwTQzQ74MISucydlbcRdzN+/MGjA6A=;
 b=HZ8JYNkH4+p2V2AvZYrPlfgCWWYFycdy8C72SxbaVLXG6N6NevIp2X7J24naG1A+Vv
 Hp8EOnGkV5JtrbPVCyb7qLcz8c8L44Fq1rbQlbCIHTB39AQnUoKC8AMMZtOM7vPjri2p
 FmItpAXRBCQ2jyShZ81zPAw5SJpY40MPFiAmbxZJE1BVYEQK7n8V5W1Ffn9SpYh95CjQ
 jzx0YTqjmwUsihEzjS8KbXFAzf14AaYx9S7U+jhgut+VYEbcV4FEv47EKQJeK0npUO2L
 07Wqy1oZsH/Y3Lo3QWLOyHRDg5RFTf+K0JZx2nn63sTtlg8ZAAUEQ9Fur8tC0guLmsuH
 j2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261458; x=1780866258;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsJv0Wn52j8BLMwTQzQ74MISucydlbcRdzN+/MGjA6A=;
 b=LY2xUJBkoZrrNFqlcv1DudeBB3DaUFYvlfzObqBin0Id8kdx1bJ10ZwxRO6dlzFuLU
 9E5eyLvZmiRAWf8/hv01YlJHKd6w+1rv1gCh5WKB1xxwT0/GTxdBujwueb0JMX2dFf97
 mB44XtKjn6WNsqIrz3MQdDZeAq1qopMDsUwPwSTfU4s9MkjpxuHutrujoGznf7XO7/7F
 UjU39NFJI7G84JT9KhrrljJiRTErAdGh342F8WcpLncReErkwWMq7IleTbMMMincTe4f
 8S4FF1IkCXjHQYqqD0/rVj+vr7pE+HEXT7Z/IEBjjvunbDZq6O1doC14NN3friUea7Yr
 TWuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oQYmZTKzziQvbAfvgHVeHTq9ofi82o4RFJJ2j9VxgfRSIkPNw1uwrxg1YmQoINt1cFlqFLRc=@lists.denx.de
X-Gm-Message-State: AOJu0YzsWKQt13poW0HuflSl3BkhLnpyl055zA20yp5VA8cvCsfyj0RF
 +r6X83Vw4LgNt1SMXvx1gJQnJsdjD+rsHggbbqu2vV2FjcmHHB0UmKCn
X-Gm-Gg: Acq92OFSdzsvC/KjNLXZrsDuqghSx5evbSDLs+PR3xAAlzxtlOk2ofR1v6AHvfIDrXc
 5Mv++wdnBZFmXu+CQgR8vZ9E5rMR7rSxT+VSxk14KP3If5EdlM+8n9RSAHqtUpNOEdtLqKMx40a
 8B8n5L/2oI5IT82Tf10RCKGBW0GHh4buXHmcxekfO35LNtHH78DRfpKkKGfGzWi5AzlpNA8CK6l
 cOoJI1+gjxHaOsSsWjhN1UsQa3edl/J1LhVXS5Et2jOiw6fqWsRtbnhCQ+VppbDYp/8U9R+Pnme
 ohA6tfE69ELcK/N7XeTxQ27dIzK7ds8OC//3o3H633vx/aPdTivsu2oTtSuG/73Zr/0YMuIzkPd
 gLy4ChAQG1F2o71AR4z7b1c7ddyWWhXEVe89tZXpsxdC+hZJishCrGIK66DaS79ffb5I/mYLIgY
 Et5QZHZg+3j2MbpBYOoM096ET6XpYkViX3g5ZKPOVmw5Gq4PQgZX8U7nZ/HI2zevM5CQRDDzMm
X-Received: by 2002:a17:907:d93:b0:beb:3449:5fff with SMTP id
 a640c23a62f3a-beb34496088mr118415566b.0.1780261458213; 
 Sun, 31 May 2026 14:04:18 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-becdb41500fsm62523066b.41.2026.05.31.14.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:04:16 -0700 (PDT)
Message-ID: <d001285d-c059-497c-b4b3-79f71f52741d@gmail.com>
Date: Sun, 31 May 2026 23:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 10/12] rockchip: spl-boot-order: add usb boot option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

Add usb boot option to spl-boot-order.c

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 6572dde29f65..cd17af13f41b 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -76,6 +76,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;

+	if (!uclass_get_device_by_of_offset(UCLASS_USB, node, &parent))
+		return BOOT_DEVICE_USB;
+
 	return -1;
 }

--
2.39.5

