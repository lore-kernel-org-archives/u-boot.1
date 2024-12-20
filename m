Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B671EE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 11:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED61480087;
	Fri, 20 Dec 2024 12:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="LJfyB7BW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1E68021A; Fri, 20 Dec 2024 12:43:58 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 374F88007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 12:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so5216823a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1734695035; x=1735299835;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujqIi5V52EMX2p9WnopJbRhR5Jx5du8VqhxwhZT85tI=;
 b=LJfyB7BWJSnVONUhz0N2HlIK2eq9OtpDdmrXWhhZCqVEVVuacxcEa55zSFbHDjbJI0
 brYa9qy/P7UsnSC3Sw9JdGvvc0ncsvgYgj8eAlNMG+0UGQGv6f6oCV29Lkh0X9/2Z+9B
 0MQ7iKpWBGDTA8H+v+ojJSrbjVmRdScg/zjwdpiuONTqRhjQdtF+UATcaV8OYsD3OswC
 mTDlJF2/K2Whgq8vWH/2gIYNA9OT2V2VqMVFi0xP0veixhY+rwqRIfnP77thwjI0dYKe
 KhXVQvu6P1aCvWduP9SC1JpV4VYf0cPcZPtQBLIechJACRkaXAmWhT6Z2GqV2bW+5AvZ
 GHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734695035; x=1735299835;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ujqIi5V52EMX2p9WnopJbRhR5Jx5du8VqhxwhZT85tI=;
 b=kTFIHUeu/tFLxi3XngQjJgrhqHnmJ/NDCBlhjxEL87OiEiM7mkhRTQcCh2YoGEg37t
 t5GWPcKoGmN08sNFMYvHWPAv8UBSNf4LykbsPYGvr9kIEj9z9G7E6mnvvm2P8LacZ1/B
 6HTOGyk0JUMepBV1nro8GeEx1GQC/7uK9gyk4p6YdfS6r/Wf1oowx1J4tp5h6aKxuKFD
 8dbyCkOuPH6UA8LhBtehtEfquXMUDzevpaaeTiu2ZdOYM9jEOxbIRiJkmZsw0tFIRxoa
 u2T8Qajf9winHAIFe2+rlqWdZuyT0iD7lIu5D8zs2Lr8Gq6DnUBh9+HTo2aLibzs7r/+
 FkFA==
X-Gm-Message-State: AOJu0Yxgj8UzQlxvk5TLejtGF6dxXaLad3Fw0t6jQovRVi23pRvYrmu8
 +scAC5rMLe6F9dzqEKY6VDShBoumlSvMRPPYXezfCFYB8iiMuYJL5gLaB4/Qz3LBdYbhkQ8funD
 7jw/w
X-Gm-Gg: ASbGnctBy4gEDmX7CHr5/EBAAo17QRoIW0ht3agqgEEMGQBnhmkvxCU9DevX5z2iMdu
 mJvCVqGfAA9ynMKVeEVmzrZ92Lljc7H0v0Zk8dipieXl5TCLPDDsqOomVOgSiQQZaSeeMW/2rC6
 +UIS6KVwk+ii0gU7Ltbpi6B/dGo62tqs+Ru+b4cnjLmMxhdJfmf5CLDDaw12UFDIPxRAZMawNtW
 X7ryJjF7lV8nGPsthW6XyLdHA1RD9I55HOutZ3Vpn//+JnIgnNVBDauw8XV3fMpVUR0RCzt
X-Google-Smtp-Source: AGHT+IEVg3GGB/CxWEaJ5p3qKPf3CfKYb31mO7l64wCR7haPtSwZ8u/GHRskdtCNNezfunmSmvLo2g==
X-Received: by 2002:a05:6402:274a:b0:5d0:d06b:cdc4 with SMTP id
 4fb4d7f45d1cf-5d81e8f2ecemr1651849a12.15.1734695035394; 
 Fri, 20 Dec 2024 03:43:55 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80675a41esm1646226a12.1.2024.12.20.03.43.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 03:43:55 -0800 (PST)
Message-ID: <4aa0c9ef-d582-44f6-9309-3c3c0c532a56@monstr.eu>
Date: Fri, 20 Dec 2024 12:43:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] xilinx patches for v2025.01-rc5 - v2
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

Hi Tom,

I would like to get this patch to 2025.01-rc5. The change is quite minimal but 
enable HW designs with memory mapped above 4GB which is quite useful

Thanks,
Michal


The following changes since commit c06705a9a13d58e799b98927c360e93954b62860:

   Makefile: Match the full path to ccache for filtering (2024-12-19 12:18:57 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.01-rc5-v2

for you to fetch changes up to 1b70b6c9cc98290fbd46da09c9f5a95f45121148:

   common: memtop: Fix the return type for find_ram_top (2024-12-20 09:17:43 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.01-rc5 - second

- Fix find_ram_top() return to support configs > 4GB

----------------------------------------------------------------
Venkatesh Yadav Abbarapu (1):
       common: memtop: Fix the return type for find_ram_top

  common/memtop.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

