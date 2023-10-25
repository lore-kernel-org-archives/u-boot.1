Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C520C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 15:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE138718D;
	Wed, 25 Oct 2023 17:28:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XjlQ9Lwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65B5F86F91; Wed, 25 Oct 2023 17:28:27 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF5687ABB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 17:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698247692; x=1698852492; i=xypron.glpk@gmx.de;
 bh=7rsnTYrseRcNlRTQ1nxMAVm0iKSdhiiJ7uHY4aTcDSs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=XjlQ9LwnUT4UF0pKKT8FyDiX1BaR3Zle9oMD6MyM3BFtJmKS2SoRlWGs+K9+KJLU
 03gQ/08eHawZo+ezYQ2fcMxNAiWfrGE1zjT6pTqXuoUOR062WrCpYQjUfDXcLS2op
 uQlHVR9Qglj2LWCFke2e9VIvpTzE84+3yLYox8kG6YgMeYPmdw5Y9RBpjWygoMoG0
 x5WfgZN7Jn+4dcB6dqgXZewY0OLgEPxFWqBY+DEFIO+KUP7ebuh8ND3qNhEgrZlF9
 rTExQz+e9lIMy/QIFOjAnibOuChhz+NHkcE9Wble07w1yHaJBxAKVP4Oh5j4M456I
 FlQlguMZxDXAHjoZWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwQTF-1rnUyX0DdV-00sRdV; Wed, 25
 Oct 2023 17:28:12 +0200
Message-ID: <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
Date: Wed, 25 Oct 2023 17:28:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231025142842.GQ496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lABL/FGcxfBRfk87r7PuKK96kOxAzEBDjLefZ6BjivOHqrki/TP
 DIuddH/PjVJ/PcQZa6r9nxLj89gVvbfdeTQ0OutBfQYZeLxhIRXbvdvzM0f/9MwRsQCEZ8e
 kvCOLM79k8EaAjpoGJq/qdovP4g7yT2cF0zh0blw7I2mQmo/K8dmCKeG70WswqpZLSDKmXM
 x0EVKKHeThtXsppUn5/fw==
UI-OutboundReport: notjunk:1;M01:P0:Rxb11Qia8xY=;wZZPpmUQ1vuWC+rETLPDD5M05Cv
 bau4bsyb1oSVFpsPifdzWiLpFQzWmkLXmOeIIkV9Qa0WvMdLzJxOwcjp26k/Knu/ed3lb68Sf
 mCONwGu5mqd6Yle0tg18nPAx7vCHD5LkHh+4da7Qp7gDa1n0XwmCUtX3rIENGHo6YJCWm2HtD
 r7NR9X2Wu7pIzeFyOcMy6/sjjS5N4dXQY7zhLZf1FX3mvVhSbPPqWUi3RRIfwn10qGkeStabD
 tR72mekknDnbBG43m6uxFO+BiLInT8arh9c+vv+IBKrzboWQ5HjTR+2mxGCOzophPpeR6VlpG
 gyGtAGPov3kdy4eogdWF7ax8TjpFPudUuM8SlHc4rzSifZYK1DporfXQlXRUreCfaMbgXUJLo
 yUtQGEWAD9ZsZcDMg4Nsdt6YeJpALKZwpMGR+0ao5W1mbc2WyfL21hT6B6KEB6YyV0ZeQqVVQ
 QZlnelp1WJ1bCETMHM7VZIZrYlx5eAx07TPihqi0juScJjkyKGHxorfIDBSEBkBdtB3haag6A
 wSx8yW9YE1bhXMlC3P9bPq8CSL9WIQBPm3WgVSSg0RdWBnay+7O44XURCgzDf3fPCQz+TInP4
 jL1Es3iGDtWWlWBPnH1aIFwcgMHbgkJcWxMPMlgwT5DZ8lIO1aVAscb40jEICVIl9tvT/+1Xf
 lONJnwZX96dWVc2kMsUZbUd1sHnWCyNUIGcGhTcrLd9Edpp7pXl5xLEBKWr05t/abz+01VvWo
 d8ZDutPlkOucSTC7MtlJgppXFbBl4S+Gcfp3Ix83+dwev4PSFW1DG80ReUHZTCsvTSlBpQhJA
 hu/B+tXinkVemiR52xdMYt9T15A7+YykDIWwrq0ZgADU7JhVA3P682B3OxIWvClAdWkVn8xWk
 MLQhrN/zlQvLB2OYyWi3ZxEHIsonUKxHbW7UEeF1xW/CH9u+1paOp0XSoyI9r2tBzYlUoO3Rm
 FIfJLOj6GgQRAlouUFx7HNKsCzg=
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

On 25.10.23 16:28, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
>>> Date: Tue, 24 Oct 2023 18:34:05 -0400
>>> From: Tom Rini <trini@konsulko.com>
>>>
>>> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
>>>>> From: Simon Glass <sjg@chromium.org>
>>>>> Date: Mon, 23 Oct 2023 00:04:14 -0700
>>>>>
>>>>> Hi Caleb,
>>>>>
>>>>> On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.=
org> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>
>>>>>> On 21/10/2023 01:45, Simon Glass wrote:
>>>>>>> U-Boot typically sets up its malloc() pool near the top of memory.=
 On
>>>>>>> ARM64 systems this can result in an SMBIOS table above 4GB which i=
s
>>>>>>> not supported by SMBIOSv2.
>>> [snip]
>>>> There is absolutely no guarantee that arm64 machines have memory belo=
w
>>>> 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Optero=
n
>>>> A1100 SoC and all the recent Apple SoCs.
>>>
>>> So one thing to resolve here is where does that requirement about the
>>> SMBIOS table needing to be below 4GB come from (standards wise), and i=
n
>>> turn is that obeyed by consumers like say Linux or OpenBSD? Answering =
my
>>> own question, maybe in part, https://www.dmtf.org/standards/smbios rea=
ds
>>> to me like there's a v3 and maybe we should be doing what we need to
>>> support / identify as that, if it doesn't have that restriction?
>>
>> Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete and
>> uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So to
>> fix this U-Boot needs support for SMBIOS 3.x.
>
> OK, thanks.  And for clarity / repeating my confusion, at least right
> now we also set the major/minor in the struct to 3.0.
>
>> Personally I don't see why we'd need SMBIOS support on non-x86
>> platforms, which is why implementing this isn't a high priority for
>> me.  I simply disabled SMBIOS support for M1 for now.
>
> This I think in turn (based on Heinrich's emails in v2 of this patch)
> EFI_LOADER wants to pass SMBIOS (probably 3) information along so that
> human user facing tools can see the kind of info that table provides.
>

If you have to manage a fleet of devices, be it Apple laptops, small
servers or IoT devices, you want to be able to retrieve information
about these devices like installed firmware, serial numbers, etc. This
information should be presented by our SMBIOS implementation.

Other EFI architectures (ARM and RISC-V) target the same markets as x86.
The customers expect that they can use the same tools irrespective of
architecture.

Best regards

Heinrich
