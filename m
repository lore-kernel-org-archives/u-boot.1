Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC0CFC296
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF55383A41;
	Fri, 21 Nov 2025 18:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Y/BQrN7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BCF839E8; Fri, 21 Nov 2025 18:53:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7497583A8A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dCjWY471sz9v3Q;
 Fri, 21 Nov 2025 18:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763747625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiToC1OE9DR8EhwO3EAiMj29Fp3cdNws7DdZyVgFudM=;
 b=Y/BQrN7CdCMNamxhFIGOBeXUPQM1bsfxSdspCTSWx6Xy8AvOcjT5Wy9/K63g55QU1FxtfV
 4OCnctwbheIpe65nYWuVkBAifwq/NklDp3XvmBTVaSs3geBxZ4sTiUkHIRyFLwpQ3lUC7k
 CKTpm/Rdi9hIT/TyM0EIANMzBD4IA+5I7Cglh31uaqmoNjvah3s68YyCCst7QwpWNbbjR4
 c+e09Tz5MgO8gScnP9I/mOdoGX/AX4B1vzvloqNXRBcmsWzMlM+eOhnIguubDb2FWbwtPl
 Em0Al28V1D6g0L/7NlKkh5RdfiHfaA06lGPE3VvH8/eMMfDdXbZTQk3E/sbR/w==
Message-ID: <36b44a71-e98d-4b89-b639-cb1e31f41865@mailbox.org>
Date: Fri, 21 Nov 2025 18:53:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: fixed_rate: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>
References: <20251120041439.817233-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjnGtSPvki-i1fHQEU+bn=6cTqjRFyid3D5zQepNEhzog@mail.gmail.com>
 <c8752825-92d5-43bd-aa28-e229d4cc3fda@mailbox.org>
 <CAFLszThiZ9iWZG8vNSaosNjMMTQZeG2=yO8kGoPDBL0SSp_4Cw@mail.gmail.com>
 <20251121143510.GX2125796@bill-the-cat>
 <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAFLszTiBezzWuBE2qo8iEU8dyyD6ro4x2UrXGnQnfKSYSmTGgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ezw3z5uj6pgmryihfq9nupsxdceo5x9r
X-MBO-RS-ID: 63e44b8e8a78a489add
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

On 11/21/25 6:35 PM, Simon Glass wrote:

Hello Simon,

>> To be made to clk_fixed_rate_ofdata_to_plat_(...) in
>> drivers/clk/clk_fixed_rate.c as it does not currently call
>> dev_has_ofnode(dev).
> 
> Ah OK. So the call stack is something like:
> 
> dev_read_u32_default()
> dev_ofnode() - returns ofnode_null
> ofnode_read_u32_default()
> ofnode_read_u32_index
> fdt_getprop(NULL, -1, ...)   // guess
> 
> And I see that I put assert() in some of the ofnode_read..() functions
> because I don't have tests for passing an invalid ofnode.
> 
> So perhaps fdt_offset_ptr_() should check for NULL and return? I
> haven't traced it though.

In previous patch

[PATCH 3/3] libfdt: Check fdt_offset_ptr() return value unconditionally

that approach seems to have been rejected, and these dev_read_*() fixes 
were implemented as a replacement.
