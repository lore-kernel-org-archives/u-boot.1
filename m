Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCF7D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6014D83A83;
	Mon,  1 Dec 2025 10:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gy9/Y87o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E9E83A8D; Mon,  1 Dec 2025 10:15:22 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A08C83A2B
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D715444A3;
 Mon,  1 Dec 2025 09:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED13C4CEF1;
 Mon,  1 Dec 2025 09:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764580518;
 bh=PLzjRQpN+80jDd61t+0B/NeetgQKLLfNwZS+T3YYfuU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=gy9/Y87oLgzF/KIwWsci01+UBOVGY8Z5sCMeDout14uwU+TyV0PSUW61PiapAzcZe
 K+I4+vtLI65uFU2tNX17Hx+jvMKvmwUz4oawFRcqv2I29/nOypKHSfSyTBaLPv13Xu
 7uHwLddfySo5gEaDm/XM3eBP4mvNJQN+dlcLBgIyS9JeNVIxPKLp5sRhdT9Iijb79T
 IyP61WZYard2qPvdQ43T6dNHVWujmAku4ZAC4aA3LNhtk2Br/KZmbPZnFGBCKUXfG3
 rC10rCpFrPMdzXbFPi9UswCn5xqEnqrhwRqsLvvSx7ynSDaC5RSnrrj2b3FDprGJ89
 JR7zTwjtnlV4Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Petr Benes <petr.benes@ysoft.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michal =?utf-8?B?Vm9rw6HEjQ==?=
 <michal.vokac@ysoft.com>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
In-Reply-To: <45eb3702-466e-4e22-b27d-6710ac765dcb@ysoft.com>
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
 <87fr9zss1e.fsf@kernel.org>
 <6cc1b997-2713-42be-9b0a-dc44db251b06@ysoft.com>
 <87a506sg41.fsf@kernel.org>
 <45eb3702-466e-4e22-b27d-6710ac765dcb@ysoft.com>
Date: Mon, 01 Dec 2025 10:15:15 +0100
Message-ID: <87ms42sgv0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 01, 2025 at 09:20, Petr Benes <petr.benes@ysoft.com> wrote:
>>>
>>> Which are held in (struct ci_drv).ep[] and the problematic code is
>>> ci_udc specific.
>>
>> Ok.
>>
>> I have compared the changes with the linux driver
>> (drivers/usb/chipidea/udc.c) and see a couple of differences in error
>> handling
>>
>> For example, in linux, in ep_disable(), we return -EBUSY instead of 0.
>>
>> 0 seems to tell the caller that we sucesfully disabled an ep but we did
>> not do anything since it was already disabled.
>
> Fair.>
>> Can we do the same error handling as in the linux driver ?
>
> Sure. -EBUSY seems to used mainly by *_register_driver(), I'll test it
> and return with the updated patch.>

Thank you. Please also make sure to look at ep_enable() in linux as a
similar pattern is found in this U-Boot patch.
(we return 0 instead of a negative error code)

>>>
>>>>
>>>>>
>>>>> Moreover, the patch gets rid of possible outstanding requests if the
>>>>> endpoint's state changes to disabled.
>>>>>
>>>>> Signed-off-by: Petr Bene=C5=A1 <petr.benes@ysoft.com>
>>>>> Signed-off-by: Michal Vok=C3=A1=C4=8D <michal.vokac@ysoft.com>
>>>>> ---
