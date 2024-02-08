Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AF5C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 11:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A5887E36;
	Thu,  8 Feb 2024 12:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iFsERNJ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FFB87BBA; Thu,  8 Feb 2024 12:58:10 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B178687E36
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 12:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1F7E261B5D;
 Thu,  8 Feb 2024 11:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253FEC433F1;
 Thu,  8 Feb 2024 11:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707393485;
 bh=lCUJmQZuWj/lrk/nFpc1eEN+3Wx3CQsGan1R+a44zGA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iFsERNJ5914BYQydz8wkKfV2AQCPm0XLfrqL69L5kGKwqWAgI/kWTOR41oTF/PUME
 DR5XYcjmLh9/VPdmW5qsf/Zbzt+SOcKKOCdnB6fNLS9rEBpltiE4LjWkExoOB4ZSk2
 TpWX5/EEOBiDom0/V79AFGkMymTi43Uo2yW9pZ5dYhzmJN4GZdc+Sio1NIuQTqDq+M
 dU3zTXGWTjOtDKXYWNsS4luuoYZXnktmwMSOzwn4GDFQjC+DB2WzkdFu3mPffjkMgo
 IpEujs3bpL/PB4Ch8StbmW47XB5Qca7B+vkFEBbzhjabSZi7COfLC2/JPkBb3IZLjP
 8Kt/vuieJ6IDw==
Message-ID: <e72baacd-2af7-4e35-9e89-083a580125dc@kernel.org>
Date: Thu, 8 Feb 2024 13:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Qu Wenruo <wqu@suse.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com
References: <20240130062627.2344282-1-danishanwar@ti.com>
 <bcbcf89e-f417-849d-ce2c-bcae8dc772fe@gmail.com>
 <0cf2369d-4d18-4cab-a28b-dc72d42ec136@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <0cf2369d-4d18-4cab-a28b-dc72d42ec136@ti.com>
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



On 08/02/2024 07:19, MD Danish Anwar wrote:
> Hi Sean,
> 
> On 07/02/24 11:14 pm, Sean Anderson wrote:
>> On 1/30/24 01:26, MD Danish Anwar wrote:
>>> The fs-loader driver reads env storage_interface and uses it to load
>>> firmware file into memory using the medium set by env. Update the driver
>>> to use env fw_storage_interface as this variable is only used to load
>>> firmwares. The env storage_interface will act as fallback so that the
>>> existing implementations do not break.
>>>
>>> Also update the FS Loader documentation accordingly.
>>
>> So why do you want to do this? I don't see what the point of renaming the
>> variable is, since you are not e.g. adding any new functionality, and we
>> have to pay for the rename in code size.
>>
> 
> I am upstreaming TI's ICSSG driver for u-boot and during code review
> Roger Quadros <rogerq@kernel.org> commented asking to rename this
> variable [1]. I think the motive here was to keep all variables used by
> fs-loader driver with 'fw_' prefix. All other variables had 'fw_' prefix
> except for storage_interface.

Can you please mention this motive in the Commit message?

> 
> [1]
> https://lore.kernel.org/all/4721f3b9-f823-47f3-b4f3-ed40002af31b@kernel.org/
> 
>> --Sean
> 

-- 
cheers,
-roger
