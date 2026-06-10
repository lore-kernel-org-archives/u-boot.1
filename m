Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF39CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D51D848BA;
	Wed, 10 Jun 2026 14:53:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="j8OPl2Rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 309B584704; Wed, 10 Jun 2026 12:13:38 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DB8807C4
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 12:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45ef29c5561so3549271f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1781086415; x=1781691215; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=dcWjtxo5bDhG2TljwaFyVdApVokBkCsXnKN4aGFMNAI=;
 b=j8OPl2RbyDtFitmyapC+JqBawPEt91fNib/9h5smdIEfUYmuoh0LW+a99CYX78WSMC
 IuKNyDepuGSrcwXFRn61mL3BBFmLFEzOf3MINShgaTlRN/pmV++oir1pXSF8oaEtMma+
 YmubXz9PcAHNpEJqTS8QtEUhxcWXldkhuZVAT8C6mRXnb13f/uAgboe7+/zZNzhh5WVd
 6ScNivs9rqcysdkuWP0rEuYWXTrKanbrq4p7J9MQNBN7/QDRXxWEf1Z27bk84BiCKjwK
 y4CsENKnW/ovC0ZMO3vNN+cywvOd3h/Y2uJmgAwvIBuFWMeRlNy3VuGWoJ8f1pMz2LOk
 X5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086415; x=1781691215;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcWjtxo5bDhG2TljwaFyVdApVokBkCsXnKN4aGFMNAI=;
 b=Asncin1fFLLDyRhUuCsn5y4qEll35Nt4Xebe1d+Gh4xku3RzfjI4WPDD2ZRAHkKHmS
 KyX3HQ37TEvrIufCJGrIvHJGNe3wdULUt2LCFk4EbmmBtX9FW7jCUBg8p0bqd3chFjGF
 A7O9NJIFBx0nDBNJ89ggGIUNICNR944xCQhPzyc+pLRKBQ6EH3To1jFR6iFbOjL3/kAi
 26DD7Vj8an7bKLsOHizLoZfnl10RJ0SmiP64nqC5cXfHTvvZQK7EHtJZIXeApTpocFvh
 sdil3hqZ9GlshRoH60pIgMIbvwjuV2nH/yD9rk+rPjg2IEsqmMeLDjOcDQWBB1RGtXTY
 p1Mw==
X-Gm-Message-State: AOJu0YxVXTAOw+xlH2Vtf5O1/9QkiSu48+0AxlRJeirnOq+bIU053P3K
 Q0NraEc4zvcIbq33HQL4XJ6ZooyVKNAIjhaTJEbep2DcEn7v3XWVdMcLeNZ/BVkTcuc=
X-Gm-Gg: Acq92OHO4u7upXxfCJMDuedEvKDbN7iQuOpLfWgGG7ciwyCfrDJcjUOLcI88DEuAGy+
 4u7CTUSdiOWzkEixD1Sv0AB2nWgDpviUwC0iMFtn+2BXbaJtpuDNhoNipVBsQ5Y7YeAwiCa7Fi3
 mGu69nTyRwJHcaXviQzT4lDcaKk7kasmg9aL1H9Zsrzhtz4qMQ+Az/LXl5RPQnVphSroIB3nU9O
 fI2PLb5Q7NHeRtr3smqV2OI/7rigAhw+Fg5q0G6076EG11/ZsUhQyKRLfnU6B6EryuY5ocYqMU2
 LxQuIQnMkcBR5FCSWvpRBbyAoOMtAmhHfm/cIDJIsAadOmIXylty/nBwKL+/h0Mg8ZYcMhrEnCC
 pBBRq97mjA76IzAcsM4rx3AsClzskdEB91fPKBuBZMG59xSJdlz4CrXHnJDero+qnm5AjFGP4lQ
 Rk8r/QOsWrblOuF4gY4H8ntOm/u9n3hwD4Eg27Cdw3SzyDi1W+ST+iNvyjaQhioOIMOsRma990a
 YiV+ku8LWdc8+Y=
X-Received: by 2002:a5d:6889:0:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-4603063423fmr27627969f8f.35.1781086415454; 
 Wed, 10 Jun 2026 03:13:35 -0700 (PDT)
Received: from ?IPV6:2a04:9546:1c18:5b01:e4e2:7f5d:bdb1:1ff2?
 ([2a04:9546:1c18:5b01:e4e2:7f5d:bdb1:1ff2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm75500155f8f.6.2026.06.10.03.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 03:13:35 -0700 (PDT)
Message-ID: <952ea111-e406-44ac-81ad-1293ee102a06@sigma-star.at>
Date: Wed, 10 Jun 2026 12:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] boot/fit: fix CVE-2021-27138 while keeping '@'
 node names
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 upstream+uboot@sigma-star.at, Arie Haenel <arie.haenel@intel.com>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
 <322a63c7-0b63-4762-8968-f9112dd6863b@sigma-star.at>
 <20260608142056.GJ382693@bill-the-cat>
Content-Language: en-US
From: Lorenz Kofler <lorenz@sigma-star.at>
Autocrypt: addr=lorenz@sigma-star.at; keydata=
 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
 RN2HqQUYnIgKMEqcnsan22HO9tKGdaxTYmKdGQ==
In-Reply-To: <20260608142056.GJ382693@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 10 Jun 2026 14:53:33 +0200
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

On 6/8/26 4:20 PM, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 11:10:22AM +0200, Lorenz Kofler wrote:
>> Hello!
>>
>> Gentle ping :) Any feedback on this patch?
>>
>> On 6/2/26 9:43 AM, Lorenz Kofler wrote:
>>> CVE-2021-27138 was fixed by rejecting any FIT node whose name contains '@'.
>>> That stops libfdt's unit-address matching from resolving a reference such
>>> as "kernel" to a node named "kernel@1".
>>>
>>> Rejecting '@' outright, however, is a regression. We have a customer with
>>> signed FIT images deployed in the field that use '@' in node names, and
>>> with signature verification enabled those images are now rejected and fail
>>> to boot.
>>>
>>> Such names are admittedly not ideal. The devicetree specification only
>>> allows a unit address when the node has a matching 'reg' property, and
>>> newer dtc versions warn about violations. New FIT images should therefore
>>> avoid such names, but existing deployed images still need to keep working.
>>>
>>> This series fixes CVE-2021-27138 without that regression. The root cause is
>>> not the '@' character itself, but accepting a non-exact node-name match
>>> when resolving a FIT reference. Patch 1 hardens the lookups so the
>>> requested name and the resolved node name must match exactly: an inserted
>>> "kernel@1" can no longer stand in for the "kernel" node. Patches 2 and 3
>>> then drop the now-redundant blanket '@' rejection.
>>>
>>> Review is welcome, especially on whether I missed any place that looks up a
>>> FIT node by name.
> 
> I think it's good to have made this public, for anyone else that's in a
> similar situation, but that the migration path for deployed systems here
> should include a step migration away from deprecated images. We're a bit
> more than 5 years past the original fix and so while I would have been
> open to this change in 2021, or maybe even early 2022, it's just too
> late at this point.
> 

Ah yes, that makes sense.

Thanks!
Lorenz

-- 
sigma star gmbh | Eduard-Bodem-Gasse 6, 6020 Innsbruck, Austria
UID/VAT Nr: ATU 66964118 | FN: 374287y

