Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2467CC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBA4874D6;
	Thu, 26 Oct 2023 01:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F3v5btkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D8F874D8; Thu, 26 Oct 2023 01:02:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38EBC86F9F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698274951; x=1698879751; i=xypron.glpk@gmx.de;
 bh=i4Pxy1xbCwWhJvU6XpaQaPRIzsKIPHlMr8sSE8Slluc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=F3v5btkrtLCEHJNGIRd+6r4PWbyN11yIocahv85SyTKttM3tvJvAr2QCIXLf6+8c
 PPI5tBVV7Oeuh7jL6ftgmTA1noE/KRUAACggLV6yDfsqzuD8Fgiq1vordqQpaZOgw
 0+fCJIhxOVv4wuVeTOIpp1/wvSMmrFXWk3KYZv3ANJuP50EvVxewJNdk4BTOS6NCo
 nWPdPGw2roaYSQjhWNacqlIEf3HI+VaS4D+OrqGYcKcIPB03mEU7tEJyvSW/Oa9aX
 iSvGd6yAaW7XeSrmCmEPL59SNwnkmgeCxtPotxjOuXclroo/chCYSKAxf3M06TYpy
 NoFlEr/cyUNp/NTPqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1qtIzO05zl-002YGr; Thu, 26
 Oct 2023 01:02:31 +0200
Message-ID: <cce41111-3870-420f-9ca2-0a1ba51b3eb7@gmx.de>
Date: Thu, 26 Oct 2023 01:02:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
 <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
 <20231025142842.GQ496310@bill-the-cat>
 <ab2be1cb-f185-4f4e-83dc-d318fd2ab30e@gmx.de>
 <20231025170956.GU496310@bill-the-cat>
 <e05c870f-5522-4194-92d5-82e5c9808169@gmx.de>
 <20231025210913.GY496310@bill-the-cat>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231025210913.GY496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/dyTrb74S0fSkgSIcuW30Q15oD3Ll6FMqwmoqnmjIO0mHJW+QC
 W8qZTnWavcVZEef5E3rb2khCJ5jZPQSzVSMEspREwqiSIPUevccpnMhn1JV/YcaNqHjzTP8
 rYpQKi2x9mGl105AU9R4u8rWcUmhlQG8ShMriq846qjQ7Ee75p7FsbDL8vA3ovGcX/ph7k0
 GfceqeU24jjC62NR7GYmA==
UI-OutboundReport: notjunk:1;M01:P0:WDV/93j5tUY=;RVbvuir0sDXyf2yVC4nOnrJj4Si
 d9ppA5ulN0AI3EQ2Ah6v2TDTdy858mDBU5445A4NsyZpgsiClpfrSflwUnypcsDcSRbUdJClk
 dGH4Fn1doCz8G6tP0R1SE3F4KydOfYLPnl9KGJP/wuRCBu6d5H1xN9Fp09zH5bc+TAt3S3HZ1
 zHRTxjRXKz7lVsq5a+cgJF3viHIfB1zydstOmTrJxuxKV+msvdgA7U6bPfSaMSsf0AK1f6lRO
 KOIRDAWhfGPyY9i5ECRLoExNyQbFBc7Rq6BM3ZiVixQKFpSsAzq+dcpY7yl14QDiT4FXxWCMx
 xRTm0Nrw9ychSo+WMIkWtp615G/0yyCtlh/eDwH1t0uiTT2P/QWm82h/JV7rOjG1H0GfaMAO7
 vMkDTG4crxVoQCAEI4fox+qmyMylJ3DS7JTNIHaiSOij3U0ZanppO6FAayLyYmw0WjDeJ6pfC
 JioVZG2qn0fv300Pnd/x7Ibx40nlsSY4XpHfQn4FSzPORW3CxMru1VwifBM3Eqyr/XQD9PYwa
 392O+HmP7t/kal292Qwo/RrEuQrlZgfYr9q/qTuJ+hgdtK3NIXD/kz+gmgnp7nFuD7ra3Tw9W
 oMVJFhuIq572phO98Hb79BuON85H95rq9XcvdYv9YELn11jfZ68dgeMZjG5UBcA3Od1hmI1GT
 HXv1mRzZpi9r0+3YSaqH+9ihqr6TBQv/tFx28LrOWkcyTx5NYedfJzSpe59Y4J313vPyNXOjq
 PZgeSEwJi7kIR2EY/2t1PoUkKLm/X1+LbzeBIXwadAfH7+BtyayzaETD/GeNr+b/zhezoJYQc
 7h2F4bEeOaUgesJzucqCx5wz8yD6D0IJiv6jn2s3TaTrUSYsP3/9T6LtxuFL33Hg/FgMA6WPe
 KeFV2l1ZdHAW8uV0OK0h3VSJuIyA/L+abmXq1DwpPzs5588WcXe3hvmVG/em0D4SsuOgqdbjC
 sBPwSyLuVJ7+B2OjCKjPHIZ7AX8=
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

On 10/25/23 23:09, Tom Rini wrote:
> On Wed, Oct 25, 2023 at 10:52:48PM +0200, Heinrich Schuchardt wrote:
>> On 10/25/23 19:09, Tom Rini wrote:
>>> On Wed, Oct 25, 2023 at 05:28:10PM +0200, Heinrich Schuchardt wrote:
>>>> On 25.10.23 16:28, Tom Rini wrote:
>>>>> On Wed, Oct 25, 2023 at 04:18:20PM +0200, Mark Kettenis wrote:
>>>>>>> Date: Tue, 24 Oct 2023 18:34:05 -0400
>>>>>>> From: Tom Rini <trini@konsulko.com>
>>>>>>>
>>>>>>> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
>>>>>>>>> From: Simon Glass <sjg@chromium.org>
>>>>>>>>> Date: Mon, 23 Oct 2023 00:04:14 -0700
>>>>>>>>>
>>>>>>>>> Hi Caleb,
>>>>>>>>>
>>>>>>>>> On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@lin=
aro.org> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Simon,
>>>>>>>>>>
>>>>>>>>>> On 21/10/2023 01:45, Simon Glass wrote:
>>>>>>>>>>> U-Boot typically sets up its malloc() pool near the top of mem=
ory. On
>>>>>>>>>>> ARM64 systems this can result in an SMBIOS table above 4GB whi=
ch is
>>>>>>>>>>> not supported by SMBIOSv2.
>>>>>>> [snip]
>>>>>>>> There is absolutely no guarantee that arm64 machines have memory =
below
>>>>>>>> 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Op=
teron
>>>>>>>> A1100 SoC and all the recent Apple SoCs.
>>>>>>>
>>>>>>> So one thing to resolve here is where does that requirement about =
the
>>>>>>> SMBIOS table needing to be below 4GB come from (standards wise), a=
nd in
>>>>>>> turn is that obeyed by consumers like say Linux or OpenBSD? Answer=
ing my
>>>>>>> own question, maybe in part, https://www.dmtf.org/standards/smbios=
 reads
>>>>>>> to me like there's a v3 and maybe we should be doing what we need =
to
>>>>>>> support / identify as that, if it doesn't have that restriction?
>>>>>>
>>>>>> Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete =
and
>>>>>> uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So=
 to
>>>>>> fix this U-Boot needs support for SMBIOS 3.x.
>>>>>
>>>>> OK, thanks.  And for clarity / repeating my confusion, at least righ=
t
>>>>> now we also set the major/minor in the struct to 3.0.
>>>>>
>>>>>> Personally I don't see why we'd need SMBIOS support on non-x86
>>>>>> platforms, which is why implementing this isn't a high priority for
>>>>>> me.  I simply disabled SMBIOS support for M1 for now.
>>>>>
>>>>> This I think in turn (based on Heinrich's emails in v2 of this patch=
)
>>>>> EFI_LOADER wants to pass SMBIOS (probably 3) information along so th=
at
>>>>> human user facing tools can see the kind of info that table provides=
.
>>>>>
>>>>
>>>> If you have to manage a fleet of devices, be it Apple laptops, small
>>>> servers or IoT devices, you want to be able to retrieve information
>>>> about these devices like installed firmware, serial numbers, etc. Thi=
s
>>>> information should be presented by our SMBIOS implementation.
>>>>
>>>> Other EFI architectures (ARM and RISC-V) target the same markets as x=
86.
>>>> The customers expect that they can use the same tools irrespective of
>>>> architecture.
>>>
>>> Ah, we do have serial# being passed along that way (as well as other
>>> methods which is why I didn't think about them for SMBIOS). But this
>>> also doesn't answer my bigger concern which is that we're setting our
>>> version major to 3, our minor to 0 and then filling in a struct that's
>>> not the "smbios3" one that Simon's patch from another thread added. Is
>>> what we're filling out today semantically valid? I'm hoping someone wh=
o
>>> has already read over the spec / is familiar and I don't need to go do
>>> that right now.
>>>
>>
>> First of all there is a field "Anchor String". For a 32bit structure it
>> contains the value '_SM_', for a 64bit structure it contains the value
>> '_SM3_'. The different EFI GUIDs relate to these two different
>> structures. In our mails we simply referred to them as SMBIOS2 and
>> SMBIOS3 structures.
>>
>> Next there are the fields 'SMBIOS Major Version' and 'SMBIOS Minor
>> Version'. These should refer to the standard version 3.7 if U-Boot
>> adheres to the current version.
>>
>> As RISC-V was only fully added in SMBIOS version 3.4 we should not use
>> any older version of the specification.
>>
>> See
>> https://www.dmtf.org/content/dmtf-releases-smbios-37
>
> That's helpful.  Can we use an SMBIOS2 structure with 'SMBIOS Major
> Version' =3D 3 and be valid?
>

The SMBIOS specification 3.7 says:

"If an implementation provides both a 32-bit and a 64-bit entry point,
they must both report the same SMBIOS major.minor specification version"

This implies that SMBIOS Major Version =3D 3 is valid both in the 32- and
in the 64-bit structure.

Best regards

Heinrich
