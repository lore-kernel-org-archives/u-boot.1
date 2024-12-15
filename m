Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690BDE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 02:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA3538006E;
	Sun, 15 Dec 2024 03:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KeMEH3Nn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2023E80086; Sun, 15 Dec 2024 03:55:42 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD3AD8006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 03:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3ADDB3F1BD
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1734231339;
 bh=mrhNJfI3OoxFTNSaBLG9DKX75DqG++kLUpPHwWmDPMw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=KeMEH3Nnj+AhK8bUJOCQHpQMVXwFLKKpUuwIfFp6l8yB8xA3TAs81XlNFL63tGqSZ
 Lzwm6cS3UNeW8EA8rTockjkOcmShgg/5LdmFl+R0qMQp9CsKrYTS9YtYajyYQD6AUr
 R3f9e2RfZZid/1wYwVzg00BBzo237+39WgQNIJ9XqT888a+6qx6tK0c40nctaRkpmI
 nLEnYmcHyymfDd3VDcugijjyfTsBL2eynzj93Knr4ABbrTZ0GYVL21akd6pDPXWw05
 0HgXNG8jhk62XBdEHDMRDnfwmqUbhNXpffmh1zpBFI2DpVkVRmb3z3C7uM337InvsU
 GVjgHu5rmutFw==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e9c698e7so1509639f8f.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 18:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734231339; x=1734836139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrhNJfI3OoxFTNSaBLG9DKX75DqG++kLUpPHwWmDPMw=;
 b=W+igYa/jZCoYRbQK+ZOsjtw1z92iaJhDFNpX0wxXjben3dlIUIIbJ1OuAfCFmqEIbP
 Q431giQmVHxSrT7+4+yVJN9dCweo+dPtb2J/Uo1HefP4nyATo0Vthd03kq5T+7imEQBf
 J+LxhYr9Xh77UB3PUw+eQk+AX++ZylUJfK66qH9/vqxKhs0nhLt6CYdtPs88+14sa0NI
 xAglzu87yZ9R41fHeGgcm2wiHwpjO3PnsbcMksBlZrd/qGwGm3wpiSUbXXq2av5Y+rDk
 vSwIhr0wPycLNTxRvVVITdMvg77UTEBMl5X+ax63fD8K9nMNrTqPetHgFKCoxmYbiLJo
 JiRg==
X-Gm-Message-State: AOJu0Yw3CqTNCi8NhF3VhWQig1h6diss9ov2d646A1xqeMy825Hn7TPn
 kOrBSPpDtdEO+9RmXf4JdN1htv1bQYBk0NZYf2KBLCJ7k9w0ORSv1NghUj1uyzLekzhdsrI1wfK
 JK+8Sfl0Nd448lBaDSnSSzqSMUryYOkhpnIrFvGuXUzq/1MdDYXBYBBSJ+JAG1g8wxVIiOLd5AO
 8=
X-Gm-Gg: ASbGncubdHBJFE6O4H2olI513J0imwPIE54duJ125oovBiHRI7jSCGl34DRgARIGiM1
 hDLRMbSW9KaeXcJL8GWdbwno4jbzs88hj/FhfbJgZoJalGj2v3aPtSY+0xUcOopu4aZGphPzY/y
 E9KID3XNRLQHaZhIhQnX3mI1326E1l+D3nfceyrCzLss4T8orhhYqn4ocaNmbyb0q5bW/rq4zNy
 ZQBRk5aVDSiS9HyeTyLxZOCiJU9rbKb0dVTo1AJjO8yz48ZZngaOFRARFlJ2a8L1+1d9i6Gc3rf
 YHz8Lu+s6nk9Uxl+wBK4LOyDDTnZgbwr2s1Qaduk647AmzJYQ8uewg==
X-Received: by 2002:a05:6000:1f83:b0:385:f07a:f4cb with SMTP id
 ffacd0b85a97d-388c3651990mr5224256f8f.8.1734231338750; 
 Sat, 14 Dec 2024 18:55:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqmLKkrg0OA06Em0wzAu91DccRLT5H6GOUt1O26/2wgJ93lXIrksXaYwqQXpbdxe3i1ZM5Jg==
X-Received: by 2002:a05:6000:1f83:b0:385:f07a:f4cb with SMTP id
 ffacd0b85a97d-388c3651990mr5224250f8f.8.1734231338378; 
 Sat, 14 Dec 2024 18:55:38 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016427sm4034921f8f.30.2024.12.14.18.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 18:55:37 -0800 (PST)
Message-ID: <2ebed5a8-002c-4792-a474-7cf31b6c0bad@canonical.com>
Date: Sun, 15 Dec 2024 03:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scripts/spelling.txt: add GPL-2.0+
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241215023732.68902-1-heinrich.schuchardt@canonical.com>
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

On 12/15/24 03:37, Heinrich Schuchardt wrote:
> The correct SPDX identifier for the 'GNU General Public License v2.0 or
> later' is GPL-2.0-or-later.
> 
> Checkpatch.pl uses the misspelled words from spelling.txt both as keys of a
> hash and as part of a regular expression. For usage in the regular
> expression special characters like the plus sign need to be escaped.
> 
> Heinrich Schuchardt (2):
>    scripts/checkpatch.pl: allow special characters in spelling.txt
>    scripts/spelling.txt: add GPL-2.0+
> 
>   scripts/checkpatch.pl | 2 +-
>   scripts/spelling.txt  | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

I sent similar patches send to the Linux kernel list:

https://lore.kernel.org/lkml/20241215025104.70096-1-heinrich.schuchardt@canonical.com/T/#t

Best regards

Heinrich
