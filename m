Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D89C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 17:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2636881F4;
	Sun, 19 May 2024 19:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bb48xEMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0F988291; Sun, 19 May 2024 19:57:21 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C19F881AD
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 19:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57230faeb81so3944367a12.0
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716141439; x=1716746239; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nJosJWP13oW+NBtpHZbNQ8D208IIEHVryY6kvPz3GfQ=;
 b=bb48xEMTGQ/grc+1S9vGqvXRXeML6SoDLbxMjjYq7C+ijZ2RJ/0iqjrT7dQhVaPd+B
 qweWf/mEWPA+b0Nv860Lfjv0j3Td89XzyuAPhOYlxM84raEltdREKoiYkuEHVgQL6Toi
 ehNo/nvc/6zjIdS/drb1jAHavWsUbSY5W5GVPiLjDmQMCwgtKUEGD7Gvbp1U7HnIMn/1
 aoxgBSTvzWTETPAr9yFmFZ+xEO3uQDQ/0O9ozF7ewqUC/4EZmWelCkB2Ka5DS3BwgIrd
 7LBZPrssgaTBGiwFZqX6D5tXJ5CPiaNgGf7SXcB1fb1pSXFoof1/UluBzxeNgknCD9Wu
 6KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716141439; x=1716746239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJosJWP13oW+NBtpHZbNQ8D208IIEHVryY6kvPz3GfQ=;
 b=v6ShDNc5F3p+7W+XesH3gsfTeSSZ1fzBau3c1SMG8h6Au2WI2GowAEBDIyegV3+HOd
 OulHOI5x98nMKJ2M+LbmvKAmQJ60ZJYRVCxMlvQb3iBi2aR5DtAZdW4qTBAm44XIWBQG
 /5yMKgkexb2X3TmZUvPZsl+DWXgYa7PDCiypMgILm5sOMBIyY1PYoSLy4BJdTf0Ga50z
 eTQllJneVOaxCFFw1QQ/n+cbdSy/B/vwt05TnBFY3Al10X00P+dFB2M43OcuwaQWm99j
 /NI1OJeEzB8Vinas9SUge5RrKfXKc7DOseS8YVqbHdJhLquz8bismFTDqKVqyZCz+6Tu
 qFGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWaLfBbleSSvlzMOtYWUmQwaU9tLjE7I9HiIvWIaV7Kls7MD5V0Hvgvr/A+H+om7gdKEXB9rwCXFY99abPAXPV5HcNmA==
X-Gm-Message-State: AOJu0YzxjYxWrhYfxigWma58v9WrRwOMZRxre3hOEC3kq1PLl4Dxt60C
 hY6onoy8LGc6e/GXhD0yq4X0u3fnpbFqNEXpSc7RN9SKG9/w0yKW
X-Google-Smtp-Source: AGHT+IF0hSwjDWd9XtHDdaG7ewe3w02m5ZXgbEqcApoynBW5fo6yXe1UysnmcNTQWGwKT8UmDNFGcg==
X-Received: by 2002:a50:d65d:0:b0:572:3483:8a27 with SMTP id
 4fb4d7f45d1cf-5734d67f8f7mr25348799a12.33.1716141438479; 
 Sun, 19 May 2024 10:57:18 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574ec5fb906sm6831497a12.30.2024.05.19.10.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 10:57:17 -0700 (PDT)
Message-ID: <2c45ebe6-2b8a-4ba9-9a81-ee761a5038ea@gmail.com>
Date: Sun, 19 May 2024 19:57:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] pci: xilinx: Handle size of ecam region properly
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-1-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-1-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:14, Jiaxun Yang wrote:
> Probe size of ecam from devicetree properly and cap accessible
> bus number accorading to ecam region size to ensure we don't go
> beyond hardware address space.
> 
> Also disable all interrupts to ensure errors are handled silently.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   drivers/pci/pcie_xilinx.c | 53 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 13 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
