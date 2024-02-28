Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F4C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 09:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA84587D8E;
	Wed, 28 Feb 2024 10:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CpkGzOOy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1CB087E03; Wed, 28 Feb 2024 10:45:48 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B2187D84
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 10:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CC888CE207D;
 Wed, 28 Feb 2024 09:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B515C433F1;
 Wed, 28 Feb 2024 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709113541;
 bh=x8Y+x1Eq2TsYiQPryLekWbQJPL/6d7RXSNmZNvU3dA4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CpkGzOOyPu4/bsx8qfDVIa8JwwxCTV9wEAuSH+dZLaqx0ll0kYf0EVkvmIHlZfdx1
 SnDBotq4Pp0Dym9gGuD5Y4HT0wG+lISQEuz1QYcE2RZYcZmjIbPyhTUXdFdXI6V9pK
 ytuHK/AguB22b7CZVSpkca8+IUP6VifAN/jzHs+/A9FcaAFTcV6NU1tiVkDwpWzU9u
 X44aG4KxS6bvmgmqCp9k+ePgOFXSe0x3ySOvZAXwWsAifIOKH6zXPvWGzLyIbTQAkA
 zclp0+JTGw1zAAH1tDkJvo4wwtVMqibXtkHbqGqNYwcWx2mF3g/UHmQCbWtRa+XWD6
 IQh3enM46oFWg==
Message-ID: <f02fc4d8-e74f-4a24-a866-80267d972f72@kernel.org>
Date: Wed, 28 Feb 2024 11:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
To: MD Danish Anwar <danishanwar@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com
References: <20240209100829.1079401-1-danishanwar@ti.com>
 <40bd8620-9fad-4c7b-9f28-4ab8a3e0365a@ti.com>
 <04e7a4b8-a264-5d9c-a0b5-c985d5f35cb8@gmail.com>
 <2ec93e9f-fbe5-4c9f-83d5-bbc820efff0a@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <2ec93e9f-fbe5-4c9f-83d5-bbc820efff0a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 28/02/2024 11:02, MD Danish Anwar wrote:
> 
> On 27/02/24 7:33 pm, Sean Anderson wrote:
>> Hi Danish,
>>
>> On 2/27/24 05:26, MD Danish Anwar wrote:
>>> On 09/02/24 3:38 pm, MD Danish Anwar wrote:
>>>> The fs-loader driver reads env storage_interface and uses it to load
>>>> firmware file into memory using the medium set by env. Update the driver
>>>> to use env fw_storage_interface as this variable is only used to load
>>>> firmwares. This is to keep all variables used by fs-loader driver with
>>>> 'fw_' prefix. All other variables have 'fw_' prefix except for
>>>> storage_interface.
>>>>
>>>> The env storage_interface will act as fallback so that the
>>>> existing implementations do not break.
>>>>
>>>> Also update the FS Loader documentation accordingly.
>>>>
>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>> ---
>>>
>>> Hi Tom / Sean, can you please pick this patch if there is no pending
>>> comments to address.
>>>
>>
>> Sorry, I forgot to respond to this earlier.
>>
>> To be honest, I'm not really convinced. We have plenty of environmental
>> variables which are inconsistent (e.g. ethaddr, eth2addr, eth3addr) and it
>> doesn't cause any issues. While fixing code has no cost, the environment
>> is an ABI which we can't break. So we'd have to support both of these
>> variables forever. I'm not really a fan of doing that without good reason,
>> and I think aesthetics of the variable name isn't really compelling.
>>
> 
> Roger, should I keep the env variable name as it is and don't rename it?
> Sean's concern seems valid, can you please comment here.

Sure.

-- 
cheers,
-roger
