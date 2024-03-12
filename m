Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C470DC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D61D87F01;
	Tue, 12 Mar 2024 16:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fa02Kog0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B54D875B9; Tue, 12 Mar 2024 16:06:03 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A616F87F43
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41336981b3aso451895e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710255959; x=1710860759;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RyZRQhy0AWytd0iL8xhh0qyJjYpUPxKXyHWUwaIsZ/E=;
 b=fa02Kog0St8KKv9fZfGB6wT5vK2ttBiwdTKZ0bHN6I3A6wVARLfkHgWxO9Ma+SATQv
 ZT4YDmUJYerIo4iQMabpmb1R77aNvxbX03mRe9eW72qmZwpUHWiM5DWDv1+/EcbggTGv
 WyYNqCa7+a5+OgOjKgvFxQlwdquD6F2eiLk7v+RrcHZwqWXw0LXMP04gQH4+mc1avhTl
 JmqZg6EnwLlYz0vkINswNvshDhpne+p0wwNxmmvfDTthwqcwzmTk/1oD9C7bYKSyWyKE
 Apr8teV5dyVD0nCNFHi+w77PtTGcQSa4nAe+IgGCXoJdZWDaJHNWZWVminzOpq22p0M/
 RhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710255959; x=1710860759;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyZRQhy0AWytd0iL8xhh0qyJjYpUPxKXyHWUwaIsZ/E=;
 b=o/xJ8Hn4cQubZEmaw3xnsAXZCEw5gGEY+/1jSCEH1OfuJB2P1B1IN8eKG953IxFhUX
 V0ZjaK348KttqPZojElAM2sRzMP457q7inZijLqM6GHtXWfxOswJY/eI/qMd3ZHUG3mF
 qitrdBtKCI+PcaapH9NR9aKKmR1URmuWRIRk6jgYtnC7Z2oZRHggeDD7+yRlXbeqYeYy
 PzKVvEwSk3/pqD2sZmHwuHPLqD9HZRgH58dhhQ+/FrfzlLBC2f26Lilvr5LJil1cQZvL
 xpKuMNZVx+Ns6IaLkp2S67c8agXlieEgBpSZS0Qy/nHKkdjU9HrFkCCTHp8X08w9bx1N
 VcDA==
X-Gm-Message-State: AOJu0YyRm9f8xX3DiGyg1BO7hsidFw6bxAm/Eh7414S57okbJGRmcfvE
 229VT+ilNcV6Tuhyqgr9nuz/36BOGMMeet8No30oZvrO+emRFeZbM+T5/Ws/8Uw=
X-Google-Smtp-Source: AGHT+IFdsUnJ8okG3FM3f65ldiIwgxCFPMSu8cfGDp82UOHTU1VSqXgaAaphVI97sdMR8zgGx/CUiA==
X-Received: by 2002:a05:600c:314b:b0:413:c8e:d4d9 with SMTP id
 h11-20020a05600c314b00b004130c8ed4d9mr2735995wmo.39.1710255958868; 
 Tue, 12 Mar 2024 08:05:58 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b0041333685a00sm2597693wmb.44.2024.03.12.08.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:05:57 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "McAllister, Colin" <Colin.McAllister@garmin.com>, Sam Protsenko
 <semen.protsenko@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "JPEWhacker@gmail.com"
 <JPEWhacker@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: RE: [PATCH v3 0/2] Fix Android A/B backup
In-Reply-To: <SA2PR04MB7723DDB13510F1930459C073F42B2@SA2PR04MB7723.namprd04.prod.outlook.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
 <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
 <CAPLW+4nQBssOtR_wqU25XW-6ZDEm7Yu_7q9ODjWhkWoE9FoV9g@mail.gmail.com>
 <87v85r4wao.fsf@baylibre.com>
 <SA2PR04MB7723DDB13510F1930459C073F42B2@SA2PR04MB7723.namprd04.prod.outlook.com>
Date: Tue, 12 Mar 2024 16:05:56 +0100
Message-ID: <87plvz4hij.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Colin,

On mar., mars 12, 2024 at 14:04, "McAllister, Colin" <Colin.McAllister@garm=
in.com> wrote:

> Hi Mattijs,
>
> I=E2=80=99ve been using git send-email, but there might be issues with wh=
at the Garmin smtp server is doing to the email, like adding the footer. I =
sent a v4 PS in a new thread using my personal email, but that email isn=E2=
=80=99t subscribed to this ML so I think the patches are pending approval t=
o be added to the ML.

Yep, seems they got approved. I will follow-up on the v4 series.

>
> Best,
> Colin
>
> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Sent: Tuesday, March 12, 2024 4:47 AM
> To: Sam Protsenko <semen.protsenko@linaro.org>; McAllister, Colin <Colin.=
McAllister@garmin.com>
> Cc: u-boot@lists.denx.de; JPEWhacker@gmail.com; sjg@chromium.org; Igor Op=
aniuk <igor.opaniuk@gmail.com>
> Subject: Re: [PATCH v3 0/2] Fix Android A/B backup
>
> Hi Colin, On ven.=E2=80=8A, mars 08, 2024 at 15:=E2=80=8A59, Sam Protsenk=
o <semen.=E2=80=8Aprotsenko@=E2=80=8Alinaro.=E2=80=8Aorg> wrote: > On Fri, =
Mar 8, 2024 at 1:=E2=80=8A24 PM McAllister, Colin > <Colin.=E2=80=8AMcAllis=
ter@=E2=80=8Agarmin.=E2=80=8Acom> wrote: >> >> > Ah, ok, I see you
>
>
> Hi Colin,
>
>
>
> On ven., mars 08, 2024 at 15:59, Sam Protsenko <semen.protsenko@linaro.or=
g<mailto:semen.protsenko@linaro.org>> wrote:
>
>
>
>> On Fri, Mar 8, 2024 at 1:24=E2=80=AFPM McAllister, Colin
>
>> <Colin.McAllister@garmin.com<mailto:Colin.McAllister@garmin.com>> wrote:
>
>>>
>
>>> > Ah, ok, I see you replied to my comment here.
>
>>>
>
>>> Yes, sorry. Outlook is terrible to send inline responses too. I figured
>
>>> just adding responses in the patch contents would be better. Next time =
I'll submit
>
>>> my patch with a different email :)
>
>>>
>
>>> > So when that config option is not defined at all, the build still
>
>>> > works, right?
>
>>>
>
>>> Yes, the default value for CONFIG_ANDROID_AB_BACKUP_OFFSET is 0x0, which
>
>>> would evaluate to a false bool value in the if conditions. I did do some
>
>>> testing with the config value not defined for my board and confirmed
>
>>> back-up data is not used.
>
>>>
>
>>
>
>> Looks good to me, thanks.
>
>>
>
>>> In your other emails you include your reviewed-by tag. For clarity, Am I
>
>>> supposed to append my patches and upload a new version? This is my
>
>>> first time contributing to u-boot, so I'm still learning the workflow. I
>
>>> didn't see anything glancing through the "Sending patches" page in the
>
>>> U-Boot documentation.
>
>>>
>
>>
>
>> Welcome to the community! And thanks for your patches :) U-Boot
>
>> workflow is quite similar to Linux kernel one. It's useful to collect
>
>> all tags when sending out your next version. When the maintainer takes
>
>> your patch, they usually also apply all R-b tags for the final patch
>
>> version, so you only have to worry about that when sending out a new
>
>> version. I know that U-Boot contributors are often using `patman' tool
>
>> [1] for submitting patches (and corresponding updated versions), and
>
>> I'm pretty sure it collects all pending tags automatically for you.
>
>> FWIW, I'm not experienced with `patman', as I'm trying to use somehow
>
>> unified submitting process for both U-Boot and Linux kernel, and I
>
>> know that using `patman' is sometimes discouraged in Linux kernel
>
>> community.
>
>
>
> Welcome to the U-Boot community! It takes quite some time to start
>
> contributing so thank you for the patches.
>
>
>
> The changes look fine and the detailed approach on how you tested is
>
> very much appreciated.
>
>
>
> I have a couple of suggestions on the whole series.
>
>
>
> 1. The patches don't apply:
>
>
>
> $ b4 shazam -s -l 20240308165937.270499-1-colin.mcallister@garmin.com<mai=
lto:20240308165937.270499-1-colin.mcallister@garmin.com>
>
>
>
> error: patch failed: boot/android_ab.c:187
>
> error: boot/android_ab.c: patch does not apply
>
> error: Did you hand edit your patch?
>
> It does not apply to blobs recorded in its index.
>
> Patch failed at 0002 android_ab: Fix ANDROID_AB_BACKUP_OFFSET
>
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>
> When you have resolved this problem, run "git am --continue".
>
> If you prefer to skip this patch, run "git am --skip" instead.
>
> To restore the original branch and stop patching, run "git am --abort".
>
>
>
> I suspect your email provider swapped tabs to spaces. It's also possible
>
> that the Garmin confidentiality footer caused this.
>
>
>
> 2. Using the khadas-vim3_android_ab_defconfig, this does not build:
>
>
>
> boot/android_ab.c: In function 'ab_select_slot':
>
> boot/android_ab.c:350:48: error: 'ANDROID_AB_BACKUP_OFFSET' undeclared (f=
irst use in this function); did you mean 'CONFIG_ANDROID_AB_BACKUP_OFFSET'?
>
>   350 |                                                ANDROID_AB_BACKUP_=
OFFSET);
>
>       |                                                ^~~~~~~~~~~~~~~~~~=
~~~~~~
>
>       |                                                CONFIG_ANDROID_AB_=
BACKUP_OFFSET
>
>
>
> Both are minor problems.
>
> I re-applied the diffs manually to be able to build/boot test this.
>
>
>
> Since this is your first contribution, I can either:
>
> - fix both myself and merge this.
>
> - let you spin a v4 to fix the above.
>
>
>
> Please let me know what you prefer.
>
>
>
> If you do intend to send a v4, please:
>
> - Do it in a new email thread
>
> - Make sure you cc me, Igor and Sam
>
> - Make sure the patches you send can be applied.
>
>   https://urldefense.com/v3/__http://git-send-email.io/__;!!EJc4YC3iFmQ!S=
PI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621A=
COzFcWz8Ldw1zsFDgg$<https://urldefense.com/v3/__http:/git-send-email.io/__;=
!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8=
G_SXOw5oXUX621ACOzFcWz8Ldw1zsFDgg$> is a friendly service you can use to te=
st
>
>   your workflow.
>
>
>
> On workflow, tooling, I usually suggest the b4 tool:
>
> https://urldefense.com/v3/__https://people.kernel.org/monsieuricon/sendin=
g-a-kernel-patch-with-b4-part-1__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAy=
FwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8LdwuYhSjtw$<https:=
//urldefense.com/v3/__https:/people.kernel.org/monsieuricon/sending-a-kerne=
l-patch-with-b4-part-1__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJ=
Noupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8LdwuYhSjtw$>
>
>
>
> Regards,
>
> Mattijs
>
>
>
>>
>
>> [1] https://urldefense.com/v3/__https://docs.u-boot.org/en/latest/develo=
p/patman.html__;!!EJc4YC3iFmQ!SPI0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyP=
LgiELEAXx-cPq4j8G_SXOw5oXUX621ACOzFcWz8Ldyum8H6Ow$<https://urldefense.com/v=
3/__https:/docs.u-boot.org/en/latest/develop/patman.html__;!!EJc4YC3iFmQ!SP=
I0-0rQ9vj-ywEEcv6DQJbMQAyFwaCwC-RJNoupu3oyPLgiELEAXx-cPq4j8G_SXOw5oXUX621AC=
OzFcWz8Ldyum8H6Ow$>
>
>>
>
>> [snip]
