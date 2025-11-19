Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583D7CF258E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 06:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA1A8397A;
	Wed, 19 Nov 2025 07:11:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GlpWKR8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C98283A57; Wed, 19 Nov 2025 07:11:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D28383979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763532697; x=1764137497; i=xypron.glpk@gmx.de;
 bh=nKlIoIwLQ+YpNlc0G26r+W0eAj/+SA7l5OmaPDYqsiU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GlpWKR8zEpYhGoWhdLaLS1Q8qP3ZRHPAvpIwCiMYdXW/FiV+8eTvWWixIjzlwwMr
 jZVTk5ImpKC+Q7hLNKLh07XKvRMO62fWgdgXfnq1sMzbhgceSN00gVlbwspEHki/N
 WTwrMMJwWKAB36fjU06HfoKZK/2EWtkjxAvC5jpTwk0EEcaWOXz6YNvyD37+Qc9AL
 DZBCQUkAFxZDKK+FD037WTepnatmF8QCxH6KIp9GoXkVvpYLExEOGCq706K8YMlYu
 NKJIltbkT2AIyPVXOn6j/oGXVeLrID7a2bKCBgyxQyHojE+6PoZiiZel23oyaOBDa
 eFXLzq6C6i02lr9cWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.154] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1w5HmA3n0o-017hwM; Wed, 19
 Nov 2025 07:11:36 +0100
Message-ID: <eb23054b-a9a4-4c62-a956-97b9ffef3f07@gmx.de>
Date: Wed, 19 Nov 2025 07:11:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: board: starfive: update jh7110 common description
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de, E Shattow <e@freeshell.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20251117233603.15409-1-e@freeshell.de>
 <24B5D5B7-0D3F-4091-82B8-A5E2328DE59F@gmx.de> <aRxKcvcc2IP-2dfw@pie>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <aRxKcvcc2IP-2dfw@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AWOeF95LYlUyf2vNkD5eY6Q7dIagGPGjPW5PTc88onhbMZkCnLj
 UyhBXuU5mCNAWFlVXGLKHj/Izixp9bLxk3sFzxxs0AS4cI0thNoL+MuJGmvRDi9l68SaVsr
 qgaszA56v3C5eep/PbbxT6IWBsgkGs6WdublTPL8yFwmJ7hVLUXbjBMhj9TAPPncLt2pKVS
 tQp3YvjGve9z0UVS2h3Ew==
UI-OutboundReport: notjunk:1;M01:P0:M/Yo5wCUTM4=;Wg9l5QCTWrOPuXj91Qu0mYZ0C/A
 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
 H5ku5Ye/Y22ZhlHGejPwtbUPkAZvj
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

On 11/18/25 11:29, Yao Zi wrote:
> On Tue, Nov 18, 2025 at 08:08:12AM +0100, Heinrich Schuchardt wrote:
>> Am 18. November 2025 00:35:51 MEZ schrieb E Shattow <e@freeshell.de>:
>>> Updates to the JH7110 common description:
>>> - add detailed overview of JH-7110 SoC and boot process
>>> - revise descriptions of deprecated StarFive loader modes
>>> - refresh build directions grouped with SPL debug advice
>>> - reduce usage instructions into common methods shared by supported bo=
ards
>>> - cite starfive_visionfive2 board maintainer description of StarFive l=
oader
>>> - cite published datasheets for ambient operating temperature data
>>>
>>> Redundant/deprecated sections of each board doc are dropped accordingl=
y:
>>> - deepcomputing fml13v01
>>> - milk-v mars
>>> - pine64 star64 (also add inclusion of JH7110 common description)
>>> - visionfive2
>>>
>>> Signed-off-by: E Shattow <e@freeshell.de>
>>> ---
>>> Changes since v1:
>>>
>>> By popular request I have expanded on the topic of deprecated boot mod=
es.
>>> For those users that rely on this it is now more descriptive about
>>> factors contributing to the feature deprecation and naming the U-Boot
>>> release version when this change is in effect. Re-introducing these mo=
des
>>> is out of scope for this documentation series, however.
>>>
>>> - reST needs a space between numeric and the substitution
>>> - add comment identifying where U-Boot SPL again reads state of [RGPIO=
1:RGPIO0]
>>>   useful to refer to for boards with button+transistors instead of MSE=
L DIP
>>> - cite reference to JH-7110 Boot User Guide BootROM description of Sta=
rFive loader
>>> - expand on topic of supported and deprecated U-Boot SPL boot modes
>>> - cite from published datasheets for ambient operating temperature dat=
a
>>> - drop not-yet-published OpenSBI version recommendation
>>> ---
>=20
> ...
>=20
>>> diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive=
/jh7110_common.rst
>>> index 4a8058ee5da..2f049b4c327 100644
>>> --- a/doc/board/starfive/jh7110_common.rst
>>> +++ b/doc/board/starfive/jh7110_common.rst
>>> @@ -1,103 +1,560 @@
>=20
> ...
>=20
>>> +There are additional unexplained GUID references in the JH-7110 MaskR=
OM so the
>>> +description given is not complete. Attribution and modifications to t=
he GPL2.0+
>>> +source code used in StarFive loader have not been published as of thi=
s writing.
>>> +Due to the lack of verifiable documentation the upstream Linux device=
tree does
>>> +not contain hints for mmc0 and mmc1 interfaces to be included in U-Bo=
ot SPL. As
>>> +of U-Boot release v2025.10 and newer the U-Boot specific devicetree o=
verride of
>>> +hints for mmc0 and mmc1 interfaces that are required for the deprecat=
ed modes
>>> +have been dropped marking the deprecation of these boot modes in U-Bo=
ot.
>>
>> Do you mean upstream  U-Boot will fail to boot from SD-card, which is t=
he Ubuntu default?
>>
>> This would need to be fixed urgently.
>=20
> U-Boot master has failed to boot from SD-Card on VisionFive 2 for some
> time, see my previous report[1] in Octorber.
>=20
> Best regards,
> Yao Zi
>=20
> [1]: https://lore.kernel.org/u-boot/aPYUlyni65Ux8xpq@pie/

Hello Yao,

Thank you for pointing to your former communication.

E's commit 27f617019dd0 ("riscv: dts: starfive: prune redundant=20
jh7110-common overrides") removed bootph-pre-ram properties - in=20
contradiction to the commit message - removed bootph-pre-ram properties=20
which were not provided by upstream device-trees.

I sent a mail to point to the issue on the kernel mailing list:

Re: [PATCH v2 4/8] riscv: dts: starfive: Split jh7110-common.dtsi and=20
move opp table to it
https://lore.kernel.org/all/ffdfc550-559b-4c59-9873-3f040fc3bb0e@canonical=
.com/

With that additional bootph-pre-ram I am able to boot from SD-card again.

I have not yet checked if something is missing to boot from eMMC.

Best regards

Heinrich
