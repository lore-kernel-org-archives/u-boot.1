Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B767AC30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE42886C3;
	Mon,  1 Jul 2024 15:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA9A88667; Mon,  1 Jul 2024 14:39:18 +0200 (CEST)
Received: from EXCEDGE01.prodrive.nl (mail.prodrive-technologies.com
 [212.61.153.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DE8884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 14:39:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=prodrive-technologies.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=paul.geurts@prodrive-technologies.com
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by webmail.prodrive.nl
 (192.168.102.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 14:39:15 +0200
Received: from EXCOP01.bk.prodrive.nl (10.1.0.22) by EXCOP01.bk.prodrive.nl
 (10.1.0.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Jul 2024
 14:39:15 +0200
Received: from lnxdevrm02.bk.prodrive.nl (10.1.1.121) by
 EXCOP01.bk.prodrive.nl (10.1.0.22) with Microsoft SMTP Server id 15.2.1544.4
 via Frontend Transport; Mon, 1 Jul 2024 14:39:15 +0200
Received: from paugeu by lnxdevrm02.bk.prodrive.nl with local (Exim 4.94.2)
 (envelope-from <paul.geurts@prodrive-technologies.com>)
 id 1sOGJO-00BGd5-QR; Mon, 01 Jul 2024 14:39:14 +0200
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
Date: Mon, 1 Jul 2024 14:39:14 +0200
Message-ID: <20240701123914.2685310-1-paul.geurts@prodrive-technologies.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a9ebece9-4ab6-4bca-bebe-985e0bf95278@oss.nxp.com>
References: <a9ebece9-4ab6-4bca-bebe-985e0bf95278@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Jul 2024 15:53:19 +0200
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
> On 6/26/2024 3:17 PM, Paul Geurts wrote:
>> Hi,
>> Thanks for the feedback.
>>
>>> Hi Paul,
>>>
>>> On 6/24/2024 8:09 PM, Fabio Estevam wrote:
>>>
>>>> Hi Paul,
>>>>
>>>> On Fri, Jun 21, 2024 at 10:06 AM Paul Geurts
>>>> <paul.geurts@prodrive-technologies.com>  wrote:
>>>>
>>>>> -struct imx_sec_config_fuse_t {
>>>>> +struct imx_fuse_t {
>>>> Please make the struct renaming a separate patch.
>>>>
>>>> Peng Fan, Ye Li,
>>>>
>>>> Could you please help review this patch?
>>>>
>>>> Thanks
>>> Can you take a look iMX8MP FIELD_RETURN fuse, I think it does not
>>> have 1 bit but 8 bits which requires to burn a sequence. Only when
>>> the bits sequence is matched, the field return can work.  So checking
>>> the bit 0 is not enough.
>> Are you sure about that? The security reference manual (IMX8MPSRM)
>> says in Table 5-5
>> that the FIELD_RETURN fuse is located on fuse 0x630[0], which is a
>> single bit. Also,
>> the "Chip Security Lifecycle" section (2.15.1) says the following:
>>
>> FEILD RETURN (SEC_CONFIG[1] fuse = 1 and FIELD_RETURN fuse = 1)
>>
>> Are you maybe confusing the FIELD_RETURN fuse with the
>> FIELD_RETURN_LOCK sticky bit?
>> clearing the lock bit _is_ quite the procedure, but it is unrelated to
>> U-Boot, as
>> this is done by ROM code through CSF.
>>
>> I tested this on an i.MX8M Plus and it seems to work fine.
>
> I know the steps for field return.  What I mean is the FIELD_RETURN
> fuse.  It is true that security RM mentions it as you quote. But from
> 8MP fuse map and ROM codes,  I get different things.
>
> FIELD_RETURN 8-bit code.
> FIELD_RETURN = 0, is non-field return mode, functional/secure mode.
> FIELD_RETURN = Matching Sequence, device is in field_return mode
> FIELD_RETURN != Matching Sequence, device asserts security violation

That is indeed different from what is mentioned in documentation. I have
asked our NXP FAE about the discrepancy and I will adjust the code if
needed.

>
>
> However, I'm not sure how is it implemented in HAB. Since you have
> tested 8M plus, can you confirm the closed part is successfully
> converted to field return and can boot without signing?

Maybe I did something wrong while testing. I will retest it on a new
board when I have received some more information from NXP.

>
>
>  Best regards,
>
> Ye Li
>
