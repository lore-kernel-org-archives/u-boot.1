Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48039E92FFA
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 09:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4747386E2C;
	Fri,  6 Oct 2023 11:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xew+wNvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FA5086E2D; Fri,  6 Oct 2023 11:55:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D63686CB8
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 11:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E94C661BF0;
 Fri,  6 Oct 2023 09:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA1C433C7;
 Fri,  6 Oct 2023 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696586095;
 bh=Q1toJ4vUAzkug70MCHNRQ1qHa74Pfoa5kU7oeC1gULk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Xew+wNvMfXMDvg3Fahb2z9g0dasH9+yp7NcXtTqm8MRGGg+Lz/DYMaXabWkG7E29p
 pQyQ3f/qiTlVWsQTtsYASPvZ1r8QXFdYF9mmlN4rxd8/3xmc7F1a5guPz0rJKGo7vw
 +YTUdSTSTm1CdCw+VEOvdvfzCtkmgYWV2fxv2AnCAYSLXje8QfA1mN0nWNVCjR/+rK
 Yo4rVBmUk7EgRAPaoSJacAjZazN9/liYxt4tI+PnYHoJKhv4ckGLp6oy+eKmB/lCGF
 a41qe38t866SLpnKIC0W+cr7mL+m3XqH7nzw3NbUg8KME/JW738oEL6OXPAv8Va2mS
 9mr7sdhON1QNA==
Message-ID: <a8f3749a-ab3f-4e77-bf68-b45ca86117cc@kernel.org>
Date: Fri, 6 Oct 2023 12:54:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>,
 vigneshr@ti.com, m-chawdhry@ti.com, jonas@kwiboo.se, srk@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <20231004132324.44198-1-rogerq@kernel.org>
 <20231004132324.44198-2-rogerq@kernel.org>
 <26457fd1-439d-fb87-52cc-350a884a8dcd@ti.com>
 <20231004135436.ihofrxutzcdefica@audacious>
 <895a5d8f-1d5f-4f90-90a1-ca75bc1ff54f@ti.com>
 <20231005163645.GS8465@bill-the-cat>
 <20231005171010.zvza7uqyn4mcgp5g@handsaw>
 <20231005171614.yiatmyczip2jnmf4@surround>
 <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CAPnjgZ1fnqgk5W_8-jkJL1keXGM4CfnK-jPnFtQcFcV+y89+cA@mail.gmail.com>
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

Hi Simon,

On 05/10/2023 20:22, Simon Glass wrote:
> Hi Nishanth,
> 
> On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
>>
>> On 12:10-20231005, Nishanth Menon wrote:
>>> On 12:36-20231005, Tom Rini wrote:
>>>> On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
>>>>> On 10/4/23 8:54 AM, Nishanth Menon wrote:
>>>>>> On 08:48-20231004, Andrew Davis wrote:
>>>>>>> On 10/4/23 8:23 AM, Roger Quadros wrote:
>>>>>>>> ti_mmc is not a valid boot_target for standard boot flow so
>>>>>>>
>>>>>>> Is there some way to make it into a valid boot_target? Otherwise
>>>>>>> how do we use uEnv.txt files, or boot from FIT images with overlays?
>>>>>>
>>>>>> envboot takes care of uEnv.txt file (see
>>>>>> https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
>>>>>>
>>>>>> Early remote proc loading and FIT image is a question for stdboot itself.
>>>>>>
>>>>>
>>>>> If stdboot is missing these features then we shouldn't switch until it
>>>>> has them. I'm all for switching to this, but only if it is complete.
>>>>
>>>> Depends on what you mean?  Did you mean an option to run scripts
>>>> (exists) or an option to do what TI needs done, via
>>>> boot/bootmeth_something.c ?  If the latter, someone from TI needs to
>>>> figure out what that should be and do (but plumbing-wise everything it
>>>> needs should exist).
>>>
>>> Andrew is generalizing here (on the wrong patch though).
>>>
>>> On am62x platforms, there is nothing regressing with this series. The
>>> challenge is early remote_proc loading which is done for J7* platforms.
>>>
>>> How that is initiated as part of bootmethods is something of a gap.
>>>
>>> The other gap has been support for uEnv.txt -> which we can workaround
>>> at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
>>> -lb" in defconfig (This series from Roger already does that - hence I am
>>> saying that Andrew is complaining on the wrong series).
>>>
>>> Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan -lb" and
>>> uEnv.txt remoteproc loads and the various standard bootmethods should
>>> "just work".
>>
>>
>> I forgot to add: FIT image authenticated boot flow. That is really what
>> ti_mmc distroboot method was trying to solve.
>>
>> Maybe Simon or someone know how the stdboot flow handles authenticated
>> kernel image and dtb boot flow with FIT image?
> 
> Yes you can use FIT configuration verification and things should work as normal.
> 

It there any reference to look at on how this is done? Thanks.

-- 
cheers,
-roger
