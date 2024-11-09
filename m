Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB470D5E375
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 15:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5929A88C7E;
	Sat,  9 Nov 2024 16:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jjBNE9Q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3BB89110; Sat,  9 Nov 2024 16:22:35 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA3D88B0C
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 16:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 016C63F296
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731165751;
 bh=TlF+iGlmpHeBdZo73cspXelFX0QIp8ZnAqJycjBCbHY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jjBNE9Q4E1HYLNsWhp1qMA3zong3hrw6EUdVjZ95BWrZTlm6ECNTGT4DgMkehvYnC
 tphy/D27Qc9d7EewTyx/0Ru6HJFPbhtUuea5Nw4BMftVt9lDSD0BnacWWa17Q/eUOI
 BHvcuQaDxkSDQ7tOT8OaIEWvp6DVP6CSLZ5c/iOGlbXsIaC+d8fg/DBaO+oP+9o4KT
 hZp7NxS7dL+h3Sk7+SrT4Xu+6Ep3VSokpM3Y6aKXhDr3mpmSp7YqEkJb1/u/cvmNrK
 R+P+vkrrgNddSqCMSVxVgEhitpsN8QAQO2M1F6wngMqTCOm+MUEtDIYMdZYRek4QzW
 oU52eVF/+dLtg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-381d0582ad3so2470792f8f.0
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 07:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731165750; x=1731770550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TlF+iGlmpHeBdZo73cspXelFX0QIp8ZnAqJycjBCbHY=;
 b=V3JnsLROX/5uuyJbDhWrZNftiklpuIvpiGZF/dIRF1DCvsVbdhxZcBxNgJPR7L9Vkn
 anl9udwCa215zsi1tr0Wr29syxjtAdB/NTaO7anjUTG+y8ab/FHtjA0F6dDrfVKvVH16
 F1yPO8XQGLpYSll1mHSWxucJD/RBx4xbgG7m977ybqIh2twaX2i7i3bmxkyRC6kPyOCG
 UNCIQqO1vTItc5GCk+NIEjSRH2ClKF8l9tnaOhiZLLBmMlNHf/X28Ca/9SyIAhWKssIq
 7BkaEdqOmp65Jt5M9Fy1yhqC5h+VPIUW2aT7mVOPc8Md8CJNSzZfr9+0c/5LmkGknWIx
 Evhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU9Ewm7AN+HRijD60Bi8wKUcTMFi9Jr800aJn0ge3ObfB887001UORPyDgK0t0xVA3YhoGD0Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxHy6sTQDmqlNBdrB1DsGqO2xJdVwMj2IOCr5bD5A0R72h8DT5n
 FSqVjBWJ9lcZqKObGVuYJnkCSL47bFy6jSQvOKlWt83jny7uEitCjMg71IftxoUq6bLe4A/jdDl
 QpgZpp3d4wvyUKuDEMwOWM1qJido74Hv4DPKonwYZNXqEgKYpIgba8aapXEzNXUNUgPbsM1kPkD
 VcDw==
X-Received: by 2002:a5d:59a9:0:b0:381:f0e2:d874 with SMTP id
 ffacd0b85a97d-381f1884823mr7063728f8f.44.1731165750336; 
 Sat, 09 Nov 2024 07:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS/Nf8OcNs5YvXlqff+w7zGaqxAmYoosV6KgTyIJ2q+yJl7uicxKvTdMQIMdXdnNzotWOeWQ==
X-Received: by 2002:a5d:59a9:0:b0:381:f0e2:d874 with SMTP id
 ffacd0b85a97d-381f1884823mr7063685f8f.44.1731165749688; 
 Sat, 09 Nov 2024 07:22:29 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:8b3a:93e1:3453:f857:6699?
 ([2a02:3035:6e0:8b3a:93e1:3453:f857:6699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97075fsm7824734f8f.14.2024.11.09.07.22.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 07:22:29 -0800 (PST)
Message-ID: <654f78ed-18db-4f77-a732-69ef32c8c7c4@canonical.com>
Date: Sat, 9 Nov 2024 16:22:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] dhcp fails to download file with CONFIG_NET_LWIP=y
To: E Shattow <lucent@gmail.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
 <CANV2PTNScpCfP3vuwHFchR7ZgP5oDGUe1-9Lg5u2v8-cU48Pig@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CANV2PTNScpCfP3vuwHFchR7ZgP5oDGUe1-9Lg5u2v8-cU48Pig@mail.gmail.com>
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

On 11/9/24 16:12, E Shattow wrote:
> On Sat, Nov 9, 2024 at 6:20 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Hello Jerome,
>>
>> Using the old network stack U-Boot's dhcp command can be used to
>> download via TFTP. This fails with the lwIP stack:
>>
>> StarFive # dhcp $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
>> ethernet@16030000 Waiting for PHY auto negotiation to complete.... done
>> DHCP client bound to address 192.168.1.47 (233 ms)
>> StarFive # tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
>> Using ethernet@16030000 device
>> TFTP from server 192.168.1.103; our IP address is 192.168.1.47
>> Filename '/vf2/grubriscv64.efi'.
>> Load address: 0x40200000
>> Loading: #################################################################
>>            #################################################################
>>            #################################################################
>>            #################################################################
>>            #########
>>            4.1 MiB/s
>>
>> We should try to provide the old functionality to make the move to lwIP
>> seamless.
>>
>> In the CI QEMU instances we already have
>>
>> test/py/tests/test_net.py
>>
>> to test tftpboot. We should add an equivalent dhcp test.
>>
>> Best regards
>>
>> Heinrich
> 
> It is useful to have dhcp assignment without the side-effect of trying
> to load files. Your script can be updated to:

The dhcp command was explicitly built to support booting by retrieving a 
filename from the DHCP server and then loading it from a TFTP server. 
The recovery of many routers and IoT devices depends on this feature.

There is an environment variable autostart that controls if the file is 
only loaded or booted.

If we want to change the behavior, it should be via a well reviewed 
patch and not as a side-effect.

Best regards

Heinrich

> 
> dhcp ; tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
> 
> I agree this is a change in the user interface, but this change makes
> sense to me. There needs to be a way to boot tftp using the DHCP
> optioned tftp server, but a command 'dhcp' does not have boot in the
> name it is not clear what this command does. All other commands that
> do a boot action have 'boot' in the name? Perhaps dhcpboot or to make
> tftpboot with an option to use DHCP options for the tftp server
> location.
> 
> I don't think 'dhcp' should do anything except DHCP.
> 
> -E

