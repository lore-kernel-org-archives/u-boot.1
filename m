Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486DAD5E372
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 14:20:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5FF89065;
	Sat,  9 Nov 2024 15:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NzYV5pEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874A889065; Sat,  9 Nov 2024 15:20:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA3D88BFB
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 15:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0DF423F29B
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1731162007;
 bh=K3f/Gn4pN73Fq5pE5SNQiqW4Fr+cquK+buZIRtMRNS4=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=NzYV5pEMY7qmxhuvFwLfgeLcB3qDRl3niOTzEruA4o517SuliUAAzQxVnzvmv2c1y
 4whoovllwxpqRfCAFCux0nyjUPM8CT12ftTgZE0RmjIyy/TjEQ4rTeiWHYrBpaGxji
 6Xn3hBQC7ShyeNQHjOCOVF5QYw8BMf6ahRq3xYMkZ+tCxpxvG83ooUa2t+lTxaNuqY
 dfTNLPpW6mFS5cho0FBUnIxNXa2uwNa6Q8l01xmiP7nQvB/Vj3wkAyb8sfdpdbZQj4
 qAGPvdI4BcMvBnYATskhuUEaF3QkVsKPqJWjfgKIYnqXKcVeZemI5xkFPamtcdqkjH
 7gE5QPzfE/0/Q==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315e8e9b1cso17525195e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 06:20:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731162006; x=1731766806;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K3f/Gn4pN73Fq5pE5SNQiqW4Fr+cquK+buZIRtMRNS4=;
 b=ikkaxUcSwkwDYP5XVvk32OuKJ438Dq0duCtWYda4jpc5oFL9oQOnj6ZaOVXW6MRu6H
 EZBOBtUdU4+3aubJrIa05OV1wTaEUO2bqSR4Hor9LfwSk+2Amg+WZQhYhHCWuMV3K8nV
 tKVbCHfBBTV5jCi5kx1ctH5nIkK9GH11mSVu/K3490NUk9eY9W62OaZqpQPQrBDa7zyx
 GpujiIoAc+b+YIJzrUF8fE1oqGaQeVkGtFI3ZJsIj+ipnbOikdpZB4e9jgNn5Qh+WiD+
 GSnEpumYqk7y1Y0/gV0uJ0DF9wAHZ7cBEuMKXThRpugz7kWGN4P8M5hND5ZDvWQC0rK5
 ooTQ==
X-Gm-Message-State: AOJu0YxSevOZ/ktv9qOLJ/hUn7misFCXxAFJ8LfiCGFetmwN/Tc00fBU
 oPCUzothFiVReHlRO5NO1jVULvNz7aP698ywAqFq/cgAscD3h6dAKnIIqBWi8sQYvUxF68bCJOl
 XCY9PSSP1A9DuAWXsrQYrnAuy3hHfm4PbPFOho4KZA07nle1H7HKe2Hy66teFTwMCtNY=
X-Received: by 2002:a05:600c:4fc3:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-432b744db26mr53870235e9.4.1731162006487; 
 Sat, 09 Nov 2024 06:20:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEofkBmeAA5P76bkGp7MuKgk/BuXInUTFd5V8P5Oa55JPn2MwFtNAxiibBw+Y2XVvKXq3eZDQ==
X-Received: by 2002:a05:600c:4fc3:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-432b744db26mr53869995e9.4.1731162005907; 
 Sat, 09 Nov 2024 06:20:05 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:8b3a:93e1:3453:f857:6699?
 ([2a02:3035:6e0:8b3a:93e1:3453:f857:6699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea5c1sm7931809f8f.81.2024.11.09.06.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 06:20:05 -0800 (PST)
Message-ID: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
Date: Sat, 9 Nov 2024 15:20:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [BUG] dhcp fails to download file with CONFIG_NET_LWIP=y
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

Hello Jerome,

Using the old network stack U-Boot's dhcp command can be used to 
download via TFTP. This fails with the lwIP stack:

StarFive # dhcp $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
ethernet@16030000 Waiting for PHY auto negotiation to complete.... done
DHCP client bound to address 192.168.1.47 (233 ms)
StarFive # tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
Using ethernet@16030000 device
TFTP from server 192.168.1.103; our IP address is 192.168.1.47
Filename '/vf2/grubriscv64.efi'.
Load address: 0x40200000
Loading: #################################################################
          #################################################################
          #################################################################
          #################################################################
          #########
          4.1 MiB/s

We should try to provide the old functionality to make the move to lwIP 
seamless.

In the CI QEMU instances we already have

test/py/tests/test_net.py

to test tftpboot. We should add an equivalent dhcp test.

Best regards

Heinrich
