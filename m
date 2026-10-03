Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC22CCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 10:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6A0160F03;
	Sat,  3 Oct 2026 10:14:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8S04vjAN4Xo8; Sat,  3 Oct 2026 10:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E649960EF8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791022485;
	b=RBJJSz2vdYpP4wWGEqeHOO7RI2ab+ldVqlL/W1XiHbljKKuH2vxEQp/KsGhtANNviuhh
	 lAsUyFiS+IxTTEzEeDO/9CaTTg/tIlpNa9Fbv/6mQTh/ZXvFs8HIV/rMD9BvBoIy9zvXY
	 ewzn1/xsHwIFuJLG+pF39cwxtZgtDqlmhfJUmkVOgNSrocQStUhx3kBemr/gf8fClN8T+
	 a29dEh6Az0Q+tOAXZnctBBDecNhcW7p8wqq/5eM/ojblOZ8j5X0Rwyeuv8Hz7MhWLXO4n
	 Hy9ZOJ21DCeEFe4OBptAQl/KTzuuTcX/OrchI2LfaKuWvThddXyI4OEsO61UV2PODTw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791022485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2VmWHvOJq3ei+FZj9fYa920sLoHkcpKfJwXQkSPQhUg=;
	b=TqN17CAMGk9r+9mtcQOI9Jtph6//E7tGFpz1uFdJ+QElNOhXLZcliRpnDQwMf9EuzzgA
	 ZZUu0AnyUfHvcGdsSuSpGC2fe5BpAgYUnKeaOr0T6t0OMHSa46L42V4zHLaPM5PP3ogRH
	 /4AsYJ/U3FK2LmiJqVCqPg/0tCdKBFePsPBj3ftAyZctg3cbFhoLy41v2CzqmkkytDFFu
	 Z6GzQF5C7bhWBQqNxjJOSLvoP8dp2KRFfcfY3vZAGDiwpgTOtsuNgsR47KGk/fbRP5gvG
	 1yUfBBU6TYBePYFc8D6Ixe0s5Tj/nYAD4ZAWnq+fLLlZJrvDn7zFC4DZLeEYFGLvOyw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791022485;
	bh=2VmWHvOJq3ei+FZj9fYa920sLoHkcpKfJwXQkSPQhUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CSVF+iCb5S16LPzPen7Gzo7yyMIfG2v28FRAUGEpNXy+iRR6yX8pTxvYrkl/z3MkX
	 /m8rlSrjg0lWV+HkKxKGbA4W3WjQW3rx8WtTZOcI0pYzfagl1HZtmSEyH6xzEfYu06
	 7N2sB5mtZb9ufw9yCLRfYZ3fIZcRBJKft1NrdySFe3QXUWkt7R2Uw0LLaC39GHYx+0
	 ec04dug70QgGXkh6aC8ow8T8oqU74jlGt/URpZsJNs/xQ0ud+maOl4jzbAdPnLINgU
	 4t2x1plNt/pHzQCEzL0xz7EDGzS0bHQPa/I0x7D6b7sPnx9EJcr4UxTs868j/rOAFU
	 mFYDW2tgUc0zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E649960EF8;
	Sat,  3 Oct 2026 10:14:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B37E2335
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99C0581102
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:14:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jI1KmXFUDTQi for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 10:14:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DA8BF80F6D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791022471;
 b=tGOQ5MzArz3K5tj7cnlO6i2JbWR4B0wBq+xB96e2RoeUuB24iSol3XCkSdZHhxT3fPBL
 y7OQay21c+DzB/HAaitHwH8Tyr8ehoBdyeuvpyWqOzff5gbLhLrLNz/eG7MLjnTnoSy7L
 WwmbTv1kH+5E9+Ym4AxyvxwbyOF5bbeCY3OT/nOjdQx4409GKsc7q36ldfAmLfRr7uGQx
 5AMGBwYbhSUdPqR8L3AQ2q3HUlGUPZHwfFjznbf9xcGnee4Dh8hV51siQa4SyAcq9vzlI
 5QUdEzhTHiU3uEW+/tfbIxrMoReQMxajpDaGN2lmeA62UYAH+a1icTARRvc492X9OyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791022471;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=2VmWHvOJq3ei+FZj9fYa920sLoHkcpKfJwXQkSPQhUg=;
 b=me8JA29LsoWAqje7Pw6g2OOy3p0JQEzhRysMntl4rINZdYBkpf3QP0ynvLDye17C9yNA
 PJz55v0qVxYKVNAx1kTqIYalpdDePx+xSoJJzP1PxvBHOd/HRZsRm8hdqmfLmKV9FPnKU
 nAc30SbVIfRBi7ukVE1u2seG8hlIh24ZFEPWmFC3bAchYaAoCh2C6fKC1daDlZgqYo2yt
 K5HV3xjdLadajvPCoAnJYOd2X6QenqLrSYUINdvs2ahrdWkvLm3qvkt0SCNaU72xh8Y6o
 NlfvBkumtxc18xu+CeS5avvs8QZQNiA6atLCHKiWwNDqdPayPf5kiwqGXTOD+ptgIrQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gvtnl7+I; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gvtnl7+I
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA8BF80F6D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 10:14:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C472D40A76;
 Sat,  3 Oct 2026 10:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB281F0089B;
 Sat,  3 Oct 2026 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791022469;
 bh=2VmWHvOJq3ei+FZj9fYa920sLoHkcpKfJwXQkSPQhUg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gvtnl7+ID5OzDiQAIC9c7uebK8LX7jl+75bgE/AWzyTexA9t1pz/zI4wPUHGp0O/9
 mHlm1mFGeXl2+ZhTyytXJxpOapZt/MdOMMq+0M8gfi11zqPFt20Kzel6nXbwBQB03X
 /qlPiM96cb+ljXtZHWzKphQW3a3Wn6gsScWwheDU2tEh6BhRognu+RrDbQ4GVIjWiK
 BOd455i7+M4yYLChaE4FwDud8lx9sai6ODWFRxAXovn9vCyu3kpf6NeRxJvrw7Y7V1
 tsi3pOokXJl1r4FJB88+HwbYfR2n8bi6HCBZWucESwM4zmNoRbWGYnS+iQeRRQA1VS
 Ly8it/j1edRdg==
Date: Sat, 3 Oct 2026 10:14:27 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Hiago De Franco <hfranco@baylibre.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH v3 2/4] riscv: dts: spacemit: k3: add binman node
Message-ID: <20261003101427-GKA68132@kernel.org>
References: <20261003-00-basic-spacemit-k3-v3-0-dea68cd1bd7d@kernel.org>
 <20261003-00-basic-spacemit-k3-v3-2-dea68cd1bd7d@kernel.org>
 <2dcd6f21-ea10-4986-ae3c-fb81f5d768a4@freeshell.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dcd6f21-ea10-4986-ae3c-fb81f5d768a4@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi E Shattow,

Thanks for the suggestion

On 00:49 Sat 03 Oct     , E Shattow wrote:
> On 10/2/26 17:34, Yixun Lan wrote:
> > SpacemiT K3 follow the standard riscv binman layout, which has opensbi
> > and U-Boot proper, so include the common binman dtsi file.
> > 
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> >  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..f1c1c3ee6fd
> > --- /dev/null
> > +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> > +/*
> > + * Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
> > + */
> > +
> > +#include "binman.dtsi"
> > 
> 
> Looks good to me. I suggest to introduce spacemit-k3-binman.dtsi now or
> later, may as well do it now?
> 
Yes, I thought about this as we introduced new SpacemiT image format..
I have no objection to do it now in this series

> See for example of how this looks in files
> starfive-visionfive2-binman.dtsi and starfive-visionfive2-u-boot.dtsi,
> it would be as follows:
> 
> arch/riscv/dts/spacemit-k3-binman.dtsi:
> ...copyright comment...
> +#include "binman.dtsi"
> +
> +
> 
> arch/riscv/dts/spacemit-k3-u-boot.dtsi:
> ...copyright comment...
> -#include "binman.dtsi"
> +
> +
> +#include "spacemit-k3-binman.dtsi"
> 
> With that,
> 
> Reviewed-by: E Shattow <e@freeshell.de>

-- 
Yixun Lan (dlan)
