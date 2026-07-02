Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EF1C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0D184671;
	Thu,  2 Jul 2026 12:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wLrbvWia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FF7846F4; Thu,  2 Jul 2026 12:08:05 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C174F84409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-664c4a04081so1325091d50.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782986881; cv=none;
 d=google.com; s=arc-20260327;
 b=rU14iCyw6h7HRZStdcNU25npRAFx96EYZ9Ls3jIoCXk5Am10GuSf1O+GkyYTyt3o8d
 NXcsZqzCucBR9z66Gx/JToox9XjwH/GW7fHFWYMacbs/mZVu+iZlATYZv40xRxSFxzrR
 GF6Dh3Oi6PCigWxIfFMfkOKC+PhfXfN+bQZyrQ52LpEDzcwe5obmlLzpdv25k/giLUqm
 1Lrpxt+XYm+jL3rwX3nH/s7VcRMfu0qAoSW5s8NPfRK9pQcd21Lz2WSYn0LCTidaj4TT
 x+K17cU7QT4TQhYyCpUe5TgX/PbNbfpLc+RDF4SAHi1jxIb+Y8m8OiQolXw1d6+/m0c0
 4d7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7hdcbpoPf49c8VoAY5m6FTdYVkMU5HqFXdLtaXbJg20=;
 fh=/Nsu4KeIY/BckAkrFd38YurCorn6dwrZh11nSZtiKSE=;
 b=TupQvbLqKsoAfOIkg39rwVnJ18TGfvuXgJz0ZVkIU4l/EgEeD9dCH3gaudWLgDGYwq
 7R+YKK007eTAoBOImN9I59iNyVHxUY35N8Wwe22Nz2thiGuvmOcXhiTIHmXpgkTPW12I
 bfh+csvV5xlxy/Z4hvTFR6rMsxOhzaTzV6kZCJ3rRrnVdxY3zOCEBYLss137KH7qdU6h
 iW5VPq0O64Tbo+cx5mGRjkHdoFQYtGt4im1+7e2v2pGu5dDCZXJorcuZ+yHR1dj7I30j
 p5tSxYQscVV04scshTI/LG8Wn4QvL6MGLOvcGOA4JUJ0q+AeGGk9FQV32khJ44aKf5sK
 lRTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782986881; x=1783591681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7hdcbpoPf49c8VoAY5m6FTdYVkMU5HqFXdLtaXbJg20=;
 b=wLrbvWiaTWE21MuUw8CL4/0iKBbRZWKvDVqWj/mNi0h36Z/6dB/IL6DTWmbDaVeLFv
 OxDdYq7ay53QeJkNqaLdRjiDgEo2I+VaE6Qt+62qyQLf2yqSJCV6UNgQf/D8IT+BzaPj
 kO3MT4UPYGCog2SqCceVkHUjOlu4/RIo8Q9MS540MV8Tfdo/MkLPJhUUB3+TuG7Nxbhw
 mCd81U60wSDZOehxnhgpkp2kT+O08Dsy8GsYuOhzsPqSkOQXWKXi98XRdJJmUd99q0a2
 wDFfx/uJU0rFp9rQUlcsXp61RRZtv1RgEMQXxnBKxhtdvbXc1HoDXZSSf/guyHbinQV2
 C7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782986881; x=1783591681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hdcbpoPf49c8VoAY5m6FTdYVkMU5HqFXdLtaXbJg20=;
 b=oSzQibfURcFcXFWSrOpByTTfiSvK5sk0Hy2NzXJAcnXQHOAcY8rGvshXOHBYRkmHa+
 zXbd+xvOhpp9UDOpUdyT0qW06E3X2sVZ8pmoP92SbI5iUFObMIKa1qYDZAqbrfEUMLhQ
 s2OtZhEt+EPfjhdkWIBh4xZ3cu9ZHK6Xx1HHWJLAoU5Ue3WkQRo/7dWOEXgJdCs2+bv4
 OAg0FHSo8pcnDm6HgGaP5kKIRiYz4cTF60vzz3GOB7nigWWaG3qhCp+NxXJVGaJ/+zgH
 bZFOH59vwZiIoU2Nyo0zHyojv0c1uE5DaIt5xcn14tEQgXnk9gIUIhg46ZfcoGzyBSCN
 rX7A==
X-Gm-Message-State: AOJu0Yz6sEQ6MfFUX0VJn0BTKhHQ6bQlxyOrsS0L/LC+ZQRzuwwf9fhU
 lpmfJOfwDRT9xBj4UH+WSW9zjAZgoTmsqLU8tbImYlCvm6eDhx/I0ONQDRTCRJLLtzpS8mief9Z
 1tMTdtZGTdlKWKrQxaVdKHurpM7kWiTFUIZJRmfa/zw==
X-Gm-Gg: AfdE7cn0dFKOhojJ0b7lczbwT5nLHj5Ha1SUN5vJmx7MaGQ1pREUelcu13d3G+HpW2B
 t7BPU/47sARBfKVwXd7p3MVms8k7J9yiPOdu683af813XAERX5KeXfqk5Z07ixG8SSsUn+1sRs9
 TAMK6ssxPoN6my8H9Fd6apybdTRMhxrsuoFp6WQW2MxYbaYP/fyBr/x6Uh64X8+byJpjVj89z+L
 KMVNArl1quVGD5djpE10N4Y6qviRdvn/a8Ps0b3VPWFrOti9jF988cz31DJ/jdMLUH6omJada09
 ozSHk97Aj6JXozeQqQJJ+V+VVy99l6NrFkvb2cxu5TzVb64Z1mqdfB3RuiLdjgepGv8GtBm6lOo
 oUTEA6meRlbi8o3bWEhsZII57Z59i+KUsURfxc2PwFeO/Tnb2IkI4blPtahSsdskIM/0LTUguaS
 N5+qwzt1S4OXEhkKggiDHH/ONbmvgNe1zuboUxDUt284QocwNSEGz36L+0V5Ejd+IxPYwhAff1q
 atAqSGcVq7a8/gIyTw+yGgGRhFYVnU6O4NqXt67DBPiJ0/h53IlQGwC8KMUwf+dhwiqpRr8/Nul
 a1LZvVCZegDeaRIHe0lBBkPcwMq65kAMj93YQfaL89hRkWLJmPcuiaRJLDQ9yAKrRT79bfo=
X-Received: by 2002:a05:690e:bce:b0:660:a41d:d175 with SMTP id
 956f58d0204a3-66521b945c8mr5515845d50.55.1782986881273; Thu, 02 Jul 2026
 03:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
 <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
 <CAC_iWjKeFMqXqo9tcf27Yuofyvbvr34Hqf5hFpK4zB8crtw8Yg@mail.gmail.com>
 <f63906f9-29a6-422f-a111-855cdc8d1f2b@amd.com>
 <CAC_iWjLfC_U=q+iPCy-BXLXwLiwjXBe3UHqH5XuvU1gkyVxKkA@mail.gmail.com>
 <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
In-Reply-To: <08e98c15-80a0-40d8-bc7c-8d8edfbf3f99@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 2 Jul 2026 13:07:24 +0300
X-Gm-Features: AVVi8CcTtoQXCO4Tay9JD4Z-7HJixtEajMNVoX-e7cE-RP6KKSvKJfRJJ5o1jPI
Message-ID: <CAC_iWjKH89ibj3KNvJW9HHXbQ4MhDLb2qWaYytU0S9Q_3xqkgw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Michal

On Thu, 2 Jul 2026 at 12:10, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 7/2/26 10:03, Ilias Apalodimas wrote:
> > On Thu, 2 Jul 2026 at 10:49, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >>
> >>
> >> On 7/2/26 09:41, Ilias Apalodimas wrote:
> >>> Hi Michal,
> >>>
> >>> On Tue, 30 Jun 2026 at 16:18, Michal Simek <michal.simek@amd.com> wrote:
> >>>>
> >>>> On systems with FWU enabled but without the required DT changes the FWU
> >>>> metadata device is not found and fwu_boottime_checks() returns an error.
> >>>> Being an initcall, that non-zero return aborts the boot flow
> >>>>
> >>>> Return 0 instead so the boot continues. The preceding log_err() still
> >>>> tells the user that the FWU device could not be found.
> >>>
> >>> Won't that affect the board later on? E.g When you do capsule updates,
> >>> updating the metadata will fail
> >>
> >> Do you mean on systems without mdata?
> >
> > Yes. if the config is enabled it will make the capsule update code
> > searching and updating metadata.
>
> fwu mdata backend is not enabled hence not used. fwu just returns 0 in dump.
> Updating metadata will never call any backend.

The prints below are just from fwu and efidebug for the ESRT table.
Those will work.
But what happens if you try to run a capsule update?
Eg. efi_capsule_update_firmware() will call
fwu_plat_get_update_index() which will fail,. no ?

Thanks
/Ilias
>
> Some logs below.
>
> Thanks,
> Michal
>
>
> ZYNQ GEM: f1a60000, mdio bus f1a60000, phyaddr 1, interface rgmii-id
> eth0: ethernet@f1a60000
> ZYNQ GEM: ed920000, mdio bus ed920000, phyaddr 0, interface 10gbase-r
> , eth1: ethernet@ed920000
> Cannot find fwu device
> Cannot persist EFI variables without system partition
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Missing RNG device for EFI_RNG_PROTOCOL
> Hit any key to stop autoboot: 0
> versal2>
> versal2> fwu
>         FWU Metadata
> crc32: 0x0
> version: 0x0
> size: 0x0
> active_index: 0x0
> previous_active_index: 0x0
>         Image Info
>
> Image Type Guid: 00000000-0000-0000-0000-000000000000
> Location Guid: 00000000-0000-0000-0000-000000000000
> Image Guid:  00000000-0000-0000-0000-000000000000
> Image Acceptance: no
> Image Guid:  00000000-0000-0000-0000-000000000000
> Image Acceptance: no
> versal2>
> versal2> efidebug capsule esrt
> ========================================
> ESRT: fw_resource_count=1
> ESRT: fw_resource_count_max=1
> ESRT: fw_resource_version=1
> [entry 0]==============================
> ESRT: fw_class=ED9E7FCF-47B3-40CD-B6E3-565F14676D82
> ESRT: fw_type=system FW
> ESRT: fw_version=0
> ESRT: lowest_supported_fw_version=0
> ESRT: capsule_flags=0
> ESRT: last_attempt_version=0
> ESRT: last_attempt_status=success
> ========================================
>
