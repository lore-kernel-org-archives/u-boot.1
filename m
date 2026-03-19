Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38FB109319C
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 09:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 231D383CEA;
	Fri, 20 Mar 2026 10:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LyqjeWxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2316083F8A; Fri, 20 Mar 2026 04:59:07 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0983883E36
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 04:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6299811118D; Fri, 20 Mar 2026 04:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1773979144;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=8GCg7cDCNFNBv+UVwK7us64prlYfhuBPeP5BNjSZi/Q=;
 b=LyqjeWxbtpCE4iudDUSeEp7SXmIcDLbbfANpAxD3IbjWniuYGFVX1eDDAxDezrRMEID0uY
 V07Nc2OI8HKFuw68aM5mOdaLYu9cfdmBw175bSOW6JEyPZDvjg6ipHrEYoG0no8i6jvZ0S
 q5GDaBTJYvcoYIIYmsyiw6Yj0HGNeEy7zO2YkqG13OXxoeUX8UO0Yetdn1qhtJ54xpbKvX
 kKBIY/LwJRIRIbG3ttdqfWectTuHkARw46V+DEVraJ7m5Se9Pe/W+A2zdcg6en0UuY4758
 MTz6NPJ7gYiRT3mIgxL3RTy4nnLuxaKuDvk3ChFz1UB0WSG0P1KerEW8wYr99g==
Message-ID: <a8f0a62a-9b26-46c7-bf5c-edd26bb1f29c@nabladev.com>
Date: Thu, 19 Mar 2026 19:02:58 +0100
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
 <78c40910-a90c-4cef-ba72-4e4cdfd5abe2@nabladev.com>
 <7fg7jj4rou4ke7nkewytibvcz3oehxtot4q4apq2uhtz75a2gp@uvpcobhbwu33>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <7fg7jj4rou4ke7nkewytibvcz3oehxtot4q4apq2uhtz75a2gp@uvpcobhbwu33>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 20 Mar 2026 10:16:48 +0100
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

On 3/19/26 4:17 PM, Simona Toaca wrote:

Hi,

>>> If one wants to store the data elsewhere, they could use
>>> the generic fs methods to make the backup wherever they want, and re-load
>>> it themselves to the QB_SAVED_STATE_BASE address, so that U-Boot can save
>>> it from there.
>>
>> It would be good to document this mechanism, esp. how to locate the QB data
>> in RAM and how much data have to be saved into backup storage.
>>
> 
> I don't recommend anyone does this sort of backup, although it is possible.

I think I know of at least one such use case.

> I don't see why one would do that since OEI runs training and the data can be
> saved then. The data is board, ddr configuration and firmare specific,
> and I wouldn't want to encourage someone to think they could save it and re-use it
> just like that. Why not re-run OEI and save the data (by using SPL_IMX_QB, for
> example, which does it automatically)? Or run the training multiple times and use
> the cmdline qb command to save to all the boot devices?

Consider a device that is trained in factory, at 25C. The training data 
are saved, and backed up. Then, due to some sort of training data 
corruption, a slow retraining happens in field at unknown and possibly 
very high or very low temperature, which could lead to low quality QB 
data. Worse, the next time the device starts, the conditions can be the 
exact opposite, very low or very high temperature and the DRAM may start 
to suffer from bitflips because of that. In this deployment, it is 
better to use the factory QB data from backup than to rely on the 
in-field training.

>>>>> And the
>>>>> board will boot from the selected configs if one boots from spi.
>>>> Please see above.
>>>>
>>>>>> Looking at this, why can this QB not use the same interface to select
>>>>>> arbitrary block storage device/partition/... that e.g. FS_GENERIC does use ?
>>>>>
>>>>> There is a limited list of boot devices. By keeping things the way they are
>>>>> we limit the usage of this command to the actually useful boot devices (and
>>>>> that we also test this command on).
>>>>
>>>> I would argue that it is better to use generic code instead of hand-writing
>>>> local ad-hoc implementation which is a limited version of the same.
>>>
>>> In the above context, using filesystem methods might not
>>> be feasible.
>> Look at cmd/blk_common.c , that is not filesystem, that is generic interface
>> for block devices.
> 
> I looked through the code and it seems that the driver for the storage device
> has to call blk_create_device in order to be able to use the blk_* commands
> later. MMC indeed does that, and some other drivers. For SPI NAND I could find
> that mtd_bind is called and that calls blk_create_device. But for SPI NOR there
> is no such thing.
> 
> Is there something I missed?

All block devices can (and should) use the unified block device 
accessors, otherwise this will only add yet another ad-hoc block device 
handling. MTD devices may have to be special cased.
