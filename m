Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4710CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6719D8488B;
	Mon, 15 Jun 2026 23:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y5DXOTFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41542848E2; Mon, 15 Jun 2026 23:08:45 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C5B8484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68f9f1814b3so537652a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557723; x=1782162523; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=anl4Tr//xD8T44PYrkL0pBcSYq2JMp7UYxWbl9LQkQw=;
 b=Y5DXOTFSKP7wwZj8TZcvbO+azY7cqLh/f7nqXo50oIQURwMV725Yip9SYd87LLJzV9
 00Gmo9AROjB62kNWRS9RZI96L8xunioNtsjslI6XEx5gHevLNtHKwLjkGGvkPMw61e+S
 63w/G5o3B6NyvgZXPoKKRBYfww5ug6CCscaYJtVec/8gn9PqhqQtrrgTux2Mcdw9EOFq
 1+PoObMPV3CPa3rrAKu+kzWhGRIZ8S5LDjPdpaqpIQ4JU3krstUBb2pNcyGW70DNgf8i
 O3KZvswocSB0Vb2Tjyu9FtfkqqPjlRHGOodkKbfFhtuTCMKwNexfbgNwjIRLcDF9qcks
 qZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557723; x=1782162523;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anl4Tr//xD8T44PYrkL0pBcSYq2JMp7UYxWbl9LQkQw=;
 b=kQD/FgaDZMqwisinvwHm0oQeKY3VFREYL6hcDZ3S1Mc99wWjarqNT4XpjlELwftXrY
 9Mf8zMBwkcURBkjIzI8067Ng8npfyJONYD3nhTO/z3K15ZleKItj88rEGn9BuWuX5ri/
 o8azuuepKxE5CAWuk9lc9m5fgFWOazAlrtqJLFhO1dnm4x+bnUIlCKZWqPMk7TRUQ0Vs
 XyU9vRkpFp3JP7WipHgea2IXIbHALXjZ2BTp0NTVqjiITrP61elZtjSVZU2QoUtsNUuq
 dPLqP6yMKGCGxbpp/wN+kk6a3zkJ1tlBFtETbu1xK8LzlnAA/RFjgwrWv4FJdRMlCHCQ
 TFBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VdkzA6nAocGOQzo6lfkxRCZNZ9VAjwdtCT6ZUhwsRFWzINo9O4zRGK9/3GocAJ7AxezJ28rQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyRiP9W1jVjS2VmRI+LQdQ1uu17a7Z/gExYCVzREsF1dW0x5SRH
 Q3wreIDE+pxPqsgSfJBek6pDBcbPldS0rtEttWt2uvhfvbpmW9DbuOye
X-Gm-Gg: Acq92OF9IfDd26YZc+CyJAU3/YcPgNQ+bPbqvjDGRtEVcOYKpmFuTIg4KsBfIjac/HJ
 TOndexW8uGKobI9tv9BxQCmiLwqn/geT/8BymJ/zXOmgjAxlxaOLdLLZWr+B01B61Ut7kj54hXj
 h3RoQeQSOLEYrGv6Z+ADgbRmHZhVJ0YOpf4TBASBuQsFfbQEK0C1MMcJmHgIVsbCC0elcdwJYp7
 fNXw3sGaPFTfstYObgERH82JYKxsNFAwwHKvMUJopQelKqPYsKTF+cVf3zpjjg6/Eyec7+ZwwcA
 cjj7FubEgxK5QaaCjH1dxoUNgaHRRxbWEu3kwfk3haK2YJdaE4pAVNQ79Hqo83FgSyu79pG06Fq
 N4Vwswpw18pfyVKWi8rzaqk+84LuAM3vssdRDbqy93IP3HSxVSvXlIN1QmBw1khBsV11Lyx7fT1
 IxlYnL6/Dqi/sOz+6wIeFma4G7m8GfaicY724gc7Io3DL+ahZoaaCwrXxtwMpkaikianQkiSkw
X-Received: by 2002:a05:6402:3605:b0:67b:f6b1:f8d6 with SMTP id
 4fb4d7f45d1cf-69378a68a7cmr2651883a12.5.1781557722766; 
 Mon, 15 Jun 2026 14:08:42 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937919b54asm4103425a12.3.2026.06.15.14.08.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:08:41 -0700 (PDT)
Message-ID: <f66bf3c3-8b9c-4400-be36-ff1f3a1c6643@gmail.com>
Date: Mon, 15 Jun 2026 23:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 08/10] rockchip: spl-boot-order: add usb boot option
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

Changed V5:
rebase

Changed V4:
(Jonas)
use uclass_find_device_by_of_offset
---
 arch/arm/mach-rockchip/spl-boot-order.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index d2dd5e10935f..1ed8c5728f2e 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -79,6 +79,9 @@ static int spl_node_to_boot_device(int node)
 	if (!uclass_find_device_by_of_offset(UCLASS_UFS, node, &parent))
 		return BOOT_DEVICE_UFS;

+	if (!uclass_find_device_by_of_offset(UCLASS_USB, node, &parent))
+		return BOOT_DEVICE_USB;
+
 	return -1;
 }

--
2.39.5

