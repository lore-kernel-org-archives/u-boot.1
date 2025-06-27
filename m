Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE304C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 06:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92AB82B34;
	Fri, 27 Jun 2025 08:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jyGDWPvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D9882C65; Fri, 27 Jun 2025 08:43:55 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118C480C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 08:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1D4C8A4AAB3;
 Fri, 27 Jun 2025 06:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E312C4CEE3;
 Fri, 27 Jun 2025 06:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751006629;
 bh=nn72IFD4U0yBJ7MiFHsoOGssIUKv4/P/a8RCtFpNLnU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jyGDWPvAdrdefRrLliK9gBaP8tVlMkBpsDWXfk9RFQnCILQdxVtPXKTjOTfStLuP+
 JIKBiJIUopcNUaBSCpH7RpNGTJyonVsE5/c3AYL1CCuuqI3jmpnVtNy4MXxxf3Kc+y
 1ExCXNDLRSllsDvmPYwrSZEi6ZTsxF7iDVIEY/W9g30u9vGBm9/YTCBiGVnfnPARZT
 tmomoKmoMC7BVMJcesC1ueVNHxBXPHvpfPoCxllSjX0wOgoBVACcxr/ge+X3sST7z2
 dInfGcnIsRQn69gAmmbkGeCu8PNKsrfzHsIAxatY4Qpcqgx/pjLqFylhayHdzNilGn
 SFkyRktnjwkaA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: abootimg: Prevent use of unintialised variable
In-Reply-To: <c5a4f007-0846-42a8-a153-d95cb070dc66@linaro.org>
References: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
 <87wm8zx0mr.fsf@kernel.org>
 <c5a4f007-0846-42a8-a153-d95cb070dc66@linaro.org>
Date: Fri, 27 Jun 2025 08:43:45 +0200
Message-ID: <87ecv5y99a.fsf@kernel.org>
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

On Wed, Jun 25, 2025 at 17:31, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:

> On 25/06/2025 17:10, Mattijs Korpershoek wrote:

[...]

>
>> android_image_get_data() handles the case where vendor_boot_hdr is NULL:
>> """
>> 	if (((struct andr_boot_img_hdr_v0 *)boot_hdr)->header_version > 2) {
>> 		if (!vendor_boot_hdr) {
>> 			printf("For boot header v3+ vendor boot image has to be provided\n");
>> 			return false;
>> 		}
>> """
>> 
>> So I don't think we should early return here.
>> If we do, we will probably break boot image v2 support.
>
> Well I guess the alternate fix is to just init vhdr to be NULL?

Yes, that would be better.

>
> Andrew
>
>>>   

[...]
