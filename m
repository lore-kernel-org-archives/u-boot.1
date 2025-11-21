Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331CFCFC266
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 11:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 345448051F;
	Fri, 21 Nov 2025 12:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NpqhcRly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFFC8312A; Fri, 21 Nov 2025 12:33:44 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474C9802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 12:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7815092cd0bso18609937b3.2
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763724821; x=1764329621; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd3QdjsLY1Oc1xDLvpN9FPSEx/ahg9kOGuLI2y45sEY=;
 b=NpqhcRlyci3Vs0hmfC3PJ3ld9eh3bLbYjVhjwMrzGkmPq6holggh8LV/Wlq61JMULE
 f/sVk6BTmbSmQ4My5nLYnFiPERVRoGEXyp6u8Lm78jxERtykqzsXMG9YmeBm1JeNAk6X
 3akHKFt7BoOa4c8fW86BAPgUWHqHIW72xRp8xR2F3V/ZYYFXTrBFhm/GJx079XlCSfei
 Qbe0VnY3YLLEQE1hfzlWsAwKqC6LmT0/nAiC20AzqeacARJ6nP1poelKLWSjgCDizhkb
 qaCVFIKzbztSyiwAHISJaCwSaRJjYuiS2cCkG0uv3RZqiSFxW1y64N1jFXOdXsbxF24J
 1h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763724821; x=1764329621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cd3QdjsLY1Oc1xDLvpN9FPSEx/ahg9kOGuLI2y45sEY=;
 b=ikI+N4+FFL0L9H4RgS3ekW5LhfzPFNwwmbRhxZdAIlsCZZPSAGpquIhj1UcvmDTOVW
 /mhBBwFIxf1HtBpNwyVvaDPgHTjwBSdxCrOIpUmgF9d9ErWdbqaEXiFjJUh/KII36dwB
 ODnh80B2bvkhryz2uuT/4x4yvO01rYIDR3bna+wxMfUPX0h53gFjDxP6/INtSKk7lVwv
 kKqdVDJbxUssEMjgx1ENSZ2equl+8YLAG48SjVfmAd0fF/8+XIm7JnRHAMXOLgo1+U4G
 xvi5sBpVDzZHmMfaVzHbDfElML3uNWrV96f8s9XMqNWYOgcrMibldZf2eL2HVsKGRL5w
 YH6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMgG03wzO0qX0IRD7/jgahLfStrLH64t9lNccTjHgsIexVMQptniXAp978W0pGCe/9yB1oJJ8=@lists.denx.de
X-Gm-Message-State: AOJu0YzOUDzsrPlgsjGV71+V1XB+NHMz8EDQS9wnSCyQ39Sfgc8sivFs
 P+rRdwRyBpQDGPl7gb0Lw/YCcVsjy1fxIvHTLi8ZBpxBuNwYEzllkobBSNH2a6oiPd6BbFU/P99
 YLXkRT5acGl6wplefrbiSsPjHdg7OIfbXoyyfOnjmOQ==
X-Gm-Gg: ASbGnct/Ytw7AJNlEo0DUnvJnYNXit4W3qysfUwpdQPDoGItlKTQka6NVMZvt/dGcr1
 yX8SOFsGuSTb7cQI+DfUA5jDFyFsh3V1gqvwNK7YH7B7qIQX7wwRFV0XBBVc9XAx9fJKx0CM0Nj
 RW/AT09K+f0j2qQ/Xp2wkUO6ulvS4Vi+tCHsbj4rK9tJr1gz7AxrOq/LxxtROdGOqiB1kJtYqDu
 hZxrPT7Nqiibq5kiQxWGhj3Zq7FzvAA/B6u91Fjz2+bJGvTsuKTiT5xC/3z4M1/WNERSXdEBbKr
 5FaK/o7YoaVULzbQsi/iClGUzByn+O4l9P0/iNM6u41VnQUxQFU=
X-Google-Smtp-Source: AGHT+IF4VD5pHgudbqlIyrnXAyTe7cDEt64KL9g79TP0JIP3UqXU9ipAQoIRY+8iexnMYsm6fZedRtG0djBw1htS82s=
X-Received: by 2002:a05:690c:74c5:b0:786:5712:46b8 with SMTP id
 00721157ae682-78a8b47af0bmr26107727b3.5.1763724821067; Fri, 21 Nov 2025
 03:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
 <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
 <CAC_iWjKTeNTwyQE0KoAApF_qbd1c6ftTnU8jx85sVNBTnYJoRg@mail.gmail.com>
 <21d94821-a339-49a6-af50-6a93788a4f2d@oss.qualcomm.com>
 <CAC_iWjKZB41YNC4p3HRz=UXeyfod0hxyFZp-1Tr1n75P9h=g2A@mail.gmail.com>
In-Reply-To: <CAC_iWjKZB41YNC4p3HRz=UXeyfod0hxyFZp-1Tr1n75P9h=g2A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 21 Nov 2025 13:33:05 +0200
X-Gm-Features: AWmQ_bnK_TErfYeq8x7I8V8VcZ9Eu2GMCQHhwVhqWH4JoM8p8dfPo_eeQapZak0
Message-ID: <CAC_iWjLgRTryKZa8xJXsTfR2=pvm-=_+EE78Tg7bk+=PMDNRmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com, 
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com, 
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 21 Nov 2025 at 12:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Balaji,
>
> On Fri, 21 Nov 2025 at 11:24, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
> >
> > Hi Ilias,
> > Sorry for the late reply.
> >
> > If the boot option generation logic skips partitions, then the boot
> > option points to whole disk.
> >
> > But when capsule update calls device_is_present_and_system_part() =E2=
=86=92
> > efi_dp_find_obj() =E2=86=92 find_handle(), it tries to match this boot =
device
> > path against the ESP partition handle which has path longer than boot
> > device path.
> >
> > The find_handle() logic at line 142 rejects the ESP handle because:
> > if (len_current > len)  // ESP path is longer than boot device path
> >      continue;           // Skip it!
> >
> > So capsule update fails to find the ESP partition.
> > Based on this analysis, I believe the fix I proposed would help address
> > this issue, but I'd appreciate your thoughts on whether this approach
> > makes sense or if there's a better way to handle it.
>
> It would and and what you point at is an actual problem. The reason it
> happens is that doing what is suggested would violate the EFI spec.
> OTOH I don't mind because being able to update the device without
> having to manually add a boot option is a nice feature.
> Heinirch any opinions?

Ok repsonding to myself here, but I didn't remember the EFI spec correctly.
8.5.5 says
"The directory \EFI\UpdateCapsule is checked for capsules only within
the EFI system partition on the device specified in the active boot
option determine by reference to BootNext variable or BootOrder
variable processing"

So the actrive boot option doesn't have to point to the ESP. Having
any active boot option in the same device is enough. That means we can
trigger a capsule update from automatically generated boot options.
The patch above isn't 100% correct though. I'll respond there with
comments

Cheers
/Ilias
>
> Cheers
> /Ilias
> > Thanks for your guidance!
> >
> > On 8/28/2025 5:53 PM, Ilias Apalodimas wrote:
> > > Yes it was. In fact the original patches were adding the file instead
> > > of the disk [1], but we had concerns on scanning all partitions wrt t=
o
> > > boot time. I don't remember if anyone tested the boot time though.
