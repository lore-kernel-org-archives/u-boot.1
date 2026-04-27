Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA1AFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:27:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D681683AA9;
	Mon, 27 Apr 2026 13:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ADuBtfQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA7B839D9; Mon, 27 Apr 2026 13:26:59 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA2F80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4g41Vm0Ky3z9tk4;
 Mon, 27 Apr 2026 13:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777289216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpQVEx0tAbmKRuz8DEij+3N/1FioQP99JFcaIW+KoDE=;
 b=ADuBtfQz1Bp3YsWvWUJdj/VVmKjyakETJuPyMimJhMfeosHh/npP3FqbcaTBadxRDSAr+2
 nRQT2Q4PJLwVwvb4GZ8aGaAfi++XWOoehw4SiwFAhAPF5J3olBUZwfV5YU8rexCT1Nt4zR
 zUbl9t6f2CZnSKSznjsCXJbkRzgi5GTd6KZABKdazBxi+vCCuMisD2Gf9bNqVHlqeV7dsf
 RzpGxvYCTSwcZsA9hwI88pZz4yeWHbrfDkHvDXna18FTbUeDW1uV9JBTXRJpbt0nNNts/k
 lO7TEPAcG4FYdH06qbKc8EqD/RbMdHdeCS/+nIGkClv4dn+SkDSlgaK7lTytJQ==
Message-ID: <7edd2c18-4f09-42c0-98be-1dfcb23b755b@mailbox.org>
Date: Mon, 27 Apr 2026 12:11:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
 <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jjqtoxdbks1axbhuwijt5gjehcz19bqq
X-MBO-RS-ID: 1d2b5e1663a1643ab6b
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

On 4/27/26 11:13 AM, Quentin Schulz wrote:
> Hi Simon, Marek,
> 
> On 4/22/26 4:31 AM, Simon Glass wrote:
>> When producing a DTB from fdtgrep, there is no way to reserve extra
>> space so that more nodes/properties can be added at runtime without
>> growing totalsize first.
>>
> 
> Ok but why is that an issue? What is the actual usecase? What I'm afraid 
> of is that you pad enough and you hit random bugs because you forget 
> that adding enough properties can now hit the size limit and you forgot 
> to add the logic to resize/grow the fdt when it's too small to fit new 
> properties.
This is needed to prevent fdtgrep from inhibiting this and stripping the 
pad bytes again:

scripts/Makefile.dts:DTC_FLAGS += -p $(CONFIG_SYS_DTC_PAD_BYTES)

That ^ is used by early U-Boot stages in place of 'fdt resize' , it 
provides enough space to add basic modifications to the DT at those stages.
