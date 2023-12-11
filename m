Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8B4C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDDF8778F;
	Mon, 11 Dec 2023 18:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KsyvBEPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA4587796; Mon, 11 Dec 2023 18:55:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBAE8776E
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B78D3F1EE
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702317313;
 bh=FOOt30GuuGvb0qCVawHyYJUUnLjn/MqPjV2mcbFQBF8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KsyvBEPQGlRb2EFsVjCCn6UTCu+cFKVAZGL1hXu4ceO8Ls653LFDWS2X9q6BjOtbK
 lItcBfhRwsDlRVaZRtZpDVGvkyRi/n4ntlCYeC2wBrP1bvVM54XBsxzZlWwkSj3M0J
 f1dJCW2rqNwUeoILCUsQPXOvFiaPB2Eg6mFvMRdcfueopkOv1/HXEQJEe1yd+++Gft
 NP3mOm1KLGjhIJ3vg9FAbFohYFSgmk4HlGeH+dxCuIIVFYNyjF/moR7tnlVGcqRKOp
 040wul+unaMFSk6j2BHrYGQ8lEZ+qBbrLb+rk3phTxd7/15bMB1wiRhRmICR43K1HI
 c0zWkjlPqUFVw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c25973861so32157625e9.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317312; x=1702922112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOOt30GuuGvb0qCVawHyYJUUnLjn/MqPjV2mcbFQBF8=;
 b=sAaI+KZ5X8uZinoeeyujm+C7MXOS05lC/OlGfiuEopUjhlh/KWU8tUERnBx9Rpw2BT
 Yh43gsDq7+oZDKNNUADT3tLKOjfQmlO2r2TEjoVVnk1f/sjvYiPCzO1TjehjOtHu+38a
 nJoA3gDu7H4DkQOao3DvwgV289h73q4/UDXDcyfGHe24B5SgTbMu28k8DjEKL27VLWXA
 8bTP2aNDMwYYkYLkuTLW5ydshdTbSxYTyNGJC4O+sH32sK8VkyybPwEG7dkwyWSdm1kx
 Yt692DHB23UkI04kO1R/sBQgjYaodSxaUHqxHfCNImQw6Nhq6sXQBaOnQfhL4Zc/KXCx
 BjiQ==
X-Gm-Message-State: AOJu0Yw3pAv1yntOLrzfGjGGuy5jk/vZcUL/JpIuIdDhoxNwJKAHruNr
 Pz/WBijR02APbDVEH9zw6w5olTxvsYo4YExHiHuL5Dz0wNsxwqtQ5+6QNGPFBIMEWgZrMx7QpBb
 ZKjqScbZpmFQW4urUegsxFcvbNXOkbOo=
X-Received: by 2002:a05:600c:512a:b0:40c:37f7:c2da with SMTP id
 o42-20020a05600c512a00b0040c37f7c2damr2393847wms.16.1702317312188; 
 Mon, 11 Dec 2023 09:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3UcXzUZyLJ4j0WyAt9MQP4UBkUrSlMGE/b7Dtxszq09TjBdQQKNl19PomSZsXEWoV4zI2IQ==
X-Received: by 2002:a05:600c:512a:b0:40c:37f7:c2da with SMTP id
 o42-20020a05600c512a00b0040c37f7c2damr2393840wms.16.1702317311857; 
 Mon, 11 Dec 2023 09:55:11 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c1d0f00b003feae747ff2sm16071240wms.35.2023.12.11.09.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:55:11 -0800 (PST)
Message-ID: <b56a73e7-ff4c-4d0d-b334-17af022d911e@canonical.com>
Date: Mon, 11 Dec 2023 18:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: vboot: Using variable 'old_dtb' before
 assignment
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de
References: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
 <20231209185411.8212-3-heinrich.schuchardt@canonical.com>
 <CAPnjgZ1ycQgEvd5jEDyEW77fgJMu9x4c3+_Ep5+oShz3SRZQVw@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAPnjgZ1ycQgEvd5jEDyEW77fgJMu9x4c3+_Ep5+oShz3SRZQVw@mail.gmail.com>
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

On 11.12.23 18:52, Simon Glass wrote:
> On Sat, 9 Dec 2023 at 11:54, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> old_dtb can only be assumed initialized in the finally block
>> if it is assigned a value before the try statement.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   test/py/tests/test_vboot.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> I suggest mentioning the motivation for the patch in your commit
> message. E.g. does it cause a pylint failure?

You only get a pylint error with current pylint, not with the one used 
by our CI.

Best regards

Heinrich
