Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E431FD73E87
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 19:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E24184082;
	Thu, 29 Jan 2026 20:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YgLsneuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4773D8063E; Thu, 29 Jan 2026 20:21:42 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 176838063E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 20:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C219860126;
 Thu, 29 Jan 2026 19:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD271C2BC87;
 Thu, 29 Jan 2026 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769714498;
 bh=tN9MIaIkXeZAC3q/Z/hBdJIAvkGhl2YK+fxSG1j6q7o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YgLsneuVcM4FO4uOXE49Jjh4qXFrOs4wsvB7gBSNVskpZ8nDUaR8GLznUJhd8x40g
 gnJsD0QPYmGjzLVOjDnmfPLb50KWexmI2lokVuTOAdT64wzicV8JgACYKX3d+SUr1R
 P6q4h9jTIs5f4g8Phi6SQyjgWn3WuBk+Li5PgAb3aX05wvIB9IOPTrT8+uxDADSpFo
 l2ey7bPYVc4wGFthiHhENhQS5YuOI5AfbnOXUBhVXKnaivqzFwYXaw5k8CVWTnTbwK
 aL5re6WR8Nq2WTMliMvR1UENNW7Euwnz7HHKKX7XBDbXCB0WOOwO7TiZeQYQ7NOs7S
 8QIYNlaRpPqMQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
In-Reply-To: <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
 <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
Date: Thu, 29 Jan 2026 20:21:35 +0100
Message-ID: <87o6mcmdhc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jan 29, 2026 at 17:33, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:
>
> Hi,
>
>> +++ b/lib/gunzip.c
>> @@ -8,6 +8,7 @@
>>   #include <command.h>
>>   #include <console.h>
>>   #include <div64.h>
>> +#include <env.h>
>>   #include <gzip.h>
>>   #include <image.h>
>>   #include <malloc.h>
>
> This is part of
>
> gunzip: Implement chunked decompression
>
> so clearly I should move that part here already.
>
>> Maybe this should be included conditionally depending on the command
>> being enabled or not?
> Why conditionally ?

Tom seems to have chimed in already but code size was one of them.
Other reason was that it seems weird to have library code (that should
not have too many dependencies) depend on environment (which is
optional).
Especially if it's just for test cases.

I see from the thread that this will be dropped for v2 so no longer need
to debate about this :)
