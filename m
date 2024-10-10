Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12A4CF11E1
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159C788E15;
	Thu, 10 Oct 2024 14:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uZ6IYqSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B459B88F2C; Thu, 10 Oct 2024 14:24:09 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B41FB88C98
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 14:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 54EE93F277
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728563035;
 bh=t/qiFgiJrlq3b5IzBwkExHqYXJmXiZ8GJMgbr6c5W7w=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=uZ6IYqSDC7YDZq+91cUCCveYCR0WlsEh+KOZ3jKndsja2YbzT2gN5Hip6iglkexKK
 xSdKN3SlZ+9MK2L5p47k7v/8MVRRjI0nfhDuXgjKZDB/c2fVKm2BKZZJgMnw/F6a65
 /U5pqmRwksw8O9YLXq/uJC2GiATd8dhgQuwfldzmHsQvX87DQqdZLqhkBEtTVBFh8j
 KqHodke0ZduVLGTMBje9Xi5ixnDoIuUlKhmYR6gNqsm60Iw8tbhoSA2dWURVJL8tO4
 1V1vfPjXEAXZT1c6MBnxSFTTC+fOmhn4Nycs0RrPBN8GnXjs1L9lMXakFiyanLEvEd
 CfZWSi61/fr7A==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5116f0a6so103656f8f.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 05:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728563035; x=1729167835;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t/qiFgiJrlq3b5IzBwkExHqYXJmXiZ8GJMgbr6c5W7w=;
 b=gxbfQszJA2Pp2GTCarNz22xtMoNey4KHoazUBohxbheBHLVBtg3pO5EMljmuP9BAuv
 qj/BH3sOWrz+ClswqsK4vAQyat551MTfB8aCvx+DKLYueEm4jzDMQ41JHlHS3cNkjjiM
 3QzNjRFXTpTqfRyPuDmb7NSmitD6Oa3RjH9Q+OIZ3N6sZzS0BxHevVmQPB31ueDzkL5t
 Z3mN4XDWR0C6LhHNWbba7r3es0fOQ5FPcYpuaozOAt6BQBtzrKfpovyWAjYDN6Wqyqgf
 Bn0ny17TOx0Qlg7fv13L6V1jW+FNL2I24WTAVoTtNJonGuvvgjRN1aPaDa7X63KamV58
 LRuw==
X-Gm-Message-State: AOJu0Yw0U5ZKCtDk/b/uGHSXsBUhuJoDFuv+ZdvpudSly4ehx0XUmY8f
 IoRflKwVAE+MgGy1M4cL9cSOdwfwZJU63JNRZzhJjRTu0dqr7pr7YIA8zrG14wD1sKBlH3vpG8r
 SageJViRgwfg8E5DeL/ndR1LEPdc3tUiYEimD3+T8u9jWdUFfgwzjm6YXD+3P2VCdTVknTsSw4p
 dJ+w==
X-Received: by 2002:a05:6000:d83:b0:37d:4ebe:1646 with SMTP id
 ffacd0b85a97d-37d4ebe16dbmr825932f8f.48.1728563034842; 
 Thu, 10 Oct 2024 05:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgncPaQQQF2CDHeHWeCEvGDVNfNlHHN+Xio6lBaHI5HYX00HGe1pn7bR2pr4hn7Ui16bsp9g==
X-Received: by 2002:a05:6000:d83:b0:37d:4ebe:1646 with SMTP id
 ffacd0b85a97d-37d4ebe16dbmr825922f8f.48.1728563034463; 
 Thu, 10 Oct 2024 05:23:54 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:3cab:665b:d600:7ca:1c20?
 ([2a02:3035:6e0:3cab:665b:d600:7ca:1c20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b6cfb43sm1410662f8f.56.2024.10.10.05.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 05:23:54 -0700 (PDT)
Message-ID: <8669aceb-dcc2-467f-98bf-816ab6a165a9@canonical.com>
Date: Thu, 10 Oct 2024 14:23:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Arthur Heymans <arthurphilippeheymans@gmail.com>
Cc: u-boot@lists.denx.de
References: <CAC8Nb8Q0ACFhUxvmFM5YRSE=b9XEQQH--RQ1iZdva4LNzXDBRQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC8Nb8Q0ACFhUxvmFM5YRSE=b9XEQQH--RQ1iZdva4LNzXDBRQ@mail.gmail.com>
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

On 10.10.24 13:48, Arthur Heymans wrote:
> Hi
> 
> The addition of the line
> 
> ret = device_chld_unbind(dev, NULL);
> 
> Broke booting from sata with qemu q35 with coreboot + u-boot for me.
> 
> Kind regards

Hello Arthur,

Sorry to hear this. I would need a reproducible example for further 
analysis.

Could you, please, share an image, the U-Boot .config file and HEAD 
commit hash, as well as the QEMU command.

Best regards

Heinrich
