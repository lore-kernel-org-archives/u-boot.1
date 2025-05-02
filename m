Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D6C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 17:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C35820E1;
	Fri,  2 May 2025 19:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="V9v+kCyz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD09820E2; Fri,  2 May 2025 19:19:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037A281FAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 19:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746206370; x=1746811170; i=xypron.glpk@gmx.de;
 bh=LywlcPFr2p3f+kaZ3wyBhmhEogKbu77ENospW9/ZpEI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=V9v+kCyz8CPqfHJDwvGfDv55frVvgd11A6XR7v7ZGfLKS3MaRqPdeR5VmiI/sxkz
 Ap6gIs+t9qCPF8fN2Y85ndYJMjXNjd1Zduar1q9tvdSbrPVhw6S2djy7uixE4oolK
 as2VdZSCkFzPbNnv+b/ybt6HmzkvVX9R8jwWM1yGnSnYL4XNYJHiSc+AvrpOB8/Y0
 sX3sQ8dB0HZgPVu8I1g3zism7qVLV1iu8wEtYv4byC4ZFXh4eb/XUW/NCIbxkzKEK
 7sBBbIDt+smNIDJ3U56m7THrhApSB0DWaxg+IE3ye7fV0Ty+b50AsJTOc8282iu16
 YiRvvz79r5CVLlpHUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.64]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1uCoWb1gxb-001FZF; Fri, 02
 May 2025 19:19:30 +0200
Message-ID: <18d5e7ee-a63d-4895-abbc-4df7737dccff@gmx.de>
Date: Fri, 2 May 2025 19:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
 <20250502150641.GW1261075@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250502150641.GW1261075@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XVcEWVSgthyY3XH9Nlezq8OMSjFt5kvfBXIbnc3Mq7u1hcf/c/+
 v9GmP7b4GsbhzNF8PLN+rzeJ15ATanqoTsdDRwtUGREZ3J6h7Xob/sXVDplKti5cLy9IGFD
 Zy7xcE0+Rf8866QBUiuvoZZ+RKFSR8EfXEvrVlUrPiitBZIqEEVUz2/IG25BVf5CT/Gu0hN
 xc3xkn08OdStCoOSE1BbA==
UI-OutboundReport: notjunk:1;M01:P0:Jna9qzVnc3M=;wemX4vlHQ0dS1kLGVlrVDbMRTkl
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

On 5/2/25 17:06, Tom Rini wrote:
> On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
>> Hi Tom,
>>
>> On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
>>>
>>>> During a recent discussion with Heinrich we discussed why the hooks a=
re
>>>> kept in a separate repo.
>>>>
>>>> The amount of code is small, a tenth of the size of the recently adde=
d
>>>> lwip, just by way of example. Testing is a critical part of U-Boot an=
d
>>>> one of the things that distinguishes it from firmware projects that h=
ave
>>>> not kept up in this area. By having the tests somewhere else, we are
>>>> signalling that it is unusual, or difficult, or optional.
>>>>
>>>> The hooks mechanism also needs something of an update to take account=
 of
>>>> real boards in 2025. That will be much easier to undertake if the cod=
e
>>>> that test/py talks to is in the same repo.
>>>>
>>>> This series brings the hook files in as first-class citizens of U-Boo=
t.
>>>>
>>>> If we do go ahead with this, I will send a different series which has
>>>> separate commits (with correct author) in the u-boot-test-hooks repo.
>>>
>>> I think bringing more projects directly in to the repository is a bad
>>> idea. Your example of lwip isn't applicable because it's a read-only
>>> subtree that's maintained outside of the project (same as the dts
>>> subtree). But sure, lets "Say Yes". That said, we still need to:
>>> - Remove needless examples from the tree.
>>> - Not include personal labs directly in the tree.
>>>
>>> That last one is why I really think this is a bad idea. The point of
>>> having the hooks standalone is so that any given lab can easily add
>>> support for their lab and manage it, without worrying about disclosing
>>> internal layout. There's going to be hard coded default passwords ther=
e.

Secrets MUST NEVER reside in git repos.

I can't imagine that such irresponsible habits would be practiced by any=
=20
accountable developer.

Please, have a look at

https://docs.github.com/en/actions/security-for-github-actions/security-gu=
ides/using-secrets-in-github-actions
https://tsi-ccdoc.readthedocs.io/en/master/ResOps/2019/gitlab/07_pass-buil=
d-secrets.html

to see how to do it properly.

The same is true for a private lab:
Use environment variables that are coming from outside the repository.

>>> There's going to be repository secrets there. That kind of information
>>> really should not be in a public repository. Integrating the hooks wit=
h
>>> mainline will make lab management harder, not easier. The point of the
>>> existing labs in u-boot-test-hooks is to provide samples.
>>>
>>> I think this is all why no, we should not go down this path.
>>
>> Is it worth discussing this, or is your mind made up? I have some
>> thoughts on the last one.
>=20
> I think it's a terrible idea that I already said:
>> But sure, lets "Say Yes".
>=20
> But please do spend time explaining your thoughts and perhaps others
> will also agree with you and I'll feel less bad taking this in?
>=20

Currently when changing a test hook I have to go through these steps:

* fork u-boot-test-hooks
* push a commit to my fork
* update both .gitlab-ci.yaml and .azure-pipelines.yaml
* commit the change code.denx.de
* create a merge request for github.com/u-boot/u-boot

If the test hooks were in the same repo as main U-Boot, I could save two=
=20
steps.

Best regards

Heinrich
