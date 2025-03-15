Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5540C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 00:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033FA82040;
	Sat, 15 Mar 2025 01:12:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHGZJ/ax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95D8D82047; Sat, 15 Mar 2025 01:12:33 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D07D81F7E
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 01:12:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-300f92661fcso351545a91.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741997550; x=1742602350; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oSVGQ+pxUrXoOognGaiAa0fxAT8e/wKwhjVJIADqEOI=;
 b=MHGZJ/axEMxrOuxYTa9dgHWap+kbVYbIc3qkxNkt4gARnE7vVyn397pThfd8CeKWZN
 eplxgfbkyA7dZmraHnbatHRAuH1tCyXNqiupX8yoQu3Y5WkvQIw4jT8/+Hf5LSemjDjH
 eu0kONsc+LIOOYgTVjVJsPtrGXg4YjW4cAtepSvBvEstohQpv5l2ENXaEppvQHMHv+qY
 AjlmcB68AROyg0k1fuADLpA40ClGsLju9FrCVUlUH6fk4Vt+/O5sjGBfNK0ho559Z8ar
 MORRa+VVeyGCv6IiD2jhIP2ym0rUC1CECKhXYgiC9+kxGMD1tttSp3RmyIhm55BFBpeu
 JP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741997550; x=1742602350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oSVGQ+pxUrXoOognGaiAa0fxAT8e/wKwhjVJIADqEOI=;
 b=fJTXRA2bIGfenLNqsYY0t0h7NK0IXXX6drAlpsQYoGXG5TqQ2/z91njkghvwKV66Yp
 MacLDqQAc/bqVEl3YXNbqeLOswnlpZUImH/sy4b0JfVBmB4WSKdpdWpIT5/NvWtTk0KR
 JatVFyiQ//ro1uOrx6x69JRRGS6ju8xjjTv9N/hLwhRIB6/C1EmwDxRpnWHKtY6fQLw5
 vUwUPwhO+OU1csIDyqr79TvOS5Z2hTmwQZ6ajK4NBjO4k3xPuE8cDZMnVmNwes7i+VDb
 ROxyRmQYxj22NxBJFSanBJAbNVNQ0YXXiUQXMPkq046ebDv/MOodxFMgjLczbX8Y39J1
 vrkg==
X-Gm-Message-State: AOJu0YxnqnZRwK3fxrDpgajseu0G/iQRbtCge6iuem92Q0UN34W9nyXz
 Hm+UuSfVnmJB0+906JtuwI2mrMKw1NHpNoOXxJTe4exywCsQnUCp
X-Gm-Gg: ASbGncvZ8/5fetjG90jQ6BejR2ApvnWt2tKLTcVHlH/wTcOD/5mGByosC2bfbzoMegy
 uB71WpsY1xl7WePZYtDqhVtgnuMg4hE/YczuqnC3AR5lLB/rkyUyZlV5sEuf7e16vbswXgeJrg+
 IINlBW0I0qFp4YF2FCKBTCGqpoZq9MzqW8XohIDbotY5i4WsGh0HWrytQSsBoayIWC/o8MxQFJi
 WA8epXPRm8Fxg0mmLeP9pUtkLx315VyekCekaYjd4ZXuiq6iMHIUpR1mAljIqhH39Jx8382OFDi
 zwiKUmrCLHfN34jeJeLZfvDIrUymXcnaRaEh9n+qPl7Q1EAkvB3/s6hEFzMOK53yOvBOf3E7+2v
 hWsVzhhNkbY/8WBGnJx8X
X-Google-Smtp-Source: AGHT+IGAMJu/35UFa9cN4GxGjIemPNcidOHTjGHbw5z2U7IcOBj5U6dqEk8M8e24TKes8CD/mu3IwQ==
X-Received: by 2002:a17:90b:2cc3:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-30151acdcf1mr6461010a91.0.1741997549650; 
 Fri, 14 Mar 2025 17:12:29 -0700 (PDT)
Received: from [192.168.0.10] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301539d3f17sm1633649a91.10.2025.03.14.17.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 17:12:29 -0700 (PDT)
Message-ID: <ee59e161-7b0a-4cdf-a4da-16aedbe9afb8@gmail.com>
Date: Sat, 15 Mar 2025 09:12:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mtd: spi-nor-core: Rework spansion_sr_ready() for
 parallel memories support
To: Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>,
 jagan@amarulasolutions.com, vigneshr@ti.com, pratyush@kernel.org,
 ashok.reddy.soma@amd.com, venkatesh.abbarapu@amd.com,
 Hiroyuki.Saito2@infineon.com, Shinsuke.Okada@infineon.com,
 Daisuke.Nakata@infineon.com, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1741930961.git.Takahiro.Kuwano@infineon.com>
 <39ff6a5876f739f27aae4121f0669545def4aafe.1741930961.git.Takahiro.Kuwano@infineon.com>
 <b4fa6dc3-d9c5-4543-8410-5125a6fc9b7f@linaro.org>
 <20250314145415.GP2640854@bill-the-cat>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20250314145415.GP2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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

On 3/14/2025 11:54 PM, Tom Rini wrote:
> On Fri, Mar 14, 2025 at 07:40:17AM +0000, Tudor Ambarus wrote:
>> + Marek,
>>
>> Hi,
>>
>> On 3/14/25 5:53 AM, tkuw584924@gmail.com wrote:
>>> spansion_sr_ready() needs to support parallel memories configuration,
>>> that reads status register value from each devices and combines the
>>> status bits, likewise read_sr() and read_fsr().
>>
>> SNOR_F_HAS_PARALLEL describes 2 flashes that work in parallel mode. And
>> we hacked SPI NOR and used a single spi_nor object to handle both
>> flashes which is obviously wrong.
>>
>> My 2c is that we shouldn't build on top of a crumbling foundation. Until
>> everything's moved on top of SPI NOR, I'd accept just fixes on this
>> subject, so no new support. Tom and Jagan to decide.
> 
> Yes, I believe I was expecting some patches to redo / rework what we
> have in-tree currently.
> 
Understood our current position and status, thanks!

Takahiro

