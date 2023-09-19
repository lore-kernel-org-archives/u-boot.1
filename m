Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA5BCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 22:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1055186A33;
	Wed, 20 Sep 2023 00:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695162502;
	bh=vuRt6C01CT1yIvne4wtT6Of7ZPjtjAnj4B+eyjVYdI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYYK6KiJJiSU1babfXoYtMoCVwchubDHrZsqSl/pgFWLjZBe0o0jm8o29BTFfeO80
	 5Pl4EVrJ1OhV3dvF33d/2bZOBfBOaWdRRbsLQXEK1/JT6rCZqhUKWXJx9kZ765im3N
	 MZU/gh/+MR0B8BRUHZohnFOyE033iS37CtYn0QjQVoS+NHLTMuG1yozzYeNj4Js/y7
	 lv/nyi6DTPt6x8Z4ESVEk4Rp1rVTW2YbMR6cJgJmPUXY8nmS8mNX0fi1/9ZrXjxk4m
	 BkoeZ9KVnffNEXWqpKzsKF6imvNR7E4DTZr1KjCOknhsSonVdu1/f59XzOIbZt8BHJ
	 DU1MDEQQtpz1g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 04FFC868D1;
 Wed, 20 Sep 2023 00:28:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695162500;
 bh=vuRt6C01CT1yIvne4wtT6Of7ZPjtjAnj4B+eyjVYdI0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UiuFOfVUZJjyeD022pW3WBGmjc8Gp4R/4uZmHKt5cvs440BPU0wwH1Q06XnbyeqDs
 bC9ScsyOs2+kc93GqcJDwGHINun/U5wK0VPsP8voBOFZVZiiZ5HYfFH91HUp5WkYUs
 H+kNFoodxzbKLy+cWC5G/0mbq9tWMQMmSEKinMbahsNjG/dSib7WfkU+JDcJrdNsqi
 6oc20NgRHnniyZTTGA8RFQN9j1//+O5+35eUUPIxRY0vd9Xd6FWJLlEoCXk1hR+kJZ
 K3LpPza1k22l2s70XwevpMJzlxobXYW7RGAE+wIbqixUe7JrUdRvZSxbcxuMEDZk1a
 vAe2Sy9LSYb8w==
Message-ID: <2b8df193-c9b5-b4af-e291-d84bbb13c7ed@denx.de>
Date: Wed, 20 Sep 2023 00:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mx8m: csf.sh: pad csf blob for u-boot.itb to CSF_SIZE
 minus IVT header
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 uboot-imx@nxp.com
References: <20230919100017.43523-1-rasmus.villemoes@prevas.dk>
 <ccce016d-3756-fae1-e074-70d94a9f8f6e@denx.de>
 <2c318328-2acf-cfd1-55e3-2074eda28929@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2c318328-2acf-cfd1-55e3-2074eda28929@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/19/23 21:15, Rasmus Villemoes wrote:
> On 19/09/2023 20.27, Marek Vasut wrote:
>> On 9/19/23 12:00, Rasmus Villemoes wrote:
>>> When built with CONFIG_IMX_HAB, the full FIT image, including stuff
>>> tacked on beyond the end of the fdt structure, is expected to be (fdt
>>> size rounded up to 0x1000 boundary)+CONFIG_CSF_SIZE.
>>>
>>> Now, when the FIT image is loaded from a storage device, it doesn't
>>> really matter that the flash.bin that gets written to target isn't
>>> quite that big - we will just load some garbage bytes that are never
>>> read or used for anything. But when flash.bin is uploaded via uuu,
>>> it's important that we actually serve at least as many bytes as the
>>> target expects, or we will hang in rom_api_download_image().
>>>
>>> Extend the logic in the csf.sh script so that the csf blob is padded
>>> to CONFIG_CSF_SIZE minus the size of the IVT header.
>>
>> On which SoC do you trigger this stuff ?
> 
> imx8mp
> 
>> (or rather, which bootrom version, v1 or v2? they each use SDP or SDPS
>> respectively)
> 
> Absolutely no idea. I just do "uuu flash.bin", which seems to DTRT
> automatically, I've never figured out the esoteric uuu language, and
> I've never found any actual documentation for it.

So yeah, MX8MP is SDPS (streaming).

> It also doesn't work without
> https://lore.kernel.org/u-boot/20230919134932.134678-1-rasmus.villemoes@prevas.dk/
> due to the spl_load_simple_fit() abuse.
> 
>>> +
>>> +# When loading flash.bin via USB, we must ensure that the file being
>>> +# served is as large as the target expects (see
>>> +# board_spl_fit_size_align()), otherwise the target will hang in
>>> +# rom_api_download_image() waiting for the remaining bytes.
>>> +CSF_SIZE=$(sed -n "/CONFIG_CSF_SIZE=/ s@.*=@@p" .config)
>>> +truncate -s $((CSF_SIZE - 0x20)) csf_fit.bin
>>
>> Can you use dd(1) instead ? I think dd(1) is more portable than
>> truncate(1) , at least I cannot find truncate(1) in opengroup specs.
> 
> Certainly.

Please do v2 with dd and then we should be all fine, thanks.
