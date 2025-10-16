Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D6CCD199
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 15:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F8F2836C1;
	Thu, 16 Oct 2025 17:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=writeme.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=writeme.com header.i=sinan@writeme.com header.b="GCrYheBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A38C836D1; Thu, 16 Oct 2025 17:24:02 +0200 (CEST)
Received: from mout.mail.com (mout.mail.com [74.208.4.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C5C80077
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 17:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=writeme.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sinan@writeme.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=writeme.com;
 s=s1089575; t=1760628234; x=1761233034; i=sinan@writeme.com;
 bh=CqQ1uhG64SXgrVGj52Dj7ck9tECEatRYYjEg4B8OXwQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GCrYheBN2/dDFS4UAmTtcH8gVeNEyJ9hgcvP9RTa2MVfLcIKWjyBG7z8mjvjcQPW
 9WkT0XKkfvr8XldruqpqhCPIRgLUwvO6x5UQe+BZAsKopc38+kz2zrfVUkPMuGg+q
 4xL/AUaOS6IhDnXWL3JvkOO0M9Z8q+5syZzNDXKAR0S7I+KREv3Y4l6ZvDJtG1QjR
 U3zqzlMvOcl7RfxXTwxBBOvcCiONPXhq7jbMBMMVnet0fRP06sllywlCb0AByCUh4
 b6A7j6RfHYu2BxG2TxNIg6ryzAPq4uIHoKiNSiHQeJb0IX8MkAjCm7/Sd+tnrNw8j
 JpxacHa45SHwF4klGA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.4.12] ([208.111.77.233]) by smtp.mail.com (mrgmxus004
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LsSII-1uCFhy20b2-00zYuL;
 Thu, 16 Oct 2025 17:23:54 +0200
Message-ID: <6c7eb700-5417-4e50-90b8-ce45558ef44b@writeme.com>
Date: Thu, 16 Oct 2025 11:23:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External]Re: Uboot upgrade from 2016 to 2020
To: "Manea, Alexandru (Alexandru)" <amanea@avaya.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Priyanka Jain <priyanka.jain@nxp.com>
References: <SJ0PR15MB475808D1A536E7E2993BDD1DDCEBA@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <20251015221933.GW6113@bill-the-cat>
 <5b6c23df-1b90-4ff7-80b9-e68f6e08f242@writeme.com>
 <SJ0PR15MB47583424C26BA0F2290F1532DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
 <11ae527d-5d5d-4ae7-a3de-024c2edaeaba@writeme.com>
 <SJ0PR15MB4758865E802D76404B080A98DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
Content-Language: en-US
From: Sinan Akman <sinan@writeme.com>
In-Reply-To: <SJ0PR15MB4758865E802D76404B080A98DCE9A@SJ0PR15MB4758.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0M7WU0AW6nIt+ClfEQGQ8WlAle/ceabnSFFfwDXJr+EH0dqZeN7
 U9OupVadx9ihlDTJgBbzNM7QIlIqMja5dz7+c78X83CwIhpiZmEop7llxjbxELDC3UcTdK/
 Ji+kJMQTZDbsIeLFMpSM68xtlG9HXBydvA6gE0FpgXAsWX/zhSNf7O1XU5GFN+A5KDAn7QD
 C6nc+n1w1Guda408nS6WA==
UI-OutboundReport: notjunk:1;M01:P0:0oimv8EC0fw=;UZe+Y9U49YyufPPEEqC48E6SWE/
 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
 PcWvA==
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

Hi Alex

On 2025-10-16 10:42, Manea, Alexandru (Alexandru) wrote:
>
> Hi Sinan,
>
> We have a very limited supply of boards, maybe one we have everything=20
> ongoing we could arrange for one.
>
> Is there anything I can provide so you could help me out a bit? I=E2=80=
=99m=20
> stuck with this hanging situation and I=E2=80=99m running out of idea wh=
y it=E2=80=99s=20
> not working=E2=80=A6as it matches most of the old working uboot settings=
=E2=80=A6
>
>
> Regards,
>
> Alex
>
> *From:*Sinan Akman <sinan@writeme.com>
> *Sent:* Thursday, October 16, 2025 5:39 PM
> *To:* Manea, Alexandru (Alexandru) **CTR** <amanea@avaya.com>; Tom=20
> Rini <trini@konsulko.com>
> *Cc:* u-boot@lists.denx.de
> *Subject:* Re: [External]Re: Uboot upgrade from 2016 to 2020
>
> Hi Alex On 2025-10-16 01:=E2=80=8A26, Manea, Alexandru (Alexandru) wrote=
: > Hi=20
> Sinan, > > First thanks for replying. I do hope you will be able to=20
> help me a bit. > The board is PPCE5500 used for Avaya IP500L platform.=
=20
> > > What I noticed
>
> Hi Alex
> On 2025-10-16 01:26, Manea, Alexandru (Alexandru) wrote:
> > Hi Sinan,
> >=20
> > First thanks for replying. I do hope you will be able to help me a bit=
.
> > The board is PPCE5500 used for Avaya IP500L platform.
> >=20
> > What I noticed for hanging is that it hangs when setting mtspr=C2=A0=
=C2=A0=C2=A0 IVPR, r0 in start.s although this seems correct: CONFIG_SYS_M=
ONITOR_BASE@h
> >=20
> > Regards,
> > Alex
> >=20
> > From: Sinan Akman <sinan@writeme.com>
> > Sent: Thursday, October 16, 2025 3:00 AM
> > To: Tom Rini <trini@konsulko.com>; Manea, Alexandru (Alexandru) **CTR*=
*=20
> <amanea@avaya.com>
> > Cc: u-boot@lists.denx.de
> > Subject: [External]Re: Uboot upgrade from 2016 to 2020
> >=20
> > [External Sender]
> > Hi Alexandru On 2025-10-15 18:=E2=80=8A19, Tom Rini wrote: > On Tue, O=
ct 14, 2025 at 10:=E2=80=8A21:=E2=80=8A37AM +0000, Manea, Alexandru (Alexa=
ndru) wrote: > >> Hi, >> >> I have an issue with upgrading our sources to =
use the 2020.=E2=80=8A04 uboot rather
> >=20
> >=20
> > Hi Alexandru
> >=20
> >=20
> >=20
> > On 2025-10-15 18:19, Tom Rini wrote:
> >=20
> >> On Tue, Oct 14, 2025 at 10:21:37AM +0000, Manea, Alexandru (Alexandru=
) wrote:
> >=20
> >>
> >=20
> >>> Hi,
> >=20
> >>>
> >=20
> >>> I have an issue with upgrading our sources to use the 2020.04 uboot =
rather than the one working now on our system which is 2016.
> >=20
> >>> After adding all our board changes, I can see the SPL loading and se=
tting DDR and TLB entries but once it tries to jump to uboot from mmc_boot=
() it hangs and I can't get to see anything...has anyone encountered this?=
 Is there something I can do to make sure uboot is actually being jumped t=
o or why the hang? I've set the offsets to go to the _start_e500: instruct=
ions like the old uboot. I can share the traces I have if needed. Looking =
forward to an answer.
> >=20
> >>
> >=20
> >> There might have been some issue with certain PowerPC platforms
> >=20
> >> introduced after the v2016.xx releases and fixed later than v2020.04,
> >=20
> >> and git log might help. Of course, it would be better still if you co=
uld
> >=20
> >> move to current mainline and then help with PowerPC maintenance, as w=
e
> >=20
> >> do need more people helping there. Thanks.
> >=20
> >>
> >=20
> >=20
> >=20
> >=20
> >=20
> > Which board is this for ?
> >=20
> I don't have access to P50x0 or T10x0 boards to test and debug this
> but I might try to see if I can get my hands on a T1040RDB or one of
> your boards (e.g. IP500L). As Tom mentioned any help you can provide
> is definitely very welcome here in this area.

First a minor thing : we don't really top post in discussions here. We=20
provide
our comments after quoting the others. It helps to have good flow and
also this is part of the etiquette so please consider not to top post.

For debugging, what I suggest is that you bisect the mainline u-boot tree
to find the commit point (or set of commits) that the break you are=20
observing
happened.

Once you find where the break happened you can try to understand what
this commit was trying to do and why it caused the break. With this you
can provide a new patch to fix the problem.

You would probably also need to do some debugging at the board level.
For this I would recommend to use a JTAG debugger like BDI3000 (or
others). You might have one already in house or in the case of BDI3000
you might be able to find a used one.

Finally, I suggest to start a new discussion with all your findings and fo=
r
a potential patch ides. While doing this please use a better subject line
indicating clearly what architecture/platform this is related.

I am also cc'ing now Priyanka Jain as I believe the name shows as the
maintainer now for some of the NXP e5500 boards.

Hope this helps. Enjoy u-boot debugging and thanks for all your help.

=2D- sinan

