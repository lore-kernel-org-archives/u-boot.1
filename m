Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657F0C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C4082F08;
	Sun, 29 Jun 2025 21:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GFnGLELJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFDE82F46; Sun, 29 Jun 2025 21:35:12 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B5582EA9
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bVfdL6vmfz9sd6;
 Sun, 29 Jun 2025 21:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1751225703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9OmdJ7QIuvqT9VedjyBuRfdgJjfpi16FiqsdO4LiQo=;
 b=GFnGLELJUAqtROnAO3q86+dKj8VNLAKUnyJzbQvGiCqUoorasMIGRNAeMaFFvEnEABna6n
 XSstY0LK6J2AWKnCnCV0mDt28ByDuz9xfBnJRl4TszFcXe233Y6amCcNia/Iqo8KMn1CfI
 5Lt52tSitDfsbnyPculP34Rej5gsDDryTKIPg2V+0cfkOihNAXxcju68fIev5wh2CxqLIx
 HsIw1/si+C+GaswEIQWF4pWRb5BZdtTfAKrge/pOOwOw3D3CfrorRJSyYpDJ6+82xIRFgE
 4F5Bg5fVYKGfOBntwy+0akWBeOLdcEoyN7GhoiKgBNViCIWcv4DNx/SGHYd/zQ==
Message-ID: <b0905e50-5db0-4e88-8a8d-f7f7daa9de94@mailbox.org>
Date: Sun, 29 Jun 2025 21:35:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 06/10] ARM: dts: stm32: Add stm32mp13-ddr.dtsi template
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-7-marek.vasut@mailbox.org>
 <c6d04a79-f36a-4eaf-a4f0-06067307cc54@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c6d04a79-f36a-4eaf-a4f0-06067307cc54@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: edebcf2673f7d3a8445
X-MBO-RS-META: xz6qyw6pa9zti9r7x4efgmwx3we7fto7
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

On 6/3/25 4:22 PM, Patrick DELAUNAY wrote:

Hi,

>> +++ b/arch/arm/dts/stm32mp13-ddr.dtsi
>> @@ -0,0 +1,49 @@
>> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> 
> 
> For new STM32MP file avoids to use the Deprecated License Identifiers 
> (GPL-2.0+ / GPL-2.0)
> 
> reference=
> 
> +https://spdx.dev/learn/handling-license-info/
> 
> + https://spdx.org/licenses/
> 
> 
> =>
> 
> SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> 
> 
>> +/*
>> + * Copyright : STMicroelectronics 2018
> 
> 
> This copyright, with year 2018 is strange this file is copied for TF-A 
> file, I think = ./fdts/stm32mp13-ddr.dtsi
How did you arrive at this conclusion ? The content of these two files 
is nothing alike , see e.g. diff output. The stm32mp13-ddr.dtsi is 
derived from stm32mp15-ddr.dtsi, which is where the copyright stems 
from, I can update it to 2018-2025 ?
