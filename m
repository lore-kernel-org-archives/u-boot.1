Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6382AC5DF7D
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 10:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3F0D40754;
	Mon, 17 Aug 2026 10:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ayx4j-32AUFV; Mon, 17 Aug 2026 10:56:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FBD540756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786964173;
	bh=NWvTi0fXiNLGzrsQtMg2X5SxB+nxmq9j1N/ZVsyYegc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B11iT/xSGHnHCLI5a+rmgsJymlkD7+kZCRM+/VYV1UbZzX3Raj2OqISWoysmDpOTk
	 puXDCmQZLnpkqjIRsWT+InSrsjUNVru74Y8VVPyBZpf5Uk2APvMU6ZrJmhAS8AXXz7
	 hxycMzO74YuB5LkvAruw8SAk7BalQQXW/hT8hdoDmiDdF8WzvyuJoL/XIRLnL8GoYz
	 tWvz4oLqvkU+s69OnjHA4MqmmwP8EfWwaNaa88Wwfsaq4arp6HYnKqbqVARr6Ha/FV
	 zGYuXJIpZCa4N87dlFNM86BIZZNKapVaSvDXCisfALDZ0mXYdLgypJowYZ3KUNEHMh
	 C+Uv59T0jkSQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FBD540756;
	Mon, 17 Aug 2026 10:56:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89B8E282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 702B1400EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yDQ41w9RU2f for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 10:56:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=daniel.schwierzeck@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B142640090
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B142640090
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TUMtock8
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B142640090
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:56:11 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-476a130c138so3400483f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786964170; x=1787568970;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NWvTi0fXiNLGzrsQtMg2X5SxB+nxmq9j1N/ZVsyYegc=;
 b=TUMtock8J/VbD5JG/hkWAAsn5WTDS9w6TFTvmepcgDt+/GuG5H3LY+eXfkgfhYJTKh
 WBYESdaxf2y4wCh9FTn6jOCWv4e564AGw3tWM2AbDM4r4pbtp683FcYMTdscDAdGl5rs
 h/AAcHMxvCCSb8XntVwrFRT7++wBaQAU0kPkFpvafK8qDunm88EVUW9AQcVLTYGmaCGY
 i2vXPrseXtcpJqNZPA9531vq3wWL15L3U79621EplBDdKl2Wc0DqQfDSvE6qTPw9yhbs
 VZISdZhtGQaDMfBSrCd+gdEyAUJw+sVzyc9QaTz9B3rJ2W18gINCPtqhjpSypdkXtGsp
 +MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786964170; x=1787568970;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NWvTi0fXiNLGzrsQtMg2X5SxB+nxmq9j1N/ZVsyYegc=;
 b=l1lR99Gk9NU2jRUkbPtm6qjG4LiEjufgFnLviJZbyUh8RJHgc+7xd/bCSj+7UFGTsD
 1gXoO/ZAq4WutYOSyGczJSxxMVlQy2J02i5e+GT1z6qzgiEF5/ERKj0fVbnowbm/VRsg
 YRADs13lxMX7zv4JaVBF6b1PmOpj2xYNNqAM6dXCOJhxZlq7rpzfxnpTC8BvPsRFKYqB
 AIZemHYtFQ2n1IwFbtsh5vMA4t0kPQyGud9t5oAbhlxoplHVLizdQZZ0Yr75wz4/DNzR
 8dtiEJEiwZ0oHayUUj2mFxBPqZPBwoozhbEYbeqkl91Hr17qqnXf7La6LACKaWwCCRjv
 qfgg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwzJd7tV1xswIzuVx3FMbuoHySBjqcPPkiPkxu4rZ7e9q1SflIEjedVL1NyqsQR5lR9kAWofU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yz6KDoXUiAHrwslSZituAR38jTuph//cyUGlsIVHrcLfbPp3hVr
 2nKwghshEqrYLlPhAB9YNs0jU++mos1jIZUaiPSfI3cGx0UNJf2FUBGv
X-Gm-Gg: AR+sD10EHMtgBkpffboZfJUOEF2BqUQq4utyjy3UKXwU8wSU+JbaQYLgFlK+TnqgVv4
 zjMwUyC3RFFlPgwVJcpGyoT5amdWCiE2CDmD4O6VcVOIqGpKgrDHniHmqlCgvwrqP+se6GwrHrd
 ia7Xe3WZN9DN5MeSXfTHsMJp/D+jQtjBphRxFW+h6cLZB2tImNsevxg0xnfOjemVLXRM/uyz/pu
 4Vj7wdwB2Y5xOZOj8xFT/EaX0V1Mvt003ahCWl4KZt0rNfk/t9j3b0X+GEA4SaaDYO7vgCUHgid
 OtgtUYhoIRPOgMYtmJXHzWx7KnyrB+5iDaMJPC+6t3GKKksgJQ0/qB6nVmAAHkoI/RYhAy/bglX
 L4NAaWcnB015XAaz+pMQwUg3nToF4muAUI28uNTXTFHv/q2E9jV5x83DNkq39i6yoyATpEV71sO
 QRsta37nZM1ZqGHKHduK0mBdRR/d8KgU67IKV++LisbLtJgXGl/19jPKUDrfqW0lFsFQVamPrhq
 aIQLRQh/Pe4g657094wBgkEEsnLqTFownVvJ8HJXw==
X-Received: by 2002:a05:600c:609a:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4998d7aeb12mr291311305e9.3.1786964169520; 
 Mon, 17 Aug 2026 03:56:09 -0700 (PDT)
Received: from ?IPV6:2001:9e8:af:f810:5a66:bc0c:3472:142f?
 ([2001:9e8:af:f810:5a66:bc0c:3472:142f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a31572sm3057467f8f.5.2026.08.17.03.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 03:56:08 -0700 (PDT)
Message-ID: <9e556ea0-1d90-4d13-aa58-af5c24f688ec@gmail.com>
Date: Mon, 17 Aug 2026 12:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: airoha: sync with linux-7.3 driver
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 Markus Gothe <markus.gothe@genexis.eu>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>
References: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 8/10/26 01:27, Mikhail Kshevetskiy wrote:
> The code was synced with linux-pinctrl/for-next (future linux-7.3) branch.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>   drivers/pinctrl/airoha/airoha-common.h  | 27 +---------
>   drivers/pinctrl/airoha/pinctrl-airoha.c | 66 ++++++++++++++++---------
>   drivers/pinctrl/airoha/pinctrl-an7581.c | 20 ++++----
>   drivers/pinctrl/airoha/pinctrl-an7583.c | 42 +++++++++++-----
>   drivers/pinctrl/airoha/pinctrl-en7523.c | 48 +++++++++++++++---
>   5 files changed, 126 insertions(+), 77 deletions(-)
> 
Tested on AN7581 and AN7583.

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Tested-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

