Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6FBC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 17:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B6FF88EBB;
	Fri, 26 Apr 2024 19:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714152588;
	bh=Fv6YFtbH/Jpx0a0qRwp0Cj88rYlsaug5d/77rTrPQ+Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fT6NRSblJTvYrePnyxoeMfBJDEO8w0hRWOFtI7vw1zASvODICQj3Vc4WikiWnBwQ1
	 F8hUb6cqToAK5fFUlKstV2qhywOIgo0XMCh5rj79ZNTT8vwjG1dDdyus5R1D7u3I3D
	 rNMI8mkgIzRqPfUu/uEJ2ENDVvdzvfD5tjDLbt9piaOAdWHlCAZ/5JiWNWG7EDc810
	 AlvkBV3YKdIEeR+RtiUmzCJ4bBHS6p8npMIrcj086NeIiZJfnA1TRKzz3V/fT6Kc1v
	 mvWxK61CEBqwXktnauQ6fvE2XCrlco4VkJBjryLh+R8Ezd3IRXo23DeNBXOfd+44ai
	 cFudjAFM6LFbA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C68098826E;
 Fri, 26 Apr 2024 19:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714152587;
 bh=Fv6YFtbH/Jpx0a0qRwp0Cj88rYlsaug5d/77rTrPQ+Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nCtb441EeUgHgb+/fyIwo/8IPxsHCV834GsQjgc4lADH/VhG675FpadU3tJ3UgAWY
 aCsC/fjukh1+wC8ipMW4Vm3tVIJTO4L8VthNPPbV/5RvADDd0CYZ5xf1jRHaNd8s0J
 S9xGs7Dk3Bl4iXoGLkeZhL0mrw+kcsLxcrqyQRoPTgn5Jx8cnBPp9wiN48hwb463wg
 8E8w0Vhr3sy6yvmfWwANeg+FXSQ9ushVFRfGb0cuETBRkEUn7w7SdNDuTG88wHLPz8
 cK/AZFOSmVZntsZMmintBjT7LbnakjVSeGZEzhmU/RsE5408F6Lo6SCadXZLfJzEab
 GPnclgnSnUkBw==
Message-ID: <87755b1f-c4cf-4647-b604-7b7d4e7dab8b@denx.de>
Date: Fri, 26 Apr 2024 19:29:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
 <8d75e195-d644-4436-8007-8476da589032@gmx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8d75e195-d644-4436-8007-8476da589032@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/26/24 4:39 PM, Heinrich Schuchardt wrote:
> On 26.04.24 06:03, Marek Vasut wrote:
>> On 4/26/24 2:16 AM, Tim Harvey wrote:
>>
>>>> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefile
>>>> index 7a2543e16cc..4fbce519a0b 100644
>>>> --- a/drivers/crypto/fsl/Makefile
>>>> +++ b/drivers/crypto/fsl/Makefile
>>>> @@ -6,6 +6,6 @@ obj-y += sec.o
>>>>   obj-$(CONFIG_FSL_CAAM) += jr.o fsl_hash.o jobdesc.o error.o
>>>>   obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) += fsl_blob.o
>>>>   obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
>>>> -obj-$(CONFIG_FSL_CAAM_RNG) += rng.o
>>>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) += rng.o
>>>>   obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
>>>>   obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
>>>> -- 
>>>> 2.43.0
>>>>
>>>
>>> Marek,
>>
>> Hi,
>>
>>> Thanks - this series does solve the issue I am seeing in the SPL when
>>> enabling DM_RNG. Is this going to cause an issue for people who expect
>>> it to be currently enabled and now have to manually enable it?
>>
>> That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem
>> to be no users, so I don't think we need to worry here, right ?
>>
>> With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at the
>> users that enable DM_RNG, I am not seeing any obvious ones that would
>> require SPL_DM_RNG too. What do you think ?
> 
> Grepping for UCLASS_RNG should find usages.
> 
> The only possible SPL usage seems to be in net/net_rand.h. Here a
> fallback to the mac address as seed exists.

So this may need to be tested on AM335x with SPL ethernet boot ?
+CC Nishanth ?
