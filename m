Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F07C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A0188714;
	Tue,  2 Jul 2024 15:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E3B883AC; Tue,  2 Jul 2024 11:09:53 +0200 (CEST)
Received: from EXCEDGE02.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4094988113
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 11:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 11:09:24 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 11:09:29 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Tue, 2 Jul 2024 11:09:29 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sOZVw-006yrI-QV; Tue, 02 Jul 2024 11:09:28 +0200
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
To: <festevam@gmail.com>, <ye.li@oss.nxp.com>
CC: <sbabic@denx.de>, <uboot-imx@nxp.com>, <trini@konsulko.com>,
 <peng.fan@nxp.com>, <eduard@lionizers.com>, <marex@denx.de>,
 <fedor.ross@ifm.com>, <rasmus.villemoes@prevas.dk>, <xypron.glpk@gmx.de>,
 <elena.popa@nxp.com>, <tharvey@gateworks.com>, <sjg@chromium.org>,
 <vitor.soares@toradex.com>, <u-boot@lists.denx.de>,
 <martijn.de.gouw@prodrive-technologies.com>
Subject: Re: [PATCH] imx: hab: Make imx_hab_is_enabled dependent on
 FIELD_RETURN
Date: Tue, 2 Jul 2024 11:09:28 +0200
Message-ID: <20240702090928.1663707-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <038dad39-e99a-4464-be5e-57a3a73ca8af@oss.nxp.com>
References: <038dad39-e99a-4464-be5e-57a3a73ca8af@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jul 2024 15:00:15 +0200
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

Hi Ye,

> Hi Paul,
>
>On 7/1/2024 8:39 PM, Paul Geurts wrote:
>> Hi Ye,
>>
>>> Hi Paul,
>>>
>>> On 6/26/2024 3:17 PM, Paul Geurts wrote:
>>>> Hi,
>>>> Thanks for the feedback.
>>>>
>>>>> Hi Paul,
>>>>>
>>>>> On 6/24/2024 8:09 PM, Fabio Estevam wrote:
>>>>>
>>>>>> Hi Paul,
>>>>>>
>>>>>> On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts
>>>>>> <paul.geurts@prodrive-technologies.com>  wrote:
>>>>>>
>>>>>>> -struct imx_sec_config_fuse_t {
>>>>>>> +struct imx_fuse_t {
>>>>>> Please make the struct renaming a separate patch.
>>>>>>
>>>>>> Peng Fan, Ye Li,
>>>>>>
>>>>>> Could you please help review this patch?
>>>>>>
>>>>>> Thanks
>>>>> Can you take a look iMX8MP FIELD_RETURN fuse, I think it does not
>>>>> have 1 bit but 8 bits which requires to burn a sequence. Only when
>>>>> the bits sequence is matched, the field return can work.  So checking
>>>>> the bit 0 is not enough.
>>>> Are you sure about that? The security reference manual (IMX8MPSRM)
>>>> says in Table 5-5
>>>> that the FIELD_RETURN fuse is located on fuse 0x630[0], which is a
>>>> single bit. Also,
>>>> the "Chip Security Lifecycle" section (2.15.1) says the following:
>>>>
>>>> FEILD RETURN (SEC_CONFIG[1] fuse = 1 and FIELD_RETURN fuse = 1)
>>>>
>>>> Are you maybe confusing the FIELD_RETURN fuse with the
>>>> FIELD_RETURN_LOCK sticky bit?
>>>> clearing the lock bit _is_ quite the procedure, but it is unrelated to
>>>> U-Boot, as
>>>> this is done by ROM code through CSF.
>>>>
>>>> I tested this on an i.MX8M Plus and it seems to work fine.
>>> I know the steps for field return.  What I mean is the FIELD_RETURN
>>> fuse.  It is true that security RM mentions it as you quote. But from
>>> 8MP fuse map and ROM codes,  I get different things.
>>>
>>> FIELD_RETURN 8-bit code.
>>> FIELD_RETURN = 0, is non-field return mode, functional/secure mode.
>>> FIELD_RETURN = Matching Sequence, device is in field_return mode
>>> FIELD_RETURN != Matching Sequence, device asserts security violation
>> That is indeed different from what is mentioned in documentation. I have
>> asked our NXP FAE about the discrepancy and I will adjust the code if
>> needed.
>
> Thanks for confirm. I also cross checked with teams. 8MP must burn a 
> pattern. Otherwise HAB won't covert to field return.

Okay, thanks for checking, I will wait for the details and make the necessary adjustments

>
> Additional, do you think it is very necessary to add this patch set?  
> Because field return is a pure debug feature, it won't be deployed on 
> productions. The developers working on field return parts can re-build 
> u-boot with CONFIG_IMX_HAB disabled.

In an OEM situation, is a lot of cases, the company creating the bootloader (OEM) is typically neither the one
singing the bootloader nor performing the FIELD_RETURN setting (end customer/VAR). The end
customer is typically neither interested nor capable of rebuilding the bootloader with CONFIG_IMX_HAB
disabled.

This means 2 bootloaders need to be maintained in parallel by the OEM, creating unnecessary overhead. This
also introduces additional risk as the end customer may sign the wrong bootloader (with HAB disabled).

>
> This patch may introduce risk to HAB in some sense,  especially for 
> productions. One mistake would make unsigned image bypass authentication 
> result.

I think this risk is mitigated by the fuse unlocking procedure imposed by HAB. I don't think someone
will accidentally go through the entire procedure of unlocking the FIELD_RETURN fuse and then
also accidentally burning the fuse. The risk in code IMO is not greater then the risk already there by
reading out the SEC_CONFIG fuse.

>
>
> Best regards,
>
> Ye Li
>
>>>
>>> However, I'm not sure how is it implemented in HAB. Since you have
>>> tested 8M plus, can you confirm the closed part is successfully
>>> converted to field return and can boot without signing?
>> Maybe I did something wrong while testing. I will retest it on a new
>> board when I have received some more information from NXP.
>>
>>>
>>>   Best regards,
>>>
>>> Ye Li
>>>
