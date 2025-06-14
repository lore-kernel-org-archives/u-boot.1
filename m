Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E772C71135
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 12:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2E780F0E;
	Sat, 14 Jun 2025 14:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJejOVgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A42880FA8; Sat, 14 Jun 2025 14:10:08 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 031E7800C1
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 14:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-addda47ebeaso583239266b.1
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749903005; x=1750507805; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqJcoars5DxSBwkR76heFCWogFOR1u3i1LpQJ+o6txU=;
 b=mJejOVgQ5thM8msRZlfmi+aB0P4cUNLRc1bFSY+VqexG6it98dIRAJk0nuK6bxoskM
 xyHfnq6PJ03wv0CSQ+qO0EMODcBAihKcqUuedSZsEQSF1N/SuErvhERlFX5H2k0Tt/Ch
 n1jHNlSlpEOinIat0AUkh/Q/KTGn21G6f8nVR5WYd8cgL/q2TYEudfIfsR++ktA3GRam
 7GpkWkJcHSc81AyMfiDpsPup/jd4OmEbw5kgCkgv/kzaol1LdoRz6CWRxjxlvn/CgEWx
 xJCJSS4eC5uPSuOg3kJRoCbYOezCn08Jppfe319ltiFMIsjdO84wZHAq7MzEZ7D5UCDd
 NruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749903005; x=1750507805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqJcoars5DxSBwkR76heFCWogFOR1u3i1LpQJ+o6txU=;
 b=mVjwQgMQhm9EFAhvc9BvFgAYyq4BmSbEN9FLhdzs17HDqJojF2XDCVhB9j+sOS3h5Y
 gvok9kyTR9lFkRdIGJ85Eo+GyTBX/dEvRoUrvUqG9OTbAXxMqDigoockqXDpCwl6IUe4
 5XFrUUufbN6WF+TX7kXH41tzFxS2gUyGUBK4DIpuuOTBXo8R1JB+N4NO0LXKjgqS25c7
 bDs6eVuuMub+mFL798hHS1BpGEEgaN+8D6veT69y0ganRXPdtjW77fr+NY/6eMDsKGo7
 UUH+EbR5aX/PdjGxbFTRSepyTyt0JAwelYxG9UqF1HxBXl4hHn5BH0hg/SL7IrLJg07z
 3tqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8HgQ3yam2Wk1UmBOk7U1e593UYKjrRpqOO5UYggw7L1oldxshcLDLKrgOs34VENk83p+Cexg=@lists.denx.de
X-Gm-Message-State: AOJu0YyA8x+nEVvidoGnFYlULsOJdIwQMkV0mRdVisrVZ6GwMBKC2m6w
 fyYV421tB2Al77935gPi4A41ZL3LY2GIHDSR4De4u8zFEbt/wNQTOjaj/RwYLR029wzk7TquMqa
 9f9ymq0vnxv9Y8dPknuaTuwzNEibmZk4=
X-Gm-Gg: ASbGnctlkSxit3FRbeEF87XvlaTJ85RUSBtIQQSvqdTtGKRNGtA1EpvW9JktNkCA4Vk
 bFVXCXgiD6I7j8dqJCvcVZVJ3qGTISd+B/BRqhYtLlqhdhv7brueMmUI0emyvjP8/euep3Ha9OQ
 wGyM8aTzkJRPoq4WqQYu3qxKXAuc2qAgUzdOeAIhMJg/k3deFCf8H5loBARJabgyqFWshwcSg02
 Pf7
X-Google-Smtp-Source: AGHT+IEJzlRX+HbTb/d08UwNUcyie3ET80wBGNDY/G/C5iD7vGm3utNCe1uynIF1AikxfilAVjuMR7YSHKC5nNBGbR4=
X-Received: by 2002:a17:907:3da6:b0:ad2:39f2:3aa8 with SMTP id
 a640c23a62f3a-adfad450a57mr259066966b.38.1749903005073; Sat, 14 Jun 2025
 05:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
 <20250613154922.GY1382132@bill-the-cat>
 <87cyb7vaq2.fsf@minerva.mail-host-address-is-not-set>
 <20250613173459.GB1382132@bill-the-cat>
In-Reply-To: <20250613173459.GB1382132@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 14 Jun 2025 13:09:52 +0100
X-Gm-Features: AX0GCFuSnBYAfc0VHlUnXsu35qWcPpc4LXx92kMAkyoO1ZTdSP27sWR2vNtwVk8
Message-ID: <CALeDE9P33wLtWz6Aj8CsQxP7V_yDA6D9KgxtecmhPASgBgkBSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
To: Tom Rini <trini@konsulko.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com, 
 mripard@redhat.com, alexl@redhat.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
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

> > >> The project is https://gitlab.com/CentOS/automotive/src/ukiboot and reads
> > >> UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
> > >> images from raw data partitions. Just like ABL reads Android Boot images.
> > >>
> > >> > Are you planning to add it to the EBBR specification?
> > >> >
> > >>
> > >> I haven't thought about it before but I also didn't know that u-boot had
> > >> this requirement. Probably it should be documented somewhere to make it
> > >> more clear? Maybe I didn't look enough but didn't find a doc in the repo.
> > >
> > > We are not strictly and only EBBR requirements, if there is good reason
> >
> > That's good to know. Heinrich's answer seemed to imply that u-boot was
> > limited to EBBR requirements.
>
> It's one of the main users, yes, but it shouldn't be seen as *only* for
> that.

Also to note that EBBR is a living spec and can evolve, typically the
way we've done that historically is to have an implementation, or at
least patches, in U-Boot first to prove out the idea before putting
something in the spec so IMO this is the right way to go about this.

> > > to add more features (and tests). But Heinrich's follow-up question is
> >
> > Oh, I missed the lib/efi_selftest directory. I'll see to add a test then.
>
> Thanks.

Yes, the lack of tests was the first thing I noticed on the patches ;-)

> > > quite important. I feel like there's already a half dozen offerings of
> > > A/B update that works within UEFI.
> > >
> >
> > I just brought the A/B boot protocol used by ukiboot because I was asked
> > how I was using the EFI_PARTITION_INFO_PROTOCOL. But I'm not proposing to
> > add a new A/B update mechanism for u-boot, just to implement an existing
> > EFI protocol...
>
> Yes, this was more a lament for the ecosystem as a whole really. The
> concept of A/B(/Golden) with various security features is pretty old at
> this point, there's many implementations. I wish there was not "here is
> yet another" in the space.
>
> But regardless, we should aim to have U-Boot be able to be used with it.
> Otherwise my crystal ball says that a few years down the line it'll be
> hard to use Fedora-IoT-distro on common-device with U-Boot.

There's a basic concept of a fallback with the UEFI bootnext bits but
yes, if UEFI actually had the ability to deal with proper A/B we
wouldn't need a dozen different ways to do it, sigh, of course there's
some harder things that also need to be addressed like changes for
signing keys etc.

The other initial feedback I would ask is around a Kconfig to make it
optional, will everyone want/need it, what's the size impact?

Cheers,
Peter
