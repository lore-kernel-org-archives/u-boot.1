Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7F9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 19:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5545882D9;
	Fri, 26 Apr 2024 21:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dM4BNvsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918C28845B; Fri, 26 Apr 2024 21:31:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D5B882A9
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 21:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1714159890; x=1714764690; i=xypron.glpk@gmx.de;
 bh=EWIjSiQUFticm1ZmO9sFXuQRti6ZVhmuiVukTmAjJjg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dM4BNvsFg7yoXikWRiAflUETHAuoUUWavYMZ9C9Xt5iO8wsJW2l21p6nMpnCKQ3K
 Od7v39rl3dbQ9xFkJ9duHb8S6mGdQmsi7KG8n8KqIRWE5r3Fq/LebtsCOQCxj85tx
 1wfGA7lH3kOELXucM7S2aKdhNx16ho3dDhlB1Pw7erNXMnTQSwy734SV1MRjm74Vb
 l50zxZ/scwqwDobi7Bs8u1+MxcFzJ3fJibZO+4136ZqmlC9rSwO5HfNVJDV052bec
 kGRV5rSx4LVnw5PmwzWuRjgwZMnFrxqM4cTuQoEVTR4G8zqsrSxIhjBIojR58I68g
 WquwrwiCydZHBFXXdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Hdq-1rynfM2Xu6-002pWO; Fri, 26
 Apr 2024 21:31:30 +0200
Message-ID: <9f77b7bf-7e47-4de0-b89f-57e67d992b8a@gmx.de>
Date: Fri, 26 Apr 2024 21:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] crypto/fsl: Introduce SPL_FSL_CAAM_RNG
To: Tim Harvey <tharvey@gateworks.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20240425230314.497203-1-marex@denx.de>
 <20240425230314.497203-2-marex@denx.de>
 <CAJ+vNU3ndKTXr5XBOd9b2aQF7WmBPARJ70Fsuab1rmnaQsEZiQ@mail.gmail.com>
 <94a75eb9-950c-41f0-b9fc-c7d95ecec6c6@denx.de>
 <8d75e195-d644-4436-8007-8476da589032@gmx.de>
 <CAJ+vNU1sYMGMeJemEaMvEO4RNS_Yb-BZse3x6dXehjHL-+Gfkw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAJ+vNU1sYMGMeJemEaMvEO4RNS_Yb-BZse3x6dXehjHL-+Gfkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q/ag/nVdKgfafAFyA894rYyp87eKgpmd+PdCLx5IXGfrPMlzy/a
 amrPNEL3wQSXOFZD9/MEQKc+n0FLDCorwGD4c9FmCtarMnWIvHagLqafviL67JwHbWdbr/J
 dsqsEIfyno/f4QYwaUuOkC6QbxNFYqkmK1JERY2KQi7RlcEz1l76KjvwPopfVwkRU1ZsRX4
 uIjdl7wA+E2wjTuSSqs7w==
UI-OutboundReport: notjunk:1;M01:P0:DD14ZI/TdbE=;+0OQ89yX2spBc8HYhqFZtGb1kSI
 aysKk60kNgpRKVFOrwFuojmdj74YUJfCR82vZIgbRPihzgwN3Up6OX5iHk2gF08ROnpYZmBBQ
 N136KvzOZ5y5dv95B9wJcKl0CjMh1C1G4hGxefLsa/smctKEtVsLno5BfjwkB/hScacvZOjaW
 gtVvkeKO7jf/0XaB+Ia0Qe27xHwT68XS4PkgenDhNDXjbJoDWxVTDYQsxkrg7z/CsbFaWvo3C
 YVqftsr/fp6gh8GLkAt801ziIA6D9++CAh5D2g5srtMJ1H1D/zym/DnRLWbOZJjjr+iHMRu5F
 oZD+UOt8d7H7kYBieGt/yxa4rsYU5e1B3SLobZdnfnP5dpDDtr0w9j7Xa+GysxFq2kLjK37Fm
 CYzMtSnh9GZT4Qr44baGFZX5kzsCIhz5AC35mPoDg5dk9ENlfzBpIbEn9KmT5VrcSoTgHfrIi
 60Hd3F3TRG05+zypCzGZMjBu2M8fE5pq1F2Q4JtOIjyAtnM0EFq6cDx+gZd8mi8CrfC5CoH6E
 as5dBYdVf7hj4RHkTsi6HUw9mDD2k5wQpHTHBdPmADZb0K1MDD2pGJ1wYwKMfa9guZEfaPFfg
 kDwB/ob0IEZlw1kWx+Z4C6+FSfQOOQfZxC0NG18ZKJi234D+Nij8bPXx/jNK2Ey7bzWxLsim3
 RuuYwJrp7hmjgfxQdPk7NaCJrj5LJI5BixNcamXxtBu0JOUmYkK4rZXL158eRfb8ndpXWPjVz
 eU+mceFNXue1s9DmASLd4Z5bAKqincuXhgL652LxBt41NdQt7AFnpb8LHm3O35ttX+LDBzQKx
 +CJ9c6Z3yNG9DSy4uSNjA0uBapBROfEPAOp0G+9VAz5AA=
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

On 4/26/24 19:34, Tim Harvey wrote:
> On Fri, Apr 26, 2024 at 7:45=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> On 26.04.24 06:03, Marek Vasut wrote:
>>> On 4/26/24 2:16 AM, Tim Harvey wrote:
>>>
>>>>> diff --git a/drivers/crypto/fsl/Makefile b/drivers/crypto/fsl/Makefi=
le
>>>>> index 7a2543e16cc..4fbce519a0b 100644
>>>>> --- a/drivers/crypto/fsl/Makefile
>>>>> +++ b/drivers/crypto/fsl/Makefile
>>>>> @@ -6,6 +6,6 @@ obj-y +=3D sec.o
>>>>>    obj-$(CONFIG_FSL_CAAM) +=3D jr.o fsl_hash.o jobdesc.o error.o
>>>>>    obj-$(CONFIG_CMD_BLOB)$(CONFIG_IMX_CAAM_DEK_ENCAP) +=3D fsl_blob.=
o
>>>>>    obj-$(CONFIG_RSA_FREESCALE_EXP) +=3D fsl_rsa.o
>>>>> -obj-$(CONFIG_FSL_CAAM_RNG) +=3D rng.o
>>>>> +obj-$(CONFIG_$(SPL_TPL_)FSL_CAAM_RNG) +=3D rng.o
>>>>>    obj-$(CONFIG_FSL_DCP_RNG) +=3D dcp_rng.o
>>>>>    obj-$(CONFIG_FSL_MFGPROT) +=3D fsl_mfgprot.o
>>>>> --
>>>>> 2.43.0
>>>>>
>>>>
>>>> Marek,
>>>
>>> Hi,
>>>
>>>> Thanks - this series does solve the issue I am seeing in the SPL when
>>>> enabling DM_RNG. Is this going to cause an issue for people who expec=
t
>>>> it to be currently enabled and now have to manually enable it?
>>>
>>> That's a good question. If I do '$ git grep FSL_CAAM_RNG' , there seem
>>> to be no users, so I don't think we need to worry here, right ?
>>>
>>> With SPL_DM_RNG i.e. 1/3 I am a bit more concerned. But, looking at th=
e
>>> users that enable DM_RNG, I am not seeing any obvious ones that would
>>> require SPL_DM_RNG too. What do you think ?
>>
>> Grepping for UCLASS_RNG should find usages.
>>
>> The only possible SPL usage seems to be in net/net_rand.h. Here a
>> fallback to the mac address as seed exists.
>>
>> Best regards
>>
>> Heinrich
>>
>
> Hi Heinrich,
>
> looks like its also used in lib/uuid.c by CONFIG_RANDOM_UUID and the
> few configs have CONFIG_RANDOM_UUID=3Dy do not have DM_RNG=3Dy so not an
> issue.
>
> srand_mac is used in:
> net/bootp.c which is CONFIG_CMD_BOOTP so not SPL
> net/dhcpv6.c which is CONIFG_CMD_DHCP6 so not in SPL
> net/net.c which is used by CONFIG_SPL_DM_ETH and the fallback you
> refer to but 'git grep DM_RNG=3Dy configs/ | cut -d: -f1 | xargs grep
> SPL_DM_ETH' shows no results so I think this is ok right?
>
> but I also see lib/efi_loader/efi_rng.c where UCLASS_RNG used by
> efi_rng_protocol - I don't know anything about efi... is this going to
> be used by SPL?

UEFI is only relevant in main U-Boot. The EFI_RNG_PROTOCOL is used for
KASLR by Linux but you can boot without it.

Best regards

Heinrich

