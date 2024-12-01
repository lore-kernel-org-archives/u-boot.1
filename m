Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D792DD49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8AB88E35;
	Sun,  1 Dec 2024 16:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733066452;
	bh=WZUFNTZdnJh+Rmcp2Op+QvOB4tbxnsMxJBZxh57ocQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pFe9MzUiwr4V/m4YVoYU0kuXc1yxA4271tC+vqeco9gRKAfSfpY14jMe9C7z3V6WE
	 QSUoOcwWYYvGfd43QW/WBYn86IgLqC7BXRqV5yAnm/6E9I/CMbVcYQAF1IEdqdyQIw
	 UtBHc5oUNn9kV0KWIelVKpje2kTmJjKYyDAPTStyUqwfg9nicLS6chfIbppxbFoi0w
	 swMQgO+p56BWWItl98fHnAgjNX778rgJj5fudAA8Y99u5ajKdN0UVM5G7ON2rMsusm
	 4hW7Pdr4BOFfx2IJIxP/Gt7Z6ea7l6BTlemKsfhmG/i0gqaDhjbXNKzdxMaH082+My
	 rRiFdd2XOXyng==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7158188D4F;
 Sun,  1 Dec 2024 16:20:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733066451;
 bh=WZUFNTZdnJh+Rmcp2Op+QvOB4tbxnsMxJBZxh57ocQQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Cz/KdDe2yQoVFv7o+KaNcXVCbXOtzUEFlRv4jXNJ1Zzznohgqxfl6vCSIO/g2fWO5
 LxayTmbjfIE0ewKToliHK+VQf8qvDvYzfWkXJfPRkINjp835V9BDtdqWYwVN9vB9HQ
 EIs/CTpXNlqKn2llBA9J2h6locZAYfOUDGd822kNkfsIb/YUTsCD6CqT4iy8uCMzWH
 rCdkb+YUau76gqJhiy2w1Q/THgrno//kGnmkDWCKqgOgpWbia5SJfJNUr8Lkbz6Bke
 6JHNidp5bL4J7XzbBq/OBgGgJWlulP8Cpaf+N50VKHd1DP7OSkSpvq0dNdVVaLxjC/
 4/go+2RsCkrPA==
Message-ID: <65cef924-a16a-4af1-819c-a15410d92f4c@denx.de>
Date: Sun, 1 Dec 2024 16:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] Revert "power: regulator: Trigger probe of regulators
 which are always-on or boot-on"
To: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-3-sjg@chromium.org>
 <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAPVz0n0RGrgUSrNzyT16FKMBcqYs00qb+3jEHsq4tiYyWGR-Nw@mail.gmail.com>
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

On 12/1/24 4:05 PM, Svyatoslav Ryhel wrote:

[...]

>> @@ -288,7 +289,8 @@ static int dm_test_power_regulator_autoset(struct unit_test_state *uts)
>>           * Expected output state: uV=1200000; uA=200000; output enabled
>>           */
>>          platname = regulator_names[BUCK1][PLATNAME];
>> -       ut_asserteq(-EALREADY, regulator_autoset_by_name(platname, &dev_autoset));
>> +       ut_asserteq(-EALREADY,
>> +                   regulator_autoset_by_name(platname, &dev_autoset));
>>
>>          /* Check, that the returned device is proper */
>>          ut_assertok(regulator_get_by_platname(platname, &dev));
>> --
>> 2.43.0
>>
> 
> It seems that I have found a fix for this issue. Simon, please test
> this commit https://gitlab.com/clamor-s/u-boot/-/commit/6149722aa48f84d9ea037ae990141a231106244e

So this regulator problem was a tegra platform specific issue after all.

Nice find, thanks !
