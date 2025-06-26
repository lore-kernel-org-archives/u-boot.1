Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F15C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38F9882AA4;
	Thu, 26 Jun 2025 13:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sD8w4nZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03C182D83; Thu, 26 Jun 2025 13:30:05 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897E080E9A
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so473389f8f.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750937396; x=1751542196; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mQ/7yH9rwF87qoQMIJmWAeY0O5yOei9Ly5rK1YEIDHk=;
 b=sD8w4nZ19fRYwH00qteWmgTn/Hm80P8ownFK4UfFVTY+/CC2cnXgNKvXBSU2+kiyF3
 Y1WdfPb/dAUQlnmS3agU+CUnT8VYAVRwknLP8QZYOtkkx7o+jHJcRalWNxAvt19T2MK1
 7t/pzQwtyV/TaabwpCFx/gYl2oACQI7jQiIh4vyrI3xgF7jWfD8WAHlqAS8LM7yi1Br9
 p/tuX74dFSwFJtJMLT8qtGh3wFb+zUk5mlHNFxiEwPv1nLVRQmRte9RKJXx8N4EyivYS
 4w9HxS3u1PqS94++4Ifd/MW/aiNAEuWdyxKcfmrZEl2pHzJdqOmMfqtqyGT2p11I8NBl
 XQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750937396; x=1751542196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mQ/7yH9rwF87qoQMIJmWAeY0O5yOei9Ly5rK1YEIDHk=;
 b=ZIRrUmO3AXVFhHHS6OFoAHdzAgwcmpkrfcoBusg4/E/YBlmzxrqeQpRl7BJyp0jMAH
 mD2Tc5vppiJFrnzO2Bhf6xtkHnTzROsZm62HfR1VY7O3B0Gaskfx49Lj4Q9Xb+fjfEmx
 sNc3lkOxz869d+bbCI/ojG7xt2MbpWiyoa33y3OMkoENsEo0KXNUGjQU6q2mOUORBBEX
 Y0qXmJMJc2RMMl9sRC+IlHbN+yMiz6d8y/Oflk1kt9GC2wgVSF+cVwiB6oa+APriXQTw
 az00iBWLNe23PCZIFDqp+/XzHBPiVYslnXyXkw0vQP1tJ4nPz2npdC65sDYT2g6c0KFS
 I2CQ==
X-Gm-Message-State: AOJu0YyvbMVlNFqOTki0YQobqsVO34VXuC1f7LLVz5StHvkTQqh01Uza
 mtkGkZxrmioo/T/UQpne+sSy/RNUNkSfSV5JRolr/iZwrooIlzOx640pQP1g4qW/GeU=
X-Gm-Gg: ASbGncsK10ICMUDHmFBsFhlqIKuIVva02nBaoOyAtNG27v/7ZgLjHYG592xr4FCDg0d
 iTcd19gK6DKd6Xp2fluv67JT+nolOi1zpbc75yr0wLN9FInjyX/M7BXzAinXhkY5t/C9D3cxUeY
 Cq/EsYtUcWuFd5k6veJtXONl8DwNUP3t8bsivnDg/bRSWJlSTlg7IGPz0P2NuQdbV/EX0DW7ga1
 M3pZDZDOaJZl1afLkfWLnGbvc8i9foBzY7G2bTZakmO5k9ehhjY6tXjWCJLkZ3j71YRTtT8P9UW
 mY9LYEWMpCHkmIlWgIEnnq43rb19NdrarlV2tU3O/XSm2H3Si83yvKR7Qgrr7Qs+OFc9+0xR6D6
 /Ez53vAxgt9bT6zYjMBM+RvUr8AGrA7CQott0YE/JGfw/Ztit0g==
X-Google-Smtp-Source: AGHT+IHUtcuR2wdemrDn6iypC9MCi5qvsYjG9sjx2qCOOtgiFJ//0XD+6iN/M+/lBKMWL3tTFcH8hA==
X-Received: by 2002:a05:6000:40df:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a6ed65cc0emr4880958f8f.50.1750937395882; 
 Thu, 26 Jun 2025 04:29:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:ee3:2301:12b:81c6:a008:45a3?
 ([2a0a:ef40:ee3:2301:12b:81c6:a008:45a3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c0812sm46594035e9.34.2025.06.26.04.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Jun 2025 04:29:55 -0700 (PDT)
Message-ID: <84d760dc-cc1d-46ab-bded-d7c6f72abbf5@linaro.org>
Date: Thu, 26 Jun 2025 12:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
 <b8e3d928-7f3c-46ef-bf6d-6eb8a48931ac@cherry.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <b8e3d928-7f3c-46ef-bf6d-6eb8a48931ac@cherry.de>
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

On 26/06/2025 12:14, Quentin Schulz wrote:
> Hi Andrew,
> 
> On 6/26/25 12:49 PM, Andrew Goodbody wrote:
>> ret maybe used uninitialised in some cases so instead
>> initialise it first to prevent this.
>>
> 
> I don't believe that's true, can you tell us which code path(s) could 
> trigger this because I didn't find one the 2min I spent reading the code.

No error path taken before line 563, ret is still not assigned to.
remaining == 0 which could come from being passed 0 on the command line, 
line 518, unless there is a check for that that I missed?
Code reaches line 591 without assigning to ret.

Andrew

>> This issue was found by Smatch.
>>
> 
> Seems like a false positive to me?
> 
> Cheers,
> Quentin

