Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85617C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EA5879A0;
	Mon, 29 Jan 2024 14:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JfCUC2II";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NW32z6AC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A46B87CDD; Mon, 29 Jan 2024 14:27:46 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690D28798B
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNpy71W5Nz9smn;
 Mon, 29 Jan 2024 14:27:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706534863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yw5IlaLt7kispchsghzeBWPui5/GcbKrsU7SwBN79g=;
 b=JfCUC2IIGcAYiKAvpLPfuo/j+/60gB7IoCGD6WIG3yqWAenvMBEMwIHFDsGZ7fm7xc9l6V
 kjHcyPHfha7OCdmqOFF5LNR53NXv5HZE1Ga5eF3nAiO5Hz/Bwm+oo8Owi9CeBTAiTGqh2U
 k37SIELEciwFwt4v2ayRwytDCNfIOuInjXBttrdV4caUu0kCIw5pidLLxIE5/ibntxgpQL
 31BxwAiRmk2L4g+MAszR/1wlJt/mTI4z0k0110pc3cjzLTQAIrkPdGBou8MxXb6yEN8H4K
 tBRO9mE7ED5cZWz7zNtEI7JqMFAEl7pj1pXj19p83oY8AgG9of5Shb8Jmlcrcg==
Message-ID: <aa6740c9-4568-4469-9790-635d68a08473@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706534861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yw5IlaLt7kispchsghzeBWPui5/GcbKrsU7SwBN79g=;
 b=NW32z6ACZ8qQni2Jmi8W2CO4/UWMOdLqGerLN/v54tHQsM+wb2jniALfYezdBsDGNgqN88
 zrzmqMsaGkV2Mtc5oUNBKwubBSceNCencF5yHS2uk7Sxt8FjKI2T/13Bjm+GDr7yX6N5zu
 NjDnIGnpY8xYmTU2XGNBrtClA9a6ZcbfcDnm7avXk9uHFx27EdwkvHBsJ2SwDLWcRyNgJf
 4wKnev/okRrHGkBf5RBKUJglfey4FvkpOxMLff0FT99pXdRsI7fC87ODIJMGwpN0UoxBF4
 lE/6t8sP0pMk1u/yuMpJ4f2ihKuZqXZ78usMI2+olRcSuAgH82rOgxtomy9i4Q==
Date: Mon, 29 Jan 2024 14:27:38 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/11] mtd: spi: renesas: Add R8A779H0 V4M support
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
References: <20240128155458.56712-1-marek.vasut+renesas@mailbox.org>
 <20240128155458.56712-7-marek.vasut+renesas@mailbox.org>
 <CAMty3ZA7sEks59cdQhHCZR+R8fSxHdAtgHUupem=X61KDUALSA@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAMty3ZA7sEks59cdQhHCZR+R8fSxHdAtgHUupem=X61KDUALSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xcdr8pc68masne5wxcwf5rtn5ryraod6
X-MBO-RS-ID: c9fbde2dd9a97ab1572
X-Rspamd-Queue-Id: 4TNpy71W5Nz9smn
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

On 1/29/24 12:52, Jagan Teki wrote:
> On Sun, Jan 28, 2024 at 9:25 PM Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> From: Hai Pham <hai.pham.ud@renesas.com>
>>
>> Support RPC SPI on R8A779H0 V4M SoC.
>>
>> Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
>> ---
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
> 
> Applied to u-boot-spi/master

I don't think this will build without 06/11 macro addition, so I'll pull 
this via u-boot-sh tree if that's OK with you ?

I could use a RB though .
