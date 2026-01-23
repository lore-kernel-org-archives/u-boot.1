Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E4CD6CFBB
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 04:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74293839D5;
	Fri, 23 Jan 2026 05:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PqOAqEZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67C8783AC5; Fri, 23 Jan 2026 03:11:44 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E92E8397D
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 03:11:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59b834e3d64so2251066e87.2
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 18:11:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769134301; cv=none;
 d=google.com; s=arc-20240605;
 b=XBWfmW4F46Y1y9PE2z3KtXqEVba0vh4e7gF4ezePpCawSGUBXwZINls88Rg0pg6F5O
 DUa87DfA/hDCGL8Zoe9GQ/pqR27X9ZX3YDNkI2xlCQ5ee4egZM3rpizGli9FLr60OXQs
 4s/8F+coJHkgyrv5eVdm0zdF/560gSy/RpApSODEVyahiNPRkZUihboFjY9yKP0qScdM
 Gnthvc9Ux3rTl3l3K8OGjmwsWe+D2HFuqKowKip1xHuOIEOXUtCy90Oo/ydKLWkQQY65
 NnWr94H5YZE6qMzhjo0FRtQnNUS955pcrMNuNblkUuyA9xxMAfpbMeKFe1UF2NJAurQI
 qb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DDo7pufPLI3WP1XKZY05AroYwQa7YmvjCs1zyVOPydU=;
 fh=iRFH3MgPC7wgzlKa9Kbr8z7p0ugw9sjGx91vbOxdENE=;
 b=NFIwMGhAXDLuU2Y7tIaRAZNib103Oo3vYQiqqvyEqzhN1HuKob3TGXZTP8Z2RfqO6B
 NBmXbzHlJcm9D4nBVLI/femIelyBTQPAuLdFCQQqUug3katRbqFR5qM9fiUmbk0GEqgn
 JCfX3nY3Tv2EppEeEgSgqc27m3mRqfV0jeSpns+X20W7D3grrFoyH1KjqjGN273tmYZe
 LAUI7ASlE1diqcLbnfUdC2SDanlVncSsGXvMupVsElfobJFx2zW3kP3kYFA3sNZfTarn
 OVT44bO0Q0jSBezNvtAbgP63K3hKnKSsgvDhDOKLKJep0c9sBgTE102wl3AYCDyogW/j
 n9eA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769134301; x=1769739101; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DDo7pufPLI3WP1XKZY05AroYwQa7YmvjCs1zyVOPydU=;
 b=PqOAqEZSpC377wu+vXkAiuX1u80/cUXou1Q9twb8fbhJFNW82+SWQ3n1Oxd7rMc7Ga
 IfqR2GpbVJjewxNcwb0au76/Pc7HjFAVbQdENYaIuH4qJxsSM/y8z64n5w34r25si8ND
 8xMgIAYaMm6hcrmVckANFwlcLHZCuiM6LzuCPoht4K0kvHHyv/zZBvnIjRNT7jqy77cU
 PTMMztZY9MdRDK3tgoJlgwdwPPcDZAcA+qENPTTGpA8Tm5h9fdB1yuteAHO5uXr0MKyz
 I/2SwOuwqwMxELmdXQup+gSgwyScRciJxHPp7XAIahIqC5lUUsGEtiJe+j4qwnPob+bR
 ndSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769134301; x=1769739101;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDo7pufPLI3WP1XKZY05AroYwQa7YmvjCs1zyVOPydU=;
 b=OIRjYJfIGWkFG/j3iCkBOTS3T9lV1qX1HYhk62AjBH3bP3yZ5TPab/5ImH5zbp38w3
 8RyBLv/BGkDpSGhhRUyriV1lxCB/IiUiz7394Qg1K6E1rS7/T2Qr7QpEeY0OI9X1f/Oz
 IkLbJTU+xIlRIJD4DlPPCTBtUUhlSjbxZQ7XxXNbFMA/bBTRMvw94VxmfCB/AJAO0YJv
 xFircNDemS525g9eSaZZbOcQbg3e/BHdpRAy6bGJolj7HUYa8leX5V/XG8lCfJQWZdeS
 9D4pajFehZkX3kSLCziPrrDptPKS0bbkeZUTbFLoZ5JK7z/lAJV5MoppryswmqpJ+KRg
 bnIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBSoqIp20WWHU3IkQekSMCl9MTh2THDr/PxCxD0XcV8btRfLHa5IbwitQQSaoHuEbIBjLULMQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzLVkvkFrt1ur6R/wgjBAr/xvUpvUrFuh63s8B7z2b/FTtkrAR8
 7kQQXT62u2PlDVRiSZuae2zgQB00tE2rXsILWPiT5sC4rEtIPeSyS5oxsXyVi+CAd1hTpDhgjBV
 S2/QMKkBHrvKn25/0eiuHd5B8AvIt2LE=
X-Gm-Gg: AZuq6aLPzHyJ8XLfbcPofxdvsxy/hXn+2FjAmSBfIMGU7yUZtUDyNnD0ZM6/PBkAxA4
 TjNmiNQdmSCpqfB3KQQ7OL0tlTASfkAgQNMcByojItuc4SKgi1yqEhDBZ1gYVZ3BlkQpBKKI8rz
 Mkqqu4qtNq707bH2lT012SJJkP9MlAUyrK9fDRB5IW/SLHA8jnwqkeRGOW57qq8AFZlrHkjGXsd
 Vltt3VRiluKqBcZEjZgmZD821ko6wDGkIvMP1gG5ng8uBEVCpRCmkIcjCRvTzFVC0l+ICEvMA==
X-Received: by 2002:a05:6512:ba1:b0:59c:bdd8:9d7e with SMTP id
 2adb3069b0e04-59de4a326d9mr385665e87.45.1769134300256; Thu, 22 Jan 2026
 18:11:40 -0800 (PST)
MIME-Version: 1.0
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
 <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
In-Reply-To: <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Thu, 22 Jan 2026 23:11:28 -0300
X-Gm-Features: AZwV_Qjh3qTUncF5sKtJULj-n4Y3A4O2ZMiNGjUAzSltEyXXMpJBhAGz0XG-qd0
Message-ID: <CAP8WwTGBmobvB_AvCd4SfxbDB5ZsNv8zGS_m9LQ_KPPKqCWHNg@mail.gmail.com>
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 23 Jan 2026 05:36:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Jan 22, 2026 at 10:12=E2=80=AFAM Mateus Lima <mateuslima.ti@gmail.c=
om>
wrote:

> On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> =
wrote:
>
>> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
>> >This patch adds CPLD support via IFC to the ls1021a-iot board.
>> >
>> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
>>
>> CI report build failure.
>>
>>   CC      drivers/video/hitachi-tx10d07vm0baa.o
>> In file included from drivers/misc/fsl_ifc.c:8:
>> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or directo=
ry
>>    16 | #include <asm/ppc.h>
>>       |          ^~~~~~~~~~~
>> compilation terminated.
>> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error =
1
>> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>   CC      drivers/rtc/ht1380.o
>>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
>>   CC      drivers/rtc/i2c_rtc_emul.o
>>
>> make[1]: *** [Makefile:2191: drivers] Error 2
>> make: *** [Makefile:362: __build_one_by_one] Error 2
>> Cleaning up project directory and file based variables
>>
>> Regards
>> Peng
>>
> Hi Peng,
>
> Thank you for the test, and apologies for not having validated the patch
> on other targets.
> In fact, this driver was not being used by any target (neither ARM nor
> PPC) and after this patch it became enabled again. However, PPC targets
> fail when trying to include the asm/ppc.h header, which is not available
> for some reason.
>
> For now, I am thinking of submitting a v3 of the patch adding an explicit
> dependency on ARM, something like:
>
> + depends on ARM
>
> This way we would avoid building the driver for PPC targets.
> What do you think about this approach?
>
> Thanks again for the report and the feedback.
>
> BR,
> Mateus
>
Hi Peng,

I have just run a pipeline in the U-Boot Azure DevOps environment and all
targets were built successfully. Please take a look:

https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12700&view=3Dr=
esults

Could you please let me know what you did differently that caused the build
to fail?

BR,
Mateus
