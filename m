Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2A6D3B7F5
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3329899C1;
	Mon, 25 Nov 2024 10:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uw3TQmHV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B255189963; Mon, 25 Nov 2024 10:21:38 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EC0899E7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 083FF40593
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732526496;
 bh=e57AsUCb8j28c4L5o2f0csxyy/7B4p1WrdKJ42U5gWQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=uw3TQmHVGjpU+QQIt17YMSCrnhIwsF+TURB/5cJg+5QfYkTvHBr/HxMAU7/LPUySY
 01UMZNHmmNGf9hApqg9XqP5qjU9BI9bltLbmiWeorqUcFIDtWVJz2mfcvpy/xaobGC
 LQs4xO+xnweNKmXxyhUxTA09LnjB9EuGcWWuuG9owUYWB7sFWYVi4stseClnnrZwin
 FiDSBHYbsUSca7Z4Cgxz3HHQpfDaDp9Eh3WCZO5/uTi5494sQSqOh9boxpQ92X0F7u
 THpY40oI160cHflx2uOEfE1L4bUlOLxjiknL9fRadxNvKP6O3xvVakX68vdF2KMXNM
 jEIePqaBas98A==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38229779bf4so2828644f8f.0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732526494; x=1733131294;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e57AsUCb8j28c4L5o2f0csxyy/7B4p1WrdKJ42U5gWQ=;
 b=TY7xxqwdzrLmo6zTdVaXtE76vDtLKU1ATBoK4kZm2upnWGEYV6F/DQzqly2gy9FQQN
 Jk3CtBKz37abebp1afV8XG8CEiPNOksyx1fWriy+vKn2lPthmN8fbAj5IX7oKlcONZvM
 8OwdX8CS1kyMBUoNTPNtktyz0WqHT8Jbbpv+1DFiuvhoKBugSx7OoYLX7LJ1mqNJvuOC
 PeyLQpIN9egYilhX9eYnQq4MNAzvdG/qxDiiZPcm1owlY+LmMJz0yx506u5eOeh8O1U/
 UEJKBBlKtB6o87dITHUi+0HETMyBK7P1CQ78/1TpaCW6UZI29BrUVzp2kpT7JPW7omWA
 pFgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvRZ7m4rI9w7Ncv0CrfQFKHXAdOpP7RQuZ9gqUNntTSOZ6wm2ErkAoF7c6J7if+51fmPoHhmI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+iB1NayWmRt9M8CfbnyKH+WqS+HaBVXq1kTCRxFG9V0l5pI+s
 ZgvQBPYZqq2Pse8WiosHFcdhSdB9hMNL47rzz8p9H0wf7eyrHKCu2b7hPWX5+UYqijjhSYNROhG
 Y6an2Y+ohUEkBQGTHP0QowbWb4HcOY72f96xhbFH5NSn873+cEKfPeo1t1wa0ZeZ20oY=
X-Gm-Gg: ASbGncutKVnzdK3FUQSWAUK0PlXduwVxcUtCIhuvTxaONXVTs0HC2Y0UUsCXbs71bLm
 LAZDoOcJTCDbhAqLz20e1oZy21TPoPx6OSvFLa+eQqIZpGQgBrLroVukQhZDv4bcM+28Eht5EBo
 wjeP593upw0OQwoOM3bLiLByfCsZJo3dQ/hExFuWLb8agFdnnb9Ju/NCRtMPowDzfnBlt3cjRah
 URofpxk1Ug6SnS9jGJnBEbiqmPOMba6mv2ZWHIwNh+U9M3yTt4fBr7fm4/GNb5FRMLhjQ7bIbO+
 DpVngpdj3g+KU498kqEQNSCNaMg7qrwz2wXevdtY7btNJg==
X-Received: by 2002:a05:6000:4007:b0:382:5295:b350 with SMTP id
 ffacd0b85a97d-38260b46ceamr10936658f8f.5.1732526494590; 
 Mon, 25 Nov 2024 01:21:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+9LIZK0nr+6Y7Y9hRUfPyb4jRgQRloI7ztjcE3vYXDxKE35QJDyqQOXWdjAl6qVcdtPeguQ==
X-Received: by 2002:a05:6000:4007:b0:382:5295:b350 with SMTP id
 ffacd0b85a97d-38260b46ceamr10936636f8f.5.1732526494271; 
 Mon, 25 Nov 2024 01:21:34 -0800 (PST)
Received: from [192.168.123.30] (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3defsm10139055f8f.70.2024.11.25.01.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 01:21:33 -0800 (PST)
Message-ID: <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
Date: Mon, 25 Nov 2024 10:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
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

On 11/25/24 09:32, Michal Simek wrote:
> 
> 
> On 11/23/24 22:45, Heinrich Schuchardt wrote:
>> The CI uses the following command to launch xilinx_versal_virt_defconfig:
>>
>>      qemu-system-aarch64 -M xlnx-versal-virt \
>>      -display none -m 4G -serial mon:stdio \
>>      -device loader,file=u-boot,cpu-num=0
>>
>> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
>> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
>> relative to the register start address 0xfe20c100.
>>
>> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>     new patch
>> ---
>>   configs/xilinx_versal_virt_defconfig | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/ 
>> xilinx_versal_virt_defconfig
>> index c8f166c1221..06a240173ba 100644
>> --- a/configs/xilinx_versal_virt_defconfig
>> +++ b/configs/xilinx_versal_virt_defconfig
>> @@ -153,8 +153,6 @@ CONFIG_USB=y
>>   CONFIG_DM_USB_GADGET=y
>>   CONFIG_USB_XHCI_HCD=y
>>   CONFIG_USB_XHCI_DWC3=y
>> -CONFIG_USB_DWC3=y
>> -CONFIG_USB_DWC3_GENERIC=y
>>   CONFIG_USB_ULPI_VIEWPORT=y
>>   CONFIG_USB_ULPI=y
>>   CONFIG_USB_GADGET=y
> 
> NACK. That's not the way to go. If one test is failing in CI disable 
> that test not really support which is for HW too.
> 
> Thanks,
> Michal

Hello Michal,

It is not that a single test fails. USB is completely unusable on the 
board. 'usb start' leads to an immediate crash.

The problem already existed in v2021.01.
Do you know of any QEMU/U-Boot combination where USB ever worked on the 
board?

Best regards

Heinrich
