Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B8ECD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 13:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B786483EF9;
	Wed,  3 Jun 2026 15:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="MXah/Coo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C2883FF5; Wed,  3 Jun 2026 15:53:11 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6208C839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 15:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1F1F1161EB; Wed,  3 Jun 2026 15:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780494788;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Rf9lquJCh6wJbD+rw7lYErMkYHxsvV6HrwtoWkreb1Y=;
 b=MXah/CoolrXrJJgxO45z2mL3gf4Sshs3cAHJI9X187BkKhCfoU3Rd5JnoqW12uGtsgBBiU
 amVnN2herWlnO2E/nc3nLbiA9R4FHk99YgK4L5ySCmrnMUwjwNq7cCgqJtpvP5NpYvF756
 YwNc1Mu1dioANXgKx8uuyL7vr1khw1BdSjbDm/ZJTFS/WJwRva94m7RzFDoK3FPPcnV3S5
 RVhwePGmEFVpCwrOSC+e5xfHY0Nxm0KfJyVsWZCWV2wOSIet4HbCFOgNcbvII7isj+o0lh
 h6YKtfdQzrJMFjonHFXFCSlAVSqysnbQ1TSUP1gxgcXbAnvpqiT29QdJP2Ke2Q==
Message-ID: <295b60bf-d027-4587-b808-c7d71b64286a@nabladev.com>
Date: Wed, 3 Jun 2026 15:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, ye.li@nxp.com, simona.toaca@nxp.com,
 viorel.suman@nxp.com, fedor.ross@ifm.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <acfe5311-2ec4-48fb-80bd-55c11931b377@nabladev.com>
 <4phebvxijyyk5yd4p7omjlup3iotsqgp6r3kt5aiwgimwg6nyp@hnl3qq4imsf2>
 <4dd5cfbf-18d3-4411-bb02-c746611ecceb@nabladev.com>
 <9e3611ff-55f0-4a04-864a-935e6c7a3623@nabladev.com>
 <doqobuvsxnnhfyey4ly72shhxue3g5pnqfybc4k6jaiawld3rg@rb7srjxsb5i2>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <doqobuvsxnnhfyey4ly72shhxue3g5pnqfybc4k6jaiawld3rg@rb7srjxsb5i2>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/26 3:31 PM, Simona Toaca wrote:

[...]

>>>> I also do not see why I would check if the offset is a multiple of
>>>> the erase size, since the erase fails gracefully.
>>> My understanding is, that the erase operation should erase the QB data
>>> from the SPI NOR, not ignore failure and keep the data there ?
> If there is data in SPI NOR it means that a previous write was successful,
> thus the erase shouldn't fail (as the write method in qb save also uses erase).

It is possible to write to a non-erased SPI NOR, even at unaligned 
address. It is not possible to erase at unaligned address.

>> It seems that on iMX95 B0, the DDR_DUMMY offset is 0x76400 (aligned to 1
>> kiB, which is too low):
> Yes, this is indeed too low. We align our DDR_DUMMY offset to 0x1000 (4KiB) in
> imx-mkimage, I see that here is not the case. At the same time, aligning
> it everytime (even for eMMC/SD case) to 64KiB seems overkill.

Are you testing this patchset with upstream U-Boot mkimage ?

>> This makes the "qb save" work reliably even on SPI NOR, because the erase
>> block is aligned to 64 kiB instead of 1 kiB as it was before. Maybe we need
>> such an alignment change ?
> 
> My suggestion is that we align it with what happens in imx-mkimage
> and make ddr_dummy take an additional argument specifying the alignment.
> (and leave 4KiB default alignment in the dtsi, which should be fine if
> SFDP is used).
> 
> If you're ok with this, I will start working on a patch.
This is fine by me, thank you.
