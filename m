Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B5AC282E5
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 16:52:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E3E80BAA;
	Wed,  5 Mar 2025 17:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="j4bl1lZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100EC80E94; Wed,  5 Mar 2025 17:52:22 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AF9808A2
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 17:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e50de0b5easo6256950a12.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1741193539; x=1741798339;
 darn=lists.denx.de; 
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNHYimBo8ZH0ft9BLFVDYOyUscAHc7Hefxtg/0Kb7gA=;
 b=j4bl1lZPlgbKTDq4q0B1ai/dZttB4WyrpJPoTNk70UvPsMsKArDI1jajZ+wsGdtSRF
 dxPOpJhZ+o6YzW+nFNnWrfxnISXYaIss5vDHHQCe1KhWCAki7hlTaWz62aghvfgYGRhj
 8yBWhmY3YqDu0IeU1lsy+BTlyzz9oSalKT2IPbhAtEc3yINT2z5OLKb6V/gjLM+lWIu+
 5i15hn12hgXPLs7yAbwyb2Uucj/ibk5Ihf7axlUJcMiR5aWlc3s46TpCDEskwMftqT7d
 1lb4D7fqijzDv6aCZAFKdSAPfDDt+Jn5nnqK/agFkdkSAXPemWrsZm5g3P2BAzIhWzjF
 AiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193539; x=1741798339;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gNHYimBo8ZH0ft9BLFVDYOyUscAHc7Hefxtg/0Kb7gA=;
 b=cR0XznT+TSz59uV4RNLY94T3qFp5GVVkNT6CboGGOZ8fe8V2gOQwVPW4jOkAMwbxg0
 isUbilQ/bi5FBqDyVdji8YKHpefHzMI3DsDunQYAf+27G8vaGYo14YB/EPRSHZAa6qv2
 hZs/dVJE3pr2MRhgnX0fUiviEOxceujrdJMwjLoxOTFpb9pD/v/CGVmQvOcluNWn4zMA
 skNeOZwI9MFIsrX1MWYO3r/I8D+mh02M0s9khWJna+BtBpcXqCYcHaHNzRGMQZM8nybC
 cpAw/fyeS1BZAGWk4Rxe+5U1lq0Z4l0LmtMHCAJ8KQs9XlWUewYkNVRwHqgR9/rCs6XO
 1Ibg==
X-Gm-Message-State: AOJu0YyHt1VUxzgYXPFOgHAfqs9oEC2/aaWxU2AS3lt3dcjSRF1H0Zo+
 5o1kK7LEUK+3sAX7A3jrCpCSnO2JyMViOWEhW2bV4wni6qBcXJMY2ZygQKz1DdZHq5f3xsGSFgW
 5+g==
X-Gm-Gg: ASbGncsoEgV1DRKXX6Ku74Fr2pY/DF1iUXAXkIZPk6UF+P+YP/tH4Mc9bFgWGn0pQe9
 JbYwNdAG+UDgsDbjJSOyLBE5TcQ2poitxqO1xtjfbRm3hgfqbpw39DWEyLRpBqaxDvive+IOfBO
 BqiO2Qy33n8vYTIJseERfR91m7M2ggaJH6SAmQUCRYfbXpC3qL2RWOyzuITD7RIEcI5lrxn9x1B
 8p4hczrMkQc6hwhlF/H94RklsO/a4+HZrHKp1QuMWZPYH9lwRoBw0CKszJl9TMLZXLtRKtZzNVT
 WoYTy7dJGA65NqShC0UL9dt4ZC9dGfyP0SF60GoEaZ+gfDQXOWyqa7eJ9Mvv
X-Google-Smtp-Source: AGHT+IH2mXdBXETFL/lIxmEEOsYCjvQNhHiQDKi0hwnIcoraPe8cZybR6UAnUaxP19RwpXS5v+161Q==
X-Received: by 2002:a17:906:f584:b0:ac0:3d5c:4fc6 with SMTP id
 a640c23a62f3a-ac20da51dadmr382024566b.27.1741193538474; 
 Wed, 05 Mar 2025 08:52:18 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ee4c9sm1164387266b.97.2025.03.05.08.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:52:17 -0800 (PST)
Message-ID: <5195ba6f-1633-4b14-9567-4626ddbfe60d@monstr.eu>
Date: Wed, 5 Mar 2025 17:52:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <monstr@monstr.eu>
Subject: [GIT PULL] amd/xilinx patches for v2025.04-rc4
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

please pull these fixes to your tree. Especially patches from Padmarao are must 
have. One is fixing issue around using BSS section before relocation and second 
is fix connected to switching to LWIP. 4k MTU size never really worked with our 
MACB driver but old ethernet stack fallback to 1.5k MTU without.

Thanks,
Michal

The following changes since commit 6ae0a578de67038df291a5fea3e7ab67cc520680:

   Merge tag 'u-boot-rockchip-20250301' of 
https://source.denx.de/u-boot/custodians/u-boot-rockchip (2025-03-01 07:51:14 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.04-rc4

for you to fetch changes up to 8d2d615f14435c8d2d4e80509310691443b3a3d5:

   xilinx: Remove tftp block size 4096 (2025-03-05 12:42:34 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.04-rc4

Zynq:
- Guard code around SPL_FS_LOAD_PAYLOAD_NAME

Versal*:
- Remove tftp block size 4096

Versal:
- Use clocks per DT binding
- Store driver data in data section

Versal Gen 2:
- Fix major/minor version decoding

----------------------------------------------------------------
Michal Simek (2):
       xilinx: zynq: Guard code around SPL_FS_LOAD_PAYLOAD_NAME
       arm64: versal2: Show major and minor silicon version

Padmarao Begari (2):
       clk: versal: Store driver data in data section
       xilinx: Remove tftp block size 4096

Venkatesh Yadav Abbarapu (1):
       clk: versal: Update the reference clocks as per bindings

  arch/arm/mach-versal2/include/mach/hardware.h |  3 ++-
  board/xilinx/zynq/board.c                     |  2 ++
  configs/amd_versal2_virt_defconfig            |  1 -
  configs/xilinx_versal_net_virt_defconfig      |  1 -
  configs/xilinx_versal_virt_defconfig          |  1 -
  drivers/clk/clk_versal.c                      | 21 ++++++++++++++------
  drivers/soc/soc_amd_versal2.c                 |  4 +++-
  7 files changed, 22 insertions(+), 11 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
