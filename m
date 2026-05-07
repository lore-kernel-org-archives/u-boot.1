Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C3CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 03:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6886A849BF;
	Thu,  7 May 2026 05:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="J6XzANVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C74A849F6; Thu,  7 May 2026 05:51:16 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E1B84951
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 05:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g9ywH4y3Xz9vJh;
 Thu,  7 May 2026 05:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778125872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6na5yuMNvS/laDn+VO4bsD1IBxEOeOunY58zQZMZu8=;
 b=J6XzANVin2CgFP/+e4uB2v+QSWqqdiLBazjPjYq9WoagGKQenIgFYIlRWTincs4YSgVeuo
 ICmRUg9f/dexBEJt4DKdNwCZg+BO2+LiHPHJYiaKF9M0gSyZacZoPzU2VFAKY9MR4Fvg+s
 4Qv+bu7kQQ/9kT85HbphQMYmEFQMp7Y9EywhS/fcAoUcak92JfxcVxNizq6TdouQrfuZg8
 WZRpQxUZVQnNSWffqibl4eXipRcnAa1aANTJpvt2+T/fUcgFiQO4/8i2PRQF05WPdox7mI
 5YRZWL6jqs+d4ovILo9q5dOs19pgNReAB6Ss0sjT/OWkIJ/d56HEM4MybvXCjA==
Message-ID: <755b13b4-604d-480a-84be-000316eaf5a5@mailbox.org>
Date: Thu, 7 May 2026 05:51:08 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-4-alif.zakuan.yuslaimi@altera.com>
 <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2880c529-5740-40b4-bb98-aa471f0c628f@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qqtzzzn3ik4qm4eur51p1w1e8qut16r8
X-MBO-RS-ID: 4015e2a507f459ef5fa
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

On 5/5/26 8:54 AM, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>> case.
>>
>> This implementation turns the caches on temporarily, then overwrites the
>> whole RAM with zeroes, flushes the caches and turns them off again.
>> This provides satisfactory performance.
>>
>> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
>> Preparation for Gen5 uses the same memory initialization function as
>> Arria10.
>>
>> New Kconfig is introduced to enable this implementation only on the 
>> default
>> Arria10 and CycloneV boards as this will increase the SPL size which
>> will exceed some Gen5 devices' SPL size limit.
The subject is severely misleading, the ECC scrubbing was upstream since 
2018:

07252f6f7e37 ("ddr: altera: Add ECC DRAM scrubbing support for Arria10")

     ddr: altera: Add ECC DRAM scrubbing support for Arria10

     The SDRAM must first be rewritten by zeroes if ECC is used to 
initialize
     the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
     case. This scrubbing implementation turns the caches on 
temporarily, then
     overwrites the whole RAM with zeroes, flushes the caches and turns them
     off again. This provides satisfactory performance.

Even the commit message of this patch is a duplicate of that one in the 
commit from 2018 ? What is going on here ?
