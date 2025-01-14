Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05FCC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D860805CD;
	Tue, 14 Jan 2025 15:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736863743;
	bh=6es6yCEGERL+rwPdzq6ESnTJnPxkGkApwmItFlT+M7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aa6g5tbCubHA8DF75vsBBmUQCQ6aay7SMwTbUdb9LrOOfaEz59T9HvFANcZ0OqhjT
	 mg6LOijCyTLFah/bglvkqKTGzgSaav+GFdKFO183LgB/YKTB8Rv2ZJy3C7i/K7z0A/
	 /3MPh0FYBzEFf4MA+bNXKfJKRVRtbbhSQmDUo9Ltl00kbm/g99EiRarxS+fVkMC7Dl
	 lEXoA8RVzcxrKSRk+mAfMmQtsJNuHrm0MYxK8xAIsmHrj5nO+qkE1/pD3zrocXRur+
	 mZePPcaTs7GUfQTLQEIT0yNGo0hn1DRrYyCvIQM4Vfckg94PjlXQYdMwxo13Dz7GbF
	 21AcZ0ai6RagQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 569218060C; Tue, 14 Jan 2025 15:09:02 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA808022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Pj0jNdQt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3722B1040DBCA; Tue, 14 Jan 2025 15:08:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736863739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6es6yCEGERL+rwPdzq6ESnTJnPxkGkApwmItFlT+M7o=;
 b=Pj0jNdQtR8YYZmjmT600WlqpETuZPK5swwEUI8WSeDaoVQVVOE1CI43I7/xb20ZrodaYYJ
 lfexcAWL+K/ge1dUc5UVd8BPdgwF9whzePHU2RS8GYKhG2YkK4H/CJ4Z1p8TyoJ5MU14Qg
 6baerZ3aini6UdpBjZYdvEt2W9g9EjeYUv54XQCp1QBxLi1mhJ6sEci6T7GbwMq5LXzlwE
 xJ7ofIEjt/204t349+GF5oKT0FWDA+XaBhRLUIVfIrdg2NeaPDG5BxWPR/GcTD8MF+912K
 KGPAg9fspClmk14vYR6XXX5xiX/hvW2Ixw2zsEDVwADasGKQftgS50KryxUJtA==
Message-ID: <ea374f5c-3d22-420d-acf4-6942c6d76e1c@denx.de>
Date: Tue, 14 Jan 2025 14:46:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] image: apply FDTOs on FDT image node without a load
 property
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de>
 <fd67183b-c1a6-4e93-9b07-ac5fb8196d2b@denx.de>
 <8875f80c-48e3-4ad9-8c9e-4cbec49070ec@cherry.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8875f80c-48e3-4ad9-8c9e-4cbec49070ec@cherry.de>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/14/25 12:04 PM, Quentin Schulz wrote:
[...]

>> This has to be updated to handle the mkimage -E case too. Basically, 
>> if the FDT is outside of the fitImage tree area, but still in the 
>> trailing blob area at the end of fitImage generated with mkimage -E, 
>> then any modification to the DT which would result in resize may 
>> either fail or corrupt the surrounding blobs.
>>
>> The safe but heavy handed option would be to relocate unconditionally .
>>
> 
> Will do.

Thank you

>>> -        /* check is simplified; fit load checks for overlaps */
>>> -        printf("Overlayed FDT requires relocation\n");
>>> -        fdt_noffset = -EBADF;
>>> -        goto out;
>>> -    }
>>> +        /* Cannot overlay an FDT stored inside the fitImage, so 
>>> let's relocate */
>>> +        char *of_flat_tree = map_sysmem(load, len);
>>> -    base = map_sysmem(load, len);
>>> +        len = ALIGN(fdt_totalsize(load), SZ_4K);
>>> +        if (boot_relocate_fdt(&of_flat_tree, &len)) {
>>
>> Please print the error value in case of failure here, it is useful for 
>> debugging.
>>
> 
> The function returns 0 on success, 1 on any error, not sure it's that 
> useful as it'll always be 1. Do we want to anticipate this function 
> being updated to have other error codes in the future?
The other functions in boot/image-fdt.c already return proper error 
codes, so it is possible this one will be updated to return them too, 
eventually.
