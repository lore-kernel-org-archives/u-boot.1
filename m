Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819D7C02192
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2EB801DE;
	Fri,  7 Feb 2025 07:27:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="ccf1DIEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA0780207; Fri,  7 Feb 2025 07:27:49 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C932A801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5dce4a5d8a0so2866251a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 22:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1738909666; x=1739514466;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJQUe5wlA3t57H19KeILEVBLr+2C9aMwcRBaP9tAAjs=;
 b=ccf1DIEJZ8yrDsP/qiTtw2cV2fEZCSyVQL+RrOyWtmBBui/xad9Wu/T6EFAdQBYjtB
 PR/N3M1ZrrAvDBsDnOT7QqqMmGUPA3cQZKkac6K6I0IlLpevuYqfhB8ylX12Mhzy+mkx
 OlUMGjDhuzhal1s35ngnca64O5aM3mdNbdlDAdgO8P0tpSzmRW6Q6YEeW5fB9NSemsyh
 +WstTbDAvKWrR0h1l5xfbiMEBr4aXqy/DeuWJNV5AK+NPXrQXIRV4/nxW7UrgRQHR6HK
 DrWgfvQpdJkxw7gFGZt2gLNil49nXCReas+JfX5xjMSeh0YTQQzlVZJgb6JkHaE1Zw4k
 UxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738909666; x=1739514466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJQUe5wlA3t57H19KeILEVBLr+2C9aMwcRBaP9tAAjs=;
 b=VuIlDtzx9FCcsPQElmsc4QMUg2V9R0UrzqgSNbLM7MWAvPuNmw06HlMhiqTCzBMzE9
 B0Js+U0oMInwh4XRf1JsjjHJhsz7pwSEUXQvPLo/xjdJ/0/P4PVnBBDaepl/SE3BX8s6
 I8E9CxzEsQDAR/l4D6AxVqETStXC+aJRWU7zRzhYQDVjYIIFKCiXjw3Of7jfNOLTzPET
 APN0f4pf9FJZFcMmKXeAg4M1HBu5SYuePHc6a5F1O7z56dXyTMtWwz7Nef+ek/TqRYQF
 0tdhvBclJVIiFjZD7kbB42oslxqKYnz6FTRzCPBubha/vX7MhQP2PjA3vu1chRLvP3k5
 iFOA==
X-Gm-Message-State: AOJu0Yz2aErtP3+6cVA0uzyyhDykY1khkrI3d/mxwsPzDuhfuNcVNSTH
 0aslqQbLu8K5HOygaUT6q5hLcJcZ8+XVOmQ0iLhrZ9v+bvzbhhospscPPOOxUZS7nAa+ETHh5qv
 Wfg==
X-Gm-Gg: ASbGncv1PeC36zU7gij+AdpOotiqQzYxfl0FbX8R1UsikU8+EVg5VzkKmbRVgFHmIGC
 W5XFqM1DZQBNa10tOZsO38+OfhxvAFsropupy/vHG0I7lbdwnl1/iNnBd7Tptv0NoY25Kc5AgPR
 fo8p6Zzeg3GRcXVQbX/RL+Y69JXbNktQQL6ChGLg0L8nDw0p+gO1dHbtygdWNx1urodejofo87W
 9ug+UxXvkGFRT4/tu/cBACD/6qxK47ygoyQposIfwzq4WJT1E1MhJwlqciqBsKcoFRFXMW3Vzux
 BVmY5y3v62PRuJf0rBHN5q1RWxnXRvM=
X-Google-Smtp-Source: AGHT+IFpxFxOveJIwBhuRkxh3LcCSNZW+Fa9kGfB1Sj+gZnG8c9xS3OcWP5AAWIPvbk63tyZeLScvA==
X-Received: by 2002:a05:6402:194b:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5de44fe941dmr5876538a12.7.1738909665978; 
 Thu, 06 Feb 2025 22:27:45 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab781453f04sm133178066b.161.2025.02.06.22.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 22:27:44 -0800 (PST)
Message-ID: <b7675cc7-a058-4340-8858-935bc24152cb@monstr.eu>
Date: Fri, 7 Feb 2025 07:27:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] amd/xilinx patches for v2025.04-rc2
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <08076b31-b5e6-4321-af5f-0d59b559e21f@monstr.eu>
 <20250206233300.GS1233568@bill-the-cat>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
In-Reply-To: <20250206233300.GS1233568@bill-the-cat>
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



On 2/7/25 00:33, Tom Rini wrote:
> On Thu, Feb 06, 2025 at 08:57:41AM +0100, Michal Simek wrote:
> 
>> Hi Tom,
>>
>> please pull these patches to your tree. Nothing really significant there.
>> Some binman fixes which were not spot before and switching our platform to
>> LWIP to have cover it better.
>>
>> Thanks,
>> Michal
>>
>>
>> The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da1224416:
>>
>>    Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04
>> 11:57:36 -0600)
>>
>> are available in the Git repository at:
>>
>>    git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
>> tags/xilinx-for-v2025.04-rc2
> 
> Please note that if change your .git/config to something like:
> 	url = https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
> 	pushurl = git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> 
> for this remote I can then use "b4 pr" to apply these.

done. Did you switch to it?

Cheers,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

