Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F3FCD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 11:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB90A848EB;
	Wed, 17 Jun 2026 13:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jjwEnRdh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76B7F8499C; Wed, 17 Jun 2026 13:16:57 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE44084833
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 13:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE7D760120;
 Wed, 17 Jun 2026 11:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D098A1F000E9;
 Wed, 17 Jun 2026 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695013;
 bh=v34W6xEpNBFULF/rVcrI4hMg5AU/Nshuq6+tG/JUY8E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=jjwEnRdhwhi9zIqWqGy2jtiV5C5LoumOTClMjR4FJCXFGGWLNkrxXoPQUDdxE1ygR
 pC14vIGXxoEKcE3hsDRfRAqpEMj3RdlLJ5R69tzGA6JaEVduxoQUsjijdQXFcPc8E/
 IjIkRJHNcr84NBW18hpQ7E8wLGx0qQWGSQ8ewYwXjq3ZsU/tH3Fg4k7/W5wSt7HuSJ
 2u07A53THHgN7GF8g5HQhGAOZtJq0shpTCgs74633ql7DHDZV2Wyv2nnbGdJgpHiZY
 AmiHEo2agR2+fcPqnYbyzTNyiOzm6ttkNFwfmFRKZWaQFDgGWyi15GQ7boFdD9X0c4
 UInmdzoe0YynA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.denx.de, Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH] usb: gadget: dwc2: reset endpoint enabled state on reinit
In-Reply-To: <87a4sth3vt.fsf@kernel.org>
References: <20260616-ums_fix-v1-1-f1f6c903b3fc@foss.st.com>
 <87cxxph6d1.fsf@kernel.org> <87a4sth3vt.fsf@kernel.org>
Date: Wed, 17 Jun 2026 13:16:50 +0200
Message-ID: <877bnxh0wt.fsf@kernel.org>
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

On Wed, Jun 17, 2026 at 12:12, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> On Wed, Jun 17, 2026 at 11:19, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
>>
>> Maybe the commands have a different teardown mechanism.
>
> Some debugging pointed me out to the following patch that's in linux:
> https://lore.kernel.org/r/1635365407-31337-3-git-send-email-quic_wcheng@quicinc.com
>
> I've applied that locally and to me it fixes the issue with UMS.
>
> I'll send it to the list.

https://lore.kernel.org/all/20260617-ums-disconnect-v2-1-6e52d9de1d36@kernel.org/

>
>>
