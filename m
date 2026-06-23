Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6068CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B32849EE;
	Tue, 23 Jun 2026 15:16:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yOAuzt1W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NBLHE5XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69BE849F7; Tue, 23 Jun 2026 15:16:26 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9228849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gl5Dm13KTz9v1D;
 Tue, 23 Jun 2026 15:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782220584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ea9wLciiyAFq92zol9BoN1JINMLsdu1yYuFfG34BIM=;
 b=yOAuzt1WS8Na7VBKVp4jfoH0DsBUaPcpL/0MPE0mg3qWV22uvBvSqakvwii0fK1BRtg4BB
 aeixWNCCu9pruo0fEurs12F45M/ZLuzZ7bXTjv4vKoR42OQ8pa3GJkcYPE/9uRUEniGJMa
 JJHegjfcC73MVpPB3HpOH4eyLdd3+SPal1gzeChOFmTfMCefZlUSY/2dbn27ow8mQ77chu
 JFDyYYsado8cpj6Rn3l29Pj59XyZqcuXvOwhMPaL8YnUhf+VOfYy352r/vMrLJeE2CKRSD
 K0NXRryVqKoxStSLjeZMy2RU0AP/2EdIjfZp5hvqBvIx4sFRzR5y0A+PTrUsrw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=NBLHE5XW;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <7a74ad03-e180-4ae1-955e-3bab54d3342f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782220582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ea9wLciiyAFq92zol9BoN1JINMLsdu1yYuFfG34BIM=;
 b=NBLHE5XWE6OiORFY/WiTJQg8XwUGwsc5PCPVvYzvDZH6l73t/GRlIXhnbmTJ6ruMuhh8VE
 hguAk6MVbGKFVEMc7uF/cSVnYMn1PL+W1/fuTm7HMx89TPfNy9ePTE5OM7LtSPl8YE2Tyv
 lYYFzyZuOOkvfCOVyKL5aG2cskQGr66thMzJIDGhbRWOIIKWyKJ+8Oe93Cg+JY0Gmfvwyb
 VbdO4szi+VLdjKKD/naT1IuJjSwLMnxQc+Gk1vLxNZeADLdnyLxolJcjSdJKrYBTiOl5ez
 doeefn6Uxc31/RBY4lN1oeJHh5axmDpP993zgyLcYZ1LI+Kazqf48DB8vwPDHA==
Date: Tue, 23 Jun 2026 15:16:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/7] Relocate U-Boot in the last bank
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu, u-boot@lists.denx.de
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
 <849b2c49-9d92-4c5e-be0c-97091f070918@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <849b2c49-9d92-4c5e-be0c-97091f070918@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d235a62670ff735b724
X-MBO-RS-META: ybuzgt89pegkkxfkg4u7k5eykboekzwt
X-Rspamd-Queue-Id: 4gl5Dm13KTz9v1D
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

On 6/23/26 3:13 PM, Christophe Leroy (CS GROUP) wrote:

Hello Christophe,

> Le 17/06/2026 à 09:48, Ilias Apalodimas a écrit :
>> Hi all, this is v7 of [1][2][3][4][5][6]!
>>
>> There was a discussion recently on the mailing lists regarding our
>> management of memory above ram_top [0]. The tl;dr is that we have two 
>> problems.
>>
>> The first one is that U-Boot always relocates to the top of the first 
>> available
>> bank unless there's special board code to sidestep that. The second is 
>> we don't
>> successfully deal with devices that can only do 32-bit DMA.
>>
>> This patch series deals with the first problem by adding a Kconfig option
>> allowing platforms to relocate to the top of the last discovered bank.
>>
>> It's worth noting that this is easily testable with QEMU
> 
> Following discussion on patch 1/7 in v5, I boot tested this v7 series on 
> one of my powerpc boards. It could start Linux kernel v7.0 without any 
> problem.
> 
> FWIW,
> 
> Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
That is really nice, thank you.

Which PPC board did you use ?
