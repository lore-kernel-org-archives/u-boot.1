Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713C8C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 19:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF17820E1;
	Fri,  2 May 2025 21:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fgl01gH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15635820F6; Fri,  2 May 2025 21:43:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962D881FAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 21:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746214977; x=1746819777; i=xypron.glpk@gmx.de;
 bh=8Nr8YISEVqd6d+mXeLs0E8s2eU8x3LzczJ9QurqbtFI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fgl01gH6HrqP6EnrDPtP4WwqjoxyJptm9t4Mjhn9uBeBa+Hd1KyvUZmcCx3IRIza
 dVBc3ULiT9DEEuwgDUQrLXqTbWf0l0CGIq+OP+VgIHnN2QXoHX7zskBU7vfvpidqN
 4/09i4kEGvSzLJuZcPFantHBR/0JESniNuN5lw/NJEljkGfHqxEsn6ruClpu0ZY5Q
 4o9a1DKP6DdehkjWpxzRHadJcR87yFJzGu37AJkZYYwhk3sBahRcQosZa/IT4abDH
 DIZWvA/6nQ3PncOjG42sSPD6EO/NHz1gXfb0nJ+SRsyRk80MlUPptmwPQ3mOJmXds
 xFry+m5a2FlgP+n1Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.64]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0Ne-1uvFTF1hOq-00is38; Fri, 02
 May 2025 21:42:57 +0200
Message-ID: <45357aad-96d3-4c84-b6be-36cf4bb9dfff@gmx.de>
Date: Fri, 2 May 2025 21:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
 <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
 <20250502193020.GZ1261075@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250502193020.GZ1261075@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yQL6FkZt0PRvBiNa86Dymb3hlDwgjgXNJEH31T6lxd9thDQI9TD
 cHSOjVH280pTD5RlxptXDS856M2mT54pIF3/nrHy81XNUo4yQodSgskNF7Dncji5fWFFiWt
 SK61H5jKp/5hyEJBmgUFVrvRXCn6oqWS95jIc0JS/Bv1p3jqqgNSMBZ3T/rIs6oB+utkYuy
 iTen5pasqzPZuONdBuZCw==
UI-OutboundReport: notjunk:1;M01:P0:GILp8wGzyuY=;gBy55EHFFYUue3VoQoiPw7A0twy
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

On 5/2/25 21:30, Tom Rini wrote:
> On Fri, May 02, 2025 at 07:19:18PM +0200, Heinrich Schuchardt wrote:
>> On 5/2/25 17:06, Tom Rini wrote:
>>> On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
>>>> Hi Tom,
>>>>
>>>> On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
>>>>>
>>>>> On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
>>>>>
>>>>>> During a recent discussion with Heinrich we discussed why the hooks=
 are
>>>>>> kept in a separate repo.
>>>>>>
>>>>>> The amount of code is small, a tenth of the size of the recently ad=
ded
>>>>>> lwip, just by way of example. Testing is a critical part of U-Boot =
and
>>>>>> one of the things that distinguishes it from firmware projects that=
 have
>>>>>> not kept up in this area. By having the tests somewhere else, we ar=
e
>>>>>> signalling that it is unusual, or difficult, or optional.
>>>>>>
>>>>>> The hooks mechanism also needs something of an update to take accou=
nt of
>>>>>> real boards in 2025. That will be much easier to undertake if the c=
ode
>>>>>> that test/py talks to is in the same repo.
>>>>>>
>>>>>> This series brings the hook files in as first-class citizens of U-B=
oot.
>>>>>>
>>>>>> If we do go ahead with this, I will send a different series which h=
as
>>>>>> separate commits (with correct author) in the u-boot-test-hooks rep=
o.
>>>>>
>>>>> I think bringing more projects directly in to the repository is a ba=
d
>>>>> idea. Your example of lwip isn't applicable because it's a read-only
>>>>> subtree that's maintained outside of the project (same as the dts
>>>>> subtree). But sure, lets "Say Yes". That said, we still need to:
>>>>> - Remove needless examples from the tree.
>>>>> - Not include personal labs directly in the tree.
>>>>>
>>>>> That last one is why I really think this is a bad idea. The point of
>>>>> having the hooks standalone is so that any given lab can easily add
>>>>> support for their lab and manage it, without worrying about disclosi=
ng
>>>>> internal layout. There's going to be hard coded default passwords th=
ere.
>>
>> Secrets MUST NEVER reside in git repos.
>>
>> I can't imagine that such irresponsible habits would be practiced by an=
y
>> accountable developer.
>=20
> I agree it shouldn't be done. And just this week was the most recent
> time I've seen a company do that internally, because it's internal and
> was just a temporary thing. We helped them stop needing to do that, but
> assuming it never happens is a bad idea.
>=20
>> Please, have a look at
>>
>> https://docs.github.com/en/actions/security-for-github-actions/security=
-guides/using-secrets-in-github-actions
>> https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-b=
uild-secrets.html
>>
>> to see how to do it properly.
>>
>> The same is true for a private lab:
>> Use environment variables that are coming from outside the repository.
>>
>>>>> There's going to be repository secrets there. That kind of informati=
on
>>>>> really should not be in a public repository. Integrating the hooks w=
ith
>>>>> mainline will make lab management harder, not easier. The point of t=
he
>>>>> existing labs in u-boot-test-hooks is to provide samples.
>>>>>
>>>>> I think this is all why no, we should not go down this path.
>>>>
>>>> Is it worth discussing this, or is your mind made up? I have some
>>>> thoughts on the last one.
>>>
>>> I think it's a terrible idea that I already said:
>>>> But sure, lets "Say Yes".
>>>
>>> But please do spend time explaining your thoughts and perhaps others
>>> will also agree with you and I'll feel less bad taking this in?
>>>
>>
>> Currently when changing a test hook I have to go through these steps:
>>
>> * fork u-boot-test-hooks
>> * push a commit to my fork
>> * update both .gitlab-ci.yaml and .azure-pipelines.yaml
>> * commit the change code.denx.de
>> * create a merge request for github.com/u-boot/u-boot
>>
>> If the test hooks were in the same repo as main U-Boot, I could save tw=
o
>> steps.
>=20
> Yes, that's true, the steps for updating our CI are a little bit longer.
> I would be happy to make u-boot-test-hooks more widely writable (so it
> would instead be pushing to a branch for step 1+2). But I'm also
> concerned with external labs (which is both the origin of these scripts,
> and where they're also used).
>=20
> Today, I have both a "konsulko" branch of u-boot-test-hooks, internally.
> That has subdirectories for both "sage" and "lootbox" (the two lab
> hosts), and in turn py and bin subdirectories for each. There's no value
> in publishing these changes as there's nothing unique about the
> platforms there, which aren't already in the mainline u-boot-test-hooks.
>=20
> How should I manage these changes moving forward?

You could create two branches based on origin/master u-boot:

One for maintaining your test lab specific u-boot-test changes and one=20
for your private u-boot code changes.

Check out the lab specific u-boot-test branch for steering the tests of=20
the u-boot code branch.

As said don't put the secrets into any of your branches.

Best regards

Heinrich
