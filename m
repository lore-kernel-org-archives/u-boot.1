Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5176EC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE28849F6;
	Fri,  3 Jul 2026 14:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="JPuqZBdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6EB584A1D; Fri,  3 Jul 2026 14:29:07 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56207849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7eb64085c45so282612a34.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 05:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783081743; cv=none;
 d=google.com; s=arc-20260327;
 b=cBH5WRnG4gQeaL8FUjxWMJU5VO8b5AMtoL3G8k9bNjcyBxWw3II7jkGmeAbVmGnd/e
 kC+/aMzlv07dJlYXiFH72USdFgBO0jvgSXwuR1alWAz6tQSlsWTSGupynPHPHY2KUekS
 q8B2rtgaOvtTbcTUh4zg1hdaMkCKrH0niFomOeLbSpcGD8q77dqVaBq0fhkx6KNJETYk
 LwCmpTu1g6RsyyjBkCXcPXH88f6wEyYE+/3jEDRLveNK+3B3al5+kTSjB3/Uj0i9H1aw
 XWm1NiX7Q7HVNvhpNAqXC2zHc1RadrWFyaNDh87aUKemZ0FiEGpSyR7XOwMnE6TRM4g5
 jjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EnV5vhjl3Qi300CnD7SEkg1kSb+s++RvNHd/JUl7iWM=;
 fh=2SkbafkFXBsBlRgoeCVRn33kXqbV8Bq674lZ/xUryH8=;
 b=QhszoCb+wWcAaXnOMkwk5UdiGNu43t9OeLiRIyETw0mCCvgfDlVYlXjfpWhay2wQK4
 ZKifzVWbYlqnkCORwUCrxckDk7ZG4MqXdo/yRcHF37AqFmFnAxHQRlnxXJKFBZq97EM9
 rlaQFi5U04oVfz8MRejUAUEfrlpSUhZDxI6WlFG/i+wDvlNlD3BcxGJSpoBfl+ElDY7E
 HYwFpYEoNl7BI/t4swFbg1n2idcQx6124mGFkOMYBTIkGuk/2S8f8Z/NUnxn6qgMg1kN
 XQLmlQa6glqCQlMctBBWNFxuN/PKYYiwzsMBYqM8KXO2rdKoGPwUJ2B7qd+vQAv4Nbqq
 Nnvg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783081743; x=1783686543; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EnV5vhjl3Qi300CnD7SEkg1kSb+s++RvNHd/JUl7iWM=;
 b=JPuqZBdBOI1Bvn2zZrHbamfywNJP/AnP8HMdDkjX6uaI1YwdAGQtI/e8h0ZG0j0WFv
 ZiBgN9hDQFZ+I+CGKj1dhWo2TcRQu81+gZQ9FfF8Bn5SPzP46YejMOCL/LYfOIHQH9w5
 0gLu1Vw48hEXFhNSpaMPOaaY/MUY4HGH9RPbWz44b82AZICKIXTWOk+zRagwxoF1mdJ7
 82aBJPGAstP+jaVKujfSYzLA61rQMaz3EePZ667Yqes5hvCCUP4wnNMnkwKlZjYe57bn
 X6YtY6xHSxXnf3YNgyyb6tqPttf5/XBkDSCbRex5hcANPDIilwb19tLl8J0eE50SqqGY
 WuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783081743; x=1783686543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EnV5vhjl3Qi300CnD7SEkg1kSb+s++RvNHd/JUl7iWM=;
 b=iJ1BOetZYkyxyVVxWHxV2tlWWK14IP1Zg9Igcnx68iVJDrbjVUQe27pqT34PIgMYCw
 kzZC2/9d259rXS1L+VZze3bGxfVDInWQ+LqPeLiHkKgm/EpFBcyiRsaVwLLKwg9VEqD4
 l+rRCNqBwSqYOE+h+X7up6uy51OOS9OwhkN3IcBwTUtwujNL5t3bMyU3bOptKn3krw8q
 yOBMYCooyJZMiMhy8o2KEDbilCeYeZpV+vF0Da5u0Z9ZjkHslzSFk/hHdLox/rqymyy+
 0ft2Ync68JaMq+fob8cSlSp0GaTKAp9Ua7n9Dqh3ZqD/m4dNXtNvEJoIunwSUy3NxIE0
 4pUQ==
X-Gm-Message-State: AOJu0YzYUhMDaGC4EZ9UasgQ3cbSSWlG+AazUch8gYyLW+cT7u7T7Kqf
 /ixxNXr/mznmvk6VEzqktEnI904qNm5fe6EfAzdgD7CMNRRS1JOkc8XiZkLl0Y4BJ/hQrIuYXCw
 owxVFHXxBbynVHiIiTYV8o7TTdH2SNWwAa+KZFrsY8g==
X-Gm-Gg: AfdE7ckpJvdTOp5hXwbgLD5g8eHXS1sV4fhVpktjp/CJkVkZAsRIBLvHp/xb6cfCB+E
 6Oxv29bpLLq9cQhg1Di6AzfbnopBut749QHXiCAKfWIG6x3zBHURCwLnIQR92hsfNocMnhuQDwe
 lb5kR7Hi2IQmA3SDm1uleECKeDKo0iAUfSgf2KF48GWH4r9a5Snt1o76V76BSTuLtyq+EL8XQKQ
 fwpJ5yGoAVQtt7lKa2ks3MUT9aKbdHTTzjCjIgJq74VGnDtDXE1WvJdH+1wHkO4WpWedPovgQ==
X-Received: by 2002:a05:6830:82e3:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7eb4cc18ef7mr6029151a34.15.1783081742914; Fri, 03 Jul 2026
 05:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <140504E6-5BCB-4566-A03F-2A94B0F5BA01@baylibre.com>
 <CAC_iWjKUghtMYU_g4JUJbXF12sGL=zW8W8bcCfNWRsN7xx11Yg@mail.gmail.com>
In-Reply-To: <CAC_iWjKUghtMYU_g4JUJbXF12sGL=zW8W8bcCfNWRsN7xx11Yg@mail.gmail.com>
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 3 Jul 2026 14:28:51 +0200
X-Gm-Features: AVVi8CdscELUxLvGCIol7uRcD-r4xTRIOBUNhkM3DiBOtPjMT8KossZqftQyNQw
Message-ID: <CADh8LschPxP73+=mfoudKkB-CF94O458wwta3jpHHzOf_V0bwQ@mail.gmail.com>
Subject: Re: [RFC v2] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io, a.fatoum@barebox.org
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

On Fri, Jul 3, 2026 at 1:49=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> > Platforms that follow EBBR / Arm SystemReady IR treat the OS devicetree=
 as part
>
> Not the OS devicetree. The devicetree. It should be a single entity
> consumed by the firmware, os etc.

Yes, indeed.

> >   - Install it on *every* EFI launch path, not just one. SystemReady IR=
 boots
> >     through the UEFI boot manager, which in U-Boot does not go through =
the
> >     per-device EFI bootmeth, so a per-device-only hook is not enough.
>
> This should be happening already
> commit 7e624377e99 has some info

Right, and in fact the series relies on that: efi_install_fdt() runs
on every launch. What this bullet is about is the source rather than
the installation: each launch path chooses the devicetree from its own
list (a Boot#### load option, a file on the ESP, the control
devicetree) and currently the firmware partition is not among them.
Basically the (future) series adds it as a source on each path.

> > The *location* is described in the control devicetree. The bootstd node=
 carries
> > a 'firmware-fdt-source' phandle to a node that is a child of the media =
device
> > that owns the partition:
>
> A lot of boards are building with  CONFIG_OF_UPSTREAM. Is this
> something that wil be injected in the DT during build?

Exactly that: the binding is U-Boot-specific, so it lives in the
board's arch/arm/dts/<board>-u-boot.dtsi, which the build system
merges into the OF_UPSTREAM devicetree automatically (the upstream dts
is never modified).

> > Each path installs the result through efi_install_fdt(), the convergenc=
e
> > point all EFI launches pass through, so the firmware devicetree is inst=
alled
> > regardless of how the EFI application is started, including the boot-ma=
nager
> > autoboot path that SystemReady IR uses.
>
> That path should be fine since it applies the local fixups before install=
ing it.

yeah, that's the idea.

Thanks for the pointers, cheers.

--
Carlo Caione
