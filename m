Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB83CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76F480FA1;
	Tue, 19 Aug 2025 11:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GMrZK10n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DF7D81FEE; Tue, 19 Aug 2025 11:36:43 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5575802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 11:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 34DF83F5B7
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755596200;
 bh=mOpmqb17b2K/9PCDGTx5F2OKTvZpxaldfkhlrQGnVd4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GMrZK10npdH2ifLTr7A0PQ7vTQiVfABnaCTZhxS0v5PIEa/GiKV3fqrgUvYWerZ2i
 aCCDTiAC0KlScAVxW6AHucUJ7bZQOBdlb7OPAgcdxlH5aiKh+okEGJcHYHhoM1b3h+
 dfb/6pomaHlSX29cmyC3KdlX3HxuqDp2VWdjlWp20o3hgfaVXwKhC1lMOfupIiuVoE
 SEpFuvl0i9iE4Sm0dEjvbdwCfIiPufXHo2UL/vwm+EJkYZeHTvL1Qt7bNOIvaqyoP6
 Slp+K3gnAmpqNW2XOaeOjdOsEpQBQ+kwEPmCj+WeKk1ddDwWSTzqhC1jGpI72UpjNN
 DtI4IgG48WPBw==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b9e4146aa2so2920248f8f.2
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 02:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755596200; x=1756201000;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOpmqb17b2K/9PCDGTx5F2OKTvZpxaldfkhlrQGnVd4=;
 b=B1bnqa9f4yCUKtz5UcdQtxphmTJibW4u2qFEaz5w/XF7/Xc3K2ebWBsAoD2701rVUV
 Y/jNIzZXRg+8SKhWmZxwifPA7oLAzwne50MIIC8/EXceLdk0T8Vz+DaDaeuqI7jykJxJ
 1VACgTc0YZ++iQwS5yHPnkarrXdZD08xfyAp22DaWO7pvtHKqKv7xxbj4UbsNlP8GWVJ
 Z0kjL8m0g1KVwSCM+HXax2ChwWFW2aUZLl71N3rdPWqpnIOibrjUNQ7Ip9AJ0gqmNgMZ
 37iSOLpiBWDyGjxeZx0f6z9T6Ch4SA5mbPVH0gV8u9M49VJSG3h4+2wIb7uLZm8sE07b
 HMug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1eRfy9jV5Tak7av9qFaPlyzGNU5+Z+BX46408gI+0wAlIhSGnIxh/7Z+Q4woeXAo4ahU3YM=@lists.denx.de
X-Gm-Message-State: AOJu0YwQDOs+ZfMdNBQ3l7aZlS157zF1hMOh+ve6CtuSo9MLM2ELISaS
 G7Ab9EJeFtZkuvgVAzgowKM2mukiRS3cVG4Gzk45kxs7mIvPlKlkzssXvDcKez0zl8mqnPOT0D5
 JfVuA0KujPXzXvWyFBl5tfYqNodvRhYimmxfvj6m8X/uZ46vGWx85deukQutMWKdZBg/wutU=
X-Gm-Gg: ASbGncu/YjZgx6vbke+ZvzE+BdAcwp+el+d8LZgnb2lyBTi6VTqTq3qXDVCFbaM4P2P
 eljMnxoc3IBEyL6FHQV7q9bYB5uOMJGtQbPDJEsNtD6ejtMzamk9USj1UE4DDrO/QwelUp2Q/nr
 k2paxRahMx+8w1OuGamz0OJTiLsPbNePknru0mRbLoG2dtwqvqsrXZ2WES5uaQawfiJDABKaJxN
 2YhEUsHDQkxs4/B2B9F34Ak+afi2mR6IsFq3PAsrfSUE3Ky1jEjrCS8fxEm28PEkmjftptOl5s7
 BvNh245/mOejJYfLdVyq93uuP8iQwNvG2ZNsaP+43JniVmjf1CF+WHHOJ/JCocEaPtLTeAC72g9
 SzQxvHDJ2Oqs8Txe/7O68e1OgwDmk+rE3Chor2Q==
X-Received: by 2002:a5d:5f52:0:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3c0ea5ba120mr1685956f8f.11.1755596199723; 
 Tue, 19 Aug 2025 02:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXgE9H7rSetFt/fcW8XNUHnORTaJB21bcGRcB77DKtXv73MYQCPk+283RB8l5rY4CUp8wZRg==
X-Received: by 2002:a5d:5f52:0:b0:3b8:eb9f:a756 with SMTP id
 ffacd0b85a97d-3c0ea5ba120mr1685929f8f.11.1755596199238; 
 Tue, 19 Aug 2025 02:36:39 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077789d12sm2938504f8f.54.2025.08.19.02.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 02:36:38 -0700 (PDT)
Message-ID: <ed11d0a5-69ac-4c96-80b0-60825b24af16@canonical.com>
Date: Tue, 19 Aug 2025 11:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: Fix swtiching typo
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Janne Grunau
 <j@jannau.net>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20250818064715.20359-1-heinrich.schuchardt@canonical.com>
 <102d53b5-be1f-474d-a0a0-ccb585dfb50d@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <102d53b5-be1f-474d-a0a0-ccb585dfb50d@cherry.de>
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

On 19.08.25 11:28, Quentin Schulz wrote:
> Hi Heinrich,
> 
> On 8/18/25 8:47 AM, Heinrich Schuchardt wrote:
>> From: Simon Glass <sjg@chromium.org>
>>
>> This should say 'switching', so fix it.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
> Need your SoB too, I believe, c.f. https://docs.kernel.org/process/ 
> submitting-patches.html#developer-s-certificate-of-origin-1-1 and 
> https://docs.kernel.org/process/submitting-patches.html#when-to-use- 
> acked-by-cc-and-co-developed-by
> 
> """
> The sign-off is a simple line at the end of the explanation for the 
> patch, which certifies that you wrote it or otherwise have the right to 
> pass it on as an open-source patch.
> """
> 
> """
> Notably, the last Signed-off-by: must always be that of the developer 
> submitting the patch.
> """
> 
> With that change:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

