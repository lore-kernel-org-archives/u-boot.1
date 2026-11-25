Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58685606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IW0/npC7;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kwHCiaZX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D33280DA5;
	Wed, 25 Nov 2026 08:27:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2YvAY2lNncNu; Wed, 25 Nov 2026 08:27:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C49B680D7F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795595222;
	b=BFrB6WByBohy/a2oKijNlFh0H6SLKl+55zX3TKW1brywBajCMsTJCox3Cdm8XeeYXYzw
	 Gz+tGY/Q2x8c6QNNUASFAWuDHirhGPv95mcS38YwMXGtrnhwVbsY37s6EGQi+jMErabhL
	 qEWNbt4iV2wo6KfwOIyvQuGB5VoPb2RfLwdXw0FiEpEezLPYQJ2vSO2VReEuCHxhxKxlh
	 icHES0sUACIWAXSj3kPatPGKm/k0nizwQbiRrRN0k9KIT2iymWb8GnZJEvaNT1IjT7fYn
	 uLauxvIpKlYHdYVRCPvKxCpdBzTN2vst9J6svQKn1tPQXcGxgtpIg3dM+teByO6T/gA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795595222;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bmj12dYbbqFkD36L0CPMGrBh5LmBkcbgrj+bZbLXumQ=;
	b=KrS3Y6tHhCAOFDRT0AMww5zFBrd0tbmK9CkjelRZwR+wJxIYde4I7S6SdtycQepEFm9U
	 hhiIDXi1MG9aK7gU8lCrTTO+VFUfHN0U2nPkwDYpFYO9eKLwVX1CFrWgPQ19ExoiMRsev
	 GO1SSsZJHSBSydr2uvusu7Miy5UA5Zbto7U7bfj5Rh3BfqhvpdBjVTtzzYRGkIUCrrVX7
	 VsMINGo99QFVwOA5fUEPA0ZvfLmjsVO0bt/a7ttLhYZkzQLBbdf4s7iOwZy5hOeI4u1dr
	 WWNpdu42R+ySGAZreCCAlanVDEwCxfOgZ1h3s6efGaUrxrMUCqQ8HULlD/8nXJWF6fQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795595222;
	bh=bmj12dYbbqFkD36L0CPMGrBh5LmBkcbgrj+bZbLXumQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IW0/npC7plAO4NCR8sbA+sFmcO6AZNgePdJ5ll7ByfCVmIXopapUnS3g0zLK1PkcI
	 O0xoePerGYAErmy31DQv+xXNzbpSDlkWu266haHyM8q6GjJaubcqCr7YJxf3014aFB
	 LyKS9ofRD46q65mjzxeUh4IkjkiEtXRYguJd0oH1mccY9L4Ta0kYfTFtKE98KeOh2/
	 0hSNm0jjBUAgJygbBNuiGJLaU2xv2BeEejZJrb22mYfgcL7XHuIfJS18/4mBUywYGn
	 iJFnlSU4Gt6tQzG8tSBV9tWAYHWCjQDCCd2EH+0d2FRnQZlzQ5zHjkr5gEmEZr6FTG
	 atFLO1nXndwmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C49B680D7F;
	Wed, 25 Nov 2026 08:27:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B07C10B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:27:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3097C6069B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:27:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K9Xp0ReunbCU for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 08:27:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 359D760627
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=kwHCiaZX
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 359D760627
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 08:26:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 359FAC2BB3B;
 Wed, 25 Nov 2026 08:27:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 69F9960480;
 Wed, 25 Nov 2026 08:26:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D210E11E68E26; Wed, 25 Nov 2026 09:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795595215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=bmj12dYbbqFkD36L0CPMGrBh5LmBkcbgrj+bZbLXumQ=;
 b=kwHCiaZX4PuLqEUwEYm9T+NVf+Z4uvtzajCm4SB5A884GpQSUEk43Ao3L3dVo0/v0iKVxy
 5z8GUsRc+1ZcelTkOdypScjKww8YxmjY+XxHTAwjbn+B2/ZgncTBzQG2GWAUXlLaf1RI2R
 4c2Vqad7CBZuwjFsaJTldxfgtimvDulhlKePWAlPLa5haHfLxa7LeWr2vtXw79ip3OY9WW
 Z/S6t0p03PSwI1koithS1pEpFhv7OhLv4lZeYTlR57q/hW3cBWcjG6+NLhA5PlOcd+mJSZ
 /lB85gMvAmPffn1tPLS9IWKOA75N2phi7Rn8psYm23YaicjlbLKn88Gl/k0V3Q==
Message-ID: <977d80bd-f9e3-471a-97f6-8f93bd3bd354@bootlin.com>
Date: Wed, 25 Nov 2026 09:26:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] soc: synaptics: add sl2610 system controller
 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>, David Lechner
 <dlechner@baylibre.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-4-9e3b28c77cda@bootlin.com>
 <20261124183030.GW3176972@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261124183030.GW3176972@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[removed Guodong Xu as email is failing]

Le 24/11/2026 à 19:30, Tom Rini a écrit :
> On Mon, Nov 23, 2026 at 03:22:03PM +0100, Richard Genoud (Synaptics) wrote:
> 
>> Introduce Synaptics sl2610 family system controller driver.
>>
>> The code is based on Linux driver by Jisheng Zhang:
>> https://lore.kernel.org/lkml/20261115102401.3520-1-jszhang@kernel.org/
>>
>> Creates and binds the clock, reset and pin controller platform devices
>> implemented by each SL2610 system control block.
>> The platform device driver gets the block id (muc, soc, avio or cpu) as
>> argument to select the appropriate private data.
>>
>> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
>> ---
>>   drivers/soc/Kconfig                   |   1 +
>>   drivers/soc/Makefile                  |   1 +
>>   drivers/soc/synaptics/Kconfig         |  11 ++++
>>   drivers/soc/synaptics/Makefile        |   2 +
>>   drivers/soc/synaptics/sl2610-syscon.c | 118 ++++++++++++++++++++++++++++++++++
>>   include/soc/synaptics/sl2610-syscon.h |  23 +++++++
>>   6 files changed, 156 insertions(+)
>>
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 8ef408d9ba1b..0d5990cdc381 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -50,6 +50,7 @@ config SOC_XILINX_VERSAL_NET
>>   
>>   source "drivers/soc/qcom/Kconfig"
>>   source "drivers/soc/samsung/Kconfig"
>> +source "drivers/soc/synaptics/Kconfig"
>>   source "drivers/soc/ti/Kconfig"
>>   
>>   endmenu
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 00e6a5ac8e2b..de28c93160d5 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -5,6 +5,7 @@
>>   obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
>>   obj-$(CONFIG_SOC_QCOM) += qcom/
>>   obj-$(CONFIG_SOC_SAMSUNG) += samsung/
>> +obj-$(CONFIG_SYNAPTICS_SL2619) += synaptics/
> 
> This should be key'd off of SOC_SL2610_SYSCON instead.
> 
Indeed.
Thanks!

