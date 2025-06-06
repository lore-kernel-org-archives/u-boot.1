Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC197C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 10:50:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03EED81FEE;
	Fri,  6 Jun 2025 12:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S6YY55Ot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFF682977; Fri,  6 Jun 2025 12:50:04 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0CC81F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 12:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442f4a3a4d6so11343145e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749207000; x=1749811800; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oEcpeNgV0KNuAcACVLBZU+URhNncHip8VZ8ec5sxrs8=;
 b=S6YY55OtdoCXPiUO2+PfWVI85pONsrbksrwpF+tdXCgUxtxl6jQ9Qd3pKNj2Wvn63k
 UmCf0HlNxAkPMGLG3Nd4D9z2nPRNWNw/MPIGQw+iQ2Fmwh/R8tHKBxUpx1LQA20Zhx/H
 0XX/3CHYtjVe5AMBj2ufVl8YfbxzxwD92Ss2Ed91BZI/CvbEx6x8TcmBeKrAVe7mLv5z
 B5nXX3ZZvOP60mkDAS61Vj583YTeOPoQiMGRdvYvjGWp8C8hTzU2iY5pJeEdvTVkLC6O
 Q+Fq9m9lqmDonz2u+Zp8M2oxUKnhls2EM2dDECw96bfe32BaAPa3PYzh5t68PUHJoLTh
 AsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749207000; x=1749811800;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oEcpeNgV0KNuAcACVLBZU+URhNncHip8VZ8ec5sxrs8=;
 b=hC/jPHnYLyZh9ne0J/Jq7V/IIFU6f6vL9MULmwi0kj06FoL5nnzAv26QBL9p35biAI
 QnhBxEe4rA/3ep6oYOzGpuka3Jw+lZzX1ljdGdTARVnAXfoW7jVUpP8rejXwUsYcyBD4
 e04U14OoFg4Mzsimee0dP4Gnz+IW68Qxy43ik06AXgtwyEYtBBL+ssvl+OYsQYtGC3w6
 y9kHvBd0cTVULKkJc9DzZqX5Tw/1pYw6dWFyuOC6Hc8o+i+ALAjzYMYMwAuiE8J5wrrL
 5G84CCzmtUmMH7KmW3c5HpDdWBAv9mCRGThMQkXIRCU/F4FWl1udov9Mr3Z1WNG4DnR5
 u9sg==
X-Gm-Message-State: AOJu0YzRj4yW+MfxgbfD3IpTIbT6Xzf6qp2iwPo2tnrwS8+xpHydY6EW
 qd4mdtaWRHuRyv5e9YNcuGJs2cdtQdzO/TtekWzUQHzbR1unk2Yyv2iY32BJXn1rFQG+Msbpi5N
 zmGyIuKU=
X-Gm-Gg: ASbGncuWVgn5AbcpKomyse30HV41bLPKZF1J3v5SbuiE3I2wMHiPho5mM8Dy1a1AFIv
 azhp+V2fyNp7gQYfG4VlPn+odcsPnL+Qp8MwFUmSmCQF56syNHHpv7FtMON4x76ejyUlNn4YCVN
 WHlmdUiFG4kGyKIOrJoGB3M2Qn6h7ObJpDLJEUpvKU+xFcwK7tA/MhuGllD9AojwiseahP4IaZB
 eq3gjGbZdPcyArCAOFghJtcVIAAIktlN56zn5jeVyGkVSSw3nHgiC7Ym08V29QWibrnprw6ow8z
 RacGwqcnUFUQ9r+5+d534JbdtN2vEtbFxL37Ez/ty+DJiCSksTGrqXOo3gP371lMOOEqxd6IEAo
 GoV+jJnnW4M2F4LHUz/nDOoaAID0DM1Q=
X-Google-Smtp-Source: AGHT+IH8r3ayLLEBVUGAaAQPxxgMp+ukuzkBnuhrfM3oCQ6gOBQjWbq+CPEW/78u7o7Cln8RnDe9xQ==
X-Received: by 2002:a05:600c:4e4f:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4520159c111mr30731395e9.14.1749207000325; 
 Fri, 06 Jun 2025 03:50:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:c625:7937:4718:437f?
 ([2a0a:ef40:ee3:2301:c625:7937:4718:437f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4521375a392sm19526435e9.36.2025.06.06.03.49.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 03:49:59 -0700 (PDT)
Message-ID: <10d4a4b3-2737-4908-92ef-af8c1dc09305@linaro.org>
Date: Fri, 6 Jun 2025 11:49:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
To: u-boot@lists.denx.de
References: <20250605074610.1424953-1-mwalle@kernel.org>
 <a2f93b49-aea5-4bc2-881a-11d3d85e4dc3@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <a2f93b49-aea5-4bc2-881a-11d3d85e4dc3@cherry.de>
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

On 06/06/2025 10:45, Quentin Schulz wrote:
> Hi Michael,
> 
> On 6/5/25 9:46 AM, Michael Walle wrote:
>> According to the help text, you can set negative offsets to indicated
> 
> s/indicated/indicate/
> 
>> that the offset is relative to the end of the parition. But kconfig
> 
> s/parition/partition/
> 
>> doesn't let you specify negative hex values. I think this fell through
>> the cracks when converting the symbol from a '#define' to a kconfig
>> option.
>>
> 
> Maybe a Fixes: tag would be nice there, but since we don't have stable 
> releases like the kernel, not sure it matters much :)

Please always include a Fixes tag when appropriate.

Thank you,
Andrew

>> Introduce a new boolean kconfig option to switch on the "relative to the
>> end" behavior.
>>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> Not sure about the ramifications, but the change looks reasonable to me, 
> so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Maybe we should have some test for that to make sure it works as 
> expected and keeps working as expected?
> 
> Thanks!
> Quentin

