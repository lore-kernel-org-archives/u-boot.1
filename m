Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C28CA0EF8
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 14:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B293480548;
	Thu, 21 Aug 2025 16:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s95eaR7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA10E80B9B; Thu, 21 Aug 2025 16:23:49 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 078FB80422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b472da8ff0eso662307a12.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 07:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755786225; x=1756391025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2FcK3ryxi1cwu4XZY7Lyk4mF1qA4Blf1BM1+XiS8xc=;
 b=s95eaR7KxP7vIHb2CZUbvYgMahI+MOmJblUxg44WkS/5xSIpc1gtR+2vsbcWs7Svx4
 Urwoi5xdUV++zISryNLdi7NJpQBwe291AT0lFOBLvoMWG/Gye3cKmfp5uW21IoYIBr3G
 tUWE/UVhn8y4mXtIKbkozIoQy9TrnSfmX8okkUP/9h/3tjwTLju+UOLrOQ2m2xpN78a6
 OctIpcxN9WqlbkgNvmaBxzZd8BFM0Y7mTvNjltvRJuNc+c2qAoVrQT1poD88zhg2MVuy
 36d72wIwGUmylDNZVD5hHXrQN7jOUb2bXDDefBaWGe0y5DkkYcxYh+549m7Up0pDbZ0S
 8HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755786225; x=1756391025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2FcK3ryxi1cwu4XZY7Lyk4mF1qA4Blf1BM1+XiS8xc=;
 b=YoVWZyOxU2mBtOGJmsod0Fn2ARwASD0emgnZBeldfdzFTR1l7Fi+ZefrrDwn/p/IIJ
 rirv+/YIuJNuXRUnd46ru7nK+19OshcnK35+x6qRy53pDlipVKI2/2rU23bPnNYSX4do
 IOroMeaJWwuB9fiYfTfsvIptiw8Rak2mI3400O876HTffxA/jmpN2x5bjwBVPtKAbBmM
 M1jR09/YSEArljBSmW5fzn+FhAHGBBNBIATIWFpRw84rxronCxx772Mp1D09kcQgWb9E
 MRGmF5f7hK6w+CnxLdYECxAwBNIUJxhmifjPzR1MvHm1zzLdjTvPJ2ji6L5dRopezaI7
 C39A==
X-Gm-Message-State: AOJu0Yyg4RMKQ83UfgEicgjpycGoKUcIsqf8KZRH3Xwz+69n2GxxG8eA
 fGlGHSkY7buylI/Hox8lg25cC2nFmuEEZmVIKfuBB5rIeslKw1iOrTotefjqwzeVj7k2tqUsf6L
 5aIRiycbb9TWa7BMI72Y9tWC/JEsjJZE1jzWR0INZQA==
X-Gm-Gg: ASbGnctjbhunfKGw2pRwIUMkTyny8HWeaWaXYe/sSHRNQYPyFV4cicomtIijcrR69Hk
 igOf9mTl88XEYlYcf8EWJyF3dF9Hwh+pQbkP8DXW2mdFK92z2kxwk60zPPD2e0Az9Ef7uimWTT3
 1lYprlcGe/cHrkrryiQSBlPbg1vGIUYWCcdKinLX3MEe9tUwL9D6sWhNfOdh0QnJqjs3fT3xE6u
 TEKM2wCMQ==
X-Google-Smtp-Source: AGHT+IG7fJqvIx59xzpWSgDbvyuZEdxKMStr0gZMbmmbg5EJzIrosQ1CxI3UXlttxJh+0YKy/cS9L0NpeqjHVKUn9BI=
X-Received: by 2002:a17:903:a90:b0:244:9c27:9829 with SMTP id
 d9443c01a7336-245febed60bmr33399815ad.10.1755786225435; Thu, 21 Aug 2025
 07:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250718141621.3147633-1-raymond.mao@linaro.org>
 <SA1PR12MB86977E312AB3965DFB8D2DD79833A@SA1PR12MB8697.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB86977E312AB3965DFB8D2DD79833A@SA1PR12MB8697.namprd12.prod.outlook.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 21 Aug 2025 10:23:33 -0400
X-Gm-Features: Ac12FXwTgsRJzARft5AMt-qBxGjj8l5WjQlA_dbmz7qAG3bsO91Lv1EGVtYwyLY
Message-ID: <CAEfUkUJZ+G=yJLwgZHFj_P2PJiXMsKar-QKxB94pRjT8rBCh6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for DT overlays handoff
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek,
 Michal" <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Venkatesh,

On Wed, 20 Aug 2025 at 01:15, Abbarapu, Venkatesh
<venkatesh.abbarapu@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi @Raymond Mao,
> I was trying to test these patches with the transfer list binary which contains tl.bin(dtb+dtbo) inside it. Facing issue with the dtbo address and fdt_check_header(*blob) from fdtdec_apply_dto_blob() gets the invalid magic num.

Currently, DTO support is not enabled in TF-A qemu - It won't append a
DTO via qemu so I am not sure if you had your own patch or platform
code to make this work.
To verify this U-Boot patch, please simply follow the 'Notes for
testing' in my cover letter, my working branch referred by my manifest
provides necessary changes for TF-A and OP-TEE to allow loading a DTO
file via qemu, place it into a TF-A reserved memory and append it as a
TE.

Regards,
Raymond

> fdt_magic=0x38 fdt_chk_version=0x1
>
> Attaching the log with details. Let me know if you need any other information.
>
> Thanks
> Venkatesh
>
> > -----Original Message-----
> > From: Raymond Mao <raymond.mao@linaro.org>
> > Sent: Friday, July 18, 2025 7:46 PM
> > To: u-boot@lists.denx.de
> > Cc: Simek, Michal <michal.simek@amd.com>; Abbarapu, Venkatesh
> > <venkatesh.abbarapu@amd.com>; Raymond Mao <raymond.mao@linaro.org>;
> > Tom Rini <trini@konsulko.com>; Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>;
> > Liviu Dudau <liviu.dudau@foss.arm.com>; Simon Glass <sjg@chromium.org>; Ilias
> > Apalodimas <ilias.apalodimas@linaro.org>; Dan Carpenter
> > <dan.carpenter@linaro.org>; Patrick Rudolph <patrick.rudolph@9elements.com>;
> > Andrew Goodbody <andrew.goodbody@linaro.org>; Harrison Mutai
> > <harrison.mutai@arm.com>; Jerome Forissier <jerome.forissier@linaro.org>;
> > Heinrich Schuchardt <xypron.glpk@gmx.de>; Evgeny Bachinin
> > <EABachinin@salutedevices.com>; Matthias Brugger <mbrugger@suse.com>; Lad
> > Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Subject: [PATCH v3 0/6] Add support for DT overlays handoff
> >
> > The series include refactoring on bloblist and fdtdec to support handoff of multiple
> > DT overlays and applying them into the DT base during setup.
> > All changes are aligned to the spec update for supporting DT overlay handoff[1].
> >
> > Notes for testing:
> >
> > Currently DT overlay is not yet enabled in TF-A, but with the test patches I provided
> > for TF-A and OP-TEE build, importing a DT overlay blob file from QEMU to TF-A
> > reserved memory is supported.
> > Follow below instructions to build and run for test:
> > $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml Replace your
> > local qemu_v8.xml with [2], which contains all necessary changes in both TF-A and
> > OP-TEE build.
> > $ repo sync
> > $ cd build
> > $ make toolchains
> > $ make ARM_FIRMWARE_HANDOFF=y all
> > Copy and rename your DT overlay blob as 'qemu_v8.dtb' into out/bin $ make
> > ARM_FIRMWARE_HANDOFF=y run-only
> >
> > [1] Add Transfer Entry for Devicetree Overlay
> > https://github.com/FirmwareHandoff/firmware_handoff/pull/74
> >
> > [2]
> > https://github.com/raymo200915/optee_manifest/blob/dt_overlay_handoff/qemu_v8.x
> > ml
> >
> > Raymond Mao (6):
> >   bloblist: add blob type for DT overlay
> >   bloblist: add helper functions
> >   bloblist: fix a potential negative size for memmove
> >   bloblist: add API for applying blobs with specified tag
> >   fdtdec: apply DT overlays from bloblist
> >   configs: Select OF_LIBFDT_OVERLAY to hand over DTO via bloblist
> >
> >  common/bloblist.c                       | 67 ++++++++++++++++++++-
> >  configs/qemu_arm64_defconfig            |  1 +
> >  configs/vexpress_fvp_bloblist_defconfig |  1 +
> >  include/bloblist.h                      | 34 ++++++++++-
> >  lib/fdtdec.c                            | 80 +++++++++++++++++++++++++
> >  5 files changed, 181 insertions(+), 2 deletions(-)
> >
> > --
> > 2.25.1
>
