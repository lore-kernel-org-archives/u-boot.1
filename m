Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24831088E58
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 00:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66BA383A1B;
	Thu, 19 Mar 2026 01:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Cms/qtfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 597D6836D3; Thu, 19 Mar 2026 01:36:52 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6187880050
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 01:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7033710E8FA; Thu, 19 Mar 2026 01:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773880609;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Xul0pVCjxQ1w7Sp1lU+boeLs9tgsJHKriVotf7y5ZpE=;
 b=Cms/qtfUnLv030IPZQ4UoDIy1mEepRnxImGEVZJsFmskOWJSe4tkYkIB75degb+x9PyJg+
 F8FjOTT8bv/mXzJF97Fb+Ub/Th5AOIJp3lbhjcyUvur3IK/2acoI1CNad/JNX/WTEXyMXn
 H4jXtcFXH/6OO1sLWkfY7GKGMOET2Y4f+A9+3cEMqqCRCmJzVQawDHZRd8ETp0MOXtVWL/
 l3t3V8iFhROfC+Ux1XzHqzaYdGotil3vQ3AqNePSFghxyvpBqlY2oql7J5YrZ95x2s96uZ
 8t0wrnvABjiqIKutOpH11b5RJBo1a27DO5e6pge/uwg6hTDn09L9KLAIuwuAhA==
Message-ID: <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
Date: Wed, 18 Mar 2026 21:32:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] doc: board: nxp: Add Quickboot documentation
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, sebastien.szymanski@armadeus.com,
 ravi@prevas.dk, joao.goncalves@toradex.com, ji.luo@nxp.com,
 tharvey@gateworks.com, qijian.guo@nxp.com
References: <cover.1773648510.git.simona.toaca@nxp.com>
 <be6b07edb38e4e0dc86e65f8bac7b6b3b0e29d01.1773648510.git.simona.toaca@nxp.com>
 <d3b42af1-65a8-401f-9dda-1f79cb0dde9a@nabladev.com>
 <yuwvhik6p6eordghidde6l4ey6fclwwuxnzuqpttcoicxqa2r4@jpp2t42tl2wx>
 <541a05c0-e0f0-43ce-b944-d7656da585e1@nabladev.com>
 <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <becryuzd7ohecs7vq2goxhfv5fsrjh6a3ctav77y4uxrszzecd@wsnoc3muqoit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 19 Mar 2026 01:46:15 +0100
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

On 3/18/26 3:20 PM, Simona Toaca wrote:

>>>> Can QB data be saved to arbitrary SPI NOR ?
>>>>
>>>
>>> No, this SPI NOR refers to the SPI controller selected by
>>> the CONFIG_SF_DEFAULT_BUS and CONFIG_SF_DEFAULT_CS options.
>>
>> Maybe the user would want to make a backup of the QB data to another SPI NOR
>> (e.g. if the device has two, which is not unheard of) ? They should not be
>> prevented from doing so.
>>
>>> The point is that the device we save the data to is also an
>>> option to boot from, otherwise the qb data is useless.
>>
>> The QB data could be stored for backup purposes, that is not useless.
>>
> There is one thing that might make this clearer, and I forgot to
> mention it explicitly:
> 
> The get_qbdata_offset method searches for a 64KB hole in the bootloader,
> so it can save the data there. OEI knows that's where the data
> should be saved. On an arbitrary non-boot device, or, on a filesystem
> partition, the hole would not exist. It is mkimage that puts that
> hole in the bootloader, and U-Boot explicitly checks for container
> header tags.

Uh, is there any danger that this might accidentally corrupt the 
surrounding bootloader ?

> If one wants to store the data elsewhere, they could use
> the generic fs methods to make the backup wherever they want, and re-load
> it themselves to the QB_SAVED_STATE_BASE address, so that U-Boot can save
> it from there.

It would be good to document this mechanism, esp. how to locate the QB 
data in RAM and how much data have to be saved into backup storage.

>>> And the
>>> board will boot from the selected configs if one boots from spi.
>> Please see above.
>>
>>>> Looking at this, why can this QB not use the same interface to select
>>>> arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
>>>
>>> There is a limited list of boot devices. By keeping things the way they are
>>> we limit the usage of this command to the actually useful boot devices (and
>>> that we also test this command on).
>>
>> I would argue that it is better to use generic code instead of hand-writing
>> local ad-hoc implementation which is a limited version of the same.
> 
> In the above context, using filesystem methods might not
> be feasible.
Look at cmd/blk_common.c , that is not filesystem, that is generic 
interface for block devices.
