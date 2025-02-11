Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3B6C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99409803CC;
	Tue, 11 Feb 2025 09:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="OY5a/Hmi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D0E805D7; Tue, 11 Feb 2025 09:02:01 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6D48043C
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1160788566b.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1739260917; x=1739865717;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFnxnB67+7ypOnTcUAvoqfBfMGuNYCzTx+ges54yDKw=;
 b=OY5a/HmiCEOywRxrShX3wpNItYjOTPFEkQGokWXhPdxzwBj8OGixZlprjJ9B+LJe0h
 YCLypd9ktMhkkkEVhex8HyEKB41SCr1UHQJ3pUowerLiu/aAAYbQ7+ymWzLLjZI/hA1f
 UUxoHAQL+NQNUlMK4l3GXK9m2h3xUt8c92xEOmvv1da62bnNRPoUZ+sTlvaV1D97LpA+
 sw0U/Do78PRXBnp4cuADjSTXn0xONldN+WafhvP5l4A0E5YXPNbcVt/BSXF5Xu8z0Ts/
 llLPBqTa1hjG1rWYnYlpqK0e9IrptbrwOe36C8r9AaVImivp7OJEAhGzKFg4MX21XbUY
 BWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260917; x=1739865717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFnxnB67+7ypOnTcUAvoqfBfMGuNYCzTx+ges54yDKw=;
 b=dFTR+xkl3L2ErtYOCJCsBM4QVpue3EscSQwzbSYVpSekRIdVdmBqRiB7jwx0a5RHi9
 gnG6HDCZdTVM0K+4ufbMI3hqLC/SyDiE5gnBtGMWJrs5bGcVaLY0ZrfxOkOgDbeZE81b
 5aARb/vcFSsK7nwvaCShiHYLGi4i5FFARGUYGx91cPZ3lO815VnYCRXMp+wTneDKb/Gx
 wh8p7ClZBsK9t7rhUMschlTGVO33UR5C2VbBR9caXt/oMJr1i3kNLdFZiCXBVtwNlaxE
 EX7/Y5dC0p4nUomSkL2lRhXrddH3FgdNn5+I/FwNsUj1glf0AH3z191mS+XHE2TgeHRo
 phsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1xMICIcFBhVpi/u309ZLutnxx7nHb3xNbDx+a91pCVEFMN4klY/HWiRS07bjPLcAjZL7RLc4=@lists.denx.de
X-Gm-Message-State: AOJu0YxGO/dEfFj08t+8orcRTdGT3+tONgf3ZvYpR2PjccSWVsSSe6wR
 MWDgWpAbXec59YsjV5/NjNfIAfWaqVVHMuWH2LhNw8F+CCHS51m/99HwnADGIg==
X-Gm-Gg: ASbGnctbvwIs/c6Qh9jytGhWaingzS+JGi6gMZJ/AMrQMrkTedFh07KiCYQD5+Gr/rP
 RViHMuHhfYeDpDwZY9drm9yTTcSe1UfxoepvDnoQ1gXceWe4RZ0Yjz9Jz6ELJdqmHd8lsfVqPbj
 UD8W+dmfEn/0iAuY50drxRph3FxJYLBY9BlW+A2w7gGuWfSqqwxUroaWHTHTi9xtRrHWVMOe0tV
 rcVBumP+waD2VVikRDVsOAxn881S2F2C69hqzpQu43q8RebwmmCYgQQHy6wOzh9YbXBlRZc9t9+
 4yjpMPm4qGCS8ruFbXHkmNIoWXZ5LPk=
X-Google-Smtp-Source: AGHT+IHWd3DK72zSiSRSvbsn9ZIHldU8084J1IIZlbu7jhwuBRirWkJqgP7Kgko/qduZFwPUST6X9Q==
X-Received: by 2002:a17:907:a0d1:b0:ab7:e91c:77ef with SMTP id
 a640c23a62f3a-ab7e91c7dbamr20261766b.24.1739260916548; 
 Tue, 11 Feb 2025 00:01:56 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d9601161sm119435666b.183.2025.02.11.00.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 00:01:55 -0800 (PST)
Message-ID: <06041153-7f57-4aec-b4ba-24f600a9241a@monstr.eu>
Date: Tue, 11 Feb 2025 09:01:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2025.04-rc2 released
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20250210220151.GR1233568@bill-the-cat>
 <5b1e2d1d-87b1-4051-acb1-ea91b0a31dc2@gmx.de>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <5b1e2d1d-87b1-4051-acb1-ea91b0a31dc2@gmx.de>
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



On 2/11/25 08:37, Heinrich Schuchardt wrote:
> On 10.02.25 23:01, Tom Rini wrote:
>> Hey all,
>>
>> It's release day and so here's v2025.04-rc2. As this is the -rc2
>> release, I've now also opened up the -next branch and will be stricter
>> about what I apply myself, and what I see coming in for pull requests as
>> well moving forward.
>>
>> Continuing on with what I started after the -rc1 release, I've
>> scheduled a video call tomorrow at 9am -0600 and the calendar link is:
>> https://calendar.google.com/calendar/event? 
>> action=TEMPLATE&tmeid=N280N2tlcXE3aDVtbjlicnNkcm82YnA1bDAgODliZTdiODEzMTM2YmVjMDZhODNkZTRkYTU5NzQ1ZjBhYmQxMWMxYjgzNjA2MWFlMDZjMWM3ZGJjZDE4ZGY0MUBn&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com
> 
> When I try to follow this link it Google just tells me "Calendar could
> not load the data. Please try reloading later."

The same for me.

M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

