Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4EBC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2016877AF;
	Mon, 11 Mar 2024 13:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="CK7NFQaZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A8D8786A; Mon, 11 Mar 2024 13:02:16 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2025875FC
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1710158533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xlq9tXKGEeyRJJXWM60KcN5E64tSe5+49C64tueXO3s=;
 b=CK7NFQaZYRm/8g8dyG7bhFMsSniIqK7vSVMp0Bpear6yPoElaUlxGAYq2eFUL9Qie/7Ehx
 4jWpUf/TPsXIPn8eED9FzGG/Fp921Tu4bHkJPDPv9wS8J9biRgBzQfcB2lSNeMee5pcuRn
 3K97UbtcOKS58cAfwvAbLrD8AhMDtmDtZQYEKZoqcyAfcb92QZKaFAqcIqT+MAKsV7Q8E2
 5L6wfv6e5bUsw0hi1aRlZI9Y4pMCQ0pC+XPsAdKX5anU34UdUBfvGJvH/AHtyjcAlkFzhM
 d5hjMVXftY61wD/ct3WFct+wl/gJCI8K91XB+4fbt/6ZAyjL5xI1zKyyacV6fg==
Date: Mon, 11 Mar 2024 13:02:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH] fdt_support: fix fdt_copy_fixed_partitions function()
In-Reply-To: <5b95fea0-581a-44e5-b275-09393b7b02a1@moroto.mountain>
References: <20240308133404.2619848-1-patrice.chotard@foss.st.com>
 <5b95fea0-581a-44e5-b275-09393b7b02a1@moroto.mountain>
Message-ID: <e2d52a2d1d420c7b9da362a5c5f433fe@manjaro.org>
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

On 2024-03-11 12:37, Dan Carpenter wrote:
> On Fri, Mar 08, 2024 at 02:34:04PM +0100, Patrice Chotard wrote:
>> Move variable declaration at the beginning of the function.
> 
> The problem, presumably, is that when declarations are in the middle of
> a block then it triggers a GCC warning.  "declarations after code" or
> whatever...  The commit message is not really clear.

IIRC, there's at least one more such case of block-local variables in
the same source code file, so perhaps we should move those as well, if
the final decision is to move some of them.

> And when I built this file I don't get a warning.  Is there a specific
> config required to trigger the warning?
> 
> Btw, the Linux kernel recently silenced this warning because it doesn't
> work well with the cleanup.h code...  It will be interesting to see if
> people abandon this style guideline.
> 
> regards,
> dan carpenter
> 
>> Fixes: 163c5f60ebb4 ("fdt_support: add fdt_copy_fixed_partitions 
>> function")
>> 
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
