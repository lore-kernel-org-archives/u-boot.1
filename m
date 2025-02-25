Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C870C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 06:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C63F807B1;
	Tue, 25 Feb 2025 07:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740463548;
	bh=xQeUuFrEI+ZgFZEDF4c4IFWcE/VhGezGFdMAnj1tyFU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zEXLDgi6aV9r6/HIsEaw9tRd8Fpd21T+Ub2mXJ5jhfVOjKksJ2i5B409wGJqLbph+
	 HgH9pheHo6gvLq880eitHqiIrELBLa8wnGBwZHUmuibG28eiH3DE1f8wEd8ROxiVTS
	 B7E9FKSZYBw34W06rv6VkGBOq6a2ylhlb2yGTm9OlEhHJ3bA/krz5ZVOA+1CNz7wiC
	 V/03GrEasjlSDg879fgUqmd18W0Hf0SWpEvNJZnq0qrut/oe3LPqvbW0YitU550F6D
	 Y7Z9fZNdY1lXic2o/YCwbBq+Fwb2U9O0n8UwyZA+1wPV4rIwjda6PqCYZ6QOiBMHYv
	 3+P7/6uUgIsAw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D3A780977; Tue, 25 Feb 2025 07:05:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01D47805C3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 07:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FYdjiEIT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3C9410382F1F; Tue, 25 Feb 2025 07:05:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740463543; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQeUuFrEI+ZgFZEDF4c4IFWcE/VhGezGFdMAnj1tyFU=;
 b=FYdjiEITCFxH5+rDG23GN/eIYTT6U0tN0JO3kboo3M1ue/1YsdCw8Vy5WAefnEuSf0+/GT
 QinUR/MTUT4DrD2lzx/AP8Dmmi/fyTTHP3pyIJrwjVpI6yXNCauzWzxgbCL6Ie1qoMjQTC
 rE9X5nHFCK9MrA6i9F/uzzz+Gy1Ae+/Vy1GmgNrVdYqNHO7WM7vk9p894OPDfL/BimxflW
 X02Fu6niDOqyxcHnUkRiwqxlXih7A/aJnb7Qdv1dXHurDgLOHBtcghsA1jPhLXIuJ6aJ6o
 ixujrV4Ns5NUJqz5AdvsnbNehr6BJnRzkmqfbNdy6yFke0JJ6XeU6afbSCd1og==
Message-ID: <176357bb-258b-2523-66e9-d94a51064f17@denx.de>
Date: Tue, 25 Feb 2025 07:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250225023913.GK1233568@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250225023913.GK1233568@bill-the-cat>
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

Hello Tom,

On 25.02.25 03:39, Tom Rini wrote:
> Here's the latest report. Getting closer with the led change. I do wish
> it was easier to test fixes here.

Yes...

> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Feb 24, 2025, 5:05 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to Das U-Boot
> found with Coverity Scan.
> 
> 1 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 2 defect(s), reported by Coverity Scan earlier, were marked fixed in the
> recent build analyzed by Coverity Scan.
> 
> New defect(s) Reported-by: Coverity Scan
> Showing 1 of 1 defect(s)
> 
> 
> ** CID 542488:  Control flow issues  (NO_EFFECT)
> /drivers/led/led-uclass.c: 277 in led_get_function_name()
> 
> 
> ________________________________________________________________________________________________________
> *** CID 542488:  Control flow issues  (NO_EFFECT)
> /drivers/led/led-uclass.c: 277 in led_get_function_name()
> 271                     return uc_plat->label;
> 272
> 273             /* Now try to detect function label name */
> 274             func = dev_read_string(dev, "function");
> 275             cp = dev_read_u32(dev, "color", &color);
> 276             // prevent coverity scan error CID 541279: (TAINTED_SCALAR)
>>>>      CID 542488:  Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never true.
> "color < 0U".
> 277             if (color < LED_COLOR_ID_WHITE || color >= LED_COLOR_ID_MAX)
> 278                     cp = -EINVAL;

So I simply remove this check ... and add a comment that LED_COLOR_ID_WHITE
must be 0...

> 279
> 280             if (cp == 0 || func) {
> 281                     ret = dev_read_u32(dev, "function-enumerator",
> &enumerator);
> 282                     if (!ret) {
> 
> 
> ----- End forwarded message -----

Send the fix, when CI succeeds:
https://dev.azure.com/hs0298/hs/_build/results?buildId=171&view=results

Thanks for the report.

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
