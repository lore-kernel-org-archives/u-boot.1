Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8EECAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 13:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF2C8004F;
	Thu, 18 Sep 2025 15:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GaZ9K5/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AA18003E; Thu, 18 Sep 2025 15:14:45 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9418004F
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 15:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cSGM35sLXz9sPr;
 Thu, 18 Sep 2025 15:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758201279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9VaWL+/Aj/dopEjF0F/B+BbtOTSrM6DqVM2SZRzn0s=;
 b=GaZ9K5/ozWbbz2sn6kW83rESPRCaWv3BCxBoBkRjyLkWTvO4bAx46j/blPgGAGL3G/pX3b
 H6Vj8oQbIC1laNP4mZMouKDJfZRSWJWI7u7GlDOrx3hTy5B63VRIKZ6x6orodHwrBM0cEG
 LtrRhWOsGkch00cnLadVkX3R77XsWmGiIhfj74eTOR3D9szrttcNyv9VlRpg9Wr5cDbuTt
 Y4WJ95HHYYY4cJvu2BLkgWBoTPAvdcqXleRTMtFRlu4yBvyQNBY3Rs/adQZxX0SUhoTYi5
 Bs/5ok1PHuP6gTA+X0FHE8G5MlFpsA5y/m7IUEBuNxuF25l42963R6ZkaPifqQ==
Message-ID: <b9c28613-dde4-4dca-ad6b-3693488f4c55@mailbox.org>
Date: Thu, 18 Sep 2025 15:14:37 +0200
MIME-Version: 1.0
Subject: Re: RZG2L and DTB blob from TF-A
To: Mathieu Othacehe <othacehe@gnu.org>, Biju Das <biju.das.jz@bp.renesas.com>
Cc: "paul@pbarker.dev" <paul@pbarker.dev>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "anton.reding@landisgyr.com" <anton.reding@landisgyr.com>
References: <87plbqd0kk.fsf@gnu.org>
 <56857fb6-e3d4-4069-afde-57b43c4d2442@mailbox.org>
 <TY3PR01MB11346F452EAE530A0931C9D228614A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <87plbnhqe5.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87plbnhqe5.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b5a1d79790a06c6b614
X-MBO-RS-META: ekz7yp9am836aaaup9mzb7tuuu3o6jax
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

On 9/18/25 2:54 PM, Mathieu Othacehe wrote:

Hello everyone,

>> Also, you need a patch to identify the device and pass it as blob
>> to the mainline u-boot
>>
>> On TF-A:
>> .ep_info.args.arg1 = (uintptr_t)fdt_blob,
>>
>> Also you should fill the memory blob(fdt_blob).
>>
>> Hope you can take over from here.
> 
> Thanks Marek and Biju. The current state is still that people will take
> the forked Renesas TF-A

Why not take mainline TFA ? Maybe there is no TFA for G2L upstream (yet) ?

> , the mainline U-Boot with the
> renesas_rzg2l_smarc_defconfig configuration and expect things to work
> out of the box.
> 
> Currently, before figuring out that the TF-A needs to be patched
> manually, U-Boot is just crashing without outputing anything, which is
> painful to debug.
> 
> As the only RZG2L supported by U-Boot is the r9a07g044l2-smarc, and we
> are not receiving any blob from the TF-A, I think it is fair to assume
> that we are booting from the platform we are compiling U-Boot for.
> 
> I have proposed a patch here:
> https://lists.denx.de/pipermail/u-boot/2025-September/598712.html
I'll reply to the patch.
