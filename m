Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF40D66BB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 04:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BDE83C54;
	Thu, 18 Dec 2025 05:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S1xZE1Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B03583C61; Thu, 18 Dec 2025 05:49:40 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0776D83C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:49:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-889d80de181so202556d6.0
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 20:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766033377; x=1766638177; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=acMbEmXvDqs22MigcMQ5elitKumHeIBtNr2NDdNaWKs=;
 b=S1xZE1XcODnlS/rkZ9GNJ9cO/GUbcKWFgJFhi1HXuw7YTBeeIKoQ5ULFpmubnYQTHU
 YNwnzncWnBSLnXJ9ilfQcwYdIy7TkeCCC5h5iJtgol7edhe8rS4cFDNzRTKwoH9t6mkc
 0qt+eVx/zG1Pm5J/r9F7snmUS+dMJMb49Yer8Vc1dScGjLmlMzHopvp22c/mxjwmqAbG
 Rr+IiRtB+BYYotNtEstVfChKkIG9uOYbXyTWcIe/96Ig5sON7NxJoWF53y+5TsZuHE2R
 mENqZTgGSsWe80c9tDq1hPapdHpA7Yn/YhJndGYyF3BrQpMIGzQgGBn3VD+4Z26nf64q
 J1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766033377; x=1766638177;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=acMbEmXvDqs22MigcMQ5elitKumHeIBtNr2NDdNaWKs=;
 b=m0eq9JsERJQi4LC7jl4hFnsBf1jaah1YX5VBoJBYIKfTyf5jVIZizLR4Hri7Ct2U+Q
 l4WsGMFf583TZ3T5cQBxEAsnOWqPjVaQ6S8jzFmZIwwtDO2+e1tev/9I187+F59a5q3Z
 YTNWHfcJCfYooEdkV4B95fm2A2JJr84wnh+HIacycsJpC2FLJyLhFjmioFb/cftnZ4qs
 FswdMw+XkLdUdnuCZq44qH7aTNmU7QAYcjcYRX4dvH9NW+wbFguSGeiILOkuzMHgeZ0i
 R0VJHZH1FE3zOtyV8hNUP39ijwQx2W4juDyVtdQQ33buL4Q9Io0HDqmL9GtgJWdSHd90
 UJmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLrr6O2wfdsS7r2wiRK7lvc/8vcG627UYsttNiUmifl5Nj2/8dbJbIoxcRNtHIYmenuzvMjiI=@lists.denx.de
X-Gm-Message-State: AOJu0YzIpGL3tVj14pE5XPn+x116yncGj8pGXjtvRsQ4Mt5yOE9g5qkT
 BZdL+5T+AkhxeCeXf4/CueCnP7o5m/RmKv+vYjBd73ORKtf4HMnYUj+O
X-Gm-Gg: AY/fxX763SiQRcnoMIiif+o+oo9lfVZsgs82ezC5EWp4y0Kfz8iypE9qbPukcoWHpv4
 74gRYLbGpxhE99KZwWHsgc+kIU0Tb6ydMGa+Dzjri6eQ+n08S97rmrdkLauB8JA2TcD7YpgTHdf
 pR0jp22qO9imRwG9TwtJmunbtme2wcsjH80mRjzf8ovZmYujuSw25x8WS1uJdLvWRQjRMacm5B3
 /aNxzjPaaXO6UWOYx/L0m5HwLerSdLqSTAMhwik7xozySKY8UZPcse4L76zHAdS65uaEhJokDSW
 Ud+eg4yIaSucryK6H8XP965qKh1hbcQP5jQy6lo+Oq5vLX3+P0KdpsDJJwup2BtrsXj3SswdQ+h
 gZA/YiWguf7XK+hQSxChSPaueyiAR4cSDHRWsgrtYjajnDkV0qCyy8XgaMDfbTMnVjtIgYXRzh9
 gdgGDrcguwXg2YDOEofSYwsEqvo6o9BatOADDulKg8okPL3vX7x3cFg7gw5M8R68391w==
X-Google-Smtp-Source: AGHT+IFg1+TuURhAiA1du5P4W2opFREG9XWuljXsT8ZfvLJS1zqxOVQBGnSwpnhjJ91sCTpOwiv3fw==
X-Received: by 2002:a05:622a:341:b0:4ec:f9c2:c1ec with SMTP id
 d75a77b69052e-4f361152409mr9286821cf.9.1766033376804; 
 Wed, 17 Dec 2025 20:49:36 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f35fd60192sm8528971cf.19.2025.12.17.20.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 20:49:36 -0800 (PST)
Message-ID: <f44d25fc-2eb9-af08-7a28-737f1bf510ca@gmail.com>
Date: Wed, 17 Dec 2025 23:49:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mtd: nand: pxa3xx: Null de-references with dev_err()
Content-Language: en-US
To: Chris Packham <judge.packham@gmail.com>, u-boot <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <CAFOYHZBuWrLk4LfDa2dysvdHUMH7ziDicA9a+usPaYQnKc1O2A@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAFOYHZBuWrLk4LfDa2dysvdHUMH7ziDicA9a+usPaYQnKc1O2A@mail.gmail.com>
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

On 12/17/25 21:21, Chris Packham wrote:
> Hi All,
> 
> Sorry this isn't a patch but I've just stumbled across a problem and
> I'm not sure how to deal with it.
> 
> In commit 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx
> with a device") Sean updated some code to pass a valid device to
> dev_err(). Most of the places had a struct mtd_info * with an
> appropriate member. A few didn't and Sean used
> info->controller.active->mtd.dev instead but it looks like
> controller.active is only assigned via panic_nand_get_device() which
> I'm not sure is ever actually called in u-boot. Being that the
> offending calls are only in error cases I'm guessing no-one else has
> stumbled across them.
> 
> I'm a little unsure what to do here. Some of the uses of
> info->controller.active->mtd.dev are close enough to a struct mtd_info
> * that I can just pass that in. But others are buried deep and it
> would be quite invasive to add. I could add a dev member to struct
> pxa3xx_nand_info. Or just change the dev_err to pr_err instead.
> 
> Any preference?

I'd just add a dev member to nand_info.

--Sean
