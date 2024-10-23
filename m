Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D10CF539E
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AEE18919C;
	Wed, 23 Oct 2024 17:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="f0r8RTb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B031E891A3; Wed, 23 Oct 2024 17:18:18 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C21689184
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XYXjv3mLgz9t1H;
 Wed, 23 Oct 2024 17:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729696691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTJI0DLbUn0OE24LoDWZAb9IiCmfF8bR38HUIcm47B4=;
 b=f0r8RTb9/i3l0Cj0KOCqg/X60rw1btB0cMqhn8ih/I1RR/+mnj7fbR+sGoYFE4Aqvan7Li
 4lCD8XdQSmKwYp5G+PpHHKdPVVmVSUCSDqSjSbEh92KATMfp+296agm/C9v8j8YJLjwfIM
 rTG4XySUhtLvHFdnC1sa200vbJWV162c19axcQ+NaRdMH3e/qVOpGC8qUYMpO4w19L6IO8
 I8Hplnpnb4oGk4D/lYUAwxBhKTsvDf3DIbZ5tkMWkO9h+vKYkEw0jTnRRKea5vF5KKB2mP
 KK7gq+BhgesKbdH/y/LOmHGbHBM4CZsz75ocPCHTZ6qWu2a9GewIvFNmrycunA==
Message-ID: <d3a6617e-4ca0-4a9c-8434-fd859c4c78d3@mailbox.org>
Date: Wed, 23 Oct 2024 17:18:07 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories support
 in QSPI driver"
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241022210633.271534-1-marek.vasut+renesas@mailbox.org>
 <SA1PR12MB8697AF99B0A56734FF65AD47984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <699f9d96-a109-40ab-9cd8-ed0c5b4b589f@mailbox.org>
 <SA1PR12MB869767A8D003AB114830D46A984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <03389ee7-3da9-4160-a193-00fd517ad56e@mailbox.org>
 <SA1PR12MB869722D8E2019193343572AF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <a78899c6-aecf-4eaa-a9c9-8f11758542cd@mailbox.org>
 <SA1PR12MB8697E723395F31AEFCD1C8F1984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <SA1PR12MB869790C1B058968E33C891CF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <SA1PR12MB869790C1B058968E33C891CF984D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: r4fuzxnumh4fys4k7xcnc5q5bwg5hmy1
X-MBO-RS-ID: dbbdd7496c6afca702b
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

On 10/23/24 4:37 PM, Abbarapu, Venkatesh wrote:

[...]

>> Tried the test " sf probe && sf update 0x4000000 0 0x160000"
>>
>> Zynq> sf probe && sf update 0x4000000 0 0x160000
>> SF: Detected mx66l1g45g with page size 256 Bytes, erase size 64 KiB, total 128
>> MiB device 0 offset 0x0, size 0x160000
>> 0 bytes written, 1441792 bytes skipped in 0.154s, speed 9586980 B/s
>> Zynq>
>>
>>
> 
> Got the board with spansion flash part, tried below commands
> 
> Zynq> sf probe && sf update 0x4000000 0 0x160000
> SF: Detected s25fl512s with page size 256 Bytes, erase size 256 KiB, total 64 MiB
> device 0 offset 0x0, size 0x160000
> 1441792 bytes written, 0 bytes skipped in 5.186s, speed 284688 B/s
> Zynq>

Which board (or DT) is this and which U-Boot tree commit ?

And I am sorry, I missed the sf update test in your previous replies.
