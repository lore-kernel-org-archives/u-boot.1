Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15139D5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFE188C7C;
	Thu,  7 Nov 2024 10:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="SPJLPVMi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACCA8920C; Thu,  7 Nov 2024 10:47:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A07C288C4D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730972859; x=1731577659; i=xypron.glpk@gmx.de;
 bh=OD+WNZbWZwLjpLPUQeXra99PJnPxTAI+wlXfjhkpjGE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SPJLPVMiCbke9nA4SVYWFNUNrWPZiwG/i5Kg1zCiZ2fkgwFeHd+YWtcCXU5tGy2R
 v7bM+YhkuKSCullxfhdNq6tN+B8Cv0UqykwrMM22jhs68CWt80bA+eCBUqgfRvh0j
 E7rN0UaswyRcX0cU6z5obpk9k61nhB1OxhQ4mtynEhPynL+1Yus+QaC4+WGCTINbQ
 zLrRcX5Z+SN+4/vDborhO/dS6bTlMbgYTubjkRFrcPC1m4/IB0uHYWKPGGU10w3Rk
 +Yqs81Dwmyfp/iKEX2OjrofiCwZTXRwvoL/SuMMmOqhM4Lkw74ptpXHUqtkUvJ4WG
 BKg9caNJLJGw95O9EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QWA-1tDOxP0JJg-003ZCT; Thu, 07
 Nov 2024 10:47:39 +0100
Message-ID: <bd927540-d3f5-4eb4-babe-13910c735b40@gmx.de>
Date: Thu, 7 Nov 2024 10:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] fs: ext4: implement opendir, readdir, closedir
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <173058992364.1044919.1983318156372551084.b4-ty@konsulko.com>
 <CAOf5uw=292JNb1g03_Hcgav4zyUckh3R1_iphHnynHVeqC82Jw@mail.gmail.com>
 <e79be8c7-2461-425f-8f7b-e24ad3884d65@gmx.de>
 <CAOf5uwmXy4qevGpYe04pYCcSJ3r20o9WXzqemDLfi6z5A041LQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAOf5uwmXy4qevGpYe04pYCcSJ3r20o9WXzqemDLfi6z5A041LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Awg3FBWxuy9e9uShZtIJ/E7yaIZeunmq4UoWQcJHZl+D6qCGPqB
 VAEVBLO1DXXISqDUBUDhny92mt02mTIhc0mpg6s2CNxAyhFgBqJUeZKo74dkP+UcyCJyqGu
 Rmg5izGzWw/JrXidfOlfkP2DYJTt4V+xnGxDpTNEjNGQaw98nnEnFchOhuU2nNgbz+EgbDR
 hskax4d8Udx8SqiNj8imQ==
UI-OutboundReport: notjunk:1;M01:P0:CW8YUR9blQY=;BobYFr8x/cRBLYb0aI5vdMq3TPc
 HQJcUWHjSOmXbM2jPgeT915FKzyc2RZl8BHBiIbddhUDoBfDQmdPtY6EgmsJ63uzEJjDiD5nk
 gTU5kPh3fE/Bayz0cR8Lr6ELX0NCgDYl2OJwJlH0yMDzIjQSxy8Bd6DGVAE/24xzFOuEK6d0U
 GPlnuU1Unpw+QnKq2JKNzZbQzy43zceaZB8Q2YnanIeTTU5usHywgdk8OukWHqapKPYA/MLPu
 forFiJNQIE0g87qtkhx0conOn3XbyX1s/pz7M/6ZPNqDSfm+++RgeSIewT80uptN7US5T4gG0
 zZ0l7JozADOyPTfoqX/PNU4luHIA7zV8HRM/F7KKIF0mrOuRCeQFlUgEVgiIIVZx5xcdaoJ/U
 IPEVEEqc+FyN18P0/hRez/eK7fu6CO2hEcKh0s0IAiJop0Oqzv7nuKh+rK9TKv2Jbnz+CAenw
 udxmZ2S12veyD7nJoDB9uC1KDnYswDFIeWeXUBSX7tEc/IyuEuvBQKaDQfeDLC4wtz1bXMoT8
 ah/U2dRRiDW8wSWvH5AMK3mCQA7rF3pPl/sVgc13HCivKiJ2lfafMap/OV2ck5T0C3TfyPYTI
 AcCxioBzmkhk60B52g+33LoH+vYpbNLeFm7Xk/Dd0OEiDrPxH9vsAx9DEw6XwbqBC8bxGaJGC
 xkMN4M+i8KYWfYkXW3VBv2S9Pzk3WOqlQ5ScBxPDTivo6lMls3BLzpeS9+jvxrcWiRkiyRoYK
 2H3z3rx3O70fNVnm14PERPaTTX9v09czXbiH5nnR5HFzNdCk55iKXGyEl4LC/8z3/TGumVCYw
 3Ir0a6GaQcAyJhp5HNYwJcGg==
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

On 11/7/24 10:31, Michael Nazzareno Trimarchi wrote:
> Hi
>
> On Thu, Nov 7, 2024 at 10:27=E2=80=AFAM Heinrich Schuchardt <xypron.glpk=
@gmx.de> wrote:
>>
>> On 11/3/24 00:36, Michael Nazzareno Trimarchi wrote:
>>> Hi Tom
>>>
>>> On Sun, Nov 3, 2024 at 12:26=E2=80=AFAM Tom Rini <trini@konsulko.com> =
wrote:
>>>>
>>>> On Sat, 26 Oct 2024 08:40:43 +0200, Heinrich Schuchardt wrote:
>>>>
>>>>> With this series opendir, readdir, closedir are implemented for ext4=
.
>>>>> These functions are needed for the UEFI sub-system to interact with
>>>>> the ext4 file system.
>>>>>
>>>>> To reduce code growth the functions are reused to implement the ls
>>>>> command for ext4.
>>>>>
>>>>> [...]
>>>>
>>>> Applied to local tree/v2-tidy-test-dir, thanks!
>>>>
>>> Am I sleeping?
>>>
>>> int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp) =
{
>>>       struct ext4_dir_stream *dirs =3D NULL;
>>
>> Thank you for your review.
>>
>> We should not set a value that we do not use.
>>
>>>       struct ext2fs_node *dir =3D NULL;
>>>       int ret;
>>>
>>>       *dirsp =3D NULL;
>>>
>>>       dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
>>>       if (!dirs)
>>>           return -ENOMEM;
>>>
>>>       dirs->dirname =3D strdup(dirname);
>>>       if (!dirs->dirname) {
>>
>> Yes this line in my code is incorrect.
>>
>
> We need to use valgrind in unit test or we need some code analys to
> automate this process.
> We are always looking for memory leaks in uboot in exit path or we
> need to have alloction funciton that
> automatic free the memory when we go in error path

Coverity probably would have reported this. But I think we only run it
on tags.

This article describes how Valgrind could be used:

https://developers.redhat.com/articles/2022/03/23/use-valgrind-memcheck-cu=
stom-memory-manager

Both malloc and LMB would be candidates.

Best regards

Heinrich

>
> Michael
>
>>>           free(dirs);
>>>           return -ENOMEM;
>>>       }
>>>
>>>       ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
>>> FILETYPE_DIRECTORY);
>>>
>>>       if (ret =3D=3D 1) {
>>>           ret =3D 0;
>>>           *dirsp =3D (struct fs_dir_stream *)dirs;
>>>       } else {
>>>           ret =3D -ENOENT;
>>>           free(dirs->dirname);
>>>           free(dirs);
>>
>> Yes, we should avoid a memory leak here.
>>
>> I will send a patch.
>>
>> Best regards
>>
>> Heinrich
>>
>>>       }
>>>
>>>       if (dir)
>>>           ext4fs_free_node(dir, &ext4fs_root->diropen);
>>>
>>>       return ret;
>>> }
>>>
>>> Should not be like this?
>>>
>>>> --
>>>> Tom
>>>>
>>>>
>>>
>>>
>>
>
>

