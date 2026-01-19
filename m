Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8EFCCF2E0
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 12:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489C683015;
	Mon, 19 Jan 2026 13:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GAJdrwXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD39C8313B; Mon, 19 Jan 2026 13:23:59 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2001800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61E296014E;
 Mon, 19 Jan 2026 12:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DE9C116C6;
 Mon, 19 Jan 2026 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768825436;
 bh=Rb03mdJW8zHvAOK0Xtlr/PjSzFdOqv86Bx4YXS+cYgE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GAJdrwXIoUY2VH7HhR00Lf92nWSHdZFlS2wzYzwmJ2hjMEfoyov7HxqzKdV9QYSlK
 nIyhKNjolPxuthy6CUfxHsSvBQaFs7u5+vjGlAgKOTkQ0fpuDRSNoBMe1XsUfYXvmg
 5PgK0osrhOUNtyssuDmJYwC8KceepWfjCUDudUC8SHobhP0UHZDmMvb8n+aGAZ5q5x
 QpSPtzXvRC7uGVZ1bptMFw629qiRH+nnOmrED4pqKi9EkcJTEdpTy1AWHTcFPizXlO
 3yvx/TZrI609EM5F5DfEdZqw8ibE/DyorSzN4WM6X9PjLqN5rbFh0+frDqffdtUUzC
 g/23YgltFnErA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Kaustabh
 Chakraborty <kauschluss@disroot.org>, Jonas Karlman <jonas@kwiboo.se>, Sam
 Protsenko <semen.protsenko@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 2/3] usb: dwc3-generic: support Qualcomm flattened DT
In-Reply-To: <2d495261-ddf2-411f-a3af-7e051917da4b@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
 <873447fcyf.fsf@kernel.org>
 <2d495261-ddf2-411f-a3af-7e051917da4b@linaro.org>
Date: Mon, 19 Jan 2026 13:23:53 +0100
Message-ID: <87jyxdvlie.fsf@kernel.org>
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


On Fri, Jan 16, 2026 at 18:54, Casey Connolly <casey.connolly@linaro.org> wrote:

> Hi Mattijs,
>
> On 1/15/26 10:21, Mattijs Korpershoek wrote:
>> Hi Casey,
>> 
>> Thank you for the patch.
>> 
>> On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>> 
>>> Qualcomm devicetrees are moving away from having a glue node with dwc3
>>> as a subnode and now may just have a single flattened node.
>> 
>> In the commit message, could you provide a link to an example dt who has
>> this single flattened node?
>
> Sorry I just saw this after posting v2... You can grep for the new 

No worries.

> compatible string in upstream DT, sc7280, sm8650 and a few other 
> platforms are already switched over, eventually all the used/maintained 
> platforms will get switched over I suspect.

Thanks for the hints. That's good enough for me!

>
>> 
>>>
