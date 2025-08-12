Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E877C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 07:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DF10831E0;
	Tue, 12 Aug 2025 09:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lz1MUbxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9010831E1; Tue, 12 Aug 2025 09:49:46 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B481E8319C
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-615460d9897so5906637a12.0
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 00:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754984983; x=1755589783; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxzD5gFj8yoQpXv1rKfcV/gBNkXad4ViG2+1c3sEpjw=;
 b=lz1MUbxpLM3s920b4+fzlW436l59MhCORtwimsxIlMZZSLFdM7FtrwzU2+vBHMZeh1
 kQsAo8e9L73D5wkKSJ94vvAoCphof2RfbP+ww8ZZMv20hgingjSFA7f9bTHW15VTRhws
 LwSZkAjYO1mAmz1huppgq8jZL2Vj3OOsxLQ7aK3cVsuMEmpBXaJV+0MhDXsTnT9brg8N
 PyezG61mT54xgs16jMprkRUPWzO6bvt/2Yz9CcNIU7v3nTeMV9TItDQDjOtT0tSjlsww
 G57g6OOXxdHZ0oOf32nf6FvmIQViGxfPrUpF48u5nskpENW1q3LVYn9FkxKg8V/ydEs4
 /xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754984983; x=1755589783;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxzD5gFj8yoQpXv1rKfcV/gBNkXad4ViG2+1c3sEpjw=;
 b=WAefACFvXe44rhl5L28WmCwcMfeI/vvK5RqqbvKjJe3oQaZmqVOLtUwxvmoWdTfBFd
 wQiXUI1QJDvlabVVUasuRF8arrbIXOHhueFIbAemE2A2K85wORkz71Ku6IlN7yfXmSLL
 wNnOwyyNdZxEdtSVCIP746cUw3xC5o4OovQPjEO8xbSbhFR+KCMxIOgVI29QNco1BBQD
 S+dn5FtundpusTesmhzRqeXo2syWHC5dSqqH+Ykc37sbJp5pvX6VyDVOzwTUpTw2/oJR
 0VU8pbCMeCfQthTs9AcbAxvHMSyCZwSeTj68yRYBDltryIB4fidaUUVBQFDcGN+YxHi/
 4Cxg==
X-Gm-Message-State: AOJu0YyFqoZSBFD3sJuTPGVq6svyYSiLx6E2HVx+a0vTuRXQGVOPYmGn
 sYqN8gmZKnEUFI9GMHLOzF0ZSdZKdSUw9xafofoD9opy2l+He5OGryeuk47C++PDj/g=
X-Gm-Gg: ASbGnct5U7PPy/bClGB4Eu2kcn257dNWHHCXoyKAIpKofLWfXgaaAHi4Fs4avWmfOqP
 dP/wjJKvBH9hnW2otg4H2rjrGpq5A2YnGuYbaAnHtdvasHVNil+h8pdG19LgqFij2HboxZPvsV/
 tzqfo1g0FDWBjL4UmtHgh90QsRXOKnFHQ/eTck1cmuuYhJM9gQjULNghimNJVWZ/obQSG1xpRiW
 3DClb+dQOztExUDuyd91FhQho/DaAa67e7lP51p/WMvNgu8nx8iKTb+kZQiRR9Tq/IFT7++gfMU
 hYrOmhNnG5y/wSFYXB3Hn8v1BK0ZYWh0nzBSYc+gQCM9SXIGpnxyLlvJub8YIWWBjd40Ze60C8/
 QwsGTkDUybC2BMpjineSO5EQAHIPvx+2jiw==
X-Google-Smtp-Source: AGHT+IHjnXIKZv01arzb0pch7JbA8yGgxtInnfACEh3+3+qPJEXYQTqh+PVdYMWYlJ6ES9dC7RDS+w==
X-Received: by 2002:a05:6402:520b:b0:617:d013:74a with SMTP id
 4fb4d7f45d1cf-6184eb5266dmr1999739a12.4.1754984973611; 
 Tue, 12 Aug 2025 00:49:33 -0700 (PDT)
Received: from [10.100.0.2] ([194.15.111.159])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6177dc4b209sm12557214a12.28.2025.08.12.00.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 00:49:31 -0700 (PDT)
Message-ID: <5f3e997a-f070-417f-a09a-90e1bf7774cb@linaro.org>
Date: Tue, 12 Aug 2025 09:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] lwip: add Kconfig to decode and print ICMP
 unreachable messages
To: Peter Robinson <pbrobinson@gmail.com>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20250806085959.2130339-1-jerome.forissier@linaro.org>
 <CALeDE9NsfBRyfOdxr8S0iRSj5kdSwyKVr-pfroJCdjqT0hbmvA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CALeDE9NsfBRyfOdxr8S0iRSj5kdSwyKVr-pfroJCdjqT0hbmvA@mail.gmail.com>
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



On 8/11/25 17:56, Peter Robinson wrote:
> Hi Jerome,
> 
>> When using commands based on UDP such as tftp or sntp, if the server is
>> not reachable or the service is not started on the expected port then
>> the command ultimately times out. However it often happens that the server
>> or a router sends back an ICMP Destination Unreachable message. That can
>> help troubleshooting. Therefore, add support to the lwIP stack and to
> 
> Has the patch for adding support to the lwIP stack been sent upstream
> for review? Please reference the upstream patch for this.

Yes, see https://github.com/lwip-tcpip/lwip/pull/73. I will add a link to
the commit description.
 
> Also related, what is the status of other out of tree patches to upstream LWIP?

At the moment we have:

- 5634ecc88e9 ("net: lwip: tftp: bind to TFTP port only when in server mode")
Submitted upstream as https://savannah.nongnu.org/patch/?10480 and
https://github.com/lwip-tcpip/lwip/pull/61.
Status: MERGED (https://github.com/lwip-tcpip/lwip/commit/b1edb7780f5f)

- 27d7ccda94f ("net: lwip: tftp: add support of blksize option to client")
further modified by 10917df17f2 ("net: lwip: tftp: fix find_option()")
Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/62
Status: PENDING

- f69f7aef26f ("lwip: tls: enforce checking of server certificates based on
CA availability")
Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/63
Status: PENDING

- Part of 9349fc2e9c76 ("net, net-lwip: wget: suppress console output when
called by EFI")
Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/66
Status: PENDING

- Patch 1/2 in this series ("lwip: icmp: allow reporting ICMP detination
unreachable")
Submitted upstream as https://github.com/lwip-tcpip/lwip/pull/73
Status: PENDING

FYI we do track this information internally here at Linaro. I could as well
store it in a public location if it makes more sense.

Regards,
-- 
Jerome


> Peter
> 
>> U-Boot to handle those packets and print a diagnostic message on the
>> console.
>>
>>
>> Jerome Forissier (2):
>>   lwip: icmp: allow reporting ICMP detination unreachable
>>   net: lwip: add Kconfig option to show ICMP unreachable errors
>>
>>  lib/lwip/lwip/src/core/ipv4/icmp.c | 17 +++++++++----
>>  lib/lwip/u-boot/arch/cc.h          |  7 ++++++
>>  lib/lwip/u-boot/lwipopts.h         |  4 ++++
>>  net/lwip/Kconfig                   | 13 ++++++++++
>>  net/lwip/Makefile                  |  1 +
>>  net/lwip/icmp_unreach.c            | 38 ++++++++++++++++++++++++++++++
>>  6 files changed, 76 insertions(+), 4 deletions(-)
>>  create mode 100644 net/lwip/icmp_unreach.c
>>
>> --
>> 2.43.0
>>
>> base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
>> branch: lwip-icmp-unreach
