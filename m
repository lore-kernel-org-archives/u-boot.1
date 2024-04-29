Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20661C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 13:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68452888CC;
	Mon, 29 Apr 2024 15:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714397294;
	bh=2bfS63GFzBK2rKq8vi46yg4dGImB6ed85w2NS5vv5Tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JYaAFhbR4urLvubUDcz6AALuwS7NC5AUt95mR7nyOBtbxx4I8PoDDzik2jSThpp1k
	 g11kR4nhWjFdIErebgxCMi99XMSqlfzah+oS7EP5Le6yBPM62XdFwSk8+EcxIGt5bt
	 IMEzfMSM5JxMlTRRqjG47FrHSRN6B83ozSrNmVfHjTYFozDN3ot3YOoh5ZIzmSEuca
	 aGXRUzUAfRjgMVNBuTVgW0mLijWXUg5f80OoTLzDjXgt7njwwgxCqZ4W+zbMwrmw63
	 j50SwDn37w0nqPdTPErp1X4n/lB52vQmD/gfvdJALGI3C6nQo/xogsFZUD8c8Cp/6u
	 EGX61r9f6IP6g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ED09F887EA;
 Mon, 29 Apr 2024 15:28:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714397293;
 bh=2bfS63GFzBK2rKq8vi46yg4dGImB6ed85w2NS5vv5Tw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MC5K47uBDSghjRhJ1VngPNxJYKu9aiBCRWDioFQwClzDYqP8J15Jf3rVMzw9OeoOt
 2MxvDCceDl6bziOi4M+pWND8RAgpw0ucqWo7oa6mabGB6H1BBc6rI0TC2Pwn/n9Jsc
 jJeoRlX01RVE6LQn8PpIb39up7iHR0n1FAtv8c3hF4Ouhahb3H5t6+5LJIiGCCpRVr
 63/Vf+suZFt+FEkPLUbxLOCKf5RTDmRcvI95FIkPbiaNcIOzmtJlMtd2Q0i8pMBCUb
 teT7qgIQ9Kag8Ywnocrvv/YNwkP2HTkVcaubKlM90abliZeOw7eYE/EDeGYzraY74L
 0O+xu3c+MsKTw==
Message-ID: <dc3973f1-ecee-426d-81ed-4c37b46eb2ff@denx.de>
Date: Mon, 29 Apr 2024 14:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Gaurav Jain <gaurav.jain@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>,
 Varun Sethi <V.Sethi@nxp.com>, Kshitiz Varshney <kshitiz.varshney@nxp.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
 <AM0PR04MB600444768BFB0DF8114EFAF5E71B2@AM0PR04MB6004.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM0PR04MB600444768BFB0DF8114EFAF5E71B2@AM0PR04MB6004.eurprd04.prod.outlook.com>
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

On 4/29/24 11:02 AM, Gaurav Jain wrote:

Hi,

>>>> diff --git a/drivers/crypto/fsl/Makefile
>>>> b/drivers/crypto/fsl/Makefile index 7a2543e16cc..4fbce519a0b 100644
>>>> --- a/drivers/crypto/fsl/Makefile
>>>> +++ b/drivers/crypto/fsl/Makefile
>>>> @@ -6,6 +6,6 @@ obj-y += sec.o
>>>>    obj-$(CONFIG_FSL_CAAM) += jr.o fsl_hash.o jobdesc.o error.o
>>>>    obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) += fsl_blob.o
>>>>    obj-$(CONFIG_RSA_FREESCALE_EXP) += fsl_rsa.o
>>>> -obj-$(CONFIG_FSL_CAAM_RNG) += rng.o
>>>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) += rng.o
>>>>    obj-$(CONFIG_FSL_DCP_RNG) += dcp_rng.o
>>>>    obj-$(CONFIG_FSL_MFGPROT) += fsl_mfgprot.o
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
>> That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem to be no
>> users, so I don't think we need to worry here, right ?
>>
>> With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at the users
>> that enable DM_RNG, I am not seeing any obvious ones that would require
>> SPL_DM_RNG too. What do you think ?
> 
> FSL_CAAM_RNG is enabled based on DM_RNG. This patch will disable the build of drivers/crypto/fsl/rng.c in SPL.

Is that actually a problem for any supported platform ?
(that is what is being discussed in this thread already)
