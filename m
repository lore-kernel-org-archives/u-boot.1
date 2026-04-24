Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107BEFF8864
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A409784370;
	Sat, 25 Apr 2026 18:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="T1a6bv4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA338435B; Sat, 25 Apr 2026 18:24:21 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44B98435C
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7F763F9D2
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 13:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1777037265;
 bh=X75GWNFrCF30tyG8vzupIW8MR6pWVMCHtgY2uoR85TA=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=T1a6bv4/TYxuMKdCBMmXYDnq4qfMJJETwx0pj6ewuojQzcToFnoiM1n16sri9mzoA
 ro2IATemtgvojWSYiat+3wHpuXIggW/FsNYRJdj8qqUOc7ipIMT9GkLjCIcTwR36WR
 vofSts58d8x7LSwsvbPoxIOV+2MFCYjgzigxgV/VqameeZT39GS4gtxSOCAMEU76J8
 Ybo+U7q96491aZRmc4cNTbDwuIic/16g5c78Ri4AZOUk8rieCrNJYLg8LAL3ErzSJG
 Dp5lf3VCZLYjDeYPbtXjWwCTbw7c1G4ZMbB5y0AQ5RtwPJNDxtIo6ZlXVQNzbm0/Pv
 w/ZdGZU2j+G3cEuB83dTZZjRfY7LDDWsFtaFmWake2g32kHRLitmACl2ouPT2UR97Y
 Asrt6Wha2s1RXur7REovlclw2+rIBI13nNQLM7M/Zw3v4fA5yLY0BYiESoPBAhI4Ei
 1xFiQkZQZ12s2K3JT5gChsgQiG6EgSeV9xGno1fxsdaWrPTwvqVB6Y3W3Bl2DRfWFq
 7lMfc8DMhL/E/UQXgXosrl/I7W/P1DiSFyuswbsx1zN7k9+wuSikqrauNdE3ggbFae
 dBJrkEtaocGDE5rj50ckfpwnSO9DDeZKdflGq2J6+48O6GvD3nqvI2uwByEJdQ8Fqr
 AfgxfSJ4muBVn0iGo6njdfH8=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c0fcc6deso48376275e9.2
 for <u-boot@lists.denx.de>; Fri, 24 Apr 2026 06:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777037265; x=1777642065;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X75GWNFrCF30tyG8vzupIW8MR6pWVMCHtgY2uoR85TA=;
 b=DMhaxuA6x+fLCrhsy0fMPIOSAHCLg605CCu7M47Cmr8OUtNBqRN926ERudoum0kdBE
 KjMCzDDf23hpP7nmiBi4JzMMml/9kd8zSeyMhiW9v4dCZYOtd8Rqv+6FTSBvn8iv94j4
 EGJ3VXcxcjR9wLYqENwfSJrcxXHKB19TufjD6VKcudrSqC8FwKUbb6Zh4+YGIUouRXel
 i7+OSABSNXs8eJQPfaGy/XE9a+HJMfUbP5HIyD1BC7EVlTujTohsnoeeBZRMxAKxOroo
 RrzVstBanNgfsjMnWoOIGq7QuoU/ASgH4D/rjM754dpvUqZeumEmZ/bObHr0IvMWWUdk
 oriw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86ypNQFpqzDmUuitXKqdEMLQxU0I1JR1aGiOesrAIvYIcHxbXymPZXWlyWdFboxMEZqWErkzg=@lists.denx.de
X-Gm-Message-State: AOJu0YypXzyTYRQegKbQoWOaIBKRynYsv3THV/gaGtaw/tEJYrXMMMLp
 U82s79nDrhcF7S+2TjTXuRUz9GjlnKt0by+nGNHsalCdo7vAEcfz9rT/IRK5raec6Qwi4z1GYXR
 CxrEGQWPpAj0VpBNHqOj8QGEeUi3sNq6CYR32vJJeReNz31Lx3VwQA6s0cYowbXS3oXWxTa0=
X-Gm-Gg: AeBDieuDRKovBqw52z+IewLUz6rIwUtZFYCZvLBClmljy9dj7cpVnSlxYTbh6N3lKMx
 NSW9MLUAmoqAhU0mVLjdUofjeF8cZxEgEQJ/Esd610ReloRc+KsHDudM18Sn4NxTYL7FVDsCd4y
 9IfLwrBDAxvIU4v51eQKsLLxuy9CMKI4uD+NnI31rMBPfZtd5d6fkTduL18iOj5wSZd47o+ztmI
 SYTP3VwYU5nN0i9yFN6ViEE4FUdsBy8ekWO/BwDiESvOAZlPlLJ6eM717COxKrU9AnoDYNCzzaG
 Zg8viqoqT5MJHx7tAGqFBW2e/gphHuyugZmOnnvnAkuApZVO97f9kczl5dw3eSGpmkhhsgtoDPJ
 mV6F4FdA9jtC5zzsjQdKZYYdYJ9z20ze9eZNg5u1VoM+4Q305y+C98IuLxUwjcy1XDrDQe8xuhj
 SbmCjiOF1shvWkZm0bonJtu/r1F8hCxYvEjKCu25O3aL6by7+FuuOgs3S5DDa6GJrq3rY=
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr358247295e9.24.1777037265360; 
 Fri, 24 Apr 2026 06:27:45 -0700 (PDT)
X-Received: by 2002:a05:600c:c085:b0:488:c530:48a0 with SMTP id
 5b1f17b1804b1-488fb784843mr358246915e9.24.1777037264916; 
 Fri, 24 Apr 2026 06:27:44 -0700 (PDT)
Received: from [192.168.103.133]
 (ip-176-199-115-125.um44.pools.vodafone-ip.de. [176.199.115.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm1011242365e9.3.2026.04.24.06.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:27:44 -0700 (PDT)
Message-ID: <69f9cedb-dad1-4cba-83c0-77b3e8458b1b@canonical.com>
Date: Fri, 24 Apr 2026 15:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: .clang-format description
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia
 <floss@jetm.me>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
References: <20260424130510.275226-1-heinrich.schuchardt@canonical.com>
 <0b958275-d387-4cb8-ad68-55f3e2d0ac82@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <0b958275-d387-4cb8-ad68-55f3e2d0ac82@cherry.de>
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

On 4/24/26 15:10, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 4/24/26 3:05 PM, Heinrich Schuchardt wrote:
>> We cannot use .clang-format without modification. For instance U-Boot
>> has some for each macros that Linux does not have.
>>
> 
> Uh?
> 
> sha256sum ../u-boot/.clang-format <(git show v6.16:.clang-format)
> a7a2d4f21d9ff4696498077b71b5589a44b95697eb80c013a94768d05f7d8b54 ../u- 
> boot/.clang-format
> a7a2d4f21d9ff4696498077b71b5589a44b95697eb80c013a94768d05f7d8b54 /proc/ 
> self/fd/11
> 
> Cheers,
> Quentin

Try to format anything with one of these macros:

+  # U-Boot specific
+  - 'alist_for_each'
+  - 'alist_for_each_filter'
+  - 'for_each_bl_params_node'
+  - 'ofnode_for_each_prop'
+  - 'ofnode_for_each_subnode'
+  - 'ofnode_for_each_compatible_node'
+  - 'dev_for_each_subnode'
+  - 'dev_for_each_property'
+  - 'fdt_for_each_node_by_compatible'
+  - 'for_each_console_dev'
+  - 'mtd_for_each_device'
+  - 'for_each_tpm_device'

I have created a separate patch for .clang-format but unfortunately our 
list server is down.

Best regards

Heinrich
