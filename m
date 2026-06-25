Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923C6CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8DD84704;
	Thu, 25 Jun 2026 09:08:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DYDBT8F7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11196848F0; Thu, 25 Jun 2026 09:08:23 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB7880398
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4F7274E408CB;
 Thu, 25 Jun 2026 07:08:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 20EC35FF03;
 Thu, 25 Jun 2026 07:08:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B795106C84DD; 
 Thu, 25 Jun 2026 09:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782371298; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=XNg24OrSinXHeF0MIjZq4V/gyjYHQFJDr56HtVUALQY=;
 b=DYDBT8F7nEbnGoij0PzLqYztUm7U6H6KV4mF1H36LzZiSxxJ8TBeO4kxqZHZfRbjX+Vjcl
 QVIwJ/tYD3n5upRJM0ftlWo347QlAO5k8+QGtUrIZKaFI2RWmpGOyOPM70RdF4bp3TJ5jz
 s8KC/8oFj1JgzkzUQU6MCEQb9EHHcYjXR0uHCPUtxsXWqZhpiY7NrGDLz8pza9U4YEMJoQ
 /kKarFPn4zrL8JeEwhy3VHm6Ek4DyPL2MPXNdYR9Qto5SBTBtIm8FOmwHeF3/O3UAxeHy4
 J2G9uGpqhNt1gMjrX35z9VwptTMg4uw/wfO9zhSKuhIiIa745UYdAXuPg+tPeg==
Message-ID: <666483d3-0053-4218-9c46-a092dbb029b0@bootlin.com>
Date: Thu, 25 Jun 2026 09:08:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/19] Introduce resume for J7xx SoCs
To: Anshul Dalal <anshuld@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
 <178236663369.80761.5454834032276538887.b4-review@b4>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <178236663369.80761.5454834032276538887.b4-review@b4>
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

Le 25/06/2026 à 07:50, Anshul Dalal a écrit :
> On Wed, 24 Jun 2026 09:44:40 +0200, Richard Genoud (TI) <richard.genoud@bootlin.com> wrote:
>> [...]
>>
>> BEWARE: This series is based on v2026.04 + AM62 LPM series:
>> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
>>
>> It needs lpm_memory_regions described in DTS:
>> https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/
> 
> Hi Richard,
> 
> The series doesn't apply cleanly on next, could you rebase and resend.
Hi Anshul,

Of course, I'll re-send that in a few jiffies.

(NB: you'll also need to apply AM62 LPM series beforehand)

Thanks!
> 
> Thanks
> 

