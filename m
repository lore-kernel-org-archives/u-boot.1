Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A135CCF9E3
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 14:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC0168389A;
	Sun,  2 Nov 2025 15:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xxpIA2/q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I16s6dwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E78F838A5; Sun,  2 Nov 2025 15:25:25 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C89283642
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 15:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4czxnt6NlJz9srd;
 Sun,  2 Nov 2025 15:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762093522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXg7xpibEdfkPPZT+ESFWECMEZcGc9VDAwapWCWz/M0=;
 b=xxpIA2/qRsAIQ96eHRMFodvAnzoj0YWvzTiep7+KqVEQ1lPiyPLYHIWf1wnBADhMSr2ba4
 Klt/DIBFpyeKcIXLPc8vCOeB05bohIFbLyuK0961PJUWqV+DFBLzZ3V1poIPOYUXP+eWUS
 xKH0IDR83Y9brt3jEijc82mMrglBHP/UN1ihs66pRaP0qatKlRejhx2A4kGaxBMRQp2qas
 LlSJ6WyWf0v8LSaSxcxiFtWp+jy3Bp9mX9AhLnadc/te7byt/JPtidq4zRwsWHmqoWMyOG
 XTelYKhCZ/208LrS2w0U87rWOTSRfOxlkUn17/xEzTY7ahzrDYsueBKn+lgwOg==
Message-ID: <9377791a-b36b-401d-abbb-60decd9f9e80@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762093521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXg7xpibEdfkPPZT+ESFWECMEZcGc9VDAwapWCWz/M0=;
 b=I16s6dwNULvMZ/5GoenuqQ1dPzkDAu5/pefIAGwH3hsXhkSDKFLJe+QZNC0pCnGj9Lt8ed
 YMPCg2PaegrSinJYXMX4o8c9vj9DBc0VQWvNNbwXYWMndZJ/F/oWqm1P8eetVAy8YHvQam
 tpUYo1reee7DSmCh9pp4yPlQr6hX8nwBZQHFQYbPJ3cASmsKeqKQTtvH2qWLjP/EvhhtdV
 y8SHiAs4qp6/5N5pL1waLb3E1Q0orFkdcBsnfxnQPCnPOyuxAMo61GFuAvUoGKaOnTniSN
 40rauu8mx2Q07tcV53WOwDe3O3hgdTK2XCqy4J2hO3gs70mUaPdoZbmvhrSj8Q==
Date: Sun, 2 Nov 2025 15:25:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
 <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
 <FEAA3555-3109-41E7-A58F-5B601B6C2FB5@infi.wang>
 <a8f176dc-59c3-4af4-88ed-03d064f2e7c2@mailbox.org>
 <8968863B-CFDC-4EE9-9062-08219AC0838E@infi.wang>
 <1fc25e78-4a7c-4471-b381-f35e69a8d5d8@mailbox.org>
 <490112A0-3D3B-4209-AC15-43A5A74C546D@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <490112A0-3D3B-4209-AC15-43A5A74C546D@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qioafz5phmfgadp95rat1ripp3jxze7z
X-MBO-RS-ID: 483867ced3f88224cee
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

On 11/2/25 5:57 AM, Beiyan Yun wrote:

Hi,

>>>>>> Can you not use the plain FW_LOADER to load the firmware from either storage, UBI or Block ? Is FS_LOADER even needed ?
>>>>> Thanks for the suggestion, and yes you can, but that API is script-only—it expects the board to stage the blob and just copies from the address exposed via *_addr/_size. The current users of this driver expect the old pattern: the bootloader mounts a filesystem (MMC before, now possibly UBI/USB/etc.), reads the firmware, and applies it. Keeping an fs-loader node in the DT is effectively the same contract as the legacy MMC setup, just generalized.
>>>>
>>>> Can you maybe write a script which implements the old loader behavior in a compatible manner ?
>>>>
>>>>> The fs_loader driver gives us several things the script path doesn’t: a standard way to describe the storage via "/chosen/firmware-loader"
>>>>
>>>> Try this:
>>>>
>>>> "fdt addr $fdtcontroladdr ; fdt print /chosen"
>>>>
>>>> And then look at the "fdt" command and what it can do regarding reading content of DT properties into variables.
>>>>
>>>>> , runtime overrides through "storage_interface/fw_dev_part/fw_ubi_*, and no requirement for a board-specific script. So FS_LOADER isn’t redundant—it’s the part that replaces the hard-coded MMC flow with a configurable backend, while the script helper stays available for boards that want extra logic.
>>>> Maybe a more generic script can be a replacement for the older hard-coded approach ?
>>> Fair enough, I’ll remove fsloader for now.
>>> I still believe it would be valuable someday: if reading from nvmem cell is implemented, the same DT could be used for both U-Boot and Linux.
>>
>> See example above, you can read anything from the U-Boot control DT both in U-Boot shell and in U-Boot env scripts, using 'fdt' command .
>>
> 
> To make sure I understand the preferred architecture: are you suggesting that FW_LOADER is the preferred method, and that all the logic for finding, mounting, and reading from storage should be handled by board-specific scripts that parse the DT using fdt?
> 
> My main objective with FS_LOADER was to provide a "zero-script" default for most common use case. While scripting is powerful, it seems beneficial to have a C-based driver that can natively read from a filesystem described by a standard DT binding, rather than requiring every board to script the same "find-and-mount" logic.

Maybe the scripts can be made common, similar to what distro bootcommand 
did ?

The upside of doing the loading in a script is, that it allows users to 
tweak the scripts without rebuilding and updating the bootloader, which 
may be beneficial in case they need to load firmware from a device which 
was not considered when the bootloader was built.

> Am I overlooking al drawback to that C-based approach, or perhaps missing some prior discussion on this?

See above.

-- 
Best regards,
Marek Vasut
