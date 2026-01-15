Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45DD4662B
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 21:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E0880325;
	Thu, 15 Jan 2026 22:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CRsGeZXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B1983015; Thu, 15 Jan 2026 22:50:03 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 754DC80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 22:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso9518715e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768513800; x=1769118600; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PWh7tqbT25x3UNe4daBZvkn80Qdta+gi9Pm91AKjIZw=;
 b=CRsGeZXhZsnsn82p9l7G4RNLEUep7+X72pvzoaZmeTkDY3X0Eh2W6d9gv6o/cLftmd
 m7T7BSRNPMAaQVbFqK+ByNcbtWjdau2su5mz7SGvTzDEm65tWHNoN2ORifW0jq5YSSko
 XXMjoxx0Dd9ig4r/ccCxSAr3Sy3StACaDDYTFtWMYWLCCmVNx8AVdc0qExKmaWLN1Op4
 eHDJtfosb75h4/iOASN9G8wTGViXHydUde0rTfI9MQBerrbTCbLkH2XoHbc1TfNMek1T
 o4NWlJtwWACkZgSn3v/j+IT+fs+r1kOUY8tDxej8F/IozUanaTvISZhJSSndUSItBM9w
 hT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768513800; x=1769118600;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWh7tqbT25x3UNe4daBZvkn80Qdta+gi9Pm91AKjIZw=;
 b=Z+HrA322d+ua2bmV8XMG0sFQ70AcWMw6fyBwwPFA3JWrAA0u+mke+hq3mCxf3b2av6
 nl7tPgklRb+P/J0T0X/38ljT/El0e7T2sem8mpyv79sDHt5vMSbisDyAVfut9QEE8BzJ
 qxGznyJH+87u7J5JK0opPEbz1a9jAzvMv3pV7evy3KvEghjRhxYK4Aea1WBq9CknK5sF
 4lJ7sRyOoo/gQ1GkDny36lXOf5yvOw3ONO3iAL25WKQ9Nqhj8+CuLQxUGWCWxtIqRKmp
 0rvRB6wwfoS6hl8JrAuMvYSk3ubMljWNW2BmzREtsYdtxOj4k59Co4j1JPb/POPSI87G
 gXhg==
X-Gm-Message-State: AOJu0Yw8A4OYdkIjTF9S+1/torBu6sN33qjAm9OyWj52xpwBJqeZeC1G
 PG9eWOTwXOs3S7KNn3iKmP80myVlSGSKHkrUl/9Stexi3jZqagkTWbS77kCRTeps
X-Gm-Gg: AY/fxX7+qtGvDppHsSIhH+Hd5FVoIqXDZ6wY+aZOBV0/E0ch7uQvYc7PawmFDALZag7
 W7FJmQdthqyi9SdvA5a9pJPhYz6FNfMPDCXne9kOFUQQlDMeUKUfNtA52gr5DWvhHFGBML19jJP
 7OfksFZUW1aIV6MKmufTs28I0Se9vwIEW+RDLfjgrFxsut50HqHvqg6ammOhQOkNe62s5xMFpw0
 v4KS89BNkoJYBA1dhHC1m3uOsxpM2F28g8BoTzyCmOff6IfpiUaD8WbbaTO2glSFWLir0j7OIEd
 vjUG4sQiCic9ObEBibOJgkd164tvPJzpR6B89ImFWHnWzolMHXAGgzibRqwQuqs0Pylc/ACohd8
 /wBfZhtHw6qNhoNZSSMmITtdSzSsxst0Q/SX+c5A5IyW0dhX5fM+nYP5eCyNOxK7o1xdbYIHMJ4
 FeWYs8ug4Of3uvLd3vCiyfVDCpFQ2DLvxZ0thv7mXoBgkqWxoSzmJbKSa/Hgx17+e5DEo=
X-Received: by 2002:a05:600c:8a1:b0:47e:d9e8:2f3a with SMTP id
 5b1f17b1804b1-47f4289abc2mr31682555e9.2.1768513800374; 
 Thu, 15 Jan 2026 13:50:00 -0800 (PST)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194?
 ([2001:861:3385:e20:6384:4cf:52c5:3194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cefdsm1300156f8f.24.2026.01.15.13.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 13:49:59 -0800 (PST)
Message-ID: <8e6e5524-5839-4c44-8df2-f035f50e1384@gmail.com>
Date: Thu, 15 Jan 2026 22:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: simple_panel: add support for
 "rocktech,rk043fn48h" display
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini
 <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>
References: <20251207-simple_panel-v1-1-8688d221aacd@gmail.com>
Content-Language: en-US, fr
In-Reply-To: <20251207-simple_panel-v1-1-8688d221aacd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Jan 2026 22:58:53 +0100
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



Le 07/12/2025 à 21:09, Raphael Gallais-Pou a écrit :
> Add the compatible "rocktech,rk043fn48h" for simple-panel driver.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
> This patch has been tested on stm32mp135f-dk board.
> ---
>   drivers/video/simple_panel.c | 2 ++
>   1 file changed, 2 insertions(+)

Hi,

Gentle ping on this patch.

Thanks
Raphaël
> Best regards,

