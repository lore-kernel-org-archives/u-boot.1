Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14033E9B266
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16CF83E13;
	Tue, 24 Feb 2026 14:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ycG9UpIy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523A283D3D; Tue, 24 Feb 2026 11:23:38 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC3C83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4377174e1ebso4093835f8f.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 02:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771928615; x=1772533415; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qmzKwXZcnAhbjfmYmvH5khfegf+EZRvNKZc5/WgPL00=;
 b=ycG9UpIyBwdUi4LMmcAbFeZSSklWh+5WvMb3LG+dMRcgwhcxECUBXCD4ElLYNONJ03
 z+xdofp63rO0SD+/IkC7ZQ2iJLXNC+B34Dp+ZplP+7D2CHObuXPpV8HI3iNS44vXlXp3
 WAiuIuiOBtWK1vqe1zOIADP4GefoCnAn3uQqVAfDHNIZjH/k4bKbpSoGT+mhdDMt3Wof
 2tf3MvPBFkytD3KGobKE/6JM0+el0iut1tNJrHVilzKE0NLEa/ixhtmZxmke6mxYN6V9
 e9398kJ8nsnJBSH7VLPzLSrNYMzhCJb/BI0sYN5s3XixnNoDs6WdVbdAJPojTuGy/CWn
 nsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771928615; x=1772533415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qmzKwXZcnAhbjfmYmvH5khfegf+EZRvNKZc5/WgPL00=;
 b=LlyO36+D82u8nvHXKxIxLvw6KNp8MAR+3M4L49zXmPi7BM3/voY7Hh/yb32IgbLafC
 Eh1EwUirkrvs9EvQ90KqYOqFax+7KSM33vFiNy5MNBCtgIQ/v1Ww6UH9N7ZXSuBF/4v3
 +w2lmtxXFjMR94iTU5McYMU+flPHtYIN/kTDGqcmcsi5E4+LBbbnxFfcdP3e6UyPTlEV
 bmgl/hGfEnZ6rNkudP6+3z05mHWvHnsi9icr10sNRBUHahesX3/Xj/WIhotZXhFtHrje
 mWJ0Jez0+XNzC6F2aOY0/IHQva8nQcBGzuNUqjUep3D6OVI4wuvqzCuY56So+DbuCfxA
 FtCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5stT3SI6fwTud0CJ9uYqlTkka6kKMEU1TC8y9hm6GGOAxsHUTADIZLJBi7y3ul6MV/kMV0Cw=@lists.denx.de
X-Gm-Message-State: AOJu0Yypb7UgdsniCHjTNJPVBHxZEAB+5NbjHOSRuZVRL63aerxuvp2m
 SSMvEGTADsdLDd5MgWZHkNw3hH6s9jyhsxpHWBwTVIgFv+/UoSfgNy59juCj6QzOxxU=
X-Gm-Gg: ATEYQzxLZDXe42Km8WbbTeX6ZEuIJ83fc3nFtYYRUPyUN8d2Vjpd8Q2BkxOP+CKtTip
 uST+YjyyOttD2hDGzH5Dkpy5JyUO2/tPVOZephXOjSMr4IKEnmdT42IoxJjYwpvwJlsCKi3mYUE
 0Hc8+skjp4QvxuJ7AXYLYd4xead+CYqMY1pR7aXD4S+S4Y/stElOcYoqfXzzReCF/N2F/lk8rqm
 y1ZSwA84+DjEnLIrHsULXlwcYUyIeEi140TqcckTVeATWpyai8lkaP8rrhAVuVtbe0Yh9nLER8M
 +1LrnxEr8/qxYy7/oHFA6lE+1AR1jV8+0kzG4ulq2AQYM4ZE8OQuc0ESDi3m4j0jeNhzdFkSjR1
 lr5aOfyezBuDW4Da+DWNTGrItMObz0ey1EarV994eUAMsFsC0cs663DqH8oCOThjXQhBxflGRvL
 LuebXYdyCnlSuTZ6JLjmR4fYo6XVMj6tnX
X-Received: by 2002:a05:6000:1865:b0:439:8a9d:66fc with SMTP id
 ffacd0b85a97d-4398a9d684emr1212031f8f.15.1771928615469; 
 Tue, 24 Feb 2026 02:23:35 -0800 (PST)
Received: from [10.11.12.108] ([79.115.63.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d4bf89sm24515744f8f.29.2026.02.24.02.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 02:23:35 -0800 (PST)
Message-ID: <4e4d660e-b9a1-48ce-aa60-ae63bea6bbde@linaro.org>
Date: Tue, 24 Feb 2026 12:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] SPI and SPI-NOR patch help
To: Takahiro.Kuwano@infineon.com, miquel.raynal@bootlin.com, trini@konsulko.com
Cc: mwalle@kernel.org, conor@kernel.org, u-boot@lists.denx.de,
 Hiroyuki.Saito2@infineon.com, venkatesh.abbarapu@amd.com, p-mantena@ti.com,
 vaishnav.a@ti.com, prasad.kummari@amd.com, pratyush@kernel.org,
 vigneshr@ti.com, marek.vasut+renesas@mailbox.org
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat> <87bjhmv20f.fsf@bootlin.com>
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
 <90d5d396d2ec4888a4359ca4b2392b8d@infineon.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <90d5d396d2ec4888a4359ca4b2392b8d@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:26 +0100
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



On 2/24/26 10:39 AM, Takahiro.Kuwano@infineon.com wrote:
>> Takahiro recently accepted becoming a designated reviewer for SPI NOR
>> in Linux, and I think his expertise would be highly valuable in U-Boot
>> as well. Takahiro, if you have the bandwidth, would you be open to
>> becoming a designated reviewer here too? Or maybe see how things are
>> going in Linux first? No pressure.
>>
> Yes, I'm open to do that.
> 

Wonderful!

> To sync with Linux, we need to isolate stacked/parallel support from core first.
> https://patchwork.ozlabs.org/project/uboot/cover/20251119-amd-cleanup-v1-0-c555bd85e6e4@infineon.com/

+1
