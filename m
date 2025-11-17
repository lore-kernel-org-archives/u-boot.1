Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE51ECEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 14:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86281839A8;
	Mon, 17 Nov 2025 15:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="P8PSlywl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07B6839AC; Mon, 17 Nov 2025 14:59:59 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0875839A1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 14:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71EBE3F641
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763387997;
 bh=7K8hSI8LfJk+VjqWMFrG34zkkUqKLOHY6H9bGNE80Eo=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=P8PSlywlT/aJuRK3YptWIEKNOyk024PkXcc+QTZi8o0+CsY5WGh01H8xFjmbQDIpE
 Yxsk+TTRkF4mt+I+gBwJbUIQXvx6NvMek898XUbCsC+Hb/jl42JSQvuC1lCgeyNOUr
 hodI9t91zbaS00XyNFUPCkIlQhqJEoYztLGm05r/qpJOZZgOP6ZkNiuA3ftzvpd4h2
 ur/7x4lMMjJVAL/bPPt37irZDoWalj956avO8pQD4cSiijD8M0bccfdyivcoG2pCuv
 Kd6ph6FuUatfUtSgX4abNeIA1ZyWWT4bFSesLJpM3Cs1axblznZ9oEq6NiGHoAsstI
 XLycrSHi5iOr82upVOuHcMDObWgaY4fIsde7HBjshY/MV4iOPH6319x200Lmi/BZ7J
 9n+0LsaEKiFG0yBE/dKeCRc9Tlgbi4qZ6gmpS2TQp0xmu1gnTBn+Fkt480IRsB1I8o
 oVO2w9qStZlvWa+yKWp123+uMAoUKIsfKoJi9g4zqp7U5quzh8rrXRG4dKkGcy6dPE
 iZfP7FsoF9oBF+75oUGlpXnIik04SieYuV079wRqGMYL0zIb2QMMolomImkD5a96DP
 EyThABfaonQVX8pEU/YS7hbG/GzjfLEXQKD58GPffk8qlwWEYa9/ziNnIMZY8sP5Pq
 SgFrDtaMULBs11eGCXQPMVZU=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso3389164f8f.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 05:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763387997; x=1763992797;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7K8hSI8LfJk+VjqWMFrG34zkkUqKLOHY6H9bGNE80Eo=;
 b=bLjPme/R1EN9yLINfC1xu9hBVmYHNj46Q50jEhvIb0/QZ97Kz3geEm5tEicM/RN3/+
 8nxqi43x3ufh8BkPGFNGAI3ghDSNwQsKk3uOGibqo9U0rToj9k0/QLctqdtDkVRfcn7X
 vPr3gNLi8GFbOHLUtGVnY3tZvEnCnGxM6CeQu2rvDASHFt4fGo2+9KPwq+MkUZTon1pq
 9pup1PSP/xtU7W9TXeGuAHcAuH2GWAp3g80eZ8rOnqkKa8aH3bJMJCX5eMa3BIxXpPWw
 stXhXlHv3cnX7uftnqOlKC59HKi7pIpiU04lsIQ+T1z1Es7VsjjmP7gDzXmgFBnmlSTS
 8CDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKMvRG9czrDe0nIv2EHAiq6Ls+geHL+8bs4YwUWQ1sWEsqdKeyB6uWkzJIDxD6VK3jgFYmttw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxlm0cyyZKfrJ34yi34Ic2m/ylyxqNGwTqfQX4FXQNUqnPwDkVT
 pcclRnj9WK38SNIV04jLX5Kqwfu5OFFYxFAq6m6tm9ukbzhs33gZM8DVGYKvbeudX7+Myj1j5OT
 bKvUNOuOGnQcZzfBHGEizOCSc7FDL5d7jnQGCCWXe0h2rSVs1UaRknH+NrkPNcbCfG9OSkJGhQJ
 70zM5W7Q==
X-Gm-Gg: ASbGncssAR+/3ftG3XKzSQ8Ukbydqb3eOrkOHvhDuLEsy7TuwVLP2/ON0C5U2gQJFuA
 fygxXB8//bMBo7LgDXsoF/gi7Xl9dh3TVSLUaL/re4lDiRgOkU900+A4TFr1WuR3tqIyqxUk3qm
 0D2W+1ZjvR/wrSP2Hc34YTGfpgGQdWJzu/ZZc4m3szFe6Iq0x/kidGL3HU9OrUOaZc+PMJcxjXF
 1c3WqZuv+SZR77y7DcDx12oTAG/PeLu5mhQcZhBG5eC3V1Z2VaMVUkH3RCouArCfzbHgLPs2K1Q
 LkaejS9ANF8a4EVF4PHh/DJA4GuPUmDQkaReH4GukrhNW2nZH+foV0kivrQEgsqxoN31HLSyQOw
 yylPEEpw/cKxmCu4RZJ6gdrNvAotmiBzXupE6k04aH95S8p9ggVEOj4dCoOw6uvZ8ec39FyyxO7
 XYIiAVURM=
X-Received: by 2002:a05:6000:3110:b0:42b:394a:9e3 with SMTP id
 ffacd0b85a97d-42b593821d8mr10790910f8f.38.1763387996989; 
 Mon, 17 Nov 2025 05:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDhJgfa6zeDa6exmfMsXm4FmRpFG7Ql7DqHOjhGKEVF6g2Jp2EjAh9qa27XzcNlEYGJouUQw==
X-Received: by 2002:a05:6000:3110:b0:42b:394a:9e3 with SMTP id
 ffacd0b85a97d-42b593821d8mr10790882f8f.38.1763387996512; 
 Mon, 17 Nov 2025 05:59:56 -0800 (PST)
Received: from [192.168.103.118]
 (dynamic-046-114-108-197.46.114.pool.telefonica.de. [46.114.108.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e845bdsm25522943f8f.12.2025.11.17.05.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 05:59:55 -0800 (PST)
Message-ID: <9d9357c5-4c09-46a4-bf33-f53399c176f9@canonical.com>
Date: Mon, 17 Nov 2025 14:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: E Shattow <lucent@gmail.com>, Marek Vasut <marex@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [BUG] Broken USB on StarFive VisionFive 2
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

Hello Hal, hello Minda,

USB on the StarFive VisionFive 2 is somehow broken.

The `usb start` via preboot results in an error.
When I stop and restart USB it works.

I am on origin/master (v2026.01-rc2-41-g69cc92d6869).

I have a single USB stick plugged in. I tried with different devices.

Best regards

Heinrich


starting USB...
Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
Adding block device usb_mass_storage.lun0 failed, r = 20
Bus xhci_pci: 3 USB Device(s) found
        scanning usb for storage devices... 2 Storage Device(s) found
Working FDT set to ff718640
Hit any key to stop autoboot: 0
StarFive # usb tree
USB device tree:
   1  Hub (5 Gb/s, 0mA)
   |  U-Boot XHCI Host Controller
   |
   +-2  Hub (480 Mb/s, 100mA)
     |   USB2.0 Hub
     |
     +-3  Mass Storage (480 Mb/s, 224mA)
          SanDisk Cruzer Fit 4C530102811224103381

StarFive # part list usb 0

Partition Map for usb device 0  --   Partition Type: DOS

Part    Start Sector    Num Sectors     UUID            Type
   1     64              4802720         00000000-01     cd
   2     4802784         14112           00000000-02     ef Boot
   3     4816896         56672256        00000000-03     83
StarFive # ls usb 0:2
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted
Resetting EP 3...
WARN endpoint is halted
WARN endpoint is halted
WARN endpoint is halted

0 file(s), 0 dir(s)

StarFive # usb stop
stopping USB..
StarFive # usb start
starting USB...
Register 5000420 NbrPorts 5
Starting the controller
USB XHCI 1.00
Bus xhci_pci: 3 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found
StarFive # ls usb 0:2
             EFI/

0 file(s), 1 dir(s)


