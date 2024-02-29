Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EE5C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 20:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE79C87763;
	Thu, 29 Feb 2024 21:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Q7ENptWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED7B879A2; Thu, 29 Feb 2024 21:02:25 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FB0D876D3
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 21:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709236943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsZDgX8mwXb1U0uB/vMpMgTuO57dqATqY6P10BYmnZI=;
 b=Q7ENptWYXJvhrSf+aTFSTH1vxNSPkKVQz/ZQffjkGvjkDwepp93/VWBR3ef+6jZyKgJ2IG
 EDvWw5LgJTlrjzv5YmdEULEWy7xXN40GbXDvJiVngpSpGHn8eGWZUOV/n4MrXqQipSLNjy
 NSVe/ZM+NXEJTtMYa9DpSk4gfvixhqSka5h5DSPPXzpmrJScB4ghVm6BNqaEi57B4NFbs7
 TzIKVAFN/O+YWq9CAK2bZPRyFUwuGxH7CbgduF00Ow+cfzYo6IGTJgUqpBLHSaDHs9m6ZL
 YJLhnbYrezs1jhq9w242IfxVCe9hc6sDTKPkFMrgoN2N/Ygu5xY+O/lGULho+w==
Date: Thu, 29 Feb 2024 21:02:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, martin@geanix.com, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH v2] scripts: dtc-version: Don't show error messages
In-Reply-To: <457ee2e80fa3092d7da9d1c69b24a5e7@manjaro.org>
References: <5ece6e37de9321ad1c2e089659cbd80355181c4a.1707217112.git.dsimic@manjaro.org>
 <3baedbe13804025441547b23949bede9@manjaro.org>
 <20240215131302.GA3040305@bill-the-cat>
 <457ee2e80fa3092d7da9d1c69b24a5e7@manjaro.org>
Message-ID: <7332087556140347d2e2ea342141b035@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-15 15:21, Dragan Simic wrote:
> On 2024-02-15 14:13, Tom Rini wrote:
>> On Wed, Feb 14, 2024 at 04:48:52AM +0100, Dragan Simic wrote:
>>> On 2024-02-06 12:00, Dragan Simic wrote:
>>> > Prevent the error messages produced by which(1), such as the one quoted
>>> > below, from being visible in the build outputs.
>>> >
>>> >     which: no dtc in (./scripts/dtc)
>>> >
>>> > This makes the build outputs look a tiny bit cleaner.
>>> 
>>> Just checking, is there something that prevents this patch from
>>> becoming merged?
>> 
>> I'll probably take this once the merge window opens, thanks.
> 
> Great, thanks!

Just a small reminder about, possibly, picking this up for -next.
