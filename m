Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D75AC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2FB806D8;
	Fri, 27 Jun 2025 20:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986FF81F66; Fri, 27 Jun 2025 17:24:01 +0200 (CEST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AAA880C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 17:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pom.pumba@gmail.com
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so17008215e9.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751037835; x=1751642635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ecy1lu4HubW4pztC4YMUcoXKTGqeXDuf1wJXlT0GEmc=;
 b=YC5/75hwNjIv0fckzf6tLhjUdlhVBUngYSSR1VjRMb+BFbwXCJE4kNeQiRlwdkn2PS
 x6v7/tBSMQMWu8cMzyVQdxuuiAlFryxnMrPUieuj4JX5U0M4Cik4Fqv7768lmJj53FMm
 hj2uQWEjKBUmYsk3h/6k3J60NH0R491qktcCZqBjTtxi/Vk0kwwauthhMA5oeesCLcLK
 nWiIaubyYNGSK7v9ReYpq8Cok2mkr1w/zBBgTMM/+aauO7kvqMele8Gg8rIjfoDxhxn+
 rYo7qg6e+UFEfkZeVJwanjJHlj87GyJjraEkbjrpE0a9osqwl6UoIHDAk6KJqAXGO8K6
 +m5w==
X-Gm-Message-State: AOJu0Yx3esXpEg+vM96dvvlppb3UIot4PnryeXVTOlhn+v46CW+gZADG
 3+uxa/6gdiPOcjQKfnChbez3UpgkDk/V7kOzejX1jKYVJJEFSnSzFJMPaUq9Ug==
X-Gm-Gg: ASbGncsfqRXAu9lFLC+YbFZllumdZdFjfXXMCd2V2iJ/iL543dZ4ax0RADXUfMYkZpD
 UvKZ8/8JM718uchUQ7cr4r5fgKTxc0n4jixj2i4bnzgh2u4778/gwIUR2HSB+wPUZLH7+FMYsuN
 0NbhckcfSNHuFj4Tf/8a9S73CcN6ivPwNqRobeANr8EmXwIeE5bIhoX0seWGeJLML1Dh33BiCVN
 P+P5ky4r9Bmwznm1wyI6u2BtElLwdloBVqIUtJZSsk/AD55wDy+wn3hxjF0MhJGicfxJXCRAcrd
 t/oKP2k+nEm36UzqSxzM5kwvd6L2lpCpRTSi/Vf0TzmUPunk3AxdIQBPRn0mS6+Ciu8s9ApXBPV
 plF9RDycc/qJFqQCQ7Y/YS73/siK73l9qI9oxau4o5oJQQLvSnsNV81HGuJ5s70jb8B0Q/oqhpy
 BpmFwIuLDrYklX9t4SHMsp
X-Google-Smtp-Source: AGHT+IE9LxzyY9S62E0G/Pp6aB3qJbJxHSeI8JRGDoji4mQTIiBG6pGHnTod8Tk3RuZ/S4PpIxJj3A==
X-Received: by 2002:a05:600c:3b07:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-4538ee6ebd6mr39691755e9.27.1751037835187; 
 Fri, 27 Jun 2025 08:23:55 -0700 (PDT)
Received: from ?IPV6:2003:e0:6f23:535a:5c41:d08c:1d27:c718?
 (p200300e06f23535a5c41d08c1d27c718.dip0.t-ipconnect.de.
 [2003:e0:6f23:535a:5c41:d08c:1d27:c718])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453888886ddsm40796235e9.0.2025.06.27.08.23.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 08:23:54 -0700 (PDT)
Message-ID: <e92a4e72-1f7f-4a38-80df-7df8447a7bef@dietpi.com>
Date: Fri, 27 Jun 2025 17:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <e76dbe98-2fa3-4d1b-a452-aa88a142c5cc@dietpi.com>
 <2beda42f-68c4-4fc3-8b84-ede6e452c4c7@cherry.de>
 <5aeeab0f-cbaa-4b25-9baf-37e2b0e5e9d1@dietpi.com>
 <7ab1deb6-5ab7-4544-805f-f2e1e139d045@cherry.de>
 <647c2f92-344f-4feb-8979-93b1d6574193@dietpi.com>
 <0c822158-11d7-4a1f-93f8-22043c807bd9@cherry.de>
 <3a38f9b3-e8a1-41dc-b770-0af80b8ebc09@dietpi.com>
 <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
Content-Language: en-GB, de-DE
From: MichaIng <micha@dietpi.com>
In-Reply-To: <ed094775-23e6-4fb1-9272-540256d46719@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Jun 2025 20:04:23 +0200
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

Hi Quentin,

many thanks for all your feedback and input.

 > If DM_SEQ_ALIAS is enabled, I believe so.
 > I would imagine people be surprised if the same device operates under 
two different MAC addresses depending on which SW is running at the 
moment (U-Boot or Linux for example).

So far I only found 
https://github.com/u-boot/u-boot/blob/master/boot/fdt_support.c#L645-L664, 
the fdt_fixup_ethernet() function, which, as far as I can see, is called 
after/with boot* commands. Ah, but if U-Boots device tree is used to 
boot, then of course it is applied there as well. What I meant is in 
bootloader stage before that, when it is about looping through boot 
media, and in case network boot options, searching for/executing 
boot.scr, in case U-Boot console.

In any case, I will wait for one more opinion/input about this, and are 
then happy to try implementing a more generic method: E.g. right into 
the above function, generating and directly applying MAC addresses to 
aliases which do not have a variable to apply from yet, based on an 
existing eth0?addr to start with.

Best regards,

Micha
