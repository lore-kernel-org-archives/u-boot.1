Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A89C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5BD877AB;
	Sat,  2 Dec 2023 19:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U7k+Tff5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E399887795; Sat,  2 Dec 2023 19:31:57 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 785DD86E82
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so4150069a12.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541911; x=1702146711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FhHDQHBcRwQi0y7WvqurNdRpXM/ulaBxvs5WMuJWUSM=;
 b=U7k+Tff5fzGB/Q4pp04sYxblp7Vsjl/VBFRYHdM0sTIgwdvr2e4i1fpOCpoGZsgDNB
 iSGKJd3PHBO6wy5o6x017q/P0KbOSBZsCVDnWrScwOmUx3QEEAbhqwXLzw8QAA00U52m
 T4XDcHkSwWnDZ77BwL3CLBiBGnXP80fyl63go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541911; x=1702146711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FhHDQHBcRwQi0y7WvqurNdRpXM/ulaBxvs5WMuJWUSM=;
 b=RK32Bt38a9lxCdL4zKHselp9l8cJSMK6aQQnkvxv+TilAsx/mKtfY21SuLMBqR4gHD
 casLzrpJWwqCXLAKWYvGgcIQrMFrFWbANkOhlSrJFS+Me00KJK45dclnbu0nCF2OEh8U
 xHNKHz/rJv8hz1NC7kx5kfX7J39HU6ksb0+PR4TjvyGuEKLkSvnDFYnuySqGlXjNn/C+
 GXMYtwCBa408g4eGcGn6MLEaxiGWbNZk5BHxW67oMe8SX9R//0Q9m9ZRVnNIvOUqU0Dm
 YTRvUnPRH9G4YX2WY7VAMuxKwlwpMN6LgL6WugxWUVDfbKVtqr5X+kiarB6/a7hqjlA/
 +MUg==
X-Gm-Message-State: AOJu0Yy/hcO0jIkYyf6k3HvbH2FLrirjFRaiu0FkU9XQs6RAp7lHiMkI
 pmmsk/2U1ZryoqvNRkcUfwv9yXTyoW3RSOF6quBymA==
X-Google-Smtp-Source: AGHT+IHc7CnqqXTE3rnAP9u/4Tl/E3LUGs8bdVFT5k+/DWCubxx1nymFEts1+gzKDkyBPE5xysE/C3xrGa+6ED+y/as=
X-Received: by 2002:a17:906:3145:b0:a0c:46b4:a70d with SMTP id
 e5-20020a170906314500b00a0c46b4a70dmr1715106eje.28.1701541910831; Sat, 02 Dec
 2023 10:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:35 -0700
Message-ID: <CAPnjgZ12yc+e_T6R99UcNT=rYqP2uamvMVgajuRzrBYLcMSSiA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Support Firmware Handoff spec via bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Major changes:
>
> Update bloblist to align to Firmware Handoff spec v0.9
> (https://github.com/FirmwareHandoff/firmware_handoff).
>
> Implement Qemu-Arm platform custom functions to retrieve the bloblist
> (aka. Transfer List) from previous loader via boot arguments when
> CONFIG_OF_BOARD option is enabled.
>
> If a board provides both custom functions for getting the bloblist and
> the address of external FDT, the FDT inside the bloblist will be prioritized
> during FDT setup.
>
> The patch set is tested with previous done TF-A/OP-TEE patches through a
> complete Firmware Handoff cycle (BL2, BL31, BL32, BL33).
> TF-A Patches:
> feat(handoff): introduce firmware handoff library
> (https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215)
> feat(qemu): implement firmware handoff on qemu
> (https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22178)
> feat(handoff): enhance transfer list library
> (https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23776)
> feat(optee): enable transfer list in opteed
> (https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23777)
> feat(qemu): enable transfer list to BL31/32
> (https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23778)
> OP-TEE Patch:
> Firmware handoff
> (https://github.com/OP-TEE/optee_os/pull/6308)
> fixup of transfer list entry overriding
> (https://github.com/OP-TEE/optee_os/pull/6461)
>
> Raymond Mao (3):
>   bloblist: Align bloblist used_size and total_size to spec
>   qemu-arm: Get bloblist from boot arguments
>   bloblist: Load the bloblist from the previous loader
>
> Simon Glass (15):
>   bloblist: Update the tag numbering
>   bloblist: Adjust API to align in powers of 2
>   bloblist: Change the magic value
>   bloblist: Set version to 1
>   bloblist: Access record hdr_size and tag via a function
>   bloblist: Drop the flags value
>   bloblist: Drop the spare values
>   bloblist: Change the checksum algorithm
>   bloblist: Checksum the entire bloblist
>   bloblist: Handle alignment with a void entry
>   bloblist: Reduce blob-header size
>   bloblist: Reduce bloblist header size
>   bloblist: Add alignment to bloblist_new()
>   bloblist: Update documentation and header comment
>   fdt: Allow the devicetree to come from a bloblist
>
>  arch/x86/lib/tables.c                    |   3 +-
>  board/emulation/qemu-arm/Makefile        |   1 +
>  board/emulation/qemu-arm/lowlevel_init.S |  19 ++
>  board/emulation/qemu-arm/qemu-arm.c      |  54 ++++++
>  common/bloblist.c                        | 225 +++++++++++++----------
>  configs/qemu_arm64_defconfig             |   3 +
>  configs/qemu_arm_defconfig               |   3 +
>  doc/develop/bloblist.rst                 |   4 +-
>  doc/develop/devicetree/control.rst       |   8 +-
>  dts/Kconfig                              |   9 +-
>  include/bloblist.h                       | 181 ++++++++++--------
>  include/fdtdec.h                         |   3 +-
>  lib/fdtdec.c                             |  52 ++++--
>  test/bloblist.c                          |  86 ++++-----
>  14 files changed, 420 insertions(+), 231 deletions(-)
>  create mode 100644 board/emulation/qemu-arm/lowlevel_init.S
>
> --
> 2.25.1
>

Thank you for taking this on!

It is great to have a qemu test, but please do hook it into test/py so
that it runs in CI.

We should also have a sandbox test. With this series this fails:

/tmp/b/sandbox_spl/spl/u-boot-spl -d /tmp/b/sandbox_spl/u-boot.dtb -m ram.bin

A simple C test could be something that checks that the bloblist is
present, e.g. in test/bloblist.c :

static int bloblist_test_from_spl(struct unit_test_state *uts)
{
   if (!IS_ENABLED(SPL))
      return -EAGAIN;

   ut_assertnonnull(gd->bloblist);

   return 0;
}


Also you could add jwerner to this as he reviewed v1

Here is my cover letter in case it helps (at u-boot-dm/blob-working):

    Series-to: u-boot
    Series-cc: trini, Jose Marinho <jose.marinho@arm.com>
    Series-cc: Julius Werner <jwerner@chromium.org>, ilias,
    Series-cc: Dan Handley <dan.handley@arm.com >
    Cover-letter:
    bloblist: Align to firmware handoff
    In moving from v0.8 to v0.9 the Firmware Handoff specification made some
    changes, including:

       - Use a packed format for headers to reduce space
       - Add an explicit alignment field in the header
       - Renumber all the tags and reduce their size to 24 bits
       - Drop use of the blob header to specify alignment, in favour of a
         'void' blob type

    This series attempts to align to that specification, including updating
    the API and tests. It is likely that refinements will be made as other
    projects implement the spec too.

    As before the code is dual-licensed, to permit use in projects with a
    permissive license.
    END

Regards,
Simon
