Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA9D43352
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD72389263;
	Thu,  7 Nov 2024 13:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QnmDOH34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D3989266; Thu,  7 Nov 2024 13:13:24 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B437889259
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso7013615e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 04:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730981601; x=1731586401; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GbWr6zE0nT4c+2fN3NurLz2S5lKZ7ymOZmi6eIBytJc=;
 b=QnmDOH34QwCyK8Wd/s94DnG0Tp6PkLr0SRFzjDC/cX8pk8Q3vdtJo5io0KeYaCbVw3
 0/VWa5Z3Bum0krKAKBxVwEdJvVdPB2rHCyiMa/VKcQl0uW89Epruju1BPgWFH9Thr10e
 NFbuSe4xPybKD0PTsLcmvRl09YBmbvALKlSPWSwyiRChgTzKZHcuAeX+3hvhIJrwntW5
 oMCdFxofNQdywdI6rjQARUK4q/TAy726oqGcH8oZC5KLZqksf4lIas7Al1G6lHTMdVWn
 /WccFXSmGEtFGnniSRyxGGBUkq3JA4ii54fS4YRJwACnk/hgtlXxnLfXukm1uVqOEwwH
 3irg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730981601; x=1731586401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GbWr6zE0nT4c+2fN3NurLz2S5lKZ7ymOZmi6eIBytJc=;
 b=CSNzmEdZyV5wtlOtKSwhBh1XQIP6NhUKHXn+pHTzvMz5N3kB7+k7qm4mc/GFguAb9F
 iwYtKGkqaXdoEah70+nrRK8ODpRvPkfiAy6XCVexSFXMf5Rnrv7MdlCHqe7rwkWE9G8g
 xzzRdV4MXwA9hhz1diwnGFx0Z389EHwi2TbIPFczYKKk5ycXNKEKv1XRQ+ukblDWYt3q
 OXEXfkdIcTEqssCJiFQMM49aYCO52e+AfmDUOZWwpOGg/6VEtT/xEbpWanot2p0S1Qai
 lvU5m4tQR51R5iYTnusk/k8ow5H76KPWRHRiBoTjn5FNDd6TkcnlMJHp2YUw5j3uFn96
 DKeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqSNoSwHx1zGUBmMTp/aFaAOp5tuTJZpkVjgst2yqlYHq7V7WgjsP7XtawSTrCNsoJ7PUb5tQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/FWPxHOVQ0OMEzVtKjdLvIoR+TDaO6Kp3Wyev0A9zri4JMYl8
 8pG5cc28c+M4wXS+WWM3gD5aO4Kv7o9c/T/4tXO+qrUgSCnWjonGBiwZlKUQ2js=
X-Google-Smtp-Source: AGHT+IEv4QslTXrROLWyyI0ltndt3qdufvN9BiRBHOEljmHr56FCWHzoKukxhe7uUDqEhH5pe25HFg==
X-Received: by 2002:a05:600c:4fcb:b0:425:7bbf:fd07 with SMTP id
 5b1f17b1804b1-4319ac6fb93mr392468655e9.5.1730981601178; 
 Thu, 07 Nov 2024 04:13:21 -0800 (PST)
Received: from [172.16.25.132] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053ff08sm22454955e9.10.2024.11.07.04.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 04:13:20 -0800 (PST)
Message-ID: <d99881f4-bc58-4328-9848-a308b0659b0b@linaro.org>
Date: Thu, 7 Nov 2024 12:13:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/21] Introduce the lwIP network stack
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
 <172910926540.24133.2953899765717446506.b4-ty@konsulko.com>
 <20241016203351.GH4959@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241016203351.GH4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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

Hi Tom,

On 10/16/24 21:33, Tom Rini wrote:
> On Wed, Oct 16, 2024 at 02:07:45PM -0600, Tom Rini wrote:
>> On Wed, 16 Oct 2024 11:56:22 +0200, Jerome Forissier wrote:
>>
>>> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
>>> library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
>>> stack [2] [3] as an alternative to the current implementation in net/,
>>> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
>>> reasons for doing so are:
>>> - Make the support of HTTPS in the wget command easier. Javier T. and
>>> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
>>> so. With that it becomes possible to fetch and launch a distro installer
>>> such as Debian etc. using a secure, authenticated connection directly
>>> from the U-Boot shell. Several use cases:
>>>   * Authentication: prevent MITM attack (third party replacing the
>>> binary with a different one)
>>>   * Confidentiality: prevent third parties from grabbing a copy of the
>>> image as it is being downloaded
>>>   * Allow connection to servers that do not support plain HTTP anymore
>>> (this is becoming more and more common on the Internet these days)
>>> - Possibly benefit from additional features implemented in lwIP
>>> - Less code to maintain in U-Boot
>>>
>>> [...]
>>
>> Applied to u-boot/master, thanks!
> 
> With that said, checkpatch.pl finds a number of style errors under the
> new U-Boot code, please address those shortly, thanks.

https://lists.denx.de/pipermail/u-boot/2024-November/570977.html

Thanks,
-- 
Jerome
