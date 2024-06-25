Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E60C2BD09
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 03:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768718845A;
	Tue, 25 Jun 2024 05:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719284812;
	bh=NxeVzVrPvb+eRyiwSAKdj/78woc2JbVzF7MLpQD66sg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ih+L2eQKaJ39ETThzUb6HlKmubmowegAkhu7ksQTqdjvB7dnNEhmGSng2YUy3uoBE
	 fAOluBiY7EP5spFftZyIWmKTcS1Sk2MfPoKrNILgtjPFvOfV6AAPU5+t8+CWpsfkNY
	 Encd6B8zqZ+ipw6eLRga0S59zRsR6dVmmb85mw1jYv6MNmWKIa2V3eQ1MAf9b7oQ++
	 FD5U+R+XpEY0sD0arusV+045n3rnhO7YeVUm4Q5PX3wKeViDYrU1yXSAI/WHK8bIvR
	 OXkLvcuRr6sOkBODJjAq69M40STjGLAtET4R2/hboQiVhHWlWaWbmq5EzAZ0PC9jmn
	 KbEirwjf0+Pew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9546D883FE;
 Tue, 25 Jun 2024 05:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719284811;
 bh=NxeVzVrPvb+eRyiwSAKdj/78woc2JbVzF7MLpQD66sg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oFlNPiIVRWUFKcwxAV6K1/kWux4CUPZnN/C25OMzle0fljZ/UQaPHAHV59DX4UE1P
 dfcHugMlSIxJnqpgDJL5GGfbImIIjLu/UoGme7TSVGz5ZgQhX5aBbDkMs4iqVQBTDy
 7hWbvv5wmi1nBpj8RxScmKKB76TUG/K1gj2vZROfEyip3iOgz8pLVAUhXspqAF1U0R
 lftqbpVm4EwBgQPP4wopw7K0z3tyIZQILM5NBcPU30SunctmtBHTdS1laNyZL5BHIN
 +09efdm5aFrRGizv4ijmI/YMyxmdXIwPKKcPbziGiaK//fhlROUChsJpDkDl0lKSp2
 tJ02eOvL2W8TQ==
Message-ID: <a986f1da-d76a-4b43-a335-adea3648be05@denx.de>
Date: Tue, 25 Jun 2024 04:13:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, peng.fan@nxp.com, ye.li@nxp.com, eduard@lionizers.com,
 fedor.ross@ifm.com, rasmus.villemoes@prevas.dk, xypron.glpk@gmx.de,
 elena.popa@nxp.com, tharvey@gateworks.com, sjg@chromium.org,
 vitor.soares@toradex.com, u-boot@lists.denx.de,
 martijn.de.gouw@prodrive-technologies.com
References: <aba27158-0301-45b1-833d-ab84081b6242@denx.de>
 <20240624082020.1470964-1-paul.geurts@prodrive-technologies.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240624082020.1470964-1-paul.geurts@prodrive-technologies.com>
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

On 6/24/24 10:20 AM, Paul Geurts wrote:
>>> The decision on whether HAB is enabled is solely based on the SEC_CONFIG
>>> fuse. The HAB FIELD_RETURN feature is able to permanently disable HAB on
>>> a CPU, after which it is able to boot unsigned firmware. U-Boot however
>>> does not take into account the FIELD_RETURN mode, and refuses to boot
>>> unsigned software when the feature is enabled.
>>>
>>> Also take the FIELD_RETURN fuse into account when deciding whether HAB
>>> is enabled. When The FIELD_RETURN fuse is blown, HAB is not enabled.
>>>
>>> Tested on i.MX8M Mini, i.MX8M Plus, i.MX8M Nano and i.MX6ULL
>>
>> The purpose of the field return fuse is to unlock a system when it is
>> returned to factory, right ?
> 
> That is the intention of the field return mode indeed.
> 
>>
>> Can the system be re-locked afterward too ?
> 
> No, the field return is enabled by a fuse, which cannot be reverted. The
> mode is intended to be able to perform investigations on broken devices,
> but these devices are not intended to go back into the field.

Understood, thanks for clarifying.
