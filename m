Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DA9CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 14:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81F3846A4;
	Thu, 21 May 2026 16:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TK/Sal4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D15F1846A7; Thu, 21 May 2026 16:08:52 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BA5844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 742071A364F;
 Thu, 21 May 2026 14:08:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 460C960495;
 Thu, 21 May 2026 14:08:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 56D22107E81AD; 
 Thu, 21 May 2026 16:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779372529; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=xUiTrZBwDePKPF/exo50wkI5Xwu0BnENYrtEmw4y1Ak=;
 b=TK/Sal4aDA0miSub5uOOvlb4R0Ozoihzg6VfPRW39xOqn9GPY43EbTd050Tf9MC+SeKgfc
 wP59M9B1w1FCSNhv9CtR6NzmnyICLp26w4NWhIqjMUzVLPGFxUMAvYHYxCeouDaAnIl05o
 SLkzgnmyHk18SsmigrmJQWuJNpJVcO5xeCbLjQy+ZcYAazxJEjqf5+ae/jvjVh0INnOTIp
 QvrZ469zjlkqZVJvhyW8gyty2s7HEi5GQ2DOA42wXrwA7zKfQY9y/QaqRZX1g3c/hzpola
 2c22GEo6jCCIKkQUKPGqQ/3n/bK38VSz5c5OBLSSBe898c5v2OyzfN7APA1Vrw==
Message-ID: <a69e559e-9271-4859-9841-e1d991121693@bootlin.com>
Date: Thu, 21 May 2026 16:08:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-12-richard.genoud@bootlin.com>
 <7d8e528e-0b17-4e30-987f-059476da263d@ti.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <7d8e528e-0b17-4e30-987f-059476da263d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 11/05/2026 à 12:52, Kumar, Udit a écrit :
> 
> 
> On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
>> +	
> [..]if (ret)
>> +		return;
>> +	save_addr = (unsigned long)mem_addr_lpm.context_save_addr;
>> +	ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, save_addr,
>> +						mem_addr_lpm.size);
>> +	if (ret)
>> +		pr_err("TIFS lpm save addr fail\n");
> 
> please check firmware capability instead of sending it w/o any check

as the DM is not yet loaded, checking the capabilities failed with
Failed to query DM firmware capability -110
Are you thinking of another way to check for TISCI_MSG_LPM_SAVE_ADDR 
availability?

Regards,
Richard
