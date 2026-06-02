Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF03FCD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 14:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DC184855;
	Tue,  2 Jun 2026 16:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OdJ9Tubm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 874E28485F; Tue,  2 Jun 2026 16:47:31 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA55880433
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 16:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gVDFX3VQsz9sc0;
 Tue,  2 Jun 2026 16:47:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780411648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pdM3yxNio7FXyvz3HPISz/2LGAyMesRW8dzBlKv52A=;
 b=OdJ9TubmyQzDI/8pA+k0DscpP9qlb/P3Ke1OuL+6x0i+HUBeoLoobo+bqBKmnpZUmJRQP+
 6SxIoWFy9QIDPGJ7QMc1o5RZeOkL5FDTUhZsx+d9n9IyfAHldA07A6QVwyuECqJtsFdCHp
 WYAcslc3IJ7f/FCpZvWEqVpzchMbWR9k983UdyXslV/t1N+ord6to4ATG+huhFiIkiaRg8
 tGKYzpMgd7QWokiP8bod1uQ7AtK9SHrPjnYR1vBx1pXBeXeh0EVpi4h+8BoHj72jaGgzJU
 qsUAHw2fMHcaq7UJ0q0Csg3EYpvRYlHSZsEV8G7+YNmbgbYKZYlDyyGd0h8BqQ==
Message-ID: <32f2a805-1c38-40d4-b29b-c8ee353fb6d0@mailbox.org>
Date: Tue, 2 Jun 2026 16:47:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] NBX10G: Marvell Armada 8040 Nodebox 10G board
 support
To: Tom Rini <trini@konsulko.com>
Cc: Vincent Jardin <vjardin@free.fr>, u-boot@lists.denx.de
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr> <ahmrSI5Hf7r1moV-@L30177.local>
 <1d168901-eeb0-48d6-a5af-5f7538230214@mailbox.org>
 <20260602143617.GM627328@bill-the-cat>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260602143617.GM627328@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7ffd3561ba0f2aacc62
X-MBO-RS-META: eukaq68fpb7sa91z39ff6rt67xrs78id
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

On 6/2/26 16:36, Tom Rini wrote:
> On Tue, Jun 02, 2026 at 04:17:16PM +0200, Stefan Roese wrote:
>> Hi Vincent,
>> Hi Tom,
>>
>> On 5/29/26 17:05, Vincent Jardin wrote:
>>> Hi Tom, Stefan,
>>>
>>> It is a gentle ping on this v3 NBX10G serie. All 5 have Reviewed-by: from Stefan.
>>>
>>> However the Marvell custodian tree (u-boot-marvell.git) hasn't moved since
>>> October 2025, and I see no recent (git pull) from Stefan in the archive.
>>> Could you apply the series directly to denx/master with Stefan's R-b ?
>>>
>>> Or, Stefan, if you'd prefer to handle this through your tree, let me know
>>> what timing works for you. What else would you need from me for this serie ?
>>
>> I was pretty busy with other stuff lately, sorry. But will catch up on
>> the U-Boot custodian work soon.
>>
>> Tom, question to you: Since we're at rc3 already in the release cycle,
>> is a pull request with marvell & watchdog related patches still okay? Or
>> should I wait for the -next branch to open?
> 
> At this point I would prefer a PR against the master branch which is
> only fixes, and a PR against the next branch for new features / board /
> etc. Thanks!

Understood. And will do.

Thanks,
Stefan

