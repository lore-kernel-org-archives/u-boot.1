Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE65CF394C
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 790FD891A1;
	Thu, 19 Sep 2024 16:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VUAZ1OBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A386289194; Thu, 19 Sep 2024 16:32:04 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 538B5891B6
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-718d704704aso711031b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726756321; x=1727361121; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V24224j0jKcJVsfPFW+kK5N/Jdu2byEXQUos4bBGL54=;
 b=VUAZ1OBekFxzFhob5drqnUs1puBPERg1oVOGYdvWbjI5fSYobXCVTvgKKz/oh7oggO
 qyb45fS9eL+zyQ/KqyYRFlwepW4p3rYhsQoSFwckMbXhoqO0FlYJx/JB1IVcqnP65SX6
 S0k/X95W4uR55rvnkZnDrnnubv2lL7kLuuG46+dHhjrMCNldM+KZabCbmWJq1ig8zaYb
 mC9wnA6aZOPKSHfbBhZqG8O9hwogi4g4+coo5x0DMW8rY30YVSfMtzyp8jM7faGA3ENq
 eG1EyX/1SInTQDOMV0ap2VRTm5xFL79TB9Gtm/k5q0D37j3h0Ukpuw99Uyo67/XOnIU5
 O99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726756321; x=1727361121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V24224j0jKcJVsfPFW+kK5N/Jdu2byEXQUos4bBGL54=;
 b=SD96FWJvypZ7oY+V8uIrG3JxF9wWimv2xFV2Uhrh/Wv2a0qbhPPXK9fCnCdYNg3NQl
 RvCF1JYkjbb0s6IDjk176nGkiMMTYJiPqa9luDdxrBgoqL6ixpYuEvpJNEQRqrtk7sxI
 pUFAxBoIuQLutHa4WWzPLJ5g6+aOhVlZ8IRKJ38AWAM+hau1aLJojXkDcd6NaYFXnVws
 GNQtzyrZUdbVk1pCsMDydjHcbVqNdhaZaIIKuVDc2R/ccMe+KZVYHcrGUjBU/hgml6nO
 KVOTiKupHP2zy6Ykw7R1BT2X8CiBWuwwNN4dDvfKM4VvQEyFEic/aGfvFflz1CJbplJF
 0QgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2UDOTXHjBYGmKwfNDE7lUctO5OkhP6+akj70wBxv1+znL/xDlcfKh2L72Hc7hJMdqRp0pckM=@lists.denx.de
X-Gm-Message-State: AOJu0YwW+ptf2iIneYqRhUo/9zCTOqbdQLLCj0PBw1J8f4R8D7E9+wed
 tyPHMjICQkoPmrhf6RT7yAROWt7A0TNSDt0W7TBBDJ5vaEJH1h0woiW2lxWB81SqKz+WMor+rNl
 DA7WybcKowV+OiLhSM6k8RqqNxJU258duvB+6Mw==
X-Google-Smtp-Source: AGHT+IHhwf34THgy7mIUcPmJt62ZiAzu0eyboYma4J/qc4oK3LDsiCziVWi6VRUNQe46Yy+F3RVwPYyJ6Ajv44usIp8=
X-Received: by 2002:a05:6a00:3d12:b0:714:1f6d:11e5 with SMTP id
 d2e1a72fcca58-719260815d3mr39977606b3a.12.1726756320794; Thu, 19 Sep 2024
 07:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
In-Reply-To: <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 17:31:23 +0300
Message-ID: <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi all,

On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 19.09.24 16:10, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> For measured be boot we must avoid any volatile values in the device-tree.
> >> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> >
> > Could you explain a bit why this is, and where this is checked?
> >>
> >> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>
> Measured boot relies on creating hashes of artifacts and writing these
> to TPM. If the hashes don't match the OS will either warn or refuse to
> boot. The device-tree is one of the artifacts that are measured.
>
> If we have random values in /chosen, measured boot will fail.
>
> When an EFI RNG protocol is provided by the firmware, GRUB and the
> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.

There's a comment on top of that function that explains what happens as well.
In short the EFI stub does not even look at the KASLR seed and never
randomizes the physical placement of the kernel. It only does that
when the EFI_RNG protocol is there.

Regards
/Ilias
>
> Best regards
>
> Heinrich
>
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   include/efi_loader.h          |  2 +-
> >>   lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
> >>   lib/efi_loader/efi_helper.c   |  2 +-
> >>   3 files changed, 12 insertions(+), 7 deletions(-)
> >
> > [..]
> >
> > Regards,
> > Simon
>
