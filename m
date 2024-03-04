Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCB9C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4AC87F09;
	Mon,  4 Mar 2024 10:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="u6GDxSOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E3187E64; Mon,  4 Mar 2024 10:23:25 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E142787EEE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6DA033F277
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 09:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709544202;
 bh=93J/+Zx4ShOW2244vhgZSQQCZQhLktexnOmCFVar52s=;
 h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
 b=u6GDxSODuxmSIImnp7KXl9SFVlLMGRVGr0KNNSVEgxa3zd1aLjRKgQ3cAu+Txgqcw
 i5mwfnnrLnNArmqhuC8MQUtOyGiyMQk7/05kWr6Mv52DVj3CiA259Fdjgnpqg29td2
 01j/3/UHe9cpRNbamirJuoG1Ls2fXKkl27Ph+McRmroJ7ooTAsiT2xgIKjIzlDL5sm
 wKAmeGWitvmIOkUj1YKoqrlicqpLt60MeH4r1vghQME/AfoROItyWn1isR/1mUQ9mk
 LnS+A0oloEQ2GFh6GBGsB2bDaYK7YO/BAMNj5OVQsJ+DMRQpin/S3nTikCuRra2q/V
 GWisHMO4floOg==
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50e91f9d422so4979210e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709544201; x=1710149001;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=93J/+Zx4ShOW2244vhgZSQQCZQhLktexnOmCFVar52s=;
 b=ds8/O5rrtnMIcFeJcILvVjc7xlV6PVuf51pOhfGnUsF8A/7jyMRBERuap6Zi++6UHU
 F0BdLV8wnola2qBRU81G/TDcFSsjyd4nHaIHLp5UlNLnc1T537nA5728SG+8MOr0iX7p
 p+wbWI5IbfC0ttUmp5dI5Q9K2U0MbKRi0QIhyxvvbvnEy1Nj8Sxy+a7UDS583jFQk3GM
 1IlYc4p/YTu9eITnCY0ndy0/p+U7zF+kCjxhs4VyNLyZXWkDfVmIHDolcjE9LmgFuvf5
 sExaKWk5D50ZVIzgfLruYr+FiXH4xWs9584HKLBYIEzKnSUI+S7zoct39TDZmcOHOliV
 kdig==
X-Gm-Message-State: AOJu0Yw94RkJip/TmfTiADDhnajZBZxHSChGk9GoZTs8LUQ+SNmHlyYe
 QOmGotuc3P5CZ0N0FOJlfAQfPV0eBw0CoUrdWjrv5zaujO85e4Rial7uqspSgk+xQZ5WQ97AwJw
 0p2gin6o5b2H271/THXWbUTrhBsql+IUUU6jMCTLWs5hOS/S3+0CJ9c1TkIjqXaiSYKI=
X-Received: by 2002:a19:e047:0:b0:513:3fa6:efe3 with SMTP id
 g7-20020a19e047000000b005133fa6efe3mr3047038lfj.8.1709544201572; 
 Mon, 04 Mar 2024 01:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuJmnNnJB7FT0SDOBB5CGxsHA1R+JTRpDtcdziyi8zLcW2uNYEJ0TCGCmGXpg2BGt38HVpUQ==
X-Received: by 2002:a19:e047:0:b0:513:3fa6:efe3 with SMTP id
 g7-20020a19e047000000b005133fa6efe3mr3047027lfj.8.1709544201227; 
 Mon, 04 Mar 2024 01:23:21 -0800 (PST)
Received: from [192.168.123.67] (ip-095-222-037-056.um34.pools.vodafone-ip.de.
 [95.222.37.56]) by smtp.gmail.com with ESMTPSA id
 j12-20020adfea4c000000b0033e11bd9febsm11215561wrn.90.2024.03.04.01.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 01:23:20 -0800 (PST)
Message-ID: <c43033ab-0be9-472b-b246-e1ccd5a205a7@canonical.com>
Date: Mon, 4 Mar 2024 10:23:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: U-Boot Maintainer for StarFive VisionFive 2 board
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

Hello Kuan, hello Wei Liang,

In U-Boot board/starfive/visionfive2/MAINTAINERS shows Yanhong Wang 
<yanhong.wang@starfivetech.com> as maintainer for the VisionFive 2 
board. But my mails for

"riscv: add support for Milk-V Mars board"
https://lore.kernel.org/u-boot/20240303130122.29983-1-heinrich.schuchardt@canonical.com/T/#t

were not received by Yanhong Wang:

<yanhong.wang@starfivetech.com>: host
     starfivetech-com.mail.protection.partner.outlook.cn[139.219.17.10] 
said:
     550 5.4.1 Recipient address rejected: Access denied. AS(201806281)
     [BJSCHN02FT010.eop-chn02.gallatin.protection.partner.outlook.cn
     2024-03-03T13:01:34.329Z 08DC3A90884ED30E] (in reply to RCPT TO 
command)

If he is no longer in your company, is there anybody else from StarFive 
who wants to step in?

Best regards

Heinrich
