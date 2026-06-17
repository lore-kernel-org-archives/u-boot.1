Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32008CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 15:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29A8846B0;
	Wed, 17 Jun 2026 17:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sodF3nkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33041848D7; Wed, 17 Jun 2026 17:03:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B888460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 17:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so46837335e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708635; x=1782313435; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjGqL0sjB4X+d9pzYVWF9nit1wn82hcM1SI1Db9VURM=;
 b=sodF3nkOC4WBg54l4TTa5c3VNrlbblA+nWzlYRggTyy2IBOd3zZYuJciNqmRVGXDjP
 7Tm7ZWG9mO1o6PNf3a0RCor4KMrQmKFwO5LAvwpYVtB11i52evpKlaMgPU1nZl2BHsJx
 xImUGhRKlPX/NfwhuBHgcFDiXDHa0OsKsatP1vNnkhsJe3rpaWqPhWo00KIr5TW/x+7T
 Id6g+MoDvEahJ4mq2++1fgHBTBDOTSMgSevkzE9hu/6V0MKLZLQqtfWTSqZHeB2xcGcM
 s4oukCAC+yCYOn4NWyG+cYdUrhri30hVo6moKyqOmnQ9AAHhEWHCI4wF2nsTed7oBMtn
 H2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708635; x=1782313435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjGqL0sjB4X+d9pzYVWF9nit1wn82hcM1SI1Db9VURM=;
 b=bWGLK3IJGsR9q44OcF2rn0rz+Bo2kMqQaVxqGih2B2GNg2va/J47WqKELyMV5z2r9K
 HbF2LA7eqzLmdsvLBJppPQwrJBzugI0MnRuNUE4xVLdH3scHsqIgc3p6kE6CGSlHMG2q
 Hs75SjQMvSmCylgaprVOyO2lZYjfqisVqFAgDs6Q9Qq9V1g2LZX5axcS8gOSVzsM+x7H
 kNFgPV68zv5w+ePmLPfTalw3sidgQ7qv5hy8Pe5GW+2UDFywec9O/F4Z865xnVA41kAr
 HYGD1bYV5B+jeidq5D5xCHuTSWKaQL6VBLaZLR7NOxsgWAVdIjSauzmlfRmwux6wOzXn
 bPyA==
X-Gm-Message-State: AOJu0YzBS4ipB6GpMBYuj8UaeWG3nXG8LPmoZaWCX1AgExggtwqiH2uZ
 za0+PTuJS+18ZGR+KiGN3wDHylAw4hs7/w06C+AYAvrNXLFnw9GRRMPI0c0GjIhPA7OVpOAX9/n
 VLaDSvQU=
X-Gm-Gg: Acq92OFLxVU0DqAhPqByfCXRMw6+0CrZHvzWT8oNcMyWnBf9+0wShQW9Q36MaYhH2I2
 Ze7uPrf25Fgka18LxZoNRP3OB6U+f8e+uZqPq+qV3NigTw6eE20mvhpnhnI6ZS17WQaI5JCtq7F
 9/+OGxUve7edEpPgXrjT1l58ca+jkm2QKMvfbo1NyYC1yLR5SAjQ0fB8QYYiodyIxHBn5guuFSR
 ZwA1A3/sfjvSbZnzWmwhpRkVEO+RGhFasmHqs7M23Xx87ncq0rJ5ElF8SlM3brPUaYXb5OyHNp1
 lnF/ExVjxN1eUYLfRZn4gj4oXhIOUmv45MjFEmWEN53Z2hivOWl52SE/3U+Y98E2ixOHfPNnYvy
 /iPhzYVbex1+9WDvtB2f9n56mZeeGbSM+G0C7DyDIv8q+pfh3HDe+Twgu8He44MmivPi1nRoVW4
 qx5SQgLMe4BEAX6LIv8Voc5cvg1w5j9KRGHOIvZDbGelLHID5h5zh92y2a+yucAL8=
X-Received: by 2002:a05:600c:e547:20b0:492:1eed:3e67 with SMTP id
 5b1f17b1804b1-492333d6cadmr54227665e9.26.1781708634429; 
 Wed, 17 Jun 2026 08:03:54 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cf5d9sm47968645f8f.32.2026.06.17.08.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 08:03:53 -0700 (PDT)
Message-ID: <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
Date: Wed, 17 Jun 2026 17:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
 <20260616143649.GH382693@bill-the-cat>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260616143649.GH382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Tom,

On 16/06/2026 16:36, Tom Rini wrote:
> On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:
> 
>> Their email is no longer valid and bounces, ensure we don't include it
>> in get_maintainer.pl output.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>  .get_maintainer.ignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
>> index 899a1469b2ae..5b7d84646f62 100644
>> --- a/.get_maintainer.ignore
>> +++ b/.get_maintainer.ignore
>> @@ -1 +1,2 @@
>>  "Pali Rohár" <pali@kernel.org>
>> +Tingting Meng <tingting.meng@altera.com>
> 
> The .get_maintainer.ignore file is a heavy-handed measure for things
> more serious than just bouncing email. It looks like Tingting Meng just
> comes up via git history and so will roll out of emails in a few months
> now, so I don't want to go this path.

Ok, that makes sense. I have found bouncing emails and excessively long
CC lists to be a bit of a recurring email when using b4 prep
--auto-to-cc, do you have any ideas on how we can improve this?

Maybe we could tighten the timeline and/or contribution weight a bit?

Kind regards,

> 

-- 
// Casey (she/her)

