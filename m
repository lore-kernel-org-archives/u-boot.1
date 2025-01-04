Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03020E77197
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 23:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B700800B3;
	Sun,  5 Jan 2025 00:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kRXnHpN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6842803DC; Sun,  5 Jan 2025 00:48:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B436D800B2
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 00:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2771C40FA6
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 23:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736034486;
 bh=RwCcxqBACEFKPk5Aqw+DaEPFfwxqwjU7nsWADAU/jnY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=kRXnHpN9/32cPq5VsWfBAbbzBtDIImaEXzKQma+fRSGarxWtmlc84KBIJbxe/K6Q8
 O7/ooPf0VkgaKNrz55tzrLyTlT5DSi/2unvR68+qN+r5Uo2BdyEyw2KBIgMe0HSETj
 tAgVNL3j+gvhqXrFKknVFwwc1pKvof+5BDGq7EVdxCmPP7IVIfKYkXuTUE0CWI5NZ1
 xYmu9kPnlqOohKBa2eIEKRXlTXDkj3qksptxdYz4Y7epuok5d91Q2Z3VPpmlB3Ziqd
 opUwBkbG4xvhbah1zibNDXsBVySwIvCgW6mDfkJKh9Ah/33DZvDJVcTPxYV5l1ftva
 b+4SdpWDfEAZg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38a2140a400so8191976f8f.0
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 15:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736034484; x=1736639284;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RwCcxqBACEFKPk5Aqw+DaEPFfwxqwjU7nsWADAU/jnY=;
 b=gazpI68nHk9MlbotObFH+jdGtEh6O5xo6+xWT5bIVYbievFv0Li0q6iznfWJ6vou7M
 I7au6Ync4RGM8ySK4IxiZdbQij9yZrv+8wqNADtrXZ/F5y4aWmIX2O2e2prkyd3MLgDp
 CSlG+Lme24e0BGk9SwWr+HMW8bU4bdAleY/15rNxUs0EgZJB3D9ttJoJ3Zd6ViSozg7b
 n0wJ60YDxe+kojFxtgzGmGnrk9mhj9p2bu+VhrvwrTkAj5Lf4IADvYqXd+fZdfXiDS5g
 MrB3SRilgdjP92NE+xBqVAkSvsGk9NFF4QKR/X5/pyxw3B6ZBQ1mPPeOtpRcq2vyOAMM
 PBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyTaJL2THJDl4G96gpmReHKWqVrL3/Xez4tUh8/vAlCk3+5E3hPFTvd0VEyMM7R0pOYcgWvc8=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ6NPvr1gzXYP2ubAF6qdYyq/MLsd+P2s8ydrQxHwyyYNWvnTm
 LtNuzDE3Ui9zRlyfmY7AcazJKbxc/zWqd7vDCLuhPpOg2MXq1lboh95vNLwfuq846mA92T4191c
 DP2JRp00fXg8KJ2/Ahw/hk2d1e//KMDnLN2r/MUzz7wzfvVsYssaSdDou9wECc3IDYNE=
X-Gm-Gg: ASbGncsRmMiiGeOban34ff4VdYdac64Ix1mreU/rmm08dfey/V2KFigl9oT+0xrViQI
 zkQWKmzPv1mmmUPh9epakQowEuBaBgIjjqhto0+BbarCMwIEIjEIoaIOEmEdMMfgIyyl9lUvFH/
 8Vz/k9nwZ9vROhFNEcxueRkZwnsYYuU6iTxIwFDXZYgO11NPqdsVShefW5q8C1pJPvdaqUW7huE
 MPXIsfJ6Ti/ssj3UwUJX8cts6boc/VYJO/REEPi4igSXwrcgsCYlK3X3j1p26M2h4advU8wDRGk
 e2fDxIX9+/QoE8vCIoYfp7rwnqvVWCYmBmR70zXueMe37hL42v8FXA==
X-Received: by 2002:a05:600c:1e15:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-4368be58507mr295564885e9.21.1736034484137; 
 Sat, 04 Jan 2025 15:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgJJTjSWdxv3Jt4Dm+Ey8NLj52Z2Vy8gyG82lypyYbFLjLYyMGFJl9nTZ7PuVt+fMXOB3RfQ==
X-Received: by 2002:a05:600c:1e15:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-4368be58507mr295564765e9.21.1736034483497; 
 Sat, 04 Jan 2025 15:48:03 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474c2sm43654326f8f.55.2025.01.04.15.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 15:48:01 -0800 (PST)
Message-ID: <6cee26d5-dfa2-48b5-a338-97df8770b33b@canonical.com>
Date: Sun, 5 Jan 2025 00:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 "cdhmanning@gmail.com" <cdhmanning@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
 <20250104012443.GW3476@bill-the-cat>
 <CAFLszThsXV_mxaOftCM4K9=t1ziEenFG3NkA_h4wrt2jpLqH+g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszThsXV_mxaOftCM4K9=t1ziEenFG3NkA_h4wrt2jpLqH+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/4/25 20:31, Simon Glass wrote:
> +cdhmanning@gmail.com
> 
> On Sat, 4 Jan 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Sat, Jan 04, 2025 at 01:34:02AM +0100, Heinrich Schuchardt wrote:
>>
>>> Upstream development stopped 2012.
> 
> I believe upstream is at [1] and I still see pull requests, perhaps
> just in maintenance mode.
> 
>>> Linux eliminated YAFFS2 in 2010.
> 
> Do you have a link for the commit, or why that was? I have probably forgotten.


8b1bb90701f9 ("defconfig reduction") eliminated the last reference to 
CONFIG_YAFFS_YAFFS2 on 2010-08-14.

I could not find when 'config YAFFS_YAFFS2' existed in Kconfig but it 
was eliminated before this patch. Maybe it always lived out of tree.

Best regards

Heinrich

> 
>>>
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>
>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>
> 
> I don't have any objection to this. I think most boards have migrated
> to MMC and UFS by now. There is at least one board in the tree
> (gurnard) which could have YAFFS2 enabled, but doesn't.
 > > Regards,
> Simon
> 
> [1] https://github.com/Aleph-One-Ltd/yaffs2

