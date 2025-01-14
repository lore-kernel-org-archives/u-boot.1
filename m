Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA46E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2267280657;
	Tue, 14 Jan 2025 15:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="byiOHla4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA452806B7; Tue, 14 Jan 2025 15:21:15 +0100 (CET)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976428060C
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x541.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so2042783a12.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1736864473; x=1737469273;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ejB4vaf4B3rl69g3eSeBd8w4slnBUTqFeSkbW0JSY8g=;
 b=byiOHla4aIJI7kla8QwQzuNaq8+Xf2nFQEVDJUav0TZh9OCmULzDcMB21r8YmwJSGX
 ni1NvyYZu/W7H5jUdu+H25Qz0cRC88L3sBkFm1LHCSOPN9l+Hp01BcDNleX8dmwAzlvl
 x/+SADu5MIYcx892SXeQn5zoAiUEiybK47+e3JBGp9aR+GhZScIgNul8Zgt+T1NbZiTN
 Dcbc6lK5Cqq/czMnix299Z9l0xtiH8iFWsj8UUT9hDZrplRhoPKOv1LIwAJPgT9cUY1D
 2bo7PRk2P9SM+k1nqLtrs1N0laX1LBqr+Zmz+6AcTBrUcybmRbyy5V7hgW7DxMwk6AKb
 XiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736864473; x=1737469273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ejB4vaf4B3rl69g3eSeBd8w4slnBUTqFeSkbW0JSY8g=;
 b=aAry0C9IfI5owsUbDRZqZEvlbzKdT41JkRG3nPTelekX9hRg54ScdxFlnSgrc1PJ+o
 vwKJDFLYb5OSS/3GUsKx/d6Zxn8RyXKOqjvpCexvhFg5cMHVy9qAprtHebCtaPH6cgp1
 Sz5LyLK8qHRbNdFNbBhTJwZKOYlOvzOegR8z8/eG4eaC/qqYC1dcEyhznUXSLG5w9/M0
 pX3h/M/iavxCuGh8brIja/U9GUh+fwb1u/1JdAd13ipl8wRWqCtuYuewCTeN81xpafum
 DswUVtkEDW9WlSnV6mGzXPqBY6CUbQ5n5XG3F/BFceHTl+sXAwno5UjE9WH6NXv4Akl9
 pSLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDD1rLZAkmyLLDS8JojqxuG8GffHeqD0ap+izAbWdKGQcNzMGqPHU1+mxJ1waIQLSGDf6vYhM=@lists.denx.de
X-Gm-Message-State: AOJu0YzzSkFsqvHiECCdHDJyTFLYs9xcOL4JvvdK+kJzQ7b9eZwMeNJp
 m0T1EME7T7p/df1noeRSoAxbDLde6U3LLjujz0JZQqBuR327Dhs/3eZJM9S7mQ==
X-Gm-Gg: ASbGncszF4CcX1s+XXFEzZuW6msChY7xHzGcMxH4Ov2drVDsSbdeEMxAl08rE1W7AGY
 wemufl5oH1C52UfNUGTgwXWm2vA9DtwuRauYYtxoTvD0C8F/rrR84RV54/VoyH9e9RuF5qKfSoy
 aLmvIm6ked6v3qNJvugdF2tP8mF9Zg1dwLqBUpCIL+FLOxQtqOtSBBX7l5YQbN++rapL906VlqM
 xWCstuxXZD3Nq4khIDEalBqJREF42aV3BRWUmMs/UCrqY7P2WPAZYuQq9t9FKg6xeoEBLGN
X-Google-Smtp-Source: AGHT+IETLseXiresibPmHXNHdKiQVy7ee+W6Sbv6EyP0PHpAwHmU9HGcBmOugbFJ0il9h7tKSh9jaw==
X-Received: by 2002:a17:907:c1c:b0:aab:882e:921e with SMTP id
 a640c23a62f3a-ab2c3c63988mr2015367666b.2.1736864472284; 
 Tue, 14 Jan 2025 06:21:12 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905cd8asm634597766b.7.2025.01.14.06.21.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:21:11 -0800 (PST)
Message-ID: <31e9cdb8-72a1-401d-bd7b-6be8ef403507@monstr.eu>
Date: Tue, 14 Jan 2025 15:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN / RFC] Regular community calls?
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250113183409.GY3476@bill-the-cat>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250113183409.GY3476@bill-the-cat>
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

Hi

On 1/13/25 19:34, Tom Rini wrote:
> Hey all,
> 
> It's been suggested again a few times recently that we should try and
> have some sort of regular open call / video chat as that might help
> clear up some issues. To that end, I'd like to propose we have the first
> one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> after the v2025.04-rc1 release, and I'll include a link in the release
> email. If this works out well, we can make it a regular thing for the
> day after a release and also try rotating the time, or having a second
> meeting much later in my day that's at a better time for other parts of
> the world.

+1
TBH would be the best to send meeting invitation to have a record in a calendar.

Cheers,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

