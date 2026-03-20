Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939631099B4C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 23:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3ECE8403D;
	Sat, 21 Mar 2026 00:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="RUmR+kTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE5983CF3; Fri, 20 Mar 2026 20:21:04 +0100 (CET)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB49A805D7
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 20:21:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
Message-ID: <47829306-22ea-476e-ae55-624024d1796c@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774034459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46pkilFD5R63OyfDYjsaJfVb7QryWEZLM8n0NdgXgko=;
 b=RUmR+kTHlA/W+TriSRVu5/Sda2X3/a8sg35lggiyxUSZ9ozCkhuiwOJYunurgJSD+ef6tk
 fpTYY/iGnMMY6DvW3XLHXjyoJxzmnc/JhfbLHXttl9EkW3uMuKLy0avWStv2R+AbUtYQ1V
 UgUNLRXMCTBzyK/CCc7rgyVe5ixs+9swUObcIpd4ccxQtoUJA45tSH+zR+yqvLPPmEgXoS
 s4gClD8R4SjbDeS7hMct/cEyPACK3OLiJ+c0jXSMrnVzBh64G2ekIQ3Z0wBIhN/VJlewbA
 KLmMiRdiLsCfT8Y2RDW/KxGdvt2o/ODpg+xWrfdRzYAXrDyy2X6Ks11qwnJRVw==
Date: Fri, 20 Mar 2026 20:20:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/40] clk: port full Linux Common Clock Framework to
 U-Boot
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
 <CAFLszTimOLhu=n5jrztE9QqbtXRDjutf_WiKLGMVe4ODJOc8wA@mail.gmail.com>
 <4d07d238-42b7-439b-9369-9306ce1b64c4@linaro.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Casey Connolly <kcxt@postmarketos.org>
In-Reply-To: <4d07d238-42b7-439b-9369-9306ce1b64c4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Sat, 21 Mar 2026 00:54:20 +0100
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

Hi Neil,

On 20/03/2026 18:55, Neil Armstrong wrote:

[...]

>>>
>>> === clk_ops/UCLASS_CLK ===
>>>
>>> CCF_FULL drivers should NOT use UCLASS_CLK, since CCF uses a totally
>>> independent clock API. If the clocks are provided by another device like
>>> a phy, they can simply be registered with the clk core the same way they
>>> are in Linux. Standalone clock drivers should use UCLASS_NOP.
>>
>> Bypassing UCLASS_CLK entirely is a big departure. It means DM can't
>> track these clock devices properly - no uclass_find_device(), no
>> sequence numbers, no standard device iteration.
>>
> 
> Can't we allocate struct clk as udevices subdevices of clk drivers ?
> 
> Like alloc_clk() woult create a child udevice of dev and the lookup
> functions would use the uclass functions and use dm for all the
> allocation and lifetime of the clk.
> 
> This is what I did for the interconnect, and it works well. You
> can easily create/attach/find/iterate/remove subdevices instead
> of using custom alloc and lists.

This is what the existing U-Boot CCF does, while we totally could go
with this approach it would involve a lot of changes to CCF to use DM to
manage the clock tree but I don't think we'd gain much.... We'd
basically just end up with the CCF U-Boot already has where every
clk_ops needs it's own driver definition and we have to rely much more
on string based lookups.

If I were writing my own CCF for U-Boot from scratch I could imagine
going this way, clearly it has some value for the existing
implementation... But yeah the allocation and lifetime management is
already just there and battle tested as well as doing some thing DM
alone can't like keeping around but stubbing a clk_core if the provider
is removed without breaking consumers.

> 
> Neil
> 


-- 
// Casey (she/her)

