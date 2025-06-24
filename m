Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE401C71157
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 06:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1875C82B20;
	Tue, 24 Jun 2025 08:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750746051;
	bh=Ors0dnh6Jc2URcfT3cePrHII6de6slRf47E/XAEaFEg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dsvr/lGY/wu/4q8i4ph7qwnS/WwBq52O8uBJ62K04SqILhYPVDlxyvkBjR7wlCnN9
	 xvK0gHd7FPfHUxKbL+LjNXZzxlA9wF1JFCxP35H9cYvgUPvpPTowsmGgq1qcplurKm
	 lO4/oDbX8owuOBK//ikJHomYfYRibmrI9vuaXKRyfKrV6OkuPkEirXPqBOsuaPJz7m
	 PksGRsuwQzB19D6X2cNFtS5DV1HlGS7Hdz/v29Uj4uGEqALSryZl2TChIYkXmj5zaf
	 rcDRzGuPIftiY9fPxwNCH+WRfjsrNgJrsDtQH6YpoS20LqH57WpAH2luoKA/XMN9Yq
	 7v+6AgcImI4hw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BA682BCD; Tue, 24 Jun 2025 08:20:50 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE79281F66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 08:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="H47zSj01"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4ABAC101F71C8; 
 Tue, 24 Jun 2025 08:20:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750746046;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Ors0dnh6Jc2URcfT3cePrHII6de6slRf47E/XAEaFEg=;
 b=H47zSj01HAVmfrXk8kZvkg6f3SDTc6jvaZwKsRATLYQv80ayEsvlQhI1apfF5a7v0cBp78
 xxmj3jNN+1WmOPkc/VjVULo0/yrf/WG69XJ/D4JE8b0WHt6vAC3Odi+HH+4feQl79wxpbZ
 +A2aOpVUl3J8WfEAKMu3G0piXrzsYUcGjePTD8LpvfuZedLsSWNrlMLso3Gs9iv9BcME/F
 ewwyQIEgBENIF6g+cDplWRlF2RU9aTmOdS6fVufOJeBJ6vaFyyhWl2NwFTO8qk0Qcg5j28
 khEO/P/0lLuxCbzHwyIHQKU9dU7ghVMDM6WGhxymHglUCXUowF/FEjzGT24CUg==
Message-ID: <eb5dee2e-133b-c01a-28fb-f431ef39b621@denx.de>
Date: Tue, 24 Jun 2025 08:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: mux: Fix the crash when the i2c-arbitrator node
 is present
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, trini@konsulko.com
Cc: sjg@chromium.org, git@amd.com, u-boot@lists.denx.de
References: <20250623080607.100895-1-venkatesh.abbarapu@amd.com>
 <76349303-7fe3-392f-f272-004c3e173206@denx.de>
 <d5b5f585-dde1-48ac-8b1d-e7ce089bd0e0@amd.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <d5b5f585-dde1-48ac-8b1d-e7ce089bd0e0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Michal,

On 24.06.25 08:03, Michal Simek wrote:
> 
> 
> On 6/24/25 05:43, Heiko Schocher wrote:
>> Hello Venkatesh Yadav Abbarapu,
>>
>> On 23.06.25 10:06, Venkatesh Yadav Abbarapu wrote:
>>> Observing the crash when we add the i2c-arbitrator node in the device
>>> tree as per the DT bindings. The issue is with the child node of
>>> i2c-arbitrator@72 i.e., i2c@f1950000->i2c-arbitrator@72->i2c-arb, as the
>>> arbitrator uses the uclass of mux(UCLASS_I2C_MUX) and the mux uclass driver
>>> checks for the "reg" property using the i2c_mux_child_post_bind() function,
>>> if it won't find the "reg" property it will return -EINVAL which is leading
>>> to the crash.
>>> So, add the logic to check whether the  child node has the "reg" property,
>>> if the "reg" property exists then read the "reg" and update the channel.
>>>
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/i2c/i2c-arb.txt
>>>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>> Changes in v2:
>>> - Return immediately if "reg" property is missing for arbitrator case.
>>> ---
>>>   drivers/i2c/muxes/i2c-mux-uclass.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>
>> Reviewed-by: Heiko Schocher <hs@denx.de>
>>
>> @Tom: The fix looks valid for me, but I am unsure if it is not to
>>        late for 2025.07. What do you think?
> 
> No issue to take it to next release. Issue is visible with pca9541 which has been sent too but won't 
> make to 2025.07 anyway.

@Tom: May you can pick it up without a formal pull request?

Thanks!

bye,
Heiko
> 
> Thanks,
> Michal

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
