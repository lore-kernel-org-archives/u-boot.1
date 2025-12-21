Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF45D68BD5
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 07:24:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C423283700;
	Sun, 21 Dec 2025 08:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="LyWNb8th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331EF83885; Sun, 21 Dec 2025 08:24:13 +0100 (CET)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AB5B836A3
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 08:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1766301850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGMZuCRZmNBxA/QCyTedLYLXWWfeuRcX842Hseppwuo=;
 b=LyWNb8thJ4IfbB6D9b6LP+8gm66gHKPAEeHeoafwPXvAK0TET72r0v4tWZLLTVFeb80Q71
 6Jnn0sO8t+wBiQzFWxJQyKCm+TxRlxWsTRRC0S12fBkwo2RgsuIvm8Kifg/XGWKiThzZVF
 tDxf9B49mLF6P52TD5i+OrNQmHVUgCE=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown>
 [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 923a423b
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 21 Dec 2025 07:24:09 +0000 (UTC)
Message-ID: <5e4d3a2f-3576-404e-9637-7372e7a5b824@kernel-space.org>
Date: Sun, 21 Dec 2025 08:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
To: Daniel Palmer <daniel@0x0f.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, trini@konsulko.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
 <CAFr9PXmwBpQW60jZDFf+iqCaSbW4z25=OMN5XXBkBMH5AW-t_A@mail.gmail.com>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <CAFr9PXmwBpQW60jZDFf+iqCaSbW4z25=OMN5XXBkBMH5AW-t_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 12/21/25 05:53, Daniel Palmer wrote:
> Hi Kuan-Wei
>
> On Fri, 19 Dec 2025 at 04:06, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>> Add support for the Motorola 68040 architecture. Currently, m68k
>> support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
>> Introduce the necessary infrastructure to support the classic M680x0
>> series, specifically targeting the M68040 as emulated by QEMU.
> For all of this: It really needs to be split into the bits for all
> classic 68K and then the supplemental bits for 040 (basically the
> cache stuff that you only have stubs for).
> That way if your parts get merged I can rework my support for 000, 030
> etc on top of that.
>
> Cheers,
> Daniel

Looks good to me, even if i can't test any of them here.

Angelo

