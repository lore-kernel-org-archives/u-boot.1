Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3368C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 22:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B8886ED0;
	Sun,  3 Dec 2023 23:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Zl0eD7EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F3B87479; Sun,  3 Dec 2023 23:01:45 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1AD68272A
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 23:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1701640902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxlUM5RZcKRxwxGcIAQY82OwDS9YS1ACuTLHZN2cs2M=;
 b=Zl0eD7EKrETC4tCwoPclO2vTZs0PGX+C2YqFnaPXOEKkwDMcGxw1ha8pGwfpjScxd7qwLJ
 0+KA9u3YFctD3lv0G1wu6UaznyP201lHoIskleVD7Jqs4sj9B5XARmrrzlMNnEx0iUV+hS
 dtm9zbJkIGdjPDuwLbE7FaLjsgM3Ecd0kvSlzzZvVBilb0Gruu/MEXXxaZKd9KADNnty03
 UhZ9QDSNZsycfHR8mvT4vw9bPh060EhDzaMnUfk436XU1xQunpLh4ZLLp9/s/2OFhxyNHe
 C/fFbyv2tXkhfxGl2N+b4Li2NN6WNqJobbXrnQLZyKFlAiV+D2a/EzfZE9SPIQ==
Date: Sun, 03 Dec 2023 23:01:42 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, Jagan Teki
 <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 3/3] defconfig: rockpro64: Enable SF EFI var store
In-Reply-To: <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
References: <20231126220836.374956-1-i@shantur.com>
 <20231126220836.374956-4-i@shantur.com>
 <CAPnjgZ2W2maVN14usKHHdyTKyzriP_=iJYpYBvycRxR5zDZW2g@mail.gmail.com>
 <CAHc5_t3fMFntuQ+VLOb9RQ7CBCy7mtsEFEKZ1bWzDAu3mCVEHw@mail.gmail.com>
 <CAPnjgZ3YQb5Tva44HOv+SLx58XBJqqZwhFMxrfxrMY71bjpMLg@mail.gmail.com>
 <CAHc5_t2pEzVLH7aD_md5PVkpj_LC_U70EK-Q-1Yrc+P45NqVcw@mail.gmail.com>
Message-ID: <e5d4a0fcff8cea34af0d69c2204cb7a1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

On 2023-12-03 22:49, Shantur Rathore wrote:
> On Sun, Dec 3, 2023 at 5:44 PM Simon Glass <sjg@chromium.org> wrote:
>> In fact, I wonder if we should add something like:
>> 
>> u-boot-env {
>>    offset = <CONFIG_ENV_OFFSET>;
>> };
>> 
>> so the environment gets filled into the SPI flash when we write the 
>> image?
> 
> Do we want to reset the environment to default on every u-boot update?
> I believe this would overwrite the environment space isn't it.

Obviously, resetting the U-Boot environment on updates would be a really 
bad idea, which may even render some boards unbootable.

>> I suppose we could also add the EFI variable store, although that
>> would require adding a new entry type to binman.
> 
> I am not sure about this but surely EFI vars can be moved to a location
> just after the u-boot environment and increase the u-boot image size.
> 
> Would you still need an entry in dts?
