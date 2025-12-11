Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331E8D41C12
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 09:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 605B283655;
	Thu, 11 Dec 2025 10:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JOx3rXr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5009983B48; Thu, 11 Dec 2025 10:08:06 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C6E835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:08:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b79ea617f55so131660666b.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 01:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765444081; x=1766048881; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edLF0zlt55+PzqpSiUc8pc7utyIPQvA8VOTctE8uePc=;
 b=JOx3rXr0pXzvLtVfjZ0tOrjtSwV8bVKmZyB+jfh53/3yddKCj+Y/WaYbmoG3eBkmC/
 sPrDVYGLf9aj9EgXKAcfty/f13AnVL3dVXnHYWTVQTnJBUwPZLzn+M4jT0/qbYawhAMk
 eFiIGsLJdmtxpmZCMRuciJU/8kvyAS+9/+QXOSprfLaKVbRnTutMsQ9XB8O41B+a3SsL
 FpqHkZiL0P5+0ovqu/2rZST0ibsCnrXkMoRtgwKYDphGdOMMbCo/e/3yLNJeEelif4cP
 l+fYI7zM5Me+vFIhoBvVpwuKbMwBb+PGmk5N5P2QhmEFhxmxa2JdIIbMX3fvVozIYgkZ
 uKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765444081; x=1766048881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=edLF0zlt55+PzqpSiUc8pc7utyIPQvA8VOTctE8uePc=;
 b=hl+8r4fYW4ioA5kj2QiqFKg9hy1FJIUvRRIf8SLnejOSZhb9R0gpjiZso0XoLYEAQ4
 VgM6HaTwzPZUc368aNsyoQXn3vpo8I1EJ1AEK0b85WPbgkxw7zdEmWSE7pzX2aso8uWe
 wxP+x5KK3tpmnA6N93E078nGYGAQHJ62IFqrB7Jy7jW+ErxSZbYqlFVOAN4O3l7+5DSQ
 nLtW9pe45joKHnPgJYXwikkC1KF3A19PmxybadZlJHe7S2tgRsL+xtbbyc6tHn8LUc+2
 inVD0TUDEqdSW1Mdd+/3j8qh6/IJaaoJ1YHTouyaQzCGxz3ISpQ3iZr6lUYTTehd7i57
 tKEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnc/TSR53ndWxbZHiSUGPgcLe390X7spqyhbCqUB0+pgnon4iYiqhuY+brZiJe0yGGYSwKK/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YykQiIL8gz/PN+CvT1ZQenNJN7Eu8zasEBN0zPIxSikwuuAJXX7
 IYHhHLtRzJQ7QtSzmUPQkqncxXaXsDn7tZ87KQ2A3WlhAVLJB6c0IzU3+Cy/Ir/VRYs=
X-Gm-Gg: AY/fxX5Tg7CeY5JM4k7cuj2ipW+UlgbATeOcQAomEQc2NwH1WkW89z9J6UKax62mygi
 anYn1zL/a85fsD+ks32s9rzQsmBCL8XFEi06m25PZ0ACtCyQcSMstNhb0Zdu932a6SZn0tNis1T
 cGS5JhQfbCERKNg+2dTaTQVv/boLFDGL8xOGbGLrjExhquU+2HzW0SltXNbzvHx/SB9cZQ0EAti
 nRre+5YUR/lBn+DX6HM53v8uW7/HmhfxEFT5VSqQsM608yiV6p2XDWnQBSbZsIMV6at9s9+Nyvk
 qWONLuRp79YPBOTw8U8P98RkPiE5Dts46fgTghovEZZLKgw1H8gfKpEJmuDAwGb5Mkr3U2+RF2g
 cXCCQPSFZ2JOFfjlI5WlPNmKEplAPrznw1SUn+Qa/NdIzg7oCFEYQTp2rc5ptBt8yv4zB33V357
 EIi9V/i1msBS5SqzFBJfLvf+XT/kIJL1/Fpsy51Ua2WN5OE9JvgSN+Ck59XAbnc1uTs+OSVNjBu
 Msy
X-Google-Smtp-Source: AGHT+IHq4vACgVKOx4aPx801tg3PLPK8pFDyzu+UtEpz6JVbzAfuE91i9u5AKu1h/ttU9wE/M+7d2A==
X-Received: by 2002:a17:907:d93:b0:b76:4426:3a3a with SMTP id
 a640c23a62f3a-b7ce850ab93mr636333166b.58.1765444081247; 
 Thu, 11 Dec 2025 01:08:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:fed:3801:b301:f624:81e5:1bad?
 ([2a0a:ef40:fed:3801:b301:f624:81e5:1bad])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7cfa5d1e89sm206952966b.69.2025.12.11.01.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 01:08:00 -0800 (PST)
Message-ID: <0e7b7801-1066-4ed5-9407-a0dd62f2b8a9@linaro.org>
Date: Thu, 11 Dec 2025 09:07:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: Port NFS to LWIP
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <d9abea30-3604-4c06-9ec0-15e67edf34f7@gmx.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <d9abea30-3604-4c06-9ec0-15e67edf34f7@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/12/2025 12:55, Heinrich Schuchardt wrote:
> On 12/8/25 13:52, Andrew Goodbody wrote:
>> This series ports the existing NFS code so that it can be used with both
>> the legacy network code and also with LWIP.
>> Firstly some legacy network code, mostly variables, is moved into common
>> files so that it is accessible to LWIP.
>> Secondly the NFS code is refactored so that the parts that are not
>> specific to the network code can be shared with both network
>> implementations.
>> Finally the LWIP specific parts needed to interface the NFS shared code
>> to that network stack are added and enabled.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>> Andrew Goodbody (5):
>>        net: move net_state to net-common
>>        net: Move some variables to net-common files
>>        net: nfs: Add licence header
>>        net: nfs: Move most NFS code to common files
>>        net: lwip: nfs: Port the NFS code to work with LWIP
>>
>>   cmd/Kconfig          |  28 +-
>>   cmd/lwip/Makefile    |   1 +
>>   cmd/lwip/nfs.c       |  11 +
>>   include/net-common.h |  38 ++-
>>   include/net-legacy.h |  26 --
>>   include/net-lwip.h   |   1 +
>>   net/Makefile         |   1 +
>>   net/lwip/Makefile    |   1 +
>>   net/lwip/net-lwip.c  |   5 -
>>   net/lwip/nfs.c       | 282 +++++++++++++++++
>>   net/net-common.c     |  21 ++
>>   net/net.c            |  23 --
>>   net/nfs-common.c     | 863 +++++++++++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   net/nfs-common.h     | 123 ++++++++
>>   net/nfs.c            | 849 
>> +-------------------------------------------------
>>   net/nfs.h            |  59 ----
>>   16 files changed, 1368 insertions(+), 964 deletions(-)
>> ---
>> base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
>> change-id: 20251029-lwip_nfs-5385efca71bc
>>
>> Best regards,
> 
> Thank you for looking into the LWIP port.
> 
> We lack an NFS server in our Gitlab CI to run the NFS test.
> 
> For HTTP we are running
> python3 -m http.server 80 --directory "${UBOOT_TRAVIS_BUILD_DIR}"
> in .gitlab-ci.yml.
> 
> We should do something similar for NFS.
> 
> There is a userspace NFS server available
> at https://github.com/unfs3/unfs3.
> 
> This worked on my workstation:
> 
> cat > exports << EOF
> /home/ubuntu
> EOF
> ./unfsd -e `pwd`/exports  -u  -n 4096 -m 4096
> sudo mount -t nfs \
> -o port=4096,mountport=4096,mountvers=3,nolock \
> localhost:/home/ubuntu /mnt
> 
> Now in /mnt I could see the /home/ubuntu file-system.

Tom, is this something that can be added to the build containers?

> With LWIP we should think about enabling tcp for NFS.

As they say, patches are welcome, but it is unfortunately well outside 
the scope of this work.

Andrew

> Best regards
> 
> Heinrich

