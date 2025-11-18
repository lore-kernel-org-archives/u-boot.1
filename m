Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1E7CEDD81
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D280C83D07;
	Tue, 18 Nov 2025 14:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Bcfi50Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7741D83D17; Tue, 18 Nov 2025 14:39:24 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702D883C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 14:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C3AC53F529
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763473160;
 bh=KL/4Z4f8pof6lbNDWPd5/BrNEBWC678TujdeK2j4aVI=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Bcfi50Le43/a/ONykwEKX2Hv+gS8HOkadcxtn7tGhzTMFxLdOG+Vc2JxRDwYjSLK5
 d5lCodZRWrLf5DHPQh5P9W+NV2vZaJgeOnrfSv+ZSwh0fvxA+jVGg/fB5chqeRXjqr
 fWxIQ1/AMVekOP+U2PJP7N2ImsR8fMg6aQdisvFq7Ru6eB8Ud8hfom6Ya+y1uHd9wJ
 VQMjUfIH3AlR4H2CiGWGaWgM92C5i+r4Gv6R1AR7dWksJQrPNKTFwPOz15MatCb6+M
 kCwHrjQLrKIv1bDfj/91oRAEpahvw5avEyOySwFETp8d5456xHp6cI+Nj8Wmng038e
 bg00Uoluj17AbePCCphA2cf8KjdneoIFT9Jym0Sd/CAYtr9XtDTER62zZ5TDGYr/BB
 CDyAV4vfGsn31BjbAQI9kDBPejV94EbO6THEib/dR+gOb2TVTqctDb1nEsnYiH9vuv
 Ca07vwUCEKrMlVroXjBtk0U+0ePh9aRDMQXeIchwV6PxftesCJWImSTpMD5I5zJY8V
 Ka07hYb/y7cyQt07SKx+S/LWRaVtqmFbVHpNMvZNh1ZB7RlPweqdv06Db7KyLva8hV
 gFZhUoASh47lUpq1EYr1vrBluIoYflhTHQvLOp02KarTiyksrPpI90kqGyRe1CkBUl
 KSN9pKJcaDKrVLfm/KEphO0g=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so25307585e9.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763473160; x=1764077960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KL/4Z4f8pof6lbNDWPd5/BrNEBWC678TujdeK2j4aVI=;
 b=ZKuyh2GWGQvbWOyJ4tR7+SVHkxRmxzvIibKymeUBgoa+ZDPzJtHmXks87OXMmaIQqO
 wYeMCxo4sBVyYtMC9FpKlQndFEaeSEJU2VIPOob/T/wZzEbJ6WGu9Xi7Hoo1KVTYpW3d
 mxt08m0ZVwvazK15FOdJbETlS95p0b4hQskm+tB5E7ZhstFJ63HwwAwQtifJ/EGqvsi8
 ZnuMxRRWzIseKZIU9DiYJww8FwBey2FSXP8kjk2aKDQragLXtC/Ufh8bNYWN63w9OaK2
 abA/rAeDVS3q+5t49bjKqaEIU/bD9JC6MZ416iu8A2Wylqpx9vLjHiU0a1tGxtsgpdZb
 D2Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6hVvozppejlvE1tJwj0oMFqCiLxDUzbRL+hK24384dWNZ15efihKq9WtQWn16DMu9Xzc4UV4=@lists.denx.de
X-Gm-Message-State: AOJu0YyM4CdtfjvVRTtqruDZ2KhjusdQWqWd8g/1IKgPHIzT5bQYmplg
 sAH77wXPeNJMuTJfa5d6b4T8nWXF5BNuHKanLXnM5CiCKqAfm3zz4k0+tWpmRU3B8+Pv3rwLIBe
 xtf+LX79wEW96yEWYW3rIWipgvvyMdn9FXPkvH4/118fz4euyUchTAasqGJt988P7c+ROtlA=
X-Gm-Gg: ASbGnctiHkNzmxsBYc0RG4ohMmC6T637mOuWGP5FcYJhFfN40BfzJlbAhZewUSJNHTn
 LH2BaIfiy3OZdo48ZJrkbvTrQw9NkViBjmqMSfVirfXWSWev+1zxLZsdQ3EZLK8iB7kV2WaYNYx
 Qu1oIWn8r6yF1dJka76RQQiwkLUAeamq9MkZg/UAhXWELLVU/nQpMcT/9udgK4OY8zau+WKWVcE
 hUXEqiHdGUzcguWEPc+ElQJ75oL8a1GhSCfM3asU2DZjSx/3QQQXbhFDxv6/TURBu5Bii5fu9zJ
 MEpT0dHDEmiKdIaCgcw69whj6E0OWHLbJw6y3jJqycnDvyztoJCR0iKluAQeeXcPTuyqVz2FNLz
 DkhgYBP19fP8aq254y+h3NzkScuiXv4cmZp9zBj0mdzl/ehk9hfL38J5mWNoNOUljdmfc+Eja/I
 eXGHDrikM=
X-Received: by 2002:a05:600c:c1c8:20b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-477a94acee9mr23462735e9.3.1763473160322; 
 Tue, 18 Nov 2025 05:39:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHelnlktj5HWYioPGNO90Yeim08XbprJTYP68GxlY5CIDmhoXlsJyAyvVPtIZtZDLZLCYXwkg==
X-Received: by 2002:a05:600c:c1c8:20b0:477:a2f7:74de with SMTP id
 5b1f17b1804b1-477a94acee9mr23462475e9.3.1763473159909; 
 Tue, 18 Nov 2025 05:39:19 -0800 (PST)
Received: from [192.168.103.118]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477975022ecsm204419055e9.4.2025.11.18.05.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 05:39:19 -0800 (PST)
Message-ID: <9e433559-5ed5-4aa4-b4a6-6c5541953b7a@canonical.com>
Date: Tue, 18 Nov 2025 14:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Broken USB on StarFive VisionFive 2
To: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <9d9357c5-4c09-46a4-bf33-f53399c176f9@canonical.com>
 <d0045b92-e823-4c2f-b7a5-efa7ececce37@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <d0045b92-e823-4c2f-b7a5-efa7ececce37@freeshell.de>
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

On 11/17/25 17:29, E Shattow wrote:
> 
> On 11/17/25 05:59, Heinrich Schuchardt wrote:
>> Hello Hal, hello Minda,
>>
>> USB on the StarFive VisionFive 2 is somehow broken.
>>
>> The `usb start` via preboot results in an error.
>> When I stop and restart USB it works.
>>
>> I am on origin/master (v2026.01-rc2-41-g69cc92d6869).
>>
>> I have a single USB stick plugged in. I tried with different devices.
>>
>> Best regards
>>
>> Heinrich
>>
>>
>> starting USB...
>> Register 5000420 NbrPorts 5
>> Starting the controller
>> USB XHCI 1.00
>> Adding block device usb_mass_storage.lun0 failed, r = 20
>> Bus xhci_pci: 3 USB Device(s) found
>>         scanning usb for storage devices... 2 Storage Device(s) found
>> Working FDT set to ff718640
>> Hit any key to stop autoboot: 0
>> StarFive # usb tree
>> USB device tree:
>>    1  Hub (5 Gb/s, 0mA)
>>    |  U-Boot XHCI Host Controller
>>    |
>>    +-2  Hub (480 Mb/s, 100mA)
>>      |   USB2.0 Hub
>>      |
>>      +-3  Mass Storage (480 Mb/s, 224mA)
>>           SanDisk Cruzer Fit 4C530102811224103381
>>
>> StarFive # part list usb 0
>>
>> Partition Map for usb device 0  --   Partition Type: DOS
>>
>> Part    Start Sector    Num Sectors     UUID            Type
>>    1     64              4802720         00000000-01     cd
>>    2     4802784         14112           00000000-02     ef Boot
>>    3     4816896         56672256        00000000-03     83
>> StarFive # ls usb 0:2
>> WARN endpoint is halted
>> WARN endpoint is halted
>> Resetting EP 3...
>> WARN endpoint is halted
>> WARN endpoint is halted
>> WARN endpoint is halted
>> Resetting EP 3...
>> WARN endpoint is halted
>> WARN endpoint is halted
>> WARN endpoint is halted
>> Resetting EP 3...
>> WARN endpoint is halted
>> WARN endpoint is halted
>> WARN endpoint is halted
>> Resetting EP 3...
>> WARN endpoint is halted
>> WARN endpoint is halted
>> WARN endpoint is halted
>> Resetting EP 3...
>> WARN endpoint is halted
>> WARN endpoint is halted
>> WARN endpoint is halted
>>
>> 0 file(s), 0 dir(s)
>>
>> StarFive # usb stop
>> stopping USB..
>> StarFive # usb start
>> starting USB...
>> Register 5000420 NbrPorts 5
>> Starting the controller
>> USB XHCI 1.00
>> Bus xhci_pci: 3 USB Device(s) found
>>         scanning usb for storage devices... 1 Storage Device(s) found
>> StarFive # ls usb 0:2
>>              EFI/
>>
>> 0 file(s), 1 dir(s)
>>
>>
> 
> Is there a different outcome with v2025.01 ? If yes, are you able to git
> bisect?
> 
> -E

I see the same behavior on U-Boot 2025.01.

The issue only occurs on my VisionFive 2 boards and not on any other 
JH7110 boards (Star64, Mars, Mars CM, VisionFive 2 Lite).

Best regards

Heinrich
