Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D72CC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 18:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178098817B;
	Sun, 19 May 2024 20:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YENgXKPX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6651788140; Sun, 19 May 2024 20:25:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46008817B
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 20:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59c448b44aso639675266b.2
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716143100; x=1716747900; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D9eMx6+exMXhVlwOapNQcYCqXzJZS89f9fI//2l/eRE=;
 b=YENgXKPXCcu8FHP9nRmxWRS4KwExE2aFZ4DYxmofPkD51cuHPhcLUEY/BuyPrL1Ots
 Nki3QYLT9KVejrGIebCiOI6uhARHbiX1H29X91G6j0AUFyq2liKZx1sQSAX4sDDphUZD
 C9R7TGmNqRaMHmREzNwp5PeCV2cwkwxVDAqURdmBNXOhhxq/7d/NU6DF3gym4m4HDKsR
 nEI276wES9TOdQGm0zJ5zvNxqePyjnXTH5Os1ZqaYRrvby0yNpz1yp5WT4joMTFIxVBQ
 Nr9dbyL64+ENZ31wgFPHfTpmg6W9CSUloinN+/VdJ9rSXj8Uf/KDxWD72opV3pK6223q
 Vw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716143100; x=1716747900;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D9eMx6+exMXhVlwOapNQcYCqXzJZS89f9fI//2l/eRE=;
 b=ehK+dA3a7ks1GNeZpAAH5AmA7VSYTy49o+CbqQ8/OOJi+rwSK+NoMtzwguanuNDbWh
 CDYMkGk1AnnTBnAm3vzNmsRtmUK5lpFt27Lx7EINF/7t86Q8LyBEJrqWvpqTwbyHgInr
 VZQMhn6VYq/QdbuFxa0bQRMiBxqe+4UCgaj71DWujVE1y/oXB+jCgOE6y4iiqJEu6G5R
 51OKr0qcm4CUP+f5+ck+22bYs2fNRi8uQJ67qO0QSyHpRH2o2DSGb6elD0FrBy0Z62WJ
 HKA1qyRm51cJ8AttGJXpqV4xyvZitc71ulMFvyMuIUkoVTbx48dGYGh3eSjRpDi88xDZ
 nf6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7gZblpi05E0TC7qz+PDYmy4FPIL9ceK5fP0QIr0+++ERv4f9elZtp6ABNgqzT+/FBT9EkprlAE2B+T2SRXxkJ4+TWw==
X-Gm-Message-State: AOJu0Yx9g0oFs07ULHed6ihn952YUnupMWy9+4tAY9MMxjRgJi2CpEac
 sY+t2cRNU+UW6LhOolUYcflaEUqWs7yrnYfaxQtWM+cZXSKNzzh1
X-Google-Smtp-Source: AGHT+IFr1Gfwk5xQHmwbUZoel12p/Aa22RlEqdiM6+Se573kklaSWZvXgk+A60UUfkNdLo66u/+AWQ==
X-Received: by 2002:a17:906:d41:b0:a5d:e05:c5eb with SMTP id
 a640c23a62f3a-a5d0e05c639mr434959666b.65.1716143100089; 
 Sun, 19 May 2024 11:25:00 -0700 (PDT)
Received: from [192.168.10.30] (77-7-142-46.pool.kielnet.net. [46.142.7.77])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a893a91b9sm699323366b.7.2024.05.19.11.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 11:24:59 -0700 (PDT)
Message-ID: <6efc687b-4aaa-4bf2-b705-303138cf330c@gmail.com>
Date: Sun, 19 May 2024 20:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] mailmap: Update email for Paul Burton
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
 <20240517-boston-v3-12-1ea7d23f4a1d@flygoat.com>
Content-Language: en-US
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
In-Reply-To: <20240517-boston-v3-12-1ea7d23f4a1d@flygoat.com>
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



On 5/17/24 20:15, Jiaxun Yang wrote:
> Paul had left MIPS a couple of years ago, his email address is
> no longer valid.
> 
> Replace it with his kenrel.org email, which has been used in
> kernel and QEMU, in case we still want to reach him.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   .mailmap                        | 3 ++-
>   board/imgtec/boston/MAINTAINERS | 2 +-
>   board/imgtec/malta/MAINTAINERS  | 2 +-
>   3 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
