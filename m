Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC1FED9F6
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 17:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A691D84201;
	Tue, 17 Mar 2026 18:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vK1w5j8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D97DA8421D; Tue, 17 Mar 2026 18:24:07 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F5B84137
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fZzMj5D48z9tgJ;
 Tue, 17 Mar 2026 18:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773768242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeP9GJugtFRNg21eot+WAjERADM1XP4AfY4d2g2Hluw=;
 b=vK1w5j8WjkfJYDvxDpZhtpucj55T00VquYW3WyAVnqGF2PYf97dfQg5FK0mqs69fTbJdTS
 8nn1ruVhvzopzwf7z0uYK6yHK10Eic7qR/0dmU2Uz/DfFipf71+R+oWtXvWch2/Fur1pYb
 xlWZOZTkethkwygJ2JSW4SzgODM37vkqxtqxGMMj1nOIfyzeckBzw6E+bdZvbffBWK9a8h
 Fzfjv47Sr+wIyOYr7N6ktxMmiRmMubxBKuT0rN1gPscrbWOBQY78izQn4N2w32bCO68Gy5
 tCItx23anhGjDDYnDtRlN2rqSmmaBLIq5XDjtS7cmP8NtJkAS6wkOXslLmizSA==
Message-ID: <5f3fa5ce-24fa-4f43-b2c3-4382c36d8fbb@mailbox.org>
Date: Tue, 17 Mar 2026 18:23:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>, ilias.apalodimas@linaro.org
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <6AD955F3-6535-41DC-9F1F-B8FD663E7BEC@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <6AD955F3-6535-41DC-9F1F-B8FD663E7BEC@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i1mmap9s75cpjtwqytzhuzuxutw7tju6
X-MBO-RS-ID: e5d4ba22577994480ea
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

On 3/17/26 8:46 AM, Heinrich Schuchardt wrote:
> Am 16. März 2026 00:54:05 MEZ schrieb Marek Vasut <marek.vasut+renesas@mailbox.org>:
>> Introduce new mode of relocation which relocates only data, not code.
>> This is mainly meant to relocate data to read-write portion of the RAM,
>> while the code remains in read-only portion of the RAM from which it is
>> allowed to execute. This split configuration is present on various secure
>> cores.
> 
> Ilias has been working on supporting RX and RW memory areas via the MMU. Isn't this compatible with code relocation?
This is different. First of all, the core has no MMU, it has MPU. But 
the separation of instructions and data is implemented on the bus level, 
it is outside of the MPU.
