Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D52C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 673BC8644F;
	Wed, 23 Aug 2023 22:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Me8ealCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39A68640E; Wed, 23 Aug 2023 22:31:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45F63864DD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EA2F43FA9F
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 20:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692822689;
 bh=VO7D5djsZdAF3wXb59K85/oTjgFnaW1aetIf9r3Wmos=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Me8ealCzCpH9znSuAS7WSVE1rmxS8hPiDeOvolaYg4HDNsXE8TcTXRSM6Nv57tp1H
 ekrabNs0cmMWSZOXS67n7yDbqCCs6knM4L4zeUVvcfuVTW56RyqLP8KoAHszuSydDI
 yx2/sBLam5nnJAfDhnWui1gi3msBfuKKSfokmhO819A86Uz6imL/b+Brpyle9NDN3a
 k4BtHEFTj0hO7x9VOGzzTiT+yrxcEIygzSvfCvLfXzFaW4sg1pCUBEpbJZGPzlQYB6
 bODy0u//30xJtVQH3LovX+zve3obVssVZq71YWjJnVe6DDb9oIswrlAbQzKzw5Kmrg
 ByC6cIvm6jCiw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4014945c0a9so68235e9.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822689; x=1693427489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VO7D5djsZdAF3wXb59K85/oTjgFnaW1aetIf9r3Wmos=;
 b=hqOHTTurnpMmpyhpLFCXb396BdBjRMyl5iA7LPva5yrKzIr69hLE9EWm1kPY+hyXJr
 do5NXUzLSJVpFjLBTCTYRflxxIMfKKwjRVB5fS70kOevaHuPOYH1C9g6TWQy+G4riXLW
 9c2w4+hFXm7RTkd+kaePRwdyx+P1iC2Sdcr+3VK4BRxZMHqGrgqFMZG4JR8zUa/cxYFq
 joMXPBfLA5qvKa2U54sdtm+ZLSmmFTt9QT+wVrwu5za4m6qzK5GrrHk1NJlDah7w8WN1
 lTQGNkp7cA9gEH/1hqQR3x71TfzipXRCCsqFTu1hYnOOeMocgVTEaPf9DrpaZDuAeveC
 Z/kA==
X-Gm-Message-State: AOJu0YxL28KqLHPd1zTYf0Tz061Rb3nzjV2rWK7jLxbQtdNARl0YIVlU
 YdvOzPgPomyI7Z41o+cO8rws75r/u4r1YVpzSFBS0MR0elbsShOFjEFNAdbD6sOIMZ0IL8kHBEq
 F7PaAqKnYNYqf/1/DV1vWTQ/sV4Q8RlKGV6xzyCE=
X-Received: by 2002:a05:600c:3799:b0:3fe:d7b9:8251 with SMTP id
 o25-20020a05600c379900b003fed7b98251mr10095489wmr.2.1692822689357; 
 Wed, 23 Aug 2023 13:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjM3U2GjgxleBdTiUPaCXAJNuWYGtNDpECojdVuTj6rUDw1Lri/mpFTfdc4ugrKxy00cwKww==
X-Received: by 2002:a05:600c:3799:b0:3fe:d7b9:8251 with SMTP id
 o25-20020a05600c379900b003fed7b98251mr10095471wmr.2.1692822688949; 
 Wed, 23 Aug 2023 13:31:28 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-244-162.um16.pools.vodafone-ip.de.
 [62.143.244.162]) by smtp.gmail.com with ESMTPSA id
 p11-20020adfe60b000000b003176c6e87b1sm20114010wrm.81.2023.08.23.13.31.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 13:31:28 -0700 (PDT)
Message-ID: <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
Date: Wed, 23 Aug 2023 22:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20230823201400.m4l6hl7zy6x6srzd@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 8/23/23 22:14, Pali Rohár wrote:
> On Wednesday 23 August 2023 21:57:28 Heinrich Schuchardt wrote:
>> +Booting from TPL/SPL
>> +====================
>> +
>> +The main U-Boot binary may be to large to be loaded directly by the Boot ROM.
>> +This was the main driver for splitting up U-Boot into multiple boot stages with
>> +successively larger binaries.
>> +
>> +U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
>> +are optional. While many boards use SPL only few use TPL.
>> +
>> +TPL
>> +   Very early init, as tiny as possible. This loads SPL (or VPL if enabled).
> 
> This is not truth. SPL loads TPL. Or at least it was about year ago for powerpc plat.

Thanks for reviewing.

Cf. doc/arch/sandbox/sandbox.rst

For roc-cc-rk3328_defconfig TPL is much smaller than SPL:

78224 spl/u-boot-spl-nodtb.bin
20744 tpl/u-boot-tpl-nodtb.bin

For P2020RDB-PC_NAND_defconfig SPL is much smaller than TPL:

63624 tpl/u-boot-tpl-nodtb.bin
4096 spl/u-boot-spl-nodtb.bin

If some boards are running TPL->SPL and others SPL->TPL, we really have 
a naming convention issue. We cannot expect any user to understand such 
a confusion.

Looking at the MAINTAINER file it seems that POWERPC should be set to 
orphaned.

Best regards

Heinrich

> 
>> +VPL
>> +   Optional verification step, which can select one of several SPL binaries,
>> +   if A/B verified boot is enabled. Implementation of the VPL logic is
>> +   work-in-progress. For now it just boots into SPL.
>> +
>> +SPL
>> +   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It may also
>> +   load other firmware components.
> 
> SPL initializes NAND then loads TPL from NAND, TPL initialize DDR and then loads U-Boot.
