Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A604DCAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 14:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396C8835CD;
	Fri, 26 Sep 2025 16:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DQHxbSNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C00835FD; Fri, 26 Sep 2025 16:53:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18119835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1758898418; x=1759503218; i=xypron.glpk@gmx.de;
 bh=lxgH9x51PBDQPCkTwvbAah4w7viMPAqxMQa8mYvoU4I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DQHxbSNUyCUSxJ3SzMV+eOwEF29HVfZcBGUwKl/ZyMYYVSS2JtlTnPdQgh60txdf
 kfxyty4ynukx1odtrMdCyIninpNB3Ft8G8NcRApWBC7QCZP3D7i7hyUY7kU35WcPX
 wiw5TMyJ625cABvHVvr7lPqa8BB9YW6mJpQXZ00l/yyCq8lsUhqDmEcm26DNryg5S
 I2XQp4zWYu7UmkdHaizwEZtEnXny12n6K8yWlqOJkWiOuNM+5Cn9Q2YeImDFIPhkf
 iH2uID3gyyxTnZDzggjse1w1xmKQZ+lB2I+cBv8Jl8nQmWhklYhAjDuFFpf7oQJT6
 VC9T2tf3uFEfdoEFGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1uHrgo1fxI-0127RQ; Fri, 26
 Sep 2025 16:53:38 +0200
Message-ID: <0ce44ac9-bfd0-4356-bbe5-1745c31cb729@gmx.de>
Date: Fri, 26 Sep 2025 16:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bootstd for sunxi
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
 <20250924163413.GJ197373@bill-the-cat>
 <CAFLszTh7so42FH2pms7dqzXFSz0vbOcab-GRmFCOaqLe2DL6fw@mail.gmail.com>
 <20250925010615.GK197373@bill-the-cat>
 <CAFLszTg5oOzt5poKdify8Hf44WVgy-uyb1tcmaUZ--auTd-xqQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTg5oOzt5poKdify8Hf44WVgy-uyb1tcmaUZ--auTd-xqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bo7D/iWuTXY0TaIGs2uA9cEAlr6QNPxLaJ2PqY0BoH4gWZZr2LC
 68VToP4i/GkoigSFpOTdnvnme3uMb6Y7syt7R/wTzSdiV6ZmzC6hLadshNB207SV0YxZxqK
 A9QVcw7kbWGGq3w4RoJtA44q4yEMCNgWE73EHQZkoeeFdNVVHwATIW9NwsWlARkqsQCLHRT
 Sx3K0Urq1dqsZ6gUinkPw==
UI-OutboundReport: notjunk:1;M01:P0:wUwlh28FN84=;9L5+fiMQ7IZ1go85/O0XAwR3V5v
 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
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

On 9/26/25 16:47, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 24 Sept 2025 at 19:06, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Sep 24, 2025 at 06:34:53PM -0600, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Wed, 24 Sept 2025 at 10:34, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Sep 24, 2025 at 10:28:45AM -0600, Simon Glass wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> After the discussion on the call this week and Andre's suggestion of
>>>>> putting FEL as the first global boothmeth, I took a look this mornin=
g.
>>>>>
>>>>> I created a new v7 series without the 'efi_loader: bootstd: Drop
>>>>> bootmgr for sunxi' patch.
>>>>>
>>>>> It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
>>>>> enough. The FEL boothmeth is first, which is good. But Heinrich did =
a
>>>>> series to reorder bootmgr which hasn't landed and specifically I had
>>>>> concerns about this patch[1].
>>>>>
>>>>> Given that Heinrich can't make the calls, I'll talk it through with
>>>>> him separately and reply on this thread. For now I don't see much
>>>>> benefit in sending the new v7 series, but I can if desired.
>>>>
>>>> The biggest blocking part of the sunxi series became that it showcase=
d
>>>> the more generic problem with integration of EFI and standard boot [2=
]
>>>> so yes, getting that resolved first is the next big blocker for tryin=
g
>>>> to migrate more platforms. It was unclear to me then, and still uncle=
ar
>>>> to me now what the value is in exposing more platforms to what I beli=
eve
>>>> ends up being a less than optimal experience is compared with what th=
ey
>>>> experience today.
>>>
>>> I'm not sure about the less-than-optimal, but I suspect this is the
>>> bootmgr kicking in and checking the network. Heinrich has something
>>> for that and I'll talk to him in a day or two.
>>
>> Well, that's not how [2] was summarized, but it's hard to know without
>> anyone being able to try it.
>=20
> My understanding is that Andre wanted to disable bootmgr for sunxi, or
> have it look only at devices mentioned by its boot variables, but
> Heinrich did not.

I would assume that I am not the only one that wants to run a Linux=20
distro on Sunxi with out of the box experience. Ubuntu works just fine=20
on my devices booting via EFI. Installing BSD also requires EFI.

Best regards

Heinrich

>=20
>>
>>>> But since no one can actually test things out and see what is or is n=
ot
>>>> different with the switch, yes, you should post v7.
>>>
>>> OK, done! Something wrong with CI, but not sure what.
>>
>> It seems something is going on with docker.com.
>=20
> OK
>=20
>>
>>>> [2]: https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.=
1534931-4-sjg@chromium.org/#3418689
>=20
>=20
> - Simon

