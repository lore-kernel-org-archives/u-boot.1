Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 15:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A914888253;
	Fri, 17 May 2024 17:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tiqvgaN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827C188263; Fri, 17 May 2024 17:51:36 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A2087ED3
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 17:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B157C400F6
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 15:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715961093;
 bh=pI6TMwC82RQUezDZ67xFWmqn1v49m9Ynh6CEUdS5Cf4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tiqvgaN9gyQ3x/kl1tRC0160PrVuDhQt0jluplyChfLnX443qdY0FtRbHhDmnfykl
 ak9rx24yYMHBPUq9xPcRGbFqVCcAuVZ87B56LJMVS6QHiQQQXW0D03ntH6+onNEVAR
 p8+BB2JWkb0jzeQf5NUQOA4Fio+pII1EEsZCFZD6PI+pz2zrCUDizBdBVW9enFg4NK
 0QvFU6KMMRqwxpz7vTM7a5hf6s62P+Oy0iGVFSVk3WtKhmAoB3t40Clcfco8s4OcKZ
 APpc05uEeTFxEYYPdAPjY2zAZQMUYjB9BA7qQ6nRC5nQz34BxUHPohmsFB9zEtlOUn
 I95dMRSbZSPQg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34da03e19beso5839701f8f.1
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 08:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715961093; x=1716565893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pI6TMwC82RQUezDZ67xFWmqn1v49m9Ynh6CEUdS5Cf4=;
 b=o8mFw60LkOMc548eoTpVEAXJow+rt8SPpoH5mn6rsLn6PytMGRkSdDQZYkKoiFis7x
 b+wakTbwNCVYtqIHjKPEh+Y/1IwCZcX6Vyq1q8ixhg07tLQuLDEop0qVgGS+irKfBbU8
 wrx774Yyo59c8Puouy9zrrxjLIZXzYtEV66D9ljjUvgqhq2atU0YC7SWSy+bVTU3rA6f
 bX0oOCWUaSIArgysfpe7FOhpn6c5o83L/AyVv6aVx2CQWnCquPjXIVhPGGpUwSY3r60w
 0fmr2yJ5RAW4xu/TISBmF9zpA0kn59sn8AyM3wk1pn52MS73O7UAy/fQakq8UQxfGjXx
 sIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEEBBzJrzA158kPfB7iqcqLuGt2ImXQdRr2lVgyfrIV2qzLfLKWc1cjmfrXIB+luI/3h+ET7pI01t03DpthMm/OI6C8A==
X-Gm-Message-State: AOJu0YwHwT5DEyNjILFNgU6LyoNvnpm5LVvkleeksmsnQs9f1SJb5lD7
 Wxuk/WlEX0zWKgDfaMBjOTBjvQJmaCwBprnBHke2MidFgwZve3/FEvh/v5PwOcdMy+uyzV6+AuZ
 1eW5dkq34KQ4h3E1OKaNTarPefdSt26kaDWAObiMc5FS6J6ifhb5vbCs2w57k6vW1rlM=
X-Received: by 2002:a05:600c:1c88:b0:41b:855b:5d26 with SMTP id
 5b1f17b1804b1-41fea927e30mr162894385e9.2.1715961092879; 
 Fri, 17 May 2024 08:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFefxWDC8rV2TvPoQ2X6XaLqO96s7p25HKsql8E4H8jQEcStPOX5hH/A+q4YxzXdWi4lOXZlg==
X-Received: by 2002:a05:600c:1c88:b0:41b:855b:5d26 with SMTP id
 5b1f17b1804b1-41fea927e30mr162894195e9.2.1715961092530; 
 Fri, 17 May 2024 08:51:32 -0700 (PDT)
Received: from [172.33.107.111] (18.pool62-36-37.static.orange.es.
 [62.36.37.18]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41facbd295fsm330389535e9.36.2024.05.17.08.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 08:51:31 -0700 (PDT)
Message-ID: <f055664e-5d3b-45eb-b6e9-d0321058e76c@canonical.com>
Date: Fri, 17 May 2024 17:51:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Makefile: add build-sandbox*/ to mrproper target
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M . Busch-George" <leon@georgemail.eu>, u-boot@lists.denx.de
References: <20240517151534.65242-1-heinrich.schuchardt@canonical.com>
 <20240517151855.GK2568172@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240517151855.GK2568172@bill-the-cat>
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

On 5/17/24 17:18, Tom Rini wrote:
> On Fri, May 17, 2024 at 05:15:34PM +0200, Heinrich Schuchardt wrote:
> 
>> make mrproper should remove all build artefacts.
>>
>> Running make tests without deleting build-sandbox led to an error
>>
>>      *** No rule to make target '../include/common.h',
>>      needed by 'include/config/auto.conf'.
>>
>> on my machine.
>>
>> Let's add the build-sandbox*/ directories to the mrproper target.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I don't believe it's the right place to remove build directories. This
> is also incomplete as it wouldn't clean up other platforms that can be
> built, and of course it cannot handle out of tree build directories. All
> build directories regardless of where they are need to be removed as
> that particular change breaks re-using build directories before/after
> it.
> 

My expectation is that after 'make mrproper; git clean -df' I have no 
build artifacts left over.

In .gitignore I find '/build*'. This results in 'git clean -df' not 
removing the the build directories either.

Tom, what is your suggestion?

Best regards

Heinrich
