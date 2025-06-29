Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DF7C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 20:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01F3682F4E;
	Sun, 29 Jun 2025 22:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FsuDqGoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D73582F6A; Sun, 29 Jun 2025 22:08:49 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EC282ED0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 22:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bVgNB2Ngrz9srp;
 Sun, 29 Jun 2025 22:08:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751227722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LATyC7JeMakEo4tNszjvqMeJ5k6SmlijeyKlIndIqE=;
 b=FsuDqGoC9zfK7Vnlk5Qx6SIra41Fm8RPI2fBHL7WVUEKWuUBe19LGKR6XmcQQdEbktr6FV
 v8wu0KUq3tBFjjVhMqK21gVxplwOhHBQVFDmYIGXyxyHkeYTvzgFGT1XsIZAqOBHdmE5bn
 1wwurcnXt2Tsyi4XXHBQSa4+QW2Y1vi+TejwaAGzKC6fouyFPl8xap2DQYjOk7Vq6PHEqc
 lxEUpA5O7JocHFMf9KHQ3wt120/ersZXkwpb+7PLHcrNrwZkzBHogmMW2Clkw7npZ+kHMp
 9uG6PpGPXlAJXTWN+OD8EOvi1H1mTx2mnDeoVaITQKW+DYe7doDgPNqMojDLMg==
Message-ID: <4c1d60c4-26fb-40eb-9855-56ca91776acb@mailbox.org>
Date: Sun, 29 Jun 2025 22:08:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 09/10] ARM: dts: stm32: Add SPL specifics for DH
 STM32MP13xx DHCOR DHSBC
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-10-marek.vasut@mailbox.org>
 <89a5867f-996f-42e7-9e0e-544bec2fe457@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <89a5867f-996f-42e7-9e0e-544bec2fe457@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c1b805d3a5b68a34aff
X-MBO-RS-META: ezwzuf36bwxwpum4ud4gabyegfy5sabu
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

On 6/3/25 4:36 PM, Patrick DELAUNAY wrote:

Hi,

>> +&etzpc {
>> +    compatible = "simple-bus";
>> +};
>> +
> 
> change the compatible is not not needed I think
> 
> if the ETZPC driver was not compiled for SPL
> 
> today it is compiled
> 
>   ./arch/arm/mach-stm32mp/stm32mp1/etzpc.c
> 
> ./arch/arm/mach-stm32mp/stm32mp1/Makefile:7:obj-y += etzpc.o

I need to be able to bind devices on the etzpc bus, so it really has to 
be a simple-bus .
