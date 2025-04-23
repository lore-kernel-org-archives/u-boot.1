Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C56C369D7
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 13:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705C780FEC;
	Wed, 23 Apr 2025 15:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H7/Nk5gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A586380FA8; Wed, 23 Apr 2025 15:36:56 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8588082A;
 Wed, 23 Apr 2025 15:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745415412; x=1746020212; i=xypron.glpk@gmx.de;
 bh=z2iwoj67su836f9YJz6iRlFAqMUxkh2rUfm3bp2k93A=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=H7/Nk5gqmXSuVTLC3AfzGsEiirigOGoDuN9tq4FZdfX8Eu/phk0zQ5UX+xWf8KoS
 K/6ggBqIRg4owYG71iXd0Y3aOG+ftcw9+Z2WRbNCL8UbHbXXyCSCvxys/YO4Mgukc
 szysFw6Qmo+X7+mc/MgqD+/1twf3JKLKhv2UADmxgrGepYY4y5gOgkDdmb6JNGz+g
 tDRgnjzryH12pwJePkP3F4wkbEKe0RlI3kL93ArdGRdSg3PAm6cZnWx1g1NYNFUGI
 +DrPUHOams+isomIGX51SBBbxBLJLrBomZNrwcaEN52JfIyyuO0MXMV8ipHRDSclU
 ZCTtFDZHO+kuZSxswg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1uBAFN0sLl-005POk; Wed, 23
 Apr 2025 15:36:52 +0200
Message-ID: <cb4448c6-396a-4778-9ef2-565ab4f08b29@gmx.de>
Date: Wed, 23 Apr 2025 15:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Maintenance of Python tools
To: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@redhat.com>
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <87a587fja8.fsf@kernel.org>
 <CAFLszTiThPOHm+D=Zts9QP0mm4dYHE=kAqS1LAnfF1MLmc=QEg@mail.gmail.com>
 <874iyff3pz.fsf@kernel.org>
 <CAFLszTia74jHUx0VrESU2J_w092_M8rsLwNR2fmuHp+e4JX49w@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTia74jHUx0VrESU2J_w092_M8rsLwNR2fmuHp+e4JX49w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IXnKJuApw1P4KxzJzqNUsxA2V+D9W5ckJgSsHsNDlabJ1uvJqR6
 4O7ne8GQkWaxFfjXRPgYtMp1NIUS5eTX/XRWaKBFwg0f5qILuSeouc3tkhqSHpDWtsfQZy7
 gXqX1HypqZcr1bT+XmGk/LTLd+F0aS7I2JvawAMkxNFQaAY9pvM39oJ48jVEY2NmrK13vb8
 TZtfDxCUfPuT2ClHPGjjw==
UI-OutboundReport: notjunk:1;M01:P0:wR1kK2zDNg8=;XN0ESG48oY2BxyaQZ04mOPd0PqY
 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
 Q==
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

On 23.04.25 15:05, Simon Glass wrote:
> Hi Mattijs,
>=20
> On Wed, 23 Apr 2025 at 06:43, Mattijs Korpershoek
> <mkorpershoek@redhat.com> wrote:
>>
>> Hi Simon,
>>
>> On mer., avril 23, 2025 at 06:28, Simon Glass <sjg@chromium.org> wrote:
>>
>>> Hi Mattijs,
>>>
>>> On Wed, 23 Apr 2025 at 01:07, Mattijs Korpershoek
>>> <mkorpershoek@kernel.org> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On mar., avril 22, 2025 at 17:39, Simon Glass <sjg@chromium.org> wrot=
e:
>>>>
>>>>> Hi,
>>>>>
>>>>> Tom has indicated that he would like Patman to move out of his tree.=
 I
>>>>> suggested on another thread[1] that I maintain it in my 'sjg' tree, =
so
>>>>> here is a new thread to discuss this.
>>>>>
>>>>> I have already done this for the qemu/efi/coreboot scripts as Tom ha=
s
>>>>> NAK'ed patches for those.
>>>>>
>>>>> For the other tools there is going to be quite a bit of churn, as I
>>>>> would like to resolve most of the many Python warnings.
>>>>>
>>>>> Given the shared source between the tools, it would be easier for me
>>>>> to do the same for buildman, binman and qconfig. I am thinking that =
I
>>>>> might try a move to allow Gitlab pull-requests for reviews on these =
as
>>>>> well as the mailing list, if that is useful.
>>>>>
>>>>> For tools which need to sync back to Tom's tree (i.e. not patman), I
>>>>> or Tom could do a pull request every now and then, omitting any
>>>>> changes that relate to pylint.
>>>>>
>>>>> Please let me know your thoughts. The timing is good as I am going t=
o
>>>>> be sending out a new Patman feature in the next few weeks and it is =
a
>>>>> few thousand more lines of code.
>>>>
>>>> I have a preference for binman staying in the U-Boot upstream (Tom's)
>>>> tree. AFAIK, binman is used by the CI and is also very useful for com=
posing
>>>> "complex" bootloader images (For example for the TI k3 architecture).
>>>> I don't know a good replacement of binman and I'm afraid that people
>>>> will go back to ad-hoc scripts if binman gets removed from the tree :=
(
>>>>
>>>> On the other hand, patman is a workflow tool that's not (I think) tha=
t
>>>> specific to U-Boot and is (to me) replaceable by b4.
>>>>
>>>> I understand that code sharing makes it more difficult to only move
>>>> buildman out of upstream, but in a perfect world, I'd like binman to
>>>> stay in upstream.
>>>
>>> Just to clarify this, I'm not suggesting removing binman. It's just
>>> the maintenance and development of new features that I'm referring to.
>>> We would still sync source back to Tom's tree.
>>
>> Got it, thanks.
>>
>> Wouldn't moving the binman development out of upstream reduce
>> contributions/visibility?
>> Or do you think that proposing alternative development process (like
>> Gitlab merge requests) would attract more folks?
>=20
> I'm not sure, which is why I am asking about it here, to get feedback.
> I like patches on the mailing list myself, but perhaps others don't?
>=20
>>
>> What would be the policy for development/syncing back to upstream?
>>
>> What happens if binman evolves in a way that's not aligned/practical fo=
r
>> upstream (Tom's tree) ?
>>
>> Would that mean that we would have to maintain a fork in upstream?
>=20
> My thinking here is that U-Boot would simply use binman / buildman as
> they are, similar to how dts-upstream (91MB), lwip (9MB) and mbedtls
> (48MB) work. But yes, if Tom decides that Binman (3MB) / Buildman
> (700KB) / other tools (small) have hared off in an undesirable
> direction, then it would be tricky.
>=20
> Regards,
> Simon
>=20
>>>>> [1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO7=
6cUWj+H719mfc97mMQ@mail.gmail.com/
>>

Which projects beyond U-Boot use buildman or binman?

* If there are none, we should maintain the tools inside the U-Boot
   code.
* If there are other uses, we should still keep a copy inside U-Boot to
   ensure that we can build U-Boot no matter what the upstream
   maintainer decides to change.

Patman is not needed for maintaining the U-Boot project and can be used=20
for other purposes. Moving it out makes sense.

Best regards

Heinrich
