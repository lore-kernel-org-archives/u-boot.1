Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B0DCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9B6B839DE;
	Wed,  8 Oct 2025 16:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j6dMtZYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25A483C91; Wed,  8 Oct 2025 16:46:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E9D839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b48d8deafaeso23293166b.1
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759934766; x=1760539566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNFADBG0MvAC7ySoWOCyi6peZLi9cTCG70T+hsH7Qts=;
 b=j6dMtZYRTH++qHK8wD6s9Q7j+p51K0yGGhT6+7a8XnHXR7OwMRyeCcUNybO6CNJGMg
 +KIFA1jAsxKavgMq4cY9AR0Tlj+FdqOFXyOfn9xPY6wA6E5tMlMxGnYCVHDMBvn3kGqy
 i9HKQ96J6CK5ArsY/PDR8/BzgSXiZrRfRlMfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759934766; x=1760539566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZNFADBG0MvAC7ySoWOCyi6peZLi9cTCG70T+hsH7Qts=;
 b=C1iBaR6TkLAIn0JRPK7tWPKzcylS+IW1pKKmM9x5XaOnmcGncEjHg6MtOYeeokyVz+
 HX3gtuSiJelxu1CGaGY+NOiOZL37iy7ByCR3J3hQ+brMFUEgdMowyb5EvWqxVc5u4Imb
 emvCcF17+Wgad8QYIwDiEFE38zbSsvEeMwwV3Nexl8lhwQIfw5RXihurSRDoUL7kJ/WN
 pr+nsgWcPvi6Qo46PeFttgpOcc0StrTbVQHIDdZWrIh35tkCA8QUzbjnWLEg3Mhk9G6y
 012+R9PdOnO9kkduI9eXitYe3h05w1/PV2lw3FFMzFeRed3qQgXYphgsJGzx6A0XAM5F
 5Hdw==
X-Gm-Message-State: AOJu0YwWXAUW4P6zYNODLzUpSwNlNyfGSvwyHrW2ZW6qalxR5PQ3Pmak
 V33wRy323Vc003cfoIDBbnVEbiTyto2giyNBeoZPS7w7d+FePSebMaYG5L1KEGHHyuf2MF979NI
 hOqylavxaK1aMGnEAEAeAolCW8iPailQSC71qBulNtHJkbmVADe0=
X-Gm-Gg: ASbGncu6U3aiykjeIddiU11N2IBV6z0xS/JIS1efZUm0ktisO47PVGObr/kZiKOs3Gx
 LwxYrEz/uiGwbeu4xIZVmFdXWQ59tXJa1jSj/VL9E36altOGcPXZOT+4NzXGxEw+ksL+taogL2Z
 BG7RvNhRUsI52mMk32xkv2xxhtJRSL7CkYqUr4dSFLKhHD5ZLTGcHNv1L9QRhQCFE9lO2h4E4n/
 Obm3c//IYOu2yk5Xq1BSnIwrinfXQ==
X-Google-Smtp-Source: AGHT+IHPImVwX8dwXyhRnAqvaMx0ozQ27KjNbE5arZihGAfRBoo9lstJigNZcjUExhziC3ey6KGGYaeswd8NqsAgKUU=
X-Received: by 2002:a17:907:980f:b0:b42:9840:eac5 with SMTP id
 a640c23a62f3a-b50acb0e645mr416567266b.61.1759934765804; Wed, 08 Oct 2025
 07:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-3-sjg@chromium.org>
 <20251007181356.GO298503@bill-the-cat>
 <CAFLszTieyj5_wTNCqsGryCses5a7DWpgVN9AUiJchmjPMViHTg@mail.gmail.com>
 <20251008143415.GU298503@bill-the-cat>
In-Reply-To: <20251008143415.GU298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 08:45:54 -0600
X-Gm-Features: AS18NWCVojinUSYB-cB0Err1ZsmO5jr9tLldDBwiE946HgZ9PWq2ZJBo3O2smQc
Message-ID: <CAFLszTh=jWE0pefvXCpxvBZUtWWuJVem7f5HsYeJU1C7dkvq+g@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] boot: Try all bootmeths on the final partition
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 8 Oct 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 08, 2025 at 06:53:44AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 7 Oct 2025 at 12:13, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 01, 2025 at 03:26:27PM -0600, Simon Glass wrote:
> > >
> > > > At present when one bootmeth fails on the final partition, the next
> > > > bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> > > > which is the more natural behaviour.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > My feedback on v1:
> > > https://lore.kernel.org/u-boot/20250331174144.GI93000@bill-the-cat/
> > > was that we need to do a documentation change when doing a behavior
> > > change. And I cannot recall if this change here is because of reports of
> > > problems or not.
> >
> > This is a long time ago, but I think it might have been an
> > inconsistency that I found myself. Otherwise I would probably have
> > mentioned the person who reported it.
> >
> > The documentation already implies the logic in this patch, as I see
> > it. But please suggest any changes.
>
> OK, I guess it's because the commit message doesn't explain the bug
> clearly enough. Is this a correct description of the patch:
>
> At present, normally when one bootmeth fails on a partition, we move on
> and try the next bootmeth. However, this was not the case for the final
> partition due to a bug. Rework the logic so that all partitions are
> treated the same.

We can certainly say that if you like. It is fair to say that the
algorithm is still being evolved as new things come up. Most of the
behaviour has been driven by new tests that I've written. The global
bootmeth is the biggest change since hunters were introduced, but I
suspect there will be more in future.

I'm heading out later today but can probably send v3 series (with the
tweaks you've given) tomorrow. After that I'm not sure as I'm on
holiday for two weeks.

Regards,
Simon
