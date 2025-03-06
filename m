Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB9C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 05:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B994C808A2;
	Thu,  6 Mar 2025 06:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741239895;
	bh=aVFVmPtjeFFeLQE93gvMYKr+qZmmixKN4+R3GxoYSpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qG5FfPInWeEshgY0luz7cNARxOvs3MwYaAFNrXj/3mDSpGwtUrIW+umBO0xNCqkSV
	 VKDtQ7YlCy8uvHNRvxtoFvjE06F4jNfNvSH+hHZjvSZeQGIF/PThDK5YEeZ0+0Bv+o
	 ApuX7joBqKw2GM3dB6+edqAxYFEv850KKUPvMlGo33Qz9bvrTdkXmAr0fbNzL+lPha
	 Sf7+ih/iYBFE1kxD1JkAGjQxNtI2piQLpJOt8JJgvUMLtSLOAb+rDgjJ6qlxSM2pfg
	 jlkr9IbYAZo+Ml2brZ8cdZQYX1CNwsAHPtp5lcNQ4Ja40zow1V6dGQbTVweuh0hxkE
	 T1yiBmWLwdIuA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB858810ED; Thu,  6 Mar 2025 06:44:53 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAD880805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 06:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="HeI2Pry+"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E428B10382C18; Thu,  6 Mar 2025 06:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741239890;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aVFVmPtjeFFeLQE93gvMYKr+qZmmixKN4+R3GxoYSpU=;
 b=HeI2Pry+Yw0ywY4oXbQBAiT6cUdUkcv8MbnnYDMkEyVXyvxrwtNRs72p0yAI+TH/FnugNn
 r6mzJ1/caZ2rfk7+Obt8GsqZvlho3TJuNgbdbJ5SJt+oRuFSopUquEpFlagjMIgrwB4FaG
 +83+5LHs/OIeZhez48xEjHJjE0bRtXdNMzwliX7w3uiuVFdShYSkOskU7zgE94odZjKR0O
 CzGQ/ysVhq0oPdg3dhALAEQeMl4V2DTdF9fp0c587YqOeRQXmCnR4tcLIrW0s2EiMduSnk
 xus8ngqV4M4VvDrQXmJY+GzRSMk2Ifxo7wB9BGy5MExtiWmzlhYq1TSImFjM2A==
Message-ID: <5100f007-28c2-ed02-620f-a013e9c6ed60@denx.de>
Date: Thu, 6 Mar 2025 06:45:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH RFC/RFT 0/3] omap24xx_i2c: Enable Repeated Start
 functionality
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, marcel.ziswiler@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250304220546.866602-1-a-limaye@ti.com>
 <20250305155000.GR2640854@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250305155000.GR2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Tom, Aniket,

On 05.03.25 16:50, Tom Rini wrote:
> On Wed, Mar 05, 2025 at 03:34:08AM +0530, Aniket Limaye wrote:
>> This series implements Repeated Start functionality for the DM_I2C xfer
>> API (omap_i2c_xfer())
>>
>> First, split out the actual implementation for each individual i2c msg
>> transfer into a new function __omap24_i2c_xfer_msg() and use this to
>> implement omap_i2c_xfer().
>>
>> Then, add support for the Repeated Start condition in omap_i2c_xfer()
>> through the CONFIG_I2C_REPEATED_START option.
>>
>> Also add this config to Kconfig and enable it for ARCH_K3 platforms by
>> default.
>>
>> Test logs (On AM68-SK with additional debug prints):
>> https://gist.github.com/aniket-l/8c64c5bc81246751a02836a96510df14
>>
>> Requesting reviews/testing on specifically the CONFIG_I2C_REPEATED_START
>> addition:
>> - Is the Kconfig needed or should we simply always default to not
>>    sending Stop bit? Drivers can use i2c_msg.flags to request Stop bit
>>    for each msg, same as in the Linux Kernel i2c-omap driver[0].
> 
> Yes, a Kconfig is needed as this driver works (as implied by the name)
> on so much old and differently buggy IP.
> 
>> - If yes, Should we re-use CONFIG_I2C_REPEATED_START from the legacy
>>    implementation of the driver or define a new config
> 
> Lets pick a new option, under the SYS_I2C_OMAP24XX namespace (and remove
> the legacy and unused variant).
> 
>> - Default enable it for K3 devices?
> 
> I'm fine with that.
> 

Yep, fully aggree, we need the Kconfig symbol for backward compatibility.

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
