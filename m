Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E49CC54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8DE87D9D;
	Tue, 12 Mar 2024 10:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IgM48JKz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F8387C86; Tue, 12 Mar 2024 10:46:44 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79BE87E14
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5139d80f8b6so3159787e87.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710236801; x=1710841601;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q8QzuAaEiF8xRXZf8RlLBi2/aDgrrwYpuzvfBvyKw0E=;
 b=IgM48JKzOqY2weaRLQHzhykqm8Uyrs2Y//d3Amk+dCjx9wxtQfeR0MBfe+PSkRErw6
 dxtil/xLLPuPpMQRlaqgtuw+4xxRX8JxQnEH+XyTPABBTWT4dZ/XIfdQ+T/YRYSlnWyt
 9wxsgTfUsTL35zZK0aSbXqVmnJ76DAKIDSBOSyL3XNRPsmXifpLEQlhoKLVrRGRslcuS
 Hd8zRPZj5s2vHpVdW7ny3YzfbP45JkVvPQGrB9c2HhfGmWRMb7TmoFXuuPugnj/xqNE4
 1ChY3+jmOBKz5v2MitDyHLMXBnFt72fBiU5AUduqVN9TEm2kHSc00VP4wpDirsrFZn47
 yd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710236801; x=1710841601;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q8QzuAaEiF8xRXZf8RlLBi2/aDgrrwYpuzvfBvyKw0E=;
 b=OgHU3YUAliJMKRZwDWmk6sdJYPiry9ODMVErJY3GiXBcr2IlZbnXdHA0vL19VXyXIZ
 lFAi2qTxaHag4/UH3iHiYmR5QmEEuBiqtwmN3dDNQ6scZLEYIBZaSIAonrnR/o5OJ63a
 CWbwGDi2tdJTz0x7brBztyRGatBfOJq2aOKEkRe/uJRtMbvRyS3lrmkarNg72qiAFr5U
 GAQEcnFuwdql2F1HOuoOC9UF5tsF0yKExMlzH4hEcKoWWTKuFjTzJrCKe2JDzFgSlYHZ
 AEMi2YNQL7T4EwUu9CdWfqvC4TyMqq3N0zZasXZ2BDFWNCjlKjGZafJbjX5vzioYhZ8d
 7fsg==
X-Gm-Message-State: AOJu0YxaFBs+zQZLVN9qu4pbcAD0fmY/vFPDm/KOVbF6YW7uT2J6dhWi
 f8Nx8wMnkQPyMRZ/Wypr7HXyz4Fzt45ur9czf7GBWexyTMtmUyhwFN/aNO38VhU=
X-Google-Smtp-Source: AGHT+IECMEgEz0JdiwKXiBFcfVS2OYruQIjuKLtqhZ46HVRUFFWnQlXVk+oYGeCPyjApAAxcO2kzzw==
X-Received: by 2002:a05:6512:b9e:b0:513:b30c:53c7 with SMTP id
 b30-20020a0565120b9e00b00513b30c53c7mr2851652lfv.10.1710236800809; 
 Tue, 12 Mar 2024 02:46:40 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 cm22-20020a5d5f56000000b0033e99b7cfa8sm3910821wrb.13.2024.03.12.02.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 02:46:40 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sam Protsenko <semen.protsenko@linaro.org>, "McAllister, Colin"
 <Colin.McAllister@garmin.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "JPEWhacker@gmail.com"
 <JPEWhacker@gmail.com>, "sjg@chromium.org" <sjg@chromium.org>, Igor
 Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix Android A/B backup
In-Reply-To: <CAPLW+4nQBssOtR_wqU25XW-6ZDEm7Yu_7q9ODjWhkWoE9FoV9g@mail.gmail.com>
References: <20240307161711.3177729-1-colin.mcallister@garmin.com>
 <20240308165937.270499-1-colin.mcallister@garmin.com>
 <CAPLW+4kZShBuiDO1aV3g9+nnsdySFv19x2nT6F7hOf4OR_dnHQ@mail.gmail.com>
 <SA2PR04MB7723C4BAEF9488482005FEF5F4272@SA2PR04MB7723.namprd04.prod.outlook.com>
 <CAPLW+4nQBssOtR_wqU25XW-6ZDEm7Yu_7q9ODjWhkWoE9FoV9g@mail.gmail.com>
Date: Tue, 12 Mar 2024 10:46:39 +0100
Message-ID: <87v85r4wao.fsf@baylibre.com>
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

On ven., mars 08, 2024 at 15:59, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:

> On Fri, Mar 8, 2024 at 1:24=E2=80=AFPM McAllister, Colin
> <Colin.McAllister@garmin.com> wrote:
>>
>> > Ah, ok, I see you replied to my comment here.
>>
>> Yes, sorry. Outlook is terrible to send inline responses too. I figured
>> just adding responses in the patch contents would be better. Next time I=
'll submit
>> my patch with a different email :)
>>
>> > So when that config option is not defined at all, the build still
>> > works, right?
>>
>> Yes, the default value for CONFIG_ANDROID_AB_BACKUP_OFFSET is 0x0, which
>> would evaluate to a false bool value in the if conditions. I did do some
>> testing with the config value not defined for my board and confirmed
>> back-up data is not used.
>>
>
> Looks good to me, thanks.
>
>> In your other emails you include your reviewed-by tag. For clarity, Am I
>> supposed to append my patches and upload a new version? This is my
>> first time contributing to u-boot, so I'm still learning the workflow. I
>> didn't see anything glancing through the "Sending patches" page in the
>> U-Boot documentation.
>>
>
> Welcome to the community! And thanks for your patches :) U-Boot
> workflow is quite similar to Linux kernel one. It's useful to collect
> all tags when sending out your next version. When the maintainer takes
> your patch, they usually also apply all R-b tags for the final patch
> version, so you only have to worry about that when sending out a new
> version. I know that U-Boot contributors are often using `patman' tool
> [1] for submitting patches (and corresponding updated versions), and
> I'm pretty sure it collects all pending tags automatically for you.
> FWIW, I'm not experienced with `patman', as I'm trying to use somehow
> unified submitting process for both U-Boot and Linux kernel, and I
> know that using `patman' is sometimes discouraged in Linux kernel
> community.

Welcome to the U-Boot community! It takes quite some time to start
contributing so thank you for the patches.

The changes look fine and the detailed approach on how you tested is
very much appreciated.

I have a couple of suggestions on the whole series.

1. The patches don't apply:

$ b4 shazam -s -l 20240308165937.270499-1-colin.mcallister@garmin.com

error: patch failed: boot/android_ab.c:187
error: boot/android_ab.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0002 android_ab: Fix ANDROID_AB_BACKUP_OFFSET
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I suspect your email provider swapped tabs to spaces. It's also possible
that the Garmin confidentiality footer caused this.

2. Using the khadas-vim3_android_ab_defconfig, this does not build:

boot/android_ab.c: In function 'ab_select_slot':
boot/android_ab.c:350:48: error: 'ANDROID_AB_BACKUP_OFFSET' undeclared (fir=
st use in this function); did you mean 'CONFIG_ANDROID_AB_BACKUP_OFFSET'?
  350 |                                                ANDROID_AB_BACKUP_OF=
FSET);
      |                                                ^~~~~~~~~~~~~~~~~~~~=
~~~~
      |                                                CONFIG_ANDROID_AB_BA=
CKUP_OFFSET

Both are minor problems.
I re-applied the diffs manually to be able to build/boot test this.

Since this is your first contribution, I can either:
- fix both myself and merge this.
- let you spin a v4 to fix the above.

Please let me know what you prefer.

If you do intend to send a v4, please:
- Do it in a new email thread
- Make sure you cc me, Igor and Sam
- Make sure the patches you send can be applied.
  http://git-send-email.io/ is a friendly service you can use to test
  your workflow.

On workflow, tooling, I usually suggest the b4 tool:
https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1

Regards,
Mattijs

>
> [1] https://docs.u-boot.org/en/latest/develop/patman.html
>
> [snip]
